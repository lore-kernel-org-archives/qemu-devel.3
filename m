Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6B4C87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 03:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugENt-0000ms-4f; Sun, 27 Jul 2025 23:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ugEM7-0000Jo-50
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 23:16:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ugEM5-0000rz-4C
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 23:16:50 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxnnOe64Zo8CczAQ--.1574S3;
 Mon, 28 Jul 2025 11:16:46 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxH8Kc64ZozmApAA--.26243S3;
 Mon, 28 Jul 2025 11:16:46 +0800 (CST)
Subject: Re: [PATCH v3 05/17] target/loongarch: Add common function
 loongarch_check_pte()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-6-maobibo@loongson.cn>
 <98090f39-b71a-4770-b9f8-9b7545e2442a@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <6148a822-0ddb-8c66-9496-a158b814251d@loongson.cn>
Date: Mon, 28 Jul 2025 11:15:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <98090f39-b71a-4770-b9f8-9b7545e2442a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8Kc64ZozmApAA--.26243S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw1fWr1fCrWrXFy8WFW7Awc_yoW8AFyDpr
 93ArZxtrWUGr93JrnIka4Yqas8Wr18Gw17W3WfWFy8Aw45Zr1qvr18Xw1vgFyDX3y8Gw12
 qr18Jr1UuF47XFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.134,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/7/26 上午9:19, Richard Henderson wrote:
> On 7/24/25 15:37, Bibo Mao wrote:
>> Common function loongarch_check_pte() is to check tlb entry, return
>> the physical address and access priviledge. Also it can be used with
>> page table entry, which is used in page table walker.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/cpu-mmu.h        | 10 +++++
>>   target/loongarch/cpu_helper.c     | 62 ++++++++++++++++++++++++++++++
>>   target/loongarch/tcg/tlb_helper.c | 63 ++++++-------------------------
>>   3 files changed, 84 insertions(+), 51 deletions(-)
>>
>> diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
>> index 4c5cbd7425..62b3acfbc7 100644
>> --- a/target/loongarch/cpu-mmu.h
>> +++ b/target/loongarch/cpu-mmu.h
>> @@ -19,7 +19,17 @@ enum {
>>       TLBRET_PE = 7,
>>   };
>> +typedef struct mmu_context {
>> +    target_ulong  vaddr;
> 
> Use the 'vaddr' type.
will do in this way. It is simple and work on 32-bit guest vm on 64-bit 
host also.
> 
>> +    uint64_t      pte;
>> +    hwaddr        physical;
>> +    int           ps;  /* page size shift */
>> +    int           prot;
>> +} mmu_context;
> 
> QEMU coding style prefers CamelCase.
Will do, how about the name MMUContext?
> 
>> +int loongarch_check_pte(CPULoongArchState *env, mmu_context *context,
>> +                        int access_type, int mmu_idx)
> 
> Use MMUAccessType access_type.
> And fix loongarch_map_tlb_entry in a separate patch.
Will do this in a new patch.
> That's the type from loongarch_get_addr_from_tlb and above.

Regards
Bibo Mao
> 
> 
> r~


