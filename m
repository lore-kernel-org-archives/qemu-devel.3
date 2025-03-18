Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540DDC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 18:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuc1j-0004U0-9M; Tue, 18 Mar 2025 14:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuc1d-0004St-TW
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:50:54 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuc1b-0002pQ-Be
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:50:53 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6e8f4c50a8fso48961816d6.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742323850; x=1742928650; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9irCSGUdnLqgoxQfoF+Ked8LnIJhdX5uZlhDcfZJ0f8=;
 b=dmY9HxKhiu8U9UjQls6VgH3f43Dyd8gFxWlHhAEjmpq0+PoTM0nbbMxBcclmE2cGvC
 QRDyD4B6I4jJFMuCfYc4kwPxoWTT+R+bah7SVMkUimjSzawSh7i4G8xNzF4TGoAuNp4d
 H1ZPTM0H09QrGnvWl0xGZ0wCuK72xcJVFPxav7B41vTuHxycy0RZ8MV1ftZ9jFSy3S1M
 74oVb6HTmIHpVhKIPvwEUzvLGkvaXFy3mM7dbhVJibFjj1K3AGuYZ8Lr3WwPJwN/HPeD
 2Rlqv2w5BKIstzEl+83ofh5nL6tJxROXqCE8HNPRtxkxszdXasnvfnNJdWSd4b/WkpNK
 e1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742323850; x=1742928650;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9irCSGUdnLqgoxQfoF+Ked8LnIJhdX5uZlhDcfZJ0f8=;
 b=p1T/oPFSKiMvb4ZPkRDi8UAR/WFWbuskAwOlI62sgaALKyQz9l//mikgvs4JMqoPJJ
 UHC4k7r5wttCtkLVa0ty9G7pEsZCFejzyf80tBsZSdpYE/nKIuYFeENpyZxRd65JWKgy
 +0swKLFF6plIrgaHnSl9if6qMLfbm6LK3RSJVW/CLWCv+Tv85ZdGHN6GtmkF6Wii8d65
 jmoYMpT9ChwkwMMFNHI/tN7oQcrCSqkAjCnuWlp8bj1+dPJL2CkqApd4fycLXOO1GSdB
 7h+978Gr0Dcqpih9n9JvJT8HDVLWAQU/3wNEJ+fCVRz72hDRClPYI3sWZ6BwtnhmKfky
 G9VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwUKD+Y93XGMn7wTS+Xky528PLBGs8xN+TygsRfWNZyfrTKcsYr4Au4/Yu0kFAf22HLuAdrRHW7KUU@nongnu.org
X-Gm-Message-State: AOJu0Yw9zVQhvl17rQ0PzWMrJTRSt8fI35mcsAl11Hb9ry8pbbFgkCNv
 hzWdLxjBWdrwSzlw8sRq6LVzjnzuTt3LTBZxMj9ryICYUZDsvJa+
X-Gm-Gg: ASbGncvpUAEPr+Ucd+wq+1hNVkMM0DXZgWXKTDt2Ny9M0j43I3rwgeIvOQ5w2f4ArOt
 fnw7jtAomIjFZXW0ga7zja1dkQdmmhUltBNFJrMO6JGPQtHgW5cyM04eooVE0cboCkT45iF5Tj2
 LA5SSzu6AhHohRnANPbjzK3+TBszG4nMXf6VYbgk0zKfsQlxvFKqONs7Nl7GusEqJ3fL0UkTAtV
 RbCiFOsDf3yQxwc3lcE2N3KSX5RPqYfeCzSQnm4L69YXYlQExpCgNm1726tjvbyPxZSUERkLAM9
 djcTm6AWvtPRJDOJr4RO4/SctixEzVKvI4UHF061uelzP/b0+DRdPt1irKTy3SE=
