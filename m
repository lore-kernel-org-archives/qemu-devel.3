Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B91C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufPLM-0001bc-W8; Fri, 25 Jul 2025 16:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufPHN-0007bb-0P
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:44:33 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufPHL-0004tI-7A
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:44:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-23c703c471dso37817655ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753476269; x=1754081069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HzzlB2MUahOK9tggNakDupnKXOdWqjMTX8brk0xUdn0=;
 b=Ojw7pn2Jg8/orwDnkSvmHDFRWoZQpOuDfJyOIdKEjSqqOf7ARHffcirA2FyWX2crLV
 4h4QQ4iGJMQGkxk75aTptakpEZJCTK8HifIPxubcLdftF9nQIKACZ+Z2NoNYz8Nhr7De
 myRSSLohMJK4HdU3s7YQw8WK3ADccj/SCOQRQEsYQO6UoOej9hOqMi7WksRXudNgsxOp
 Xvl/Wd85ujhvSrT8CbTNw9QPCYKsTObd5eViRam7sxdU8SWYHE7CwkOow9hEpiObBNBS
 Cgb7pFryJuIIGDK/dyaTYpoyCBZAFOEp7AEtJb8/dkalSbg7u9m4uaJEU2ViSm3hkI61
 rC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753476269; x=1754081069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HzzlB2MUahOK9tggNakDupnKXOdWqjMTX8brk0xUdn0=;
 b=AOqz3EFINghr36Wv2i3ALgsA6P8X18MEFF54f/BOr+jw2Ql9FrOfDGBXuipo1dX0xG
 0oy2zNAnE65HwwKALLGsP4OanbOyFyb8tp6qnYJZC1Uir1T2gp2quEO4T5Boa4P3WEuF
 4NAdMslSvxMuHBn0qE/HbuibgsvHP6KPyUE4FUDsLeRBtLPHAJ5kcdn6Fte/6E645Z2G
 +0TM3Tm34HDmMlXh4qp5KekRy+Q91xb0i9QwWxSn7Dlbn63MmMlZBky1K4+jR8mqXeQs
 Y6EMf6Gmcc9m+NbHC9NLTyfIYMfUM5y11kbqN0MXgLqBnMmGBDOiDAR/u2j7wYnEevkV
 23Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM85j584X7zvcf+thmPweEIYCP883Z73cweSv0tFpcIrJwylH310KKkM30xtfM9tUGi+I4yQ+D8jXQ@nongnu.org
X-Gm-Message-State: AOJu0YwSjwFQgtyXZt1NVGQDMxbrQA/Vqttz8cAXzHJoow1x353sXXe7
 9/aB8yHe6FGGjdM0Ckc0SUyENkH+b/eK39WGjZ9jKuGinVXQZl63GvklasdwOaBYs5s=
X-Gm-Gg: ASbGnctl9lXDP4O+AbOjMQWt4Bn8unyUHqNdKy2vtepU/Vgkl3mCBr3LDJMI6v3aPAD
 wQLeVd5twN6Wujp5/QC3lC2BHBP6jkGUxDH5ctkrJlllL4PEESwRWQpg61Okq/GHPVocNDIXiIg
 bX6FcF33JFXK1yf99CBY3l5oHXS85sKd3Np9snDGTkdYiOofhBtvI9c+6gZCH7JQzNVarnQomur
 ypkv2GRo+sRGV0MhrAc/i3+zaFDWHBFXd0xSRIUcAy4/FvTaN0l6NwWUGyIgOmqbzlY+6nJHb+h
 5UcVO9+d1eRYaQHQYqLanaBfbTwifBIbfpggFDnoGo/1FIfnuZRgo8LWnTPvOAZ3RdeeJRVjKIf
 VRFKWq7PtBzia29rqp2/G6eEgTVyorArL402Mnh5wlJU1+Mqgx6xkevog+g6kdQwF99t5EsDUCX
 twhg==
X-Google-Smtp-Source: AGHT+IEPqJljaq9tPCKOvFNAoq/OMt2FBlS3XJ5UzE/nHt3Kq6XHXcQI8ykuKSYtFnnXrTASQY3YZg==
X-Received: by 2002:a17:903:20d4:b0:23f:bc59:ba8b with SMTP id
 d9443c01a7336-23fbc59bb9dmr19343925ad.8.1753476269511; 
 Fri, 25 Jul 2025 13:44:29 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe548618sm3657675ad.182.2025.07.25.13.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 13:44:29 -0700 (PDT)
Message-ID: <d9fbdd83-599d-4cd2-a98f-6e43f902527d@linaro.org>
Date: Fri, 25 Jul 2025 10:44:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] system/main.c: compile only once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
 <20250725202016.21325-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725202016.21325-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 7/25/25 10:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build        | 5 ++---
>   system/meson.build | 1 +
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 71c253ba135..7718983951e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4437,14 +4437,14 @@ foreach target : target_dirs
>       execs = [{
>         'name': 'qemu-system-' + target_name,
>         'win_subsystem': 'console',
> -      'sources': files('system/main.c'),
> +      'sources': [],
>         'dependencies': [sdl]
>       }]
>       if host_os == 'windows' and (sdl.found() or gtk.found())
>         execs += [{
>           'name': 'qemu-system-' + target_name + 'w',
>           'win_subsystem': 'windows',
> -        'sources': files('system/main.c'),
> +        'sources': [],
>           'dependencies': [sdl]
>         }]
>       endif
> @@ -4519,7 +4519,6 @@ foreach lib: single_binary_libs
>     single_binary_objects += lib.extract_all_objects(recursive: true)
>   endforeach
>   executable('qemu-system',
> -            sources: files('system/main.c'),
>               objects: single_binary_objects,
>               dependencies: single_binary_deps,
>               link_depends: [block_syms, qemu_syms],

This series depends on stuff not upstream.  But anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

