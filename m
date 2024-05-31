Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFC6C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD5Oh-0002YV-Dw; Fri, 31 May 2024 12:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD5Of-0002Xe-6r
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:46:29 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD5Od-0005ss-6X
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:46:28 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52b88740a93so1100872e87.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717173984; x=1717778784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XNzqrtV1s0rd+PLr463zTCtEoYo1bPd1vFX3g92d3Gc=;
 b=OdTNUSWnGQxg/zM9TEksQ3ROKciiJGvcM5vpWhVxgYuRehTh3ZOv5d4oDIyo9acc1J
 I5fg+5Qzu5pgdQ60Vo1JHn9mtTghGMbrIUyOCkRN3AY7eF3gjqxjopc86+SDDf2BEUq9
 DXThgSPpnBDZFzewi78309w47J1XnBEMViOW4Rf+tc0Hutb4yfBs8+AkGusZDukZ6q/q
 9EhQZcZ3Frzq4IUklkBPHqsk0DlpzAaR1M6h/uUE18WywtMsQNxwGsVAlTCYFf9cAnIM
 JYTfHZoElqoZkOx6kXrXUAZFJ6zZmFpJMPNJxUDyUEXnRZE3Yvtbcu8JMprL4TeMchlL
 mX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717173984; x=1717778784;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNzqrtV1s0rd+PLr463zTCtEoYo1bPd1vFX3g92d3Gc=;
 b=Bp/6fV6/3xX9FldZyl4y65c9vxmAIieIFRbZ52qYaY1S8NyXYidt4EAbzP7uiNhV4Q
 93AVc/IcYQwJOKyOcv1NTrQPL2SSPJPy1ZiTo0HSzP8DTTW8hro7rCV2WLzZnRyAI6pk
 EJ7qrTFOOJmOcdXJOhFVZV63kP0FBRKNWFu4vPhimpVOQdCZW1JMj+magVU8XbTnH/j5
 a2Xwui9eocneVeah5ODgKmWXPilYe1nh5iS24C1tsnWqB4OkWM3b84SnGhILAMJPYiNh
 m5lh2GvCvr7L9rSsFMfDes61NHqWUsdmvWdwUNctDcaynQmYeFirdDkxgntS+AObnhTQ
 uCkg==
X-Gm-Message-State: AOJu0Yyc4URnv2OBG70jmxePmQhjqMgenuJBOipB0tvgs3gMARzDYZei
 3Apc2Dcynu/cmWvPDdVzpIyahGok9e3ZsG+W5w9+Thib2ThbgmVqGWa39xzlDUk=
X-Google-Smtp-Source: AGHT+IECJR4NP5PQdq6lQ5Qz8rdj11gqHyektmq6BLZc4kETD+pqgrC41CvFfeDe/7O59wg034usKg==
X-Received: by 2002:a19:ac0c:0:b0:51c:bd90:e60b with SMTP id
 2adb3069b0e04-52b8957ebfamr1627071e87.25.1717173984131; 
 Fri, 31 May 2024 09:46:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31c6d325sm1204564a12.65.2024.05.31.09.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 09:46:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1E135F8A3;
 Fri, 31 May 2024 17:46:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 2/7] accel/tcg: Set CPUState.plugin_ra before all plugin
 callbacks
In-Reply-To: <20240416040609.1313605-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 15 Apr 2024 21:06:04 -0700")
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <20240416040609.1313605-3-richard.henderson@linaro.org>
Date: Fri, 31 May 2024 17:46:22 +0100
Message-ID: <8734pyaq01.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x130.google.com
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

We really could do with a description of why we are setting plugin_ra
and what we mean to achieve by it. I think it is so we can then do the
same PC/other register recovery as we do at synchronous faulting
exceptions be it generated TCG code or a helper. However we should make
that clear in the commit (and possible some function comments).


> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/hw/core/cpu.h  |  1 +
>  accel/tcg/plugin-gen.c | 50 +++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 10cd492aff..f4af37c13d 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -350,6 +350,7 @@ typedef union IcountDecr {
>  typedef struct CPUNegativeOffsetState {
>      CPUTLB tlb;
>  #ifdef CONFIG_PLUGIN
> +    uintptr_t plugin_ra;
>      GArray *plugin_mem_cbs;
>  #endif
>      IcountDecr icount_decr;
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 36e9134a5d..f96b49cce6 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -37,6 +37,12 @@ enum plugin_gen_from {
>      PLUGIN_GEN_AFTER_TB,
>  };
>=20=20
> +enum plugin_gen_ra {
> +    GEN_RA_DONE,
> +    GEN_RA_FROM_TB,
> +    GEN_RA_FROM_INSN,
> +};
> +
>  /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
>  void plugin_gen_disable_mem_helpers(void)
>  {
> @@ -151,11 +157,38 @@ static void gen_mem_cb(struct qemu_plugin_dyn_cb *c=
b,
>      tcg_temp_free_i32(cpu_index);
>  }
>=20=20
> -static void inject_cb(struct qemu_plugin_dyn_cb *cb)
> +static void inject_ra(enum plugin_gen_ra *gen_ra)
> +{
> +    TCGv_ptr ra;
> +
> +    switch (*gen_ra) {
> +    case GEN_RA_DONE:
> +        return;
> +    case GEN_RA_FROM_TB:
> +        ra =3D tcg_constant_ptr(NULL);
> +        break;
> +    case GEN_RA_FROM_INSN:
> +        ra =3D tcg_temp_ebb_new_ptr();
> +        tcg_gen_plugin_pc(ra);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    tcg_gen_st_ptr(ra, tcg_env,
> +                   offsetof(CPUState, neg.plugin_ra) -
> +                   offsetof(ArchCPU, env));
> +    tcg_temp_free_ptr(ra);
> +    *gen_ra =3D GEN_RA_DONE;
> +}
> +
> +static void inject_cb(struct qemu_plugin_dyn_cb *cb,
> +                      enum plugin_gen_ra *gen_ra)
>=20=20
>  {
>      switch (cb->type) {
>      case PLUGIN_CB_REGULAR:
> +        inject_ra(gen_ra);
>          gen_udata_cb(cb);
>          break;
>      case PLUGIN_CB_INLINE:
> @@ -167,16 +200,18 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
>  }
>=20=20
>  static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
> +                          enum plugin_gen_ra *gen_ra,
>                            enum qemu_plugin_mem_rw rw,
>                            qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
>  {
>      if (cb->rw & rw) {
>          switch (cb->type) {
>          case PLUGIN_CB_MEM_REGULAR:
> +            inject_ra(gen_ra);
>              gen_mem_cb(cb, meminfo, addr);
>              break;
>          default:
> -            inject_cb(cb);
> +            inject_cb(cb, gen_ra);
>              break;
>          }
>      }
> @@ -186,6 +221,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *=
plugin_tb)
>  {
>      TCGOp *op, *next;
>      int insn_idx =3D -1;
> +    enum plugin_gen_ra gen_ra;
>=20=20
>      if (unlikely(qemu_loglevel_mask(LOG_TB_OP_PLUGIN)
>                   && qemu_log_in_addr_range(plugin_tb->vaddr))) {
> @@ -205,10 +241,12 @@ static void plugin_gen_inject(struct qemu_plugin_tb=
 *plugin_tb)
>       */
>      memset(tcg_ctx->free_temps, 0, sizeof(tcg_ctx->free_temps));
>=20=20
> +    gen_ra =3D GEN_RA_FROM_TB;
>      QTAILQ_FOREACH_SAFE(op, &tcg_ctx->ops, link, next) {
>          switch (op->opc) {
>          case INDEX_op_insn_start:
>              insn_idx++;
> +            gen_ra =3D GEN_RA_FROM_INSN;
>              break;
>=20=20
>          case INDEX_op_plugin_cb:
> @@ -244,7 +282,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *=
plugin_tb)
>                  cbs =3D plugin_tb->cbs;
>                  for (i =3D 0, n =3D (cbs ? cbs->len : 0); i < n; i++) {
>                      inject_cb(
> -                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i=
));
> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i=
),
> +                        &gen_ra);
>                  }
>                  break;
>=20=20
> @@ -256,7 +295,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *=
plugin_tb)
>                  cbs =3D insn->insn_cbs;
>                  for (i =3D 0, n =3D (cbs ? cbs->len : 0); i < n; i++) {
>                      inject_cb(
> -                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i=
));
> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i=
),
> +                        &gen_ra);
>                  }
>                  break;
>=20=20
> @@ -288,7 +328,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *=
plugin_tb)
>              cbs =3D insn->mem_cbs;
>              for (i =3D 0, n =3D (cbs ? cbs->len : 0); i < n; i++) {
>                  inject_mem_cb(&g_array_index(cbs, struct qemu_plugin_dyn=
_cb, i),
> -                              rw, meminfo, addr);
> +                              &gen_ra, rw, meminfo, addr);
>              }
>=20=20
>              tcg_ctx->emit_before_op =3D NULL;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

