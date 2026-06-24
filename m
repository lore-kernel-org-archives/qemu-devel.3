Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A86CD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcBNS-000236-26; Tue, 23 Jun 2026 20:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcBNP-00022T-7N
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:21:59 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcBNN-0005Eu-Im
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:21:58 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-697f6c67028so47611a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782260515; cv=none;
 d=google.com; s=arc-20260327;
 b=RrSV3XIZR9nfu9G7MbTOWBvf2o8BZwBbmSXoAHV+XIuAIwhKRbunfee/Rv8Y0u0oZs
 17f/sQAoXkahpYDPSDR6YExgaRLF4tYkPHjCRGNX+8VWqsQ83TF0LFh74shaov2OIHOv
 +fBCWfwZIlEpY4lHGdiQ7zjOc9S0qnQGTpNu4tpGw4KHdOZvrArShdwFbYhky7nyBWkN
 XFTUQksBJBN1vmXZd+UtqghAtXoZbXMJKFNtMWcddUDwPzlk/4l597gKaki9IdEMt4V8
 ziZXUXKgqzfTMvCKsHemOlusj12mwdjFCT0nuU0bC3o3hlCfH1xG2XtNMnZbQeSbC7fV
 eZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tsgZiXdkmETDqTAW5iKS/LbdFktw0x6WXcHKVU9Tljo=;
 fh=CWSAnId3W2WRhE+vYm7KnLRsSqy4d6vcRSeH2N6va14=;
 b=L/b5y4nNHUgdu+CxgYck9CqRQLAQ2b6G4c6zdgRGlf3aXXycWOG+mGdT0K2/k5tOmV
 XULIZYsRgnm76prGD4qq+pvlzgUOr9DfAV6DUlFgilBjZoikByxR0bpECegJuj0dp//D
 g0komjH62BuVWmA7FGtuUia0tthreB96TVUD8yUpodYrBpu6RenPEzHgh02IpiqavLb4
 sX6HFXaZ2jQsq9rM5iwvLVcWbGpK+iCnG5ZOAZ+TG8Ytpy+YgGUMuJQVkL6BmHuFhIm9
 S+7LybPs7P5cbMTS0rbQeuSpca39BAim+3j9lwm+vGRgDK3Im5XOPx/w9mJtGVwcBNe8
 4hBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782260515; x=1782865315; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsgZiXdkmETDqTAW5iKS/LbdFktw0x6WXcHKVU9Tljo=;
 b=ah+KKONKACopiqtgzTcRjDnhVc7ehDeB5Kw6geG2B4j3+TgiG/6fvk0kzJpUAQrjCF
 S4UrJjvxRqYa73QPpIMBq+CrqWRqAatIEJr558mcSWv2uDpFs7P5ifNA+2H6Rw7VWZY1
 BeuOwj6/QyeSw5ala9chybCO5PqS5vsfiIEzEWxEgS8OorawXhYKkpJQWfZCVlMs8Ih7
 Fe+tE49F/pmf8J8i0tsVTgl5PX2Kh+EIQRVbtk+kDrrLuAQc0S76bneIV9zMkC3C5F+S
 Rj8Jwc5Ud5JEjFbrcaJGR3oceTpTp0WqllTgEODxQdKlOQD88Ur7QBQVj1HL+H1ie/ty
 u5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782260515; x=1782865315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tsgZiXdkmETDqTAW5iKS/LbdFktw0x6WXcHKVU9Tljo=;
 b=Oua83amDWK3Gxyq6wAZuIzw3b6NKz3Q5p7IiD4RewEuCJtK/DHB/iuEtGT7f0TmzZr
 fB4kYVg+fux+qTaqDe8jsFsDkucIiEHC3A5ozndAG3KKoggq/OuKKJ+3XNXh1Yu/G45a
 uDXz1EB4TbhicS5b+FKaa+tuv9Qixh+Z7u1IlbPXLVGbt2u5uQFfKLW+yROxUDeOd8Xm
 c2P4PBMQ0T3qW5nliilhESxTVkX/h1PhwxleDeo1M4rpE/FlaUUaCiJxOtxZqbxte94b
 0rpgPF4rbevPsEif8NYLdn7kPP9F+U3UMzOGJpo1EJ2HXJAkc21YVlHn5Wz2E55WdDAe
 GzTw==
X-Gm-Message-State: AOJu0YzB5Y74xXCGXqOVj0Yut2wSFK+u9i7MXOuGSDX1bNBwfPKdomvd
 AEkEwEdWh14X0Ql2DNPYFTBPyVgrQRtMZN4cWH8qQtfsG8VoHAXIvYP1PFl6dcHdVSgkdry/5W/
 8HK9IMnhvgZgZrlI+qnff/2FcLC+QGXQ=
X-Gm-Gg: AfdE7cldBoQ/B1p74+qWqMAVy3mPtXaQlGhN8vCCUQEz7g8dECGTncEfn3w4/OwyioI
 q+KA+3DJiA3s6SipyNoy8DoVBI2tQRj+CEd7qQxisaR0S9BuAuiv1cW8LYyyzBtBI4+pczFew4c
 OYEDT9W3pYfMXZY2u/I5cu8D4qqIdKX06JSZZ8Dawhg7QnioSWXLe8w0O/0wNU8AnGX5ya5oz4w
 Ig1NNFIizmnLhZYEsBFdv97v4nZP9Zmbvy701hN3BxT0302vUoSUv+4MxAxtlP4/gPtTxpH9ITS
 Vef/NG8R6wYvkXdCAHUNI2I5QsE=
