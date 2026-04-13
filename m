Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E38F531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQ3t-0000V5-1k; Mon, 13 Apr 2026 18:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQ3r-0000UN-Bh
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:47:19 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQ3p-0000Px-Hg
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:47:19 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so1543538f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776120436; x=1776725236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sjC1RsL/Zll71P7UXXVXOBHYaX+fp6Q/ApjrM44CoJU=;
 b=mQUUrP0fWvd9g+hCcA6XME8czj704O2XTzvrt0IrCqRQoM18qztaubZppkiUFMmAg2
 x+UbHDC3Ke2tJKpa6TaGv3oELEmYZyFXBJXM97E4rcukB4L45clo1IvarexWqRcqha9M
 Zyu3dOsSy2LQDkne/bEoEwa2udpWhI3Pzk5BMpnjAfx1ObfE2CTpvPfLOEcb8iX+O/8G
 yCpZMqTgAtZ5/+BZO8wy1zsNYlDDJD8HlBj2sLXI+qvuTyPQTE/DYfisNI34v+YGQ8E+
 VycjavGjO5q8d72XSCbGk02f2LM1rF1Et5cR2O6y5z29FfAXWCOUFBvbGh3Pnpl7RJvu
 jY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776120436; x=1776725236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sjC1RsL/Zll71P7UXXVXOBHYaX+fp6Q/ApjrM44CoJU=;
 b=Ke6EE/mdhcRTH/tqcQ8IsSvMdQTakrrcYSrx2HObeQy/eeOnlJd/ts/dNriDzprvD8
 vAQRmc5SFzc21zQUB3ru9Dlq1BbKX4zq4SYecOW1ltK0LSy5wR2/reVpInQTZOlTWQnh
 F6Zzb9C0IJ/R023Y9X5BImii2T4Ck3w5Nc7uMrvWlGQSezdreySQzqzXjP9vcfmgLIiP
 8LFGqvi3DCnPCr75LE05flP4VP5Fj1ZlaEGQMDTHMxyuNY5CBBjHn56XkXsQ7hUYeT6c
 FhOYepmZWxaKGbg4xMVoKiIRupYlOnyZBrzxTsqSo6nsR6lvhmtJTXQF5UhJA0x25Otj
 4qzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8af047+uWFCoPSMPqwiu1zxqLM+TGazpLfrx3AHu265bkKgr/G54GdORqyweuU10YZmfsi6OLRihtt@nongnu.org
X-Gm-Message-State: AOJu0YySNXWerpOBbDrViNsiBCcCGFhINeqmudTKYjhRpJf1QvJDmYOg
 JNl88eBH7nCMD0euv7tuoff6fjqztrudHuIR9fwnUsVUF7I7/S+oK/AbQ7d2/ReagEE=
X-Gm-Gg: AeBDiesDCF5Y4Qlvsd58PjH6bnfkT+YL8C9j17t0HsLxZxAycGbHRB0OkhP9VuAzyjG
 urUdvddM/UEHK9FGg95+7dOjiRKOcojSLe/HIC8NBidO+0kPLsHcXvf+66kp/iAx7dH6nZtqdG0
 4h7JZhmecDUttn7pREcGxZurLmAPLIsjFlMxjKhc8BRdl/R/tadKY1tasDeFmN9tRczdeZwXsSh
 gfmk0/6Yq5hR+B53t1/mC7tj0cUbRahRn26QhIC5PvpzRW+O51zQ5wpF7AbS8jBhahCXIPdJODa
 W5EW93k/tzv3jD2XIdgVkcgRlzfL3HAi9NS2M4N5ZHYwU3g+uUKkUulV8nzbHUiHfMIErcRrzr9
 /JYWka94WB2PjbfmNQLF9NdrnQtVgrZSaCFkePN9Wr6rMTcA7+ih9OtUfHTIWDB+m4lWhJhcRqk
 SHY3lYeoZE9xCjTlgkuE17C3ceWATOF3muVzw139glBDJog+OW1qzWuH1gT3fwuL2BIg==
X-Received: by 2002:a05:6000:2001:b0:43d:773d:78ff with SMTP id
 ffacd0b85a97d-43d773d7b1fmr10307681f8f.27.1776120435612; 
 Mon, 13 Apr 2026 15:47:15 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7bd2f237sm8598760f8f.23.2026.04.13.15.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:47:14 -0700 (PDT)
Message-ID: <f1af446c-4ee1-4ba9-a045-e34a6d024289@linaro.org>
Date: Tue, 14 Apr 2026 00:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/ppc: Explicitly declare BHRB related register
 as 64-bit
Content-Language: en-US
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Glenn Miles <milesg@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260315170832.40331-1-philmd@linaro.org>
 <20260315170832.40331-4-philmd@linaro.org>
 <5fe614f5-6ff4-4418-84ae-6d6b8952bb0a@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5fe614f5-6ff4-4418-84ae-6d6b8952bb0a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/3/26 11:35, Chinmay Rath wrote:
> 
> On 3/15/26 22:38, Philippe Mathieu-Daudé wrote:
>> When TARGET_PPC64 is set, the 'target_ulong' type expand to
>> the 'uint64_t' one. Use the latter which is more explicity,
>> similarly with the TCG and migration APIs. No logical change
>> intended.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/ppc/cpu.h       | 10 +++++-----
>>   target/ppc/machine.c   |  2 +-
>>   target/ppc/translate.c | 33 +++++++++++++++++----------------
>>   3 files changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index f4438982928..2332c509524 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -1373,11 +1373,11 @@ struct CPUArchState {
>>   #ifdef TARGET_PPC64
>>       /* Branch History Rolling Buffer (BHRB) resources */
>> -    target_ulong bhrb_num_entries;
>> -    intptr_t     bhrb_base;
>> -    target_ulong bhrb_filter;
>> -    target_ulong bhrb_offset;
>> -    target_ulong bhrb_offset_mask;
>> +    uint64_t bhrb_num_entries;
>> +    intptr_t bhrb_base;
>> +    uint64_t bhrb_filter;
>> +    uint64_t bhrb_offset;
>> +    uint64_t bhrb_offset_mask;
>>       uint64_t bhrb[BHRB_MAX_NUM_ENTRIES];
>>   #endif
>> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
>> index b44c3ccf0ae..65594f5e1a6 100644
>> --- a/target/ppc/machine.c
>> +++ b/target/ppc/machine.c
>> @@ -723,7 +723,7 @@ static const VMStateDescription vmstate_bhrb = {
>>       .minimum_version_id = 1,
>>       .needed = bhrb_needed,
>>       .fields = (VMStateField[]) {
>> -        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
>> +        VMSTATE_UINT64(env.bhrb_offset, PowerPCCPU),
>>           VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, 
>> BHRB_MAX_NUM_ENTRIES),
>>           VMSTATE_END_OF_LIST()
>>       }
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index ecf75c1376e..996e6551436 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -3502,7 +3502,8 @@ static void gen_rvwinkle(DisasContext *ctx)
>>   #endif /* defined(CONFIG_USER_ONLY) */
>>   }
>> -static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv 
>> mask, TCGv value)
>> +static TCGv gen_write_bhrb(TCGv_ptr base, TCGv_i64 offset,
>> +                           TCGv_i64 mask, TCGv_i64 value
> Hey was it intentional to leave out 'inline' here ?

Yes, but I neglected to mention it in the description. I will,
thanks.

> 
> Regards,
> Chinmay


