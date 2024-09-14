Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AAAFC618D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 03:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spJJj-0008Ma-1l; Fri, 13 Sep 2024 23:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1spJJg-0008M6-AU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 23:19:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1spJJd-0002Tr-Us
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 23:19:20 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxjequAOVm16QHAA--.18214S3;
 Sat, 14 Sep 2024 11:19:11 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxL9atAOVmyngGAA--.29794S3;
 Sat, 14 Sep 2024 11:19:09 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Avoid shifting with bool type variable
To: Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240914014342.2095136-1-maobibo@loongson.cn>
 <05f04c1c-e61a-4bce-b5eb-50a516255a3c@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <51d87ce2-cdc1-aad0-8d95-0ee76d16231c@loongson.cn>
Date: Sat, 14 Sep 2024 11:19:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <05f04c1c-e61a-4bce-b5eb-50a516255a3c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxL9atAOVmyngGAA--.29794S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrWkZw1xCF4xury8uFWfZwc_yoW8AF4kpr
 W09a4qkFW7W3Z7Kw4kX3ZrXryUXr1UWw17Z3WrtFy8Cr45Jr9FqFW8X3sagrnxAa1xtF1r
 Xr15uFs8ua4UAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
 14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
 CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
 MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU1MKZJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.566,
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



On 2024/9/14 上午10:58, Richard Henderson wrote:
> On 9/13/24 18:43, Bibo Mao wrote:
>> Variable env->cf[i] is defined as bool type, it cannot be used with left
>> shifting operation. 
> 
> Not true; it promotes to 'int'.  But that isn't wide enough for the 
> value that you're trying to construct.
yeap, you are right. Variable with 'bool' type can be used with left 
shifting and treated as 'int' type.

I will refresh patch in the next version.

Regards
Bibo Mao
> 
> There is existing api read_fcc(), it can be used when
>> dumping fp registers into coredump note segment.
>>
>> Resolves: Coverity CID 1561133
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~
> 
>> ---
>>   target/loongarch/arch_dump.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
>> index 4986db970e..d9e1120333 100644
>> --- a/target/loongarch/arch_dump.c
>> +++ b/target/loongarch/arch_dump.c
>> @@ -97,11 +97,7 @@ static int 
>> loongarch_write_elf64_fprpreg(WriteCoreDumpFunction f,
>>       loongarch_note_init(&note, s, "CORE", 5, NT_PRFPREG, 
>> sizeof(note.fpu));
>>       note.fpu.fcsr = cpu_to_dump64(s, env->fcsr0);
>> -
>> -    for (i = 0; i < 8; i++) {
>> -        note.fpu.fcc |= env->cf[i] << (8 * i);
>> -    }
>> -    note.fpu.fcc = cpu_to_dump64(s, note.fpu.fcc);
>> +    note.fpu.fcc = cpu_to_dump64(s, read_fcc(env));
>>       for (i = 0; i < 32; ++i) {
>>           note.fpu.fpr[i] = cpu_to_dump64(s, env->fpr[i].vreg.UD[0]);
>>
>> base-commit: 28ae3179fc52d2e4d870b635c4a412aab99759e7
> 


