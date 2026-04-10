Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDD0F36BA4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 03:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB2FO-0007EM-6S; Thu, 09 Apr 2026 23:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB2FM-0007E1-Ov
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:09:28 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB2FL-0002ID-3Q
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:09:28 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-66ec3b7b1deso2378205a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 20:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775790565; cv=none;
 d=google.com; s=arc-20240605;
 b=CWWwJae2MShmGhpbDZtIdS7asIRkDXd49Y9e+uaJRvAqS1YF06URXGpmmDuWLOdzbp
 GBbziqHBFjM9Ls5ybhgp/i/T3Ar4r6dOwWgYz6NZ/JDdVulurbG31+7M9aleepIKvUPB
 a8SkYejfG6vOchm3vrRKFoh7Cx91Bn9GuLtq/JHxw4ytskOtSQKcuxMfLoQNPhV+vCWe
 EU2MhHu1z3Y339P8FfLjc7sTKHkhct/qcL92aPDC/1VlDpWpmASM9yYC2xAYdQEtQdB7
 KxgDfa5T15vgVVm9/RHosLN43f4iGo0o+al0D+Zfr5O/1XxjzC/73hj65Hy2Krv0rsu1
 iZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BcNwny8wyNt8LtwGmNYf4OQ39okzkFiw+z+OlIqhKJo=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=RK4vfHNWj9isO3pyGfM7/kgh9mZKYAzpl+1M9w0/ffPcUgofRSFYbm+jU+mezY4CxQ
 5hYevUfzL+W54BoRGALcHcJeN5kwEATZ7ylcdPFatLZFMhr8jLqaBkb9mqAN24syG3sX
 GtmdU0/pR8srVNkIodBufNLR+aSDwQjcxnfznR5iAfHlhQU4D7u15aSzYUJ25gvE4gd3
 oPglpvEcna3OMUg1f/y93gdHZaPoFOB2fIDM2OBFdKYHH2xOuqc3ViEKmYIfRMZ62HnW
 4KYERTe3dnCMMLiefLZCX0rzJ3vrneLUQcNbJvh7blx9CoScNLum5eb2t4SpgrFGsoM7
 Bmvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775790565; x=1776395365; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcNwny8wyNt8LtwGmNYf4OQ39okzkFiw+z+OlIqhKJo=;
 b=fnmJEu+8+4EXVK2eun5/U2K9fDdxyGsHKGS5gUWtc3Co2Z3rf/XaYh5uMJo1MKMHId
 8eQDSO1gBmvNOqpeSBhAkE2slKAisceCRadKma3RicQTRBzrCIlrCRMJ96sIcFlqXCfW
 vPsEp4gy03qu/5JQCo9hGE133x5fye10G3aYv/jLgh/w7CqYfx4K2nypnBOh4TzTknU+
 3VEwaEcBXQWLAEBcsrs/dWIJ73b+0UBYAJrIhOkQRcyKxJK1HcmVA4+A0+ICfP4caGLa
 x3yIiIkfBLAsijGdUgFjDq19QyFLKSXiymRlBG7KUT/OMN0Wsk3+TsRCuvI1xHpgIC2K
 3C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775790565; x=1776395365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BcNwny8wyNt8LtwGmNYf4OQ39okzkFiw+z+OlIqhKJo=;
 b=KjOuyG6/mH8MsILzkJ0B6Qt+Z5ziRDPSak7lOy4R5JQ543zssLhxLQoPAfrhg4DH5E
 xRlkUquAr6Wz947NqRMNabndEtDj6a0rRYrKupXP4vDP1/T5CNCXOq2PYUUIXTHOk/vF
 i5gJXqm8kG+qkjKFI5v6EVFLejJpBwgiLsajA16GSdwuGpeIJxiSh6xYVFXZwvQTlJ+G
 372pN70bn1tmqVlZPDWAuZ+Fa0xTgRa9yDWVrwtftjSYeYtwWabFhM/eRBhzUuUzrHiq
 RP+l2ypYCnz1F5I0EekaHSbBE+Xd4upRs9auH+ZTlAYX8A3m8JON8wmtRAvvItY+0Zmh
 +vUA==
X-Gm-Message-State: AOJu0YxZ7t+WL82oaad1o6reLrykFhoP9v1kvf3lim5o39wmz91ao5z9
 ztntDhrls3J/l3loIrM88/LxuJ1PC/YvtrLHJMx0S81Am2Ub0Xs6Xqm1C8+yAJMk8WU0B2/JD/9
 MbUL+FkYfcu8K8taw5AUXyJaHFoC4zUQ=
