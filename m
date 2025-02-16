Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFD2C021A9
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnqV-0001Un-IL; Sun, 16 Feb 2025 18:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnph-0000iu-Ns
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:55 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpc-0005PZ-4q
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:53 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-221050f3f00so23645105ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747626; x=1740352426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0dvB49gZPg1JMOit5Blp1JA1CJDHMwdjyo1coZXV6e0=;
 b=zCESsDElIX5YCGTFdKoWCRabKYfrQXRRslvLHbV7+mmy2pUCR9nsTO1C/EuOjlWYui
 JVtkbW0NHGXrYQrfVtOkldP2/HMPZKoDMFDZhVDyqnF8y6jsBybct7aCPJXY+7MUTbxS
 BrIEmOyMrNMxGV9G5G0yUbi1OEVqw2DcruIFDxQvVUuiopLvoaFNwrmAZeDLOIriHTYc
 u0HsEnVU2vuP68kldhvBiY4U8pHsBMkG/N3KhouDAVH9BGiZuGrxu3h/Ol5oV3WYnhqL
 TsevbqMlSQMboOwiFhmG6HKkoe/JnSKl3PbgIsjlrTl11qdCJXpT3H4sv6U6Ls1OXbRx
 0DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747626; x=1740352426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dvB49gZPg1JMOit5Blp1JA1CJDHMwdjyo1coZXV6e0=;
 b=Qa2QXr1fav+/Ngf5AqvP9OvOC2ObdbFqKD/xLRepybcWtZQkd2pqhZRIbHPh/zbPNh
 Tm5oJBLriNo5iVjvp+UJzZrvJmOoj+e451P7uaVyQsOmpifyGA+CxvgQmpfGf6bB5lI0
 8Pu4UtvwWZa8cv5hKQIVrZpTTRrbfzuYwnNHXwRH32JUFsdA7avpizGSo7i2joVgYQjN
 6FubPIrpwGVhtsGYtzcUXXfXU9mlqWMbbM6TaJb4aFRqBuCl1V1iVlIt/XH3U2HqHO4s
 KiYNthx0yRuP3/eVh4deXVpTIUTLFPq2NYX5GKwvu2BwLhELujkDyQmRfmm5tGbEFgaW
 rGlw==
X-Gm-Message-State: AOJu0Yw+U4ZxKcnkY7kgOcLOjA2TTZUdAJYXOisjFWE+g5j7Vc3Qc8aI
 QNnKppc04BYRQJDC2xjOpEHpJcw/BHiVIE6QuDLRnQpaWpqMbsNJxT1lovfrw0zwMcKi/F3DDIh
 U
X-Gm-Gg: ASbGncu8S1OQgCX6HRxDP79+/Fmx8tJ6qaJvUYo8mW1OdCKNHM7V9AtAakBlG6cIyWA
 eA4hfuSMqETeXGEJfAaY7qh/6WpI2ZRL6tp2B+vtGQhKBddurRbmdFylkOWqt6Z3LcVP8Mgr1sq
 mYUwFF5RoV9tb5mNvRK3LBdakVmrspKI+/bEQ6HOE6fJga0EHbAuc+gkbOhGZ8Mo9GJrQVCkh0E
 uZnuT6gfPD+f98Faj7HjvLfZRfOGyeSY7kwhrjsgxnbWnyQsLiQ20tXLR93nez8lz2oezlQgisz
 dfya1cPiFV5gB8weZtzH96iIUoxJk9y6Bt0kbsUK6fX2Pn8=
X-Google-Smtp-Source: AGHT+IEJLddTIjszngkwN3WEqLm5I3P2UgaJy5e7qF88IvbT/QG0YO+Uz7fi4yxuXRPKFqBY3ny7+w==
X-Received: by 2002:a17:903:41cb:b0:21f:768:cced with SMTP id
 d9443c01a7336-22103efeedemr74091735ad.8.1739747626484; 
 Sun, 16 Feb 2025 15:13:46 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 042/162] tcg: Convert divu to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:08:11 -0800
Message-ID: <20250216231012.2808572-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

