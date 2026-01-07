Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003CCCF6BEA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 05:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdM6H-0003x1-Dx; Wed, 07 Jan 2026 00:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdM6E-0003vh-6H
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 00:28:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdM6C-00081I-2C
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 00:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767763727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5C+u1mLqaXDB1dZr0w8v+YMNQBZDSHCnHi/uCTcqSTo=;
 b=IzK6Eygr/184fu7CoDNmzTp2RyFqzf6sUJ55AdZVNGezZMmFxCsTr5zi9akXA3dsFEnCHd
 dsyH856N75D4Wour1oMv7deVsjidrQC2wfTS069oiD1jYUNeeg1RAI1Jq+SRVTDETg/krz
 GZ7l9jeD6uPlwwFWgG254jRDLI9wLEM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-ebMLVGebOu6ijfx0PYDTzQ-1; Wed, 07 Jan 2026 00:28:45 -0500
X-MC-Unique: ebMLVGebOu6ijfx0PYDTzQ-1
X-Mimecast-MFC-AGG-ID: ebMLVGebOu6ijfx0PYDTzQ_1767763724
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso852598f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 21:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767763724; x=1768368524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5C+u1mLqaXDB1dZr0w8v+YMNQBZDSHCnHi/uCTcqSTo=;
 b=MwKA7sywcuQaeYUazNMx0PVWfLunkGUFlOd70kr2VszV58njmb+oTZZYp1FzZoXzVp
 YPRsvcK0VfzY41TnHSgi/tlmIGoFwr8C/brBCSi5o2kOsJbtO1OAEvObpNoIUST9QCj2
 yjRx92hu53KOBgreU10Aa/KgI7dIF3qNm316gm1iS5rpEuy1MzVrYe+QFPO9tVIlv+gO
 1Ake7LHKZhvbYc1TbCZc4bprBKKMA7KYmgY2d0V0gRT0j1M0/uzLUJCG+xUKrWingi8p
 GG3rn60mpvhBuxcgzBsp7Oaek9UjMnwOjI7KmX/qhqxKcbzm3/4BB/Upn/vtvJoohWqz
 a5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767763724; x=1768368524;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5C+u1mLqaXDB1dZr0w8v+YMNQBZDSHCnHi/uCTcqSTo=;
 b=SnyoHDsTEpCGI0H0+zfgcpRIzFiJ73afzaWd+thWPmYLGbLzLjni9LR9nakEGjGaUI
 t39nmSWMktDWQjQok5DKhFViajCJmwqA+puSG+52PaFxyeOHay2YHIr2Jxv6Dl713GR2
 fNwyMYfODkq2Y2+IZguEO4cbBaWmBXU6GK5Z/hYPPT+Vz53B10c2Sc8m5hxCSxjDE5h/
 926GPpOy+GmzXAYnmYwUk5e0hqWODu7oNU/J1IzGE5rnevZonA3OoiVZ3Vpt88igkTmG
 1FUQYlQ0Mogev2GpSzYrwbGY/0Azn+vSiGBTQItNRfK5YiE+NJevZebjTNf/PfxVyzew
 VlCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCZA1xVEHxbLAA9/1h64OB1BgCATf4FrNXooDCy9QOgfgcjA9Ykrdz6fPdbfemwOdfMzFC8kopd+XL@nongnu.org
X-Gm-Message-State: AOJu0YxKjCksU/O4mnrnuUQ4aqqrzaLpYuPL6hzhubfb+2MlasmJ/ZeP
 Bx/x5un4cM+ly36j0CUsIrjzsSo8OdXRPU9lGEB5mUkgQrNTR/SutKqkV/VyTMXeCYhR/dDXher
 fwKp7oebTFBb2Qidb24axaLH6CXh4Q9iU+BA5XsggW+5vfGmLVu1qzQY3
X-Gm-Gg: AY/fxX5+vSDnaWQpkKdzt5xIg8UhuKaYmeOckIcTQfupa7X7qgwOZ+ZfXJIWWxY2IrV
 ZNgwOTEhoL4oZSITFdHsOkXKQTXWJSdesojyk77kKh5ieBXwEXPETdEu5M2Wynl/RuMvLOjzuKR
 Xm861SMniuno//RfWdIbeHY+rqMR4/4WIKedQpPP1Ajbitl3B2XywQx/2VmMqhDage7sZDoIIea
 lx0ldX/xZtQGAfdrBi4gIYUPNXNTvg0kE15oXtJ+QEVZFeMQ5pVxCBIvpohKvw+I0gOcsihO7ko
 eNpoocQbeL9UauEsDbh/EkXAVOWTT3ZuCaASxtbxhJTXbSY0NO1lEQHwHqhbudcaaOttTAASji+
 rNBSdzx0=