X-Google-Smtp-Source: AGHT+IH+zbP9Qt5mCAcKznFrbQ178S7mmPJSR+JZ+WEpxsgDbqGXFVdaY45L+3omYRL0QajNgAtWSg==
X-Received: by 2002:ad4:51ca:0:b0:6e8:9a55:8259 with SMTP id
 6a1803df08f44-6eaea9961efmr221225176d6.9.1742323849788; 
 Tue, 18 Mar 2025 11:50:49 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:6d71:de10:2e5e:506a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade35c793sm70418826d6.123.2025.03.18.11.50.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Mar 2025 11:50:49 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-31-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-31-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 30/39] target/hexagon: Add next_PC, {s,g}reg writes
Date: Tue, 18 Mar 2025 13:50:48 -0500
Message-ID: <024f01db9836$aab62000$00226000$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQJjV6aIsvCj2vA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250318-4, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf35.google.com
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
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 30/39] target/hexagon: Add next_PC, {s,g}reg writes
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h       |   2 +-
>  target/hexagon/translate.h |   2 +
>  target/hexagon/genptr.c    |   7 +-
>  target/hexagon/translate.c | 142 ++++++++++++++++++++++++++++++++-
> ----
>  4 files changed, 132 insertions(+), 21 deletions(-)
>=20
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
> 4667a1f748..73c3bb34b0 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -142,9 +142,9 @@ typedef struct CPUArchState {
>      hex_lock_state_t k0_lock_state;
>      target_ulong tlb_lock_count;
>      target_ulong k0_lock_count;
> -    target_ulong next_PC;
>      CPUHexagonTLBContext *hex_tlb;
>  #endif
> +    target_ulong next_PC;

You are moving this from system-mode only to unconditional.  There must =
be an earlier patch in this series that put it in system-mode.  Find =
that and remove it, so there is only a single addition.

Also, does this need to be part of the global state?  The answer is no =
if it doesn't live across packets.  If it is only used within the =
context of a single packet, you can just create a temporary TCGv in =
DisasContext.  There are several examples already.


>      target_ulong new_value_usr;
>=20
>      MemLog mem_log_stores[STORES_MAX];
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h =
index
> c9533fee1f..ad1a2f4045 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -85,6 +85,7 @@ typedef struct DisasContext {
>      TCGv dczero_addr;
>      bool pcycle_enabled;
>      bool pkt_ends_tb;
> +    bool need_next_pc;
>      uint32_t num_cycles;
>  } DisasContext;
>=20
> @@ -306,6 +307,7 @@ static inline void ctx_log_qreg_read(DisasContext
> *ctx,  }
>=20
>  extern TCGv hex_gpr[TOTAL_PER_THREAD_REGS];
> +extern TCGv hex_next_PC;
>  extern TCGv hex_pred[NUM_PREGS];
>  extern TCGv hex_slot_cancelled;
>  extern TCGv hex_new_value_usr;
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c index
> 5554c9515c..afc7e5f3a5 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -634,14 +634,15 @@ static void gen_write_new_pc_addr(DisasContext
> *ctx, TCGv addr,
>          tcg_gen_brcondi_tl(cond, pred, 0, pred_false);
>      }
>=20
> +    TCGv PC_wr =3D ctx->need_next_pc ? hex_next_PC :
> hex_gpr[HEX_REG_PC];
>      if (ctx->pkt->pkt_has_multi_cof) {
>          /* If there are multiple branches in a packet, ignore the =
second one */
> -        tcg_gen_movcond_tl(TCG_COND_NE, hex_gpr[HEX_REG_PC],
> +        tcg_gen_movcond_tl(TCG_COND_NE, PC_wr,
>                             ctx->branch_taken, tcg_constant_tl(0),
> -                           hex_gpr[HEX_REG_PC], addr);
> +                           PC_wr, addr);
>          tcg_gen_movi_tl(ctx->branch_taken, 1);
>      } else {
> -        tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], addr);
> +        tcg_gen_mov_tl(PC_wr, addr);
>      }
>=20
>      if (cond !=3D TCG_COND_ALWAYS) {
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c =
index
> 475726388a..d4b22acb72 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -49,6 +49,7 @@ static const AnalyzeInsn
> opcode_analyze[XX_LAST_OPCODE] =3D {  TCGv
> hex_gpr[TOTAL_PER_THREAD_REGS];  TCGv hex_pred[NUM_PREGS];  TCGv
> hex_slot_cancelled;
> +TCGv hex_next_PC;
>  TCGv hex_new_value_usr;
>  TCGv hex_store_addr[STORES_MAX];
>  TCGv hex_store_width[STORES_MAX];
> @@ -61,12 +62,14 @@ TCGv_i64 hex_cycle_count;  TCGv
> hex_vstore_addr[VSTORES_MAX];  TCGv hex_vstore_size[VSTORES_MAX];
> TCGv hex_vstore_pending[VSTORES_MAX];
> +static bool need_next_PC(DisasContext *ctx);

You don't need this.  The function definition is before any reference to =
it.

>=20
>  #ifndef CONFIG_USER_ONLY
>  TCGv hex_greg[NUM_GREGS];
>  TCGv hex_t_sreg[NUM_SREGS];
>  TCGv_ptr hex_g_sreg_ptr;
>  TCGv hex_g_sreg[NUM_SREGS];
> +TCGv hex_cause_code;

This doesn't belong in this patch.

>  #endif
>=20
>  static const char * const hexagon_prednames[] =3D { @@ -184,6 +187,9 =
@@
> static void gen_end_tb(DisasContext *ctx)
>=20
>      gen_exec_counters(ctx);
>=20
> +    if (ctx->need_next_pc) {
> +        tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], hex_next_PC);
> +    }
>      if (ctx->branch_cond !=3D TCG_COND_NEVER) {
>          if (ctx->branch_cond !=3D TCG_COND_ALWAYS) {
>              TCGLabel *skip =3D gen_new_label(); @@ -371,18 +377,24 @@ =
static
> bool pkt_ends_tb(Packet *pkt)  static bool need_next_PC(DisasContext
> *ctx)  {
>      Packet *pkt =3D ctx->pkt;
> -
> -    /* Check for conditional control flow or HW loop end */
> -    for (int i =3D 0; i < pkt->num_insns; i++) {
> -        uint16_t opcode =3D pkt->insn[i].opcode;
> -        if (GET_ATTRIB(opcode, A_CONDEXEC) && GET_ATTRIB(opcode,
> A_COF)) {
> -            return true;
> -        }
> -        if (GET_ATTRIB(opcode, A_HWLOOP0_END) ||
> -            GET_ATTRIB(opcode, A_HWLOOP1_END)) {
> -            return true;

Was this inserted by an earlier patch in this series?  If so, don't =
insert it before.  Just put the below code in this patch.

> +    if (pkt->pkt_has_cof || ctx->pkt_ends_tb) {
> +        for (int i =3D 0; i < pkt->num_insns; i++) {
> +            uint16_t opcode =3D pkt->insn[i].opcode;
> +            if ((GET_ATTRIB(opcode, A_CONDEXEC) && GET_ATTRIB(opcode,
> A_COF)) ||
> +                GET_ATTRIB(opcode, A_HWLOOP0_END) ||
> +                GET_ATTRIB(opcode, A_HWLOOP1_END)) {
> +                return true;
> +            }
>          }
>      }
> +    /*
> +     * We end the TB on some instructions that do not change the flow =
(for
> +     * other reasons). In these cases, we must set pc too, as the =
insn won't
> +     * do it themselves.
> +     */
> +    if (ctx->pkt_ends_tb && !check_for_attrib(pkt, A_COF)) {
> +        return true;
> +    }
>      return false;
>  }
>=20
> @@ -523,7 +535,14 @@ static void analyze_packet(DisasContext *ctx)  =
static
> void gen_start_packet(DisasContext *ctx)  {
>      Packet *pkt =3D ctx->pkt;
> +#ifndef CONFIG_USER_ONLY
> +    target_ulong next_PC =3D (check_for_opcode(pkt, Y2_k0lock) ||
> +                            check_for_opcode(pkt, Y2_tlblock)) ?

Should we also check for Y2_wait?

> +                               ctx->base.pc_next :
> +                               ctx->base.pc_next +
> +pkt->encod_pkt_size_in_bytes; #else
>      target_ulong next_PC =3D ctx->base.pc_next + pkt-
> >encod_pkt_size_in_bytes;
> +#endif

You don't need the #ifndef CONFIG_USER_ONLY here.  Note that the opcodes =
exist in linux-user mode as well as system mode.  So, you can just keep =
the first version.

Note that check_for_opcode is currently guarded by #ifndef =
CONFIG_USER_ONLY, but you can remove that.

>      int i;
>=20
>      /* Clear out the disassembly context */ @@ -531,6 +550,10 @@ =
static void
> gen_start_packet(DisasContext *ctx)
>      ctx->reg_log_idx =3D 0;
>      bitmap_zero(ctx->regs_written, TOTAL_PER_THREAD_REGS);
>      bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
> +#ifndef CONFIG_USER_ONLY
> +    ctx->greg_log_idx =3D 0;
> +    ctx->sreg_log_idx =3D 0;
> +#endif
>      ctx->preg_log_idx =3D 0;
>      bitmap_zero(ctx->pregs_written, NUM_PREGS);
>      ctx->future_vregs_idx =3D 0;
> @@ -563,21 +586,41 @@ static void gen_start_packet(DisasContext *ctx)
>       * gen phase, so clear it again.
>       */
>      bitmap_zero(ctx->pregs_written, NUM_PREGS);
> +#ifndef CONFIG_USER_ONLY
> +    for (i =3D 0; i < NUM_SREGS; i++) {
> +        ctx->t_sreg_new_value[i] =3D NULL;
> +    }
> +    for (i =3D 0; i < ctx->sreg_log_idx; i++) {
> +        int reg_num =3D ctx->sreg_log[i];
> +        if (reg_num < HEX_SREG_GLB_START) {
> +            ctx->t_sreg_new_value[reg_num] =3D tcg_temp_new();
> +            tcg_gen_mov_tl(ctx->t_sreg_new_value[reg_num],
> hex_t_sreg[reg_num]);
> +        }
> +    }
> +    for (i =3D 0; i < NUM_GREGS; i++) {
> +        ctx->greg_new_value[i] =3D NULL;
> +    }
> +    for (i =3D 0; i < ctx->greg_log_idx; i++) {
> +        int reg_num =3D ctx->greg_log[i];
> +        ctx->greg_new_value[reg_num] =3D tcg_temp_new();
> +    }
> +#endif
>=20
>      /* Initialize the runtime state for packet semantics */
>      if (need_slot_cancelled(pkt)) {
>          tcg_gen_movi_tl(hex_slot_cancelled, 0);
>      }
>      ctx->branch_taken =3D NULL;
> -    ctx->pkt_ends_tb =3D pkt_ends_tb(pkt);
>      if (pkt->pkt_has_cof) {
>          ctx->branch_taken =3D tcg_temp_new();
> -        if (pkt->pkt_has_multi_cof) {
> -            tcg_gen_movi_tl(ctx->branch_taken, 0);
> -        }
> -        if (need_next_PC(ctx)) {
> -            tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], next_PC);
> -        }
> +    }
> +    if (pkt->pkt_has_multi_cof) {
> +        tcg_gen_movi_tl(ctx->branch_taken, 0);
> +    }
> +    ctx->pkt_ends_tb =3D pkt_ends_tb(pkt);
> +    ctx->need_next_pc =3D need_next_PC(ctx);
> +    if (ctx->need_next_pc) {
> +        tcg_gen_movi_tl(hex_next_PC, next_PC);
>      }
>=20
>      /* Preload the predicated registers into get_result_gpr(ctx, i) =
*/ @@ -
> 713,6 +756,59 @@ static void gen_reg_writes(DisasContext *ctx)
>      }
>  }
>=20
> +#ifndef CONFIG_USER_ONLY
> +static void gen_greg_writes(DisasContext *ctx) {
> +    int i;
> +
> +    for (i =3D 0; i < ctx->greg_log_idx; i++) {
> +        int reg_num =3D ctx->greg_log[i];
> +
> +        tcg_gen_mov_tl(hex_greg[reg_num], ctx-
> >greg_new_value[reg_num]);
> +    }
> +}
> +
> +
> +static void gen_sreg_writes(DisasContext *ctx) {
> +    int i;
> +
> +    TCGv old_reg =3D tcg_temp_new();
> +    for (i =3D 0; i < ctx->sreg_log_idx; i++) {
> +        int reg_num =3D ctx->sreg_log[i];
> +
> +        if (reg_num =3D=3D HEX_SREG_SSR) {
> +            tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
> +            tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx-
> >t_sreg_new_value[reg_num]);
> +            gen_helper_modify_ssr(tcg_env, =
ctx->t_sreg_new_value[reg_num],
> +                                  old_reg);
> +            /* This can change processor state, so end the TB */
> +            ctx->base.is_jmp =3D DISAS_NORETURN;
> +        } else if ((reg_num =3D=3D HEX_SREG_STID) ||
> +                   (reg_num =3D=3D HEX_SREG_IMASK) ||
> +                   (reg_num =3D=3D HEX_SREG_IPENDAD)) {
> +            if (reg_num < HEX_SREG_GLB_START) {
> +                tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
> +                tcg_gen_mov_tl(hex_t_sreg[reg_num],
> +                               ctx->t_sreg_new_value[reg_num]);
> +            }
> +            /* This can change the interrupt state, so end the TB */
> +            gen_helper_pending_interrupt(tcg_env);
> +            ctx->base.is_jmp =3D DISAS_NORETURN;
> +        } else if ((reg_num =3D=3D HEX_SREG_BESTWAIT) ||
> +                   (reg_num =3D=3D HEX_SREG_SCHEDCFG)) {
> +            /* This can trigger resched interrupt, so end the TB */
> +            gen_helper_resched(tcg_env);
> +            ctx->base.is_jmp =3D DISAS_NORETURN;
> +        }
> +
> +        if (reg_num < HEX_SREG_GLB_START) {
> +            tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx-
> >t_sreg_new_value[reg_num]);
> +        }
> +    }
> +}
> +#endif
> +
>  static void gen_pred_writes(DisasContext *ctx)  {
>      /* Early exit if not needed or the log is empty */ @@ -1012,6 =
+1108,10 @@
> static void gen_commit_packet(DisasContext *ctx)
>      process_store_log(ctx);
>=20
>      gen_reg_writes(ctx);
> +#if !defined(CONFIG_USER_ONLY)
> +    gen_greg_writes(ctx);
> +    gen_sreg_writes(ctx);
> +#endif
>      gen_pred_writes(ctx);
>      if (pkt->pkt_has_hvx) {
>          gen_commit_hvx(ctx);
> @@ -1073,6 +1173,7 @@ static void
> hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>      ctx->is_tight_loop =3D FIELD_EX32(hex_flags, TB_FLAGS, =
IS_TIGHT_LOOP);
>      ctx->short_circuit =3D hex_cpu->short_circuit;
>      ctx->pcycle_enabled =3D FIELD_EX32(hex_flags, TB_FLAGS,
> PCYCLE_ENABLED);
> +    ctx->need_next_pc =3D false;

Don't need this because it is initialized in gen_start_packet.

>  }
>=20
>  static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu) =
@@
> -1201,6 +1302,13 @@ void hexagon_translate_init(void)
>          offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
>      hex_cycle_count =3D tcg_global_mem_new_i64(tcg_env,
>              offsetof(CPUHexagonState, t_cycle_count), =
"t_cycle_count");
> +#ifndef CONFIG_USER_ONLY
> +    hex_cause_code =3D tcg_global_mem_new(tcg_env,
> +        offsetof(CPUHexagonState, cause_code), "cause_code"); #endif

Doesn=E2=80=99t' belong in this patch

> +    hex_next_PC =3D tcg_global_mem_new(tcg_env,
> +        offsetof(CPUHexagonState, next_PC), "next_PC");
> +
>      for (i =3D 0; i < STORES_MAX; i++) {
>          snprintf(store_addr_names[i], NAME_LEN, "store_addr_%d", i);
>          hex_store_addr[i] =3D tcg_global_mem_new(tcg_env,
> --
> 2.34.1



