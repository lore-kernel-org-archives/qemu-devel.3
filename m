Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58C7E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfP-0003Sm-Ma; Thu, 02 Jan 2025 13:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeq-0007iR-5w
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:56 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPem-0006IH-6H
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:55 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21a1e6fd923so115915445ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841451; x=1736446251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jjfv3C93PauG+JuyFdDxBM96RLNbK0xH2DLm7pawTgE=;
 b=RMC/WhXtN3aGKgQ0Mh1AypSTxgu0W0fegcuCTWcswFtgRx4z5R6aydlz3vE89LwlQ1
 L3OcE++4yUxpLEr8AK+iwN70fYhIkzjVG2mdMM/s2DlcHQtbhonM8EVAPhhxPsM0bqW+
 LbCRpDJey/G81Z9OXvmZrj7JN4hfUqeE86iJQL0ICaS9QuGKLypH9vYlKW4uUPjoD31r
 qI4ad9V1w19ih+Qsn49433z/8s54SKBKwfzCXb/iDOpE+Jd+8jJ9Dl/fXOFp5oncjX2v
 efBagZhi0l1WAmesBoKV3vrXFi16Wa/O8H2Irda+S7+yPX+NWWXr6RagCyUbNZFmhuvg
 tMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841451; x=1736446251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jjfv3C93PauG+JuyFdDxBM96RLNbK0xH2DLm7pawTgE=;
 b=t4Ozw2c/Nxdg1VeSnGoQuFOMw0uudE2vHd1ReW9vga15eEAT18N+kIck5g0KXsZkgV
 Nelutqo8JN7WFVg1fXJ54XSbU0FRkneSODkuMuY5C1/19rGxdpbnDQ5YeS39BGhxf2co
 eI7r6R35jaQbccNxWwUwmZau+bZ3/JSAvIFTfLjge7xoycfcCylj29WwP+8ygUqDG+8j
 KXbvqCtbJ9J+cDPIZbRCxM4xQW+5oGJEATrIr4dsGxAJPSoDN/bdo6B7XUB6BuJvKgUx
 0PhW0gULdEHS/qzLkUBtDhu0OVPHt7YwldWzGLi97TSZhXmzx6gCYndc0QMbckSS9PZ+
 qGJg==
X-Gm-Message-State: AOJu0Yyu/06SwMgfIA2+5kT+/ZiH4JIdg0WRZaKP8fd3rpBmonr266UZ
 cOuk3CqgZRcDnxFqDJydUZ5jLxhSsoLIPqSYn2QVts2bT/8GoWNgbVSgzoViht9KsgfEpMcfsEF
 O
X-Gm-Gg: ASbGncvKoSl0qYB8RZYCYCf2G6g93GifGEdfbB6ycyFgfObkfXY8xQ+1kyLKtwgma+6
 0o/9vgGUvpG7XDHsXVP50KftUUn8RE2m1u/dBWCq/2oHCg0gtHJK0E5GCHiFxBpzlaTZ8Pmjyiy
 XvgJGJ1Q+GegiX9jXhk91uUH6Ln3/9tTDgeTRmTOXkwrCC5iuHgLTUFpKYvIhGv+cZ6Qx7UATuR
 CF3uvFBzMNipOsMlZ52rBUTuMfS+g47XYQQu41xsJ40sarDcCCBDoHgxj4rvw==
X-Google-Smtp-Source: AGHT+IGXZI9JnoefFXSoXEEcROaHYgYRNVFJL3qubrxvLRESpsLTFdpX6fpFzGOgUJAokCqO7mXBPA==
X-Received: by 2002:a05:6a00:4c07:b0:72a:9ddf:55ab with SMTP id
 d2e1a72fcca58-72abdd9c06dmr68235916b3a.10.1735841450801; 
 Thu, 02 Jan 2025 10:10:50 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 71/73] tcg: Merge host integer load/store operations
