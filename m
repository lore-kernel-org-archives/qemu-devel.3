Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A003D63954
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 14:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDlRD-0006z2-Iv; Wed, 20 Nov 2024 09:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDlRB-0006ym-9n
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 09:12:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDlR9-00077q-JT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 09:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732111924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=joXY5JvA/cJKIN4OSMbomfG39GBD8e5VF1+ZkJ++yx0=;
 b=gCmgOaV9pH3E/a81JTiDYHth4oBTPP5iLgQKCjYoLREYmoP3YKUoC7jgfnm8cyZDREU+GV
 YQa1PKI0UAjv/97pUcANgHcSU0PXDRcCSPAMhyK7MNh5yfV5isgRnVPE8AoXe7fK/AE82D
 Ifwn3KYtcn7NDZV3yyFzMvQ4knzadXQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-nOZRKKR2Mui8DV5mbQjV4w-1; Wed, 20 Nov 2024 09:12:03 -0500
X-MC-Unique: nOZRKKR2Mui8DV5mbQjV4w-1
X-Mimecast-MFC-AGG-ID: nOZRKKR2Mui8DV5mbQjV4w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-431604a3b47so16255905e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 06:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732111922; x=1732716722;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=joXY5JvA/cJKIN4OSMbomfG39GBD8e5VF1+ZkJ++yx0=;
 b=DYoxi0VMX0ynikmIs8ztAN9eicK/lj8Lh+aMOobX8hinoJtyj5oqOExTeFNTg9o7PG
 Lz+YbFBdCTaeuVAyIXIctw5TjPq2cMqqQ0tRCQgfFIbX9zg7TqGLKdpjVkvfGx6NkOj3
 hHH7tgPYDZZeoipVmEdoDa7Ygr4+XWu1epxieI3XubqXvbLHa/Q0NFTIPo56uIe4ZC8x
 No24VPt3tAN85XrhESi4B/Akyoedn7h02kP50SumMrCGn32dK3Pa5F7amFwj+NH13q8H
 iM5ljdWnNUUfgKENeZV+Tue6cawaRQPzcKTSzgxYN+V8mBbhy+uCWy4W23zygnunVwsC
 Q7nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxDuALZ6oGaV3HrLNmpzfT5ruS4ba3PqpmcSWf+qcMG61ypGSk9PWn+lp2wkjkS+d3nZ/Bk4b51Ly/@nongnu.org
X-Gm-Message-State: AOJu0YwIuf6dYPNJtGVpUtbJvLJNTjmNfgMjTr1/4yR6DluvelGZDKZK
 FG72Hf6BfxkyYvVGkOi8+t76Rur0krugKrNRHhWDNkVPkijT9nhno8aBIOTUSi4RESHSxA31IyI
 IHp+OWUdWWQCWpwCif/6VofhJzPgpEjExma7yxj8syj/9vow4hIiP
X-Received: by 2002:a05:600c:1ca2:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-4334f026f5cmr24058735e9.29.1732111920989; 
 Wed, 20 Nov 2024 06:12:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe9Xehn/Jp4lMjFjE0PlTRhGTXj/aDkt4jAOv106gVWqBLqJHXDT8MKAvyXsYcM3adqTEJZA==
X-Received: by 2002:a05:600c:1ca2:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-4334f026f5cmr24058575e9.29.1732111920680; 
 Wed, 20 Nov 2024 06:12:00 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-433b0158637sm21341045e9.0.2024.11.20.06.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 06:11:59 -0800 (PST)
Message-ID: <cb8000dd-35fa-4752-b560-8ec064382695@redhat.com>
Date: Wed, 20 Nov 2024 15:11:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Add missing SDL dependency to system/main.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20241120114943.85080-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241120114943.85080-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/20/24 12:49, Philippe Mathieu-Daudé wrote:
> When building QEMU configure with --disable-gtk --disable-cocoa
> on macOS we get:
> 
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

I think so, SDL has its own main() wrapper.  Anyhow:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

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


