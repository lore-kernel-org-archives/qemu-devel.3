Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9CD106ACFE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 00:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0q8f-0002aZ-S1; Thu, 12 Mar 2026 20:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0q8c-0002aE-3H
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:12:22 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0q8Z-0007QN-MB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:12:21 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-661be3380adso2731347a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 17:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773360738; cv=none;
 d=google.com; s=arc-20240605;
 b=XhSjcRugds7mXz88XmVJDZ09mHVthW9Est+4F/V6tj1Ru19cnHnXso01+MmSYunjUk
 bc3EafTRIkOk3dyT8l/o5WmzvbP8zTf/+MHYFBJcKwk2gxj828q0xvFWAGvLtVnIMA67
 LRwowaVb6cVh6ExJoYr71FjV7Qz78pTEwad9GXFAnWsncLoxgoTMiKHrTr1Nl2uZSpk3
 qqrH6mORRb5zVI6oxGbOQ6Tyq+e79MolOF/45s2crw0VOSrw7vW2GHDphnbX9GOwevh2
 t8m9NP8/chAm1aDbYGlXn06PF2QdjtAFoHwDIKNZcosCK25vgQfrHNVKmG9QbsbcVRBg
 jN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZnpovbmNhh3FM7r5W61xe75pTPWS8KphWs7RN9AitRc=;
 fh=m6H9ss9c/eD6DjmG5r02IS7MGClkMxag8NOABzOAE8g=;
 b=Yzo9+N99roF1l7KFrKHXRrKea1ujnkzSGPYEUHrngtoCtkCl5wZcQ3DYj8qmHLIPGG
 6NSV999rbxIDybpV0Lufc9/XsH0Coi50bMpelKdqbqhGgW42c3prcoXiBgc+0hL3qW13
 PNoHIBMODX22T12P4F9VWfblVPJOfk0j/r9KVxMUY5v2/yZAUmtsOUF6y7kVosCV70uV
 66auy9RZZp9w0M5mg3bpROGbwDSjt3KYPQ5yFVdZbgRVW9VVVDI3dHihP4Ue3A26tIy5
 vU0agqMxzoBzxzi4WEv9u5HXLfjowV1vcRn+V161jT/MUJkVaxppPfejf937GKu475jK
 NMNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773360738; x=1773965538; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnpovbmNhh3FM7r5W61xe75pTPWS8KphWs7RN9AitRc=;
 b=K3P3D55DyJClBcgkaBC8xS3PqsyRWlXnYyDvdmPMzFtctEgHEhDwndPCWeKNL0rfpN
 F65MXqurQH4+LioXdkCjVjcbtP0ptV5AtWs9nZz0kaC6TxN67YH1XNNOxyqIet0qyNEb
 cPoIuDNQskQsinymtEWWjSh1p7GIEf3pMchgFXQJVmpO3TieQRpRG3GxY0J0CCQ1oinB
 RNc0afwJsyO+5xgNxU0hGhs4dT1RSp2MZjT4ZTraaJMOww0gy8/ushUv+w6GFgUwcyyP
 MQRwl96dm0LGLtcFBB9tSAaJricczPIPmeHSrNErkJf6WfkokGQoErVKdlj8foDmNR6G
 Bhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773360738; x=1773965538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZnpovbmNhh3FM7r5W61xe75pTPWS8KphWs7RN9AitRc=;
 b=Lisy/VbzKD9ufBig6/4Vs7+7arGH9bUHOhfr5Y5b4Z28468xJsRrbUqMp72NaozORk
 v176+OWr4UHxmv5POStdYsUzCA33anzvORCFuJMENv6vqWFSXaUw7k8IdyfwPcmBOGhI
 XlC4XN4b8nIXjIUKJrdbgGmc+yP5bo1LDdItonaZp0T5/1v8ph2v+zNLD9/CBUXfcwe0
 f+RO3yJ/cWp3DlcVD1Zmx/iDE9tgSTXJKLEUYQKtbmP4Y0+tpXMSjpdqeOxf2iMd0GPA
 bJpCUBmcYsJ7rGrs+dBpN24vNJQEVqgWH3Nk8ZctqjR5c/ZVCkZu7f6qoowurHIyFXh9
 xJzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrEAoAwbYhzujSGlAMv3sDB7gJmJKcMCtA0MXAROh47S+5jT+dGMCknZhsagbmk3jzSkm1ckQRneg1@nongnu.org
X-Gm-Message-State: AOJu0YzY/55vDMQfLag5xvFtiD6SmCbBU6C8AQJdYMrXyEx0MlRvGjE9
 QNUx+Jx819MC8iV1yp1SIWE5eshjEQsvuMID03Uqrf8Fua3b0VqBoVJUtuiSTwtGWQAa0CGnVOI
 L8jqBjq0VPLHmcqunOX5xeqRl6jhSWVw=
X-Gm-Gg: ATEYQzysdRtGoL5vR24TVehu/WWdMZzr/C2GJHBmbrFVYLcmJW780EsxcgHPXT7fOtE
 h64iET/YTnuRLLWovwG0Gq5Oih/cheIetZW+qzlTCCAqHc1MJWR8QG4XL9D4tfoYtQf/VhH1jbW
 0XokDMhyD2NFnctRXJuVsuPq2JrgzzUFWvM46RnS/PQCoO/tDOep3uTzaVNJPpf120EwXogPt4b
 FPC29uB2PnQ05eLHWHBWg/CyeWyC5Kd+H7KW/3vp1mDGSgCtDA5JyWkvrLY32iu2oo7ilyWU7b0
 H5yQqDOt3uBtWlb8AWbpXZQMTeiZhqyDLnrhag==
X-Received: by 2002:a05:6402:348f:b0:662:9f1c:8023 with SMTP id
 4fb4d7f45d1cf-663babf0c2emr725913a12.21.1773360737758; Thu, 12 Mar 2026
 17:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260312134210.5823-1-james.wainwright@lowrisc.org>
 <20260312134210.5823-4-james.wainwright@lowrisc.org>
In-Reply-To: <20260312134210.5823-4-james.wainwright@lowrisc.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 10:11:51 +1000
X-Gm-Features: AaiRm53B0s102-FQ4994a7k2fuKqRDm4IJNFXtRp4OCum1kVU85ZMGNHXM2ekgM
Message-ID: <CAKmqyKP=LUaWgfPFLHJ7NYKiruBP6CE+ac4JhtyW5LFkG_ecAw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] disas: diassemble RISC-V xlrbr (crc32) instructions
To: James Wainwright <james.wainwright@lowrisc.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 Emmanuel Blot <eblot@rivosinc.com>
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

On Thu, Mar 12, 2026 at 11:44=E2=80=AFPM James Wainwright
<james.wainwright@lowrisc.org> wrote:
>
> From: Emmanuel Blot <eblot@rivosinc.com>
>
> Placed in a separate file as a vendor extension.
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

