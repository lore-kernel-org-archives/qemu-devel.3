Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18ECC02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 12:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfesy-0002bu-Ie; Wed, 05 Feb 2025 07:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfesw-0002aZ-7D
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:52:06 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfest-00046M-KK
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:52:05 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaf60d85238so1065686166b.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 04:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738759921; x=1739364721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmlSxGRa2s4sSfRPMbq1Nbwh/C+SvwJJ9ldnNzwpwvQ=;
 b=SEZnNchoDG6xDeB1b6hZP0TcUR3k957jSlUA4DjrYL7xAxNrbaGUr6aWPLMO223efH
 pz36T3FZQHJq8ukk13VghfIiowKi+TAvxhwxgsHxwPaUefTIIpxkux+/Tz5ep8uL1yYU
 34Tr49nTHnnmJ+XljvJRbGyiE+42D2X5MBM/GBE7YrCcnKWKpMMsg6r4x1ZP4kFMMUDZ
 W6O8v6uyMB9XvEYn/kCeMIFkpL76Xf+NbQxoGW+4/s1/5p3iv0keKw6kXYuL+8ZkDblA
 hY8b8VQGc85gJ7yvE4CAAY7CS8wN0Vz7+CC0KaRNGcNceg7+p+hTqQNLbBOI2j83yG4q
 IKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738759921; x=1739364721;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xmlSxGRa2s4sSfRPMbq1Nbwh/C+SvwJJ9ldnNzwpwvQ=;
 b=iv2bimyn0xGYlhkOsYI1T8ZfPIKQpMt+IZ36lKwiuWeulTLYMDeeNNd3j6BMq8UnDx
 cpw5K/tAkyZPCRR4d5QzpPciVSlqBAHhZryJ9k8uHSNx0GnA0adz/BWaXNciscSaQsCO
 0WvCyDe3MQePvaQgxx6apsLnMNUrakT6AmWlASCGp+hRVB94spHBE7KP9p5ZuVQ0hNyI
 JT6WEqDCmJReOWMIxeag1v8ZTdajMHHV1GfLZCwbWA2vvguD/OQA8OzH13cQt4Bbz1Nv
 ugXpBsJyshaRZB6KHSGZCE1QVbB+4AmpYhyusRHYbqNBbLGMvHt11cmQ8f79HqZyGzBg
 G3Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT+L/7e7qV6ubu0apzBkS84CcvmoGqGWFwhERV0Cv6+n0HH5M25gxVEYlaqDz/VVnWoleGdsaQasQH@nongnu.org
X-Gm-Message-State: AOJu0YwTWqBh9MVNG0Baxi1TfmbZ9J7m66Z5DVLZLlhECgGWYujyzc0r
 QkhD1DqEHygvRrCpaBTiatHPEAuh0YrS1uy5MnKsEKXb5kMMI+TfTX9RsGXoQxo=
X-Gm-Gg: ASbGnctGbv6EG9KyC9pzyXVJ1YJQZqvSj3WG9LH998qEsSz9ilwqPZnHCbXSXGaMnCS
 c93o5p9e+hKKQnbxgxXHHWOEIYrRXL8nMf8payJg+4zx593e5bt7hqGF0XqPnao14Ni8fJlKD9O
 GuSadz/0Z2fwkujauVoMr7pX5heCKOAnsAP3RET4d9ik3t//966k9KXDWO424Dd6V0HNpGIrtL3
 VzDyZqTqpIW1Zt8MysQKJPwFNFIOm7XAGBazBwI1nYDH3jacFMc79Jw3nQZnw3/or+CI2IsvMRv
 MF1U//8SHRYwUsJe4Q==
X-Google-Smtp-Source: AGHT+IFZYAl5rPmxBu/7WF7Rw4sz5nICpEhkDL+ax2PkSTfYd79m6iocn7vG6e5ECsz5vdHGUEMNoA==
X-Received: by 2002:a17:907:72c4:b0:ab7:9a7:688e with SMTP id
 a640c23a62f3a-ab75e35dc28mr292675766b.45.1738759921205; 
 Wed, 05 Feb 2025 04:52:01 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcdf8529f1sm901051a12.1.2025.02.05.04.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 04:52:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E3245F90B;
 Wed,  5 Feb 2025 12:51:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 05/14] target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3
 be Monitor traps
In-Reply-To: <20250130182309.717346-6-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 30 Jan 2025 18:23:00 +0000")
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-6-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 05 Feb 2025 12:51:59 +0000
Message-ID: <874j18a70w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In system register access pseudocode the common pattern for
> AArch32 registers with access traps to EL3 is:
>
> at EL1 and EL2:
>   if HaveEL(EL3) && !ELUsingAArch32(EL3) && (SCR_EL3.TERR =3D=3D 1) then
>      AArch64.AArch32SystemAccessTrap(EL3, 0x03);
>   elsif HaveEL(EL3) && ELUsingAArch32(EL3) && (SCR.TERR =3D=3D 1) then
>      AArch32.TakeMonitorTrapException();
> at EL3:
>   if (PSTATE.M !=3D M32_Monitor) && (SCR.TERR =3D=3D 1) then
>      AArch32.TakeMonitorTrapException();

I was confused a little by my copy which was:

    elsif HaveEL(EL3) && !ELUsingAArch32(EL3) && SCR_EL3.TERR =3D=3D '1' th=
en
        if EL3SDDUndef() then
            UNDEFINED;
        else
            AArch64.AArch32SystemAccessTrap(EL3, 0x03);

But I think EL3SDDUndef() is always false for us as we don't have an
external debug interface.

