Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D749BCA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 06:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCWPw-0001FM-21; Fri, 02 Oct 2026 02:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCWPs-0001EW-Qa
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:06:45 -0400
Received: from mail-ed2-x0c.google.com ([2a00:1450:4864:33::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCWPp-0003Ck-QU
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:06:44 -0400
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acb6b726b5so6559888a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 23:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790921200; cv=none;
 d=google.com; s=arc-20260327;
 b=qPlI5kcI9tmA0ALrfIw7aGjsNHXWk5LycTpIQcSc3gAiGMVyaKNYBgelkLbYXpxKIm
 /ABT+yIyPjL1gxlkmd7XLVgg5ige2QL9MqHAPvViEQKx6AIiTjczVmhWxSuDHTZpL2m8
 s7EswSiQX/N/PcgiILv6m8DqpP/L0WHPmlHJhMCoE8korczL4wMHRXFsxhNTgDjjeioA
 zXC6+rcUG5PHE+I5JdD36XwzLMIEe0C1xem6sJzK24j35ApHe/Cnj3ggEn3zs4mGEHUw
 XzUlulaKQc5Zv6W8tPJDfDMSRT5onLaYeB4HhrXVlcWPkDLwADQH9Rmp0gFbMkwJCVpR
 49Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=98S01NEMXAyZV8o3y+B7MWDcVl0PbknoR6xmVawWP8A=;
 fh=MZQCNrTvBhHD+BQfjqjxt8bEe5OjAF/IKgZxbWwruzs=;
 b=T9ovoS0g7kbtQnlboJc8iSEu9v0Q1fd4fvVUx1IlEF6VMw7yd0h1dy1fvDYhtlaVUa
 TsA03YKtvGDDfAvPrKnOBNmR8AqeTcelaOA0xdbrTGO6Tx50lwelZNUKCMoCIYOxkKQO
 w3PcCAgmvQBZxT77gW0NkJwiBflGk2b+yb9mPLK42zlh6iEqIFPcKsqzikdPPMVrFDDz
 0Tqj6WDJwnXPcg9L2bSbhKXhkwMK6WPD0KzZ+Q+JYxS+FMVO8P3egaNG9zugaAZssiIH
 foGDSQGjtEU0p9tPtL2OFUduLUCWmcQgqqz9jAzaw8zHCH+RjHBzoCQpCE2rvf0uyrCY
 pYdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790921200; x=1791526000; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=98S01NEMXAyZV8o3y+B7MWDcVl0PbknoR6xmVawWP8A=;
 b=jJE7z6f+PCkHUGxdt5EIIrLf3QgCzwi1mQn19DxO5yB2nuFD+gxKSDOI1NLE1L5wzC
 bBLdwMd7XtGl9UC/ClNIsCYaQYgpLX/LLR0bysXJXtjGcG4x40EEjOvquL7IpPrr5YnI
 aYrZtCHWMTUzdIOnQAxWCkTTyatqludC55YmeBjYLBeCzuigjC4MBmJpi6sD6hCaJrw2
 NxCzzRj5JWXZqpZ6nHObHZ41DacagLdfigT/5UAp69fm2ktRTgedcBgQ8Sohe0ucuEbD
 o9yzzZI5laW7Yg+BYGMY85FC34kXteGfzw4qgEhy00EqNdQrRndQCIJqpY3YQrlCq8az
 de1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790921200; x=1791526000;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=98S01NEMXAyZV8o3y+B7MWDcVl0PbknoR6xmVawWP8A=;
 b=ACC2KyG9CUkki4/DL2TF9qsAL41OM2iA1uXUMZmuumrldIwA8gUIy/g6LUMIulNi8d
 eAi1ZibGwi/J87WNxrrdgxYyxpz24Hvs/Yl+2UuRQmJzFivFAZVuzLIeG4DjHfxMSqBX
 4/Jwcaq2qnwi8obVFvGsxuxM0NuxER3JQdiyB7urcl5PvLk0spp+XqJ5J4NLDT3c96U2
 zPPbmkO5LHJ/HFgN8Mu7uh2M9X0boj3b4fdf1wROoFHampo3VfitrEF6Yb0Tp5brG/Fx
 cZ1iyShYMsZU4wA0uAu9bj+bhRl9K9PQgzDROc98FW7hbBRs5Yw2SDrRfr43odphbUe4
 fLAw==
X-Gm-Message-State: AFq9FYJKLG+dWGjyxNB0lXDz5TzaYIPlLp8WbxHu6zFL10RL69rU6iys
 ra4TxjzcBpUJaz843gcQiJf4jM6qzdPbVvXcvmyqlz1z93rsvtk3Wtj9dOnuhxWK1/7Pa2B02kT
 uYfqDsk1QbfZ33Xz5XmXuUvf2lvwP1oE=
X-Gm-Gg: AYBFou07ThwCHhbeKCy1FTKnWvDLDXL7ajawmDWXA42d3cGRisLjpl7do3k4Ti+hiA8
 rW49M8ofvwEc4M4N8kwIQ2MkI5EUQ6vmdh3VEIJnmX4lfw0SmCmCYfecqb4UoV4CoQ54qZJhIc0
 H9Gi83V0TIH2AefLGjctrrOPHGkXJVgo9+8hLj+ICa8xp/l/rHIKb0br4aqLW7Lpcui/SPVCiwk
 famHkIvoRGFMGlzVE22ITOoYGLfQN13JEjtmufMpYKnXSAaMQFc93hWIHAuGz4uPHFY2Rj5nFOi
 fNxlNSXcFzhtix/v4+DwiuKZTi8PJevUzJhAhZJ/Etszh9BiEwFdfnA=
X-Received: by 2002:a05:6402:304f:b0:6ac:70ce:ba8 with SMTP id
 4fb4d7f45d1cf-6af9e35a2b5mr665872a12.35.1790921200000; Thu, 01 Oct 2026
 23:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-1-ea69b07afd31@rev.ng>
In-Reply-To: <20261001-rv-dedup-v1-1-ea69b07afd31@rev.ng>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 2 Oct 2026 14:06:26 +0800
X-Gm-Features: AclHuK_9_ONOur0BlIAIci8b7YHJwU6XHiodjQ56taB4l3UwDwUjq9TIxPQbPP8
Message-ID: <CAE2XoE_8xyc=nB9FKcEsTRuD1twkMPtRLE2XzOrff-Q83rmo8Q@mail.gmail.com>
Subject: Re: [PATCH 01/18] target/riscv: Make internals.h target agnostic
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
Content-Type: multipart/mixed; boundary="000000000000f29bea065cd5554f"
Received-SPF: pass client-ip=2a00:1450:4864:33::c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000f29bea065cd5554f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is what I did, It's in branch

https://gitlab.com/lygstate-qemu/qemu/-/tree/combined-binary-multi-targets?=
ref_type=3Dheads

On Thu, Oct 1, 2026 at 11:57=E2=80=AFPM Anton Johansson via qemu developmen=
t
<qemu-devel@nongnu.org> wrote:
>
> Replaces uses of target_ulong with fixed-size integers, this is a
> prerequisite step to compiling cpu.c once for system-mode.
>
> Note: the widening of target_long to int64_t in adjust_addr_body() is
> safe as rv32 is ruled out earlier in the function via the check
>
>   /* do nothing for rv32 mode */
>   if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
>       return addr;
>   }
>
> meaning target_long must be equal to int64_t anyway.
>
> Duplicate includes between vector_helper.c and vector_internals.h are
> removed.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/internals.h            | 31 +++++++++---------
>  target/riscv/tcg/vector_internals.h |  5 +--
>  target/riscv/tcg/vector_helper.c    | 64 +++++++++++++++++--------------=
------
>  3 files changed, 47 insertions(+), 53 deletions(-)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 1ee7e99e98..c963fae321 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -20,7 +20,6 @@
>  #define RISCV_CPU_INTERNALS_H
>
>  #include "exec/cpu-common.h"
> -#include "exec/target_long.h"
>  #include "hw/core/registerfields.h"
>  #include "fpu/softfloat-types.h"
>  #include "target/riscv/cpu_bits.h"
> @@ -98,10 +97,10 @@ FIELD(VDATA, NF, 7, 4)
>  FIELD(VDATA, WD, 7, 1)
>
>  /* float point classify helpers */
> -target_ulong fclass_h_bf16(uint64_t frs1);
> -target_ulong fclass_h(uint64_t frs1);
> -target_ulong fclass_s(uint64_t frs1);
> -target_ulong fclass_d(uint64_t frs1);
> +uint16_t fclass_h_bf16(bfloat16 frs1);
> +uint16_t fclass_h(float16 frs1);
> +uint16_t fclass_s(float32 frs1);
> +uint16_t fclass_d(float64 frs1);
>
>  #ifndef CONFIG_USER_ONLY
>  extern const VMStateDescription vmstate_riscv_cpu;
> @@ -185,7 +184,7 @@ static inline float16 check_nanbox_bf16(CPURISCVState=
 *env, uint64_t f)
>      }
>  }
>
> -static inline target_ulong get_xepc_mask(CPURISCVState *env)
> +static inline uint64_t get_xepc_mask(CPURISCVState *env)
>  {
>      RISCVCPU *cpu =3D env_archcpu(env);
>
> @@ -196,9 +195,9 @@ static inline target_ulong get_xepc_mask(CPURISCVStat=
e *env)
>      if (riscv_has_ext(env, RVC) || cpu->cfg.ext_zca ||
>          cpu->cfg.ext_zcb || cpu->cfg.ext_zcd || cpu->cfg.ext_zce ||
>          cpu->cfg.ext_zcf || cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt) {
> -        return ~(target_ulong)1;
> +        return ~1ull;
>      } else {
> -        return ~(target_ulong)3;
> +        return ~3ull;
>      }
>  }
>
> @@ -208,9 +207,9 @@ bool riscv_cpu_has_work(CPUState *cs);
>  #endif
>
>  /* Zjpm addr masking routine */
> -static inline target_ulong adjust_addr_body(CPURISCVState *env,
> -                                            target_ulong addr,
> -                                            bool is_virt_addr)
> +static inline uint64_t adjust_addr_body(CPURISCVState *env,
> +                                        uint64_t addr,
> +                                        bool is_virt_addr)
>  {
>      RISCVPmPmm pmm =3D PMM_FIELD_DISABLED;
>      uint32_t pmlen =3D 0;
> @@ -239,7 +238,7 @@ static inline target_ulong adjust_addr_body(CPURISCVS=
tate *env,
>
>      /* sign/zero extend masked address by N-1 bit */
>      if (signext) {
> -        addr =3D (target_long)addr >> pmlen;
> +        addr =3D (int64_t)addr >> pmlen;
>      } else {
>          addr =3D addr >> pmlen;
>      }
> @@ -247,14 +246,14 @@ static inline target_ulong adjust_addr_body(CPURISC=
VState *env,
>      return addr;
>  }
>
> -static inline target_ulong adjust_addr(CPURISCVState *env,
> -                                       target_ulong addr)
> +static inline uint64_t adjust_addr(CPURISCVState *env,
> +                                   uint64_t addr)
>  {
>      return adjust_addr_body(env, addr, false);
>  }
>
> -static inline target_ulong adjust_addr_virt(CPURISCVState *env,
> -                                            target_ulong addr)
> +static inline uint64_t adjust_addr_virt(CPURISCVState *env,
> +                                        uint64_t addr)
>  {
>      return adjust_addr_body(env, addr, true);
>  }
> diff --git a/target/riscv/tcg/vector_internals.h b/target/riscv/tcg/vecto=
r_internals.h
> index 5681b81815..7e186add2d 100644
> --- a/target/riscv/tcg/vector_internals.h
> +++ b/target/riscv/tcg/vector_internals.h
> @@ -20,10 +20,11 @@
>  #define TARGET_RISCV_VECTOR_INTERNALS_H
>
>  #include "qemu/bitops.h"
> +#include "exec/target_long.h"
>  #include "hw/core/registerfields.h"
> -#include "cpu.h"
> +#include "target/riscv/cpu.h"
> +#include "target/riscv/internals.h"
>  #include "tcg/tcg-gvec-desc.h"
> -#include "internals.h"
>
>  #define VSTART_CHECK_EARLY_EXIT(env, vl) do { \
>      if (env->vstart >=3D vl) {                  \
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_h=
elper.c
> index 0d1e4e0964..b4a07dbe13 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -19,7 +19,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/host-utils.h"
>  #include "qemu/bitops.h"
> -#include "cpu.h"
> +#include "target/riscv/tcg/vector_internals.h"
>  #include "exec/memop.h"
>  #include "accel/tcg/cpu-ldst.h"
>  #include "accel/tcg/probe.h"
> @@ -29,8 +29,6 @@
>  #include "exec/target_page.h"
>  #include "fpu/softfloat.h"
>  #include "tcg/tcg-gvec-desc.h"
> -#include "internals.h"
> -#include "vector_internals.h"
>  #include <math.h>
>
>  static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtyp=
e)
> @@ -4852,77 +4850,73 @@ GEN_VEXT_CMP_VF(vmfge_vf_w, uint32_t, H4, vmfge32=
)
>  GEN_VEXT_CMP_VF(vmfge_vf_d, uint64_t, H8, vmfge64)
>
>  /* Vector Floating-Point Classify Instruction */
> -target_ulong fclass_h_bf16(uint64_t frs1)
> +uint16_t fclass_h_bf16(bfloat16 frs1)
>  {
> -    bfloat16 f =3D frs1;
> -    bool sign =3D bfloat16_is_neg(f);
> +    bool sign =3D bfloat16_is_neg(frs1);
>
> -    if (bfloat16_is_infinity(f)) {
> +    if (bfloat16_is_infinity(frs1)) {
>          return sign ? 1 << 0 : 1 << 7;
> -    } else if (bfloat16_is_zero(f)) {
> +    } else if (bfloat16_is_zero(frs1)) {
>          return sign ? 1 << 3 : 1 << 4;
> -    } else if (bfloat16_is_zero_or_denormal(f)) {
> +    } else if (bfloat16_is_zero_or_denormal(frs1)) {
>          return sign ? 1 << 2 : 1 << 5;
> -    } else if (bfloat16_is_any_nan(f)) {
> +    } else if (bfloat16_is_any_nan(frs1)) {
>          float_status s =3D { }; /* for snan_bit_is_one */
> -        return bfloat16_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> +        return bfloat16_is_quiet_nan(frs1, &s) ? 1 << 9 : 1 << 8;
>      } else {
>          return sign ? 1 << 1 : 1 << 6;
>      }
>  }
>
> -target_ulong fclass_h(uint64_t frs1)
> +uint16_t fclass_h(float16 frs1)
>  {
> -    float16 f =3D frs1;
> -    bool sign =3D float16_is_neg(f);
> +    bool sign =3D float16_is_neg(frs1);
>
> -    if (float16_is_infinity(f)) {
> +    if (float16_is_infinity(frs1)) {
>          return sign ? 1 << 0 : 1 << 7;
> -    } else if (float16_is_zero(f)) {
> +    } else if (float16_is_zero(frs1)) {
>          return sign ? 1 << 3 : 1 << 4;
> -    } else if (float16_is_zero_or_denormal(f)) {
> +    } else if (float16_is_zero_or_denormal(frs1)) {
>          return sign ? 1 << 2 : 1 << 5;
> -    } else if (float16_is_any_nan(f)) {
> +    } else if (float16_is_any_nan(frs1)) {
>          float_status s =3D { }; /* for snan_bit_is_one */
> -        return float16_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> +        return float16_is_quiet_nan(frs1, &s) ? 1 << 9 : 1 << 8;
>      } else {
>          return sign ? 1 << 1 : 1 << 6;
>      }
>  }
>
> -target_ulong fclass_s(uint64_t frs1)
> +uint16_t fclass_s(float32 frs1)
>  {
> -    float32 f =3D frs1;
> -    bool sign =3D float32_is_neg(f);
> +    bool sign =3D float32_is_neg(frs1);
>
> -    if (float32_is_infinity(f)) {
> +    if (float32_is_infinity(frs1)) {
>          return sign ? 1 << 0 : 1 << 7;
> -    } else if (float32_is_zero(f)) {
> +    } else if (float32_is_zero(frs1)) {
>          return sign ? 1 << 3 : 1 << 4;
> -    } else if (float32_is_zero_or_denormal(f)) {
> +    } else if (float32_is_zero_or_denormal(frs1)) {
>          return sign ? 1 << 2 : 1 << 5;
> -    } else if (float32_is_any_nan(f)) {
> +    } else if (float32_is_any_nan(frs1)) {
>          float_status s =3D { }; /* for snan_bit_is_one */
> -        return float32_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> +        return float32_is_quiet_nan(frs1, &s) ? 1 << 9 : 1 << 8;
>      } else {
>          return sign ? 1 << 1 : 1 << 6;
>      }
>  }
>
> -target_ulong fclass_d(uint64_t frs1)
> +uint16_t fclass_d(float64 frs1)
>  {
> -    float64 f =3D frs1;
> -    bool sign =3D float64_is_neg(f);
> +    bool sign =3D float64_is_neg(frs1);
>
> -    if (float64_is_infinity(f)) {
> +    if (float64_is_infinity(frs1)) {
>          return sign ? 1 << 0 : 1 << 7;
> -    } else if (float64_is_zero(f)) {
> +    } else if (float64_is_zero(frs1)) {
>          return sign ? 1 << 3 : 1 << 4;
> -    } else if (float64_is_zero_or_denormal(f)) {
> +    } else if (float64_is_zero_or_denormal(frs1)) {
>          return sign ? 1 << 2 : 1 << 5;
> -    } else if (float64_is_any_nan(f)) {
> +    } else if (float64_is_any_nan(frs1)) {
>          float_status s =3D { }; /* for snan_bit_is_one */
> -        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> +        return float64_is_quiet_nan(frs1, &s) ? 1 << 9 : 1 << 8;
>      } else {
>          return sign ? 1 << 1 : 1 << 6;
>      }
>
> --
> 2.52.0
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000f29bea065cd5554f
Content-Type: text/plain; charset="US-ASCII"; 
	name="0001-target-riscv-preserve-signed-XLEN-semantics-without-.patch"
Content-Disposition: attachment; 
	filename="0001-target-riscv-preserve-signed-XLEN-semantics-without-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_muqk7klb0>
X-Attachment-Id: f_muqk7klb0

RnJvbSAzOTEwZTRiNmZmYmNjYmZmNmY2Mzk4NWZiYWI4YzI5OGNmMzljY2VlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nZ2FuZyBMdW8gPGx1b3lvbmdnYW5nQGdtYWlsLmNvbT4K
RGF0ZTogU2F0LCAxMiBTZXAgMjAyNiAwMDoxNjoyOCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHRh
cmdldC9yaXNjdjogcHJlc2VydmUgc2lnbmVkIFhMRU4gc2VtYW50aWNzIHdpdGhvdXQKIHRhcmdl
dF9sb25nCgpNYXNrIHBvaW50ZXItbWFza2VkIGFkZHJlc3NlcyB3aXRoIGV4dHJhY3Q2NC9zZXh0
cmFjdDY0IGF0IHJ1bnRpbWUKWExFTiBpbnN0ZWFkIG9mIGEgdGFyZ2V0X2xvbmcgYXJpdGhtZXRp
YyBzaGlmdC4gUGFzcyB2ZWN0b3IgdngKc2NhbGFycyBhcyBpbnQ2NF90IGFmdGVyIHNleHRyYWN0
NjQgZnJvbSB0aGUgaGVscGVyIHRsIHNsb3Qgc28KUlYzMiBrZWVwcyBiaXQgMzEgYXMgdGhlIHNp
Z24gYml0LiBMZWF2ZSBldmVyeSB0YXJnZXRfdWxvbmcgaGVscGVyCmFyZ3VtZW50IHVuY2hhbmdl
ZC4KClNpZ25lZC1vZmYtYnk6IFlvbmdnYW5nIEx1byA8bHVveW9uZ2dhbmdAZ21haWwuY29tPgot
LS0KIHRhcmdldC9yaXNjdi9pbnRlcm5hbHMuaCAgICAgICAgICAgIHwgMTIgKysrKysrKystLS0t
CiB0YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9oZWxwZXIuYyAgICB8IDMwICsrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tCiB0YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9pbnRlcm5hbHMuYyB8ICAy
ICstCiB0YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9pbnRlcm5hbHMuaCB8ICA5ICsrKysrLS0tLQog
NCBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS90YXJnZXQvcmlzY3YvaW50ZXJuYWxzLmggYi90YXJnZXQvcmlzY3YvaW50ZXJuYWxz
LmgKaW5kZXggMWVlN2U5OWU5OC4uMDg0NDg2NzI0NiAxMDA2NDQKLS0tIGEvdGFyZ2V0L3Jpc2N2
L2ludGVybmFscy5oCisrKyBiL3RhcmdldC9yaXNjdi9pbnRlcm5hbHMuaApAQCAtMjE0LDYgKzIx
NCw3IEBAIHN0YXRpYyBpbmxpbmUgdGFyZ2V0X3Vsb25nIGFkanVzdF9hZGRyX2JvZHkoQ1BVUklT
Q1ZTdGF0ZSAqZW52LAogewogICAgIFJJU0NWUG1QbW0gcG1tID0gUE1NX0ZJRUxEX0RJU0FCTEVE
OwogICAgIHVpbnQzMl90IHBtbGVuID0gMDsKKyAgICB1bnNpZ25lZCBrZXB0OwogICAgIGJvb2wg
c2lnbmV4dCA9IGZhbHNlOwogCiAgICAgLyogZG8gbm90aGluZyBmb3IgcnYzMiBtb2RlICovCkBA
IC0yMzUsMTMgKzIzNiwxNiBAQCBzdGF0aWMgaW5saW5lIHRhcmdldF91bG9uZyBhZGp1c3RfYWRk
cl9ib2R5KENQVVJJU0NWU3RhdGUgKmVudiwKIAogICAgIHNpZ25leHQgPSByaXNjdl9jcHVfdmly
dF9tZW1fZW5hYmxlZChlbnYsIGlzX3ZpcnRfYWRkcik7CiAgICAgcG1sZW4gPSByaXNjdl9wbV9n
ZXRfcG1sZW4ocG1tKTsKLSAgICBhZGRyID0gYWRkciA8PCBwbWxlbjsKIAotICAgIC8qIHNpZ24v
emVybyBleHRlbmQgbWFza2VkIGFkZHJlc3MgYnkgTi0xIGJpdCAqLworICAgIC8qCisgICAgICog
RHJvcCB0aGUgdG9wIHBtbGVuIGJpdHMgb2YgWExFTi4gRG8gbm90IHJlbHkgb24gdGFyZ2V0X3Vs
b25nCisgICAgICogc2hpZnQgd3JhcDsgY29tbW9uLXN5c3RlbSB0YXJnZXRfdWxvbmcgaXMgYWx3
YXlzIDY0IGJpdHMuCisgICAgICovCisgICAga2VwdCA9IHRhcmdldF9sb25nX2JpdHMoKSAtIHBt
bGVuOwogICAgIGlmIChzaWduZXh0KSB7Ci0gICAgICAgIGFkZHIgPSAodGFyZ2V0X2xvbmcpYWRk
ciA+PiBwbWxlbjsKKyAgICAgICAgYWRkciA9IHNleHRyYWN0NjQoYWRkciwgMCwga2VwdCk7CiAg
ICAgfSBlbHNlIHsKLSAgICAgICAgYWRkciA9IGFkZHIgPj4gcG1sZW47CisgICAgICAgIGFkZHIg
PSBleHRyYWN0NjQoYWRkciwgMCwga2VwdCk7CiAgICAgfQogCiAgICAgcmV0dXJuIGFkZHI7CmRp
ZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9oZWxwZXIuYyBiL3RhcmdldC9yaXNj
di90Y2cvdmVjdG9yX2hlbHBlci5jCmluZGV4IDBkMWU0ZTA5NjQuLjNhMjY2MWIzODEgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9yaXNjdi90Y2cvdmVjdG9yX2hlbHBlci5jCisrKyBiL3RhcmdldC9yaXNj
di90Y2cvdmVjdG9yX2hlbHBlci5jCkBAIC0xMjQwLDYgKzEyNDAsNyBAQCB2b2lkIEhFTFBFUihO
QU1FKSh2b2lkICp2ZCwgdm9pZCAqdjAsIHRhcmdldF91bG9uZyBzMSwgdm9pZCAqdnMyLCAgICAg
ICAgXAogICAgIHVpbnQzMl90IGVzeiA9IHNpemVvZihFVFlQRSk7ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKICAgICB1aW50MzJfdCB0b3RhbF9lbGVtcyA9IHZleHRf
Z2V0X3RvdGFsX2VsZW1zKGVudiwgZGVzYywgZXN6KTsgICAgICAgICBcCiAgICAgdWludDMyX3Qg
dnRhID0gdmV4dF92dGEoZGVzYyk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXAorICAgIEVUWVBFIHNjYWxhciA9IChFVFlQRSlzZXh0cmFjdDY0KHMxLCAwLCB0YXJnZXRf
bG9uZ19iaXRzKCkpOyAgICAgICAgIFwKICAgICB1aW50MzJfdCBpOyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXAogICAgIFZTVEFSVF9DSEVDS19FQVJMWV9FWElUKGVudiwgdmwpOyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKQEAgLTEyNDgsNyArMTI0OSw3IEBAIHZvaWQgSEVMUEVS
KE5BTUUpKHZvaWQgKnZkLCB2b2lkICp2MCwgdGFyZ2V0X3Vsb25nIHMxLCB2b2lkICp2czIsICAg
ICAgICBcCiAgICAgICAgIEVUWVBFIHMyID0gKigoRVRZUEUgKil2czIgKyBIKGkpKTsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgICAgICBFVFlQRSBjYXJyeSA9IHZleHRfZWxl
bV9tYXNrKHYwLCBpKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcCi0gICAgICAgICooKEVUWVBFICopdmQgKyBIKGkpKSA9IERPX09QKHMyLCAoRVRZUEUp
KHRhcmdldF9sb25nKXMxLCBjYXJyeSk7XAorICAgICAgICAqKChFVFlQRSAqKXZkICsgSChpKSkg
PSBET19PUChzMiwgc2NhbGFyLCBjYXJyeSk7ICAgICAgICAgICAgICAgIFwKICAgICB9ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcCiAgICAgZW52LT52c3RhcnQgPSAwOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgIC8qIHNldCB0YWlsIGVsZW1lbnRzIHRvIDFz
ICovICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKQEAgLTEzMTcsMTUg
KzEzMTgsMTYgQEAgdm9pZCBIRUxQRVIoTkFNRSkodm9pZCAqdmQsIHZvaWQgKnYwLCB0YXJnZXRf
dWxvbmcgczEsICAgICAgICAgIFwKICAgICB1aW50MzJfdCB2bSA9IHZleHRfdm0oZGVzYyk7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgdWludDMyX3QgdG90YWxfZWxlbXMg
PSByaXNjdl9jcHVfY2ZnKGVudiktPnZsZW5iIDw8IDM7ICAgICAgXAogICAgIHVpbnQzMl90IHZ0
YV9hbGxfMXMgPSB2ZXh0X3Z0YV9hbGxfMXMoZGVzYyk7ICAgICAgICAgICAgICAgIFwKKyAgICBF
VFlQRSBzY2FsYXI7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcCiAgICAgdWludDMyX3QgaTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKICAgICBWU1RBUlRfQ0hFQ0tfRUFSTFlfRVhJVChlbnYs
IHZsKTsgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgIHNjYWxhciA9
IChFVFlQRSlzZXh0cmFjdDY0KHMxLCAwLCB0YXJnZXRfbG9uZ19iaXRzKCkpOyAgICAgIFwKICAg
ICBmb3IgKGkgPSBlbnYtPnZzdGFydDsgaSA8IHZsOyBpKyspIHsgICAgICAgICAgICAgICAgICAg
ICAgICBcCiAgICAgICAgIEVUWVBFIHMyID0gKigoRVRZUEUgKil2czIgKyBIKGkpKTsgICAgICAg
ICAgICAgICAgICAgICAgXAogICAgICAgICBFVFlQRSBjYXJyeSA9ICF2bSAmJiB2ZXh0X2VsZW1f
bWFzayh2MCwgaSk7ICAgICAgICAgICAgIFwKLSAgICAgICAgdmV4dF9zZXRfZWxlbV9tYXNrKHZk
LCBpLCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCi0gICAgICAgICAgICAgICAgRE9f
T1AoczIsIChFVFlQRSkodGFyZ2V0X2xvbmcpczEsIGNhcnJ5KSk7ICAgICAgXAorICAgICAgICB2
ZXh0X3NldF9lbGVtX21hc2sodmQsIGksIERPX09QKHMyLCBzY2FsYXIsIGNhcnJ5KSk7ICAgIFwK
ICAgICB9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCiAgICAgZW52LT52c3RhcnQgPSAwOyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXAogICAgIC8qCkBAIC0xNTk1LDYgKzE1OTcsNyBAQCB2b2lkIEhF
TFBFUihOQU1FKSh2b2lkICp2ZCwgdm9pZCAqdjAsIHRhcmdldF91bG9uZyBzMSwgdm9pZCAqdnMy
LCAgIFwKICAgICB1aW50MzJfdCB0b3RhbF9lbGVtcyA9IHJpc2N2X2NwdV9jZmcoZW52KS0+dmxl
bmIgPDwgMzsgICAgICAgICAgXAogICAgIHVpbnQzMl90IHZ0YV9hbGxfMXMgPSB2ZXh0X3Z0YV9h
bGxfMXMoZGVzYyk7ICAgICAgICAgICAgICAgICAgICBcCiAgICAgdWludDMyX3Qgdm1hID0gdmV4
dF92bWEoZGVzYyk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICBFVFlQ
RSBzY2FsYXIgPSAoRVRZUEUpc2V4dHJhY3Q2NChzMSwgMCwgdGFyZ2V0X2xvbmdfYml0cygpKTsg
ICAgXAogICAgIHVpbnQzMl90IGk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICBWU1RBUlRfQ0hFQ0tfRUFSTFlf
RVhJVChlbnYsIHZsKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXApAQCAtMTYwOCw4
ICsxNjExLDcgQEAgdm9pZCBIRUxQRVIoTkFNRSkodm9pZCAqdmQsIHZvaWQgKnYwLCB0YXJnZXRf
dWxvbmcgczEsIHZvaWQgKnZzMiwgICBcCiAgICAgICAgICAgICB9ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAgIGNvbnRp
bnVlOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAg
ICAgICB9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCi0gICAgICAgIHZleHRfc2V0X2VsZW1fbWFzayh2ZCwgaSwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKLSAgICAgICAgICAgICAgICBET19PUChzMiwgKEVUWVBF
KSh0YXJnZXRfbG9uZylzMSkpOyAgICAgICAgICAgICAgICAgXAorICAgICAgICB2ZXh0X3NldF9l
bGVtX21hc2sodmQsIGksIERPX09QKHMyLCBzY2FsYXIpKTsgICAgICAgICAgICAgICBcCiAgICAg
fSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwKICAgICBlbnYtPnZzdGFydCA9IDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXAogICAgIC8qCkBAIC0yMDUwLDcgKzIwNTIsNyBAQCBHRU5f
VkVYVF9WVih2bm1zdWJfdnZfdywgNCkKIEdFTl9WRVhUX1ZWKHZubXN1Yl92dl9kLCA4KQogCiAj
ZGVmaW5lIE9QSVZYMyhOQU1FLCBURCwgVDEsIFQyLCBUWDEsIFRYMiwgSEQsIEhTMiwgT1ApICAg
ICAgICAgICAgIFwKLXN0YXRpYyB2b2lkIGRvXyMjTkFNRSh2b2lkICp2ZCwgdGFyZ2V0X2xvbmcg
czEsIHZvaWQgKnZzMiwgaW50IGkpICAgXAorc3RhdGljIHZvaWQgZG9fIyNOQU1FKHZvaWQgKnZk
LCBpbnQ2NF90IHMxLCB2b2lkICp2czIsIGludCBpKSAgICAgICBcCiB7ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAg
ICBUWDIgczIgPSAqKChUMiAqKXZzMiArIEhTMihpKSk7ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXAogICAgIFREIGQgPSAqKChURCAqKXZkICsgSEQoaSkpOyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcCkBAIC0yMjM5LDE0ICsyMjQxLDE0IEBAIHZvaWQgSEVM
UEVSKE5BTUUpKHZvaWQgKnZkLCB2b2lkICp2MCwgdGFyZ2V0X3Vsb25nIHMxLCAgICAgICAgICAg
ICAgIFwKICAgICB1aW50MzJfdCBlc3ogPSBzaXplb2YoRVRZUEUpOyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwKICAgICB1aW50MzJfdCB0b3RhbF9lbGVtcyA9IHZleHRfZ2V0
X3RvdGFsX2VsZW1zKGVudiwgZGVzYywgZXN6KTsgICAgIFwKICAgICB1aW50MzJfdCB2dGEgPSB2
ZXh0X3Z0YShkZXNjKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICBF
VFlQRSBzY2FsYXIgPSAoRVRZUEUpc2V4dHJhY3Q2NChzMSwgMCwgdGFyZ2V0X2xvbmdfYml0cygp
KTsgICAgIFwKICAgICB1aW50MzJfdCBpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICBWU1RBUlRfQ0hFQ0tf
RUFSTFlfRVhJVChlbnYsIHZsKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKICAgICBmb3IgKGkgPSBlbnYtPnZzdGFydDsgaSA8IHZsOyBpKyspIHsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgICAgRVRZUEUgczIgPSAqKChFVFlQRSAq
KXZzMiArIEgoaSkpOyAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKLSAgICAgICAgRVRZUEUg
ZCA9ICghdmV4dF9lbGVtX21hc2sodjAsIGkpID8gczIgOiAgICAgICAgICAgICAgICAgICAgIFwK
LSAgICAgICAgICAgICAgICAgICAoRVRZUEUpKHRhcmdldF9sb25nKXMxKTsgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwKKyAgICAgICAgRVRZUEUgZCA9ICghdmV4dF9lbGVtX21hc2sodjAsIGkp
ID8gczIgOiBzY2FsYXIpOyAgICAgICAgICAgIFwKICAgICAgICAgKigoRVRZUEUgKil2ZCArIEgo
aSkpID0gZDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICB9ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwKICAgICBlbnYtPnZzdGFydCA9IDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKQEAgLTIzOTcsMTIgKzIzOTksMTIgQEAgR0VOX1ZFWFRfVlZfUk0o
dnNhZGR1X3Z2X2gsIDIpCiBHRU5fVkVYVF9WVl9STSh2c2FkZHVfdnZfdywgNCkKIEdFTl9WRVhU
X1ZWX1JNKHZzYWRkdV92dl9kLCA4KQogCi10eXBlZGVmIHZvaWQgb3BpdngyX3JtX2ZuKHZvaWQg
KnZkLCB0YXJnZXRfbG9uZyBzMSwgdm9pZCAqdnMyLCBpbnQgaSwKK3R5cGVkZWYgdm9pZCBvcGl2
eDJfcm1fZm4odm9pZCAqdmQsIGludDY0X3QgczEsIHZvaWQgKnZzMiwgaW50IGksCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIENQVVJJU0NWU3RhdGUgKmVudiwgdWludDhfdCB2eHJtKTsKIAog
I2RlZmluZSBPUElWWDJfUk0oTkFNRSwgVEQsIFQxLCBUMiwgVFgxLCBUWDIsIEhELCBIUzIsIE9Q
KSAgICAgICAgICBcCiBzdGF0aWMgaW5saW5lIHZvaWQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwKLWRvXyMjTkFNRSh2b2lkICp2ZCwgdGFyZ2V0X2xv
bmcgczEsIHZvaWQgKnZzMiwgaW50IGksICAgICAgICAgICAgICAgXAorZG9fIyNOQU1FKHZvaWQg
KnZkLCBpbnQ2NF90IHMxLCB2b2lkICp2czIsIGludCBpLCAgICAgICAgICAgICAgICAgICBcCiAg
ICAgICAgICAgQ1BVUklTQ1ZTdGF0ZSAqZW52LCB1aW50OF90IHZ4cm0pICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgIFRYMiBzMiA9ICooKFQyICopdnMyICsgSFMy
KGkpKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCkBAIC0yNDEwLDcgKzI0MTIs
NyBAQCBkb18jI05BTUUodm9pZCAqdmQsIHRhcmdldF9sb25nIHMxLCB2b2lkICp2czIsIGludCBp
LCAgICAgICAgICAgICAgIFwKIH0KIAogc3RhdGljIGlubGluZSB2b2lkCi12ZXh0X3Z4X3JtXzEo
dm9pZCAqdmQsIHZvaWQgKnYwLCB0YXJnZXRfbG9uZyBzMSwgdm9pZCAqdnMyLAordmV4dF92eF9y
bV8xKHZvaWQgKnZkLCB2b2lkICp2MCwgaW50NjRfdCBzMSwgdm9pZCAqdnMyLAogICAgICAgICAg
ICAgIENQVVJJU0NWU3RhdGUgKmVudiwKICAgICAgICAgICAgICB1aW50MzJfdCB2bCwgdWludDMy
X3Qgdm0sIHVpbnQ4X3QgdnhybSwKICAgICAgICAgICAgICBvcGl2eDJfcm1fZm4gKmZuLCB1aW50
MzJfdCB2bWEsIHVpbnQzMl90IGVzeikKQEAgLTI0MjcsNyArMjQyOSw3IEBAIHZleHRfdnhfcm1f
MSh2b2lkICp2ZCwgdm9pZCAqdjAsIHRhcmdldF9sb25nIHMxLCB2b2lkICp2czIsCiB9CiAKIHN0
YXRpYyBpbmxpbmUgdm9pZAotdmV4dF92eF9ybV8yKHZvaWQgKnZkLCB2b2lkICp2MCwgdGFyZ2V0
X2xvbmcgczEsIHZvaWQgKnZzMiwKK3ZleHRfdnhfcm1fMih2b2lkICp2ZCwgdm9pZCAqdjAsIGlu
dDY0X3QgczEsIHZvaWQgKnZzMiwKICAgICAgICAgICAgICBDUFVSSVNDVlN0YXRlICplbnYsCiAg
ICAgICAgICAgICAgdWludDMyX3QgZGVzYywKICAgICAgICAgICAgICBvcGl2eDJfcm1fZm4gKmZu
LCB1aW50MzJfdCBlc3opCkBAIC0yNDY4LDcgKzI0NzAsOSBAQCB2b2lkIEhFTFBFUihOQU1FKSh2
b2lkICp2ZCwgdm9pZCAqdjAsIHRhcmdldF91bG9uZyBzMSwgICAgXAogICAgICAgICAgICAgICAg
ICAgdm9pZCAqdnMyLCBDUFVSSVNDVlN0YXRlICplbnYsICAgICAgICAgIFwKICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IGRlc2MpICAgICAgICAgICAgICAgICAgICAgICAgICBcCiB7ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAotICAg
IHZleHRfdnhfcm1fMih2ZCwgdjAsIHMxLCB2czIsIGVudiwgZGVzYywgICAgICAgICAgICAgIFwK
KyAgICBpbnQ2NF90IHNjYWxhcjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcCisgICAgc2NhbGFyID0gc2V4dHJhY3Q2NChzMSwgMCwgdGFyZ2V0X2xvbmdfYml0cygpKTsg
ICAgICAgXAorICAgIHZleHRfdnhfcm1fMih2ZCwgdjAsIHNjYWxhciwgdnMyLCBlbnYsIGRlc2Ms
ICAgICAgICAgIFwKICAgICAgICAgICAgICAgICAgZG9fIyNOQU1FLCBFU1opOyAgICAgICAgICAg
ICAgICAgICAgICAgICBcCiB9CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvdmVjdG9y
X2ludGVybmFscy5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy92ZWN0b3JfaW50ZXJuYWxzLmMKaW5kZXgg
YjQ5MGIxZDM5OC4uOTUzMjcwNTI2NiAxMDA2NDQKLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy92ZWN0
b3JfaW50ZXJuYWxzLmMKKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy92ZWN0b3JfaW50ZXJuYWxzLmMK
QEAgLTgxLDcgKzgxLDcgQEAgdm9pZCBkb192ZXh0X3Z2KHZvaWQgKnZkLCB2b2lkICp2MCwgdm9p
ZCAqdnMxLCB2b2lkICp2czIsCiAgICAgdmV4dF9zZXRfZWxlbXNfMXModmQsIHZ0YSwgdmwgKiBl
c3osIHRvdGFsX2VsZW1zICogZXN6KTsKIH0KIAotdm9pZCBkb192ZXh0X3Z4KHZvaWQgKnZkLCB2
b2lkICp2MCwgdGFyZ2V0X2xvbmcgczEsIHZvaWQgKnZzMiwKK3ZvaWQgZG9fdmV4dF92eCh2b2lk
ICp2ZCwgdm9pZCAqdjAsIGludDY0X3QgczEsIHZvaWQgKnZzMiwKICAgICAgICAgICAgICAgICBD
UFVSSVNDVlN0YXRlICplbnYsIHVpbnQzMl90IGRlc2MsCiAgICAgICAgICAgICAgICAgb3Bpdngy
X2ZuIGZuLCB1aW50MzJfdCBlc3opCiB7CmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL3Zl
Y3Rvcl9pbnRlcm5hbHMuaCBiL3RhcmdldC9yaXNjdi90Y2cvdmVjdG9yX2ludGVybmFscy5oCmlu
ZGV4IDU2ODFiODE4MTUuLmRhMDkzZDU2MWUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9yaXNjdi90Y2cv
dmVjdG9yX2ludGVybmFscy5oCisrKyBiL3RhcmdldC9yaXNjdi90Y2cvdmVjdG9yX2ludGVybmFs
cy5oCkBAIC0yMDEsMjAgKzIwMSwyMCBAQCB2b2lkIEhFTFBFUihOQU1FKSh2b2lkICp2ZCwgdm9p
ZCAqdjAsIHZvaWQgKnZzMSwgICAgICAgICAgXAogICAgICAgICAgICAgICAgZG9fIyNOQU1FLCBF
U1opOyAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKIH0KIAotdHlwZWRlZiB2b2lkIG9waXZ4
Ml9mbih2b2lkICp2ZCwgdGFyZ2V0X2xvbmcgczEsIHZvaWQgKnZzMiwgaW50IGkpOwordHlwZWRl
ZiB2b2lkIG9waXZ4Ml9mbih2b2lkICp2ZCwgaW50NjRfdCBzMSwgdm9pZCAqdnMyLCBpbnQgaSk7
CiAKIC8qCiAgKiAoVDEpczEgZ2l2ZXMgdGhlIHJlYWwgb3BlcmF0b3IgdHlwZS4KICAqIChUWDEp
KFQxKXMxIGV4cGFuZHMgdGhlIG9wZXJhdG9yIHR5cGUgb2Ygd2lkZW4gb3IgbmFycm93IG9wZXJh
dGlvbnMuCiAgKi8KICNkZWZpbmUgT1BJVlgyKE5BTUUsIFRELCBUMSwgVDIsIFRYMSwgVFgyLCBI
RCwgSFMyLCBPUCkgICAgICAgICAgICAgXAotc3RhdGljIHZvaWQgZG9fIyNOQU1FKHZvaWQgKnZk
LCB0YXJnZXRfbG9uZyBzMSwgdm9pZCAqdnMyLCBpbnQgaSkgICBcCitzdGF0aWMgdm9pZCBkb18j
I05BTUUodm9pZCAqdmQsIGludDY0X3QgczEsIHZvaWQgKnZzMiwgaW50IGkpICAgICAgIFwKIHsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXAogICAgIFRYMiBzMiA9ICooKFQyICopdnMyICsgSFMyKGkpKTsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgKigoVEQgKil2ZCArIEhEKGkpKSA9IE9QKHMy
LCAoVFgxKShUMSlzMSk7ICAgICAgICAgICAgICAgICAgICAgIFwKIH0KIAotdm9pZCBkb192ZXh0
X3Z4KHZvaWQgKnZkLCB2b2lkICp2MCwgdGFyZ2V0X2xvbmcgczEsIHZvaWQgKnZzMiwKK3ZvaWQg
ZG9fdmV4dF92eCh2b2lkICp2ZCwgdm9pZCAqdjAsIGludDY0X3QgczEsIHZvaWQgKnZzMiwKICAg
ICAgICAgICAgICAgICBDUFVSSVNDVlN0YXRlICplbnYsIHVpbnQzMl90IGRlc2MsCiAgICAgICAg
ICAgICAgICAgb3BpdngyX2ZuIGZuLCB1aW50MzJfdCBlc3opOwogCkBAIC0yMjQsNyArMjI0LDgg
QEAgdm9pZCBIRUxQRVIoTkFNRSkodm9pZCAqdmQsIHZvaWQgKnYwLCB0YXJnZXRfdWxvbmcgczEs
ICAgIFwKICAgICAgICAgICAgICAgICAgIHZvaWQgKnZzMiwgQ1BVUklTQ1ZTdGF0ZSAqZW52LCAg
ICAgICAgICBcCiAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBkZXNjKSAgICAgICAgICAgICAg
ICAgICAgICAgICAgXAogeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKLSAgICBkb192ZXh0X3Z4KHZkLCB2MCwgczEsIHZzMiwgZW52LCBk
ZXNjLCAgICAgICAgICAgICAgICBcCisgICAgZG9fdmV4dF92eCh2ZCwgdjAsIHNleHRyYWN0NjQo
czEsIDAsIHRhcmdldF9sb25nX2JpdHMoKSksIFwKKyAgICAgICAgICAgICAgIHZzMiwgZW52LCBk
ZXNjLCAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAgICBkb18jI05B
TUUsIEVTWik7ICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogfQogCi0tIAoyLjU1LjAud2lu
ZG93cy4zCgo=
--000000000000f29bea065cd5554f--

