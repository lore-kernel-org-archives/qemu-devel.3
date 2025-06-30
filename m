Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E039DC8302F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWD70-00021N-8S; Mon, 30 Jun 2025 07:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD6w-0001vB-FD
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:55:47 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD6r-0000LL-UE
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:55:46 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7d3efcb9bd6so423662985a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751284539; x=1751889339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PZEHhb4pZ/eTYSftsH0/c25gtubLmLmoFMP5eE8btVA=;
 b=CHjnOzRFcC3FHNPO9x4bTRFKL9tgsZDlVjEs0NPyuF+jXpP7itrtu5IssW4U/BsukT
 gdlNHWxBQqehMwspO4zAp2gZ4PEusWCEKMCadInd0P81kcxXa7sLz1tCpzJE2NpPBMWJ
 7sWZogGO7zfFk6awM5qhWSs2KXU9o/N3aMBB+ios9JA+Ip6EjLY4RNXlOqlxAu6p7cwO
 rIs3QTJM+D1n4/6F6kQF64zchsZblyaqE4vc8GyFCKTueTMBV41IzKcSNadcIpwgVJ0k
 vV1/5WMZP7T3DN3iBGPhRzzv/ix+dmxGS4nW8jiwLBkBvd5W1h+A/VvaH/Op0/Mrnsbr
 NpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751284539; x=1751889339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PZEHhb4pZ/eTYSftsH0/c25gtubLmLmoFMP5eE8btVA=;
 b=idv1BjQ246YO6IF5HOp+1hl4CzMqaobr9KxyoZJheXh45A4HmIkOxdLBwXY3bXYACE
 k5B2p20oo+ervNV1M2BaSWJUUWEceZ8BusWHmWf+9LwrraRXR3I3iSB53NSPRfJhE91D
 H1jkbE+s6DNyLEA6h4ww/pTMUXiv5XnRmAWjhTh3+weXaplUP+9qPETCOFI7n6qm8YwL
 wPtfBlpgzr7abF3P1cDBWYByPPB1X6ckERA/qU3Y1qONORi8YlJ0h6G1rxP8hEVaxTAW
 ATzZtNCSnsal17KS4F/+D8XNRjZxDQaGg3GNuN3kVgH3jUe8dK3xg3LVXm1IYBIZ7cf5
 lRTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLfYsjQuHq8BEA0fUDs/ZytYRTO4kImUsDsdIXUuhoXM5fVEv18LTAhLNqXQmyeyHn16n3ZM9L2PdP@nongnu.org
X-Gm-Message-State: AOJu0YwK5WZqdaIBfuJQ9x7gVRn/ks71oBqbstA/ZgMe/jbNyRCvVgj6
 vLo6x+AssKtIMpFa3NWxYg6qr130QOgELe/9KM8Wnpukmx9fgz0CyUtCo6LwyRIfk9cw33WcmVk
 BJRru
X-Gm-Gg: ASbGncvy9L8aSIfU8Nf1d7pp/IE0l+G38OuU+ziBDSbmOs6RW05jRv/ps//44aCiSTQ
 hB99SJxO5m2J/vHxx0JVloFC4SZcWRVVjUwq/9HXPtBAOhu6zOOwy/omzlOUWL4tIioQy2xY5aS
 3kC2h4LvMK+HX3RzMlQLWHNtDFWmbtPrv0jzhoYilaKbKWVcFsCuWt4Vk+oa2+ccyDMkbKYOBS5
 Q+YQUiwEeWKjowDaoHwEua7djmqSwkv52FtO7FYQ5Z1DfJb5zyo5zoNy59dvAUGUmbTlghajl1B
 JHsLVGblVo8GYAp3622ye5/UhGEg7swt+ehVOfLTuluA2YHE2W3h5joLec26Pm1vTtFZzR8w6sb
 rRZs6d9PmEQ==
X-Google-Smtp-Source: AGHT+IEpEiR5N4Gn2aOktm1h8q0Dsd2ckW/04X+0j1TzK8H0yNi3edwM7FXKF+aCOKAmcBUEJiqwyA==
X-Received: by 2002:a05:620a:25c7:b0:7d2:107c:4228 with SMTP id
 af79cd13be357-7d44393a736mr1760698685a.18.1751284538658; 
 Mon, 30 Jun 2025 04:55:38 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44317eee9sm579696885a.44.2025.06.30.04.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 04:55:38 -0700 (PDT)
Message-ID: <079b9fda-f831-4c13-8d5c-4d42a08b63d3@ventanamicro.com>
Date: Mon, 30 Jun 2025 08:55:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] target/riscv: Add Xmipslsp instructions
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
 <20250625141732.59084-8-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250625141732.59084-8-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x735.google.com
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



