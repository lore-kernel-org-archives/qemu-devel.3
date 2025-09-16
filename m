Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4468CCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 05:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyOd7-00023n-TW; Tue, 16 Sep 2025 01:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uyOd4-00023M-QX; Tue, 16 Sep 2025 01:53:27 -0400
Received: from [115.124.28.78] (helo=out28-78.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uyOd2-0003gC-Ju; Tue, 16 Sep 2025 01:53:26 -0400
Received: from 10.13.14.160(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.eg6GaBL_1758001739 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 16 Sep 2025 13:49:00 +0800
Message-ID: <8af27769-0ebb-4e5a-9a4c-9369c6d52394@zevorn.cn>
Date: Tue, 16 Sep 2025 13:48:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] target/riscv: Use tcg nodes for strided vector
 ld/st generation
To: Richard Henderson <richard.henderson@linaro.org>,
 paolo.savini@embecosm.com, npiggin@gmail.com, ebiggers@kernel.org,
 dbarboza@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1757690407.git.chao.liu@zevorn.cn>
 <1f22506f44570abf3bb17bf144d398807be0ab40.1757690407.git.chao.liu@zevorn.cn>
 <8e43c44f-609c-4a30-8559-a5dcb567b950@linaro.org>
From: Chao Liu <chao.liu@zevorn.cn>
In-Reply-To: <8e43c44f-609c-4a30-8559-a5dcb567b950@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.78 (deferred)
Received-SPF: pass client-ip=115.124.28.78; envelope-from=chao.liu@zevorn.cn;
 helo=out28-78.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 9/15/2025 9:53 PM, Richard Henderson wrote:
> On 9/13/25 02:17, Chao Liu wrote:
>> +static void gen_check_vext_elem_mask(TCGLabel *label, TCGv_i64 mask, TCGv_i64
>> mask_offs)
>> +{
>> +    TCGv_i64 mask_offs_i64 = tcg_temp_new_i64();
>> +    TCGv_ptr mask_offs_ptr = tcg_temp_new_ptr();
>> +    TCGv_i64 mask_offs_rem = tcg_temp_new_i64();
>> +    TCGv_i64 mask_elem = tcg_temp_new_i64();
>> +
>> +    tcg_gen_shri_tl(mask_offs_i64, mask_offs, 3);
>> +    tcg_gen_add_tl(mask_offs_i64, mask_offs_i64, mask);
>> +    tcg_gen_trunc_i64_ptr(mask_offs_ptr, mask_offs_i64);
>> +    tcg_gen_ld_i64(mask_elem, mask_offs_ptr, 0);
> 
> You can remove the "mask" argument, simplifying the code here.
> 
>     tcg_gen_trunc_i64_ptr(ptr, mask_offs_i64);
>     tcg_gen_add_ptr(ptr, ptr, tcg_env);
>     tcg_gen_ld_i64(mask_elem, ptr, vreg_ofs(s, 0))
> 
Thanks, I will try modifying it this way:

    	tcg_gen_shri_tl(temp, mask_offs, 3);
    	tcg_gen_trunc_i64_ptr(ptr, temp);
    	tcg_gen_add_ptr(ptr, ptr, tcg_env);

Based on your suggestion, I have removed the `mask` args.

> You can also change mask_offs to TCGv_i32, which replaces
> 
>     tcg_gen_extu_i32_ptr(pr, mask_offs_i32);
> 
> which more obviously does not discard data from mask_offs.
> 
> 
>> +    tcg_gen_andi_tl(mask_offs_rem, mask_offs, 7);
>> +    tcg_gen_shr_tl(mask_elem, mask_elem, mask_offs_rem);
> 
> The mask of 7 suggests you're only interested in the low 8 bits.  Which means
> either the load is wrong (we don't need to be loading 64 bits), or the mask and
> shift are wrong.
> 
> 
Get, loading just one byte at a time is sufficient. I will modify it accordingly:

	tcg_gen_ld8u_i64(elem, ptr, 0);
    	tcg_gen_andi_tl(temp, mask_offs, 7);
    	tcg_gen_shr_tl(elem, elem, temp);

>> +    tcg_gen_andi_tl(mask_elem, mask_elem, 1);
>> +    tcg_gen_brcond_i64(TCG_COND_TSTNE, mask_elem, tcg_constant_i64(1), label);
> 
> The andi before the brcond is redundant with the TSTNE.
> 

Get~

> 
> r~

In addition, I also found other redundant parameters, such as the `vreg`
argument in gen_ldst_vreg(). I will remove them together in the next version of
the patch.


Thanks,
Chao

