Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D32CCF9E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn3C-0003cj-OY; Thu, 23 Oct 2025 00:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3B-0003cb-Ik
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:45 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn39-0001MX-71
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:45 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-290c2b6a6c2so4074515ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194141; x=1761798941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C3z5o5ccqh3Cciac2htt8HHydUBIUBUlMnEqh3A40d0=;
 b=XCuX2WOV081SzO4fTGirC+F1ue4q2lmESktpy+jQgaKb3ZV0RMWMQ/Op5NsWminUTc
 ipX0w2Uh4FwDkzNECLKk7qiWmqMM9VNTG1tjExeRY0uK1AutUlI3wdf1zY+mVm2WlTv1
 4pnvO2TvqKF0olvp7qypxe7+H+NmQIUi1YtjMVRfKpKtRo3PBGysYkcioWjKL3FElBIa
 5Bt++nDWzg0GiuWKUSZCfr6xV3/pO81TaSR6nCjV1RnzRJxnQdaQsbIwcAtzv2zcE5rJ
 IwvpPZvkvjPk49s1X9pYCtsAdyZ7c0uiHMuTFmlGaQQVN0YPx/RB6luo/v5QCn7kr8II
 NfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194141; x=1761798941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C3z5o5ccqh3Cciac2htt8HHydUBIUBUlMnEqh3A40d0=;
 b=mC8w8begdOpCSwbPIs97yTZ3Yt3tzL+MYAcplpTKR/GQSYQ4CFe4Nx5MytHLcuQuUY
 jtVCxBf4VFVmEuAjUrurFfWaRX+Nxue0nFfLIx45HawBFOgwyqKdaQq9Q9RIZSlSu+sx
 ZwyTEiGDVBAod8jES2yU+Zf4xoYPaQ3SbbJnlxj8RvZMwLS2NYPw6myStHz2yl3xmNdz
 sfWa/tJbXKgTcy1ESeYEJdu+GpVhU57PV100PEWqbtY72ku4L3xO+AfFOKehJPDFGF5n
 JxlRm2+KpyiKxOwIJLhe90Sm5MqyhxPF2ytDEFOCgGZiafyDJ6exzm7ISAO7Pm0RHfni
 kAug==
X-Gm-Message-State: AOJu0Yw593D8rtg90VyTJunttqvASyNopgTHprzmq6gcfsmz7rwTQaP/
 PNLJWis8LbYu4TsdcGHWcXRuhV0UszWUxoUw61OGLg93cFDe9H/knjU2epLpSw==
X-Gm-Gg: ASbGncu8HJyH2Lj3FC1SQnNCYU9xcyP8U0uHxVymIerUrtXvzEs2jZrBLahbtrgRXPi
 VwfKZ70dROxsgrQ3CKJ+tAS6gupX/3w8l/Nb+b2x06PiziomF/+Os78LV/zx2P6wvxMF08K9GX0
 JvhGi8NMmr7wSzcB8oN3P0Ma+bRtzFjcZ6U5WL1vQ9fumqgTWJ0pu5W36nK+n/2qLbIN3Vj+617
 HBYmtkzrLTf7pdBKxUENUondtel6XvbsdQpOdQ8Npbz9PkjNIzmWmDB+MxA+E+/Ab2gVVDnDtJS
 NjEZnR0nvTtuhBaOHBW+rdahVB/Qs/P+DLGDC7EccxpXjclKEye//uS+U1wm6ejPUTISg5L4fys
 3dZf9SnzEFVGjk2A3NS8b5NuoobI2zCNQr/bWnSfKdktNzYy8pvJBhi1lbON/yDlOAfs1c1eWNV
 uPUPbU34PiGekHK26jxjy1h9erSf6nUNYGNmNCB4Gyb/zS5fAbspXdYYU6tNzi0YK6sOn6WlPQK
 aq8qEsT86J8FxpL/pU=
X-Google-Smtp-Source: AGHT+IEFdH4IMaRXQA5a4YPZyj3ihhTQOxxIAoMYGci0ipCtrfySTrWRjfJF2vk5CL7FMQn27WZOhw==
X-Received: by 2002:a17:903:3c24:b0:267:a942:788c with SMTP id
 d9443c01a7336-290c9c8c5e9mr286363085ad.1.1761194141137; 
 Wed, 22 Oct 2025 21:35:41 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:35:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/37] target/riscv: Add Xmipslsp instructions
Date: Thu, 23 Oct 2025 14:35:08 +1000
Message-ID: <20251023043520.1777130-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251018154522.745788-8-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/xmips.decode                 | 23 ++++++
 target/riscv/cpu.c                        |  3 +
 target/riscv/insn_trans/trans_xmips.c.inc | 88 +++++++++++++++++++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e4d5039c49..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unus
 
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
 
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index dd3ee7ba2b..7c624ab677 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -149,6 +149,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 4215813b32..3174f17aa4 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
 
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=ex_shift_2
+%imm_w     25:2 10:2              !function=ex_shift_3
+%imm_x     22:5                   !function=ex_shift_2
+%imm_y     23:4                   !function=ex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e259ff0286..77388ac76e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -251,6 +251,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1385,6 +1386,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
 
     { },
 };
@@ -3299,6 +3301,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp = true,
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
+        .cfg.ext_xmipslsp = true,
         .cfg.ext_xmipscbop = true,
         .cfg.ext_xmipscmov = true,
         .cfg.marchid = 0x8000000000000201,
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
index bfe9046153..9a72f3392f 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -21,6 +21,12 @@
     }                                            \
 } while (0)
 
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 /* Conditional move by MIPS. */
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
@@ -38,6 +44,88 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
 
+/* Load Doubleword Pair. */
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 = dest_gpr(ctx, a->rd);
+    TCGv dest1 = dest_gpr(ctx, a->rs3);
+    TCGv addr = tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Load Word Pair. */
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 = dest_gpr(ctx, a->rd);
+    TCGv dest1 = dest_gpr(ctx, a->rs3);
+    TCGv addr = tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Store Doubleword Pair. */
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 = get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr = tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+/* Store Word Pair. */
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 = get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr = tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 /* Move data from memory into cache. */
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
-- 
2.51.0


