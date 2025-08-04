Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6AFC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqbd-0001de-5Y; Mon, 04 Aug 2025 04:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uiqbO-0001XQ-Pc
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:31:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uiqbH-0008GC-6G
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:31:26 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxPOLGb5BoWjo4AQ--.4606S3;
 Mon, 04 Aug 2025 16:31:02 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxvsHEb5BoOUg1AA--.24009S3;
 Mon, 04 Aug 2025 16:31:02 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Fix [X]VLDI raising exception
 incorrectly
To: WANG Rui <wangrui@loongson.cn>, bibo mao <maobibo@loongson.cn>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu@hev.cc, Zhou Qiankang <wszqkzqk@qq.com>
References: <20250804023206.1306413-1-wangrui@loongson.cn>
 <CAHirt9hZ20=UD+e2S0+hHAG+0+qojpu2=3974JTQAzSOf0iEAg@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <bb6069f8-66f7-3a0e-a887-cdb1c83f5377@loongson.cn>
Date: Mon, 4 Aug 2025 16:34:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHirt9hZ20=UD+e2S0+hHAG+0+qojpu2=3974JTQAzSOf0iEAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxvsHEb5BoOUg1AA--.24009S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar4kJFWDGF1ktrW8CF4xZrc_yoW8CFyfpw
 1akF4jkF48JFWfZrZIvws8tr13K3yrtw4xWFn3t3WfArZ3t34ktr48KFZF9Fy7CFWUur10
 vF4Fywnxua1FvacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.561,
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

在 2025/8/4 上午11:17, WANG Rui 写道:
> Hi folks,
>
> On Mon, Aug 4, 2025 at 10:31 AM WANG Rui <wangrui@loongson.cn> wrote:
>> According to the specification, [X]VLDI should trigger an invalid instruction
>> exception only when Bit[12] is 1 and Bit[11:8] > 12. This patch fixes an issue
>> where an exception was incorrectly raised even when Bit[12] was 0.
>>
>> Test case:
>>
>> ```
>>      .global main
>> main:
>>      vldi    $vr0, 3328
>>      ret
>> ```
>>
>> Reported-by: Zhou Qiankang <wszqkzqk@qq.com>
>> Signed-off-by: WANG Rui <wangrui@loongson.cn>
>> ---
>>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> index 78730029cb..ee10a9ebe1 100644
>> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> @@ -3585,11 +3585,6 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
>>       int sel, vece;
>>       uint64_t value;
>>
>> -    if (!check_valid_vldi_mode(a)) {
>> -        generate_exception(ctx, EXCCODE_INE);
>> -        return true;
>> -    }
> Should the INE exception be prioritized over the [A]SXD exception in this case?
yes, I think we should. this is like ARM.
As Richiard said 'For Arm, at least, decode errors take precedence over 
disabled functional units.'

Thanks.
Song Gao
> - Rui
>
>> -
>>       if (!check_vec(ctx, oprsz)) {
>>           return true;
>>       }
>> @@ -3597,6 +3592,11 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
>>       sel = (a->imm >> 12) & 0x1;
>>
>>       if (sel) {
>> +        if (!check_valid_vldi_mode(a)) {
>> +            generate_exception(ctx, EXCCODE_INE);
>> +            return true;
>> +        }
>> +
>>           value = vldi_get_value(ctx, a->imm);
>>           vece = MO_64;
>>       } else {
>> --
>> 2.50.1
>>


