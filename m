Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16016C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 16:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viaey-0004Kb-SP; Wed, 21 Jan 2026 11:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1viaei-00049z-PQ
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:02:08 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1viaee-0007x8-Ae
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:02:04 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so47382235e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769011318; x=1769616118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cR5zNIGLc6jF31wai4UyLd4hZGb5cEinB/KIQx3lvoI=;
 b=FxS3YrXST6d/f1ub9OSBNto4pZLo5f45H7SJIVUaO/NbHdh/g5snDnkxEDZyPqLbvh
 JmVc9uDxUHRET1c8HXbvn42AgR+vZpfBQeInSy4hp4J/H0CCDLFKuDoyc9AcYYraFXaz
 PfzAqgUzmgBLMgUCSlkhVnBfpZl8tO8qmCFJqnMHkYnArArdzZD8pVYSQ9Kcy75iMv6W
 zlrII4ens4YmOSnuuHX4BkKLF/w6ICDBLjFgmGzmZ1TgwghajtiBRNf3pHhfaF4UDrSL
 6eDLSAkcqG715mBa8QJFgZE/gkeIZT78MrL/93GdUT6nIIEpe0Q5NVig65Cdcd9yj0k3
 IRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769011318; x=1769616118;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cR5zNIGLc6jF31wai4UyLd4hZGb5cEinB/KIQx3lvoI=;
 b=n9BN/D90jjxC/WjDzR9LWOv7k0EzdBMLelmTj557FG0YjP89snQ5kcx35tadJEU5CP
 CIlRdidNEUYS0rTUwwDvKvOjmcAT7cCLfyQ965cs3xTweejZQ1YEiEjkzahiMUzPNXHn
 GygRws459ZB/ezQiqrugXjJnUxuyDrJi6LAnXge9mAqISBex9NEE55fHxMrfixxCNH4T
 C7nVPKeZXxRU44pOtFpZ6G5TZyO7Rwm1d/CQeMwYY6YKLvcBNS5Jpo26NCtIHHFNXgvR
 2GYh0VaP2ye1q4M5qS2AEyhVRg58xXbml3gZkds8I0JnrCfJgbRHH7a5WXT4JSPbVqmS
 gyhg==
X-Gm-Message-State: AOJu0YwUcp1uXY1sUzpj4hvqPGiJGSSMjze1C8EmIvCFs41HmZOClW7N
 hIuKM/1SYZX5MbU5FfJ2Kh1aH/zqqenTKpnw46BWZ/ttue3nWYaNAxJQ+0BiAjH+cLc=
X-Gm-Gg: AZuq6aL/0Srqx4eoJLeZy+6W5to0catvvuS5dLKrqG64YEdnhHZyAmoI39CSjhvQ48L
 ecLpOVKMw22/HOCSn3DGYq8qljD6VafR1j8ezeRmsgosQ5TS7VdrmZYImLmwJ9ViSe02M+OkHOK
 8K0FPiJnVRDFWcVQ2Zgl+ebjizFBI/D1WHUzl7rv0Bk6F5nG9bqjzRKR9YIH88fu+AghEk8uzb6
 Dx4+206K+wcOeXGn/Ixx/1GFhzICr/o80Ks/R7T+eboRh5k7bufbHBCreQV/XExScjMCffRQVfm
 7gr/wEZTJwkXp9d0698DR1a9nP65n7XkbDPnQC0CzYSEidXhyuxlgfTepJxxlR/L9B4mluXEZwU
 5iuu8K8gbaS4G9KerMmmnPcdBydfgi7KmSClUFFR3O4qWyeLWM342ohKj+ek6BQXnF+kclQRHXr
 f1rfCsTg20F60n
X-Received: by 2002:a05:600c:1c28:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-4801eb109e0mr247893785e9.28.1769011317611; 
 Wed, 21 Jan 2026 08:01:57 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43596291e0asm8772328f8f.15.2026.01.21.08.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 08:01:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C9F415FDE8;
 Wed, 21 Jan 2026 16:01:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ashish Anand <ashish.a6@samsung.com>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  qemu-arm@nongnu.org,
 saurabh@samsung.com,  vishwa.mg@samsung.com,  y.kaushal@samsung.com,
 ashish.anand202@gmail.com
