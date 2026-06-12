Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B0ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 04:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXtSP-0006wS-6v; Fri, 12 Jun 2026 00:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXtSE-0006uY-SK
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 00:25:15 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXtSC-00021n-64
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 00:25:14 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69170548d0eso741493a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 21:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781238309; cv=none;
 d=google.com; s=arc-20240605;
 b=J0STjB+jDlRZDJ0FP8JX+rNQNPsD80La8LQPsyvhU+2coG1YqiYhVsZTKBWWwqfz3h
 h7LUaSsRlpZc1W1xq8ZcYFlF8wFLfyTwtedyvyXqQE46gH4vKej91VYg3ZlEaHcU+/pp
 aY0i1dEfbF8uFzEv72SVzGRZl2xAMlf2EiN+7K5NWWvUObEYbLBr2MeRzOE8E7ippk+E
 GV2eg61RKDX1jQ4MirytarE1161Cl9WIzvECEyqtPhK62howgyBpxZNhpmR4x9LCdfmD
 njwVlYErJs6C1579cCozI5ukNbp/8UM8NX27mIkkee5gnDPobKbIyntgPyM062Zp+YZM
 mPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Sdm+KFjX8FCSQz+PrUNWbK270jsk0dt4ls/rkCUxdQ4=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=fEHO5EKG61vYQefb1yGILPaw6fLP+NdqktqeE/adfYELKJBR+YI46TDW6l3ei5rDdn
 zIES9WFkcTKTgcU3U2xjEilGcJ0kqcLJjAwcvts5c+ke6Vrx/7XW3GRA4sFyqi7TN2WZ
 whfCM8l096anVUM2HSL6heKikO/FfNWwl87xkM0A4YF7YnAEwa6pzJshloYu1ZKKYHTi
 j6dstpyasKEQI35j3I6jeCMYfJjdNX+ubeGOB6Q0t57exOxQiFa7okSUFBjYk+AwQmJR
 cyn1eK9gmuiSmu2E787m7NkyrjWzVNtm829G3v6Fxto1UnZNsxSSOBZZHoSJdso+hCdf
 RuYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781238309; x=1781843109; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sdm+KFjX8FCSQz+PrUNWbK270jsk0dt4ls/rkCUxdQ4=;
 b=KD1U1x7XRT6q0FQb3vtNS7CiCxanYiM4CajbsOvs7rQ/vEwPF51IStLn153rmyo4c/
 Djh593RtYXtktFBFnU9S8GP4HbVkijo/IJi3r8Bw/qvjrxJ2zoOwVO/l6BZTKAeucWwv
 meiXzrSpyVUnzY+vviq535UhwjThTigBsLXlf9H6na+nPdv8CWs8zd4H72TL+9LumUax
 9ej40W/8Qupdu9rDFNUWJbTa5DrZMqpUumIEsZpMFBAaHa4aXb7Ziq9VFomyx5gSkE8b
 gUwd6G2js3zPBg7Ngf0xryM2fRPzLQ5HJ/rUVSgZMZpJyrBvIQAedv6ynsvaBwaQYBcs
 IrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781238309; x=1781843109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sdm+KFjX8FCSQz+PrUNWbK270jsk0dt4ls/rkCUxdQ4=;
 b=tFwhPBHmeI5qW/Z7EPtTwvBt5IMwDqhV+aq5i8J6RPBe9yRclfMkA5ans+E35AIr48
 9AQHLyL6wGkBh3R6QcK522N/yLcJNAnQfPSnK4Xy53iAlHxhguM7x9+HJxeHiV1W7UGp
 vcYWigrqBHX32jApQ2aKbsbns0aBBVmp6pvfFc+03s6Cu09CrW0t+wxueOfGwcjGyFrQ
 NdEJ1R3UQ+eoKikVpyxetlbSfdrTqzDv+rY3qyKbZjqXjjr41YNXt04UA+qnBSjoQhvA
 5lInIXUMu3mcd6lD62M5OFgIXZCYz6F/Ncgfl6Sa09MzrQ7IzsKMjNJdp5543wtfxmoJ
 CrlQ==
