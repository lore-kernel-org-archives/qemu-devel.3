Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CF6EA8553
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 05:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzSkh-0001vU-9t; Mon, 09 Mar 2026 01:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSkf-0001uw-4X
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:01:57 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSkd-0006p8-Ap
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:01:56 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6618bc129acso4737819a12.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 22:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773032513; cv=none;
 d=google.com; s=arc-20240605;
 b=at4NjVRjX3h37PeE7to210oeoyPRwyQ3VkspotleS1Fxf6g1ruzOD80TIfyj1pz2zi
 AtBdsJjl4TGVp8yi6g4UOOsZXFDdyiCesebuqjxd99Mtz3+tuyl5yIH5rLIZHcYt8myj
 PXlLhUCGhghSJ+l4K7KW4gYaM2rh/A7feFwSJ6W1wY16o2KWiyPRlwWX/FArmvjpVraY
 NJKbEP0pcU0iz5Mk4/YB4iNxNbiuRXsvbDxWaP3+XojydRt33YkRCpFn/A/VkK34Qc1x
 BNunri6cm/Q+mWyOhw7prhsjahUpKbFCNNTEHalTnP3XXGyHyB8q/MgusDAY8NCbF7tn
 pruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ril4rw2jBsjZpsT7O08dRm4Do/tIwXd4+g/CdjtDRXk=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=dqtMcA4D4ztwW8y7ozMzyPrw9jGYH6x50sPElByo1ohbDt2qxjXaPY+p5EOmuP7E+h
 nN3dMzx/xHrxVqi48B2MRJjcKaUBGw6MCf+L1tiDBC9a/ELIPAVnm3RH5D+LbwfsmC/N
 eO7u8Qrw/hTJahCePLJv7yjb4tzHd5O37RG+TXcWOiJOiVzyjBBE/QKphtFFMaPFHN2P
 Fyhjx4NRJYviIDMKpkIALaBUIfhoaxBSagVj9MmJCjFkQQlflLM4XUmEuGTuv1I6Ilk8
 Qejj2yC3v/i2OkmqhrWjQE6DYE1U4DZ3F7rBW2SGQX3rewusTuSyF3TNKR0UgCHAwGWq
 opfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773032512; x=1773637312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ril4rw2jBsjZpsT7O08dRm4Do/tIwXd4+g/CdjtDRXk=;
 b=hPSgR8GzxNMZtA55m7g6Jik/dlcBF251l/aDfIIqVdLP3KWEbzqy4OkURTSpALaYjQ
 1QrlYkDZW++xMzvjenl3Ci5gWzPQAnheSa27mI7j3X/ZbKVpp9POFb8ufJxQKURxCm35
 GaC5RdwacBe7YYcE3VV818Nc+QRkcsK+LniFjrWo3IOOdrGPP3SNDx6h3Njstw/EHkvI
 iD55oKkzP8TIhGIlJKksYljCQ7p+NM8n9nhDDBvoFzMblnsKnjpgUDw4R3l+fKTJ87sE
 DjZVa8GVXjP3JBmRRm2WynYIKYauvssVBQtYzYnq9X9OP0v4p8Jbo2BsQrt++WBcl2KH
 LCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773032512; x=1773637312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ril4rw2jBsjZpsT7O08dRm4Do/tIwXd4+g/CdjtDRXk=;
 b=vgjj2aADrpordoMw5gZ96CH/Y6FcrVHG1F6nJS9QmL88qp1bUJdF/eG/d4MpTSC8uO
 iEsbFJqI/HeV6qEC5yjjL6HoEroUW/EdNId5C5zG1kyB7ZzEhxqjFbMMFSCcOJueIjGc
 SrNZ2pJwn8ZXR2e7nr8GkqxgZyIXRRuvfgavy8Tx0Lcx881axlZvlz6MmAtasNJvZkFR
 345+Y3xuJWAc5FNuoUTD7n3zEjp17A6sb8nPDfUwpyG7hQzzAfPNGMb2is2B89kAGd37
 fgJ8zDQ7kQo5khGA4UmKxCjAdghLJ7I4tbXacb//0xxPs808w1uU7ru7YqUw+xNhmGE4
 K84Q==
X-Gm-Message-State: AOJu0YxLKsi3Mz8U335Mdgszrg58S/tjqOWlhvb0nT2eiV+7dnZZzrHW
 agK3+a/Oh/EbwHcONs/riRIBLW7qydpsdcQFbUr+D7BQaOy0Bvn76O2soS92Ed6L6f1GW+2eSf7
 3otQtdAVd/FDZk3/h/aLU5tEiyd+aSdI=
X-Gm-Gg: ATEYQzwntDFWs9AeC0q3VP6j0XOk20gI6iJjBWhBLMl/qdSjTx6dhApLTaY0DrXjuFl
 YITCbXmZpMLff+3ZgRYnU8bkGgiWvBrN9wSbbIWMpwJytbUIBwoyM1qHW1ZofcpKuGJ5P3LgLaR
 EpbVYhYbjAGNgPDfv18EcFZKCbUYLFj+73RZe96rePIg7uw9LE6B7Or63N616qzYCB9SFYESRoz
 fk/r5cUlJq7TTO37ZHqOBJt86adEH99iWAlvfXmJJjQNK10nAeTgUp0AmINu4EIrKsfuzCMGzWK
 EEm9vKD6Rc/hU/nhF4UXdj0TUIYeZE0rl5pcHg==
X-Received: by 2002:a05:6402:5419:b0:662:863f:59e1 with SMTP id
 4fb4d7f45d1cf-662863f5b9amr260235a12.23.1773032512449; Sun, 08 Mar 2026
 22:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <20260306071105.3328365-6-max.chou@sifive.com>
In-Reply-To: <20260306071105.3328365-6-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Mar 2026 15:01:26 +1000
X-Gm-Features: AaiRm52bxTnL5rkgzYwVOprXYhbqFNz9T96_6WmkkCAb8-y-etHfwx8vzBoTcuM
Message-ID: <CAKmqyKM-mu7+gtFRK+G94szLFUDdxGaz4zxW7-bW2L5y0Kn2hw@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] target/riscv: Use the tb->cs_base as the extend tb
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
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Fri, Mar 6, 2026 at 5:13=E2=80=AFPM Max Chou <max.chou@sifive.com> wrote=
:
>
> We have more than 32-bits worth of state per TB, so use the
> tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
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
> index 720ff0c2a3..378b298886 100644
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

We need to update the comment in `struct TranslationBlock` for
`target_ulong cs_base`

Alistair

>      };
>  }
>
> --
> 2.52.0
>
>

