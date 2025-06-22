Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7313BC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTBDe-0002Hx-CR; Sat, 21 Jun 2025 23:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBDb-00029W-PP
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:18:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBDZ-0004u1-Na
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:18:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2363616a1a6so24022275ad.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750562284; x=1751167084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ydtcMB9POge/KNhtG335+9dnjU1nul2YUJpZy+6+P1g=;
 b=LA6g4t985mGXGpNVsYF4g0eNTpknclpswCwRHUzaEDtgrJwZx891nmtvWZBCfarHBc
 moZhi/AYkgmHgjAKZqVQnZA1d5cuawh05hrZfsxjNALdIGldLfTT/gAm2Du6dUqrdw9c
 jaOK9nYENNVXcUhlMKlwFVjH3hM7ahTyk2ocz3jlUet8dqVcjI62a8eEO/0UvsS7O2yn
 qOAwegTj+GuCGzXaVUrWiKCxxOt/ekQCYEaxd3JSKvaRDuB0frZ7dsqwZxLAJlKzjclc
 /GDonviWlu2u88Av1sS7cpzgirDjvBUc6ndJ2p59kNwUSDSaRdUr0hfBlXz5Hv4t4jSl
 HqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750562284; x=1751167084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ydtcMB9POge/KNhtG335+9dnjU1nul2YUJpZy+6+P1g=;
 b=dAJt0HvtALcOl2Oq7gdhlZ+G9gpZSUdBQ3/GcEUoR2Q1Hn6J7J+/SHMBXJt7v74uuz
 wJwDDQgu/KMpwqOkX+S/jYOTB6D+uU/Lq3hY3dnNFJYkRPaWm4PSTakZhsmEdkIcMhYR
 siudb29ZkL1SXBPRQvv6M57VkRVAcHVGbuv3IqHM1oEhWXkrKd71v2aHL9j7qn6j1Lz4
 krawmaC3+hBnyp8J2E7LPaWVxXOGpUjcBIs9ZLwJqcWpyk6EUXC0Y9Nw7ZRpg2V3XgrV
 ILsFGuGABambWy08YBRmPOiln0Jk/+/MPF4nRgTemMm6rMulKz/KiE95YzmSo5/SIXfN
 eDmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZovffqgE3PsgDox+1s50QbUZg3Wd1qH/DVH0whq8EEf9pn9bLH5Au+kmzGam2vVZ4NL7nHxDQAaAB@nongnu.org
X-Gm-Message-State: AOJu0YwfFab3ZSZBxf13ePbDb+FOpCXdgMdVS3ZP7WN3bdQLjF/ZLB/c
 iLZhFjUMGhlrwY9+0NzvNWgsrO2Koq+rrbaMl4OEM4hfjVdiaRkhcKQp3G5k7RxMw9A=
X-Gm-Gg: ASbGnctMh3A3hQ0o2JFcRG6Nf40Dcf+DLEr35FtNMS5gNHKFcdJrunzlqxoSo7I8m4M
 hj/XyV7i6YAxrTuFvY4saJ2QDQmQXbBNtE3pjyUkOMQseBvcg4mI6prbx6Ev6gQW2SI90gcWIsb
 H/a0q4A6R3ARHCPOFLTFsZ/iJUnRrp5YfnrEVFJODZz4McQ2JuLeIV9X5kLJanCb9Hm5iXapBmQ
 OTGcPSzSDGFybt4JGNB0/hM8upCypiFpjrqOxB9ULBYl1zlwHXhNDwbuaQ8kOb2wfl7tALPuLex
 qdu9VyI7j1/2FvoaYChc4XzdiuDN9NalPiYSPhqdFj8B0u8WY0xVpaKvUyLMB4la6OC/mSSXJ+C
 BVkDqlypy2/VxEGRGi3f4zBqMDvTzhtpQb2hqWx0=
X-Google-Smtp-Source: AGHT+IEG8UT6rJYfGzCIrbqETlWtE+f5cXFd1JqbgrrfbPK+eThBW3lITNeTb4lsPcPF/mfCc54P5g==
X-Received: by 2002:a17:903:1905:b0:234:ed31:fc98 with SMTP id
 d9443c01a7336-237d9a74516mr113215065ad.37.1750562284314; 
 Sat, 21 Jun 2025 20:18:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8640dc6sm50896445ad.146.2025.06.21.20.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:18:03 -0700 (PDT)
Message-ID: <448ec0c9-c89f-4df1-9612-8026c5bce1a0@linaro.org>
Date: Sat, 21 Jun 2025 20:18:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 33/42] accel/split: Implement
 update_guest_debug()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-34-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-34-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index eb52d690c7c..d59e70e0d9b 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -252,7 +252,16 @@ static void split_handle_interrupt(CPUState *cpu, int mask)
>   
>   static int split_update_guest_debug(CPUState *cpu)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
> +    AccelClass *ac = cpu->accel->use_hw ? ACCEL_GET_CLASS(sas->hw)
> +                                        : ACCEL_GET_CLASS(sas->sw);
> +    int ret = 0;
> +
> +    if (ac->ops->update_guest_debug) {
> +        ret = ac->ops->update_guest_debug(cpu);
> +    }
> +
> +    return ret;
>   }
>   
>   static int split_insert_breakpoint(CPUState *cpu, int type,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

