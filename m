Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649A9103E2F7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 00:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ToD-00085I-Dy; Wed, 11 Mar 2026 20:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0ToC-00084o-2I
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:21:48 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0To6-0001r3-P1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:21:44 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6616cb8c80cso586264a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 17:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773274900; cv=none;
 d=google.com; s=arc-20240605;
 b=BH5s7/4R9/YQGAyZSkClNVq3sh+T9Y/Y5z2XMjB6XiyDi+Exz7npZxvlr81NbylWzr
 +J3S36xoNuuRTnJFkgD6rPSiGzLBVCx2G9Cv35b6nd5mp6bzKpvgBSkI4VPwwqJMdmwf
 KCcgP5np5gg4icbliV0zaAaInM7X/kjRkJlzUCC/d1nF8HHDRdkwaSsW1ZnrTW2Mugz9
 O2yKSFQW/a90XKZ+aDssObHc9mO/DNW10BqyJn9HRkzS4CoO/aMeBvjbO5BwSnOKj7/z
 rVD0zicTzXwUVOGQ8qcL3gCO3JkJ4UmoQMziyQid9cKaTVBRmRPqanrjkLqzalx71YEn
 iBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CNbedic5xy0umemMVqVGE5meuO3EFeY3wQ8YqHq+dpw=;
 fh=mD6UO31uvon6FWhVSbxiA4Ws65KKyzPS/nbHgviHz20=;
 b=e1663oedsxKhuMaLPOw/irNhlLCQocIy8OyYTmyRLrgqcv7zrS4UPFSsBxxJXMJgfV
 wZvr+Oc8rlCV7wmAJCOpDr5qSxfRRK0mYWRSoajc11dhCqKsMjBgkESYE1x8/0JdHCrQ
 2XGAC/klog+FdTovGNfi1JG+d46HpAR1X0W7fkdVsIm7RPwcckSvf8TeMrKjNYcMj/6S
 h7ynkFTkKNvAFX3rPctvabDwKI/vFyJZILFBDwIQ0jE4lmV0k80ZxILfPVAT9n9OwqGV
 zZ8GxKSYd65z9ayhdD/S7B/1UQSC3A4jCK+lV3aS50/DBYjXQBRCrX5jd50doKZ2b6vH
 9NHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773274900; x=1773879700; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNbedic5xy0umemMVqVGE5meuO3EFeY3wQ8YqHq+dpw=;
 b=Zyvbgk0JOxZ+XJNw0312d83vkrQ4cNICSJuTHpGpcrRCzSb5D2GU2Y0pC4C7A63F2C
 9UMe5+rFcomfXjpkilhfFwM9O8SOe7sIvdgbTB91Y3kTaKDIVbDXYDnha98d2z11ZJ1s
 I2y6aFfvHIR6hVkz2DAjJEMkRg2lbxDFEp7gEbfBU5ohUkY3ecnFnV3vRmJKvZs7RYwE
 7bFDOWvdJAMbeSt1n0SZuOpKPqVupjBJfjFKmVgjb2aqioGVW+W6hYNga2yaAAagnxqH
 x/hiHrwuplEOZsbBfENgHqN6kn2FBhQyenuGikXKo2etudxdl0LqzY5IJHGgRczmEgMU
 l3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773274900; x=1773879700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CNbedic5xy0umemMVqVGE5meuO3EFeY3wQ8YqHq+dpw=;
 b=gjAqOhlLG4Du/4/PYk9BBedoud3J66+jqhCslTp78NidPHvKqWdg6pUeRgIVCU39t5
 X+0fa8kWLQV3hJbgylzaV0o/ziGeMq9HV11Gb1p2oH0lebq3p0An2YCHUdrh6xgO8CJm
 m4tH/Lr5UgzgYHyNEml3jsVyZwClMmOMxBGdxD3CCFQUde5FVvHpWj+2XclIje5hwvwP
 t7MrcR/8R+mdKkOMg8+WHV9PqHx+zBvIcQejyUo050UQBdAcqC/6CuXRfFNA+KUBESRd
 GDATNYxyKjPOVAnRP6hdNcrW3oj76UxnWpGYMZZhMCGvbFQ+U7DkTInL64WT7smjntRZ
 Z7EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7jioz4q74fM8r8QGY86gjkAew+tzSfsr36kX1vLv+v8DPKhPLE1LdWA1BIQ2zViQeh6xULvrXVPs4@nongnu.org
