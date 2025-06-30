Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67D4C83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWD6w-0001rt-9q; Mon, 30 Jun 2025 07:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD6l-0001pS-Av
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:55:35 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD6f-0000IW-RJ
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:55:34 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7d3e7503333so286002485a.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751284528; x=1751889328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IQSB/RDjPErWEF3Ghlxy9jM045ah+bzmvLRyO80r1SQ=;
 b=WSoFQYPVGFgu+LdZjVVknqUPaw0BRGwWjPLLwSVWjhXTyA6cY2s/KmVx2H+xHWrRiB
 VVy1Sscr1kfDiQBYif0Nr6PRnom9mby6SPClEryBUbfcW9D/K6h23R2e6SYGjyUziduV
 vnCYQ2048dwguAa6tCEeBhLteyGGlATx2dA5KVZseCGF0UbdesSA5+L9gH29BsqoEpC3
 55f8ZAWLu9MPVTjsXyLCXfhG0AqCuu8nxnpwv2iQNXeJtSYHcdkqoVFGkc84yLKa4xQi
 FAqc7ziJIH9TofN3268Ny9jMM22SdxuY9DBmyoSVwJf6A1bnR7LxkaylqOiuRWBy22rR
 K5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751284528; x=1751889328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IQSB/RDjPErWEF3Ghlxy9jM045ah+bzmvLRyO80r1SQ=;
 b=FNkmmo3TbbGNWdeEBwDLLl4cBiEz0Md5rw3mzAv6ZRphZIAVj4f5EKUty3mAvRKg+s
 MQvMz1aEBWlKon4jiJqdvuvf8XzYZg8Vk7crOvM97VDAIlE1G41aC/EBf+vHCDwSkSwf
 ivzz2Zjo1/zBJuaqmItn/Xuxj6elDwC11UP/zLkUhWKuY7kjh0sT2pkZDezUq4kmbEJL
 cQDBBuqZVzEXoXm4DFDMoPcHWEwv65RndJ3rZm74LKCciZRo/LaEqdS20Ha5ln/Zah9x
 DkFQWWtfTxtlMYPkIZTGwRkX7nboM5t+qfiNJg+7HzjoUPxHJUDXCvjHi00gK0cYq20L
 03CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqO8yDSnQrAbmvczVtZI3as0kmINkNIj5PZQ8yiaJtcBsPrOZGf40jvgos60OWzQ4CkhboH/3H5GXa@nongnu.org
X-Gm-Message-State: AOJu0Yxpv0Od0mXhOuHy0x2cERkrgcgb3vGNaGANZO/ATzsPFFe7AM9Y
 4K9QXG7An1dRiwnJT0dA+zbRr+ODhnVAFTAZzMa/M+4tw5WgYFH9VU4Y4p5CzjbRrxwITgMgG1s
 WJCu7
X-Gm-Gg: ASbGncueyN/slvxZCrUD1pEVfiJ2DEHSIGPsT+1i+hqFF3CW19+hFjoW5jNNDOzBljK
 b+S39SfPrIlrBUfnzY1kgdtZsW6asxRCVu92WNkaberiA5rbLESZAtjWUjEqdHGSyTB0su1CEke
 NJkfLeqXNfI9SxfOd0XxUuJqsCMa6DNLSsH8Wn22Twlz4flHXDz019WesF0eXry0UKRsJyVIXUd
 sCVUOftcI4L+ZXzYooXyhJFxzfb49+zcZiJWi2fu5p1mOvi4ueJtkUeJLz1/Z0r8n8U0w6GCjR6
 ouo4zbfq8Iw+QFm0walITiBIPZcoUYxroJLUntDZ0gh563TXsYLq2/CxbNQGZlPuLjLKgkgA0L8
 =
