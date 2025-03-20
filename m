Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040D8C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvCLc-00082q-Sn; Thu, 20 Mar 2025 05:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tvCLK-000818-KF
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:37:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tvCLF-000073-PW
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:37:37 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxlnDa4dtnSUmeAA--.4798S3;
 Thu, 20 Mar 2025 17:37:30 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxbsXZ4dtnnHtVAA--.53298S3;
 Thu, 20 Mar 2025 17:37:29 +0800 (CST)
Subject: Re: [PATCH 1/1] target/loongarch: fix bad shift in check_ps()
To: bibo mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, stefanha@gmail.com
References: <20250319014115.431439-1-gaosong@loongson.cn>
 <82e4b822-90b0-cbde-87ce-a971232bef75@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <527a7aeb-95b3-0ce1-2636-212fe20d03b2@loongson.cn>
Date: Thu, 20 Mar 2025 17:39:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <82e4b822-90b0-cbde-87ce-a971232bef75@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxbsXZ4dtnnHtVAA--.53298S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CryfGF4xCr17JF1xtF1DJwc_yoW8XFyrpr
 yxCryUKFyrGrZ7Ja40gayYqF9rAr1xGw18Xr4Fqa4rArs8Xr1I9rZYqr1qgF48tw4rXF4I
 qF40vw1DZFW7XacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
 Ja73UjIFyTuYvjxU7MmhUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.598,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

在 2025/3/20 下午4:49, bibo mao 写道:
>
>
> On 2025/3/19 上午9:41, Song Gao wrote:
>>   In expression 1ULL << tlb_ps, left shifting by more than 63 bits 
>> has undefined behavior.
>> The shift amount, tlb_ps, is as much as 64. check "tlb_ps >=64" to fix.
>>
>> Resolves: Coverity CID 1593475
>>
>> Fixes: d882c284a3 ("target/loongarch: check tlb_ps")
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/tcg/tlb_helper.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/loongarch/tcg/tlb_helper.c 
>> b/target/loongarch/tcg/tlb_helper.c
>> index 646dbf59de..e960adad4d 100644
>> --- a/target/loongarch/tcg/tlb_helper.c
>> +++ b/target/loongarch/tcg/tlb_helper.c
>> @@ -21,10 +21,10 @@
>>     bool check_ps(CPULoongArchState *env, int tlb_ps)
>>   {
>> -     if (tlb_ps > 64) {
>> -         return false;
>> -     }
>> -     return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);
>> +    if (tlb_ps >= 64) {
>> +        return false;
>> +    }
> Do we need check (tlb_ps < 0) || (tlb_ps >= 64)? or define parameter 
> tlb_ps as uint type.
hi, Peter and RIchard, what's your opinion?
I 'll define parameter tlb_ps as uint type on v2.

Thanks.
Song Gao
> Regards
> Bibo Mao
>> +    return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);
>>   }
>>     void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>>


