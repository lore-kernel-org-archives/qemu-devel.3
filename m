Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B11E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyy6-0000yd-Cx; Wed, 18 Dec 2024 13:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNyy2-0000xQ-T5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:40:20 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNyy0-0004Me-QR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:40:18 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71e3cbd0583so1190220a34.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734547215; x=1735152015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C0FjduRa7lr/CqC+y0uk5G7bJlKVTpcZ0VPcgYpxRt8=;
 b=tC1xNrxciMXV0sPx5jg1rjRkMR7NxoMEsuDqlZJkJw3KV3UesGv+Rzriq6G1XsAF6/
 XTQLtUICUOVRM9wPeNta6fUKMI9H86j49vKiUmMiG975NEtMEhQw47ZJ+vhQVo9zPJqE
 xS4yPFR0xt7wbG50SdozzReADgbuB+LgTxLqsocDtTP4hsNszVJXs251Jx9Lejz2JYmZ
 wW1by6UxJTLqo7aoERkRd51sMqGYrucxzRsJE+MhIiqxMtBxCrfeaXTYyt/hiCBpdPMs
 upASTWCIUpD6FOdeqtW6JsDxFW8BDESILlQaeP36cGths36zZJoWT2VR10TKtblfELT8
 d6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734547215; x=1735152015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C0FjduRa7lr/CqC+y0uk5G7bJlKVTpcZ0VPcgYpxRt8=;
 b=KQ1M3knr81QX6m7PfrkVE8KEfgPNx1ZPAxEYY/D2nyI6pNnPDi2Q12F4Gdf0DM0ErW
 T4s6MKtFK0Km/NB3zg6Lo427LyrE8NpLeYsf+BRvbdWOa+4uZfNsjJ8ryjCXuNY/GEnE
 gVyGosfR0fvowxNPScK1fHEoMlmlqbJx0yMxh9qqoGLIl9DNlR1H1E/CeicnqdBadxqm
 ki5qyANedYVokvYEtnGmOyIt205tjR6ngIIwLjo0qexzcXSNCBq3auHN57CjAKHqW81l
 pXB8Gydlxv6m49fsIDK3t/hPp58rXmKkHLjnZxORTRMywKfvwg5z7226KsK9LaE1tt0b
 EAjg==
X-Gm-Message-State: AOJu0YzlXSKRxHSB1fwHCUmvZu1PNrQh9/bPyuAY0ZQ9goabOc9suJab
 Lcm3aXMb9L20YvVoh5zWU2LNVWtYqtXxms5sG5q21TA9oxMd77iSJXYvs/SMW+3aZ/ib7N3wd6/
 LW+Xdez+G
X-Gm-Gg: ASbGncveXXwj64850e+4Lsrv1rONsppP9XdGq9P0c2AKZt094zT1G7UdmpVvOzECHvK
 J04m7h6O9Wnb1m9UrFj57w743tVxqAijKeiJ2aEQJctaF6qUzAX/neCud4ySrvFY2eCjm92u8ti
 ctcCSuaXIBj0JYZ6Un09fudig6SkWsKIBctVg2T4eRQ1xO0Rc2mcOApDtu6+5HbhLF94TPCrLT/
 75Am9H7KQmrkj/hDCYaWIWTnUsSJ2U9B8IUc7Ahs31Dxv5irez1otvHodVFiHHRfYUa6mvWLQ==
X-Google-Smtp-Source: AGHT+IHYxF+MY93LMjaRUsmmwr5qdljbNRU1Z8Ow/7968zuv1xgvVbMg2Oe+aGCGLp7P4Ny6l55bTQ==
X-Received: by 2002:a05:6808:289a:b0:3ea:65bf:8438 with SMTP id
 5614622812f47-3eccc02c39cmr1830955b6e.3.1734547214911; 
 Wed, 18 Dec 2024 10:40:14 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a33dsm2956224b6e.8.2024.12.18.10.40.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 10:40:14 -0800 (PST)
Message-ID: <a7a88bb7-915b-4214-813b-a799068f9c6b@linaro.org>
Date: Wed, 18 Dec 2024 12:40:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Do not define CONFIG_DEVICES on user emulation
To: qemu-devel@nongnu.org
References: <20241218151256.68625-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241218151256.68625-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 12/18/24 09:12, Philippe Mathieu-Daudé wrote:
> CONFIG_DEVICES is not generated on user emulation, so
> do not define it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 85f74854735..d203e85d769 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4110,7 +4110,7 @@ foreach target : target_dirs
>     arch_deps = []
>     c_args = ['-DCOMPILING_PER_TARGET',
>               '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
> -            '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
> +  ]
>     link_args = emulator_link_args
>   
>     target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
> @@ -4130,6 +4130,7 @@ foreach target : target_dirs
>         arch_deps += hw.dependencies()
>       endif
>   
> +    c_args += ['-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
>       arch_srcs += config_devices_h[target]
>       link_args += ['@block.syms', '@qemu.syms']
>     else

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

