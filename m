Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2412FC27C7B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHP5a-0005lu-Iv; Wed, 12 Jun 2024 10:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHP5Z-0005l1-KV
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:36:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHP5X-0001Zb-OC
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:36:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42178999284so18656105e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718202994; x=1718807794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p488fM1XGPS9123fMBRB+L+yw1ITH2IAsaXEPgUcYbg=;
 b=PTLGAkpj6TSwxQGcDWUKCdpCk85zRdek1TRkE4HPlk2J6zTt6pF+/2Oa3XdXifEQ6K
 WL1/kgVS+fvLchO/3dD6hK9ujl0W+cWRmK0ho1Yrx5spNEW4K9++vRjy+lPSLYvBQGIb
 Z1jUFgNixE837ocfyfPKbfSCirJmDf7byjcgXxESsNoeQ5PXohPYb/vFFGxfjzbnJkRi
 y49hfWGhdVReSLCl7j4MrlY/uWu52vKLvbMdNTYf881mx3BbPztFhK++rTvL1kqGk2e0
 s5Um3y5dJgSgoo1zeO6fiTXzTkK35ziU9VWgb60hI/T/ZWv6HXm5CNStMraBf8ewREmE
 /SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718202994; x=1718807794;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p488fM1XGPS9123fMBRB+L+yw1ITH2IAsaXEPgUcYbg=;
 b=R/77UNdYPoESlvwuNN+MUd6Co51wcRJkOO0uTsx+RYha2lc53hF4rTcmw7Jf7guk60
 Q4IgMECbihSW65JI0TLr2xt7bQphz1uMtk7ekgof3RTqJBQACqKZ8ifXPpD0U/GAMWQi
 S9n6B+nfITAO+lHHZgHV7/wEgTuvJMVdi2ZCloPpG/43i+d8RFKZopcxJD8kiobOhEJ6
 GJTgas+fcQDeU4HYKJ3K/YJAcVtVJMHLf5BRUDPJBLJvgpcCVPhzSGDqhvyMTIG4Xsp0
 R3tDNfSLyBjDlrlBybP0Sz8rzYXVBPPm1T8ziS4Gvhm+E6GT0HMcDX2UU+K3JNbN7dht
 lPcA==
X-Gm-Message-State: AOJu0YzKAvMoGp8STzk4T3xJS+IJzEEL0D1XkunB73vaYpmvtgZZ8FhF
 XMJgzzp2vIqi6SVn8oKx1sknEyhMTT63eIOhe2NkN4MoN2VovEWieziRoACWd1s=
X-Google-Smtp-Source: AGHT+IHXAgfCVRLgc7CO5r29Fpjb3z5VbLF6APn42GDdy2GaGwhCWtC5+yT/yb9INxUg3j/0B3h9nw==
X-Received: by 2002:a05:600c:3328:b0:421:7f4d:525f with SMTP id
 5b1f17b1804b1-422863ad370mr15147445e9.24.1718202993795; 
 Wed, 12 Jun 2024 07:36:33 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874de68asm29466045e9.29.2024.06.12.07.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 07:36:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C43095F893;
 Wed, 12 Jun 2024 15:36:32 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 8/9] target/arm: Add aarch64_tcg_ops
In-Reply-To: <20240606032926.83599-9-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 5 Jun 2024 20:29:25 -0700")
References: <20240606032926.83599-1-richard.henderson@linaro.org>
 <20240606032926.83599-9-richard.henderson@linaro.org>
