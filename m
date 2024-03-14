Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B398C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 06:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkeWf-0008Pb-86; Thu, 14 Mar 2024 02:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rkeWQ-0008M7-D3; Thu, 14 Mar 2024 02:25:01 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rkeWL-000767-PN; Thu, 14 Mar 2024 02:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1710397483; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=gkZ2JKgHmGfwdXaPP6ejg6e6s5RdT1YrIKO+WB+VtdE=;
 b=H420l9ZUuxGEepq+66XmL5iJk0xifmYxJrPuY22yQmGILRlY+AXmYJ9ruXcOHkJuWP/U78Vj4bpKnbKSgmbYFYv6nT15pNJ1kh2LJfYCqYSWcVVaYogplNEi0SRNgZ3F5yMiz1yrnKWoUnFcF0DMSDoRDG7bWa9+pXOxT/eZBeU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0W2RPoeV_1710397479; 
Received: from 30.21.185.204(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W2RPoeV_1710397479) by smtp.aliyun-inc.com;
 Thu, 14 Mar 2024 14:24:40 +0800
Message-ID: <e5a3cb94-b45d-476a-9d83-04e47ace7c2b@linux.alibaba.com>
Date: Thu, 14 Mar 2024 14:24:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: Implement dynamic establishment of
 custom decoder
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, dbarboza@ventanamicro.com
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20240313095715.32811-1-eric.huang@linux.alibaba.com>
 <1ae334d6-f009-4e80-bf09-0500fa3486a9@linaro.org>
From: Huang Tao <eric.huang@linux.alibaba.com>
In-Reply-To: <1ae334d6-f009-4e80-bf09-0500fa3486a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi,

On 2024/3/13 18:47, Philippe Mathieu-Daudé wrote:
>
>> +{
>> +    GPtrArray *dynamic_decoders;
>> +    dynamic_decoders = g_ptr_array_sized_new(decoder_table_size);
>> +    for (size_t i = 0; i < decoder_table_size; ++i) {
>> +        if (decoder_table[i].guard_func &&
>> +            decoder_table[i].guard_func(&cpu->cfg)) {
>> +            g_ptr_array_add(dynamic_decoders,
>> + (gpointer)decoder_table[i].decode_fn);
>> +        }
>> +    }
>> +
>> +    cpu->decoders = dynamic_decoders;
>> +}
>
> Move this function to translate.c and make decoder_table[] static.
> Then we don't need the "cpu_decoder.h", it is specific to TCG and
> declarations go in "target/riscv/tcg/tcg-cpu.h".
>
This function is about finalizing the feature of cpu, it is not suitable 
to move it to translate.c from the perspective of code structure and 
readability.

I will try to move the function to tcg-cpu.c, and the declarations to 
tcg-cpu.h according to your suggestion.

>> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>> index 177418b2b9..332f0bfd4e 100644
>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -115,6 +115,7 @@ typedef struct DisasContext {
>>       bool frm_valid;
>>       /* TCG of the current insn_start */
>>       TCGOp *insn_start;
>> +    const GPtrArray *decoders;
>
> Why do we need this reference? We can use env_archcpu(env)->decoders.
>
As Richard said before:

 > We try to avoid placing env into DisasContext, so that it is much 
harder to make the mistake of referencing env fields at 
translation-time, when you really needed to generate tcg code to 
reference the fields at runtime.

It also applies to the ArchCPU case.


Thanks to your review, I will adopt the other suggestions in the next 
version.


Thanks,

Huang Tao




