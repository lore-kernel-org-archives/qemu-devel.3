Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BE7C35FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 19:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuzR7-00037y-Ey; Wed, 19 Mar 2025 15:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuzR4-00037i-Sr
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:50:43 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuzR0-0004i8-2n
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:50:42 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-46fa764aac2so710161cf.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742413836; x=1743018636; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=e7H1GyfTo/W31LWsyRdw17EMM8Hl5xk2Kg349G3osuI=;
 b=dKFvYHxv3NS45W2mgcjSliEJWPTdRWw2WBKGe4bqiYyBWEpIZmbYtm3Kd9RqAGvgIK
 uJFXU+fkHv0q4WW5DHTvOEc8ObGMM5wFd7mV1MtgoS0ykeMM1tZFdUbnbqbf9PrTEtGj
 2ctcgxWF06eZr03cMJLFtH2UoHQZir17lL9EqFjQvR0YGIDcPVYPWyYvq/meGUdojvxC
 tjrQcjsL6SJZaOZDDKGDzp3IHdX+vDTMtTqIgP/XxPp+Ey9kUkeUncn4pE0BhaXK5bxL
 phqxgNiq+Ft+I/evqkfw80yrTHSc2FZe4dG+mXFBEL4uzP43QGAq/p/qHQ8EoGrJUokN
 wmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742413836; x=1743018636;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e7H1GyfTo/W31LWsyRdw17EMM8Hl5xk2Kg349G3osuI=;
 b=AjokAszwEDzjtzyWmpAE6fmACaGH/bPgT5BqP+FBwpXRJmaB6FlphlfXQXUscy8+5d
 giQvMAUXpu+q/wRtEnwSTrLrrp6kpa44EiMgKOtm1CT+MKz0bBokC29XjdLottsFRtHN
 cGOlJfb2cwoD5egGmC4d0QmJNXOEsTKrpYqcOiaWzuXrWPYCWc6zajhO1YqgE9NWpYbK
 AUgXO1/Wfmg2zqNB2hT5msMAT+nG7+dYMl8xIX9zp1MO/X7qFF8fgImn+/sUlY4kYiex
 a1k3QTMqzHTr01Itlbq1hlyDPHoC+fI9JEuhqrMvXjsB06GyPgaBy/DBGlHarWBo4NfQ
 TDMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMmTy8WN7Lr3JKl+88yGCawWclUJrP/vmQRJlwjl4sznXBCVtPIBfcKQxqD/iGdRdVot7NiHeo9QD6@nongnu.org
X-Gm-Message-State: AOJu0YxuTLJJtZsbMZ6wa9uHHBQUYC+VgFuVPnBI2+ALQdqxL6iJKoRt
 F5t2kTGwTQqDbvngCDosGLyNDenUw1GJaoWGTU1zQWcm/JNv4pGc
X-Gm-Gg: ASbGncsT+RlyTDJt8Je+HZGb26FmPEB9AlZ7hEyiEE5O7K1AZCS/m1qL1TTUTuRXnCk
 DBnj9/4NAzXoj2iZXPARkI+MQDXcPOXT4JQYaw3pH6tPBZbNy2TMg21+Gt/KEvO1DOuS7CHuhNi
 VyH7nQtohPtQW0rw8ZMXlZhZkbMpGm/U/vREQyyAVnAT2tGyN77ScNns98XsU6NQaIJfLRcfWDV
 ddrWeXC7F0zQwHIo98r4XodT+cxXuEkyXXjgzAli6t6kynTMX0C5QlI7+eXL+omO/rYzxa1fedR
 wHc7BarcqUVvB3NIpD8bRtJGTpEPhawtKKefZLxIAyB9E0DRW4Z4mp5314Aa5iT7uXHPvg3H
X-Google-Smtp-Source: AGHT+IGznDbyrZXPWuz6CptRjRhT+87DMlrW7c7AWFKn3dIxskzm4Up48Tgw6jwnxDgj5/sRrquOCg==
X-Received: by 2002:a05:6214:cc7:b0:6d9:3016:d101 with SMTP id
 6a1803df08f44-6eb29445c73mr47343406d6.41.1742413836124; 
 Wed, 19 Mar 2025 12:50:36 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade24ea6esm83565506d6.52.2025.03.19.12.50.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 12:50:35 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-13-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-13-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 12/39] target/hexagon: Add implementation of cycle counters
