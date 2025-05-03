Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA52CC369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 22:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBLDv-0005Vx-Kh; Sat, 03 May 2025 18:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBLDt-0005VX-4i
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:20:42 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBLDr-00045j-Bn
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:20:40 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22c33677183so38368265ad.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 15:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746310837; x=1746915637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U3XNTdWrjdDo0RP0WVFaZKWtTI+X6cTatFOOc4Qu1dY=;
 b=K11CsSIGUYI++UyWuEyPVyLqItkxrmdVXpU+00tL/+INh+u1O3HIxPlGU2M6/DN/S3
 I3ipR6EVwal80DLFtq1xYxwjNLNBvPrVHFGzTYFeVLgsJ9uwj8IpSdup+godMzepixgw
 WnLid0OYspcjXWiMC4Wlmie5Z4PQu2ApmPp+IDaqJLVJ3Jen2ZbOgF8DZukVLG6of5x9
 O8eUphENJeIRhsh79cFN9uSWeCXcxSizNX5DQiRvfcoGYLYQKG8pjeYnS9aobPBT3d5n
 0spSfj1ZjRFEpKP9E1Ij6gKiExlsaL2iJJtETRVk4lnbdIzgXml1zMWvf3XyBxYigBFY
 WDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746310837; x=1746915637;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U3XNTdWrjdDo0RP0WVFaZKWtTI+X6cTatFOOc4Qu1dY=;
 b=ReBpHLd8hGkaHuSOiB9uvXd0IXQok17i3NoMByJXYtVI2g9ewiPmVOuoEYf8mElgOg
 yvc0A1E+z4gsK1lmPYKWftsIXfPRksOU8B+DOCefTWP2UbrBI54qnTcz7J8p6/Y6LdlP
 AAsDhSTTn64VatrJh7ymllDc19Y2mG4UfAebs/O0gPJrOE0MM+dl0I9HKe+p0pXBfPqs
 pPOew7aOIm8NXvieVeiW5+jdZ5WrbWKt5YbnXcqvxAM2JBfsWztRJdqFYzQ6GPZEetye
 Ul8kA5sLikYCiA8/m61vUi29Xco3HUZapbFQ+xSVZOekQfRoBo3yBcCv1eAft2rpCoCy
 IceQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMVr21fTnHKc70ZVyIzCuJvT0YIkZ9vmsukpJCaDrVKYCFghsFS0VIBxLLw8chgvk38ZOoCOdc6cie@nongnu.org
X-Gm-Message-State: AOJu0YydO23mcDz/YSMTZQHekoYu2VBiuqbSsoNsdmwxEyGxD+V0WoY/
 VYVy/kM+Tr50FbRv5PxuLfmvkiUuFnI8N9VWWVvS61/7ZIFmckYBE4l+1wXU96I=
X-Gm-Gg: ASbGncsBDYKM7dDuv+i6sPgzp9DUgu2ZNZpaMOzGNf0924jFmJIdvrhee+SXw/+9gOt
 z1+BUlh60wEyqKhMYQ8xD9V3fFRgE8upG88lSSQveqca7WIsRwPi6U24aCnQlDtEbx4Qp8ArC38
 vmkmW6ztGgiLDgAGJx+BfdHhDKiUOPAmotnSOsq39XJZgseishqENjsNz4Ri74pTR2hKEb30tfB
 Knut9HWaUHH2MiI+pEWwex44BIb1QgFoOU0QgLN6CdWAvN4Nj8nI6BRD9gvWfb6jnNaFNV7eHQF
 wAVey7ZDnf7wfgjfk85ufm45nHvix3lwCN9WaAvZwkdglBZC51oaSw==
X-Google-Smtp-Source: AGHT+IG4xBk92Qmb14P3SC+6ErM2U8xgJgOkMaOYZto9rl9Jd5cV8hSFLDBqFi+G7UEQYoIMjleG3Q==
X-Received: by 2002:a17:902:da86:b0:220:e1e6:4457 with SMTP id
 d9443c01a7336-22e1ea969a0mr29683305ad.26.1746310837360; 
 Sat, 03 May 2025 15:20:37 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm3936800b3a.146.2025.05.03.15.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 15:20:36 -0700 (PDT)
Message-ID: <a5b6548e-b4c3-4e7e-a683-ebb0243154ff@linaro.org>
Date: Sat, 3 May 2025 15:20:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/33] target/arm/helper: replace target_ulong by vaddr
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-21-pierrick.bouvier@linaro.org>
 <a9d29064-e4c7-4536-b918-057951dcc1ac@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a9d29064-e4c7-4536-b918-057951dcc1ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 5/1/25 12:28 PM, Philippe Mathieu-Daudé wrote:
> On 1/5/25 08:23, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/helper.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 085c1656027..595d9334977 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -10641,7 +10641,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>>        ARMCPU *cpu = ARM_CPU(cs);
>>        CPUARMState *env = &cpu->env;
>>        unsigned int new_el = env->exception.target_el;
>> -    target_ulong addr = env->cp15.vbar_el[new_el];
>> +    vaddr addr = env->cp15.vbar_el[new_el];
> 
> Why not directly use the symbol type (uint64_t)? Anyway,
>

Nothing in particular, I was just in the mood following patch 17.
vbar_el is an address, so it makes more sense to use vaddr.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


