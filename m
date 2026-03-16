Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667F3F53D76
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2BWp-0002aU-QD; Mon, 16 Mar 2026 13:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2BWm-0002Y6-Hj
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:14:52 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2BWk-0007k6-1p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:14:52 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c739d32b72cso3362912a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 10:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681287; cv=none;
 d=google.com; s=arc-20240605;
 b=JZtrB6Kun6lcNxV7j9NHUyDEwI+3DJoHGtiUYs2ESKCF/U1V4IKKruxl9XqSpNZzEL
 rilMqcaL1C3+aypR4RdH5kECG/4Id548H4fnFiapGx2KRpHEpQGFcz5n0DFHnFby86k2
 4Cmk+Utt0YlmnWKgAF0Kb4+LnOuwU3XMTSNFiahgeiM7nMylYsZSOwBeMpYNrJLADiNF
 LXAsIXRjI0DOtmhrhRvbm9Ri7JngLjdVlTDiM8AydiJY27r9y/6Wcl0w0jGqyOHsfwO4
 UGVWcMsXP4suGoi+EtjFXpB/bYriZbEGQlrrLoOxYCYal3DdTi1YxGFgcqVEYFaRcGQe
 T4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z1qZPtyrEjUlssrZdgg6itmaQ9RSxaBW49XVYfbw72s=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=i+vOb/wRN3yWTCZEZkOVUp5AR8HXCAFjOM2AQ0YMiTFlS2qFnr/2obSR4SpjmCiV6f
 Oa5uVcD9HZZCATl281sRMX0gsAfcNj9tMTPAMI298U01JYQKJbExaRwtCq8wEkus4HX6
 9hOaUGX/ybMVHmRjAog0ZMdETBtbZxGUnuA0Yi9XL9/KkiKbrvrz1w9fpJ/CqRz2uPGh
 Euv5Kv3zTmJzw8US4UyhOuMHsfbLrh/fsGpssMmzuPgE9Ta3qmOZnyreBOQnHVe6IbXZ
 /LEFcK3/f7bkksUm1GjozanrVxK04MOMXeS3Gr6C0BlTMncEc3JvL5xx39tU4zOcpdvP
 Z6gQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773681287; x=1774286087; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z1qZPtyrEjUlssrZdgg6itmaQ9RSxaBW49XVYfbw72s=;
 b=nqHR9edbEgHRG7Q8SNO1n0wZMgbYG0eoyNm/OcrzGQ3Id7143oGU6OPV6y9y2ENFoU
 InQBsk9DCpAci5xRdTzXmbtktn1nl/6fkyA9wxitB1k+RMGGIcmuCyi5G0QQ1Czwzyqc
 gvaFbvP0U8MAvn8XxP8siddKihoQh3CapfUdh0lR5+gubFxrISMmt0BG5vnw3Y9aMjAj
 SY7JZfO7ZypTRGcDOdL9o83pyIBUh8apy9xvsx2N1LoTFM3OFqBK3mGRpb4zDekuecTz
 stQocxR/SvVpXWWIo7Yl6ca7y4T7Do80ztGytnrFcozKhinkb8SY7Y9pc1Bxq9svR/5R
 pmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773681287; x=1774286087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1qZPtyrEjUlssrZdgg6itmaQ9RSxaBW49XVYfbw72s=;
 b=tCqyvI6Drc3Dq7AquI+UC3rR7u+8GPm0YWqjgrMDfxJ1w0csbKuSKDEueuUZ5Q/t/J
 7n+YbtxK3y4zfCMV68p0MJbiFB05vD0vJVe8aBWFer6wkuHwUYsLVOLHa5tsgu38lFoN
 knzcVX6LEhTehi8nol03OuCsCratvbhw/MhjC0AzZpZE1IOVmXQeuq0GainxrWSFyNDZ
 VN9nNszJ+SWkUtpJYMR5w+qZxdpLMvO1SHwxgM/URq4Dyl/XH+KsyAGP6Eu7r3aA/Ezy
 YDKwy7RnKeGSQVzSOFrerw0Oc37pX+i+aL4xilMNuJM2QS9OtCDnRpaoytVFHGxlFO13
 tHxg==