X-Gm-Message-State: AOJu0YxckCxPfAvHcbyTt4FdPrM+IW9dRyZpq8An/qcqLQTNkepfyEaN
 EuxBbIUCpbeMgWbqKdWFpzuIvO24ZzhGWDFzPJhbOPcdykrmU9LS2UlPBb3yzbYuB3W7KG950/9
 ehfiCPENV3yIcSUgNWL1STETtUq/f4OI=
X-Gm-Gg: Acq92OHzWPNPLuSXQgMk4HuYEcq+tEVH9dDzUNdrv2ZRoKVU158RG/bw0cyCUidKLGW
 TBKXzd65Y/7teZBY/Ui75aDinFbpxxQdTow33snpzEpgk+QCI4bonUk9fqACEPZZg1VgpxjMPNT
 15Qu4vaGrwFM/tFZBerNSVe8/qDVVlo3lf8I4eJZhMI+NeYd2UTJQmb4qIRf3ACWYfu9y88XT2n
 ES9yczKzxFvY7AIqPY+OJGuyAS5aKJ60xpDcuNjoe2BtvSKn3/uNW5dL08octkslO+cDTUIHe6V
 yNVSOkaUBz6kF2ep7SSNkHnczS38XOR3IPGi1A==
X-Received: by 2002:a05:6402:4143:b0:670:8add:2b8d with SMTP id
 4fb4d7f45d1cf-69378a84dc8mr370745a12.24.1781238308397; Thu, 11 Jun 2026
 21:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260611105037.157773-1-max.chou@sifive.com>
 <20260611105037.157773-2-max.chou@sifive.com>
