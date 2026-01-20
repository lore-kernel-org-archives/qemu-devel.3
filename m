Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05274D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9fe-0001yy-Kf; Tue, 20 Jan 2026 06:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9fJ-0001vk-N2
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:12:56 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9fG-0004Zl-D9
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:12:53 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so45417935e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 03:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768907568; x=1769512368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xq+7LtLjTmmyLgLFhCSTwgZ2FZqdBKw4qYSaPKbXI+0=;
 b=buMGc3a5LsUjqjSTRMo6gamPprxA1vC4EAcD0yxEKWfsKMeGJ9JgZQI58eR60o2Fit
 uuBmdDM+U7Xsy1+nbLlHg+4U2/QKA61kW9J3oqoZgKQQCRk60akqusDttY8PjXMPcBdD
 gzpjkeeRaXbMoWWA80zVktncOmaMzDpmbZAG55V2W3F5VmsS136P+VFPeobDF03bmYY3
 8pVUjI/ef2qGSEaJvLMNJwNSn+3wRjXikMF854WGFHfzp942U3bXEouIUjdAuFy/6LDh
 mP9ul2Y9OQaSmnViUAzhvrR22c1OHgGPb4efVaxFNkpdcwtkP9ZHs4zq9J+qa9QOX4jC
 Q/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768907568; x=1769512368;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xq+7LtLjTmmyLgLFhCSTwgZ2FZqdBKw4qYSaPKbXI+0=;
 b=Ljg92SzRTVwPAhHNmhleshMjaYTBHJTFCS9G06JArqgXba0fvfL3GLWoPblE40yoY0
 X6LAEWMkTkWLF6siEodIppWMfXMbmr1yqMvuUnEBhjgTFIZW4ypkRnHeiBdVM1Jjm1d9
 ku2iYIxmEcqprRuNqjonkycsfZ8LbhaTjDPXCSGJJ1hxrkXGE63mt+vA9N4BXUAouuOy
 kNpsHEwsRdagiCwW86vmogEiAtdwnFSx9+D6oO13KzJW/mE6fAYf1ATNlKmvYQCUQ/Qb
 H8qbFk+4Xav0diupI9QQRdGnxj5r8gsmdr6gdINVPDnFsozAxIfk9+vlkxunLjZcMT36
 Bd4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMBM3ytfAlplV8uFS7qiIp4IZvas9biNf7Wd7zoXjOZzHmb5n4e6h2zxsXDwHRFF5DEq3ej+3Ptdle@nongnu.org
X-Gm-Message-State: AOJu0YxHSxJGKKntdm8NlnfQIUC1A1FioEKIzmAXMgnFcsx38P1+fffD
 hadAnztW8dj3EOJUWFTSRfxfm/RU1cllYGmN4S+KxP/a0Y2GVuoOSugF1RyPcnaiHlo=
X-Gm-Gg: AY/fxX6Z6kKREz8clCE+J1l5dD6hnd9jp+ABrBqkAe5X86pVBDREFXTWUkGeZkXGm8M
 Z5XkFiIhRzj/NyMsoSzHurcgtlNxTKdLrKIm7Ngw5i5BHxvdvI8FnF3ArnlJQe/aJBmMAAPOR/J
 iHCv5e41aVEkwRhFyB5UL0eAw/1NphZOyZIokV3Lw15JJn006QzzraHOrbh68x7DPvuQyZBzZSY
 0ZhUzVx1hff/IDzpeGEFQu0pXq3r6E7c6fNqrPPBwVm5LIGlA4D8x0Es/BP32tgRNg7slzF+xch
 SDBO+ciAhWQNoBLheniS+lWezl1LFxqjHgTrNqPym0McciJ/xCnC5yLwRImKlck9KHjycS6n0JP
 TtHZJymmyrLGM3pRPAK0TC1eo2P++xC9dLdPvJCJmwZO+9TUu6SW7fTw8RdXU6AAmhGVknvnFZP
 JD4oZau7TM29+qjFAk2R/e+XQtL9hV0w51RGYpqNg2Gsw7JpLFHa4P0w==
X-Received: by 2002:a05:600c:1d14:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-4803e7a39damr20440815e9.13.1768907568247; 
 Tue, 20 Jan 2026 03:12:48 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2672d6sm304061045e9.14.2026.01.20.03.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 03:12:47 -0800 (PST)
Message-ID: <8d532719-7bf7-4a35-9d64-85efe6440e41@linaro.org>
Date: Tue, 20 Jan 2026 12:12:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 24/26] whpx: arm64: check for physical address width
 after WHPX availability
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-25-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116135235.38092-25-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 16/1/26 14:52, Mohamed Mediouni wrote:
> In the case where WHPX isn't supported on the platform, makes the
> intended error appear instead of failing at getting the IPA width.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/whpx/whpx-all.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 3329deeb57..79e9065d3a 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -654,7 +654,7 @@ uint32_t whpx_arm_get_ipa_bit_size(void)
>           WHvCapabilityCodePhysicalAddressWidth, &whpx_cap,
>           sizeof(whpx_cap), &whpx_cap_size);
>       if (FAILED(hr)) {
> -        error_report("WHPX: failed to get supported"
> +        error_report("WHPX: failed to get supported "
>                "physical address width, hr=%08lx", hr);
>       }
>   
> @@ -874,15 +874,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
>           goto error;
>       }
>   
> -    if (mc->get_physical_address_range) {
> -        pa_range = mc->get_physical_address_range(ms,
> -            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
> -        if (pa_range < 0) {
> -            ret = -EINVAL;
> -            goto error;
> -        }
> -    }
> -
>       whpx->mem_quota = ms->ram_size;
>   
>       hr = whp_dispatch.WHvGetCapability(
> @@ -910,6 +901,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
>           goto error;
>       }
>   
> +    if (mc->get_physical_address_range) {
> +        pa_range = mc->get_physical_address_range(ms,
> +            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
> +        if (pa_range < 0) {
> +            return -EINVAL;
> +        }
> +    }
> +
>       hr = whp_dispatch.WHvCreatePartition(&whpx->partition);
>       if (FAILED(hr)) {
>           error_report("WHPX: Failed to create partition, hr=%08lx", hr);

Squash with patch 18/26 "whpx: arm64: clamp down IPA size"?

