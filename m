Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4CAF55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6iV-0006Kz-P9; Tue, 24 Feb 2026 23:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6iT-0006JH-2D
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:41:41 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6iR-00085M-I1
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:41:40 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6786b13984fso4332576eaf.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771994498; x=1772599298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a/Nom+KVULqQvD4Ii/ACL9Vg2BTAkzCkrmfpSSlipP8=;
 b=mNSkc+S+zMxBJX1yUoUeZYPwM3nFgp7VlGOtXGFOl9orVbryP1W3SgjCKLQkyCOhyv
 0Ygmz2h0ndvrNZW4qGqBdf/cahVwwEKf55vfX1BbAyDmj9OjOm+V8a16Uwfx0uVq6Cm3
 qPPNM35luQ4NX3jmL1+5BBIHAH8NJeiSJtiYpa4KbNfKICJT0RmEZG8yjufhtz4RTqjk
 brOnz5+f6ngwiWhZlffurbmqlnTxQTSeI4/PKKrLhRtu2YodVfbJZZaqyXYQ6zTGuj7C
 ps404C5r2N2fAQELXMNU16J8u46Y65Xb/EXIlVtAhecwZdKg6tTg81JblbgaGlmkSfSZ
 dZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994498; x=1772599298;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a/Nom+KVULqQvD4Ii/ACL9Vg2BTAkzCkrmfpSSlipP8=;
 b=VqrH9KqPM9tRIHT2hSEuMP7VWvAzv25byzrUZqcgXuwzt/DY8CRS2KmBF7o1pj93vf
 YOJPNeZCJ7dvxY3qmy0lj7Cks5Pa/6KyZMiwWAG1fDGd2Xw0VlwPtq7VUt7Cdk4yNEFL
 vdw0sj2S28vNpb0GmgH7SwNvD2Lw2BZZGkwBthpKPZPjMRiOSvra7dhEbFGSHJWY08W4
 slU3+OjvaRMKtKkBY8TArWMjGn6c7rUZfFg8L1k1di2iNTOzQ4qhf8nYAa7rnOh9Eo2l
 B6B+qhTLPz4cMgDk/tJq3Qg0qX2gpUXOetlM6WsK9CJMjv4Hmz8n3kAM9OK0LKRgtvKR
 60Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqjDNtnq2+ycPBy6BTE6tpuSoVuR8RBmSDl5ipezoCvCsatFVirrdrhoMx7iwLJhdCZmKIzZR/V+/A@nongnu.org
X-Gm-Message-State: AOJu0YyQpN8nppaPmFbuGPKqtkfo85a3/ohTp3SNMmbCvgsUQKrLECH0
 TNw5Ugkes9ybBF4So3xz/FW/qZQt+UvomF1/46RbjkboDZW5ZH9H7Wk8LG4HlYRfNls=
X-Gm-Gg: ATEYQzyxbOLPYiGTAW7avQ13tfkZw3KOGuPeX+kpNNR7QnBMdonBJmemZ4dX8Y9tcx1
 6Cgtv6Hqgcw0cqpsLO3wm+Za4wUypCPedaP3d+Q17myTP1nuVGaD+W0dEJlHkIXojkJDvy3s2rT
 g47v2eAmVTgBpu0UbaehMPAXAAASaQk8hAwXRnE3LF0kKn9k3yi8uYovWsPnyOwfy2PdVRPacMZ
 gPUhOlqz4cCzqIOEkHDKmWnwuLSgt7s7od19otJ92FrSG2MvK/tL1eUg6rL+CY4xXSMAMFDZ7E7
 rmjlueDFpsUz5e+ZVds/IpZ4fVrjCKlMpDztXuLbVVJbO3LAKHirO/MTXj8c3n6wmzPv2cAKL8v
 TOdnz/djgCBDkgYDZa/aQ4a4aT42R3LYA4v63G3VNcazQ6XxCQB+jC2keUJ9ujQRzIpVTsfsjvp
 H9/Qx1z7WoQmT+gyQlxMOchuuCNC3bSlOogcy2jW+HYeOR1hajUTTj7KuvOdmODAgs1j+OyLcvF
 IBpcGol46lQo6US4qr1KdHlsOGFUg==
X-Received: by 2002:a05:6820:134e:b0:672:b25f:dfd6 with SMTP id
 006d021491bc7-679c4646732mr7645371eaf.2.1771994497660; 
 Tue, 24 Feb 2026 20:41:37 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c5630a56sm10429471eaf.1.2026.02.24.20.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:41:37 -0800 (PST)
Message-ID: <0578ac95-15cc-442c-bb1c-d1a23dc488d1@linaro.org>
Date: Wed, 25 Feb 2026 15:41:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/cpu: Build a15mpcore.c once as common object
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260225034451.41338-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225034451.41338-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

On 2/25/26 14:44, Philippe Mathieu-Daudé wrote:
> a15mpcore.c doesn't need to include the target-specific 'kvm_arm.h'
> header, it only lacks the qemu_get_cpu() declaration which comes
> from 'hw/core/cpu.h'. Include the latter and build as common object.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/cpu/a15mpcore.c | 2 +-
>   hw/cpu/meson.build | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
> index 28cc4b3a4bd..28cda55ccf8 100644
> --- a/hw/cpu/a15mpcore.c
> +++ b/hw/cpu/a15mpcore.c
> @@ -22,10 +22,10 @@
>   #include "qapi/error.h"
>   #include "qemu/module.h"
>   #include "hw/cpu/a15mpcore.h"
> +#include "hw/core/cpu.h"
>   #include "hw/core/irq.h"
>   #include "hw/core/qdev-properties.h"
>   #include "system/kvm.h"
> -#include "kvm_arm.h"
>   #include "target/arm/gtimer.h"
>   
>   static void a15mp_priv_set_irq(void *opaque, int irq, int level)
> diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
> index 9d36bf8ae2c..9c1535ca325 100644
> --- a/hw/cpu/meson.build
> +++ b/hw/cpu/meson.build
> @@ -4,4 +4,4 @@ system_ss.add(when: 'CONFIG_CPU_CLUSTER', if_true: files('cluster.c'))
>   system_ss.add(when: 'CONFIG_ARM11MPCORE', if_true: files('arm11mpcore.c'))
>   system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_mpcore.c'))
>   system_ss.add(when: 'CONFIG_A9MPCORE', if_true: files('a9mpcore.c'))
> -specific_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))
> +system_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