In-Reply-To: <20260611105037.157773-2-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jun 2026 14:24:42 +1000
X-Gm-Features: AVVi8CfcK9jvxYXhlbuNp48Zakd2aH-e_iXvK4yySIH1kTbcivx0td9mndQUHL8
Message-ID: <CAKmqyKN0X1uYkccbjm3GzhzG2DVFRCi988FoRm_xv5N=-=sjwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Set mstatus.FS dirty when scalar FP
 raises exceptions
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 11, 2026 at 8:52=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> According to the RISC-V privileged spec 3.1.6, any instruction that
> modifies FP extension state (FP CSRs including fflags, or f registers)
> must set mstatus.FS to Dirty.  Raising fflags bits is modifying fcsr
> (an FP CSR).
>
> Scalar FP instructions that write integer registers (FP comparisons and
> FP-to-integer conversions) never call mark_fs_dirty at translation time
> to set mstatus.FS to dirty.  However, they can raise FP exception flags
> via softfloat functions, which modifies fflags without any mechanism to
> dirty mstatus.FS.
>
> The affected helpers:
> - Comparisons: fle/fleq/flt/fltq/feq
>   =E2=80=94 raise NV on NaN operands
> - FP-to-integer: fcvt.[w|wu|l|lu]/fcvtmod.w.d
>   =E2=80=94 raise NX on inexact or NV on out-of-range
>
> Fix this issue by
> 1. Save float_exception_flags before the softfloat operation
> 2. Perform the operation
> 3. If any new exception bits are set, set fs to dirty
>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        |   1 +
>  target/riscv/fpu_helper.c | 157 +++++++++++++++++++++++++++++++-------
>  2 files changed, 130 insertions(+), 28 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c98652cd62..9961815ec3 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -675,6 +675,7 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *=
env,
>
>  uint8_t riscv_cpu_get_fflags(CPURISCVState *env);
>  void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t);
> +void riscv_cpu_check_fflags(CPURISCVState *env, FloatExceptionFlags);
>
>  #ifndef CONFIG_USER_ONLY
>  void cpu_set_exception_base(int vp_index, uint64_t address);
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index e6d1ffb1d6..db1475271b 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -50,6 +50,22 @@ void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t =
hard)
>      set_float_exception_flags(soft, &env->fp_status);
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +void riscv_cpu_check_fflags(CPURISCVState *env,
> +                            FloatExceptionFlags pre_fflag)
> +{
> +    if (get_float_exception_flags(&env->fp_status) & ~pre_fflag) {
> +        env->mstatus |=3D MSTATUS_FS;
> +        if (env->virt_enabled) {
> +            env->mstatus_hs |=3D MSTATUS_FS;
> +        }
> +    }
> +}
> +#else
> +void riscv_cpu_check_fflags(CPURISCVState *env,
> +                            FloatExceptionFlags pre_fflag) {}
> +#endif
> +
>  void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
>  {
>      FloatRoundMode softrm;
> @@ -286,59 +302,86 @@ target_ulong helper_fle_s(CPURISCVState *env, uint6=
4_t rs1, uint64_t rs2)
>  {
>      float32 frs1 =3D check_nanbox_s(env, rs1);
>      float32 frs2 =3D check_nanbox_s(env, rs2);
> -    return float32_le(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float32_le(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fleq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs=
2)
>  {
>      float32 frs1 =3D check_nanbox_s(env, rs1);
>      float32 frs2 =3D check_nanbox_s(env, rs2);
> -    return float32_le_quiet(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float32_le_quiet(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_flt_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2=
)
>  {
>      float32 frs1 =3D check_nanbox_s(env, rs1);
>      float32 frs2 =3D check_nanbox_s(env, rs2);
> -    return float32_lt(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float32_lt(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fltq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs=
2)
>  {
>      float32 frs1 =3D check_nanbox_s(env, rs1);
>      float32 frs2 =3D check_nanbox_s(env, rs2);
> -    return float32_lt_quiet(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float32_lt_quiet(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_feq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2=
)
>  {
>      float32 frs1 =3D check_nanbox_s(env, rs1);
>      float32 frs2 =3D check_nanbox_s(env, rs2);
> -    return float32_eq_quiet(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float32_eq_quiet(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fcvt_w_s(CPURISCVState *env, uint64_t rs1)
>  {
>      float32 frs1 =3D check_nanbox_s(env, rs1);
> -    return float32_to_int32(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float32_to_int32(frs1, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t rs1)
>  {
>      float32 frs1 =3D check_nanbox_s(env, rs1);
> -    return (int32_t)float32_to_uint32(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D (int32_t)float32_to_uint32(frs1, &env->fp_statu=
s);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
>  {
>      float32 frs1 =3D check_nanbox_s(env, rs1);
> -    return float32_to_int64(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float32_to_int64(frs1, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
>  {
>      float32 frs1 =3D check_nanbox_s(env, rs1);
> -    return float32_to_uint64(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float32_to_uint64(frs1, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  uint64_t helper_fcvt_s_w(CPURISCVState *env, target_ulong rs1)
> @@ -453,52 +496,83 @@ uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_=
t frs1)
>
>  target_ulong helper_fle_d(CPURISCVState *env, uint64_t frs1, uint64_t fr=
s2)
>  {
> -    return float64_le(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float64_le(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fleq_d(CPURISCVState *env, uint64_t frs1, uint64_t f=
rs2)
>  {
> -    return float64_le_quiet(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float64_le_quiet(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_flt_d(CPURISCVState *env, uint64_t frs1, uint64_t fr=
s2)
>  {
> -    return float64_lt(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float64_lt(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fltq_d(CPURISCVState *env, uint64_t frs1, uint64_t f=
rs2)
>  {
> -    return float64_lt_quiet(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float64_lt_quiet(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_feq_d(CPURISCVState *env, uint64_t frs1, uint64_t fr=
s2)
>  {
> -    return float64_eq_quiet(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float64_eq_quiet(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fcvt_w_d(CPURISCVState *env, uint64_t frs1)
>  {
> -    return float64_to_int32(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float64_to_int32(frs1, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  uint64_t helper_fcvtmod_w_d(CPURISCVState *env, uint64_t value)
>  {
> -    return float64_to_int32_modulo(value, float_round_to_zero, &env->fp_=
status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    uint64_t ret =3D float64_to_int32_modulo(value, float_round_to_zero,
> +                                           &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fcvt_wu_d(CPURISCVState *env, uint64_t frs1)
>  {
> -    return (int32_t)float64_to_uint32(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D (int32_t)float64_to_uint32(frs1, &env->fp_statu=
s);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
>  {
> -    return float64_to_int64(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float64_to_int64(frs1, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
>  {
> -    return float64_to_uint64(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float64_to_uint64(frs1, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  uint64_t helper_fcvt_d_w(CPURISCVState *env, target_ulong rs1)
> @@ -619,35 +693,50 @@ target_ulong helper_fle_h(CPURISCVState *env, uint6=
4_t rs1, uint64_t rs2)
>  {
>      float16 frs1 =3D check_nanbox_h(env, rs1);
>      float16 frs2 =3D check_nanbox_h(env, rs2);
> -    return float16_le(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float16_le(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fleq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs=
2)
>  {
>      float16 frs1 =3D check_nanbox_h(env, rs1);
>      float16 frs2 =3D check_nanbox_h(env, rs2);
> -    return float16_le_quiet(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float16_le_quiet(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_flt_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2=
)
>  {
>      float16 frs1 =3D check_nanbox_h(env, rs1);
>      float16 frs2 =3D check_nanbox_h(env, rs2);
> -    return float16_lt(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float16_lt(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fltq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs=
2)
>  {
>      float16 frs1 =3D check_nanbox_h(env, rs1);
>      float16 frs2 =3D check_nanbox_h(env, rs2);
> -    return float16_lt_quiet(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float16_lt_quiet(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_feq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2=
)
>  {
>      float16 frs1 =3D check_nanbox_h(env, rs1);
>      float16 frs2 =3D check_nanbox_h(env, rs2);
> -    return float16_eq_quiet(frs1, frs2, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float16_eq_quiet(frs1, frs2, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fclass_h(CPURISCVState *env, uint64_t rs1)
> @@ -683,25 +772,37 @@ uint64_t helper_froundnx_h(CPURISCVState *env, uint=
64_t rs1)
>  target_ulong helper_fcvt_w_h(CPURISCVState *env, uint64_t rs1)
>  {
>      float16 frs1 =3D check_nanbox_h(env, rs1);
> -    return float16_to_int32(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float16_to_int32(frs1, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fcvt_wu_h(CPURISCVState *env, uint64_t rs1)
>  {
>      float16 frs1 =3D check_nanbox_h(env, rs1);
> -    return (int32_t)float16_to_uint32(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D (int32_t)float16_to_uint32(frs1, &env->fp_statu=
s);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fcvt_l_h(CPURISCVState *env, uint64_t rs1)
>  {
>      float16 frs1 =3D check_nanbox_h(env, rs1);
> -    return float16_to_int64(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float16_to_int64(frs1, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  target_ulong helper_fcvt_lu_h(CPURISCVState *env, uint64_t rs1)
>  {
>      float16 frs1 =3D check_nanbox_h(env, rs1);
> -    return float16_to_uint64(frs1, &env->fp_status);
> +    FloatExceptionFlags pre_fflag =3D get_float_exception_flags(&env->fp=
_status);
> +    target_ulong ret =3D float16_to_uint64(frs1, &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +    return ret;
>  }
>
>  uint64_t helper_fcvt_h_w(CPURISCVState *env, target_ulong rs1)
> --
> 2.43.7
>
>

