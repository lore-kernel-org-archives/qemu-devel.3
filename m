Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FD3E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbr-0007ic-Qr; Thu, 02 Jan 2025 13:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbS-00072i-Vd
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:29 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbQ-0005CW-KG
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:26 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21675fd60feso209297725ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841243; x=1736446043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OMvZr/BaUUfnQP6zCu0M5f0NpLKkXRAY+r8gqBeLKeo=;
 b=Okp9FiZUS+es+x75gLyI3wKXf+Tu6GcD9s0p+efXf9FwkQPNN1cIAfAfqcPOHydSVQ
 Mg9v7Q3LJ2TPT/JQLCeqowCyr9ycvfwn/MJWwdjCbc8LV7iTilPMaQJl71mdV5GUmaau
 rQEba00EYbOmgwnoCqYpYGbfxrhby3zvZ7uODIFe8w594gPNXGH0LxQ89wQ9b9G1n5EH
 tijI2bfclVTepLLJ/5izYaX1PIVrP4VudX5MNFYY4pXLNq2v1CJDod9MG4seP7AJmCw3
 cq3n2OyLLc28mKYWIDsyG4HL+FeN3haLtz3rVd2FVR/yYDMBJgCX5rzWTMEZGFhiMa1i
 SMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841243; x=1736446043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMvZr/BaUUfnQP6zCu0M5f0NpLKkXRAY+r8gqBeLKeo=;
 b=AcaAAjlZxUMij6artTIHBwvdLZFIhRJWOOHmgR4uAHvW+/V+pbdmM5rY3iHnBaIUB4
 TDlyHJpbrDZx1d12TP8qoVO3QmwvYk7VCpkS+bQiLEozwAQFIXmyNyqZj6RV7uAD+8H/
 Qf+UV5JK4weMELqrk7GmwAqLoSvomNwazE4FJ1p+ubR6ekT/nXJekNWcJSBQYU9f5O09
 ZuVclfG65jS12CZ4f4g0tT4y4ebnQmgeRc4TSxllkonVlu6KKhlPDDympaBb7/iSoxsK
 iPOWm1Sb7IT8p1X2kxA0yYIHE4Sy55PiEjE4G0uu2l7ns/nxoCyOnP0RQ+TASNf5cMnr
 w23g==
X-Gm-Message-State: AOJu0YyMDlbbujzum7afoHq3KX7GPNWtNfpTq9O8uEwpTS8UbDyyeDZV
 xRystvQj+0ZAO+b3/7HUr4LULWa14g6zuM48UC9qFUk+0KNjcFPaK31cawnLq+xM7UlQ7NUbqeV
 Q
X-Gm-Gg: ASbGnctmuDsbHwOW07JJwEgth5NueOhkahWfeNapy1hnifPrjWuWu6AW2J71uCorHpK
 TXpohPmSbUN6+tOul2n926vBaGTDCeS1g68bPRtfFW56jcwQ89yk/9IWjPxvgFwrphYVKwy4wlK
 fgR5NmoP00iDs3bYHFSPm9xX0mK1oT49O6fo7NgjEzR64hs8ovgPicG5x7h6CCNTkswH8XUEWH2
 Oiw4saLaSbELajBm6/xGRtk8hhoeS+d3zxVZ/84MP6ddwgIEDA01NHt02l1pg==
X-Google-Smtp-Source: AGHT+IG6kgp9qayaK8IIxQpDs3mRCBdSa7cAWi2+KUcz/dJwsr+tzYyrjfH1VXxtnHbXMssJV1IAWg==
X-Received: by 2002:a05:6a00:f96:b0:724:ed8f:4d35 with SMTP id
 d2e1a72fcca58-72abdedda5fmr68733597b3a.26.1735841243223; 
 Thu, 02 Jan 2025 10:07:23 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 36/73] tcg/mips: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Thu,  2 Jan 2025 10:06:16 -0800
Message-ID: <20250102180654.1420056-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Accept AND, ext32u, ext32s extensions with the extract opcodes.
This is preparatory to removing the specialized extracts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-has.h | 26 ++++++++++++++++++++++----
 tcg/mips/tcg-target.c.inc | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index d01f74a48f..2932f99a97 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -71,8 +71,8 @@ extern bool use_mips32r2_instructions;
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
@@ -80,8 +80,8 @@ extern bool use_mips32r2_instructions;
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
@@ -99,4 +99,22 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              0
 
+#define TCG_TARGET_extract_valid(type, ofs, len)  use_mips32r2_instructions
+
+static inline bool
+tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+        case 16:
+            return use_mips32r2_instructions;
+        case 32:
+            return type == TCG_TYPE_I64;
+        }
+    }
+    return false;
+}
+#define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
+
 #endif
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 8857398893..6acc2c99a4 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2041,12 +2041,37 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_opc_bf64(s, OPC_DINS, OPC_DINSM, OPC_DINSU, a0, a2,
                          args[3] + args[4] - 1, args[3]);
         break;
+
     case INDEX_op_extract_i32:
-        tcg_out_opc_bf(s, OPC_EXT, a0, a1, args[3] - 1, a2);
+        if (a2 == 0 && args[3] <= 16) {
+            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, (1 << args[3]) - 1);
+        } else {
+            tcg_out_opc_bf(s, OPC_EXT, a0, a1, args[3] - 1, a2);
+        }
         break;
     case INDEX_op_extract_i64:
-        tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU, a0, a1,
-                         args[3] - 1, a2);
+        if (a2 == 0 && args[3] <= 16) {
+            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, (1 << args[3]) - 1);
+        } else {
+            tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU,
+                             a0, a1, args[3] - 1, a2);
+        }
+        break;
+
+    case INDEX_op_sextract_i64:
+        if (a2 == 0 && args[3] == 32) {
+            tcg_out_ext32s(s, a0, a1);
+            break;
+        }
+        /* FALLTHRU */
+    case INDEX_op_sextract_i32:
+        if (a2 == 0 && args[3] == 8) {
+            tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
+        } else if (a2 == 0 && args[3] == 16) {
+            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
+        } else {
+            g_assert_not_reached();
+        }
         break;
 
     case INDEX_op_brcond_i32:
@@ -2169,6 +2194,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext8s_i32:
     case INDEX_op_ext16s_i32:
     case INDEX_op_extract_i32:
+    case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -2190,6 +2216,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
-- 
2.43.0


