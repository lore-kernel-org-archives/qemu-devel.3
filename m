Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E66CA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 13:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uusdo-0003Ml-Bt; Sat, 06 Sep 2025 09:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uusde-0003LH-4Y; Sat, 06 Sep 2025 09:07:30 -0400
Received: from [115.124.28.68] (helo=out28-68.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uusdR-0003mc-KE; Sat, 06 Sep 2025 09:07:29 -0400
Received: from 192.168.71.3(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.eZ.szR._1757163747 cluster:ay29) by smtp.aliyun-inc.com;
 Sat, 06 Sep 2025 21:02:52 +0800
Message-ID: <cf7a8699-7c5a-42bd-baba-99b61d4d7443@zevorn.cn>
Date: Sat, 6 Sep 2025 21:02:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] target/riscv: Use tcg nodes for strided vector
 ld/st generation
To: Richard Henderson <richard.henderson@linaro.org>,
 paolo.savini@embecosm.com, npiggin@gmail.com, ebiggers@kernel.org,
 dbarboza@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1756975571.git.chao.liu@zevorn.cn>
 <74e3337dfebbeb29667492a1e57e87c75b55c725.1756975571.git.chao.liu@zevorn.cn>
 <0cb963d6-744b-4181-b590-08fee5516e30@linaro.org>
From: Chao Liu <chao.liu@zevorn.cn>
In-Reply-To: <0cb963d6-744b-4181-b590-08fee5516e30@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.68 (deferred)
Received-SPF: pass client-ip=115.124.28.68; envelope-from=chao.liu@zevorn.cn;
 helo=out28-68.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/4/2025 9:53 PM, Richard Henderson wrote:
> On 9/4/25 11:13, Chao Liu wrote:
>> +/*
>> + * Check whether the i bit of the mask is 0 or 1.
>> + *
>> + * static inline int vext_elem_mask(void *v0, int index)
>> + * {
>> + *     int idx = index / 64;
>> + *     int pos = index % 64;
>> + *     return (((uint64_t *)v0)[idx] >> pos) & 1;
>> + * }
>> + *
>> + * And
>> + *
>> + * if (vext_elem_mask(v0, i) != 0) {
>> + *     goto label;
>> + * }
>> + */
>> +static void gen_check_vext_elem_mask(TCGLabel *label, TCGv mask, TCGv mask_offs)
>> +{
>> +    TCGv mask_offs_64 = tcg_temp_new();
>> +    TCGv mask_offs_rem = tcg_temp_new();
>> +    TCGv mask_elem = tcg_temp_new();
>> +
>> +    tcg_gen_shri_tl(mask_offs_64, mask_offs, 3);
>> +    tcg_gen_add_tl(mask_offs_64, mask_offs_64, mask);
>> +    tcg_gen_ld_i64((TCGv_i64)mask_elem, (TCGv_ptr)mask_offs_64, 0);
> 
> Each and every time you cast a TCGv, you're doing something wrong.
> There are a lot of them in this patch.
> 
> Your host pointer arithmetic should be using TCGv_ptr and tcg_gen_*_ptr().
> This mask_elem should itself be TCGv_i64.
> 

Thanks, I will include these changes in the next version. :)

>> +    tcg_gen_andi_tl(mask_elem, mask_elem, 1);
>> +    tcg_gen_brcond_tl(TCG_COND_NE, mask_elem, tcg_constant_tl(0), label);
> 
> This should be
> 
>      tcg_gen_brcond_i64(TCG_COND_TSTNE, mask_elem, tcg_constant_i64(1), label);
> 
> 
>> +/*
>> + * Simulate the strided load/store main loop:
>> + *
>> + * for (i = env->vstart; i < env->vl; env->vstart = ++i) {
>> + *     k = 0;
>> + *     while (k < nf) {
>> + *         if (!vm && !vext_elem_mask(v0, i)) {
>> + *             vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
>> + *                               (i + k * max_elems + 1) * esz);
>> + *             k++;
>> + *             continue;
>> + *         }
>> + *         target_ulong addr = base + stride * i + (k << log2_esz);
>> + *         ldst(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
>> + *         k++;
>> + *     }
>> + * }
> 
> The form of this loop causes you to do more reads for vext_elem_mask than necessary.
> 
> Better to test once outside of the loop over K:
> 
>      for (i in vl) {
>          if (!vm && !vext_elem_mask(v0, i)) {
>              for (k in nf) {
>                  vd[i, k] = -1;
>              }
>          } else {
>              for (k in nf) {
>                  vd[i, k] = ld(addr);
>              }
>          }
>      }
> 

Good idea, I've already made some attempts, and I will apply this suggestion in the next version.

> If vl_eq_vlmax, and VL is a multiple of 64, you can structure this loop like:
> 
>      i = 0;
>      do {
>          mask = v0[i / 64];
>          do {
>              if (mask & 1) {
>                  ...
>              }
>              mask >>= 1;
>          } while (++i & 63);
>      } while (i < vl);
> 
> If VL is a smaller power of 2, you can load smaller units of mask to match. 

Reducing memory access is correct. this is a great optimization point.

> Though beware of the big-endian host addressing fixup.

Get~

> If VM, you should fuse I and K into a single loop over all elements.
> 

I have made some tests, such as:

     uint32_t total = env->vl * nf;
     for (uint32_t idx = 0; idx < total; idx++) {
         k = idx / env->vl;
         i = idx % env->vl;
         target_ulong addr = base + stride * i + (k << log2_esz);
         uint32_t elem_idx = i + k * max_elems;
         ldst_elem(env, adjust_addr(env, addr), elem_idx, vd, ra);
     }

If we implement it using TCG ops, would division and modulo operations be more efficient than adding an extra loop layer?

Or is there a better way to merge the loops for i and k into a single for loop?

Also, I will make more tests to check that the changes above are correct and work well.


Thanks,
Chao