Date: Wed, 12 Jun 2024 15:36:32 +0100
Message-ID: <878qzaxm6n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> For the moment, this is an exact copy of arm_tcg_ops.
> Export arm_cpu_exec_interrupt for the cross-file reference.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h |  1 +
>  target/arm/cpu.c       |  2 +-
>  target/arm/cpu64.c     | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 11b5da2562..dc53d86249 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -364,6 +364,7 @@ void arm_restore_state_to_opc(CPUState *cs,
>=20=20
>  #ifdef CONFIG_TCG
>  void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *t=
b);
> +bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
>  #endif /* CONFIG_TCG */
>=20=20
>  typedef enum ARMFPRounding {
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 35fa281f1b..3cd4711064 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -824,7 +824,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, un=
signed int excp_idx,
>      return unmasked || pstate_unmasked;
>  }
>=20=20
> -static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> +bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  {
>      CPUClass *cc =3D CPU_GET_CLASS(cs);
>      CPUARMState *env =3D cpu_env(cs);
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 262a1d6c0b..7ba80099af 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -31,6 +31,9 @@
>  #include "hvf_arm.h"
>  #include "qapi/visitor.h"
>  #include "hw/qdev-properties.h"
> +#ifdef CONFIG_TCG
> +#include "hw/core/tcg-cpu-ops.h"
> +#endif
>  #include "internals.h"
>  #include "cpu-features.h"
>  #include "cpregs.h"
> @@ -793,6 +796,29 @@ static const gchar *aarch64_gdb_arch_name(CPUState *=
cs)
>      return "aarch64";
>  }
>=20=20
> +#ifdef CONFIG_TCG
> +static const TCGCPUOps aarch64_tcg_ops =3D {
> +    .initialize =3D arm_translate_init,
> +    .synchronize_from_tb =3D arm_cpu_synchronize_from_tb,
> +    .debug_excp_handler =3D arm_debug_excp_handler,
> +    .restore_state_to_opc =3D arm_restore_state_to_opc,
> +
> +#ifdef CONFIG_USER_ONLY
> +    .record_sigsegv =3D arm_cpu_record_sigsegv,
> +    .record_sigbus =3D arm_cpu_record_sigbus,
> +#else
> +    .tlb_fill =3D arm_cpu_tlb_fill,
> +    .cpu_exec_interrupt =3D arm_cpu_exec_interrupt,
> +    .do_interrupt =3D arm_cpu_do_interrupt,
> +    .do_transaction_failed =3D arm_cpu_do_transaction_failed,
> +    .do_unaligned_access =3D arm_cpu_do_unaligned_access,
> +    .adjust_watchpoint_address =3D arm_adjust_watchpoint_address,
> +    .debug_check_watchpoint =3D arm_debug_check_watchpoint,
> +    .debug_check_breakpoint =3D arm_debug_check_breakpoint,
> +#endif /* !CONFIG_USER_ONLY */
> +};
> +#endif /* CONFIG_TCG */
> +

My principle concern is duplicating an otherwise identical structure
just gives us more opportunity to miss a change.=20

>  static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
>  {
>      CPUClass *cc =3D CPU_CLASS(oc);
> @@ -802,6 +828,10 @@ static void aarch64_cpu_class_init(ObjectClass *oc, =
void *data)
>      cc->gdb_core_xml_file =3D "aarch64-core.xml";
>      cc->gdb_arch_name =3D aarch64_gdb_arch_name;
>=20=20
> +#ifdef CONFIG_TCG
> +    cc->tcg_ops =3D &aarch64_tcg_ops;
> +#endif
> +

What happens when the CPU is running mixed mode code and jumping between
64 and 32 bit? Wouldn't it be easier to have a helper that routes to the
correct unwinder, c.f. gen_intermediate_code

  #ifdef TARGET_AARCH64
      if (EX_TBFLAG_ANY(tb_flags, AARCH64_STATE)) {
          ops =3D &aarch64_translator_ops;
      }
  #endif

which I guess for a runtime helper would be:

   if (is_a64(cpu_env(cs))) {
      aarch64_plugin_need_unwind_for_reg(...);
   } else {
      arm_plugin_need_unwind_for_reg(...);
   }


etc...


>      object_class_property_add_bool(oc, "aarch64", aarch64_cpu_get_aarch6=
4,
>                                     aarch64_cpu_set_aarch64);
>      object_class_property_set_description(oc, "aarch64",

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