For TCI, we're losing type information in the interpreter.
Introduce a tci-specific opcode to handle the difference.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h     |  2 --
 tcg/arm/tcg-target-has.h         |  1 -
 tcg/loongarch64/tcg-target-has.h |  2 --
 tcg/mips/tcg-target-has.h        |  2 --
 tcg/ppc/tcg-target-has.h         |  2 --
 tcg/riscv/tcg-target-has.h       |  2 --
 tcg/sparc64/tcg-target-has.h     |  2 --
 tcg/tcg-has.h                    | 15 ++++----
 tcg/tci/tcg-target-has.h         |  2 --
 tcg/tcg-op.c                     |  8 ++---
 tcg/tcg.c                        |  8 ++---
 tcg/tci.c                        |  3 +-
 tcg/aarch64/tcg-target.c.inc     | 18 ++++++----
 tcg/arm/tcg-target.c.inc         | 26 +++++++-------
 tcg/i386/tcg-target.c.inc        |  4 +++
 tcg/loongarch64/tcg-target.c.inc | 24 ++++++++-----
 tcg/mips/tcg-target.c.inc        | 37 ++++++++++---------
 tcg/ppc/tcg-target.c.inc         | 21 ++++++-----
 tcg/riscv/tcg-target.c.inc       | 21 ++++++-----
 tcg/s390x/tcg-target.c.inc       |  4 +++
 tcg/sparc64/tcg-target.c.inc     | 61 +++++++++++++++++---------------
 tcg/tci/tcg-target-opc.h.inc     |  1 +
 tcg/tci/tcg-target.c.inc         | 17 +++++++--
 23 files changed, 157 insertions(+), 126 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index bde6db8f2a..e961668ef0 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -13,7 +13,6 @@
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
@@ -30,7 +29,6 @@
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index ab9b7b6162..6ed2b49c84 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -34,7 +34,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_div_i32          use_idiv_instructions
 #define TCG_TARGET_HAS_rem_i32          0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index e29c892756..96a99b6d4c 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -11,7 +11,6 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_negsetcond_i32   0
-#define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          1
@@ -29,7 +28,6 @@
 
 /* 64-bit operations */
 #define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index ebaaa49cdd..9aa5bf9f1b 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -39,7 +39,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
@@ -51,7 +50,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index bbbd8de2c7..f8e4c0ad3c 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -17,7 +17,6 @@
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          have_isa_3_00
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
@@ -35,7 +34,6 @@
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          have_isa_3_00
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_bswap16_i64      1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index f7e1ef82fc..ae6624b9a4 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -11,7 +11,6 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
@@ -28,7 +27,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 5a517b6835..35f0dd4230 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,7 +14,6 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_div_i32		1
 #define TCG_TARGET_HAS_rem_i32		0
 #define TCG_TARGET_HAS_rot_i32          0
 #define TCG_TARGET_HAS_bswap16_i32      0
@@ -31,7 +30,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_rot_i64          0
 #define TCG_TARGET_HAS_bswap16_i64      0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 3d4c67698f..9680ccfc53 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -33,17 +33,16 @@
 #define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
-/* Only one of DIV or DIV2 should be defined.  */
-#if defined(TCG_TARGET_HAS_div_i32)
+#ifndef TCG_TARGET_HAS_div2_i32
 #define TCG_TARGET_HAS_div2_i32         0
-#elif defined(TCG_TARGET_HAS_div2_i32)
-#define TCG_TARGET_HAS_div_i32          0
+#endif
+#ifndef TCG_TARGET_HAS_div2_i64
+#define TCG_TARGET_HAS_div2_i64         0
+#endif
+#ifndef TCG_TARGET_HAS_rem_i32
 #define TCG_TARGET_HAS_rem_i32          0
 #endif
