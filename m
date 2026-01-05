Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BFDC2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYs1-0003Mm-Pf; Sun, 04 Jan 2026 19:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYrz-0003MN-NS
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:54:51 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYry-0002AZ-B0
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:54:51 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7aae5f2633dso14074107b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767574488; x=1768179288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JzNv4PaUjR8dyzlt2jp8cJo3LFPcbrV5+ihxMrzIiQA=;
 b=rCgcKXooBjN9mhfYr1AnOAd6M5IGn7ONQMw54jEuPD/vGqVlXYx5urJBKmgMauLOKx
 I+0+7FRtfjH15DOqM/PLg8ZqC+OUHP1BdnitSygT3JOL+TFulh8E6LEKBxsNvw2rrRXr
 PVG7N24eLRqM2lnOhltraHPqONPgA5V4817d6WjgMmf5Dryw5scw8VOU+miFUO+xuFlr
 LkVem9AP8ROErSYEUGmPwMM6n+iDglcSvHYg1rhQ644WupmKhX5qrS9N+llj2/jUVIu+
 /sfTiIfRrHLcSbcFgSh+XIimddPP7r7fVZGOxYE598yi5DMILLlTnsc/52d3rTkyMTGi
 hdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767574488; x=1768179288;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JzNv4PaUjR8dyzlt2jp8cJo3LFPcbrV5+ihxMrzIiQA=;
 b=v2hFTkqHnQevPW+JZqGkVm4Cwj6GE/IEa6vPeq6lCH/9npKv+r7F8EBykaVB9OPvRd
 fJfF1MMsdV/axu4RWWlpgqu8Sedl634XGGqTiIN/1l7KwG7IzFEgLUOkY6QK05s3YWJe
 wcnusNe2lIUaKEqih7Z0LsLldKIaP5HuQt95lQAVYKd77iWCimCcPlJPQSyQi7RlyaqD
 rkcaWCM6ybST3EIl520sopVbInyn4JiqEJr6mL1ZFwn+w38JZc8thw2DEF26silMSRda
 Wz27N1NKc3J4b3iMdf7M1NVIZ1XohELC14qgmajlqvjAi7mh7nZuidBQ0K2OuFn2db9i
 1ojA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX78W26tnqdLQEjdsQ6e0gJJRrvdwc6tnmclY39rYqEJM4007OXUHIT3BEEXBN5NRy9x2ReswOukjqN@nongnu.org
X-Gm-Message-State: AOJu0YxrawX4tWSdhq0u0IWuqezxOac0rkI1ugBaJTPUy+i5CCxMiihb
 hEM9mY29YaDXAcvWKpPgmfsN7LfzRc0PskYmk8SU3+1iXpYpMvUAwGOUZLLMbcoLY5Q=
X-Gm-Gg: AY/fxX5uEK2kr1v9EFfyD5+z4FufdJ+cHWI+zXXovB1S1c1chUtt6nqBoTXM3X/9TJd
 lNp4/LocS0Ybgd0rF1MMnUd8elnE4O3sbO8lEpx6j/EsNN71PuYMPhSikWMaNUo1NQ1Kx6RZ/sl
 G1XM9lthTJIedsh6OI/cHccN1stcul6l4m1aUNr4kDnsLo3JdPWY+S8n6fz06Efp2G7sjsv0orA
 saK9/aRY3zH3ZCRXvI5K3UFHHxjmSEvfiEV1ZPPd9gJBWQP6t2aPZs4nJuN3guzUmQx14PD4zfA
 jG4bhhJ0ynPW6jfaqN52wEGJjMo7LApKGLoZX9Qhc5mx+XPj6Ob0o1z1FH6vgC4IlI+BWcJH4ha
 pZ3ywnkBKMkr/ipytfS6qlLzf4WHEjatbEkKptm0QNOh7CBmC65PXm9kZaJhVDiMvjc2S8RpZws
 qqgT805DrS2yfYYDxhahPH+rm0uYJ2uw==
X-Google-Smtp-Source: AGHT+IEmt4Ua3MMtkw+HZvExQDkIJCfQU9bG8GqhJ3gKtyG/OuR5bWoNpxr/+jjLcncM5P26cjpRIw==
X-Received: by 2002:a05:6a20:918d:b0:35d:d477:a801 with SMTP id
 adf61e73a8af0-376a7eed254mr42810894637.13.1767574487801; 
 Sun, 04 Jan 2026 16:54:47 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e79a17fb2sm39865465a12.12.2026.01.04.16.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:54:47 -0800 (PST)
Message-ID: <bc17579d-f198-426e-b14d-008504ffd7e1@linaro.org>
Date: Mon, 5 Jan 2026 11:54:41 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/tricore: Inline translator_lduw()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251224163005.91137-1-philmd@linaro.org>
 <20251224163005.91137-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224163005.91137-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 12/25/25 03:30, Philippe Mathieu-Daudé wrote:
> translator_lduw() is defined in "exec/translator.h" as:
> 
>   192 static inline uint16_t
>   193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   194 {
>   195     return translator_lduw_end(env, db, pc, MO_TE);
>   196 }
> 
> Directly use the inlined form, expanding MO_TE -> MO_LE
> since we only build the TriCore target as little-endian.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/translate.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