Date: Thu,  2 Jan 2025 10:06:51 -0800
Message-ID: <20250102180654.1420056-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            | 12 ++++------
 tcg/optimize.c                   |  6 ++---
 tcg/tcg-op.c                     | 38 ++++++++++++++++----------------
 tcg/tcg.c                        | 29 ++++++------------------
 tcg/tci.c                        | 16 +++++++-------
 tcg/aarch64/tcg-target.c.inc     | 12 ++++------
 tcg/arm/tcg-target.c.inc         |  8 +++----
 tcg/i386/tcg-target.c.inc        | 10 ++++-----
 tcg/loongarch64/tcg-target.c.inc | 14 +++++-------
 tcg/mips/tcg-target.c.inc        | 14 +++++-------
 tcg/ppc/tcg-target.c.inc         | 12 ++++------
 tcg/riscv/tcg-target.c.inc       | 14 +++++-------
 tcg/s390x/tcg-target.c.inc       | 11 ++++-----
 tcg/sparc64/tcg-target.c.inc     | 14 ++++--------
 tcg/tci/tcg-target-opc.h.inc     |  2 ++
 tcg/tci/tcg-target.c.inc         | 26 ++++++++++------------
 16 files changed, 93 insertions(+), 145 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c9069525a1..badc587af9 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -79,10 +79,6 @@ DEF(setcond, 1, 2, 1, TCG_OPF_INT)
 DEF(negsetcond, 1, 2, 1, TCG_OPF_INT)
 DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 
-/* load/store */
-DEF(ld_i32, 1, 1, 2, 0)
-DEF(st_i32, 0, 2, 2, 0)
-
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
@@ -92,10 +88,6 @@ DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
 
-/* load/store */
-DEF(ld_i64, 1, 1, 2, 0)
-DEF(st_i64, 0, 2, 2, 0)
-
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, 0)
 DEF(extu_i32_i64, 1, 1, 0, 0)
@@ -109,6 +101,10 @@ DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
 
+/* host load/store */
+DEF(ld, 1, 1, 2, TCG_OPF_INT)
+DEF(st, 0, 2, 2, TCG_OPF_INT)
+
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
 /* There are tcg_ctx->insn_start_words here, not just one. */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 82606a00f5..e29fa9b940 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2777,13 +2777,11 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_extrh_i64_i32:
             done = fold_extu(&ctx, op);
             break;
-        case INDEX_op_ld_i32:
-        case INDEX_op_ld_i64:
+        case INDEX_op_ld:
         case INDEX_op_ld_vec:
             done = fold_tcg_ld(&ctx, op);
             break;
-        case INDEX_op_st_i32:
-        case INDEX_op_st_i64:
+        case INDEX_op_st:
         case INDEX_op_st_vec:
             done = fold_tcg_st(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f3f758b15b..34b97754a6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1352,42 +1352,42 @@ void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset, MO_UB);
+    tcg_gen_ldst_op_i32(INDEX_op_ld, ret, arg2, offset, MO_UB);
 }
 
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset, MO_SB);
+    tcg_gen_ldst_op_i32(INDEX_op_ld, ret, arg2, offset, MO_SB);
 }
 
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset, MO_UW);
+    tcg_gen_ldst_op_i32(INDEX_op_ld, ret, arg2, offset, MO_UW);
 }
 
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset, MO_SW);
+    tcg_gen_ldst_op_i32(INDEX_op_ld, ret, arg2, offset, MO_SW);
 }
 
 void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset, MO_32);
+    tcg_gen_ldst_op_i32(INDEX_op_ld, ret, arg2, offset, MO_32);
 }
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_st_i32, arg1, arg2, offset, MO_8);
+    tcg_gen_ldst_op_i32(INDEX_op_st, arg1, arg2, offset, MO_8);
 }
 
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_st_i32, arg1, arg2, offset, MO_16);
+    tcg_gen_ldst_op_i32(INDEX_op_st, arg1, arg2, offset, MO_16);
 }
 
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_st_i32, arg1, arg2, offset, MO_32);
+    tcg_gen_ldst_op_i32(INDEX_op_st, arg1, arg2, offset, MO_32);
 }
 
 