X-Gm-Message-State: AOJu0Yz+U4vmPlKwT1OuvLCA7Fbn3vbks6u950gXfNrdSJAf7pTPKoi5
 646gNxaj7QYa6yyPXG1Oy80PpBuFaHgR6T8rwdGG/JTf80iAl9/g/zW3gle+2gYRgjso9zN0bov
 qRuTH8m2XIm2fIpYnrxghdSWn6z8poZs=
X-Gm-Gg: ATEYQzzFWsIMLXnv1sSlL1lbGE9Jmoz2LQCmun3kJDD3pKCTOmMKByWJ+lDQXyCpVOn
 VvTS2MrTsJQ41grL3haw4GZVLarW28/4DacYRReuE0SJSqiL0E1mVmKGh6nZ90W6IL7v+fbZ1rF
 6pcXrNAKtuPNz5Plvnbx+ML63yTDi4lABOCROV/mPPgcozniRsfWJT+Jwk0REN2d1Q9CEApc2Mp
 YRpSTt+cQaFqBX7wENtaMwlGFe/Z0g9i8nD7Q1WdulVidK+sk0XYpOp81ubbigNyoYxRoQ8MgR6
 ux87q4WWev2fBnAcHJfZTpMKj7+mjG4RcgR8Rg==
X-Received: by 2002:a05:6402:27d3:b0:662:f822:d932 with SMTP id
 4fb4d7f45d1cf-6631a1f154emr2400228a12.15.1773274900070; Wed, 11 Mar 2026
 17:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260310151347.67263-1-james.wainwright@lowrisc.org>
 <20260310151347.67263-4-james.wainwright@lowrisc.org>
In-Reply-To: <20260310151347.67263-4-james.wainwright@lowrisc.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 10:21:13 +1000
X-Gm-Features: AaiRm51CM0_sek1-b0_hA_lOi4STWYch2LUkevq1wFfBLNCfG9E82Az60dc8T8o
Message-ID: <CAKmqyKPMSc1XDEkc1b-VvLHPFt=g1+t06AAK8HYbUgq5u3pb3g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] disas: diassemble RISC-V Zbr0p93 instructions
To: James Wainwright <james.wainwright@lowrisc.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 Emmanuel Blot <eblot@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Wed, Mar 11, 2026 at 1:15=E2=80=AFAM James Wainwright
<james.wainwright@lowrisc.org> wrote:
>
> From: Emmanuel Blot <eblot@rivosinc.com>
>
> Placed in a separate file as an unratified extension.
>
> Signed-off-by: James Wainwright <james.wainwright@lowrisc.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS         |  2 +-
>  disas/meson.build   |  3 +-
>  disas/riscv-xlrbr.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  disas/riscv-xlrbr.h | 19 +++++++++++
>  disas/riscv.c       |  2 ++
>  5 files changed, 103 insertions(+), 2 deletions(-)
>  create mode 100644 disas/riscv-xlrbr.c
>  create mode 100644 disas/riscv-xlrbr.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 847fd414bc..12f106f4c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4154,7 +4154,7 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
>  L: qemu-riscv@nongnu.org
>  S: Maintained
>  F: tcg/riscv64/
> -F: disas/riscv.[ch]
> +F: disas/riscv*.[ch]
>
>  S390 TCG target
>  M: Richard Henderson <richard.henderson@linaro.org>
> diff --git a/disas/meson.build b/disas/meson.build
> index bbfa119783..42977a1f74 100644
> --- a/disas/meson.build
> +++ b/disas/meson.build
> @@ -7,7 +7,8 @@ common_ss.add(when: 'CONFIG_MIPS_DIS', if_true: files('mi=
ps.c', 'nanomips.c'))
>  common_ss.add(when: 'CONFIG_RISCV_DIS', if_true: files(
>      'riscv.c',
>      'riscv-xthead.c',
> -    'riscv-xventana.c'
> +    'riscv-xventana.c',
> +    'riscv-xlrbr.c'
>  ))
>  common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
>  common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
> diff --git a/disas/riscv-xlrbr.c b/disas/riscv-xlrbr.c
> new file mode 100644
> index 0000000000..57cb434523
> --- /dev/null
> +++ b/disas/riscv-xlrbr.c
> @@ -0,0 +1,79 @@
> +/*
> + * QEMU RISC-V Disassembler for xlrbr matching the unratified Zbr CRC32
> + * bitmanip extension v0.93.
> + *
> + * Copyright (c) 2023 Rivos Inc
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "disas/riscv.h"
> +#include "disas/riscv-xlrbr.h"
> +
> +typedef enum {
> +    /* 0 is reserved for rv_op_illegal. */
> +    rv_op_crc32_b =3D 1,
> +    rv_op_crc32_h =3D 2,
> +    rv_op_crc32_w =3D 3,
> +    rv_op_crc32_d =3D 4,
> +    rv_op_crc32c_b =3D 5,
> +    rv_op_crc32c_h =3D 6,
> +    rv_op_crc32c_w =3D 7,
> +    rv_op_crc32c_d =3D 8,
> +} rv_xlrbr_op;
> +
> +const rv_opcode_data rv_xlrbr_opcode_data[] =3D {
> +    { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "crc32.b", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> +    { "crc32.h", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> +    { "crc32.w", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> +    { "crc32.d", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> +    { "crc32c.b", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> +    { "crc32c.h", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> +    { "crc32c.w", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> +    { "crc32c.d", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> +};
> +
> +void decode_xlrbr(rv_decode *dec, rv_isa isa)
> +{
> +    rv_inst inst =3D dec->inst;
> +    rv_opcode op =3D rv_op_illegal;
> +
> +    switch ((inst >> 0) & 0b1111111) {
> +    case 0b0010011:
> +        switch ((inst >> 12) & 0b111) {
> +        case 0b001:
> +            switch ((inst >> 20 & 0b111111111111)) {
> +            case 0b011000010000:
> +                op =3D rv_op_crc32_b;
> +                break;
> +            case 0b011000010001:
> +                op =3D rv_op_crc32_h;
> +                break;
> +            case 0b011000010010:
> +                op =3D rv_op_crc32_w;
> +                break;
> +            case 0b011000010011:
> +                op =3D rv_op_crc32_d;
> +                break;
> +            case 0b011000011000:
> +                op =3D rv_op_crc32c_b;
> +                break;
> +            case 0b011000011001:
> +                op =3D rv_op_crc32c_h;
> +                break;
> +            case 0b011000011010:
> +                op =3D rv_op_crc32c_w;
> +                break;
> +            case 0b011000011011:
> +                op =3D rv_op_crc32c_d;
> +                break;
> +            }
> +            break;
> +        }
> +        break;
> +    }
> +    dec->op =3D op;
> +}
> diff --git a/disas/riscv-xlrbr.h b/disas/riscv-xlrbr.h
> new file mode 100644
> index 0000000000..939a69ea6d
> --- /dev/null
> +++ b/disas/riscv-xlrbr.h
> @@ -0,0 +1,19 @@
> +/*
> + * QEMU RISC-V Disassembler for xlrbr matching the unratified Zbr CRC32
> + * bitmanip extension v0.93.
> + *
> + * Copyright (c) 2023 Rivos Inc
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef DISAS_RISCV_XLRBR_H
> +#define DISAS_RISCV_XLRBR_H
> +
> +#include "disas/riscv.h"
> +
> +extern const rv_opcode_data rv_xlrbr_opcode_data[];
> +
> +void decode_xlrbr(rv_decode *, rv_isa);
> +
> +#endif /* DISAS_RISCV_XLRBR_H */
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 6f2667482d..d416a4d6b3 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -26,6 +26,7 @@
>  /* Vendor extensions */
>  #include "disas/riscv-xthead.h"
>  #include "disas/riscv-xventana.h"
> +#include "disas/riscv-xlrbr.h"
>
>  typedef enum {
>      /* 0 is reserved for rv_op_illegal. */
> @@ -5434,6 +5435,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc=
, rv_inst inst,
>          { has_xtheadmempair_p, xthead_opcode_data, decode_xtheadmempair =
},
>          { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
>          { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacon=
dops },
> +        { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
>      };
>
>      for (size_t i =3D 0; i < ARRAY_SIZE(decoders); i++) {
> --
> 2.48.1
>
>