X-Gm-Message-State: AOJu0Ywcxmrn5+uWZBuZ8AR8Sz3CoiaXvt3J7B1Zwy1Aryqy9ZmJ5pC2
 +m5CngmAZk0svycPeRcFgnP79cBlKSKNZwj/3CLTCV+s3rKjPCPp6jVKpfc9t3fdaeamxntRBx9
 FCB/Mwy/wuptVdKJ/ft+F4P9VApElw0JPgags
X-Gm-Gg: ATEYQzzq9GIE/5WwsEEWzkCT/Qmne2zL0xR3QuWZfWWG4XgMPgrUd9ONEsU7xX2GvCQ
 o7M9WXWpxqGfgyZTjyr5IGd1y7WkLxwVdzMv16CdbWWx0ALJU3QgiPAIOtBT2ELPWB2nr0LcBcO
 4UEWZcPIgNjL4f7Pw7RNAhp6ZjiAwtB7WRpzcH3BoMdpykVBjbpHef+fK8/sbXlkIS0bYNLHXq5
 F8JLbgPAocEOGWGrO0U/bMJwJaEfiCNaTNsP0RrfbpCONFSqCBPwXg9ZGpsbaOtfbhZC8gzmxvT
 tsYey2JdBBk1y78CuqN/quEWdMJ9feJalxL0mw==
X-Received: by 2002:a05:6a21:7106:b0:398:7946:b70d with SMTP id
 adf61e73a8af0-398ecd617a1mr11996658637.51.1773681286650; Mon, 16 Mar 2026
 10:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-25-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-25-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 11:14:34 -0600