X-Gm-Gg: AeBDieuzv6PdS8sHXiOJ4hEUlspW6E9xZ5LU6yKYhkvgvBuslDKtfWogo7JhD01wU0S
 EiovopS1qgPbVxDqJvkAL6bvK3G06E2uZtkGRgMaLXUOnR0lmcgPM6lsr09IPH3Huj/dMHWJQ2p
 MJI4m4Q9HsTetTNmunfALVA5y46jVo+tkYCusU2q1KRupXBs8m7pUBv/3ewjcKmHuhJqwb5jTlF
 It2E5khX2sfkBZl23dxCYXUpaeKMBYPuDWuMqO92lDnw2Ira1VtX0i1XjzxDSi8vQlUnQL9Ulqb
 8Hfaljmd8NJdlZD4MlJM4U3bbCSdN7GOvB0zEjUcnP7hH7QV
X-Received: by 2002:a17:907:6c0f:b0:b97:e32f:7ee8 with SMTP id
 a640c23a62f3a-b9d7298ffe1mr76763266b.37.1775790564913; Thu, 09 Apr 2026
 20:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260402125234.1371897-1-max.chou@sifive.com>
 <20260402125234.1371897-6-max.chou@sifive.com>
In-Reply-To: <20260402125234.1371897-6-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 13:08:58 +1000
X-Gm-Features: AQROBzBTr3Kdo78Y0rCZKcEb6R6UH4FkP1U6PLofrrsxpLHhRi7I-8YUmoH5nqA
Message-ID: <CAKmqyKNDyZZjr_TWeKe1b2tfGN5+-b4P9d60PP06A5f-4gvF=Q@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] target/riscv: Use the tb->cs_base as the extend tb
 flags
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
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Thu, Apr 2, 2026 at 11:53=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> We have more than 32-bits worth of state per TB, so use the
> tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/exec/translation-block.h | 1 +
>  target/riscv/cpu.h               | 3 +++
>  target/riscv/tcg/tcg-cpu.c       | 7 ++++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/exec/translation-block.h b/include/exec/translation-=
block.h
> index 4f83d5bec9..40cc699031 100644
> --- a/include/exec/translation-block.h
> +++ b/include/exec/translation-block.h
> @@ -65,6 +65,7 @@ struct TranslationBlock {
>       * arm: an extension of tb->flags,
>       * s390x: instruction data for EXECUTE,
>       * sparc: the next pc of the instruction queue (for delay slots).
> +     * riscv: an extension of tb->flags,
>       */
>      uint64_t cs_base;
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 962cc45073..4c0676ed53 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -703,6 +703,9 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
>  FIELD(TB_FLAGS, PM_PMM, 29, 2)
>  FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
>
> +FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
> +FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
> +
>  #ifdef TARGET_RISCV32
>  #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
>  #else
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index c4f7da7193..f3f7808895 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -104,6 +104,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState =
*cs)
>      RISCVCPU *cpu =3D env_archcpu(env);
>      RISCVExtStatus fs, vs;
>      uint32_t flags =3D 0;
> +    uint64_t ext_flags =3D 0;
>      bool pm_signext =3D riscv_cpu_virt_mem_enabled(env);
>
>      if (cpu->cfg.ext_zve32x) {
> @@ -118,6 +119,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState =
*cs)
>
>          /* lmul encoded as in DisasContext::lmul */
>          int8_t lmul =3D sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL),=
 0, 3);
> +        uint8_t altfmt =3D FIELD_EX64(env->vtype, VTYPE, ALTFMT);
>          uint32_t vsew =3D FIELD_EX64(env->vtype, VTYPE, VSEW);
>          uint32_t vlmax =3D vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
>          uint32_t maxsz =3D vlmax << vsew;
> @@ -133,6 +135,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState =
*cs)
>          flags =3D FIELD_DP32(flags, TB_FLAGS, VMA,
>                             FIELD_EX64(env->vtype, VTYPE, VMA));
>          flags =3D FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstar=
t =3D=3D 0);
> +        ext_flags =3D FIELD_DP64(ext_flags, EXT_TB_FLAGS, ALTFMT, altfmt=
);
>      } else {
>          flags =3D FIELD_DP32(flags, TB_FLAGS, VILL, 1);
>      }
> @@ -189,10 +192,12 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUStat=
e *cs)
>      flags =3D FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env))=
;
>      flags =3D FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
>
> +    ext_flags =3D FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->mis=
a_ext);
> +
>      return (TCGTBCPUState){
>          .pc =3D env->xl =3D=3D MXL_RV32 ? env->pc & UINT32_MAX : env->pc=
,
>          .flags =3D flags,
> -        .cs_base =3D env->misa_ext,
> +        .cs_base =3D ext_flags,
>      };
>  }
>
> --
> 2.52.0
>
>

