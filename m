Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3CFC282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhY0-00009O-VL; Tue, 18 Mar 2025 20:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhXw-00008w-TF
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:44:37 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhXu-0005ru-N5
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:44:36 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22622ddcc35so7591325ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742345073; x=1742949873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K4YwHghKNCFjIhYeOTimT89NYOGTqRHLQljSsjt3CdI=;
 b=uUE5jt9w4mRIMEjco8s8N0xOPeWNOgB9CrWUFalGgyrz3SinYa8gz5ijoO+kxjs1JO
 yYHpRUXwrZcJ0BXZf288gIGHSRJKyF5oSy3fhKBp24YsOx1cY81NElLUg0aBuwhcuW71
 3HckT5cUrEt0Jh/W5uG+kgI1MVZD572jj41zafN4qhabtEWzCX+G/+SR7xNvFbLANMn8
 3vWXiGSrs4okooUikY5Bz2r6zEK6D6kI40oVe5ncNXn5WzYAVaszAVT5XdLqWQ2Ditzu
 YLgRWEDzktsIvS+5HwA8WtFuC2iULF3Gf/M18bN7wfN+TYllfsc9LLQPlwEaaOZdqjFu
 BVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742345073; x=1742949873;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K4YwHghKNCFjIhYeOTimT89NYOGTqRHLQljSsjt3CdI=;
 b=V3mcKgvut6KMIwD292saZGlsV2hpoD0DgCT98ulkE+8lJAWIMfIaw2uVSjAY7eQlNj
 Cgv9TkFrdL//4vFbyYxqODyFQI5RONSNg6/QkxwKGr8i+hL2c/HhC4GsQrXjFkflA9vR
 7jc/g1x04732L6VcHomOCZHOdro4sLWU2dUWw5UOCJAL3luYola4XrB6LeaihWS7JhAd
 /YJsL4dTcCBEanpsQAfjX3E84QsW24umtMmKAFWouIZ5+xsJAw8HMw9EBurVnMo70PO1
 lWyL0vt4RlIQpPapyifA3F5H+RZ+vYUKjjxpu2P8VRWE2lhSxlv9MbzD0IvxgPbg9mv4
 SvoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaQ9ZHLMKgaqW38BK/4h91DuD/RbMPMsiYf+XK+3pTnu6CsUw3Wntw42xU/x76OUYcbRULPAKn/zL3@nongnu.org
X-Gm-Message-State: AOJu0YyBytrPLvRtRy2NbCL9STy4qZUb3o+Iwpry80eezwzqZu0ZdJn+
 OrefKQ2dqBN9SZGBrFPPJHqOSzvpP4rDyyqELgj/qNY67ln/yeGdcA3BtoBiZBXRJDm5Z8rZ6pc
 6
X-Gm-Gg: ASbGncsKXoY8c+e6iWmoKTBkATzXJ1bLp9mx2MJimCwefwRWzh4zEmnPfLkWYRnpz5o
 F8HkGlXpMAQ40GgV9C7k+NYK57UqZdQ+t6ApQvjk0QmPGDuWmGWBd1sNGJeOLOIB2uYiEDgGh+W
 F91fPjdicELrnxBeNcob0b1Kjz34MWfjtGFklT+SIFgZjoezqYRoRWCZi7eMZhxaAM/txOBFwkm
 Ky9lqaM+Rl16p1N+vHMh6JIiEf38hpiIdKMgPssxL3eZ3WpufjOBFrtq6+OfJNOw3IpsTMD+rLv
 E1wrNt50O5l9GxQzc71Txrg7SThVWdb+i9etLXAGHSgI4eZ+FVc+igspAQ==
X-Google-Smtp-Source: AGHT+IHmKwU7Puyw5Oh7THts+woV5blrM/Qks8/FYmU5XF4r4cRfSYPvFZYNgO/vz+xvAQ7JljiSEA==
X-Received: by 2002:a17:903:22c4:b0:220:faa2:c911 with SMTP id
 d9443c01a7336-2264992ff63mr10932085ad.14.1742345073232; 
 Tue, 18 Mar 2025 17:44:33 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf576cf8sm167626a91.1.2025.03.18.17.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:44:32 -0700 (PDT)
