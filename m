Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753F2C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 01:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS4Lq-0001Rm-56; Wed, 18 Jun 2025 21:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uS4Lg-0001Qa-Fy
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 21:45:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uS4Ld-0002sf-4A
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 21:45:52 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxQK_Ba1NoWocZAQ--.23651S3;
 Thu, 19 Jun 2025 09:45:37 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxj8W4a1NoAWcgAQ--.34687S3;
 Thu, 19 Jun 2025 09:45:30 +0800 (CST)
Subject: Re: [PATCH v6] target/loongarch: fix vldi/xvldi raise wrong error
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org, philmd@linaro.org
Cc: richard.henderson@linaro.org, lorenz.hetterich@cispa.de
References: <20250605015332.537413-1-gaosong@loongson.cn>
 <6def6137-5a45-b597-4b43-4b12d8ec8872@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <d6805a81-0695-6466-1994-aaf5ce5a8eac@loongson.cn>
Date: Thu, 19 Jun 2025 09:44:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6def6137-5a45-b597-4b43-4b12d8ec8872@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8W4a1NoAWcgAQ--.34687S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWry3Zr13ZrykXr4rXr4rXrc_yoW5Gr4Dpr
 nYkrWUGrW8KF93Jr4rXw4UAFy5Jr18JanrXFn3t3WrCFWkAr1Ygr4jqrsF9F17GrW0qr1U
 XF1UZwnxZF42q3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.694,
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

It will be better if check_vldi_mode() is renamed as 
check_valid_vldi_mode().

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

On 2025/6/18 下午3:49, gaosong wrote:
> Ping ! :-)
> 在 2025/6/5 上午9:53, Song Gao 写道:
>> on qemu we got an aborted error
>> **
>> ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: 
>> code should not be reached
>> Bail out! 
>> ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: 
>> code should not be reached
>> Aborted (core dumped)
>> but on 3A600/3A5000 we got a "Illegal instruction" error.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2971
>>
>> Fixes: 29bb5d727ff ("target/loongarch: Implement vldi")
>>   Cc: qemu-stable@nongnu.org
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc 
>> b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> index dff92772ad..7e50fa7541 100644
>> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> @@ -3465,7 +3465,7 @@ TRANS(xvmsknz_b, LASX, gen_xx, gen_helper_vmsknz_b)
>>   static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>>   {
>>       int mode;
>> -    uint64_t data, t;
>> +    uint64_t data = 0, t;
>>       /*
>>        * imm bit [11:8] is mode, mode value is 0-12.
>> @@ -3570,17 +3570,26 @@ static uint64_t vldi_get_value(DisasContext 
>> *ctx, uint32_t imm)
>>           }
>>           break;
>>       default:
>> -        generate_exception(ctx, EXCCODE_INE);
>>           g_assert_not_reached();
>>       }
>>       return data;
>>   }
>> +static bool check_vldi_mode(arg_vldi *a)
>> +{
>> +   return  extract32(a->imm, 8, 4) <= 12;
>> +}
>> +
>>   static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
>>   {
>>       int sel, vece;
>>       uint64_t value;
>> +    if (!check_vldi_mode(a)) {
>> +        generate_exception(ctx, EXCCODE_INE);
>> +        return true;
>> +    }
>> +
>>       if (!check_vec(ctx, oprsz)) {
>>           return true;
>>       }