Date: Wed, 19 Mar 2025 14:50:34 -0500
Message-ID: <02d401db9908$2e3d77d0$8ab86770$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQGsv4sNsvf2T8A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 12/39] target/hexagon: Add implementation of cycle
> counters
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h        | 25 ++++++++++++++++++++++---
>  target/hexagon/translate.h  |  2 ++
>  target/hexagon/cpu_helper.c | 12 +++++++++---
> target/hexagon/translate.c  | 27 +++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
> 4b9c9873dc..7e2ea838c5 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -27,11 +27,15 @@
>=20
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
> +#include "exec/cpu-common.h"
>  #include "hex_regs.h"
>  #include "mmvec/mmvec.h"
>  #include "hw/registerfields.h"
>=20
> +#ifndef CONFIG_USER_ONLY
> +#include "reg_fields.h"
>  typedef struct CPUHexagonTLBContext CPUHexagonTLBContext;
> +#endif

Why is reg_fields.h guarded by #ifndef CONFIG_USER_ONLY?

Also, why wasn't the CPUHexagonTLBContext guarded when it was first =
inserted?

>=20
>  #define NUM_PREGS 4
>  #define TOTAL_PER_THREAD_REGS 64
> @@ -188,6 +192,7 @@ struct ArchCPU {
>=20
>  FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
>  FIELD(TB_FLAGS, MMU_INDEX, 1, 3)
> +FIELD(TB_FLAGS, PCYCLE_ENABLED, 4, 1)
>=20
>  G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
>                                              uint32_t exception, @@ =
-201,6 +206,11 @@ void
> hexagon_cpu_soft_reset(CPUHexagonState *env);  #endif
>=20
>  #include "exec/cpu-all.h"
> +
> +#ifndef CONFIG_USER_ONLY
> +#include "cpu_helper.h"
> +#endif
> +
>  static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr =
*pc,
>                                          uint64_t *cs_base, uint32_t =
*flags)  { @@ -210,16
> +220,27 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState
> *env, vaddr *pc,
>      if (*pc =3D=3D env->gpr[HEX_REG_SA0]) {
>          hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, =
1);
>      }
> -    *flags =3D hex_flags;
>      if (*pc & PCALIGN_MASK) {
>          hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, =
0);
>      }
>  #ifndef CONFIG_USER_ONLY
> +    target_ulong syscfg =3D arch_get_system_reg(env, =
HEX_SREG_SYSCFG);
> +
> +    bool pcycle_enabled =3D extract32(syscfg,
> +                                    =
reg_field_info[SYSCFG_PCYCLEEN].offset,
> +
> + reg_field_info[SYSCFG_PCYCLEEN].width);
> +
>      hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
>                             cpu_mmu_index(env_cpu(env), false));
> +
> +    if (pcycle_enabled) {
> +        hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, =
1);
> +    }
>  #else
> +    hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, =
true);

Are pcycles exposed in linux-user mode?  If not, make this flag =
system-mode only.=20

>      hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
> MMU_USER_IDX);  #endif
> +    *flags =3D hex_flags;
>  }
>=20
>  typedef HexagonCPU ArchCPU;
> @@ -228,6 +249,4 @@ void hexagon_translate_init(void);  void
> hexagon_translate_code(CPUState *cs, TranslationBlock *tb,
>                              int *max_insns, vaddr pc, void *host_pc);
>=20
> -#include "exec/cpu-all.h"
> -
>  #endif /* HEXAGON_CPU_H */
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h =
index
> 0eaa3db03e..9bc4b3ce8b 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -83,6 +83,8 @@ typedef struct DisasContext {
>      TCGv new_pred_value[NUM_PREGS];
>      TCGv branch_taken;
>      TCGv dczero_addr;
> +    bool pcycle_enabled;

Guard with #ifndef CONFIG_USER_ONLY

> +    uint32_t num_cycles;
>  } DisasContext;
>=20
>  bool is_gather_store_insn(DisasContext *ctx); diff --git
> a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c index
> 0b0802bfb9..1d9b9f8bef 100644
> --- a/target/hexagon/cpu_helper.c
> +++ b/target/hexagon/cpu_helper.c
> @@ -48,17 +48,23 @@ uint32_t arch_get_system_reg(CPUHexagonState
> *env, uint32_t reg)
>=20
>  uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env)  {
> -    g_assert_not_reached();

Do we need a lock here?

> +    uint64_t cycles =3D 0;
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {
> +        CPUHexagonState *env_ =3D cpu_env(cs);
> +        cycles +=3D env_->t_cycle_count;
> +    }
> +    return *(env->g_pcycle_base) + cycles;
>  }
>=20
>  uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env)  {
> -    g_assert_not_reached();
> +    return hexagon_get_sys_pcycle_count(env) >> 32;
>  }
>=20
>  uint32_t hexagon_get_sys_pcycle_count_low(CPUHexagonState *env)  {
> -    g_assert_not_reached();
> +    return extract64(hexagon_get_sys_pcycle_count(env), 0, 32);
>  }
>=20
>  void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, diff =
--git
> a/target/hexagon/translate.c b/target/hexagon/translate.c index
> 9119e42ff7..060df6e5eb 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -57,6 +57,7 @@ TCGv_i64 hex_store_val64[STORES_MAX];  TCGv
> hex_llsc_addr;  TCGv hex_llsc_val;
>  TCGv_i64 hex_llsc_val_i64;
> +TCGv_i64 hex_cycle_count;