-#if defined(TCG_TARGET_HAS_div_i64)
-#define TCG_TARGET_HAS_div2_i64         0
-#elif defined(TCG_TARGET_HAS_div2_i64)
-#define TCG_TARGET_HAS_div_i64          0
+#ifndef TCG_TARGET_HAS_rem_i64
 #define TCG_TARGET_HAS_rem_i64          0
 #endif
 
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 0627585097..ccec96b610 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -9,7 +9,6 @@
 
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_clz_i32          1
@@ -26,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9dba520d40..19be461214 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -635,7 +635,7 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_div_i32) {
+    if (tcg_op_supported(INDEX_op_divu_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_divu_i32, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i32) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -651,7 +651,7 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rem_i32) {
         tcg_gen_op3_i32(INDEX_op_remu_i32, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div_i32) {
+    } else if (tcg_op_supported(INDEX_op_divu_i32, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_divu_i32, t0, arg1, arg2);
         tcg_gen_mul_i32(t0, t0, arg2);
@@ -2003,7 +2003,7 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_div_i64) {
+    if (tcg_op_supported(INDEX_op_divu_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_divu_i64, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i64) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -2019,7 +2019,7 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_rem_i64) {
         tcg_gen_op3_i64(INDEX_op_remu_i64, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div_i64) {
+    } else if (tcg_op_supported(INDEX_op_divu_i64, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_divu_i64, t0, arg1, arg2);
         tcg_gen_mul_i64(t0, t0, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c16fb82a5c..2f8b99c428 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1021,6 +1021,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
+    OUTOP(INDEX_op_divu_i32, TCGOutOpBinary, outop_divu),
+    OUTOP(INDEX_op_divu_i64, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -2261,8 +2263,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_negsetcond_i32:
         return TCG_TARGET_HAS_negsetcond_i32;
-    case INDEX_op_divu_i32:
-        return TCG_TARGET_HAS_div_i32;
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
         return TCG_TARGET_HAS_rem_i32;
@@ -2323,8 +2323,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_negsetcond_i64:
         return TCG_TARGET_HAS_negsetcond_i64;
-    case INDEX_op_divu_i64:
-        return TCG_TARGET_HAS_div_i64;
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
         return TCG_TARGET_HAS_rem_i64;
@@ -5411,6 +5409,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_divs:
+    case INDEX_op_divu_i32:
+    case INDEX_op_divu_i64:
     case INDEX_op_eqv:
     case INDEX_op_mul:
     case INDEX_op_mulsh:
diff --git a/tcg/tci.c b/tcg/tci.c
index 4b3ca53bc5..0691824f97 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -582,7 +582,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int32_t)regs[r1] / (int32_t)regs[r2];
             break;
-        case INDEX_op_divu_i32:
+        case INDEX_op_tci_divu32:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint32_t)regs[r1] / (uint32_t)regs[r2];
             break;
@@ -1101,6 +1101,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
     case INDEX_op_tci_divs32:
+    case INDEX_op_tci_divu32:
         tci_args_rrr(insn, &r0, &r1, &r2);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
                            op_name, str_r(r0), str_r(r1), str_r(r2));
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 52069f1445..167c51c897 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2168,6 +2168,17 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static void tgen_divu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3508, UDIV, type, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divu,
+};
+
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2373,11 +2384,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_divu_i64:
-    case INDEX_op_divu_i32:
-        tcg_out_insn(s, 3508, UDIV, ext, a0, a1, a2);
-        break;
-
     case INDEX_op_rem_i64:
     case INDEX_op_rem_i32:
         tcg_out_insn(s, 3508, SDIV, ext, TCG_REG_TMP0, a1, a2);
@@ -3064,8 +3070,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
     case INDEX_op_rem_i32:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 025d32dee6..c860df6045 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -943,12 +943,6 @@ static void tcg_out_smull32(TCGContext *s, ARMCond cond, TCGReg rd0,
               (rd1 << 16) | (rd0 << 12) | (rm << 8) | rn);
 }
 
-static void tcg_out_udiv(TCGContext *s, ARMCond cond,
-                         TCGReg rd, TCGReg rn, TCGReg rm)
-{
-    tcg_out32(s, 0x0730f010 | (cond << 28) | (rd << 16) | rn | (rm << 8));
-}
-
 static void tcg_out_ext8s(TCGContext *s, TCGType t, TCGReg rd, TCGReg rn)
 {
     /* sxtb */
@@ -1892,6 +1886,19 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static void tgen_divu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    /* udiv */
+    tcg_out32(s, 0x0730f010 | (COND_AL << 28) | (a0 << 16) | a1 | (a2 << 8));
+}
+
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_idiv,
+    .out_rrr = tgen_divu,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2236,10 +2243,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_divu_i32:
-        tcg_out_udiv(s, COND_AL, args[0], args[1], args[2]);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, args[0]);
         break;
@@ -2283,9 +2286,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ctz_i32:
         return C_O1_I2(r, r, rIK);
 
-    case INDEX_op_divu_i32:
-        return C_O1_I2(r, r, r);
-
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index ebd074d0b3..0ed0626871 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2637,6 +2637,10 @@ static const TCGOutOpBinary outop_divs = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 3970dcabbc..8adcd030c5 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1331,6 +1331,21 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static void tgen_divu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_div_wu(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_div_du(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divu,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -1674,13 +1689,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_divu_i32:
-        tcg_out_opc_div_wu(s, a0, a1, a2);
-        break;
-    case INDEX_op_divu_i64:
-        tcg_out_opc_div_du(s, a0, a1, a2);
-        break;
-
     case INDEX_op_rem_i32:
         tcg_out_opc_mod_w(s, a0, a1, a2);
         break;
@@ -2359,8 +2367,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rz, rJ);
 
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
     case INDEX_op_rem_i32:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 9c1fc86f5a..5bbb4d037e 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1733,6 +1733,27 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static void tgen_divu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (use_mips32r6_instructions) {
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_reg(s, OPC_DIVU_R6, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_DDIVU_R6, a0, a1, a2);
+        }
+    } else {
+        MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_DIVU : OPC_DDIVU;
+        tcg_out_opc_reg(s, insn, 0, a1, a2);
+        tcg_out_opc_reg(s, OPC_MFLO, a0, 0, 0);
+    }
+}
+
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divu,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -1966,13 +1987,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_divu_i32:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DIVU_R6, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DIVU, i2 = OPC_MFLO;
-        goto do_hilo1;
     case INDEX_op_rem_i32:
         if (use_mips32r6_instructions) {
             tcg_out_opc_reg(s, OPC_MOD, a0, a1, a2);
@@ -1987,13 +2001,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         i1 = OPC_DIVU, i2 = OPC_MFHI;
         goto do_hilo1;
-    case INDEX_op_divu_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DDIVU_R6, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DDIVU, i2 = OPC_MFLO;
-        goto do_hilo1;
     case INDEX_op_rem_i64:
         if (use_mips32r6_instructions) {
             tcg_out_opc_reg(s, OPC_DMOD, a0, a1, a2);
@@ -2266,11 +2273,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
     case INDEX_op_setcond_i32:
-    case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
     case INDEX_op_setcond_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 9fdf8df082..b347595131 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2972,6 +2972,18 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static void tgen_divu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? DIVWU : DIVDU;
+    tcg_out32(s, insn | TAB(a0, a1, a2));
+}
+
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divu,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_O1_I2(r, r, r),
     .out_rrr = tgen_eqv,
@@ -3221,10 +3233,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
         break;
 
-    case INDEX_op_divu_i32:
-        tcg_out32(s, DIVWU | TAB(args[0], args[1], args[2]));
-        break;
-
     case INDEX_op_rem_i32:
         tcg_out32(s, MODSW | TAB(args[0], args[1], args[2]));
         break;
@@ -3325,9 +3333,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_divu_i64:
-        tcg_out32(s, DIVDU | TAB(args[0], args[1], args[2]));
-        break;
     case INDEX_op_rem_i64:
         tcg_out32(s, MODSD | TAB(args[0], args[1], args[2]));
         break;
@@ -4189,10 +4194,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
         return C_O1_I2(r, r, r);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 15925729dc..74fa38d273 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2009,6 +2009,18 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static void tgen_divu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_DIVUW : OPC_DIVU;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divu,
+};
+
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2213,13 +2225,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_divu_i32:
-        tcg_out_opc_reg(s, OPC_DIVUW, a0, a1, a2);
-        break;
-    case INDEX_op_divu_i64:
-        tcg_out_opc_reg(s, OPC_DIVU, a0, a1, a2);
-        break;
-
     case INDEX_op_rem_i32:
         tcg_out_opc_reg(s, OPC_REMW, a0, a1, a2);
         break;
