Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B042EC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 22:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlExI-0004bn-CR; Thu, 20 Feb 2025 17:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlExF-0004bI-T9
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:23:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlExC-0004ZN-4V
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:23:37 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4398ec2abc2so12795495e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 14:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740090211; x=1740695011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xfmW+7Rd75vtwonljeaStfGCcd+krv7ye+cqnLwDETI=;
 b=ZsbvutSvqLWsx6tCXPgQje2uwt2z5fGSm2F8o8mKepevCz9Tf0xnOa21u+ick3YvA+
 5KALAqvlZSwjxTwQJ2FKQafGANcRU9wNuJVt3Z5Q6M+dMlS3AhC0MxBlzrODwepCYqnp
 x1y2iIMFdzZunstienEss7CyeNaxbRbEo+aFwvJ6BXsWrABNsAEeB9t+HGBFikS4i25t
 nrvtClPZQ12v7uFiN2FwDR5nHB5x2lOcFE2J4o/LpbmGwfDj02fHKiSysOIV9BmwS5A+
 BTsMcfmPD5T1hdn20sKjpVahAkNHAEvTxO1gBsK0324M1v3hCJkS6ZCxvLY0O+Ctxc/t
 q5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740090211; x=1740695011;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xfmW+7Rd75vtwonljeaStfGCcd+krv7ye+cqnLwDETI=;
 b=ej0M7M8Q+iinC6oqNq5OmwZLknFdT3BZJNieXcFHz4wE88x3vB31SFTG24ll/MrPgI
 YuPNvxWSwMf2YAoBSK0VuEko8aQ/FHjRmgIpaCv5l/CzfcNyb+zUGagb/1ncx6Q04LPh
 4zNQd50Idb7S/C5fyVt90n5BAAiV8zcJGpKXmwLXDmvUrkoVjEICPF/giuYfsadJh8Mu
 EMZfutF+Ondsrvpwu9uE/CMUwVLH8r8C6B6B9O51O0lUvKvJUNDMeL84Ah1Z0Ijp1Mzq
 tOrnBpF2mjU7zyYA4ZBQ6ATso3SDNSMP0Sx5XLGDO4LXVEgXpgOj5d/MBVV2d1a7qILf
 heXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3CQQh1J0qxXUxIlZwS2ybC7WtRT2hdx3ca2rEcha1IDkL+0DQhLX8XhAfXI5FZi7agADRpwxBVs72@nongnu.org
X-Gm-Message-State: AOJu0Yy/7lCMuYc7ilaCh4ttowwy7c6R5DWuXR9XPJjmemajgiR6EMgk
 0ocj+MkBz0KKWQaQ2I7+IswMlfeJoJQr1NrjAjx/Tsy5EIwlExMKKgN6iRjVjtU=
X-Gm-Gg: ASbGncuhRIGiNPjk0qrAJay3MPYka1NBo+HzFDI4LuQ2r8iy7sLfRJnaBOS7MLMaFie
 CqSDqQsOU0/8CZhwzwH5MyZoeUMA6BQYgE2atFbKMdPEcVxIZ3i7d4+4BSzSxy90qXEgdfExua4
 SAxUMXXOO8fxXjLVxCr/RmOmNHq9+/XqNRGfX/qXqocI5YS8nuGBk6YaxPzpuWtDboOEEvpDdN4
 l14+ano8hcfpQDCt4uwqCx1ijZ2AHcfx/h0nP1X+yGvyr3260b5aBS2GlFAljxUOXgSBAUp/quo
 2gPo+UstDI3KS8foMmUhYw+VyDhHKvXajAngP3kW7NDJRGyEMSSdNs3MID0=
X-Google-Smtp-Source: AGHT+IHa8OsrzB4jqyal4kQFnT9d9Qdz0irWNjj5sLlFlAi4EbjoN266MB0WD70KT3QzWgo6fHoFWA==
X-Received: by 2002:a05:600c:1991:b0:439:6dba:adf2 with SMTP id
 5b1f17b1804b1-439ae1f1986mr7420095e9.15.1740090210974; 
 Thu, 20 Feb 2025 14:23:30 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399c41022csm58495935e9.40.2025.02.20.14.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 14:23:30 -0800 (PST)
Message-ID: <3637c187-0bea-4eac-9b45-c5f7cdb3e05c@linaro.org>
Date: Thu, 20 Feb 2025 23:23:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20250209103604.29545-1-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250209103604.29545-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 9/2/25 11:36, Bernhard Beschow wrote:
> TYPE_CHIPIDEA models an IP block which is also used in TYPE_ZYNQ_MACHINE which
> itself is not an IMX device. CONFIG_ZYNQ selects CONFIG_USB_EHCI_SYSBUS while
> TYPE_CHIPIDEA is a separate compilation unit, so only works by accident if
> CONFIG_IMX is given. Fix that by extracting CONFIG_USB_CHIPIDEA from CONFIG_IMX.
> 
> Fixes: 616ec12d0fcc "hw/arm/xilinx_zynq: Fix USB port instantiation"
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> cc: qemu-stable
> ---
>   hw/arm/Kconfig     | 6 +++++-
>   hw/usb/Kconfig     | 4 ++++
>   hw/usb/meson.build | 2 +-
>   3 files changed, 10 insertions(+), 2 deletions(-)

Maybe "hw/usb/Kconfig: " prefix in patch subject, otherwise thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