Subject: Re: [PATCH v2] target/arm: Implement WFE, SEV and SEVONPEND for
 Cortex-M
In-Reply-To: <20260121132421.2220928-1-ashish.a6@samsung.com> (Ashish Anand's
 message of "Wed, 21 Jan 2026 18:54:21 +0530")
References: <CGME20260121132716epcas5p1cab4021fbcd469b95d13ef4b4adc757f@epcas5p1.samsung.com>
 <20260121132421.2220928-1-ashish.a6@samsung.com>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Wed, 21 Jan 2026 16:01:55 +0000
Message-ID: <875x8vosy4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ashish Anand <ashish.a6@samsung.com> writes:

> Currently, QEMU implements the 'Wait For Event' (WFE) instruction as a
> simple yield. This causes high host CPU usage because guest
> RTOS idle loops effectively become busy-wait loops.
>
> To improve efficiency, this patch transitions WFE to use the architectural
> 'Halt' state (EXCP_HLT) for M-profile CPUs. This allows the host thread
> to sleep when the guest is idle.
>
> To support this transition, we implement the full architectural behavior
> required for WFE, specifically the 'Event Register', 'SEVONPEND' logic,
> and 'R_BPBR' exception handling requirements defined in the ARM
> Architecture Reference Manual.
>
> This patch enables resource-efficient idle emulation for Cortex-M.
>
> Signed-off-by: Ashish Anand <ashish.a6@samsung.com>
> ---
> Changes in v2:
> 1. Added R_BPBR handling as required by the Armv8-M architecture.
> 2. Unified pending-state updates to detect interrupt transitions for SEVO=
NPEND.
> 3. Moved the Event Register to the top-level ARM CPU state, since it is
>    architecturally shared between A-profile and M-profile CPUs.
> 4. Updated migration handling to be profile-agnostic so the state can be
>    reused if A-profile WFE support is implemented in the future.=20
> 5. Added CONFIG_USER_ONLY handling for WFE/SEV and tightened profile chec=
ks.
> 6. Addressed review comments and fixes raised during v1 discussion.=20
>
> Link to v1 - https://lore.kernel.org/qemu-devel/20251223120012.541777-1-a=
shish.a6@samsung.com/
>
>
<snip>
>=20=20
> +    /*
> +     * The event register is shared by all ARM profiles (A/R/M),
> +     * so it is stored in the top-level CPU state.
> +     * WFE/SEV handling is currently implemented only for M-profile.
> +     */
> +    uint32_t event_register;
> +

Looking at the Arm ARM for armv8m it says:

  The Event register is a single-bit register for each PE in the system.
  Software cannot read, and cannot write to, the Event register directly.

So I wonder if this could simply be a bool - and in that case some of
the logic simplifies.