@@ -2735,10 +2740,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
         return C_O1_I2(r, rz, rz);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fd0e717c49..f55309f48e 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2246,6 +2246,10 @@ static const TCGOutOpBinary outop_divs = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_eqv(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 779d0ce882..3a3372d7aa 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -596,21 +596,6 @@ static void tcg_out_sety(TCGContext *s, TCGReg rs)
     tcg_out32(s, WRY | INSN_RS1(TCG_REG_G0) | INSN_RS2(rs));
 }
 
-static void tcg_out_div32(TCGContext *s, TCGReg rd, TCGReg rs1,
-                          int32_t val2, int val2const, int uns)
-{
-    /* Load Y with the sign/zero extension of RS1 to 64-bits.  */
-    if (uns) {
-        tcg_out_sety(s, TCG_REG_G0);
-    } else {
-        tcg_out_arithi(s, TCG_REG_T1, rs1, 31, SHIFT_SRA);
-        tcg_out_sety(s, TCG_REG_T1);
-    }
-
-    tcg_out_arithc(s, rd, rs1, val2, val2const,
-                   uns ? ARITH_UDIV : ARITH_SDIV);
-}
-
 static const uint8_t tcg_cond_to_bcond[16] = {
     [TCG_COND_EQ] = COND_E,
     [TCG_COND_NE] = COND_NE,
@@ -1367,6 +1352,39 @@ static const TCGOutOpBinary outop_divs = {
     .out_rri = tgen_divsi,
 };
 
+static void tgen_divu_rJ(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, TCGArg a2, bool c2)
+{
+    uint32_t insn;
+
+    if (type == TCG_TYPE_I32) {
+        /* Load Y with the zero extension to 64-bits.  */
+        tcg_out_sety(s, TCG_REG_G0);
+        insn = ARITH_UDIV;
+    } else {
+        insn = ARITH_UDIVX;
+    }
+    tcg_out_arithc(s, a0, a1, a2, c2, insn);
+}
+
+static void tgen_divu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tgen_divu_rJ(s, type, a0, a1, a2, false);
+}
+
+static void tgen_divui(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_divu_rJ(s, type, a0, a1, a2, true);
+}
+
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_divu,
+    .out_rri = tgen_divui,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -1566,10 +1584,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         c = SHIFT_SRA;
         goto do_shift32;
 
