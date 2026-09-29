Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401F4CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhZF-0003on-Mz; Tue, 29 Sep 2026 19:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhZD-0003oc-B4
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:48:59 -0400
Received: from mail-lr2-x10.google.com ([2a00:1450:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhZB-0007HG-9u
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:48:59 -0400
Received: by mail-lr2-x10.google.com with SMTP id
 38308e7fff4ca-3a5da7416f9so40031361fa.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 16:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790725735; cv=none;
 d=google.com; s=arc-20260327;
 b=bgjuTu6NX9edn49wghpqX+p73WRV8+JhevryVltVrUSSDeW4hHhhgDhwytCjGY6IM7
 kc5LnhuCE9CU1Cx32STq8mT+KOTarqAQ2+nwZpK9ae6+PauVcVci7JZEisP1BXUAUFyO
 /17h7Gkq32gE7Sg0Ci0VErwDvzQWlAQeTPKNXJUxP1vIutcmSO/Z8MnTxIQpzMuhRLTl
 5MbOhwngKt50sueNytX585r7LTOIwt3/sYG6zgNr4A9Ap5jjfUQLXvvBHyPJCg5SSP1a
 nNBkf9fVw1nofHHW8y9z7EBu65qf12LxP/VxfKdDTkdP2/nrmHnl/RQmqV15DRjnLlod
 e5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/hDjlhQeFqgFy7g+md7WMr/5UqqdAWO4eNpxjp6hDpU=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=a/MVszajdSIP5zsKql6G3ErtiCtMI+jYAp6FDsoA5rvJwmsUCbk3omeYDcZVo3PLCa
 RRn3IH3i478OO8bJpjtwsQkdmT5Q0i5H2rgGtGL/iaNs5PsayQzrcRLdjlxLeM1JIGTT
 eEJaG7cXE9KHALB4oy7FWLAbYbvJyExe88pGgJvArnKINKQ/Ix8xBkREG3rDgsJ8R+TF
 jXu/mSUKPvuvq7S3Rtio1OL25BsSWdpfXzrL/qROFDtBeLT3vfDnD33uSbLfRyUYbcBE
 xIoz6sPRhIyBj3Zqvk/oCG6jetnVpLYcVPV2e5fA86tGy700HNjJgJJRrjMgDllseQzO
 Trvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790725735; x=1791330535; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/hDjlhQeFqgFy7g+md7WMr/5UqqdAWO4eNpxjp6hDpU=;
 b=sSrNhaZ+e9vSTCOfExW3vkSOxbrGWzOekstNalMIn1QKp3pba0qjIteMrsnvXrBxlg
 GbSSoLmgFDVoUjW3OELBCzGLhnJ2X+SULOhDrDozUZ6HlNzdignmvFZbjEV+3g2tVFew
 KbReun3SmPyv8y3c36NBiZagaCZkx37w0sK88P3b5SBt0ApF9uSAsTRnbqhY/JgnC08U
 rAUQvUfpjZPwbqM1NoxELwC39NZsHv4U+ryuPI0uK464LhHyScgezvp001ThMJqA5LjC
 za2mkyma219djU53O2NFmlKATWO/ZfZ60zpMEp6pcP0zjSt0oBe/v0yl/eFgcL5iG+SM
 Kf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790725735; x=1791330535;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/hDjlhQeFqgFy7g+md7WMr/5UqqdAWO4eNpxjp6hDpU=;
 b=bNj8MLz7WxlRtGGh4SrB1wCZV5b8MiGYhLhsSW6cOLmUPg0QgOlMCwHU6LspnGZKPY
 +uVL71lGb+i5mtpOz0PL/L+0x7L71hean6Ilu1evntKO6O1gJTi167F1C2dQTagn+V6B
 0VOFR2/trE9eWhQCfqsrWn9+G1ubjhFTXriLy3t06cYYCJCLq249/X4vAioKXUyWgdyF
 ax0Dq5v9UANgueWM71bOhEsG+NkDRUqCgJZKSOYDJqXdBtWixfSdqPPh52TM50Lzai46
 xxDLKyAj+bV/bgPXpsrU39Hl39fPFP372tZRvQph5r5io5GUMA6nlA/LONUn5/NJVEdc
 9Naw==
X-Gm-Message-State: AFq9FYLpdgAlMmSp64Z1IqI6BUFK0T8+kAbRuZF7zw0hDw8HVs5jwY7c
 +Lva7Nl7NViV9D0v1Bj2iwPsBc6bbLGzvivXt8lFDUTlkCzliFLL1+GNRoOvlAeIsHsM84dDZG7
 h1xgE2OzbNbeRsrm4Wd2EPLlnZzEqTps=
X-Gm-Gg: AYBFou1BlaABsnYnN8vLfK5oczOm6/NA3vCivDA0AWtSlZiMmZp+Qc4uufnFBo5nTPp
 anequlunn1x2g4CgBDqZzs+pGiqEnOZvJHDvZ7LKIYozJjyzE6WcJZew+0IhCxNeD8l24/YaSOS
 NLVW0Kri5rGD71UWVymJuEkjM1WJd0qVHjUlmZ7jy78SF0Zaq6w+ZSQirbGTZk8xn8FUISiumSY
 Caiw7Nx3UfKtq5D03ncsmUanYFgOiFZmF/GCPf8Yl2JT6JN2GTERN+yFo4Sn+emE583iP+U5Aay
 F2qcla+QZzQ/+rqug3QmJlR2Di+tB6B2x4eIIWKB5fJpvuTAPln2tULwA/rRNHtDyJAjVxzcQ2O
 Vsdg0dMBf4trcIQ==
X-Received: by 2002:a2e:be11:0:b0:3a7:7306:1b5e with SMTP id
 38308e7fff4ca-3a773061c68mr1033981fa.29.1790725735316; Tue, 29 Sep 2026
 16:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-98-richard.henderson@linaro.org>
In-Reply-To: <20260927090011.10724-98-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 29 Sep 2026 19:48:43 -0400
X-Gm-Features: AclHuK-Co9zmRCynqHzHI0700OIkxCTXUFQO9KUc5ZPyT-CjnBkWyrxap0Ylrqg
Message-ID: <CAEdQ38Gm1Leqi3ktoSovCmfmdZWgdPqQrpTVn+CVk1R91Ftx1w@mail.gmail.com>
Subject: Re: [PATCH v5 097/101] tcg: Generic expansion of tcg_gen_qemu_ld_chk
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:38::10;
 envelope-from=mattst88@gmail.com; helo=mail-lr2-x10.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Sep 27, 2026 at 5:08=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h  |   4 +-
>  include/tcg/tcg-op-mem.h     |   6 +-
>  include/tcg/tcg.h            |   2 +
>  include/tcg/tcg-op-def.h.inc |   1 +
>  tcg/tcg-op-ldst.c            | 164 ++++++++++++++---------------------
>  tcg/tcg-op.c                 |   4 +
>  6 files changed, 75 insertions(+), 106 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 583f6ebb2f5..fcbaae3def5 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -177,11 +177,9 @@ void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, t=
cg_target_long offset);
>
>  /* Local load/store bit ops */
>
> -void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType=
);
> +void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGTy=
pe);
>  void tcg_gen_qemu_st_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType=
);
> -void tcg_gen_qemu_ld_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType=
);
>  void tcg_gen_qemu_st_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType=
);
> -void tcg_gen_qemu_ld_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGTy=
pe);
>  void tcg_gen_qemu_st_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGTy=
pe);
>
>  /* Atomic ops */
> diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
> index 29e7c02f256..76955d27c1f 100644
> --- a/include/tcg/tcg-op-mem.h
> +++ b/include/tcg/tcg-op-mem.h
> @@ -31,7 +31,7 @@ typedef TCGv_i64 TCGv_va;
>  QEMU_ARG_NONNULL static inline void
>  tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
>  {
> -    tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
> +    tcg_gen_qemu_ld_chk_i32(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>  }
>
>  QEMU_ARG_NONNULL static inline void
> @@ -43,7 +43,7 @@ tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv_va a, TCGArg i, Me=
mOp m)
>  QEMU_ARG_NONNULL static inline void
>  tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
>  {
> -    tcg_gen_qemu_ld_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
> +    tcg_gen_qemu_ld_chk_i64(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>  }
>
>  QEMU_ARG_NONNULL static inline void
> @@ -55,7 +55,7 @@ tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv_va a, TCGArg i, Me=
mOp m)
>  QEMU_ARG_NONNULL static inline void
>  tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
>  {
> -    tcg_gen_qemu_ld_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
> +    tcg_gen_qemu_ld_chk_i128(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>  }
>
>  QEMU_ARG_NONNULL static inline void
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 077a1b37021..fd719f9a36a 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -293,6 +293,8 @@ typedef struct TCGTemp {
>      void *state_ptr;
>  } TCGTemp;
>
> +typedef TCGTemp *TCGTempPtr;
> +
>  typedef struct TCGContext TCGContext;
>
>  typedef struct TCGTempSet {
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index 556f7470cd6..e2da3ddef66 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -53,6 +53,7 @@ DEF2(not, TCGV, TCGV)
>  DEF3(or, TCGV, TCGV, TCGV)
>  DEF3(ori, TCGV, TCGV, TINT)
>  DEF3(orc, TCGV, TCGV, TCGV)
> +DEF5(qemu_ld_chk, TCGV, TCGTempPtr, unsigned, MemOp, TCGType)
>  DEF3(rem, TCGV, TCGV, TCGV)
>  DEF3(remu, TCGV, TCGV, TCGV)
>  DEF2(revbit8, TCGV, TCGV)
> diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
> index 031c5ce926b..c48b8c0e3d1 100644
> --- a/tcg/tcg-op-ldst.c
> +++ b/tcg/tcg-op-ldst.c
> @@ -191,33 +191,37 @@ plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTem=
p *orig_addr, MemOpIdx oi,
>  #endif
>
>  static void
> -plugin_gen_mem_callbacks_i32(TCGv_i32 val,
> +plugin_gen_mem_callbacks_tmp(TCGType type, TCGTemp *val,
>                               TCGv_i64 copy_addr, TCGTemp *orig_addr,
>                               MemOpIdx oi, enum qemu_plugin_mem_rw rw)
>  {
>  #ifdef CONFIG_PLUGIN
>      if (tcg_ctx->plugin_insn !=3D NULL) {
> -        tcg_gen_st_i32(val, tcg_env,
> -                       offsetof(CPUState, neg.plugin_mem_value_low) -
> -                       sizeof(CPUState) + (HOST_BIG_ENDIAN * 4));
> +        tcg_gen_st(type, val, tcgv_ptr_temp(tcg_env),
> +                   offsetof(CPUState, neg.plugin_mem_value_low)
> +                   - sizeof(CPUState)
> +                   + (HOST_BIG_ENDIAN && type =3D=3D TCG_TYPE_I32 ? 4 : =
0));
>          plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
>      }
>  #endif
>  }
>
> +static void
> +plugin_gen_mem_callbacks_i32(TCGv_i32 val,
> +                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
> +                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
> +{
> +    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I32, tcgv_i32_temp(val), copy_=
addr,
> +                                 orig_addr, oi, rw);
> +}
> +
>  static void
>  plugin_gen_mem_callbacks_i64(TCGv_i64 val,
>                               TCGv_i64 copy_addr, TCGTemp *orig_addr,
>                               MemOpIdx oi, enum qemu_plugin_mem_rw rw)
>  {
> -#ifdef CONFIG_PLUGIN
> -    if (tcg_ctx->plugin_insn !=3D NULL) {
> -        tcg_gen_st_i64(val, tcg_env,
> -                       offsetof(CPUState, neg.plugin_mem_value_low) -
> -                       sizeof(CPUState));
> -        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
> -    }
> -#endif
> +    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I64, tcgv_i64_temp(val), copy_=
addr,
> +                                 orig_addr, oi, rw);
>  }
>
>  static void
> @@ -238,8 +242,31 @@ plugin_gen_mem_callbacks_i128(TCGv_i128 val,
>  #endif
>  }
>
> -static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
> -                                    TCGArg idx, MemOp memop)
> +static void tcg_gen_bswap(TCGType type, TCGTemp *dst,
> +                          TCGTemp *src, unsigned flags, MemOp memop)
> +{
> +    switch (memop & MO_SIZE) {
> +    case MO_16:
> +        tcg_gen_bswap16(type, src, dst, flags);

src and dst are swapped. The load path in this patch avoids this being
a problem because the same argument is passed for both src and dst,
but 098 has a path that ends up byte swapping an uninitialized value.

