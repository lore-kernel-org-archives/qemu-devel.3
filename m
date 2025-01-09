Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03325E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW2Ck-0004RQ-E8; Thu, 09 Jan 2025 18:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW2Ci-0004Qs-Cw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:44:44 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW2Cg-0005DJ-Nc
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:44:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so11440095e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736466281; x=1737071081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HgrSRNpLpOMF/sxO+NuT5S6s4Jp5b3MaoopDHyZLPN0=;
 b=cOiefTAPhSwFyil052hqa6jg7jv+xFC7mM9RYZ606wNtHEHFkO6dofJDive4gjZKWK
 pDYunZRwaggnkFyQnfL9sqJD0p7ETShibKUi5+dMZbOhX4LlmQ09yhFw7eQBWLMn2xxm
 7r4qmlUXrIALmvFOjCAYkwzw2Orv4RLR+gq5loxOgUUJ20mQW97R39MBPhQP445YeKMO
 Q1DBaA5DuEpcNKXZ5415VHjVWeToYNRNTf54T2F490/mrfy4v0Vcf51C3exOzbd0Zu3u
 t5RXRgf+Il5tZQIesnRmd4uNA8dM2yaucQEQHb1vXiVcqVLvEM3mBNfnMahCZNPppcya
 bcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736466281; x=1737071081;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HgrSRNpLpOMF/sxO+NuT5S6s4Jp5b3MaoopDHyZLPN0=;
 b=n18SMAwXmlQDhXw3h44tIy0xE1gB83wYta4GQS1UFuoApd8tY3boZZBomZDWnXeADb
 tGwjfWFak4LvG6tBZ+LR0ER/9EQIbhM0gPeFeCEd5cb7cJ7YasG0tJlYjzRs593Dv0H8
 fImGOrh4V7i28mbqOia8f8OCysEzJcU0z46kj8JYkY/90qdwvbJkWcs2+l9nQjnhx+8j
 FmIa97CQI8eYTIZ2ybaSnsb4ywaKgQlbT3wLd6hWOD+oIeLGPxD4rshJ/IoDiJzeA/xC
 Z7+FO2PkneZwlmhHB9QcwTgXVnRw+R4Rs0OjqiJXotLR4X9acPAtlYPPW2vazEpMHGMv
 A9Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIuPGCJdzXJb9yU8rLuzZD/MF11mOELMdx5mHzyUYV3X+USQu96z/1QolkqW7KTbf8nDGPc9M2PmsH@nongnu.org
X-Gm-Message-State: AOJu0YxanXnx2S42Sqn50br9qWjRQT6ixcfTi5tBWFcas3x5Pg0jNo1G
 2Nvew44CGQcg7xkxUBZh4+Wlo5F3ENZ0rbRiEL2/s2qXJDtwqaHFOKFfr0h88Yk=
X-Gm-Gg: ASbGncuxAT4goQ6Ctg/25L4GPIns4BY08Ul241lPQm5SPnuQMucff6Xr940crV5qoj/
 erFXz+5qoDthqyvBU01gt8NzC4GPxDRjwS2NP4Z3YzUrg/4Ssw56gsM2xOU7S5AbGuK+nPBuwMT
 UKGgGF/hMbMZelOik7VfSr695FCqz0xWAO84kdsDPWjEzy5eQh8C7zSxZfjY2oV5GfnK4qz0J6D
 LXopIT7GAvtsp/RkPUY4bvOjfvhmjUrp1MIRR06jo4UR8rsk52SY+dXnIgxh/d+lE4fZ16yYxRR
 nC3fz2orlGN7i4uPn3exY1qMm8E=
X-Google-Smtp-Source: AGHT+IEce+8I4yTBKHoDLvzVk0D3gKA/Dhmf05T+5dPgGp2XRgfxXhBoNUGsJqUwsTrFn1GSkeZxPA==
X-Received: by 2002:a05:600c:1386:b0:434:f8e5:1bb with SMTP id
 5b1f17b1804b1-436e26aeb43mr83397075e9.12.1736466280645; 
 Thu, 09 Jan 2025 15:44:40 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e62116sm34296775e9.35.2025.01.09.15.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:44:39 -0800 (PST)
Message-ID: <7911f9e6-a9d5-4457-978a-d0191ce172d1@linaro.org>
Date: Fri, 10 Jan 2025 00:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 44/81] tcg/sparc64: Use SRA, SRL for {s}extract_i64
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-45-richard.henderson@linaro.org>
 <45d29837-466b-4439-a8d5-b522e1135263@linaro.org>
Content-Language: en-US
In-Reply-To: <45d29837-466b-4439-a8d5-b522e1135263@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/1/25 00:00, Philippe Mathieu-Daudé wrote:
> On 7/1/25 09:00, Richard Henderson wrote:
>> Extracts which abut bit 32 may use 32-bit shifts.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/sparc64/tcg-target-has.h |  9 +++++++--
>>   tcg/sparc64/tcg-target.c.inc | 11 +++++++++++
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
>> index d9ca14cc3d..2db461efed 100644
>> --- a/tcg/sparc64/tcg-target-has.h
>> +++ b/tcg/sparc64/tcg-target-has.h
> 
> Missing:
> 
> -- >8 --
> @@ -33,8 +33,8 @@ extern bool use_vis3_instructions;
>   #define TCG_TARGET_HAS_ctz_i32          0
>   #define TCG_TARGET_HAS_ctpop_i32        0
>   #define TCG_TARGET_HAS_deposit_i32      0
> -#define TCG_TARGET_HAS_extract_i32      0
> -#define TCG_TARGET_HAS_sextract_i32     0
> +#define TCG_TARGET_HAS_extract_i32      1
> +#define TCG_TARGET_HAS_sextract_i32     1
>   #define TCG_TARGET_HAS_extract2_i32     0
>   #define TCG_TARGET_HAS_negsetcond_i32   1
>   #define TCG_TARGET_HAS_add2_i32         1
> ---

Otherwise patch LGTM, so with that squashed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
>> @@ -68,8 +68,8 @@ extern bool use_vis3_instructions;
>>   #define TCG_TARGET_HAS_ctz_i64          0
>>   #define TCG_TARGET_HAS_ctpop_i64        0
>>   #define TCG_TARGET_HAS_deposit_i64      0
>> -#define TCG_TARGET_HAS_extract_i64      0
>> -#define TCG_TARGET_HAS_sextract_i64     0
>> +#define TCG_TARGET_HAS_extract_i64      1
>> +#define TCG_TARGET_HAS_sextract_i64     1
>>   #define TCG_TARGET_HAS_extract2_i64     0
>>   #define TCG_TARGET_HAS_negsetcond_i64   1
>>   #define TCG_TARGET_HAS_add2_i64         1
>> @@ -83,4 +83,9 @@ extern bool use_vis3_instructions;
>>   #define TCG_TARGET_HAS_tst              1
>> +#define TCG_TARGET_extract_valid(type, ofs, len) \
>> +    ((type) == TCG_TYPE_I64 && (ofs) + (len) == 32)
>> +
>> +#define TCG_TARGET_sextract_valid  TCG_TARGET_extract_valid
>> +
>>   #endif
> 


