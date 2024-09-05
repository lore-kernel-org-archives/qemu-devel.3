Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EE3CD4F5B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 08:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm7py-0008HF-8C; Thu, 05 Sep 2024 04:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sm7pw-0008DX-Lz
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 04:27:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sm7pu-0003a2-2T
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 04:27:28 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxGJpia9lmWCkrAA--.46096S3;
 Thu, 05 Sep 2024 16:27:15 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front2 (Coremail) with SMTP id qciowMDx7sVga9lmyKgGAA--.19005S3;
 Thu, 05 Sep 2024 16:27:12 +0800 (CST)
Subject: Re: [PATCH 5/5] target/loongarch/tcg: Add hardware page table walker
 support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org
References: <20240729013939.1807982-1-gaosong@loongson.cn>
 <20240729013939.1807982-6-gaosong@loongson.cn>
 <87ca1589-089a-4ebb-90dd-21780897da98@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <0cc6072a-d251-5d59-73e5-9009856e06a0@loongson.cn>
Date: Thu, 5 Sep 2024 16:27:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87ca1589-089a-4ebb-90dd-21780897da98@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qciowMDx7sVga9lmyKgGAA--.19005S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr4rKrykWw18GFy8Zw4DWrX_yoWxGr1Dpr
 18Jr4UJryUJr1rJr1UJr1UJFyUZr1UJw1UJF18XF1jyr17Jr1jqr1UXr1qgr1UJr48Jw1U
 JF1UXr1UZr1UJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.993,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

在 2024/7/29 上午11:57, Richard Henderson 写道:
> On 7/29/24 11:39, Song Gao wrote:
>>       /* Mapped address */
>> -    return loongarch_map_address(env, physical, prot, address,
>> -                                 access_type, mmu_idx);
>> +    ret = loongarch_map_address(env, physical, prot, address,
>> +                                access_type, mmu_idx);
>> +#ifdef CONFIG_TCG
>> +    if (!FIELD_EX32(env->cpucfg[2], CPUCFG2, HPTW)) {
>> +        return ret;
>> +    }
>> +
>> +    if (!FIELD_EX32(env->CSR_PWCH, CSR_PWCH, HPTW_EN)) {
>> +        return ret;
>> +    }
>> +
>> +    if (do_page_walk(env, address, access_type, ret)) {
>
> When called from loongarch_cpu_get_phys_page_debug, you do not want ...
>
>> +        index = get_random_tlb_index(env, tlbehi, ps);
>> +        invalidate_tlb(env, index);
>> +        do_fill_tlb_entry(env, vppn, entrylo0, entrylo1, index, ps);
>
> ... to modify the TLB.  This will cause gdbstub to modify the 
> behaviour of the guest, which you do not want.
>
Hi,  sorry for the late reply.  I'm very busy recently.

How about adding a variable to determine if tlb needs to be modified?
like this:

@@ -248,7 +250,7 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState 
*cs, vaddr addr)
      int prot;

      if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
-                             cpu_mmu_index(cs, false)) != 0) {
+                             cpu_mmu_index(cs, false) != 0, false)) {
          return -1;
      }

[..]

@@ -233,9 +233,11 @@ int get_physical_address(CPULoongArchState *env, 
hwaddr *physical,
          return ret;
      }

-    if (do_page_walk(env, address, access_type, ret)) {
-        ret = loongarch_map_address(env, physical, prot, address,
-                                    access_type, mmu_idx);
+    if (do_page_walk(env, address, access_type, ret, physical, 
is_modify)) {
+       if (is_modify) {
+            ret = loongarch_map_address(env, physical, prot, address,
+                                        access_type, mmu_idx);
+        }
      }

  bool do_page_walk(CPULoongArchState *env, vaddr address,
-                  MMUAccessType access_type, int tlb_error)
+                  MMUAccessType access_type, int tlb_error,
+                  hwaddr *physical, bool is_modify)
  {
      CPUState *cs = env_cpu(env);
      target_ulong base, ps, tmp0, tmp1, ptindex, ptoffset, entry;
@@ -705,9 +706,21 @@ bool do_page_walk(CPULoongArchState *env, vaddr 
address,
          entrylo1 = tmp1;
          tlbehi = address & (TARGET_PAGE_MASK << 1);
          vppn = FIELD_EX64(tlbehi, CSR_TLBEHI_64, VPPN);
-        index = get_random_tlb_index(env, tlbehi, ps);
-        invalidate_tlb(env, index);
-        do_fill_tlb_entry(env, vppn, entrylo0, entrylo1, index, ps);
+
+        if (is_modify) {
+            index = get_random_tlb_index(env, tlbehi, ps);
+            invalidate_tlb(env, index);
+            do_fill_tlb_entry(env, vppn, entrylo0, entrylo1, index, ps);
+        } else {
+            uint64_t tlb_entry, tlb_ppn;
+            uint8_t n;
+            n = (address >> ps) & 0x1;
+
+            tlb_entry = n ? entrylo1 : entrylo0;
+            tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
+            tlb_ppn = tlb_ppn & ~(((0x1UL << (ps - 12)) -1));
+            *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) | (address 
& MAKE_64BIT_MASK(0, ps));
+        }
          ret = true;
          break;

>> +        entry = ldq_phys(cs->as, tmp0) & TARGET_PHYS_MASK;
>> +
>> +        if (entry == 0) {
>> +            return ret;
>> +        }
>> +
>> +        /* Check entry, and do tlb modify. */
>> +        if ((tlb_error == TLBRET_INVALID) &&
>> +            (access_type == MMU_DATA_LOAD ||
>> +             access_type == MMU_INST_FETCH )) {
>> +            if (!(FIELD_EX64(entry, TLBENTRY, PRESENT))) {
>> +                break;
>> +            }
>> +            entry = FIELD_DP64(entry, TLBENTRY, V, 1);
>> +        } else if ((tlb_error == TLBRET_INVALID) &&
>> +                   access_type == MMU_DATA_STORE) {
>> +            if (!((FIELD_EX64(entry, TLBENTRY, PRESENT) &&
>> +                  (FIELD_EX64(entry, TLBENTRY, WRITE))))){
>> +                break;
>> +            }
>> +            entry = FIELD_DP64(entry, TLBENTRY, V, 1);
>> +            entry = FIELD_DP64(entry, TLBENTRY, D, 1);
>> +        } else if (tlb_error ==  TLBRET_DIRTY) {
>> +            if (!(FIELD_EX64(entry, TLBENTRY, WRITE))) {
>> +                break;
>> +            }
>> +            entry = FIELD_DP64(entry, TLBENTRY, D, 1);
>> +            entry = FIELD_DP64(entry, TLBENTRY, V, 1);
>> +        }
>> +        stq_phys(cs->as, tmp0, entry);
>
> You certainly want to use a compare and swap here, restarting if the 
> compare fails.
>
Sorry ,  I don't understand here, could you explain it in detail?

Thanks.
Song Gao
>
> r~


