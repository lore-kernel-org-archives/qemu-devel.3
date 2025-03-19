Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A18AC282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 02:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuj4b-0007PY-5e; Tue, 18 Mar 2025 22:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tuj4Y-0007P7-NW
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:22:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tuj4W-0006Ti-Lk
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:22:22 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxieBYKtpnCYacAA--.23875S3;
 Wed, 19 Mar 2025 10:22:16 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxbsVVKtpnP99SAA--.44143S3;
 Wed, 19 Mar 2025 10:22:15 +0800 (CST)
Subject: Re: [PULL 2/2] target/loongarch: check tlb_ps
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, maobibo@loongson.cn
References: <20250307021934.1080115-1-gaosong@loongson.cn>
 <20250307021934.1080115-3-gaosong@loongson.cn>
 <CAFEAcA_7x4Ee5gj=CP_XbR+bcZJdXJfqjJ6c6ix8OVvAmxKs3A@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <b9487a9b-67e5-cc98-9cc8-6d610e9bb1e9@loongson.cn>
Date: Wed, 19 Mar 2025 10:24:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_7x4Ee5gj=CP_XbR+bcZJdXJfqjJ6c6ix8OVvAmxKs3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxbsVVKtpnP99SAA--.44143S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWrJFyrZw4UKF43Wr1kCrX_yoW8Gw4xpr
 W3J3s0gr4qqry8Cr42q34YvF13Ars7Jw1kJrsYy34rKa4DWwn3Kr98t3ZFvaySyr4FkFy2
 kF1jyr1xZFs8ZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.526,
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

在 2025/3/19 上午12:23, Peter Maydell 写道:
> On Fri, 7 Mar 2025 at 02:42, Song Gao <gaosong@loongson.cn> wrote:
>> For LoongArch th min tlb_ps is 12(4KB), for TLB code,
>> the tlb_ps may be 0,this may case UndefinedBehavior
>> Add a check-tlb_ps fuction to check tlb_ps,
>> to make sure the tlb_ps is avalablie. we check tlb_ps
>> when get the tlb_ps from tlb->misc or CSR bits.
>> 1. cpu reset
>>     set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits a default value
>>     from CSR_PRCFG2;
>> 2. tlb instructions.
>>     some tlb instructions get  the tlb_ps from tlb->misc but the
>>     value may  has been initialized to 0. we need just check the tlb_ps
>>     skip the function and write a guest log.
>> 3. csrwr instructions.
>>     to make sure CSR_PWCL.PTBASE and CSR_STLBPS.PS bits are avalable,
>>     cheke theses bits and set a default value from CSR_PRCFG2.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>> Message-Id: <20250305063311.830674-3-gaosong@loongson.cn>
> Hi; Coverity points out what looks like an error in this commit
> (CID 1593475):
>
>> +bool check_ps(CPULoongArchState *env, int tlb_ps)
>> +{
>> +     if (tlb_ps > 64) {
>> +         return false;
>> +     }
>> +     return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);
> BIT_ULL(64) isn't valid, as it would be off the end of a
> 64-bit value. Should the check be for "tlb_ps >= 64" ?
yes, I had send a patch to fix.

thanks.
Song Gao
>> +}
> thanks
> -- PMM


