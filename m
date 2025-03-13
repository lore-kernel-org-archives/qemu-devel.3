Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17800C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmUH-0005Z3-Dn; Thu, 13 Mar 2025 13:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmTz-0005Tp-CD
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:36:35 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmTt-000246-VH
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:36:33 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3011737dda0so2361587a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741887388; x=1742492188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V/cjy26hj1xk/mvfsJEHv04tv/ZXHKPhfN0Bskh1rkY=;
 b=RDy1bDncg2j6wRtwB1j+HUF5hO2qYndrh6nmJwstXszvlQFKQHkHDujLNu8gL/DPnS
 tNMFeutGM4IOtkRixUv/z8bUgDYjDa2XT3vd5hMMyI+K6FQmcQRZnRF6oD+6ciiXwbET
 0hdwk6toOGFRANEyS4uZTAoKZKLqmjoBvky2SsSO0KkS+QUrl2E3SfM0AjkjQgGjGaqi
 RU2DIAjs4Nban6bl3R4xMXQrdusELd9HqsFfwNCUjPby9PdklG2WHIJWTMFs8KZZCY+j
 +0k4FCwdd+DQA0rhWS6Gv035KilUqJsT712c+7uUiC6imu1ZTu1fKADh4guzvK+LF+36
 i1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741887388; x=1742492188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V/cjy26hj1xk/mvfsJEHv04tv/ZXHKPhfN0Bskh1rkY=;
 b=m4twAdvPrb3fBoPLyy8CjiU1iQlNCKVh9yk7s13ys2/SC984QcheGNqUFqUQZy5Lqr
 Rc4ZFVoftTasvepu8B+fOoeF9tVgRCvm85ptjm/vEpJM2cpQ54qPRJkwAg6NuVnZXDwM
 OXqmSaS9g01jyUda0cRYn2d58JkWgYqN80/HcQX2YYsff10kV7y3qoB7gw2NtcSN+w50
 8hbGFJLSfSZUEUho45YefaaXYS26UUt4WkqTQoJQM/hH5z3pLpws9TR8uJhh0PAnSFVX
 X+EQaYHCLruRbRHbp1xxbmshLgzAFMZ+uXMBmvDnufYr+mN7rEbyFnH/x3nWBD8MbzV9
 Sm5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoP3cpUF2z3hjlr24LOdNLjFDz9m+ItGMVjHrA8Ha14kA2+NSzZph/QZXWeVr8D4mNIqVd1csB3a+d@nongnu.org
X-Gm-Message-State: AOJu0YxxT9Uybeai+EDCL7/977GCRaMCixaZWfBnI0QCskoVHIUs9fgk
 n8bhLT6TqPaNgSzdmJr6i/sge0Gb9QxmtfuhFM37lqljRwrwNx96lywt7AJYgto=
X-Gm-Gg: ASbGncsXGiT3i2JsLjH5G7+k/tkFrQTEsTPkP40kbZvs9NE+ykip/K5Yvr9MvSfSWfW
 IEoYvZwDVZHmd0olm8qBvo43iJjp/jG/o8LoW8VUmJ2ruLvjrXLIggfCuz2hIxd/xmGfei3HDsh
 4T+DwM4QpiIJr+P3rDrkd3Pqcx+fw1r8IDb+r5QLV1hRL9esqTuOo4LGVoN1BdyXE1oJzeVQguW
 qhN1z6VfzMLtENuckJ0Rq1x3m6peigYhmZBL33NsJM+T8SFDC74jrxOnG6TrEVhRwzD7IoCFoAE
 HOfLZlkOo+79o/gK07dY1DjjYCIhJ+0if/+Dms4yYtvJa0/F4KHV0ly65A==
X-Google-Smtp-Source: AGHT+IGKmjDp+rnZJE7bWRhCg8lZ283YoGigRjq/35aMnHFNzFMga2oImySvUU/iVvYKauwhk+A5Uw==
X-Received: by 2002:a17:90a:fc43:b0:2ff:702f:7172 with SMTP id
 98e67ed59e1d1-3014ea1f10emr531348a91.33.1741887388459; 
 Thu, 13 Mar 2025 10:36:28 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30138b5cbd4sm1636966a91.21.2025.03.13.10.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:36:28 -0700 (PDT)
Message-ID: <365d0d47-0dda-46c4-a8dd-097baa8af42c@linaro.org>
Date: Thu, 13 Mar 2025 10:36:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/37] meson: Introduce top-level libuser_ss and
 libsystem_ss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-18-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
