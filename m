Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753DFC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMN4G-0004Bz-OD; Tue, 03 Jun 2025 04:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uMN4C-0004Bk-6o; Tue, 03 Jun 2025 04:32:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1uMN46-0008TP-6O; Tue, 03 Jun 2025 04:32:15 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxNHACsz5o9fgJAQ--.32227S3;
 Tue, 03 Jun 2025 16:32:02 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxPsf+sj5oIqQGAQ--.26380S3;
 Tue, 03 Jun 2025 16:32:00 +0800 (CST)
Subject: Re: [PATCH v2] target/loongarch: fix vldi/xvldi raise wrong error
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org, lorenz.hetterich@cispa.de,
 qemu-stable@nongnu.org
References: <20250603024847.350568-1-gaosong@loongson.cn>
 <be345a4b-cfb3-4e97-b09f-b21e5dcb6a43@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <c6efde46-a855-aff2-3b14-10ca65740a5c@loongson.cn>
Date: Tue, 3 Jun 2025 16:34:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <be345a4b-cfb3-4e97-b09f-b21e5dcb6a43@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxPsf+sj5oIqQGAQ--.26380S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr47Gw4fGrWkAFWxuryrXwc_yoW8Kr1kpr
 n3KrW7GryUKF93Jrs5Jw4UAFyUJr48ta1qg3Wvq3WFyFWDAr1Ygr4jqrsF9F17ur40vr15
 XF1UZr17ZFsFqwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8j-e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.054,
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

在 2025/6/3 下午3:42, Richard Henderson 写道:
> On 6/3/25 03:48, Song Gao wrote:
>> on qemu we got an aborted error
>> **
>> ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: 
>> code should not be reached
>> Bail out! 
>> ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: 
>> code should not be reached
>> Aborted (core dumped)
>> bu on 3A600/3A5000 we got a "Illegal instruction" error.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2971
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc 
>> b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> index dff92772ad..cadc00e75e 100644
>> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> @@ -3465,7 +3465,7 @@ TRANS(xvmsknz_b, LASX, gen_xx, 
>> gen_helper_vmsknz_b)
>>   static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>>   {
>>       int mode;
>> -    uint64_t data, t;
>> +    uint64_t data = 0, t;
>>         /*
>>        * imm bit [11:8] is mode, mode value is 0-12.
>> @@ -3570,8 +3570,7 @@ static uint64_t vldi_get_value(DisasContext 
>> *ctx, uint32_t imm)
>>           }
>>           break;
>>       default:
>> -        generate_exception(ctx, EXCCODE_INE);
>> -        g_assert_not_reached();
>> +        data = -1;
>>       }
>>       return data;
>>   }
>> @@ -3579,7 +3578,12 @@ static uint64_t vldi_get_value(DisasContext 
>> *ctx, uint32_t imm)
>>   static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
>>   {
>>       int sel, vece;
>> -    uint64_t value;
>> +    uint64_t value = vldi_get_value(ctx, a->imm);
>> +
>> +    if (value == -1){
>> +        generate_exception(ctx, EXCCODE_INE);
>> +        return true;
>> +    }
>
> Incorrect.  -1 is a valid return value for several modes.
>

My negligence.

thanks.
Song Gao

>
> r~


