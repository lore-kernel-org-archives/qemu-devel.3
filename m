Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A9BC8302F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWD5v-0000xa-6r; Mon, 30 Jun 2025 07:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD5s-0000wC-M6
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:54:40 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD5p-0008Tg-C3
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:54:40 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7d425fc4e5fso337805185a.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751284475; x=1751889275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Q+2iEtqGpRwtFhuP2HhEUAhaq5BRGaFR48ZxQBzvoU=;
 b=O+81IU2yAxH8Z4EaMsyLlC+c52rizvyJ5bf92Bzw1WyHAcwpgnD3fA/RBRuvOouwbW
 C02dJVebBkTFzz3CEyVhwjqBCr0e4bLVrXK+FekupxTJYftCyU7OzcS5iZL3Vq6OQ1b6
 BxUSU/iXZn5EvlU8fkbnySvIZ948XYMS8+sIo7WT9EsvmgvCHA5GpolEb+SP8qUafqYZ
 xME+HjPS0OE6tMY3cj7utw0RyQlNsL2eGVwr0FcLR+GubNt3ZpSYmlbci3e+1jeBd4sw
 ZVulc4Sjd/6x1fVkCKF7SJO1Ggy8P3Xy36Oybm5rOwPsp3IUjaQBsndD0gZSY93Sh86X
 znfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751284475; x=1751889275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Q+2iEtqGpRwtFhuP2HhEUAhaq5BRGaFR48ZxQBzvoU=;
 b=VjJkys7C1UjxJ3OeWICgbcjTmdBeiWL8RHgcYCnMZeb0oSe2rIpEKOWcaN7VoZoXCQ
 utxv4uabS0SGPPkgBd778kowALF00mSDFFLmEXxickiAMJxcMlq0Dr8LO8OUMBxO242w
 N3v8EdQBrn/P33tbqKAP2i/x9o9MkKw3yUtlIcFt1SFrFSZEwqlOGKZ0kkewaMG809uV
 7yABBo3KnmDv5meUrX8eS6B7Q6pkigJZuG6cJZkF50lGGVVFmCWzqCR7TDGKgfy18D7u
 KqKjT2CayPFWdz+17fRFOR/Ioich8GL1Y0/eQ9FuJKavZdPncBDqkRxYkFIx2/dI50x3
 WeNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXTlnk7MLCurMO/HZHGzVe0lckYlZAmY/ymgDlSyP8AJVr4FuRrpl21XUYdunq+n65jNdcHJzveuAX@nongnu.org
X-Gm-Message-State: AOJu0YzNMgFnqIGJs1b1TNBk+ioHyHXzBakm2e43QXMTpZJ9V+GiJLO0
 gsRokZzqiFz5VQu2jSrzi6Y+O6WAKoLo/HgC1KHqfRgWd8oKMtxBLHqd9zRVk3dCHeo=
X-Gm-Gg: ASbGncs3Az3ISKrgJi1c6wh2hKDm+6QRpWET2m5lKhDD0ELqY8SXhhIzZW4e+HVMeOw
 MVGPL14AW7Ku1GRovj1F689vkF9nEllSojBEpIM5nrfSk4PQaTJJ7wqMspHDdyYRWvP19v3Ha5Q
 Yr7bSFlBjGwVJaylCMw6cSFQkjY4BLFiCAy/+u1s7Ix1668ROVubAxMzHkO/9Da6ldKhYnng2uk
 BRuOXTnhyZ95iV72lHwTPxv+3iWcPpuG5Icz+bFbtU5UZaLKMUzvmCMEfrqvO7uJ0DYs+jnJiJq
 uEDH+RjEUDNq4BUPjE+SSjNp6tb3Uew3O91O6kyqEucHvkcI0Sn9FDyWlTXE0gs1h30dsXA+MRI
 =
X-Google-Smtp-Source: AGHT+IFhTxO7iZI1MU3En6+PURP4l4kXL4ZPGr/CzM3CNKGAYCHWq6Zif8RYiiR/VlH2R2hxEEaVnQ==
X-Received: by 2002:a05:620a:4607:b0:7d3:c4c7:75d6 with SMTP id
 af79cd13be357-7d4439a6472mr1922542785a.47.1751284475447; 
 Mon, 30 Jun 2025 04:54:35 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443204c00sm586402685a.74.2025.06.30.04.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 04:54:34 -0700 (PDT)
Message-ID: <c871fac6-f18f-4307-b878-4ab12aff374c@ventanamicro.com>
Date: Mon, 30 Jun 2025 08:54:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] target/riscv: Add mips.ccmov instruction
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
 <20250625141732.59084-6-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250625141732.59084-6-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x729.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 6/25/25 11:18 AM, Djordje Todorovic wrote:
> Add mips.ccmov defined by Xmipscmov.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---

Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c                        |  3 ++
>   target/riscv/cpu_cfg.h                    |  5 +++
>   target/riscv/cpu_cfg_fields.h.inc         |  1 +
>   target/riscv/insn_trans/trans_xmips.c.inc | 42 +++++++++++++++++++++++
>   target/riscv/meson.build                  |  1 +
>   target/riscv/translate.c                  |  3 ++
>   target/riscv/xmips.decode                 | 11 ++++++
>   7 files changed, 66 insertions(+)
>   create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
>   create mode 100644 target/riscv/xmips.decode
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9a11a994c4..d48fd4df4e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -230,6 +230,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
>       ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>       ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
> +    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
>       ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>       ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>       ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> @@ -1360,6 +1361,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>       MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
>       MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
>       MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
> +    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
>   
>       { },
>   };
> @@ -3178,6 +3180,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.pmp = true,
>           .cfg.ext_zba = true,
>           .cfg.ext_zbb = true,
> +        .cfg.ext_xmipscmov = true,
>           .cfg.marchid = 0x8000000000000201,
>           .cfg.mvendorid = MIPS_VENDOR_ID,
>   #ifndef CONFIG_USER_ONLY
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index aa28dc8d7e..2db471ad17 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unus
>       return true;
>   }
>   
> +static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
> +{
> +    return cfg->ext_xmipscmov;
> +}
> +
>   static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
>   {
>       return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 59f134a419..baedf0c466 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
>   BOOL_FIELD(ext_xtheadmempair)
>   BOOL_FIELD(ext_xtheadsync)
>   BOOL_FIELD(ext_XVentanaCondOps)
> +BOOL_FIELD(ext_xmipscmov)
>   
>   BOOL_FIELD(mmu)
>   BOOL_FIELD(pmp)
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
> new file mode 100644
> index 0000000000..269b1082a6
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_xmips.c.inc
> @@ -0,0 +1,42 @@
> +/*
> + * RISC-V translation routines for the MIPS extensions (xmips*).
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2.1 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + * Reference: MIPS P8700 instructions
> + *            (https://mips.com/products/hardware/p8700/)
> + */
> +
> +#define REQUIRE_XMIPSCMOV(ctx) do {              \
> +    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
> +        return false;                            \
> +    }                                            \
> +} while (0)
> +
> +static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
> +{
> +    REQUIRE_XMIPSCMOV(ctx);
> +
> +    TCGv zero, source1, source2, source3;
> +    zero = tcg_constant_tl(0);
> +    source1 = get_gpr(ctx, a->rs1, EXT_NONE);
> +    source2 = get_gpr(ctx, a->rs2, EXT_NONE);
> +    source3 = get_gpr(ctx, a->rs3, EXT_NONE);
> +
> +    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
> +                       source2, zero, source1, source3);
> +
> +    return true;
> +}
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index fbb6c8fb45..26cd11ec00 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -4,6 +4,7 @@ gen = [
>     decodetree.process('insn32.decode', extra_args: '--static-decode=decode_insn32'),
>     decodetree.process('xthead.decode', extra_args: '--static-decode=decode_xthead'),
>     decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
> +  decodetree.process('xmips.decode', extra_args: '--static-decode=decode_xmips'),
>   ]
>   
>   riscv_ss = ss.source_set()
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index c3fbae7cfe..4841772522 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>   #include "insn_trans/trans_svinval.c.inc"
>   #include "insn_trans/trans_rvbf16.c.inc"
>   #include "decode-xthead.c.inc"
> +#include "decode-xmips.c.inc"
>   #include "insn_trans/trans_xthead.c.inc"
>   #include "insn_trans/trans_xventanacondops.c.inc"
> +#include "insn_trans/trans_xmips.c.inc"
>   
>   /* Include the auto-generated decoder for 16 bit insn */
>   #include "decode-insn16.c.inc"
> @@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>   
>   const RISCVDecoder decoder_table[] = {
>       { always_true_p, decode_insn32 },
> +    { has_xmips_p, decode_xmips},
>       { has_xthead_p, decode_xthead},
>       { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
>   };
> diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
> new file mode 100644
> index 0000000000..cb334fa4bd
> --- /dev/null
> +++ b/target/riscv/xmips.decode
> @@ -0,0 +1,11 @@
> +#
> +# RISC-V translation routines for the MIPS extension
> +#
> +# Copyright (c) 2025 MIPS
> +#
> +# SPDX-License-Identifier: LGPL-2.1-or-later
> +#
> +# Reference: MIPS P8700 instructions
> +#            (https://mips.com/products/hardware/p8700/)
> +
> +ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011


