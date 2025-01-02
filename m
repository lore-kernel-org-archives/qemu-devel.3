Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69DEE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPep-0007bI-AY; Thu, 02 Jan 2025 13:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeV-0007IG-68
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:39 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeT-0006DR-06
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:34 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so198425625ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841432; x=1736446232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G24xlquUfYqewIowIQONxQx0BqdSAy070cOUjLKrwBQ=;
 b=zcNnAtdMy5KBDlnXHSPMUZoAUQwtzNCpvc7cKdDafZAUW8PgRkK4g8YlIB929joq4k
 UFSovnCRHJDkkAEfsaOzTN7dKp062ZuiRaXB6NuqHfN7TCemOtQnRFxUbD8k7c4LY9mR
 OIzvvlNEjOydyOdQx7l6YSc+Ky66HXPMO3ubIVCa6/0QcxL3XQOdHknZotPbShxhjD50
 ELWD55norWhNPTrK+qRVA8Z5LvfFNVtAeDMZjoibm+CKK4RHE1D6ThD4Gpu9jGvXmAxt
 RX9UpMxhfaW9thnpJr8LrxKlI1m7YNW76Dy4WA6FsPEEOYzDm6H+VF8xvF+aYoI1wl+v
 GcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841432; x=1736446232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G24xlquUfYqewIowIQONxQx0BqdSAy070cOUjLKrwBQ=;
 b=E3fYbEsblGUmKomnfkSKxJSKe8V0FWOM/IRYiK9WmGnCQl9j66A4XpLASG9HpXOIpi
 Bz0YkUJXn7tVSDgMODRGxRGE+i+Q4HNjiMlI6qrV71uaSXLTRzbP+unF2UjAQp/IdzAY
 mrOSRD9VLlbQotuGE+G/+fgeHMZBVj6LexO7Hwdok8g1RXf7ulrpC2f91qbctIeTVgD2
 zIZIWqLaRryY/K+A72Ee/EGFBJ5rzFSi3L7Msuz7crJwTdwBdH/7mtFd+nc6yiN6ZCBe
 zL+V5uWaH3zd8NHfCBiBHpi95OO+aE0FevO89Jo5QsPscZGOBolYqlRoyAM8RFIkdOpm
 Ztvw==
X-Gm-Message-State: AOJu0Yw3xDRk40Uu8ajEDUuerxhOAh67uxHOjZngRylP3B2zA0dRCUwg
 qBQ4cETz/lW4my4C5lQkdR/cjeSA+z7K/A4B9tkELV9ZLkDO6vSgwQVkIEb20g0MlhdFsjU72AO
 B
X-Gm-Gg: ASbGncu5/lDpb6MrNk72ERvIEnzDXOkaqjDxaI2lAgcMtepdGyf1uBoCXlugsVUMyIt
 OSJN3qYlFZPuTlbJ5jdkVYn/+hoPhgW2n7qvE01fW3lP3SVcMbCV6j/Qqg9TrTUPYZCXxxwGe12
 1s6mpfZthmediftyvzyOvJWY0vs9lJCOv1Y/KUB7/6APSFkROQ7NvYoN0MJgQg1TZvYhqFImJsP
 j1vxzrggJPehKXbk39zdu/nDLyGrGGC3kNHrIEHChM8Ba4ZS97R4JlolHkhaw==
X-Google-Smtp-Source: AGHT+IGL0hwMf9OLyrYDRBElVcAAbCNFBr7MeFN7uRomQsaG6wpn7e7yqfY7CIoUYcNWMaNly/mTpQ==
X-Received: by 2002:a05:6a21:3a4b:b0:1e4:8fdd:8c77 with SMTP id
 adf61e73a8af0-1e5e044db75mr79518966637.8.1735841431607; 
 Thu, 02 Jan 2025 10:10:31 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 47/73] tcg: Make INDEX_op_extrh_i64_i32 mandatory
Date: Thu,  2 Jan 2025 10:06:27 -0800
Message-ID: <20250102180654.1420056-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

This plugs an odd hole in which a TCGv_i64 may be cast to
a TCGv_i32 for a move.  We already support this opcode for
x86_64, loongarch64, mips64, riscv64.  Implement it for
aarch64, ppc64, s390x, sparc64 and tci.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  8 ++------
 tcg/aarch64/tcg-target-has.h     |  1 -
 tcg/i386/tcg-target-has.h        |  2 --
 tcg/loongarch64/tcg-target-has.h |  1 -
 tcg/mips/tcg-target-has.h        |  1 -
 tcg/ppc/tcg-target-has.h         |  1 -
 tcg/riscv/tcg-target-has.h       |  1 -
 tcg/s390x/tcg-target-has.h       |  1 -
 tcg/sparc64/tcg-target-has.h     |  1 -
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  1 -
 tcg/tcg-op.c                     | 11 ++---------
 tcg/tcg.c                        |  5 ++---
 tcg/aarch64/tcg-target.c.inc     |  6 ++++++
 tcg/ppc/tcg-target.c.inc         |  5 +++++
 tcg/s390x/tcg-target.c.inc       |  5 +++++
 tcg/sparc64/tcg-target.c.inc     |  6 ++++++
 tcg/tci/tcg-target.c.inc         |  5 +++++
 18 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 6082549322..477fdc4235 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -153,12 +153,8 @@ DEF(extract2_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_extract2(TCG_TYPE_I64)))
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, IMPL64)
 DEF(extu_i32_i64, 1, 1, 0, IMPL64)
