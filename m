Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04F5CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn34-0003bS-KR; Thu, 23 Oct 2025 00:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn33-0003bH-Mc
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:37 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn31-0001M1-5E
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:37 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b6cf25c9ad5so259888a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194133; x=1761798933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uqEiFYtxMjkxvxS6uKXvLcW2kyntPL9oQXhowe/Obo=;
 b=TZilBe5hk0SRL2vh/ekoYqsohEMqye1ejB+0uOSMruliyLNj5/9pl/lZSoGSbHfPQA
 HCp006v9r7CApB+vOK5+U2+AdA8dE7KZIRNOl+jhh74qcS2dH2074RswcAfO9mtA9ffG
 ZyeyW8Re8WJ0ri0waTRTbGwf1/Senzi/0esqcdWsTFllAQOvzTsie9YBdW0X4FdA1SQD
 wuB1V9eqni5CuIBd9dk52j8saYTNMNz9sLsqawfB4a3TkA5uNjFmI+L9IEWRMnROvots
 qhfvewInr9Zh+4CJ5bHrtNgbMyfItzsYPXNL4voSbSMwqDdktZ4dAtZFTZ/AlV5cjoxM
 Lg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194133; x=1761798933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uqEiFYtxMjkxvxS6uKXvLcW2kyntPL9oQXhowe/Obo=;
 b=d8UaUGuWQWsZ5C/1l1a4hGabYsKUF5Sg5J5OCrt1awh1mPx3EAn/1bnlOwDC5B6ZLV
 yH8zjnRzsRZnCZ+q6O8EFqv3ypPUrJvJzSHN73LQpNk5XezQ6Ll8gDmPfPVd0Ze+DmEt
 Xj/yZ2WJBjZeDCPxRRamLcWv+J4hZVAfGBPI8jMvYbgITFLvHVURy4jH1qzCMHmYy4xO
 BWGqSF6uuUvoyM02rGRY8yGXYeRSu+LBzrEtS9fHR0WZVkdGi4NAT8jlP7o0GbEq9bZR
 GzeyMEODEXV8ljR5O48xF0XCxJi171nEy8eV0aVCDyBOjx8Kzl8r7VmK6RvTVE09o3jQ
 x3fw==
X-Gm-Message-State: AOJu0YzAUYN99oVuUleDu62ITsTN/GW/x3XdVzJ15PM8wNDZa6S7IH1O
 bXKGAjbNnGshW+swBEIfZ1xHgZFlK0I2c9J7/TEAPySiNPn2ATmEpOjO6xZVTQ==
X-Gm-Gg: ASbGncs/pYv225ZZ/2qhD1vM/7YJKqc1uHGPtlQAhdp9Hy2TL87+kbtiDMm2UdrMv8h
 EC86dcEOOGzT5HqvU18gfu8HuPhtzW6BmKMTKkxp33B17iZ7mDR2szgCg8zbAbWB3nEkiakrU3S
 TN0nXih8vOMqelBelRb21Wa84vPvne9EPMoe0dDSlq26tvMXmP8du94YJ3Cr5u2zM2EcqD977Bq
 4hAY/2qrteGLMSZGAyOPnhj6f0j7OYeCM8S66OueI8zcrl1tC9H2bI5vqbM0/svalxJUVS+tysO
 gIzGUFQd0dZNqfdwHtp4enWrZIKkgy1sjjL+ePFR2tT3rna5dUJ158oSspDebbHZB+4RoL2R6L9
 dMIPfTqKPOxKb8em8un507H5/XTc+Hh1Wvi/569XC8SpPKbgCoaTmdmaBPHkK9sMWS+3JhSYThp
 x6S/mwyupdnmHicEcOe3BaKyZc6Ni6ZuxyyK7kpOBRNsSvD1Ze0YTx7nJXYhtoCmuExRfCFdQhz
 s5IxHXm
X-Google-Smtp-Source: AGHT+IGvbLo21VMpBoLrUtc2FKegDsPwTcuPOcX8CmZIrf07ieFZDCeeOOd1cZNGniqDJcL7WkLcyA==
X-Received: by 2002:a17:902:f543:b0:24c:965a:f97e with SMTP id
 d9443c01a7336-290c9cf2e68mr301020125ad.2.1761194133224; 
 Wed, 22 Oct 2025 21:35:33 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:35:32 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/37] target/riscv: Add mips.ccmov instruction
Date: Thu, 23 Oct 2025 14:35:06 +1000
Message-ID: <20251023043520.1777130-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251018154522.745788-6-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                    |  5 ++++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/xmips.decode                 | 11 ++++++++
 target/riscv/cpu.c                        |  3 +++
 target/riscv/translate.c                  |  3 +++
 target/riscv/insn_trans/trans_xmips.c.inc | 33 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 7 files changed, 57 insertions(+)
 create mode 100644 target/riscv/xmips.decode
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unus
     return true;
 }
 
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index e2d116f0df..a290303ee7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..fadcb78470
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a52e6b7b7a..b0a1de6a26 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1381,6 +1382,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
 
     { },
 };
@@ -3295,6 +3297,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp = true,
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
+        .cfg.ext_xmipscmov = true,
         .cfg.marchid = 0x8000000000000201,
         .cfg.mvendorid = MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e1f4dc5ffd..53ce86d583 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1210,8 +1210,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
 
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1227,6 +1229,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 
 const RISCVDecoder decoder_table[] = {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..3202fd9cc0
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,33 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+/* Conditional move by MIPS. */
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero = tcg_constant_tl(0);
+    source1 = get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 = get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 25d59ef9f9..3842c7c1a8 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen = [
   decodetree.process('insn32.decode', extra_args: '--static-decode=decode_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=decode_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=decode_xmips'),
 ]
 
 riscv_ss = ss.source_set()
-- 
2.51.0


