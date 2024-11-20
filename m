Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECC9D63931
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 11:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDjG3-0001XB-9B; Wed, 20 Nov 2024 06:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDjG1-0001We-8Q
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 06:52:29 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDjFz-0001X7-IB
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 06:52:29 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53d9ff8f1e4so5085703e87.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 03:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732103545; x=1732708345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9kUxIDAH6ueeKRXf1ghazDWtiLnsz7p4DgVTGyUXon4=;
 b=FMPUCciG6HnzTE5YdXm/ITW4iV17Q4omprq5vPQdf5ZfbMVWsxOeELMjnMAFaZTxu6
 ANmEYtOriU7FbCPAVutEglGZlWBXjqCHboaqWSAMkZbARyrfbg1kDWIr8xQYHdQ0pv2g
 uSScwApJ5JeAw54x48ngdhNg15Q0TNXeMK4SSx0/+dDfMIf4OFY0FUYwRk9nme1J4LQe
 s707NVZzT0HtmkNhFFrU0SpaW+0hwHxgt3YIYtSEGsjqelR9ChYY0Co6gokLtLr7nNW4
 88h4Zo7QMPlqdboO/4tK+iWB3KWtPDkXrG9UBEfwXPH2vhy1WkDfa1U8ME4F9N+x4Xdz
 haMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732103545; x=1732708345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9kUxIDAH6ueeKRXf1ghazDWtiLnsz7p4DgVTGyUXon4=;
 b=wKmWO34NtI/16CyAJ25W+uNbAQ2Fh/SkQrkSizO5lZm15XhE40+CUabuyWIWt43ohP
 lT2+mAy5pevEvpQ1rZPyaueFqUyM8C3UEGx2zl+Bt/NUgaPVTdsQKlfVJy0Q9wdVAVec
 KClufpB99jMK38ngZuBXrOxoKSNiDCP7Z2ULNBzK3YMLXLBBogMKiU2QkuXLlMsyfICA
 52kKiQ7xU2rwVQkOVj2BW27ywQoOdfdzpFxRsmW+KJBjrJSfRgMslZ7wVZRAZY0yFS5+
 TBSemNIiQIJg3Nz3mKveLrHkLQMXJeYUCV//e2vpg2TDndy5zHEpPDyGDai47ptb6APd
 N9og==
X-Gm-Message-State: AOJu0YwWf6H4SCnIYnclQeKGrgpv3p9rZY5FKABijkD0xY4FnYGhD63t
 rY4mQeQeoeABLgMzc0YgBf4le2+88bJh2EACBgFhHYaeDhihFZFkWCoOANQaLXEogRqn30RmzcF
 X
X-Google-Smtp-Source: AGHT+IHinmZ90H5ivqd4sjPsriL/WM0gYW7lqPVLMX9ux3ykIg2G/cG7JsiX7w9xg8MFwTPtkrqMSw==
X-Received: by 2002:a05:6512:3b24:b0:53d:a2b1:b3db with SMTP id
 2adb3069b0e04-53dc134365amr1122291e87.33.1732103544793; 
 Wed, 20 Nov 2024 03:52:24 -0800 (PST)
Received: from [192.168.69.146] ([176.187.208.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b01e117bsm17330195e9.8.2024.11.20.03.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 03:52:24 -0800 (PST)
Message-ID: <e91c4d9c-53b5-412b-ad05-71a487a6452a@linaro.org>
Date: Wed, 20 Nov 2024 12:52:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Add missing SDL dependency to system/main.c
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Akihiko Odaki <akihiko.odaki@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20241120114943.85080-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120114943.85080-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 20/11/24 12:49, Philippe Mathieu-Daudé wrote:
> When building QEMU configure with --disable-gtk --disable-cocoa
> on macOS we get:
> 

Relevant ./configure output:

   User interface
     Cocoa support                   : NO
     SDL support                     : YES 2.30.5
     SDL image support               : NO
     GTK support                     : NO
     pixman                          : YES 0.42.2
     VTE support                     : NO
     PNG support                     : YES 1.6.43
     VNC support                     : YES
     VNC SASL support                : YES
     VNC JPEG support                : YES 3.0.3
     spice protocol support          : YES 0.14.4
       spice server support          : NO
     curses support                  : YES
     brlapi support                  : NO

   User defined options
     cocoa                           : disabled
     docs                            : disabled
     gtk                             : disabled

>    ../system/main.c:30:10: fatal error: 'SDL.h' file not found
>       30 | #include <SDL.h>
>          |          ^~~~~~~
>    1 error generated.
> 
> Fix by adding the SDL dependency to main.c it's CFLAGS contains
> the SDL include directory.
> 
> Fixes: 64ed6f92ff ("meson: link emulators without Makefile.target")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Looking at commit 88c39c8693 ("Simplify softmmu/main.c") I wonder
> if this header is still required.
> ---
>   meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index e0b880e4e1..846ffa3834 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4235,14 +4235,14 @@ foreach target : target_dirs
>         'name': 'qemu-system-' + target_name,
>         'win_subsystem': 'console',
>         'sources': files('system/main.c'),
> -      'dependencies': []
> +      'dependencies': [sdl]
>       }]
>       if host_os == 'windows' and (sdl.found() or gtk.found())
>         execs += [{
>           'name': 'qemu-system-' + target_name + 'w',
>           'win_subsystem': 'windows',
>           'sources': files('system/main.c'),
> -        'dependencies': []
> +        'dependencies': [sdl]
>         }]
>       endif
>       if get_option('fuzzing')


