Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB55C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5s-0006Q7-Cf; Fri, 17 Jan 2025 13:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5g-00058F-HV
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:08 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5e-0000Gb-L0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:08 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ef87d24c2dso3452704a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138545; x=1737743345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgXM2SJhYN6NrfYWSGvykVkJvg5WrjNv6ztMf07JhME=;
 b=Bk3PeUpBiR3mtMi460YLysxv5wZeMoaCGEiSjnGWoclLHn+S5RBl9wATGWrUsf2OcR
 xe241xiiUdDpmX3nCxDfAra62//FJfV8k0jJjNP4xU5aa1pBaygOS0sYvpH7zDAPQrhF
 UXvl5dZcK5WYdr+9unEgOrkd0jlEiZDnOJCPAkB9oBrkei2br0a6HnCnYLQnBGm4I8rH
 ehSlwq42eyY93EguwFzHNINH898XFb/jY9wpWN/97WZOmGeim1ZoiHHjSG+VbGlnRRyI
 j5lalJRybHOtNPyJ1CD+l8vCiVbcu0jYNJ9Dtocx6lSgngr+pCgIeuf++rDzfxCX09fb
 jaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138545; x=1737743345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgXM2SJhYN6NrfYWSGvykVkJvg5WrjNv6ztMf07JhME=;
 b=F6CG6iSmcmCGXpLbXKTA0brLXkmCjtjh3ytPZ/FflB+soW9lzVafLr+EnHOl+DGVvc
 Oz7xVjpRdNqb3BwvRwIelLQ+3ttxsBE4c3dAopAqKMByNnvglmyu5tk9+s4bZ5fnibnQ
 9F387A+sPYtAWYEfxrQfY7SYCrJUcwfZ8RdoPguxlckHHfaVVt7unlR6+X3rbbwId8yu
 CZ9WYiwL233lL/6cxdan6i1b/UODeeAhJuZYpkrXDezG0G0Qpd5B1bLgbVPvuPx2F3Xg
 TyucSwLfmb05cybXUZFQ4WFhBoid4BpKzlEx37ND5ZV7MevvsemED6JTkCMgiSnafagp
 xtlQ==
X-Gm-Message-State: AOJu0Yx7AVLsII85vTIakKUqo04S0l5BqVsGAikLdzeJL1ZGPMxiqlrR
 GXhMLcCk4hg9xNyKGItC4+l2fHaSd6b8GmgmWbtc/fcOEqY8rpgQ3m5jNAhU6V9H0ysZ3XeP8HZ
 3
X-Gm-Gg: ASbGnct2Pi3emNzEaEoavdLmaYPgG6xESyQRjYU3oBzgx/ydhNmLtc06vYmlpNizvY6
 kGXfE77YLv7OvXTG3RSmVGGsP6Qf9dsxLvIqPrjAfaag/UiK00RP0JEOyXkZqL4yImhQpRqOxrK
 wEGQw9rWaUC9mGcTIx5R44VAP7y82iPBBoCIytEmaSTKSysCDG+l4Ig3f5ReCWjp8Oxxu89jlvL
 nPi5fBhsy1YXKNTkCutHVv+bd6Nw8SfXdPZeDtnCo1P18wjql0Ro3rwTP3QFkqwo8YCVScfD5GP
 ost072Stdv9FbxM=
X-Google-Smtp-Source: AGHT+IH/aZ5O1mZpe8U6Tb9MaG+GLCFYKj4mZa7NfTSZxAA1RycK5v20w9U1ZY1wBMcbH4zS156aWg==
X-Received: by 2002:a17:90b:258b:b0:2ee:f80c:688d with SMTP id
 98e67ed59e1d1-2f782d4f168mr4940731a91.25.1737138544890; 
 Fri, 17 Jan 2025 10:29:04 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 53/68] tcg/mips: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Fri, 17 Jan 2025 10:24:41 -0800
Message-ID: <20250117182456.2077110-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-has.h | 26 ++++++++++++++++++++++----
 tcg/mips/tcg-target.c.inc | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index d3d874ffd1..e7914cc970 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -80,8 +80,8 @@ extern bool use_mips32r2_instructions;
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
@@ -96,8 +96,8 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
@@ -119,4 +119,22 @@ extern bool use_mips32r2_instructions;
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
index b31b8f0007..99f6ef6c76 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2041,12 +2041,37 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2170,6 +2195,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ext8s_i32:
     case INDEX_op_ext16s_i32:
     case INDEX_op_extract_i32:
+    case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -2191,6 +2217,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
-- 
2.43.0