X-Received: by 2002:a05:6402:324d:b0:67c:34bb:1bd1 with SMTP id
 4fb4d7f45d1cf-697d42cdddbmr2457811a12.1.1782260515235; Tue, 23 Jun 2026
 17:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260623110209.26861-1-philmd@oss.qualcomm.com>
 <20260623110209.26861-5-philmd@oss.qualcomm.com>
In-Reply-To: <20260623110209.26861-5-philmd@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 24 Jun 2026 10:21:29 +1000
X-Gm-Features: AVVi8CcYmPFKCDFnNH95O7BeLez0232hOhLNk45SccNIXpmPGvGQ9bTKM-VsXGQ
Message-ID: <CAKmqyKMrDwdiC4ggZj4uq+nTTzMOOAtT-HeMUVECb9Sb3FO4ew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] target/tcg: Rename set_rounding_mode() helpers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jun 23, 2026 at 9:04=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> In order to avoid symbol name clash when building
> a single binary, rename TCG helpers prefixing with
> the target name.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/loongarch/tcg/helper.h                    | 2 +-
>  target/riscv/helper.h                            | 2 +-
>  target/loongarch/tcg/fpu_helper.c                | 2 +-
>  target/riscv/fpu_helper.c                        | 2 +-
>  target/riscv/translate.c                         | 2 +-
>  target/loongarch/tcg/insn_trans/trans_fmov.c.inc | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.=
h
> index 35b055eb3bc..154e70c0191 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -91,7 +91,7 @@ DEF_HELPER_2(ftint_w_d, i64, env, i64)
>  DEF_HELPER_2(frint_s, i64, env, i64)
>  DEF_HELPER_2(frint_d, i64, env, i64)
>
> -DEF_HELPER_FLAGS_1(set_rounding_mode, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_FLAGS_1(loongarch_set_rounding_mode, TCG_CALL_NO_RWG, void, e=
nv)
>
>  DEF_HELPER_1(rdtime_d, i64, env)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 542b7c264fc..6f46e0d91d4 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -2,7 +2,7 @@
>  DEF_HELPER_2(raise_exception, noreturn, env, i32)
>
>  /* Floating Point - rounding mode */
> -DEF_HELPER_FLAGS_2(set_rounding_mode, TCG_CALL_NO_WG, void, env, i32)
> +DEF_HELPER_FLAGS_2(riscv_set_rounding_mode, TCG_CALL_NO_WG, void, env, i=
32)
>  DEF_HELPER_FLAGS_2(set_rounding_mode_chkfrm, TCG_CALL_NO_WG, void, env, =
i32)
>
>  /* Floating Point - fused */
> diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu=
_helper.c
> index fc9c64c20a8..265f608cddd 100644
> --- a/target/loongarch/tcg/fpu_helper.c
> +++ b/target/loongarch/tcg/fpu_helper.c
> @@ -878,7 +878,7 @@ uint64_t helper_ftint_w_d(CPULoongArchState *env, uin=
t64_t fj)
>      return fd;
>  }
>
> -void helper_set_rounding_mode(CPULoongArchState *env)
> +void helper_loongarch_set_rounding_mode(CPULoongArchState *env)
>  {
>      set_float_rounding_mode(ieee_rm[(env->fcsr0 >> FCSR0_RM) & 0x3],
>                              &env->fp_status);
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index db1475271b6..88261b223cc 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -66,7 +66,7 @@ void riscv_cpu_check_fflags(CPURISCVState *env,
>                              FloatExceptionFlags pre_fflag) {}
>  #endif
>
> -void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
> +void helper_riscv_set_rounding_mode(CPURISCVState *env, uint32_t rm)
>  {
>      FloatRoundMode softrm;
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9684dbe7528..d5c3366fd94 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -759,7 +759,7 @@ static void gen_set_rm(DisasContext *ctx, uint8_t rm)
>
>      /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
>      decode_save_opc(ctx, 0);
> -    gen_helper_set_rounding_mode(tcg_env, tcg_constant_i32(rm));
> +    gen_helper_riscv_set_rounding_mode(tcg_env, tcg_constant_i32(rm));
>  }
>
>  static void gen_set_rm_chkfrm(DisasContext *ctx, uint8_t rm)
> diff --git a/target/loongarch/tcg/insn_trans/trans_fmov.c.inc b/target/lo=
ongarch/tcg/insn_trans/trans_fmov.c.inc
> index 5cbd9d3f347..c4c4c2000f7 100644
> --- a/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
> @@ -112,7 +112,7 @@ static bool trans_movgr2fcsr(DisasContext *ctx, arg_m=
ovgr2fcsr *a)
>       * Note that FCSR3 is exactly the rounding mode field.
>       */
>      if (mask & FCSR0_M3) {
> -        gen_helper_set_rounding_mode(tcg_env);
> +        gen_helper_loongarch_set_rounding_mode(tcg_env);
>      }
>      return true;
>  }
> --
> 2.53.0
>
>

