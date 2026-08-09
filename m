Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE029C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7m-0000pL-Q0; Sun, 09 Aug 2026 18:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7l-0000oU-3g
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7i-0007Lq-I0
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cea3004256so15063845ad.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314965; x=1786919765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vBIaC0TEbddzk6bE4I0McVQv9S5gcFlTp0SCsfcdZA4=;
 b=yzqJ1Ty7A74ZQR6lsItE7a1rtwKcMzrPFpUBUfP8fl66VHbalvUyFvVNl92ORu1q2q
 66qSknfjnORIeUJdMfmTBaMW15TEFTZG5ElkdMxsuAFWu7xC/Xq/9mnV5KevDYxzHBhv
 vRvNt3LZBGc0bY1mueYYV0cdMRVtIf1LI7mJwJRSuRliED+Z2S0IvUgiVu+Xb36ECM1Z
 /iYc+x2cDFv+i/t1EZ1CCn2pgPoYPXiaqFrrBzVCTQGEkwwypPZHU7HilG4Mw2tLLiS9
 /HE8qPtPON3LGpFZoxutIhN9eNyuj6lMiOKq1TR+pQykj30k0lWXxodvhnhLH6+tysQw
 eApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314965; x=1786919765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vBIaC0TEbddzk6bE4I0McVQv9S5gcFlTp0SCsfcdZA4=;
 b=m3uv3Chw8WPxyNKWIPwBlj8RYwsc6mqcQAtqz/SuJLHfvFcwb6baOZNh+qadfBtpRE
 qrVdPwhTemeQxg3COtzM0H7LFCOjMMlx8p5HjkWVAotW/+7kMSpvZl7Iv8D/7YkWBm6m
 OC66xo3Ie9J8GzbPQOdA2uiZN0yw6BKG+fLmTImkRscdq4fuk2UcJ2P56xT4GOCllPEf
 FpkSD0wAzzR0cdu4OqYFdGy7GYIp57oVpwgVuQyt+0+EzfCePJ5nnJnmGbMI6/Q2dB/n
 ZY3s0X2FrnMYsmWkiV3cLeph/Rrn0iPJHhq/46cG8u0vm7PQXzjA6r2SFy7jvOUO1/mD
 y96w==
X-Gm-Message-State: AOJu0Yy36dFA+w6Kw7RAnxGrEI68OBiw7JMgKuN3HwnE9cICAltug5BB
 O1UrdFj/QUy6cez1DUFDdVpGpAved4teSHZJY1YX6gyNVg0OJa51vZFMAgudZkf8L8gn3Sj2DND
 7s3vv
X-Gm-Gg: AR+sD100OV/R2U6eAEDqEtKMf2pOdPPHXUThFo6Wd2do8nKbI8K39wrdFm0O9rmcj2p
 8HIO+U4zm84dxVFBv61U6toLfK05Tjyo+9sd5YhPk7qEiDaiq9LjUOf9Zn8I/rOr9R8npcMUWZk
 5jwkYTblrV+WNjNs7W5VR/uBB0CVlg023Chs9L3uWBYjHYXsm6sP4xIYeWYeY/rVFnp0lgemZro
 frXWGE3HpwinYHy+qs+XpBr3+faVjqSSkW3uZlSsSIVKd0pvdy8q0pRCIH02qxe9ZAdBCRJg9zQ
 skW1eUSPXk3IhIplhu3jJ8xTM2NPcZvjJHvO3NHv87m31J28MxGkaokEBYlfifuFOPNs7cFRGUS
 QaoiIeFu2riwCJ6fmvlMm0XEGewqfRZMO4SuUOQZlSDi3M0f0JPVdy8weHh3/7O4CxjqWAqjFal
 cjZSLb7MXq5vAX2phpqGARkE+rcJ1odMz3qijfr0pM3F2FL8msXdojWrCZWL7Y8TOEUlVHG0bdN
 Pmzu0ChI+LfWsjEPRB9
X-Received: by 2002:a05:6a20:4309:b0:3c3:954d:278d with SMTP id
 adf61e73a8af0-3cb85df09e3mr41107323637.9.1786314965094; 
 Sun, 09 Aug 2026 15:36:05 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 14/56] disas/riscv: Set dec->opcode_data in decode function
Date: Sun,  9 Aug 2026 15:35:03 -0700
Message-ID: <20260809223545.730664-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This allows each opcode table to be private to the decode file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.43.0