>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>=20=20
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 0befdb0b28..814a74745f 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -508,6 +508,24 @@ static const VMStateDescription vmstate_m_mve =3D {
>      },
>  };
>=20=20
> +static bool event_needed(void *opaque)
> +{
> +    ARMCPU *cpu =3D opaque;
> +    /* Only save the state if the event register is set (non-zero) */
> +    return cpu->env.event_register !=3D 0;
> +}
> +
> +static const VMStateDescription vmstate_event =3D {
> +    .name =3D "cpu/event",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D event_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT32(env.event_register, ARMCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_m =3D {
>      .name =3D "cpu/m",
>      .version_id =3D 4,
> @@ -1210,6 +1228,7 @@ const VMStateDescription vmstate_arm_cpu =3D {
>          &vmstate_wfxt_timer,
>          &vmstate_syndrome64,
>          &vmstate_pstate64,
> +        &vmstate_event,
>          NULL
>      }
>  };
> diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
> index 4636d1bc03..5a10a9fba3 100644
> --- a/target/arm/tcg/helper.h
> +++ b/target/arm/tcg/helper.h
> @@ -60,6 +60,7 @@ DEF_HELPER_1(yield, void, env)
>  DEF_HELPER_1(pre_hvc, void, env)
>  DEF_HELPER_2(pre_smc, void, env, i32)
>  DEF_HELPER_1(vesb, void, env)
> +DEF_HELPER_1(sev, void, env)
>=20=20
>  DEF_HELPER_3(cpsr_write, void, env, i32, i32)
>  DEF_HELPER_2(cpsr_write_eret, void, env, i32)
> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index 3fb24c7790..2a2224c996 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -962,7 +962,9 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t=
 lr, bool dotailchain,
>       * Now we've done everything that might cause a derived exception
>       * we can go ahead and activate whichever exception we're going to
>       * take (which might now be the derived exception).
> +     * Exception entry sets the event register (ARM ARM R_BPBR)
>       */
> +    env->event_register =3D 1;
>      armv7m_nvic_acknowledge_irq(env->nvic);
>=20=20
>      /* Switch to target security state -- must do this before writing SP=
SEL */
> @@ -1906,6 +1908,9 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>      /* Otherwise, we have a successful exception exit. */
>      arm_clear_exclusive(env);
>      arm_rebuild_hflags(env);
> +
> +    /* Exception return sets the event register (ARM ARM R_BPBR) */
> +    env->event_register =3D 1;
>      qemu_log_mask(CPU_LOG_INT, "...successful exception return\n");
>  }
>=20=20
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index 4fbd219555..9f385dae6d 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -469,16 +469,58 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeou=
t)
>  #endif
>  }
>=20=20
> +void HELPER(sev)(CPUARMState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +    CPU_FOREACH(cs) {
> +        ARMCPU *target_cpu =3D ARM_CPU(cs);
> +        if (arm_feature(&target_cpu->env, ARM_FEATURE_M)) {
> +            target_cpu->env.event_register =3D 1;
> +        }
> +        if (!qemu_cpu_is_self(cs)) {
> +            qemu_cpu_kick(cs);
> +        }
> +    }
> +}
> +
>  void HELPER(wfe)(CPUARMState *env)
>  {
> -    /* This is a hint instruction that is semantically different
> -     * from YIELD even though we currently implement it identically.
> -     * Don't actually halt the CPU, just yield back to top
> -     * level loop. This is not going into a "low power state"
> -     * (ie halting until some event occurs), so we never take
> -     * a configurable trap to a different exception level.
> +#ifdef CONFIG_USER_ONLY
> +    /*
> +     * WFE in the user-mode emulator is a NOP. Real-world user-mode code
> +     * shouldn't execute WFE, but if it does, we make it a NOP rather th=
an
> +     * aborting when we try to raise EXCP_HLT.
> +     */
> +    return;
> +#else
> +    /*
> +     * WFE (Wait For Event) is a hint instruction.
> +     * For Cortex-M (M-profile), we implement the strict architectural b=
ehavior:
> +     * 1. Check the Event Register (set by SEV or SEVONPEND).
> +     * 2. If set, clear it and continue (consume the event).
>       */
> -    HELPER(yield)(env);
> +    if (arm_feature(env, ARM_FEATURE_M)) {
> +        CPUState *cs =3D env_cpu(env);
> +
> +        if (env->event_register) {
> +            env->event_register =3D 0;
> +            return;
> +        }
> +
> +        cs->exception_index =3D EXCP_HLT;
> +        cs->halted =3D 1;
> +        cpu_loop_exit(cs);
> +    } else {
> +        /*
> +         * For A-profile and others, we rely on the existing "yield" beh=
avior.
> +         * Don't actually halt the CPU, just yield back to top
> +         * level loop. This is not going into a "low power state"
> +         * (ie halting until some event occurs), so we never take
> +         * a configurable trap to a different exception level
> +         */
> +        HELPER(yield)(env);
> +    }
> +#endif
>  }
>=20=20
>  void HELPER(yield)(CPUARMState *env)
> diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
> index 646c74929d..778fbf1627 100644
> --- a/target/arm/tcg/t16.decode
> +++ b/target/arm/tcg/t16.decode
> @@ -228,8 +228,9 @@ REVSH           1011 1010 11 ... ...            @rdm
>      WFE         1011 1111 0010 0000
>      WFI         1011 1111 0011 0000
>=20=20
> -    # TODO: Implement SEV, SEVL; may help SMP performance.
> -    # SEV       1011 1111 0100 0000
> +    # M-profile SEV is implemented.
> +    # TODO: Implement SEV for other profiles, and SEVL for all profiles;=
 may help SMP performance.