>
> (taking as an example the ERRIDR access pseudocode).
>
> This implements the behaviour of (in this case) SCR.TERR that
> "Accesses to the specified registers from modes other than Monitor
> mode generate a Monitor Trap exception" and of SCR_EL3.TERR that
> "Accesses of the specified Error Record registers at EL2 and EL1
> are trapped to EL3, unless the instruction generates a higher
> priority exception".
>
> In QEMU we don't implement this pattern correctly in two ways:
>  * in access_check_cp_reg() we turn the CP_ACCESS_TRAP_EL3 into
>    an UNDEF, not a trap to Monitor mode
>  * in the access functions, we check trap bits like SCR.TERR
>    only when arm_current_el(env) < 3 -- this is correct for
>    AArch64 EL3, but misses the "trap non-Monitor-mode execution
>    at EL3 into Monitor mode" case for AArch32 EL3
>
> In this commit we fix the first of these two issues, by
> making access_check_cp_reg() handle CP_ACCESS_TRAP_EL3
> as a Monitor trap. This is a kind of exception that we haven't
> yet implemented(!), so we need a new EXCP_MON_TRAP for it.
>
> This diverges from the pseudocode approach, where every access check
> function explicitly checks for "if EL3 is AArch32" and takes a
> monitor trap; if we wanted to be closer to the pseudocode we could
> add a new CP_ACCESS_TRAP_MONITOR and make all the accessfns use it
> when appropriate.  But because there are no non-standard cases in the
> pseudocode (i.e.  where either it raises a Monitor trap that doesn't
> correspond to an AArch64 SystemAccessTrap or where it raises a
> SystemAccessTrap that doesn't correspond to a Monitor trap), handling
> this all in one place seems less likely to result in future bugs
> where we forgot again about this special case when writing an
> accessor.
>
> (The cc of stable here is because "hw/intc/arm_gicv3_cpuif: Don't
> downgrade monitor traps for AArch32 EL3" which is also cc:stable
> will implicitly use the new EXCP_MON_TRAP code path.)
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h           |  1 +
>  target/arm/helper.c        | 11 +++++++++++
>  target/arm/tcg/op_helper.c | 13 ++++++++++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 2213c277348..4cb672c120b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -62,6 +62,7 @@
>  #define EXCP_NMI            26
>  #define EXCP_VINMI          27
>  #define EXCP_VFNMI          28
> +#define EXCP_MON_TRAP       29   /* AArch32 trap to Monitor mode */
>  /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
>=20=20
>  #define ARMV7M_EXCP_RESET   1
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5d9eca35c04..c5cd27b249f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -9684,6 +9684,7 @@ void arm_log_exception(CPUState *cs)
>              [EXCP_NMI] =3D "NMI",
>              [EXCP_VINMI] =3D "Virtual IRQ NMI",
>              [EXCP_VFNMI] =3D "Virtual FIQ NMI",
> +            [EXCP_MON_TRAP] =3D "Monitor Trap",
>          };
>=20=20
>          if (idx >=3D 0 && idx < ARRAY_SIZE(excnames)) {
> @@ -10250,6 +10251,16 @@ static void arm_cpu_do_interrupt_aarch32(CPUStat=
e *cs)
>          mask =3D CPSR_A | CPSR_I | CPSR_F;
>          offset =3D 0;
>          break;
> +    case EXCP_MON_TRAP:
> +        new_mode =3D ARM_CPU_MODE_MON;
> +        addr =3D 0x04;
> +        mask =3D CPSR_A | CPSR_I | CPSR_F;
> +        if (env->thumb) {
> +            offset =3D 2;
> +        } else {
> +            offset =3D 4;
> +        }
> +        break;
>      default:
>          cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
>          return; /* Never happens.  Keep compiler happy.  */
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index 1161d301b71..1ba727e8e9f 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -758,6 +758,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *=
env, uint32_t key,
>      const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(cpu->cp_regs, key);
>      CPAccessResult res =3D CP_ACCESS_OK;
>      int target_el;
> +    uint32_t excp;
>=20=20
>      assert(ri !=3D NULL);
>=20=20
> @@ -851,8 +852,18 @@ const void *HELPER(access_check_cp_reg)(CPUARMState =
*env, uint32_t key,
>      }
>=20=20
>   fail:
> +    excp =3D EXCP_UDEF;
>      switch (res & ~CP_ACCESS_EL_MASK) {
>      case CP_ACCESS_TRAP:
> +        /*
> +         * If EL3 is AArch32 then there's no syndrome register; the cases
> +         * where we would raise a SystemAccessTrap to AArch64 EL3 all be=
come
> +         * raising a Monitor trap exception. (Because there's no visible
> +         * syndrome it doesn't matter what we pass to raise_exception().)
> +         */
> +        if ((res & CP_ACCESS_EL_MASK) =3D=3D 3 && !arm_el_is_aa64(env, 3=
)) {
> +            excp =3D EXCP_MON_TRAP;
> +        }
>          break;
>      case CP_ACCESS_TRAP_UNCATEGORIZED:
>          /* Only CP_ACCESS_TRAP traps are direct to a specified EL */
> @@ -888,7 +899,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *=
env, uint32_t key,
>          g_assert_not_reached();
>      }
>=20=20
> -    raise_exception(env, EXCP_UDEF, syndrome, target_el);
> +    raise_exception(env, excp, syndrome, target_el);
>  }
>=20=20
>  const void *HELPER(lookup_cp_reg)(CPUARMState *env, uint32_t key)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

