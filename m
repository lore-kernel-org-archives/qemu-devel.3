Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC8FCA0ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 00:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulczR-00047p-LE; Mon, 11 Aug 2025 20:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulczK-00047L-59
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:35:39 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulczE-0000fr-Me
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:35:37 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76bd202ef81so6384596b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 17:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754958924; x=1755563724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MicoaPSxXcmiGnioxVX6XFJzrcig4Kvj+C0unxvkXsI=;
 b=urLfzgL+ES401SmBDLjA0d7R4CuSqPT1iIXvr9+oqSOEwD62TfdADkqvHGeSqVb2RS
 cCxkdt01NpLggo/H3kds/73XsDSB/FsD3dd77eUiBCGPL43306R1VdSyft8xo0QKd8gK
 xr3IZhn+UTPADboTEWHj3oE3T9eplGdwItrbjd/onWPIUpkP5T/cjYVlWrzhQ0o95vkL
 xo0490jN0yZ3iYOkogYZXuyQwyvP+znSz7ClO3oJnLx4c3dO4Vm1ox9xQ/PHdrxHlCER
 9DiYM7mhQAhNcJbb8gL1v1FM4qVNlPBVBQ+lCv0DchNdGVG/9ADCt+nm09+b9pyEZddX
 Ncbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754958924; x=1755563724;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MicoaPSxXcmiGnioxVX6XFJzrcig4Kvj+C0unxvkXsI=;
 b=eUGMzSNmR2Wifr8ZDAAqe12ufJTFymFMIjdcD6lJzOJFbZ1i9rNb8+Ezs7bzBFqZ2D
 FadFxsZn54UdvjlaFfRsoWEpPCivSsQcAoBT/TR4+FzKNNbY54JgAzirTkcqmH0g8h3/
 hxuSusRpkrW7aGiVY3JLP5pbxjsAJJTRU5ycrDFG58O41RFVTHlS3o1S8cgtaquAO2Kc
 Gr6YaT8MR0ig5jJ467a79ENTcooe4PAmImNAopNhJ6vvO20c1lU5cY7/2wM4ZkWgtb+M
 oaBe6LRNhbPazNNOfBvG8KSSwIypbtxC9q1OACBBcKaVCeCwQn6IJY7UA6kCek9Ri1My
 XD7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYM3/YSfIc8lPO/QT88F8JYahAudt+nYz8Ivk050ZM47yyhFl6ZckAVYAJQOEupovyHyX4mAYX6/x8@nongnu.org
X-Gm-Message-State: AOJu0YysU48ldowcQo9V6PLePsRVG+n88OdiDkof5YeXrVU6gXk81yc1
 Uaa/YfCc3W3gz2cZKz+SVf1BucmkiDQmHir+iOGUJSAjR5pIMEhvcGXpmIcrel8MMM0=
X-Gm-Gg: ASbGncsKZvFmAt0D2J/vkf339AHQE8iCTTyRh0XYrAkuihXq21DrjTA64OgOYCmqOzI
 WtGP5ypqH0Ti/WpGdXPIAxqXFS9fcpjDB6bWn0cIihryVN97uK9mjLqX0B8kLxhcV0hPhv4TVEW
 72xO4Nxk6y1t2sozch6TTVgVuRb6WxvWRCdZbQakHq6eN/muCvfmFEL0pVg9KZZQpp1xN7kA+bo
 vojRjhBh0PgcNDNDu5m7vzMvIK17i43iMQyO+sMpnIvscjLv9BQdKh1SmdySJetmt/fNeg8Xe6r
 4xc3WAljhOeDlKnJHghC3a5WSQKc2GLNH7PnXlLeuwmimE8M0I/I64wybTRzPVItpk6ko/aAyxJ
 LZ3n+0RVyIPMAWpFcOBL++MMXGOWiJGrNLW6XIo5I7Q==
X-Google-Smtp-Source: AGHT+IEyqpwPqkVhtcoPhd2aOS9bc9/xJnxu0kn4KLZgrSV9RXNQgELformVGNrBg8lsP2L0f6uQDw==
X-Received: by 2002:aa7:8891:0:b0:748:fcfa:8be2 with SMTP id
 d2e1a72fcca58-76e0de37476mr1952738b3a.2.1754958924554; 
 Mon, 11 Aug 2025 17:35:24 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfc0a2asm27948854b3a.70.2025.08.11.17.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 17:35:24 -0700 (PDT)
Message-ID: <2e5d40ac-927f-4109-b285-c0635b959066@linaro.org>
Date: Tue, 12 Aug 2025 10:35:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/11] target/arm: Introduce
 arm_hw_accel_cpu_feature_supported()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250811170611.37482-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
> Introduce arm_hw_accel_cpu_feature_supported() helper,
> an accelerator implementation to return whether a ARM
> feature is supported by host hardware. Allow optional
> fallback on emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.h     | 12 ++++++++++++
>   target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
>   target/arm/kvm.c     | 22 ++++++++++++++++++++++
>   3 files changed, 54 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index dc9b6dce4c9..5136c4caabf 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2507,6 +2507,18 @@ static inline ARMSecuritySpace arm_secure_to_space(bool secure)
>   }
>   
>   #if !defined(CONFIG_USER_ONLY)
> +
> +/**
> + * arm_hw_accel_cpu_feature_supported:
> + * @feat: Feature to test for support
> + * @can_emulate: Whether Allow to fall back to emulation if @feat is not
> + *               supported by hardware accelerator
> + *
> + * Hardware accelerator implementation of cpu_feature_supported().
> + */
> +bool arm_hw_accel_cpu_feature_supported(enum arm_features feat,
> +                                        bool can_emulate);

internals.h.

I guess this is ok.  If we ignore xen, which is a thing of its own, we don't currently 
have more than one accelerator per OS.  That hasn't always been true for x86, where we had 
2 or 3 at once for Windows.


r~