On 6/25/25 11:18 AM, Djordje Todorovic wrote:
> Add MIPS P8700 ldp, lwp, sdp, swp instructions.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---

Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c                        |  3 +
>   target/riscv/cpu_cfg.h                    |  3 +-
>   target/riscv/cpu_cfg_fields.h.inc         |  1 +
>   target/riscv/insn_trans/trans_xmips.c.inc | 84 +++++++++++++++++++++++
>   target/riscv/xmips.decode                 | 23 +++++++
>   5 files changed, 112 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1e5194fd06..6e3514a713 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -232,6 +232,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>       ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
>       ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
> +    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
>       ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>       ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>       ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> @@ -1364,6 +1365,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>       MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
>       MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
>       MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
> +    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
>   
>       { },
>   };
> @@ -3182,6 +3184,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.pmp = true,
>           .cfg.ext_zba = true,
>           .cfg.ext_zbb = true,
> +        .cfg.ext_xmipslsp = true,
>           .cfg.ext_xmipscbop = true,
>           .cfg.ext_xmipscmov = true,
>           .cfg.marchid = 0x8000000000000201,
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 9734963035..cd1cba797c 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -22,7 +22,6 @@
>   #define RISCV_CPU_CFG_H
>   
>   struct RISCVCPUConfig {
> -
>   #define BOOL_FIELD(x) bool x;
>   #define TYPED_FIELD(type, x, default) type x;
>   #include "cpu_cfg_fields.h.inc"
> @@ -39,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unus
>   
>   static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
>   {
> -    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
> +    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
>   }
>   
>   static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 9ee0a099bb..b5195959b2 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadsync)
>   BOOL_FIELD(ext_XVentanaCondOps)
>   BOOL_FIELD(ext_xmipscbop)
>   BOOL_FIELD(ext_xmipscmov)
> +BOOL_FIELD(ext_xmipslsp)
>   
>   BOOL_FIELD(mmu)
>   BOOL_FIELD(pmp)
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
> index 6555a6062a..d2720a6770 100644
> --- a/target/riscv/insn_trans/trans_xmips.c.inc
> +++ b/target/riscv/insn_trans/trans_xmips.c.inc
> @@ -31,6 +31,12 @@
>       }                                            \
>   } while (0)
>   
> +#define REQUIRE_XMIPSLSP(ctx) do {               \
> +    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
> +        return false;                            \
> +    }                                            \
> +} while (0)
> +
>   static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
>   {
>       REQUIRE_XMIPSCMOV(ctx);
> @@ -47,6 +53,84 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
>       return true;
>   }
>   
> +static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
> +{
> +    REQUIRE_XMIPSLSP(ctx);
> +    REQUIRE_64_OR_128BIT(ctx);
> +
> +    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
> +    TCGv dest0 = dest_gpr(ctx, a->rd);
> +    TCGv dest1 = dest_gpr(ctx, a->rs3);
> +    TCGv addr = tcg_temp_new();
> +
> +    tcg_gen_addi_tl(addr, src, a->imm_y);
> +    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
> +    gen_set_gpr(ctx, a->rd, dest0);
> +
> +    tcg_gen_addi_tl(addr, addr, 8);
> +    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
> +    gen_set_gpr(ctx, a->rs3, dest1);
> +
> +    return true;
> +}
> +
> +static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
> +{
> +    REQUIRE_XMIPSLSP(ctx);
> +
> +    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
> +    TCGv dest0 = dest_gpr(ctx, a->rd);
> +    TCGv dest1 = dest_gpr(ctx, a->rs3);
> +    TCGv addr = tcg_temp_new();
> +
> +    tcg_gen_addi_tl(addr, src, a->imm_x);
> +    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
> +    gen_set_gpr(ctx, a->rd, dest0);
> +
> +    tcg_gen_addi_tl(addr, addr, 4);
> +    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
> +    gen_set_gpr(ctx, a->rs3, dest1);
> +
> +    return true;
> +}
> +
> +static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
> +{
> +    REQUIRE_XMIPSLSP(ctx);
> +    REQUIRE_64_OR_128BIT(ctx);
> +
> +    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
> +    TCGv data0 = get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGv data1 = get_gpr(ctx, a->rs3, EXT_NONE);
> +    TCGv addr = tcg_temp_new();
> +
> +    tcg_gen_addi_tl(addr, src, a->imm_w);
> +    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
> +
> +    tcg_gen_addi_tl(addr, addr, 8);
> +    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
> +
> +    return true;
> +}
> +
> +static bool trans_swp(DisasContext *ctx, arg_swp *a)
> +{
> +    REQUIRE_XMIPSLSP(ctx);
> +
> +    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
> +    TCGv data0 = get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGv data1 = get_gpr(ctx, a->rs3, EXT_NONE);
> +    TCGv addr = tcg_temp_new();
> +
> +    tcg_gen_addi_tl(addr, src, a->imm_v);
> +    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
> +
> +    tcg_gen_addi_tl(addr, addr, 4);
> +    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
> +
> +    return true;
> +}
> +
>   static bool trans_pref(DisasContext *ctx, arg_pref *a)
>   {
>       REQUIRE_XMIPSCBOP(ctx);
> diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
> index 697bf26c26..99c98d4084 100644
> --- a/target/riscv/xmips.decode
> +++ b/target/riscv/xmips.decode
> @@ -8,5 +8,28 @@
>   # Reference: MIPS P8700 instructions
>   #            (https://mips.com/products/hardware/p8700/)
>   
> +# Fields
> +%rs3       27:5
> +%rs2       20:5
> +%rs1       15:5
> +%rd        7:5
> +%imm_9     20:9
> +%imm_hint  7:5
> +%imm_v     25:2 9:3               !function=ex_shift_2
> +%imm_w     25:2 10:2              !function=ex_shift_3
> +%imm_x     22:5                   !function=ex_shift_2
> +%imm_y     23:4                   !function=ex_shift_3
> +
> +# Formats
> +@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
> +@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
> +@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
> +@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
> +
> +# *** RV64 MIPS Extension ***
>   ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
>   pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
> +ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
> +lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
> +sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
> +swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv


