Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E56C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNal-0004SX-CD; Mon, 24 Aug 2026 01:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZp-00037N-Eg
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:35 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZn-0002Sl-CF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:33 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38fdeaed181so4234146a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550630; x=1788155430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V3fM4y2C472xM9X4uqOcufwfeVn3Wu1NX6yZjjnlfQ0=;
 b=sWAy3um4uk2SQU23G6tQGdn1UzBn0lu6KcebXqIyV/tAUdnQcQDt5OE+KxPM3KR9YE
 mR+1Gesgyab3VMqKYxQ4BHWc0qKZJDP43diHJdBFkGOCFxRv4QMY3/Evuo/g0HMDpuy3
 AWhduLPfqXBLje4CrRaAxRtZEUgdYm7MeEdtQpvFMZiUqDbciGScTpM5XRBL6e/Ft1m+
 +EhoAFSl06OHMWyG4HgsSa20r83P/8CV+KjvgqoeFhuNkt4j8E9ESXFNzJjfqCXaY8Hv
 3U5uV13Z1apXDM+XWpvMULuEc/vyPYVszgH9hWnK6rnIi920AyigVkKI2bF4Jh2vVoDP
 vQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550630; x=1788155430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V3fM4y2C472xM9X4uqOcufwfeVn3Wu1NX6yZjjnlfQ0=;
 b=T6h/e1dsu60Q6g+Ga+EbajED7qGnvvOZ7x2QukL/uM+Rp2sO38jOzg3Zu2Ft8Pxg0A
 VjnCCHWewAZiPaJyNBDpryU80Nw4gWTrHMqIQmQ+mswaCpTxjvR4AQOdhhi7DYkI9qD1
 WC6kxO4sdjl3eCxa3KzFrRTVkWw4z8Ah1aPJLWgPEKisTtxC8u4eVjKgMDyOs84Q24Mn
 javOWiJ/wb6T34RDlg+b7H84/PsVAeeF11VDtJZLpdscx1RO/Q1no+lp3r0VVBqdgjao
 Qdq5lphGxNQ13atzsZbk4nayyLcy0YCcCzczGaYN3D0jynbj/zwUj1LKhPapZ+IdpYAC
 s0jw==
X-Gm-Message-State: AFuF++lepxZeM1YX8+bTzpNWs5ioIB9KEIm1YCu2Nf9UXzc40rXRJc1a
 7GIGf8F1tyv/7dNGvUkiXbMa4srYum05zwQ8aYdztuy8xeV8WH71mE84J666/g==
X-Gm-Gg: AR+sD10foyJwJRlXK1fHldeYWikMks8VJmYfBAj6dlXrBaXfMW1YiANEsDoa4/krvi4
 EbvKtM2mRfdno7tHKIFVp3UChGt6+oNSq0/YYw1rMRfiJs9znwTyr4CtSIzWsSZmAtKN2wIZobo
 3eioP58X7sRdkdHUkNtWYIck0rTZofJfSen8iEFQbv67obf/12skPiUEoeakiyajotmA8fowcrC
 6xRKoSE+EcgWEMtXpMT5jXoWOD4FaCD8bu9Eb3bMzBx5vTJFS0ldsVhE8ydMWPRzGwBsyaeGUpE
 9Cfbu7FNwel39tvCmOW71AAc0osqq+BF7DqqKWQ8u+S1gKrleYV3GiZ5EPtDf6qD7tnh8dB0lO6
 5gmSSyg/1Lj1es/PSbQ0nr/Sgc3xN3DBnsJBwI+ReSNBLhW+bceOxr1c5IEJA4O0RrO0y2Cqm9O
 rYr/UPOqTwAEQ5Kq9QPGeNJsa8PIe3lPGP2+hyrF26YbJeEiGqEtnUFr8I+wxXsv/owydi5VTbG
 XnHNXSpjS8SwBkF
X-Received: by 2002:a17:90b:520c:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-395c3867ac5mr44826268a91.14.1787550629724; 
 Sun, 23 Aug 2026 22:50:29 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 42/96] disas/riscv: Set dec->opcode_data in decode function
