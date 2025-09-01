Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99196CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 15:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut68O-0002Rt-OY; Mon, 01 Sep 2025 11:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut68L-0002RJ-FG
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 11:07:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut68I-0003Iz-DA
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 11:07:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b7d497abaso28729215e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756739258; x=1757344058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zyHbFMgRMru7uNQCryWsY5UExS//R+x8yF7dtu8HwoU=;
 b=WreHfDCuwv95afBaMHafJN3UtYA9QPENbhGizzPx6RRzP1UFM2Jxx5XjjOi/ZYfVnC
 H6p4be2OT6KK++Wu9PKij68SoD+AdJkm+h1QlwrD/2+u3AOwAKoyQThqQUnDYxZ4BygJ
 JFA7Fcm8nmzLxCPa7tzILNcXARqDYx/7BhZV1fmgKjNeSHMfbJGmChrq//m74HDWRbhL
 fh0duj1xaLxnQbmfzahcS/9hvYsaLLVNkKrAerfpeIDAwB3z+/6O2TdDnBwRCxlfvaYp
 bnNcjfhrfV8EyIlgay9c0Udi4tHrh+ksR+hRcQke3nTGRMNtPv3En5u2o/5IyUnSTGO6
 8J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756739258; x=1757344058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zyHbFMgRMru7uNQCryWsY5UExS//R+x8yF7dtu8HwoU=;
 b=wuc4+PY8AsCTyTpydAUddolbtL3L/qbk7bhd8uLchxEMyWjTnh5+DjDTkvLcqgNFhc
 UpLsqmT/lgGJ/tLFv+ASIg9ggznISlOa8Rf88sfUwTdErcp/WzLyE2w+ZqluGdbYAgnm
 yJsJTxhyqb5FVX1zn8TK4c1bSychVSQ8UhTAbNbvGZV7WvCoMRZyr9pMOghdwUXJn15T
 aCoCpsx9UjnPbQD+YXv67cWhuySKo7LWK0x7wb3o1e2Nadkji/5bBe3oRGSCvKKy7Xt8
 9i+OF5/wpcbZjUpSi9aCAE8V4yW/4cW7FHjZFeykNU6wFCURPp9M321JRCgxp2EQhKCT
 fA2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKmBpieNCc0p2bdakys0XlcwNZnOqBjcCyKmQ1ePwfh8I82C8nGAlegTCrKXLhMzWiXs7avz6fMlkt@nongnu.org
X-Gm-Message-State: AOJu0YyThEA957NbhcieqyvlVNLkHzWMeru64pLzoMQCZfypwouvfMTa
 3lgC8/RtKd6Ob0UkJyxu8RWKoIrO0332O4HlG03oDNhnLzWexc/YoNk3KiN9Jgn0DGWMV2aDcA1
 WHZfy
X-Gm-Gg: ASbGncvVGE43cgMY8yM5EYd3yojJoMPMcoGlibY4OK2TwBPA+kSmQrE77Xb+JtD6COB
 oko91N8K0vm4nyrXuuU5+5OjnYwgjqjq/Zwu6pWKt3CAmELDlOSDPEL6Zrqd4blpJTy/53FHSf1
 tR7AwdvCj9okb/oOdsnujuZzfKMytQAWFnugwoLItikrN4Ib5v6WqPmc8zWIz4ofrVWA8U9GGwt
 QSHaU/sTM14mFM+Lrf+lBnfZs8Yt7rpu+b6C0Jfsb2bd2e4MVUB564fz0tmbzSqCvXIlAiekjcH
 BskbHOd1aop5lthDdlWOed8A0LqSQfwQPRyy8kEoQ2jyvHDBmTmadltIX5EjUJhOja822DQ+FcK
 5vVITzzVz93DYHYyg06UjoOm37VvxgijX3Zm27e8y6fOHzXn8CW4+xTw9cGGBhqPHVdDsM24Ycg
 Oe
X-Google-Smtp-Source: AGHT+IEerNawJKgCNewf6SYufrn9opD1LlHnVAjGZAhXJXEeJpq8QHQPY6/KrQWld+/0/niMh0vQgQ==
X-Received: by 2002:a05:600c:4b1c:b0:45b:85e5:6cba with SMTP id
 5b1f17b1804b1-45b85e5731dmr47179295e9.5.1756739257830; 
 Mon, 01 Sep 2025 08:07:37 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b85090262sm111043185e9.17.2025.09.01.08.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 08:07:37 -0700 (PDT)
Message-ID: <c6b5359b-27d0-4776-9690-7d49debe3d7c@linaro.org>
Date: Mon, 1 Sep 2025 17:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] system/main.c: compile only once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
 <20250730220519.1140447-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250730220519.1140447-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi,

On 31/7/25 00:05, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build        | 4 ++--
>   system/meson.build | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index f94209bb301..b72d4ce8618 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4420,14 +4420,14 @@ foreach target : target_dirs
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
> diff --git a/system/meson.build b/system/meson.build
> index 6d21ff9faa7..f358c2c446d 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -18,6 +18,7 @@ system_ss.add(files(
>     'globals.c',
>     'ioport.c',
>     'ram-block-attributes.c',
> +  'main.c',
>     'memory_mapping.c',
>     'memory.c',
>     'physmem.c',

This makes the build-oss-fuzz job to fail:

FAILED: qemu-fuzz-i386
clang -m64 @qemu-fuzz-i386.rsp
/usr/bin/ld: libsystem.a.p/system_main.c.o: in function `main':
/builds/philmd/qemu/build-oss-fuzz/../system/main.c:70: multiple 
definition of `main'; 
/usr/bin/../lib/clang/18/lib/x86_64-redhat-linux-gnu/libclang_rt.fuzzer.a(FuzzerMain.cpp.o):(.text+0x0): 
first defined here
/usr/bin/ld: qemu-fuzz-i386.p/tests_qtest_fuzz_fuzz.c.o:(.bss+0x0): 
multiple definition of `__odr_asan_gen_qemu_main'; 
libsystem.a.p/system_main.c.o:(.bss+0x0): first defined here
clang: error: linker command failed with exit code 1 (use -v to see 
invocation)
ninja: build stopped: subcommand failed.
make: *** [Makefile:168: run-ninja] Error 1
Error : Build failed. Please specify a compiler with fuzzing support 
using the $CC and $CXX environment variables \nFor example: CC=clang 
CXX=clang++ ./scripts/oss-fuzz/build.sh, exiting.

https://gitlab.com/philmd/qemu/-/jobs/11205571060


