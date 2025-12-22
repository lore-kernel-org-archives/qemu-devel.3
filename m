Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F326EE6748D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 09:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXcf3-0000qp-Pi; Mon, 22 Dec 2025 04:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vXcez-0000qW-8h
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 04:57:01 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vXcew-0002fO-Bt
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 04:57:01 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxEvHVFUlpT+kBAA--.6724S3;
 Mon, 22 Dec 2025 17:56:37 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxGODTFUlp2VoDAA--.10365S3;
 Mon, 22 Dec 2025 17:56:37 +0800 (CST)
Subject: Re: [PATCH 1/1] target/loongarch: Fix some exception need't update
 CSR_BADV
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251117075042.1831667-1-gaosong@loongson.cn>
 <dceb9402-e84b-f40b-20fe-58b474b526e5@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <11575e6d-a542-9f81-2e3d-909c13447796@loongson.cn>
Date: Mon, 22 Dec 2025 17:57:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dceb9402-e84b-f40b-20fe-58b474b526e5@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxGODTFUlp2VoDAA--.10365S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4xCFy8Wr1ktryUGw1kXrc_yoW5Aw1kpF
 n2k3y5Jry8K3WvqryxJw4jqryUWr4UAa17Jw1jqa48JF4Syr1vgr4vqr4qgr17Xw48J3y7
 ZF47Jry3ZFW5JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xu
 ctUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.354,
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

在 2025/11/17 下午6:29, Bibo Mao 写道:
>
>
> On 2025/11/17 下午3:50, Song Gao wrote:
>> According to Volume 1 Manual 7.4.8, certain exceptions require 
>> setting CSR_BADV,
>> but the code does not match.this patch correct it. and the exception 
>> PIL,PIS,PIF,
>> PME,PNR, PNX, PPI already update on raise_mmu_exception(),these are 
>> need't update.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/tcg/tcg_cpu.c | 24 +++++++++++++-----------
>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/loongarch/tcg/tcg_cpu.c 
>> b/target/loongarch/tcg/tcg_cpu.c
>> index 9d077c56d9..7f94c183c4 100644
>> --- a/target/loongarch/tcg/tcg_cpu.c
>> +++ b/target/loongarch/tcg/tcg_cpu.c
>> @@ -109,10 +109,22 @@ static void loongarch_cpu_do_interrupt(CPUState 
>> *cs)
>>           }
>>           QEMU_FALLTHROUGH;
>>       case EXCCODE_PIF:
>> -    case EXCCODE_ADEF:
>>           cause = cs->exception_index;
>>           update_badinstr = 0;
>>           break;
>> +    case EXCCODE_ADEF:
>> +        update_badinstr = 0;
>> +        QEMU_FALLTHROUGH;
>> +    case EXCCODE_BCE:
>> +    case EXCCODE_ADEM:
>> +        env->CSR_BADV = env->pc;
>> +        QEMU_FALLTHROUGH;
> With EXCCODE_BCE exception, CSR_BADV comes from its pc. However with 
> EXCCODE_ADEM exception, CSR_BADV should not come from its pc value.
>
how  about  update the BADV  on loongarch_cpu_do_transaction_failed()

--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -225,6 +225,7 @@ static void 
loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
  {
      CPULoongArchState *env = cpu_env(cs);

+    env->CSR_BADV = addr;
      if (access_type == MMU_INST_FETCH) {
          do_raise_exception(env, EXCCODE_ADEF, retaddr);
      } else {

Thanks.
Song Gao.
> Regards
> Bibo Mao
>> +    case EXCCODE_PNR:
>> +    case EXCCODE_PNX:
>> +    case EXCCODE_PPI:
>> +    case EXCCODE_PIL:
>> +    case EXCCODE_PIS:
>> +    case EXCCODE_PME:
>>       case EXCCODE_SYS:
>>       case EXCCODE_BRK:
>>       case EXCCODE_INE:
>> @@ -121,16 +133,6 @@ static void loongarch_cpu_do_interrupt(CPUState 
>> *cs)
>>       case EXCCODE_FPE:
>>       case EXCCODE_SXD:
>>       case EXCCODE_ASXD:
>> -        env->CSR_BADV = env->pc;
>> -        QEMU_FALLTHROUGH;
>> -    case EXCCODE_BCE:
>> -    case EXCCODE_ADEM:
>> -    case EXCCODE_PIL:
>> -    case EXCCODE_PIS:
>> -    case EXCCODE_PME:
>> -    case EXCCODE_PNR:
>> -    case EXCCODE_PNX:
>> -    case EXCCODE_PPI:
>>           cause = cs->exception_index;
>>           break;
>>       default:
>>
>