X-Received: by 2002:a05:6000:288b:b0:431:16d:63d7 with SMTP id
 ffacd0b85a97d-432c37615a2mr1400340f8f.47.1767763723887; 
 Tue, 06 Jan 2026 21:28:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPnu3xCEnyl/w+vA1PsSrrJlWeB6dppMWTitzA4siF5QXSHwDei98ywiWRUO+KGYMHqoMtMw==
X-Received: by 2002:a05:6000:288b:b0:431:16d:63d7 with SMTP id
 ffacd0b85a97d-432c37615a2mr1400328f8f.47.1767763723387; 
 Tue, 06 Jan 2026 21:28:43 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9afsm8777266f8f.24.2026.01.06.21.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 21:28:42 -0800 (PST)
Message-ID: <5938bf19-ad4d-42a3-95e5-235b277aba21@redhat.com>
Date: Wed, 7 Jan 2026 06:28:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/s390x: Restrict WatchPoint API to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20260106231908.16756-1-philmd@linaro.org>
 <20260106231908.16756-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260106231908.16756-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/01/2026 00.19, Philippe Mathieu-Daudé wrote:
> By inverting the 'tcg_enabled()' check in s390_cpu_set_psw()
> we can let the compiler elide the s390_cpu_recompute_watchpoints()
> call when TCG is not available. Move it to a TCG specific
> file to avoid compiling dead code on KVM. This restricts the
> WatchPoint API calls to TCG.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/s390x-internal.h |  1 -
>   target/s390x/tcg/tcg_s390x.h  |  4 +++
>   target/s390x/cpu.c            | 30 ++++++++++----------
>   target/s390x/helper.c         | 38 -------------------------
>   target/s390x/tcg/debug.c      | 53 +++++++++++++++++++++++++++++++++++
>   target/s390x/tcg/meson.build  |  3 ++
>   6 files changed, 75 insertions(+), 54 deletions(-)
>   create mode 100644 target/s390x/tcg/debug.c
> 
> diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
> index 9691366ec91..c4cd17d4d7d 100644
> --- a/target/s390x/s390x-internal.h
> +++ b/target/s390x/s390x-internal.h
> @@ -317,7 +317,6 @@ void s390_cpu_gdb_init(CPUState *cs);
>   void s390_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>   void do_restart_interrupt(CPUS390XState *env);
>   #ifndef CONFIG_USER_ONLY
> -void s390_cpu_recompute_watchpoints(CPUState *cs);
>   void s390x_tod_timer(void *opaque);
>   void s390x_cpu_timer(void *opaque);
>   void s390_handle_wait(S390CPU *cpu);
> diff --git a/target/s390x/tcg/tcg_s390x.h b/target/s390x/tcg/tcg_s390x.h
> index 78558912f99..33f26f26c0f 100644
> --- a/target/s390x/tcg/tcg_s390x.h
> +++ b/target/s390x/tcg/tcg_s390x.h
> @@ -21,4 +21,8 @@ G_NORETURN void tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
>   G_NORETURN void tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
>                                             uintptr_t ra);
>   
> +#ifndef CONFIG_USER_ONLY
> +void s390_cpu_recompute_watchpoints(CPUState *cs);
> +#endif
> +
>   #endif /* TCG_S390X_H */
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 6c4198eb1b1..f68b288e364 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -40,6 +40,7 @@
>   #include "system/reset.h"
>   #endif
>   #include "hw/s390x/cpu-topology.h"
> +#include "tcg/tcg_s390x.h"
>   
>   #define CR0_RESET       0xE0UL
>   #define CR14_RESET      0xC2000000UL;
> @@ -74,26 +75,25 @@ void s390_cpu_set_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
>       env->psw.mask = mask;
>   
>       /* KVM will handle all WAITs and trigger a WAIT exit on disabled_wait */
> -    if (!tcg_enabled()) {
> -        return;
> -    }
> -    env->cc_op = (mask >> 44) & 3;
> +    if (tcg_enabled()) {
> +        env->cc_op = (mask >> 44) & 3;
>   
>   #ifndef CONFIG_USER_ONLY
> -    if (is_early_exception_psw(mask, addr)) {
> -        env->int_pgm_ilen = 0;
> -        trigger_pgm_exception(env, PGM_SPECIFICATION);
> -        return;
> -    }
> +        if (is_early_exception_psw(mask, addr)) {
> +            env->int_pgm_ilen = 0;
> +            trigger_pgm_exception(env, PGM_SPECIFICATION);
> +            return;
> +        }
>   
> -    if ((old_mask ^ mask) & PSW_MASK_PER) {
> -        s390_cpu_recompute_watchpoints(env_cpu(env));
> -    }
> +        if ((old_mask ^ mask) & PSW_MASK_PER) {
> +            s390_cpu_recompute_watchpoints(env_cpu(env));
> +        }
>   
> -    if (mask & PSW_MASK_WAIT) {
> -        s390_handle_wait(env_archcpu(env));
> -    }
> +        if (mask & PSW_MASK_WAIT) {
> +            s390_handle_wait(env_archcpu(env));
> +        }
>   #endif
> +    }
>   }
>   
>   uint64_t s390_cpu_get_psw_mask(CPUS390XState *env)
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 184428c6d9d..8d1e03f6768 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -143,41 +143,3 @@ void do_restart_interrupt(CPUS390XState *env)
>   
>       s390_cpu_set_psw(env, mask, addr);
>   }
> -
> -void s390_cpu_recompute_watchpoints(CPUState *cs)
> -{
> -    const int wp_flags = BP_CPU | BP_MEM_WRITE | BP_STOP_BEFORE_ACCESS;
> -    CPUS390XState *env = cpu_env(cs);
> -
> -    /* We are called when the watchpoints have changed. First
> -       remove them all.  */
> -    cpu_watchpoint_remove_all(cs, BP_CPU);
> -
> -    /* Return if PER is not enabled */
> -    if (!(env->psw.mask & PSW_MASK_PER)) {
> -        return;
> -    }
> -
> -    /* Return if storage-alteration event is not enabled.  */
> -    if (!(env->cregs[9] & PER_CR9_EVENT_STORE)) {
> -        return;
> -    }
> -
> -    if (env->cregs[10] == 0 && env->cregs[11] == -1LL) {
> -        /* We can't create a watchoint spanning the whole memory range, so
> -           split it in two parts.   */
> -        cpu_watchpoint_insert(cs, 0, 1ULL << 63, wp_flags, NULL);
> -        cpu_watchpoint_insert(cs, 1ULL << 63, 1ULL << 63, wp_flags, NULL);
> -    } else if (env->cregs[10] > env->cregs[11]) {
> -        /* The address range loops, create two watchpoints.  */
> -        cpu_watchpoint_insert(cs, env->cregs[10], -env->cregs[10],
> -                              wp_flags, NULL);
> -        cpu_watchpoint_insert(cs, 0, env->cregs[11] + 1, wp_flags, NULL);
> -
> -    } else {
> -        /* Default case, create a single watchpoint.  */
> -        cpu_watchpoint_insert(cs, env->cregs[10],
> -                              env->cregs[11] - env->cregs[10] + 1,
> -                              wp_flags, NULL);
> -    }
> -}
> diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
> new file mode 100644
> index 00000000000..12ae95d4fe8
> --- /dev/null
> +++ b/target/s390x/tcg/debug.c
> @@ -0,0 +1,53 @@
> +/*
> + * QEMU S/390 debug routines
> + *
> + * Copyright (c) 2009 Ulrich Hecht
> + * Copyright (c) 2011 Alexander Graf
> + * Copyright (c) 2012 SUSE LINUX Products GmbH
> + * Copyright (c) 2012 IBM Corp.

Looking at "git blame," the code has been introduced in commit 
311918b979c5364c30392c1054ed77d047a83953, so none of the above 
people/companies has been involved.

That original commit also introduced another function called 
s390x_cpu_debug_excp_handler() which now resides in 
target/s390x/tcg/excp_helper.c ... so maybe s390_cpu_recompute_watchpoints() 
should simply be moved there, too, instead?

  Thomas