Date: Mon, 24 Aug 2026 15:47:12 +1000
Message-ID: <20260824054806.2790041-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This allows each opcode table to be private to the decode file.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-10-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv-xlrbr.h    |  2 --
 disas/riscv-xthead.h   |  2 --
 disas/riscv-xventana.h |  2 --
 disas/riscv-xlrbr.c    |  4 +++-
 disas/riscv-xthead.c   | 13 ++++++++++++-
 disas/riscv-xventana.c |  3 ++-
 disas/riscv.c          | 34 +++++++++++++++++-----------------
 7 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/disas/riscv-xlrbr.h b/disas/riscv-xlrbr.h
index 939a69ea6d..ebf3d4c133 100644
--- a/disas/riscv-xlrbr.h
+++ b/disas/riscv-xlrbr.h
@@ -12,8 +12,6 @@
 
 #include "disas/riscv.h"
 
-extern const rv_opcode_data rv_xlrbr_opcode_data[];
-
 void decode_xlrbr(rv_decode *, rv_isa);
 
 #endif /* DISAS_RISCV_XLRBR_H */
diff --git a/disas/riscv-xthead.h b/disas/riscv-xthead.h
index fcd42746e7..0c65c8e0af 100644
--- a/disas/riscv-xthead.h
+++ b/disas/riscv-xthead.h
@@ -11,8 +11,6 @@
 
 #include "disas/riscv.h"
 
-extern const rv_opcode_data xthead_opcode_data[];
-
 void decode_xtheadba(rv_decode *, rv_isa);
 void decode_xtheadbb(rv_decode *, rv_isa);
 void decode_xtheadbs(rv_decode *, rv_isa);
diff --git a/disas/riscv-xventana.h b/disas/riscv-xventana.h
index 72be9ffa16..1006c3be00 100644
--- a/disas/riscv-xventana.h
+++ b/disas/riscv-xventana.h
@@ -11,8 +11,6 @@
 
 #include "disas/riscv.h"
 
-extern const rv_opcode_data ventana_opcode_data[];
-
 void decode_xventanacondops(rv_decode*, rv_isa);
 
 #endif /* DISAS_RISCV_XVENTANA_H */
diff --git a/disas/riscv-xlrbr.c b/disas/riscv-xlrbr.c
index 57cb434523..f61028fce9 100644
--- a/disas/riscv-xlrbr.c
+++ b/disas/riscv-xlrbr.c
@@ -24,7 +24,7 @@ typedef enum {
     rv_op_crc32c_d = 8,
 } rv_xlrbr_op;
 
