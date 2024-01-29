Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24583C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 13:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURih-0004cY-8n; Mon, 29 Jan 2024 08:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rURiQ-0004an-7x
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:30:23 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rURiN-0006UJ-Ja
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:30:21 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40ef6da20feso5274885e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706535018; x=1707139818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gXv1lhsL8KWFPXR9Pj2Y2q5V/Kj5zTAXYDK+dOgZ0f0=;
 b=t1ony6vDLVfz8VW0+wuNl6w2oD6HypL8Q8U592bmelNMyMGIC2iKDXcVxPcRm4nBT9
 WPOShwEo464jaxUzHu3OM5wPtovWF1dkcdCj6siQDsLAhOCQgMycnwlINbFkqL2cdymX
 I6g8HuT8qstsCnEsoh0iSFGIVujiiyX9V2L2Tw7TuYWJ8/yPoZcv2nRHn62RgQsmL1rb
 XfKZrLHu+HkbCN2dkqMPTs8NI1N9X550br3Zh7rg5l5dD0xw7iXzMOeyYxix+8Tp2THW
 K+XmD60y97jaQ34ugBO1cuC5hxh7d21+8ccn4o5YI8wPibZCxDCgeFPQTkElAIseFNB5
 dmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535018; x=1707139818;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gXv1lhsL8KWFPXR9Pj2Y2q5V/Kj5zTAXYDK+dOgZ0f0=;
 b=Gj3pBkzwnYgTbEHnlUqP8kvt465CF1/dg+iQAP+5Df+Vr3ZLV39JudWKJPDbFzOOYm
 7T6uLf1G3FHbG4SH4gNEwfvZ77zEwmZspDV2Wcnr3kn/mtVDRnEzwv2sN5MUTGobCEgs
 9cs8DY80EEvCamE6tXxr3ngIQvo6gyWFmbSlzJovE9LNC6LNeBa9E3Z92L/3pbCdsIWj
 j/Oq6bcJN61tWlhb6ZQcp+3lvs6S0AJTfMnrB1AnFXCBIcz9EPGWBjaxxjTBdGhIh62M
 qyvjg7GDe+ywR9VrjY0uXMTh/+zbtcgId9XRj7A52uZkSTS0CjI0DiC9NZ0G8W73jlpf
 hU6A==
X-Gm-Message-State: AOJu0Yz5rwVV7mAcG8sYOi07sd/zxK9PPnuKPdWuk/vaPLOfQ0AACC1x
 w/UJN+l52XYWUZSMi34Ebs4YKw3Uv15xmnv8W1d4SxKa5URYzmFRngkdPahlDqg=
X-Google-Smtp-Source: AGHT+IEY1RMiAm0uaFOkafXH1ErOzzBYFw1jKXwmOT8Hhzt3fn2++zvdSz/MK8ztDDuLXTSCrfziLw==
X-Received: by 2002:a05:600c:1384:b0:40d:92c8:2cf5 with SMTP id
 u4-20020a05600c138400b0040d92c82cf5mr3951017wmf.20.1706535018118; 
 Mon, 29 Jan 2024 05:30:18 -0800 (PST)
Received: from [192.168.69.100] ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a05600c155300b0040e541ddcb1sm10247532wmg.33.2024.01.29.05.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 05:30:17 -0800 (PST)
Message-ID: <1ff4b856-352b-4eb0-944e-67ab75474be8@linaro.org>
Date: Mon, 29 Jan 2024 14:30:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: allow compiling out CONFIG_MIPS_ITU
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240129121312.1057281-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240129121312.1057281-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Paolo,

On 29/1/24 13:13, Paolo Bonzini wrote:
> itu_reconfigure() is referenced from TCG, provide a stub if needed.

s/itu_reconfigure/itc_reconfigure/

What are you trying to achieve?

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/mips/mips_itu-stub.c | 26 ++++++++++++++++++++++++++
>   hw/mips/meson.build     |  1 +
>   2 files changed, 27 insertions(+)
>   create mode 100644 hw/mips/mips_itu-stub.c
> 
> diff --git a/hw/mips/mips_itu-stub.c b/hw/mips/mips_itu-stub.c
> new file mode 100644
> index 00000000000..4cc82b8461f
> --- /dev/null
> +++ b/hw/mips/mips_itu-stub.c
> @@ -0,0 +1,26 @@
> +/*
> + * Inter-Thread Communication Unit emulation.
> + *
> + * Copyright (c) 2016 Imagination Technologies
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/misc/mips_itu.h"
> +
> +void itc_reconfigure(MIPSITUState *tag)
> +{
> +    abort();
> +}
> diff --git a/hw/mips/meson.build b/hw/mips/meson.build
> index f06d88f3430..2b1b96147a6 100644
> --- a/hw/mips/meson.build
> +++ b/hw/mips/meson.build
> @@ -4,6 +4,7 @@ mips_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true: files('fw_cfg.c'))
>   mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loongson3_virt.c'))
>   mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
>   mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
> +mips_ss.add(when: 'CONFIG_MIPS_ITU', if_false: files('mips_itu-stub.c'))
>   
>   if 'CONFIG_TCG' in config_all_accel
>   mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))