> We already have two subdirectories for which we need
> to build files twice, for user vs system modes.
> Move this handling to the top level.
> 
> This cannot be combined with user_ss or system_ss,
> because the formulation has not been extended to support
> configuration symbols.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   gdbstub/meson.build | 32 ++++++++------------------------
>   meson.build         | 22 ++++++++++++++++++++++
>   tcg/meson.build     | 23 ++---------------------
>   3 files changed, 32 insertions(+), 45 deletions(-)
> 
> diff --git a/gdbstub/meson.build b/gdbstub/meson.build
> index dff741ddd4..0e8099ae9c 100644
> --- a/gdbstub/meson.build
> +++ b/gdbstub/meson.build
> @@ -4,32 +4,16 @@
>   # types such as hwaddr.
>   #
>   
> -# We need to build the core gdb code via a library to be able to tweak
> -# cflags so:
> -
> -gdb_user_ss = ss.source_set()
> -gdb_system_ss = ss.source_set()
> -
>   # We build two versions of gdbstub, one for each mode
> -gdb_user_ss.add(files('gdbstub.c', 'user.c'))
> -gdb_system_ss.add(files('gdbstub.c', 'system.c'))
> +libuser_ss.add(files(
> +  'gdbstub.c',
> +  'user.c'
> +))
>   
> -gdb_user_ss = gdb_user_ss.apply({})
> -gdb_system_ss = gdb_system_ss.apply({})
> -
> -libgdb_user = static_library('gdb_user',
> -                             gdb_user_ss.sources() + genh,
> -                             c_args: '-DCONFIG_USER_ONLY',
> -                             build_by_default: false)
> -
> -libgdb_system = static_library('gdb_system',
> -                                gdb_system_ss.sources() + genh,
> -                                build_by_default: false)
> -
> -gdb_user = declare_dependency(objects: libgdb_user.extract_all_objects(recursive: false))
> -user_ss.add(gdb_user)
> -gdb_system = declare_dependency(objects: libgdb_system.extract_all_objects(recursive: false))
> -system_ss.add(gdb_system)
> +libsystem_ss.add(files(
> +  'gdbstub.c',
> +  'system.c'
> +))
>   
>   common_ss.add(files('syscalls.c'))
>   
> diff --git a/meson.build b/meson.build
> index 9d9c11731f..3869e5bfbc 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3655,12 +3655,14 @@ io_ss = ss.source_set()
>   qmp_ss = ss.source_set()
>   qom_ss = ss.source_set()
>   system_ss = ss.source_set()
> +libsystem_ss = ss.source_set()
>   specific_fuzz_ss = ss.source_set()
>   specific_ss = ss.source_set()
>   rust_devices_ss = ss.source_set()
>   stub_ss = ss.source_set()
>   trace_ss = ss.source_set()
>   user_ss = ss.source_set()
> +libuser_ss = ss.source_set()
>   util_ss = ss.source_set()
>   
>   # accel modules
> @@ -4038,6 +4040,26 @@ common_ss.add(qom, qemuutil)
>   common_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: [system_ss])
>   common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
>   
> +libuser_ss = libuser_ss.apply({})
> +libuser = static_library('user',
> +                         libuser_ss.sources() + genh,
> +                         c_args: '-DCONFIG_USER_ONLY',
> +                         dependencies: libuser_ss.dependencies(),
> +                         build_by_default: false)
> +libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
> +                             dependencies: libuser_ss.dependencies())
> +common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
> +
> +libsystem_ss = libsystem_ss.apply({})
> +libsystem = static_library('system',
> +                           libsystem_ss.sources() + genh,
> +                           c_args: '-DCONFIG_SOFTMMU',
> +                           dependencies: libsystem_ss.dependencies(),
> +                           build_by_default: false)
> +libsystem = declare_dependency(objects: libsystem.extract_all_objects(recursive: false),
> +                               dependencies: libsystem_ss.dependencies())
> +common_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: libsystem)
> +
>   # Note that this library is never used directly (only through extract_objects)
>   # and is not built by default; therefore, source files not used by the build
>   # configuration will be in build.ninja, but are never built by default.
> diff --git a/tcg/meson.build b/tcg/meson.build
> index 69ebb4908a..7df378d773 100644
> --- a/tcg/meson.build
> +++ b/tcg/meson.build
> @@ -27,24 +27,5 @@ if host_os == 'linux'
>     tcg_ss.add(files('perf.c'))
>   endif
>   
> -tcg_ss = tcg_ss.apply({})
> -
> -libtcg_user = static_library('tcg_user',
> -                             tcg_ss.sources() + genh,
> -                             dependencies: tcg_ss.dependencies(),
> -                             c_args: '-DCONFIG_USER_ONLY',
> -                             build_by_default: false)
> -
> -tcg_user = declare_dependency(objects: libtcg_user.extract_all_objects(recursive: false),
> -                              dependencies: tcg_ss.dependencies())
> -user_ss.add(tcg_user)
> -
> -libtcg_system = static_library('tcg_system',
> -                                tcg_ss.sources() + genh,
> -                                dependencies: tcg_ss.dependencies(),
> -                                c_args: '-DCONFIG_SOFTMMU',
> -                                build_by_default: false)
> -
> -tcg_system = declare_dependency(objects: libtcg_system.extract_all_objects(recursive: false),
> -                                dependencies: tcg_ss.dependencies())
> -system_ss.add(tcg_system)
> +libuser_ss.add_all(tcg_ss)
> +libsystem_ss.add_all(tcg_ss)

Good move,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