X-Google-Smtp-Source: AGHT+IE3oIWwlrLZp/xPA7euV42DfROjeO8m2F5ORGRn8f+T0hbfQqHRa/NdHH2iWxCTyF3SwOl8Xg==
X-Received: by 2002:a05:620a:198b:b0:7d3:9113:7902 with SMTP id
 af79cd13be357-7d44397f5e8mr1662475285a.38.1751284528338; 
 Mon, 30 Jun 2025 04:55:28 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d4431777d9sm578667685a.39.2025.06.30.04.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 04:55:27 -0700 (PDT)
Message-ID: <0e3291b5-bd50-4886-b09c-9afbefe4d6e7@ventanamicro.com>
Date: Mon, 30 Jun 2025 08:55:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] target/riscv: Add mips.pref instruction
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
 <20250625141732.59084-7-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250625141732.59084-7-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x72c.google.com
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
> Add MIPS P8700 prefetch instruction defined by Xmipscbop.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c                        |  3 +++
>   target/riscv/cpu_cfg.h                    |  3 ++-
>   target/riscv/cpu_cfg_fields.h.inc         |  1 +
>   target/riscv/insn_trans/trans_xmips.c.inc | 14 ++++++++++++++
>   target/riscv/xmips.decode                 |  1 +
>   5 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d48fd4df4e..1e5194fd06 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -230,6 +230,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
>       ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>       ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
> +    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
>       ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
>       ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>       ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
> @@ -1361,6 +1362,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>       MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
>       MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
>       MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
> +    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
>       MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
>   
>       { },
> @@ -3180,6 +3182,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.pmp = true,
>           .cfg.ext_zba = true,
>           .cfg.ext_zbb = true,
> +        .cfg.ext_xmipscbop = true,
>           .cfg.ext_xmipscmov = true,
>           .cfg.marchid = 0x8000000000000201,
>           .cfg.mvendorid = MIPS_VENDOR_ID,
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 2db471ad17..9734963035 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -22,6 +22,7 @@
>   #define RISCV_CPU_CFG_H
>   
>   struct RISCVCPUConfig {
> +
>   #define BOOL_FIELD(x) bool x;
>   #define TYPED_FIELD(type, x, default) type x;
>   #include "cpu_cfg_fields.h.inc"
> @@ -38,7 +39,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unus
>   
>   static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
>   {
> -    return cfg->ext_xmipscmov;
> +    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
>   }
>   
>   static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index baedf0c466..9ee0a099bb 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
>   BOOL_FIELD(ext_xtheadmempair)
>   BOOL_FIELD(ext_xtheadsync)
>   BOOL_FIELD(ext_XVentanaCondOps)
> +BOOL_FIELD(ext_xmipscbop)
>   BOOL_FIELD(ext_xmipscmov)
>   
>   BOOL_FIELD(mmu)
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
> index 269b1082a6..6555a6062a 100644
> --- a/target/riscv/insn_trans/trans_xmips.c.inc
> +++ b/target/riscv/insn_trans/trans_xmips.c.inc
> @@ -19,6 +19,12 @@
>    *            (https://mips.com/products/hardware/p8700/)
>    */
>   
> +#define REQUIRE_XMIPSCBOP(ctx) do {              \
> +    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
> +        return false;                            \
> +    }                                            \
> +} while (0)
> +
>   #define REQUIRE_XMIPSCMOV(ctx) do {              \
>       if (!ctx->cfg_ptr->ext_xmipscmov) {          \
>           return false;                            \
> @@ -40,3 +46,11 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
>   
>       return true;
>   }
> +
> +static bool trans_pref(DisasContext *ctx, arg_pref *a)
> +{
> +    REQUIRE_XMIPSCBOP(ctx);
> +
> +    /* Nop */
> +    return true;
> +}
> diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
> index cb334fa4bd..697bf26c26 100644
> --- a/target/riscv/xmips.decode
> +++ b/target/riscv/xmips.decode
> @@ -9,3 +9,4 @@
>   #            (https://mips.com/products/hardware/p8700/)
>   
>   ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
> +pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011