Guard with #ifndef CONFIG_USER_ONLY

>  TCGv hex_vstore_addr[VSTORES_MAX];
>  TCGv hex_vstore_size[VSTORES_MAX];
>  TCGv hex_vstore_pending[VSTORES_MAX];
> @@ -125,6 +126,22 @@ static void gen_exception_raw(int excp)
>      gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));  }
>=20
> +#ifndef CONFIG_USER_ONLY
> +static inline void gen_precise_exception(int excp, target_ulong PC) {
> +    tcg_gen_movi_tl(hex_cause_code, excp);
> +    gen_exception(HEX_EVENT_PRECISE, PC); }

Belongs in a different patch.

> +
> +static inline void gen_pcycle_counters(DisasContext *ctx) {
> +    if (ctx->pcycle_enabled) {
> +        tcg_gen_addi_i64(hex_cycle_count, hex_cycle_count, ctx-
> >num_cycles);
> +        ctx->num_cycles =3D 0;
> +    }
> +}
> +#endif
> +
>  static void gen_exec_counters(DisasContext *ctx)  {
>      tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_PKT_CNT],
> @@ -133,6 +150,10 @@ static void gen_exec_counters(DisasContext *ctx)
>                      hex_gpr[HEX_REG_QEMU_INSN_CNT], ctx->num_insns);
>      tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_HVX_CNT],
>                      hex_gpr[HEX_REG_QEMU_HVX_CNT], =
ctx->num_hvx_insns);
> +
> +#ifndef CONFIG_USER_ONLY
> +   gen_pcycle_counters(ctx);
> +#endif
>  }
>=20
>  static bool use_goto_tb(DisasContext *ctx, target_ulong dest) @@ =
-785,6
> +806,7 @@ static void gen_commit_hvx(DisasContext *ctx)
>      }
>  }
>=20
> +static const int PCYCLES_PER_PACKET =3D 3;
>  static void update_exec_counters(DisasContext *ctx)  {
>      Packet *pkt =3D ctx->pkt;
> @@ -804,6 +826,7 @@ static void update_exec_counters(DisasContext =
*ctx)
>      }
>=20
>      ctx->num_packets++;
> +    ctx->num_cycles +=3D PCYCLES_PER_PACKET;

Guard

>      ctx->num_insns +=3D num_real_insns;
>      ctx->num_hvx_insns +=3D num_hvx_insns;  } @@ -946,11 +969,13 @@ =
static
> void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>=20
>      ctx->mem_idx =3D FIELD_EX32(hex_flags, TB_FLAGS, MMU_INDEX);
>      ctx->num_packets =3D 0;
> +    ctx->num_cycles =3D 0;

Guard

>      ctx->num_insns =3D 0;
>      ctx->num_hvx_insns =3D 0;
>      ctx->branch_cond =3D TCG_COND_NEVER;
>      ctx->is_tight_loop =3D FIELD_EX32(hex_flags, TB_FLAGS, =
IS_TIGHT_LOOP);
>      ctx->short_circuit =3D hex_cpu->short_circuit;
> +    ctx->pcycle_enabled =3D FIELD_EX32(hex_flags, TB_FLAGS,
> + PCYCLE_ENABLED);

Guard

>  }
>=20
>  static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu) =
@@
> -1077,6 +1102,8 @@ void hexagon_translate_init(void)
>          offsetof(CPUHexagonState, llsc_val), "llsc_val");
>      hex_llsc_val_i64 =3D tcg_global_mem_new_i64(tcg_env,
>          offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
> +    hex_cycle_count =3D tcg_global_mem_new_i64(tcg_env,
> +            offsetof(CPUHexagonState, t_cycle_count), =
"t_cycle_count");

Guard

>      for (i =3D 0; i < STORES_MAX; i++) {
>          snprintf(store_addr_names[i], NAME_LEN, "store_addr_%d", i);
>          hex_store_addr[i] =3D tcg_global_mem_new(tcg_env,
> --
> 2.34.1