-DEF(extrl_i64_i32, 1, 1, 0,
-    IMPL(TCG_TARGET_HAS_extr_i64_i32)
-    | (TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0))
-DEF(extrh_i64_i32, 1, 1, 0,
-    IMPL(TCG_TARGET_HAS_extr_i64_i32)
-    | (TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0))
+DEF(extrl_i64_i32, 1, 1, 0, TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0)
+DEF(extrh_i64_i32, 1, 1, 0, TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0)
 
 DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | IMPL64)
 DEF(ext8s_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext8s_i64))
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 2bcfed2761..1bd2598d91 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -41,7 +41,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_ext8s_i64        1
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index e2a3513102..6c57dbb4ed 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -55,8 +55,6 @@
 #define TCG_TARGET_HAS_ext16u_i32       1
 
 #if TCG_TARGET_REG_BITS == 64
-/* Keep 32-bit values zero-extended in a register.  */
-#define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index c1a37cb524..61216884db 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -43,7 +43,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
-#define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 658748110d..0a5b7f9356 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -64,7 +64,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_orc(T)           0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
 #endif
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 42fcccbb0c..7eb3a06bba 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -50,7 +50,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index d5530dc0d6..18c7a6f3b9 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -42,7 +42,6 @@
 #define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index c01a782f80..bce6432087 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -56,7 +56,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext16s_i32     1
 #define TCG_TARGET_HAS_ext8u_i32      1
 #define TCG_TARGET_HAS_ext16u_i32     1
-#define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
 #define TCG_TARGET_HAS_ext8s_i64      1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 747ed1ab8f..7d87761de7 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -44,7 +44,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext16u_i32       0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_ext8s_i64        0
 #define TCG_TARGET_HAS_ext16s_i64       0
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 5649d36961..dc35017852 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -11,7 +11,6 @@
 
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
-#define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_ext8s_i64        0
 #define TCG_TARGET_HAS_ext16s_i64       0
 #define TCG_TARGET_HAS_ext32s_i64       0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index ffe2b0ef27..260b252aa4 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -39,7 +39,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9af6f326b6..c62e4a3b2d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -3218,11 +3218,9 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_LOW(arg));
-    } else if (TCG_TARGET_HAS_extr_i64_i32) {
+    } else {
         tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
-    } else {
-        tcg_gen_mov_i32(ret, (TCGv_i32)arg);
     }
 }
 
@@ -3230,14 +3228,9 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_HIGH(arg));
-    } else if (TCG_TARGET_HAS_extr_i64_i32) {
+    } else {
         tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
-    } else {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_shri_i64(t, arg, 32);
-        tcg_gen_mov_i32(ret, (TCGv_i32)t);
-        tcg_temp_free_i64(t);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5b2ea74f12..27575a2c43 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2300,6 +2300,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sar_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i64:
     case INDEX_op_deposit_i64:
@@ -2321,9 +2323,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_rot(TCG_TYPE_I64);
     case INDEX_op_extract2_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_extract2(TCG_TYPE_I64);
-    case INDEX_op_extrl_i64_i32:
-    case INDEX_op_extrh_i64_i32:
-        return TCG_TARGET_HAS_extr_i64_i32;
     case INDEX_op_ext8s_i64:
         return TCG_TARGET_HAS_ext8s_i64;
     case INDEX_op_ext16s_i64:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 828897ccd8..a05b3c1a34 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2358,6 +2358,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_extrh_i64_i32:
+        tcg_out_shr(s, TCG_TYPE_I64, a0, a1, 32);
+        break;
+
     case INDEX_op_clz_i64:
     case INDEX_op_clz_i32:
         tcg_out_cltz(s, ext, a0, a1, a2, c2, false);
@@ -3006,6 +3010,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 69de135ee7..0f337200eb 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3286,6 +3286,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
             tcg_out32(s, RLDCL | SAB(args[1], args[0], TCG_REG_R0) | MB64(0));
         }
         break;
+    case INDEX_op_extrh_i64_i32:
+        tcg_out_sari64(s, args[0], args[1], 32);
+        break;
 
     case INDEX_op_mul_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
@@ -4203,6 +4206,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext32s_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 633b4efb66..38c15c6ef8 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2674,6 +2674,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sar_i64:
         op = RSY_SRAG;
         goto do_shift64;
+    case INDEX_op_extrh_i64_i32:
+        tcg_out_sh64(s, RSY_SRLG, args[0], args[1], TCG_REG_NONE, 32);
+        break;
 
     case INDEX_op_rotl_i64:
         if (const_args[2]) {
@@ -3358,6 +3361,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index a2a8351945..3e4d8c3698 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1518,6 +1518,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_debug_assert(a2 + args[3] == 32);
         tcg_out_arithi(s, a0, a1, a2, SHIFT_SRA);
         break;
+    case INDEX_op_extrh_i64_i32:
+        tcg_out_arithc(s, a0, a1, 32, true, SHIFT_SRLX);
+        break;
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
@@ -1536,6 +1539,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
@@ -1567,6 +1571,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i64:
     case INDEX_op_qemu_ld_a32_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index dbffbeff5f..94cf09322a 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -70,6 +70,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
@@ -781,6 +783,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     CASE_32_64(sextract) /* Optional (TCG_TARGET_HAS_sextract_*). */
         tcg_out_op_rrbb(s, opc, args[0], args[1], args[2], args[3]);
         break;
+    case INDEX_op_extrh_i64_i32:
+        tcg_out_op_rrbb(s, INDEX_op_extract_i64, args[0], args[1], 32, 32);
+        break;
 
     CASE_32_64(brcond)
         tcg_out_op_rrrc(s, (opc == INDEX_op_brcond_i32
-- 
2.43.0


