Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBCFC83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 03:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXX6m-0006qg-HX; Thu, 03 Jul 2025 23:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXX6j-0006ib-R6; Thu, 03 Jul 2025 23:29:01 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXX6h-0006P2-NZ; Thu, 03 Jul 2025 23:29:01 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4e7fc3309f2so106554137.2; 
 Thu, 03 Jul 2025 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751599737; x=1752204537; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgMx1VqGDaJScVb9v2ZWDwgZ1dxspOT9ckd4vbNED1w=;
 b=HkUCuFLCWcBKW7bQ8xY1+5xoUbZU8B4X8+z0efALxr6OlLZJh8jeCvjpplb3Pi1tKo
 d2HMTadXksFEhLDI1AxgNaJdjUJicqewqrgL5vQlbXqNHwduzkM2Hw358c2/1t26xkvb
 awD8WaiNlf6KpBhvOCwWqfy0cD08wAU2ksnevtEf4NgjO9IdtslFeQ5IUyFU3C54p4Is
 713+aTXNP8ZKwTQHvhFIl38FtkTN5Oa2ygK6mwbZqnnS/bbhXKaFVqG+6PaH/pz2NKxu
 ugCEXIUaPgsV5e499L8kHnbg9PuOgwnk88L1eFW1myim32H8r9Pd2h/uThOLqN3EsNOQ
 NDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751599737; x=1752204537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgMx1VqGDaJScVb9v2ZWDwgZ1dxspOT9ckd4vbNED1w=;
 b=rMq0pwc17nQTGMZ61GA67RK7iE0dJ5Xt4VApNk+s9Ap5yuwEWe3uoWrznfSHrcMLTJ
 osw8fS04ym7oUX2hg8lsCxnj1wGMIoNQ2nOot1/D2WKAGU/JBWBCZES34q7Tp80UBnEd
 29RIgIbhN8vY8VSe6v9CttlKHXnsPjtl9VGh8VWatwjqMpP3L+uqTPaD+QDBTwGpfacy
 XpUkwaxV3QJN1nAsUUuV8qZcqvebjQKa0IrMRgB5lBdHbGUuurKtG10IfdzJpxiBcHxP
 kGxpEproE8+eE5UekqbnzHh4f5J1Zg+G95RdpJSR6yPRDjJN5XERcE28oM25H9F9rvr+
 itww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm4eEbIwKjp4mdZ8W6MTMgK6Fb/XbuZyoGOHNSxJX2q6aZm1RQU6nt0nm/YPIK7Jv7Mqm6WnwDmO4t@nongnu.org
X-Gm-Message-State: AOJu0YzEUyVLWHNAR6gO/s8s+GLQY0Uqg2l3raroCENTQzXqwWL+/9Ed
 f6RvHL+t7pQkCwq5CKvZ0UgAHP2OcCX59/PnXK2foZAYXCH7svsCks8E8kwYcSIQJLaA0tzCb70
 37kt6qD7lbJiNY/zdqu6RkILldWfhQ94=
X-Gm-Gg: ASbGnctjc0yJey+pQZ8tFN/S2bq8htWSApYrN3Yorc8rjN8n56ls3yryx8U7ubirpLF
 2W8nUKHB2b4QALx3ZiIc4rCRPjBTtIAEc51NO2GdZSVPWB9XPI867HiEFlfB56c6VLN4P+Bg+HJ
 07KF/ZhbGPPK4CVpQnfn0QRZH8pTGz700P0cJOX9KUchDkjrzv6Ff7R2hSfTnuNris3o2Y4UE/1
 A==
X-Google-Smtp-Source: AGHT+IEDjtl4x17nVzwh8CIw89Dyz9AuEIELaDE/YJ0WmTZvDqWTujWxAmT1/MNGFN4yfgiIa5ueV9sjGfWTMoD8Phw=
X-Received: by 2002:a05:6102:4494:b0:4de:81a:7d42 with SMTP id
 ada2fe7eead31-4f2f170ea7emr293941137.1.1751599737301; Thu, 03 Jul 2025
 20:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250619135545.61956-1-roan.richmond@codethink.co.uk>
In-Reply-To: <20250619135545.61956-1-roan.richmond@codethink.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jul 2025 13:28:31 +1000
X-Gm-Features: Ac12FXzzLbweuHcFzM_yNL0LtuVR7DvTwvwMVWOvqC6LaRCgD2t4lOxUDTv4ka0
Message-ID: <CAKmqyKMQQwHCJVgguGzMxQx16dVB5uD=stAiF8ZYV8fsDF0dmA@mail.gmail.com>
Subject: Re: [PATCH v3] Add RISCV ZALASR extension
To: Roan Richmond <roan.richmond@codethink.co.uk>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Thu, Jun 19, 2025 at 11:56=E2=80=AFPM Roan Richmond
<roan.richmond@codethink.co.uk> wrote:
>
> This is based on version v0.8.3 of the ZALASR specification [1].
> The specification is listed as in Frozen state [2].
>
> [1]: https://github.com/riscv/riscv-zalasr/tree/v0.8.3
> [2]: https://lf-riscv.atlassian.net/wiki/spaces/HOME/pages/16154882/All+R=
ISC-V+Specifications+Under+Active+Development
>
> Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
> ---
>
> Ping! resending this as no movement on previous send.
>
> V3:
>   - rebased patch onto master branch
>   - added check for aq on Load Acquire, as pointed out by Alistair Franci=
s
>   - added check for rl on Store Release, as mentioned by Alistair Francis
>
>  target/riscv/cpu.c                           |   1 +
>  target/riscv/insn32.decode                   |  10 ++
>  target/riscv/insn_trans/trans_rvzalasr.c.inc | 120 +++++++++++++++++++
>  target/riscv/translate.c                     |   1 +
>  4 files changed, 132 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..b52bbf0936 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -128,6 +128,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>      ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
> +    ISA_EXT_DATA_ENTRY(zalasr, PRIV_VERSION_1_12_0, ext_zalasr),
>      ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
>      ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>      ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index cd23b1f3a9..c848c0c1c5 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1066,3 +1066,13 @@ amominu_h  11000 . . ..... ..... 001 ..... 0101111=
 @atom_st
>  amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
>  amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
>  amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
> +
> +# *** Zalasr Standard Extension ***
> +lb_aqrl  00110 . . ..... ..... 000 ..... 0101111 @atom_st
> +lh_aqrl  00110 . . ..... ..... 001 ..... 0101111 @atom_st
> +lw_aqrl  00110 . . ..... ..... 010 ..... 0101111 @atom_st
> +ld_aqrl  00110 . . ..... ..... 011 ..... 0101111 @atom_st
> +sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
> +sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
> +sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
> +sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/=
insn_trans/trans_rvzalasr.c.inc
> new file mode 100644
> index 0000000000..8761508de3
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
> @@ -0,0 +1,120 @@
> +/*
> + * RISC-V translation routines for the ZALASR (Load-Aquire and Store-Rel=
ease)
> + * Extension.
> + *
> + * Copyright (c) 2025 Roan Richmond, roan.richmond@codethink.co.uk
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define REQUIRE_ZALASR(ctx) do {     \
> +    if (!ctx->cfg_ptr->ext_zalasr) { \

Wait, this variable doesn't exist.

How are you testing this?

Alistair