-const rv_opcode_data rv_xlrbr_opcode_data[] = {
+static const rv_opcode_data xlrbr_opcode_data[] = {
     { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
     { "crc32.b", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
     { "crc32.h", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
@@ -75,5 +75,7 @@ void decode_xlrbr(rv_decode *dec, rv_isa isa)
         }
         break;
     }
+
+    dec->opcode_data = xlrbr_opcode_data;
     dec->op = op;
 }
diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index 2f2ddb8dd9..96f80bc8e5 100644
--- a/disas/riscv-xthead.c
+++ b/disas/riscv-xthead.c
@@ -127,7 +127,7 @@ typedef enum {
     rv_op_th_sync_s,
 } rv_xthead_op;
 
-const rv_opcode_data xthead_opcode_data[] = {
+static const rv_opcode_data xthead_opcode_data[] = {
     { "th.illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
     /* XTheadBa */
     { "th.addsl", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, NULL, 0, 0, 0 },
@@ -272,6 +272,7 @@ void decode_xtheadba(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -330,6 +331,7 @@ void decode_xtheadbb(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -356,6 +358,7 @@ void decode_xtheadbs(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -434,6 +437,7 @@ void decode_xtheadcmo(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -461,6 +465,7 @@ void decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -498,6 +503,7 @@ void decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -533,6 +539,7 @@ void decode_xtheadfmv(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -564,6 +571,7 @@ void decode_xtheadmac(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -638,6 +646,7 @@ void decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -672,6 +681,7 @@ void decode_xtheadmempair(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -706,5 +716,6 @@ void decode_xtheadsync(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
index cd694f15f3..4539173d95 100644
--- a/disas/riscv-xventana.c
+++ b/disas/riscv-xventana.c
@@ -14,7 +14,7 @@ typedef enum {
     ventana_op_vt_maskcn = 2,
 } rv_ventana_op;
 
-const rv_opcode_data ventana_opcode_data[] = {
+static const rv_opcode_data ventana_opcode_data[] = {
     { "vt.illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
     { "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
@@ -38,5 +38,6 @@ void decode_xventanacondops(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = ventana_opcode_data;
     dec->op = op;
 }
diff --git a/disas/riscv.c b/disas/riscv.c
index 9880b8de20..eb6d132a2c 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1656,7 +1656,7 @@ static uint32_t operand_lpl(rv_inst inst)
 
 /* instruction metadata */
 
-const rv_opcode_data rvi_opcode_data[] = {
+static const rv_opcode_data rvi_opcode_data[] = {
     { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
     { "lui", rv_codec_u, rv_fmt_rd_uimm, NULL, 0, 0, 0 },
     { "auipc", rv_codec_u, rv_fmt_rd_uoffset, NULL, 0, 0, 0 },
@@ -2948,6 +2948,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
+
     switch ((inst >> 0) & 0b11) {
     case 0:
         switch ((inst >> 13) & 0b111) {
@@ -4590,6 +4591,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         }
         break;
     }
+
+    dec->opcode_data = rvi_opcode_data;
     dec->op = op;
 }
 
@@ -5421,33 +5424,30 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
     };
     const rv_opcode_data *op;
 
-    dec.opcode_data = rvi_opcode_data;
     decode_inst_opcode(&dec, isa);
 
     if (dec.op == rv_op_illegal && cfg) {
         static const struct {
             bool (*guard_func)(const RISCVCPUConfig *);
-            const rv_opcode_data *opcode_data;
             void (*decode_func)(rv_decode *, rv_isa);
         } decoders[] = {
-            { has_xtheadba_p, xthead_opcode_data, decode_xtheadba },
-            { has_xtheadbb_p, xthead_opcode_data, decode_xtheadbb },
-            { has_xtheadbs_p, xthead_opcode_data, decode_xtheadbs },
-            { has_xtheadcmo_p, xthead_opcode_data, decode_xtheadcmo },
-            { has_xtheadcondmov_p, xthead_opcode_data, decode_xtheadcondmov },
-            { has_xtheadfmemidx_p, xthead_opcode_data, decode_xtheadfmemidx },
-            { has_xtheadfmv_p, xthead_opcode_data, decode_xtheadfmv },
-            { has_xtheadmac_p, xthead_opcode_data, decode_xtheadmac },
-            { has_xtheadmemidx_p, xthead_opcode_data, decode_xtheadmemidx },
-            { has_xtheadmempair_p, xthead_opcode_data, decode_xtheadmempair },
-            { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
-            { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacondops },
-            { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
+            { has_xtheadba_p, decode_xtheadba },
+            { has_xtheadbb_p, decode_xtheadbb },
+            { has_xtheadbs_p, decode_xtheadbs },
+            { has_xtheadcmo_p, decode_xtheadcmo },
+            { has_xtheadcondmov_p, decode_xtheadcondmov },
+            { has_xtheadfmemidx_p, decode_xtheadfmemidx },
+            { has_xtheadfmv_p, decode_xtheadfmv },
+            { has_xtheadmac_p, decode_xtheadmac },
+            { has_xtheadmemidx_p, decode_xtheadmemidx },
+            { has_xtheadmempair_p, decode_xtheadmempair },
+            { has_xtheadsync_p, decode_xtheadsync },
+            { has_XVentanaCondOps_p, decode_xventanacondops },
+            { has_xlrbr_p, decode_xlrbr },
         };
 
         for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
             if (decoders[i].guard_func(cfg)) {
-                dec.opcode_data = decoders[i].opcode_data;
                 decoders[i].decode_func(&dec, isa);
                 if (dec.op != rv_op_illegal) {
                     break;
-- 
2.54.0


