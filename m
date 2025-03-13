Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB15C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspVy-0003Cz-1d; Thu, 13 Mar 2025 16:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspVs-0003Ag-2C
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:50:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspVp-0004vN-NA
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:50:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223fb0f619dso28198865ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899039; x=1742503839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wI/ajVWjgg+sFGV4WNDo+Qyks0mwKmGahrnizs5Z3AU=;
 b=IStFxbVwhoXZW5c1KlOYyRZ7Lohf/5N19yVojtJ4op3UAGWyHuASDdwS/l88WQ36sQ
 qpceGM/iuohQ6bm/x13XzLenX3r5l2XKeV8L0yCpnMiaqx4VDU8lc/1HOsryYgNmeLIG
 lgwLHyRiA6B39qVYDloVU4y+Hr4PrjoTT1nPDsVN0DKNrbrpBcS4AYJ84oCQOxrajRpm
 hN/cqbaaWqED6SjKJXUohNkodxXl1QlSYGw68bgDNBO51jorofxZgHGjfTpm1ijHxxtM
 6IbCAnonD23snNikHZYCW0RAsET7j5hgjZko8vhEcR3tiSw61qVxyyMoCQRRYdjHr5uP
 j0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899039; x=1742503839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wI/ajVWjgg+sFGV4WNDo+Qyks0mwKmGahrnizs5Z3AU=;
 b=h0hDqgO6NktDmx6xeF4/Rjz6qu+6bG7qzg4h7NyOhZVEtZKONKZkrxAzEmWLIzA+2S
 c43r3XGSmpyNISrSrlbsQgSsfZE8qCge2SedaLL8J1Y4tfdkoZsysUDSr7kHObsCoy4s
 A7O4WpEYZcnmkPyeUKQsyjAEScp5+MD+V5ujiRtt2W2d0x6DNsnbgvalwtHil0WfnT9x
 +53u1liH6RNKwFzG/v/C0z3A7C8C4QKqNqVY0Wa6yFYoonDtWKchpFQPJiTicXhaVg/B
 QlrcJUVbRK1SmvUKJXqAYAAEHBPbiDKzaoXXJqMMntW51vumcbRgy5ch1Ccq4Tg1OGZY
 9gdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU41HXqiBcrQlOFkdiqTkSKvQ/7bn1+gUuWlhkT2oiXwkICLqrYjq6Khjp+NTEf6Pc0pviJH+4Vstka@nongnu.org
X-Gm-Message-State: AOJu0YwT+oRBcZ5jssW8xA3nIt9MD2r4SRAu6bLK+wmdeokvROGQZR7/
 hD1imusYk1TBegkt1TsUZ295r8Dsu+rDoB6efpy6LFYcqZa+FVMoz0aJEpnJCuo=
X-Gm-Gg: ASbGncu1aB7nXcyBZ1TD2V6PSQ6hLb1Z/TRjsCkP4jhYQXM9t/L4hPl/4o2w0fY4Qt7
 7hTiU8nQf72VQhiaMPT5wWqvtte+mEm/UabPK/ZNDc0uZmi2PRiVjBArE6SdbfpyiX2Qs+h7NKU
 b6KUYbpJRvOXuanfAMISnwxTwla7C3FL6A5CD0frogdlyvleDy9Cn0Wqbf821SMG1w4AM8vwio5
 xnj21wL1j9sKNPzZZb6+JPBSQhKIKUABd1wzBZ+QqNUXZGidnLYrfZMwjQu6TygQrqOQUz0q8Og
 WiereZR4eKkURO/CQBHqI9+7x7OQBKvhS6iq4D5tn/9GYlUN+onGwlJGYA==
X-Google-Smtp-Source: AGHT+IHl9kT5r+SEMAADtmRr/ip53S2ElRSiTb7/7x9CgBkce/GdVmr4MNqYl5yRWyDs5xUqIu62Uw==
X-Received: by 2002:a05:6a00:853:b0:737:9b:582a with SMTP id
 d2e1a72fcca58-7372026d830mr751649b3a.24.1741899038941; 
 Thu, 13 Mar 2025 13:50:38 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711529374sm1801486b3a.20.2025.03.13.13.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:50:38 -0700 (PDT)
Message-ID: <f0720036-e795-44c2-89af-443bdc8ba4e6@linaro.org>
Date: Thu, 13 Mar 2025 13:50:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/37] meson: Only allow CONFIG_USER_ONLY from certain
 source sets
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-38-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
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
> index 990c19a8ef..4ca384c409 100644
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
> index 3869e5bfbc..c2c71b6f8a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4043,7 +4043,8 @@ common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
>   libuser_ss = libuser_ss.apply({})
>   libuser = static_library('user',
>                            libuser_ss.sources() + genh,
> -                         c_args: '-DCONFIG_USER_ONLY',
> +                         c_args: ['-DCONFIG_USER_ONLY',
> +                                  '-DCOMPILING_SYSTEM_VS_USER'],
>                            dependencies: libuser_ss.dependencies(),
>                            build_by_default: false)
>   libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
> @@ -4053,7 +4054,8 @@ common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
>   libsystem_ss = libsystem_ss.apply({})
>   libsystem = static_library('system',
>                              libsystem_ss.sources() + genh,
> -                           c_args: '-DCONFIG_SOFTMMU',
> +                           c_args: ['-DCONFIG_SOFTMMU',
> +                                    '-DCOMPILING_SYSTEM_VS_USER'],
>                              dependencies: libsystem_ss.dependencies(),
>                              build_by_default: false)
>   libsystem = declare_dependency(objects: libsystem.extract_all_objects(recursive: false),

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