-    case INDEX_op_divu_i32:
-        tcg_out_div32(s, a0, a1, a2, c2, 1);
-        break;
-
     case INDEX_op_brcond_i32:
         tcg_out_brcond_i32(s, a2, a0, a1, const_args[1], arg_label(args[3]));
         break;
@@ -1638,9 +1652,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_sar_i64:
         c = SHIFT_SRAX;
         goto do_shift64;
-    case INDEX_op_divu_i64:
-        c = ARITH_UDIVX;
-        goto gen_arith;
 
     case INDEX_op_brcond_i64:
         tcg_out_brcond_i64(s, a2, a0, a1, const_args[1], arg_label(args[3]));
@@ -1663,10 +1674,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             const_args[4], args[5], const_args[5], true);
         break;
 
-    gen_arith:
-        tcg_out_arithc(s, a0, a1, a2, c2, c);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -1728,8 +1735,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index f503374643..43c07a269f 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -3,3 +3,4 @@
 DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4a556e2ce7..18a10156a6 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -79,8 +79,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
     case INDEX_op_rem_i32:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
@@ -660,6 +658,20 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static void tgen_divu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_divu32
+                     : INDEX_op_divu_i64);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divu,
+};
+
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -823,7 +835,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     CASE_32_64(sar)
     CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
-    CASE_32_64(divu)     /* Optional (TCG_TARGET_HAS_div_*). */
     CASE_32_64(rem)      /* Optional (TCG_TARGET_HAS_div_*). */
     CASE_32_64(remu)     /* Optional (TCG_TARGET_HAS_div_*). */
     CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
-- 
2.43.0