@@ -1436,7 +1436,7 @@ void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_UB);
+        tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset, MO_UB);
     } else {
         tcg_gen_ld8u_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
@@ -1446,7 +1446,7 @@ void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_SB);
+        tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset, MO_SB);
     } else {
         tcg_gen_ld8s_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
@@ -1456,7 +1456,7 @@ void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_UW);
+        tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset, MO_UW);
     } else {
         tcg_gen_ld16u_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
@@ -1466,7 +1466,7 @@ void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_SW);
+        tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset, MO_SW);
     } else {
         tcg_gen_ld16s_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
@@ -1476,7 +1476,7 @@ void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_UL);
+        tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset, MO_UL);
     } else {
         tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
@@ -1486,7 +1486,7 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_SL);
+        tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset, MO_SL);
     } else {
         tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
@@ -1500,7 +1500,7 @@ void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
      * they cannot be the same temporary -- no chance of overlap.
      */
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_64);
+        tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset, MO_64);
     } else if (HOST_BIG_ENDIAN) {
         tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset);
         tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset + 4);
@@ -1513,7 +1513,7 @@ void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset, MO_8);
+        tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset, MO_8);
     } else {
         tcg_gen_st8_i32(TCGV_LOW(arg1), arg2, offset);
     }
@@ -1522,7 +1522,7 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset, MO_16);
+        tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset, MO_16);
     } else {
         tcg_gen_st16_i32(TCGV_LOW(arg1), arg2, offset);
     }
@@ -1531,7 +1531,7 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset, MO_32);
+        tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset, MO_32);
     } else {
         tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
     }
@@ -1540,7 +1540,7 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset, MO_64);
+        tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset, MO_64);
     } else if (HOST_BIG_ENDIAN) {
         tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset);
         tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset + 4);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e8377a9bbe..d3ed9d7be4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2194,6 +2194,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_brcond:
     case INDEX_op_deposit:
     case INDEX_op_extract:
+    case INDEX_op_ld:
     case INDEX_op_mov:
     case INDEX_op_movcond:
     case INDEX_op_mul:
@@ -2204,14 +2205,11 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sextract:
     case INDEX_op_shl:
     case INDEX_op_shr:
+    case INDEX_op_st:
     case INDEX_op_sub:
     case INDEX_op_xor:
         return has_type;
 
-    case INDEX_op_ld_i32:
-    case INDEX_op_st_i32:
-        return true;
-
     case INDEX_op_add2:
         return has_type && TCG_TARGET_HAS_add2(type);
     case INDEX_op_andc:
@@ -2263,8 +2261,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_ctpop_i32:
         return TCG_TARGET_HAS_ctpop(TCG_TYPE_I32);
 
-    case INDEX_op_ld_i64:
-    case INDEX_op_st_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
@@ -2833,10 +2829,8 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                     i = 1;
                 }
                 break;