Message-ID: <6cc45361-f934-486e-b59d-fe7431c5fc1f@linaro.org>
Date: Tue, 18 Mar 2025 17:44:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 42/42] meson: Only allow CONFIG_USER_ONLY from certain
 source sets
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-43-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/18/25 14:32, Richard Henderson wrote:
> Poison CONFIG_USER_ONLY and CONFIG_SOFTMMU unless
> the compilation unit is in specific_ss, libuser_ss,
> or libsystem_ss.  This is intended to prevent files
> being incorrectly added to common_ss.
> 
> Remove #ifndef CONFIG_USER_ONLY / #error / #endif blocks.
> All they do is trigger the poison error.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/poison.h                       | 5 +++++
>   include/hw/hw.h                             | 4 ----
>   include/system/confidential-guest-support.h | 4 ----
>   include/system/replay.h                     | 4 ----
>   include/system/xen.h                        | 4 ----
>   meson.build                                 | 6 ++++--
>   6 files changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 8ed04b3108..a6ffe4577f 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -67,4 +67,9 @@
>   #pragma GCC poison CONFIG_WHPX
>   #pragma GCC poison CONFIG_XEN
>   
> +#ifndef COMPILING_SYSTEM_VS_USER
> +#pragma GCC poison CONFIG_USER_ONLY
> +#pragma GCC poison CONFIG_SOFTMMU
> +#endif
> +
>   #endif
> diff --git a/include/hw/hw.h b/include/hw/hw.h
> index 045c1c8b09..1b33d12b7f 100644
> --- a/include/hw/hw.h
> +++ b/include/hw/hw.h
> @@ -1,10 +1,6 @@
>   #ifndef QEMU_HW_H
>   #define QEMU_HW_H
>   
> -#ifdef CONFIG_USER_ONLY
> -#error Cannot include hw/hw.h from user emulation
> -#endif
> -
>   G_NORETURN void hw_error(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
>   
>   #endif
> diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
> index b68c4bebbc..ea46b50c56 100644
> --- a/include/system/confidential-guest-support.h
> +++ b/include/system/confidential-guest-support.h
> @@ -18,10 +18,6 @@
>   #ifndef QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
>   #define QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
>   
> -#ifdef CONFIG_USER_ONLY
> -#error Cannot include system/confidential-guest-support.h from user emulation
> -#endif
> -
>   #include "qom/object.h"
>   
>   #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
> diff --git a/include/system/replay.h b/include/system/replay.h
> index 8926d8cf4b..1c87c97fdd 100644
> --- a/include/system/replay.h
> +++ b/include/system/replay.h
> @@ -11,10 +11,6 @@
>   #ifndef SYSTEM_REPLAY_H
>   #define SYSTEM_REPLAY_H
>   
> -#ifdef CONFIG_USER_ONLY
> -#error Cannot include this header from user emulation
> -#endif
> -
>   #include "exec/replay-core.h"
>   #include "qapi/qapi-types-misc.h"
>   #include "qapi/qapi-types-run-state.h"
> diff --git a/include/system/xen.h b/include/system/xen.h
> index 5f41915732..c2f283d1c2 100644
> --- a/include/system/xen.h
> +++ b/include/system/xen.h
> @@ -10,10 +10,6 @@
>   #ifndef SYSTEM_XEN_H
>   #define SYSTEM_XEN_H
>   
> -#ifdef CONFIG_USER_ONLY
> -#error Cannot include system/xen.h from user emulation
> -#endif
> -
>   #include "exec/cpu-common.h"
>   
>   #ifdef COMPILING_PER_TARGET
> diff --git a/meson.build b/meson.build
> index 329e7f056a..b4d65a75e5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4054,7 +4054,8 @@ common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
>   libuser_ss = libuser_ss.apply({})
>   libuser = static_library('user',
>                            libuser_ss.sources() + genh,
> -                         c_args: '-DCONFIG_USER_ONLY',
> +                         c_args: ['-DCONFIG_USER_ONLY',
> +                                  '-DCOMPILING_SYSTEM_VS_USER'],
>                            dependencies: libuser_ss.dependencies(),
>                            build_by_default: false)
>   libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
> @@ -4064,7 +4065,8 @@ common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
>   libsystem_ss = libsystem_ss.apply({})
>   libsystem = static_library('system',
>                              libsystem_ss.sources() + genh,
> -                           c_args: '-DCONFIG_SOFTMMU',
> +                           c_args: ['-DCONFIG_SOFTMMU',
> +                                    '-DCOMPILING_SYSTEM_VS_USER'],
>                              dependencies: libsystem_ss.dependencies(),
>                              build_by_default: false)
>   libsystem = declare_dependency(objects: libsystem.extract_all_objects(recursive: false),

That's a nice addition.
I'll benefit from that for hw/arm, where I have a few blocks to cleanup 
as well.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