> +    SEV         1011 1111 0100 0000
>      # SEVL      1011 1111 0101 0000
>=20=20
>      # The canonical nop has the second nibble as 0000, but the whole of =
the
> diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
> index d327178829..49b8d0037e 100644
> --- a/target/arm/tcg/t32.decode
> +++ b/target/arm/tcg/t32.decode
> @@ -369,8 +369,9 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 .=
...      @rdm
>          WFE      1111 0011 1010 1111 1000 0000 0000 0010
>          WFI      1111 0011 1010 1111 1000 0000 0000 0011
>=20=20
> -        # TODO: Implement SEV, SEVL; may help SMP performance.
> -        # SEV    1111 0011 1010 1111 1000 0000 0000 0100
> +        # M-profile SEV is implemented.
> +        # TODO: Implement SEV for other profiles, and SEVL for all profi=
les; may help SMP performance.
> +        SEV      1111 0011 1010 1111 1000 0000 0000 0100
>          # SEVL   1111 0011 1010 1111 1000 0000 0000 0101
>=20=20
>          ESB      1111 0011 1010 1111 1000 0000 0001 0000
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 63735d9789..c90b0106f7 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -3241,14 +3241,30 @@ static bool trans_YIELD(DisasContext *s, arg_YIEL=
D *a)
>      return true;
>  }
>=20=20
> +static bool trans_SEV(DisasContext *s, arg_SEV *a)
> +{
> +    /*
> +     * Currently SEV is a NOP for non-M-profile and in user-mode emulati=
on.
> +     * For system-mode M-profile, it sets the event register.
> +     */
> +#ifndef CONFIG_USER_ONLY
> +    if (arm_dc_feature(s, ARM_FEATURE_M)) {
> +        gen_helper_sev(tcg_env);
> +    }
> +#endif
> +    return true;
> +}
> +
>  static bool trans_WFE(DisasContext *s, arg_WFE *a)
>  {
>      /*
>       * When running single-threaded TCG code, use the helper to ensure t=
hat
> -     * the next round-robin scheduled vCPU gets a crack.  In MTTCG mode =
we
> -     * just skip this instruction.  Currently the SEV/SEVL instructions,
> -     * which are *one* of many ways to wake the CPU from WFE, are not
> -     * implemented so we can't sleep like WFI does.
> +     * the next round-robin scheduled vCPU gets a crack.
> +     *
> +     * For Cortex-M, we implement the architectural WFE behavior (sleepi=
ng
> +     * until an event occurs or the Event Register is set).
> +     * For other profiles, we currently treat this as a NOP or yield,
> +     * to preserve existing performance characteristics.
>       */
>      if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
>          gen_update_pc(s, curr_insn_len(s));
> @@ -6807,6 +6823,11 @@ static void arm_tr_tb_stop(DisasContextBase *dcbas=
e, CPUState *cpu)
>              break;
>          case DISAS_WFE:
>              gen_helper_wfe(tcg_env);
> +            /*
> +             * The helper can return if the event register is set, so we
> +             * must go back to the main loop to check for events.
> +             */
> +            tcg_gen_exit_tb(NULL, 0);
>              break;
>          case DISAS_YIELD:
>              gen_helper_yield(tcg_env);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