X-Gm-Features: AaiRm501x8nR_g1zaPk9Z9vOLaggefKfqGMTwFPMzvr-oJLQAOBve3HIv3pY-J0
Message-ID: <CAATN3NrZZ0biDFZ3QE94d+ro44bXZp0F+qbFCBpLds2Uv+CkCA@mail.gmail.com>
Subject: Re: [PATCH v3 24/32] target/hexagon: Add next_PC, {s,g}reg writes
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000092047064d275bbb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000092047064d275bbb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.c | 89 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 85 insertions(+), 4 deletions(-)
>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 953b34b7891..79027e8a327 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -552,6 +552,10 @@ static void gen_start_packet(DisasContext *ctx)
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
> @@ -584,6 +588,25 @@ static void gen_start_packet(DisasContext *ctx)
>       * gen phase, so clear it again.
>       */
>      bitmap_zero(ctx->pregs_written, NUM_PREGS);
> +#ifndef CONFIG_USER_ONLY
> +    for (i =3D 0; i < NUM_SREGS; i++) {
>

Use HEX_SREG_GLB_START instead of NUM_SREGS.
Also, size the t_sreg_new_value array with HEX_SREG_GLB_START.


> +        ctx->t_sreg_new_value[i] =3D NULL;
> +    }
> +    for (i =3D 0; i < ctx->sreg_log_idx; i++) {
> +        int reg_num =3D ctx->sreg_log[i];
> +        if (reg_num < HEX_SREG_GLB_START) {
> +            ctx->t_sreg_new_value[reg_num] =3D tcg_temp_new();
> +            tcg_gen_mov_tl(ctx->t_sreg_new_value[reg_num],
> hex_t_sreg[reg_num]);
>

You only need this assignment if the writes can be predicated.


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
>
>      /* Initialize the runtime state for packet semantics */
>      if (need_slot_cancelled(pkt)) {
> @@ -744,6 +767,60 @@ static void gen_reg_writes(DisasContext *ctx)
>      }
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +static void gen_greg_writes(DisasContext *ctx)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ctx->greg_log_idx; i++) {
> +        int reg_num =3D ctx->greg_log[i];
> +
> +        tcg_gen_mov_tl(hex_greg[reg_num], ctx->greg_new_value[reg_num]);
> +    }
> +}
> +
> +
> +static void gen_sreg_writes(DisasContext *ctx)
> +{
> +    int i;
> +
> +    TCGv_i32 old_reg =3D tcg_temp_new_i32();
> +    for (i =3D 0; i < ctx->sreg_log_idx; i++) {
> +        int reg_num =3D ctx->sreg_log[i];
> +
> +        if (reg_num =3D=3D HEX_SREG_SSR) {
> +            tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
> +            tcg_gen_mov_tl(hex_t_sreg[reg_num],
> ctx->t_sreg_new_value[reg_num]);
> +            gen_helper_modify_ssr(tcg_env, ctx->t_sreg_new_value[reg_num=
],
> +                                  old_reg);
> +            /* This can change processor state, so end the TB */
> +            ctx->base.is_jmp =3D DISAS_NORETURN;
>

Isn't this taken care of in pkt_ends_tb from earlier patch?


> +            continue;
> +        } else if ((reg_num =3D=3D HEX_SREG_STID) ||
> +                   (reg_num =3D=3D HEX_SREG_IMASK) ||
> +                   (reg_num =3D=3D HEX_SREG_IPENDAD)) {
> +            if (reg_num < HEX_SREG_GLB_START) {
> +                tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
>

Don't need to set old_reg here


> +                tcg_gen_mov_tl(hex_t_sreg[reg_num],
> +                               ctx->t_sreg_new_value[reg_num]);
> +            }
> +            /* This can change the interrupt state, so end the TB */
> +            gen_helper_pending_interrupt(tcg_env);
> +            ctx->base.is_jmp =3D DISAS_NORETURN;
>

Already taken care of.


> +        } else if ((reg_num =3D=3D HEX_SREG_BESTWAIT) ||
> +                   (reg_num =3D=3D HEX_SREG_SCHEDCFG)) {
> +            /* This can trigger resched interrupt, so end the TB */
> +            gen_helper_resched(tcg_env);
> +            ctx->base.is_jmp =3D DISAS_NORETURN;
>

Already taken care of.


> +        }
> +
> +        if (reg_num < HEX_SREG_GLB_START) {
> +            tcg_gen_mov_tl(hex_t_sreg[reg_num],
> ctx->t_sreg_new_value[reg_num]);
> +        }
>

Put this under an else as we've already done the assignment for specific
cases above


> +    }
> +}
> +#endif
> +
>  static void gen_pred_writes(DisasContext *ctx)
>  {
>      /* Early exit if not needed or the log is empty */
> @@ -1044,6 +1121,10 @@ static void gen_commit_packet(DisasContext *ctx)
>      process_store_log(ctx);
>
>      gen_reg_writes(ctx);
> +#if !defined(CONFIG_USER_ONLY)
> +    gen_greg_writes(ctx);
> +    gen_sreg_writes(ctx);
> +#endif
>      gen_pred_writes(ctx);
>      if (pkt->pkt_has_hvx) {
>          gen_commit_hvx(ctx);
> @@ -1255,6 +1336,10 @@ void hexagon_translate_init(void)
>          offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
>      hex_cycle_count =3D tcg_global_mem_new_i64(tcg_env,
>              offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
> +#ifndef CONFIG_USER_ONLY
> +    hex_cause_code =3D tcg_global_mem_new_i32(tcg_env,
> +        offsetof(CPUHexagonState, cause_code), "cause_code");
> +#endif
>

Seems strange to add this here and remove it below


>      for (i =3D 0; i < STORES_MAX; i++) {
>          snprintf(store_addr_names[i], NAME_LEN, "store_addr_%d", i);
>          hex_store_addr[i] =3D tcg_global_mem_new(tcg_env,
> @@ -1292,8 +1377,4 @@ void hexagon_translate_init(void)
>              offsetof(CPUHexagonState, vstore_pending[i]),
>              vstore_pending_names[i]);
>      }
> -#ifndef CONFIG_USER_ONLY
> -    hex_cause_code =3D tcg_global_mem_new(tcg_env,
> -        offsetof(CPUHexagonState, cause_code), "cause_code");
> -#endif
>  }
> --
> 2.34.1
>
>

--000000000000092047064d275bbb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mai=
lto:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/translate.c | 89 ++++++++++++++++++++++++++++++++++++-=
-<br>
=C2=A01 file changed, 85 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c<br>
index 953b34b7891..79027e8a327 100644<br>
--- a/target/hexagon/translate.c<br>
+++ b/target/hexagon/translate.c<br>
@@ -552,6 +552,10 @@ static void gen_start_packet(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;reg_log_idx =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0bitmap_zero(ctx-&gt;regs_written, TOTAL_PER_THREAD_REGS=
);<br>
=C2=A0 =C2=A0 =C2=A0bitmap_zero(ctx-&gt;predicated_regs, TOTAL_PER_THREAD_R=
EGS);<br>
+#ifndef CONFIG_USER_ONLY<br>
+=C2=A0 =C2=A0 ctx-&gt;greg_log_idx =3D 0;<br>
+=C2=A0 =C2=A0 ctx-&gt;sreg_log_idx =3D 0;<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;preg_log_idx =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0bitmap_zero(ctx-&gt;pregs_written, NUM_PREGS);<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;future_vregs_idx =3D 0;<br>
@@ -584,6 +588,25 @@ static void gen_start_packet(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 * gen phase, so clear it again.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0bitmap_zero(ctx-&gt;pregs_written, NUM_PREGS);<br>
+#ifndef CONFIG_USER_ONLY<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; NUM_SREGS; i++) {<br></blockquote><div>=
<br></div><div>Use HEX_SREG_GLB_START instead of NUM_SREGS.</div><div>Also,=
 size the t_sreg_new_value array with HEX_SREG_GLB_START.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;t_sreg_new_value[i] =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ctx-&gt;sreg_log_idx; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int reg_num =3D ctx-&gt;sreg_log[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg_num &lt; HEX_SREG_GLB_START) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;t_sreg_new_value[reg_num=
] =3D tcg_temp_new();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(ctx-&gt;t_sreg_ne=
w_value[reg_num], hex_t_sreg[reg_num]);<br></blockquote><div><br></div><div=
>You only need this assignment if the writes can be predicated.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; NUM_GREGS; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;greg_new_value[i] =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ctx-&gt;greg_log_idx; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int reg_num =3D ctx-&gt;greg_log[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;greg_new_value[reg_num] =3D tcg_temp_n=
ew();<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Initialize the runtime state for packet semantics */=
<br>
=C2=A0 =C2=A0 =C2=A0if (need_slot_cancelled(pkt)) {<br>
@@ -744,6 +767,60 @@ static void gen_reg_writes(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+#ifndef CONFIG_USER_ONLY<br>
+static void gen_greg_writes(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ctx-&gt;greg_log_idx; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int reg_num =3D ctx-&gt;greg_log[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(hex_greg[reg_num], ctx-&gt;greg=
_new_value[reg_num]);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+<br>
+static void gen_sreg_writes(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 TCGv_i32 old_reg =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ctx-&gt;sreg_log_idx; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int reg_num =3D ctx-&gt;sreg_log[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg_num =3D=3D HEX_SREG_SSR) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(old_reg, hex_t_sr=
eg[reg_num]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(hex_t_sreg[reg_nu=
m], ctx-&gt;t_sreg_new_value[reg_num]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_modify_ssr(tcg_env, c=
tx-&gt;t_sreg_new_value[reg_num],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 old_reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* This can change processor sta=
te, so end the TB */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;base.is_jmp =3D DISAS_NO=
RETURN;<br></blockquote><div><br></div><div>Isn&#39;t this taken care of in=
 pkt_ends_tb from earlier patch?</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if ((reg_num =3D=3D HEX_SREG_STID) ||<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(reg_=
num =3D=3D HEX_SREG_IMASK) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(reg_=
num =3D=3D HEX_SREG_IPENDAD)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg_num &lt; HEX_SREG_GLB_ST=
ART) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(old=
_reg, hex_t_sreg[reg_num]);<br></blockquote><div><br></div><div>Don&#39;t n=
eed to set old_reg here</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(hex=
_t_sreg[reg_num],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;t_sreg_new_value[reg_num]);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* This can change the interrupt=
 state, so end the TB */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_pending_interrupt(tcg=
_env);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;base.is_jmp =3D DISAS_NO=
RETURN;<br></blockquote><div><br></div><div>Already taken care of.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if ((reg_num =3D=3D HEX_SREG_BESTWAIT) =
||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(reg_=
num =3D=3D HEX_SREG_SCHEDCFG)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* This can trigger resched inte=
rrupt, so end the TB */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_resched(tcg_env);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;base.is_jmp =3D DISAS_NO=
RETURN;<br></blockquote><div><br></div><div>Already taken care of.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg_num &lt; HEX_SREG_GLB_START) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(hex_t_sreg[reg_nu=
m], ctx-&gt;t_sreg_new_value[reg_num]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Put this=
 under an else as we&#39;ve already done the assignment for specific cases =
above</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
+=C2=A0 =C2=A0 }<br>
+}<br>
+#endif<br>
+<br>
=C2=A0static void gen_pred_writes(DisasContext *ctx)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Early exit if not needed or the log is empty */<br>
@@ -1044,6 +1121,10 @@ static void gen_commit_packet(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0process_store_log(ctx);<br>
<br>
=C2=A0 =C2=A0 =C2=A0gen_reg_writes(ctx);<br>
+#if !defined(CONFIG_USER_ONLY)<br>
+=C2=A0 =C2=A0 gen_greg_writes(ctx);<br>
+=C2=A0 =C2=A0 gen_sreg_writes(ctx);<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0gen_pred_writes(ctx);<br>
=C2=A0 =C2=A0 =C2=A0if (pkt-&gt;pkt_has_hvx) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_commit_hvx(ctx);<br>
@@ -1255,6 +1336,10 @@ void hexagon_translate_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(CPUHexagonState, llsc_val_i64), =
&quot;llsc_val_i64&quot;);<br>
=C2=A0 =C2=A0 =C2=A0hex_cycle_count =3D tcg_global_mem_new_i64(tcg_env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(CPUHexagonState, t=
_cycle_count), &quot;t_cycle_count&quot;);<br>
+#ifndef CONFIG_USER_ONLY<br>
+=C2=A0 =C2=A0 hex_cause_code =3D tcg_global_mem_new_i32(tcg_env,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 offsetof(CPUHexagonState, cause_code), &quot;c=
ause_code&quot;);<br>
+#endif<br></blockquote><div><br></div><div>Seems strange to add this here =
and remove it below</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; STORES_MAX; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(store_addr_names[i], NAME_LEN, &=
quot;store_addr_%d&quot;, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hex_store_addr[i] =3D tcg_global_mem_new(=
tcg_env,<br>
@@ -1292,8 +1377,4 @@ void hexagon_translate_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(CPUHexagonState, v=
store_pending[i]),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vstore_pending_names[i]);<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
-#ifndef CONFIG_USER_ONLY<br>
-=C2=A0 =C2=A0 hex_cause_code =3D tcg_global_mem_new(tcg_env,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 offsetof(CPUHexagonState, cause_code), &quot;c=
ause_code&quot;);<br>
-#endif<br>
=C2=A0}<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000092047064d275bbb--