-            case INDEX_op_ld_i32:
-            case INDEX_op_ld_i64:
-            case INDEX_op_st_i32:
-            case INDEX_op_st_i64:
+            case INDEX_op_ld:
+            case INDEX_op_st:
                 {
                     tcg_target_long ofs = op->args[k++];
                     MemOp mop = op->args[k++];
@@ -4151,10 +4145,7 @@ liveness_pass_2(TCGContext *s)
             arg_ts = arg_temp(op->args[i]);
             dir_ts = arg_ts->state_ptr;
             if (dir_ts && arg_ts->state == TS_DEAD) {
-                TCGOpcode lopc = (arg_ts->type == TCG_TYPE_I32
-                                  ? INDEX_op_ld_i32
-                                  : INDEX_op_ld_i64);
-                TCGOp *lop = tcg_op_insert_before(s, op, lopc,
+                TCGOp *lop = tcg_op_insert_before(s, op, INDEX_op_ld,
                                                   arg_ts->type, 4);
 
                 lop->args[0] = temp_arg(dir_ts);
@@ -4216,10 +4207,7 @@ liveness_pass_2(TCGContext *s)
                 arg_ts->state = 0;
 
                 if (NEED_SYNC_ARG(0)) {
-                    TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
-                                      ? INDEX_op_st_i32
-                                      : INDEX_op_st_i64);
-                    TCGOp *sop = tcg_op_insert_after(s, op, sopc,
+                    TCGOp *sop = tcg_op_insert_after(s, op, INDEX_op_st,
                                                      arg_ts->type, 4);
                     TCGTemp *out_ts = dir_ts;
 
@@ -4254,10 +4242,7 @@ liveness_pass_2(TCGContext *s)
 
                 /* Sync outputs upon their last write.  */
                 if (NEED_SYNC_ARG(i)) {
-                    TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
-                                      ? INDEX_op_st_i32
-                                      : INDEX_op_st_i64);
-                    TCGOp *sop = tcg_op_insert_after(s, op, sopc,
+                    TCGOp *sop = tcg_op_insert_after(s, op, INDEX_op_st,
                                                      arg_ts->type, 4);
 
                     sop->args[0] = temp_arg(dir_ts);
diff --git a/tcg/tci.c b/tcg/tci.c
index 9cc983ca1a..14d4b3808c 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -512,7 +512,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(int16_t *)ptr;
             break;
-        case INDEX_op_ld_i32:
+        case INDEX_op_tci_ld32u:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(uint32_t *)ptr;
@@ -527,7 +527,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             ptr = (void *)(regs[r1] + ofs);
             *(uint16_t *)ptr = regs[r0];
             break;
-        case INDEX_op_st_i32:
+        case INDEX_op_tci_st32:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             *(uint32_t *)ptr = regs[r0];
@@ -733,12 +733,12 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(int32_t *)ptr;
             break;
-        case INDEX_op_ld_i64:
+        case INDEX_op_ld:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(uint64_t *)ptr;
             break;
-        case INDEX_op_st_i64:
+        case INDEX_op_st:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             *(uint64_t *)ptr = regs[r0];
@@ -1008,13 +1008,13 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_tci_ld8s:
     case INDEX_op_tci_ld16u:
     case INDEX_op_tci_ld16s:
+    case INDEX_op_tci_ld32u:
     case INDEX_op_tci_ld32s:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
     case INDEX_op_tci_st8:
     case INDEX_op_tci_st16:
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_tci_st32:
+    case INDEX_op_st:
         tci_args_rrs(insn, &r0, &r1, &s2);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %d",
                            op_name, str_r(r0), str_r(r1), s2);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index d982ac38a1..404c5a5c15 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2138,8 +2138,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_goto_label(s, arg_label(a0));
         break;
 
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
         switch (args[3]) {
         case MO_UB:
             tcg_out_ldst(s, I3312_LDRB, a0, a1, a2, 0);
@@ -2175,8 +2174,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         switch (args[3]) {
         case MO_8:
             tcg_out_ldst(s, I3312_STRB, REG0(0), a1, a2, 0);
@@ -2912,8 +2910,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
     case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_bswap16_i32:
@@ -2929,8 +2926,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sextract:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         return C_O0_I2(rZ, r);
 
     case INDEX_op_add:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index ef33cf0ac7..890fd84068 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1862,7 +1862,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_goto_label(s, COND_AL, arg_label(args[0]));
         break;
 
-    case INDEX_op_ld_i32:
+    case INDEX_op_ld:
         switch (args[3]) {
         case MO_UB:
             tcg_out_ld8u(s, COND_AL, args[0], args[1], args[2]);
@@ -1884,7 +1884,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_st_i32:
+    case INDEX_op_st:
         switch (args[3]) {
         case MO_8:
             tcg_out_st8(s, COND_AL, args[0], args[1], args[2]);
@@ -2181,7 +2181,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld_i32:
+    case INDEX_op_ld:
     case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_bswap16_i32:
@@ -2190,7 +2190,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sextract:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st_i32:
+    case INDEX_op_st:
         return C_O0_I2(r, r);
 
     case INDEX_op_add:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 61acf23708..b346f73ea3 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2660,7 +2660,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_jxx(s, JCC_JMP, arg_label(a0), 0);
         break;
 
-    OP_32_64(ld):
+    case INDEX_op_ld:
         switch (args[3]) {
         case MO_UB:
             /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
@@ -2692,7 +2692,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(st):
+    case INDEX_op_st:
         switch (args[3]) {
         case MO_8:
             if (const_args[0]) {
@@ -3663,12 +3663,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         switch (op->args[3]) {
         case MO_8:
             return C_O0_I2(qi, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 563299381a..237cfd634b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1615,8 +1615,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_movcond(s, args[5], a0, a1, a2, c2, args[3], args[4]);
         break;
 
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
         switch (args[3]) {
         case MO_SB:
             tcg_out_ldst(s, OPC_LD_B, a0, a1, a2);
@@ -1631,7 +1630,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out_ldst(s, OPC_LD_HU, a0, a1, a2);
             break;
         case MO_UL:
-            if (opc == INDEX_op_ld_i64) {
+            if (type != TCG_TYPE_I32) {
                 tcg_out_ldst(s, OPC_LD_WU, a0, a1, a2);
                 break;
             }
@@ -1647,8 +1646,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         switch (args[3]) {
         case MO_8:
             tcg_out_ldst(s, OPC_ST_B, a0, a1, a2);
@@ -2206,8 +2204,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
     case INDEX_op_qemu_st_a32_i32:
     case INDEX_op_qemu_st_a64_i32:
     case INDEX_op_qemu_st_a32_i64:
@@ -2238,8 +2235,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
     case INDEX_op_qemu_ld_a32_i64:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index d74bcdb96f..541e68e9bf 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1710,8 +1710,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        arg_label(a0));
         break;
 
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
         switch (args[3]) {
         case MO_UB:
             i1 = OPC_LBU;
@@ -1726,7 +1725,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             i1 = OPC_LH;
             goto do_ldst;
         case MO_UL:
-            if (opc == INDEX_op_ld_i64) {
+            if (type != TCG_TYPE_I32) {
                 i1 = OPC_LWU;
                 goto do_ldst;
             }
@@ -1740,8 +1739,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         g_assert_not_reached();
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         switch (args[3]) {
         case MO_8:
             i1 = OPC_SB;
@@ -2144,14 +2142,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld_i32:
+    case INDEX_op_ld:
     case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract:
     case INDEX_op_sextract:
-    case INDEX_op_ld_i64:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
@@ -2161,8 +2158,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         return C_O0_I2(rZ, r);
 
     case INDEX_op_add:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index c501b1a205..96a492cbe2 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2967,8 +2967,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
         switch (args[3]) {
         case MO_UB:
         case MO_SB:
@@ -2997,8 +2996,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         switch (args[3]) {
         case MO_8:
             tcg_out_mem_long(s, STB, STBX, args[0], args[1], args[2]);
@@ -4088,7 +4086,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld_i32:
+    case INDEX_op_ld:
     case INDEX_op_ctpop_i32:
     case INDEX_op_neg:
     case INDEX_op_not:
@@ -4096,7 +4094,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract:
     case INDEX_op_sextract:
-    case INDEX_op_ld_i64:
     case INDEX_op_ctpop_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
@@ -4107,8 +4104,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap64_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         return C_O0_I2(r, r);
 
     case INDEX_op_or:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 0606dc204e..5135af5473 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1980,8 +1980,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, 0);
         break;
 
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
         switch (args[3]) {
         case MO_UB:
             tcg_out_ldst(s, OPC_LBU, a0, a1, a2);
@@ -1996,7 +1995,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out_ldst(s, OPC_LH, a0, a1, a2);
             break;
         case MO_UL:
-            if (opc == INDEX_op_ld_i64) {
+            if (type != TCG_TYPE_I32) {
                 tcg_out_ldst(s, OPC_LWU, a0, a1, a2);
                 break;
             }
@@ -2012,8 +2011,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         switch (args[3]) {
         case MO_8:
             tcg_out_ldst(s, OPC_SB, a0, a1, a2);
@@ -2587,10 +2585,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld_i32:
+    case INDEX_op_ld:
     case INDEX_op_not:
     case INDEX_op_neg:
-    case INDEX_op_ld_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
@@ -2606,8 +2603,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         return C_O0_I2(rZ, r);
 
     case INDEX_op_add:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 3ee364b27f..edf7c0e92c 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2196,7 +2196,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, a0);
         break;
 
-    OP_32_64(ld):
+    case INDEX_op_ld:
         switch (args[3]) {
         case MO_UB:
             tcg_out_mem(s, 0, RXY_LLGC,
@@ -2230,7 +2230,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(st):
+    case INDEX_op_st:
         switch (args[3]) {
         case MO_8:
             tcg_out_mem(s, RX_STC, RXY_STCY, args[0], args[1],
@@ -3154,12 +3154,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
         return C_O1_I1(r, r);
-
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         return C_O0_I2(r, r);
 
     case INDEX_op_add:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 20911e46be..0b503b3b41 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1311,11 +1311,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_nop(s);
         break;
 
-#define OP_32_64(x)                             \
-        glue(glue(case INDEX_op_, x), _i32):    \
-        glue(glue(case INDEX_op_, x), _i64)
-
-    OP_32_64(ld):
+    case INDEX_op_ld:
         switch (args[3]) {
         case MO_UB:
             tcg_out_ldst(s, a0, a1, a2, LDUB);
@@ -1343,7 +1339,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(st):
+    case INDEX_op_st:
         switch (args[3]) {
         case MO_8:
             tcg_out_ldst(s, a0, a1, a2, STB);
@@ -1569,8 +1565,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
     case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
@@ -1585,8 +1580,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_qemu_ld_a64_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
     case INDEX_op_qemu_st_a32_i32:
     case INDEX_op_qemu_st_a64_i32:
     case INDEX_op_qemu_st_a32_i64:
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 8544654db8..7308fab920 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -6,8 +6,10 @@ DEF(tci_ld8u, 1, 1, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_ld8s, 1, 1, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_ld16u, 1, 1, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_ld16s, 1, 1, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_ld32u, 1, 1, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_ld32s, 1, 1, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_st8, 1, 1, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_st16, 1, 1, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_st32, 1, 1, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movcond32, 1, 4, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 3a3fef8679..472c6ea87f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -42,8 +42,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld_i64:
+    case INDEX_op_ld:
     case INDEX_op_not:
     case INDEX_op_neg:
     case INDEX_op_ext_i32_i64:
@@ -61,8 +60,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st:
         return C_O0_I2(r, r);
 
     case INDEX_op_div:
@@ -443,11 +441,11 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
 {
     switch (type) {
     case TCG_TYPE_I32:
-        tcg_out_ldst(s, INDEX_op_ld_i32, val, base, offset);
+        tcg_out_ldst(s, INDEX_op_tci_ld32u, val, base, offset);
         break;
 #if TCG_TARGET_REG_BITS == 64
     case TCG_TYPE_I64:
-        tcg_out_ldst(s, INDEX_op_ld_i64, val, base, offset);
+        tcg_out_ldst(s, INDEX_op_ld, val, base, offset);
         break;
 #endif
     default:
@@ -659,7 +657,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, arg_label(args[5]));
         break;
 
-    CASE_32_64(ld)
+    case INDEX_op_ld:
         switch (args[3]) {
         case MO_UB:
             opc = INDEX_op_tci_ld8u;
@@ -674,13 +672,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             opc = INDEX_op_tci_ld16s;
             break;
         case MO_UL:
-            opc = INDEX_op_ld_i32;
+            opc = INDEX_op_tci_ld32u;
             break;
         case MO_SL:
             opc = INDEX_op_tci_ld32s;
             break;
         case MO_UQ:
-            opc = INDEX_op_ld_i64;
+            opc = INDEX_op_ld;
             break;
         default:
             g_assert_not_reached();
@@ -688,7 +686,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(st)
+    case INDEX_op_st:
         switch (args[3]) {
         case MO_8:
             opc = INDEX_op_tci_st8;
@@ -697,10 +695,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             opc = INDEX_op_tci_st16;
             break;
         case MO_32:
-            opc = INDEX_op_st_i32;
+            opc = INDEX_op_tci_st32;
             break;
         case MO_64:
-            opc = INDEX_op_st_i64;
+            opc = INDEX_op_st;
             break;
         default:
             g_assert_not_reached();
@@ -842,11 +840,11 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
 {
     switch (type) {
     case TCG_TYPE_I32:
-        tcg_out_ldst(s, INDEX_op_st_i32, val, base, offset);
+        tcg_out_ldst(s, INDEX_op_tci_st32, val, base, offset);
         break;
 #if TCG_TARGET_REG_BITS == 64
     case TCG_TYPE_I64:
-        tcg_out_ldst(s, INDEX_op_st_i64, val, base, offset);
+        tcg_out_ldst(s, INDEX_op_st, val, base, offset);
         break;
 #endif
     default:
-- 
2.43.0


