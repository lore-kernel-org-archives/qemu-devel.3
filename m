Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BDEC71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 18:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRx7j-0001Oa-Rs; Wed, 18 Jun 2025 14:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uRx7h-0001Mw-Dw
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 14:02:57 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uRx7f-0002cW-4C
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 14:02:57 -0400
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so7558477b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750269774; x=1750874574; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jR6fDbx9z0kDylxk1SfPa6qhI67YpmBQHugONd/sAVM=;
 b=BsrEBQugr513To0GzlFAESNnstAcLVQoESjdDI2vRE1MXrnUD9tht0epY3e3BAvPsB
 ABmcfjVcqhlO1hwR9CE8buIv5XNAAz6UcRxStZ/wGYhw04sIvnRI7lpgSQk11oUobEJe
 igrq5vJ3bYvp0692XktImAVLuVurzMSN1GPyC4eFAjpeuq94MqqwnR0Yn69hJ8hr4psz
 9LfjLS6LtcEOSEPaJx7PwsHkKuGkzutKxU5lODpDmficMfGHwj8t0CvA7u9P9cYj+HX2
 IWn9f1jxoepVLS1Q1XR7YitRLb852TX7X/5f/h0x+PJ4xYYn0hmpc5qMx+lqZw97gTUf
 roJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750269774; x=1750874574;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jR6fDbx9z0kDylxk1SfPa6qhI67YpmBQHugONd/sAVM=;
 b=laDCZPjXICd6+QpFP4VvLktcvv3DKukU4bV+nrxprUJOSHKxEsghGRN6g4MN5bEr/L
 qCYRQsf/Yawion5H10EdAYmRu8q0D35ooCE6yf/sUPP/ynTk0Nv6XqGrzTPQoeqEonCc
 VrsdEWPD7t9OcWcFK8qpTK2+j3kC6AOXxV47HbAIpXb4wKTMbedR86yQkkSDihQBPrg5
 fTviiU7YW2LdJErMdY/rQvWEcBunHLD5q4IsZmjCWPeY4Ob+SU6tGlYZ+/eL4trmN4LS
 WXk4etkM37gcCqZGIBPj4D+OBvnAZaWUNGKsopL+DmEq3z3LjkXmR8GMA5lRTI+LFkk3
 0C5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVGrsCs6woDEAHqBC6kAsDSbr94lm+EHk4If1AwNO6LeqP2mU6cQ1jS7Ms27bhHO4dl58p9KJj0Vy2@nongnu.org
X-Gm-Message-State: AOJu0YwzO1hmyq4gYwvdcH90mquICEVLs2GfbXU96CD2mG1zdpQEBn+M
 Y8E5y7yNaPDencolfF0ghiRPmOxL5nhSgTFhvIoZmXU4cWB1T0P1iWWLJkc5t7oikgU=
X-Gm-Gg: ASbGncvAaN6IsgJ9rP9v1h1WQg79zY4tl8opVEq8NYdn6gLYH1b/YMffESXmJ39Rpca
 ChTOTW3LJcOcgVVdi1oGhf8QLusHrnUOSjH18drdAJf1CdwMBnYQP2DLW/qf0RCQAA3hcvmCVnE
 ebWxEzQk3eTz5we1KGFQETZKYboyD7mv7ns9FLuQPrJBqNg4Jg9UeWe9EA9jDM85mc0d142FiVP
 tHGFhMMH2EpvWGC0SASoWT8vd5w/Tw9IrW1V/lIiBR0XiDQxKJA7kXcO1KwrvDUueSl0UzOCffi
 I05wVPHDDr6dL9a1dvBoLfjIudtvo54A+hnmJuWtuhytErQlHIQzmiJmzliTykFZyZIL3Ervuvn
 7
X-Google-Smtp-Source: AGHT+IFy1AsMHlkmrOzvOGacQWv7XacbaXHoa+K4TgehexgaJuVk7SZVSQ512IO+y1EqYR2Y29ZbMg==
X-Received: by 2002:a05:6a21:3294:b0:21a:de8e:44a9 with SMTP id
 adf61e73a8af0-21fbd7b43b3mr28081030637.37.1750269773402; 
 Wed, 18 Jun 2025 11:02:53 -0700 (PDT)
Received: from [192.168.68.110] ([191.255.35.152])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-748f5dcb0e3sm449160b3a.55.2025.06.18.11.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 11:02:52 -0700 (PDT)
Message-ID: <5c6f06ae-3437-4438-87f0-33fe5961de1f@ventanamicro.com>
Date: Wed, 18 Jun 2025 15:02:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] target/riscv: Add mips.ccmov instruction
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>
References: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
 <20250618122715.1929966-6-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250618122715.1929966-6-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/18/25 9:27 AM, Djordje Todorovic wrote:
> Add mips.ccmov defined by Xmipscmov.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
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
> index 1e85a16971..6ed767e922 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -242,6 +242,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempair),
>       ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
>       ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
> +    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),

The order in the isa_edata_arr matters - we use it to generate the riscv,isa DT later on.

For the xmipscmov entry you want to put it at the start of the array, before the xthead
ones.

Same thing with the other MIPS extensions you added in later patches. Thanks,


Daniel



>   
>       { },
>   };
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
>   #ifndef CONFIG_USER_ONLY
>           .custom_csrs = mips_csr_list,
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


