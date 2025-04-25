Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65583C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RAO-0002Wl-OV; Fri, 25 Apr 2025 18:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7j-0005IG-GI
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7e-0001Mc-8X
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223fb0f619dso32114475ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618532; x=1746223332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlBLbxntRUUfx4xOxxyMO9j5UdD0Y4Fp3dPe9IgrB78=;
 b=Ao4x18ifM4soaV1ocFNW1XqXbHbFDmOC86mUMRsuwGfFsSlMgd+kFgHJpfBmSpHfBs
 zCogFSYzIMhfD3AG0bQBIMedstjbAFxKyU8tEf3X0HqUN1JXIIZA/mkvmWiR83Iivlq7
 6S/74qFR3j4vfteugWu8qG9B16D0gObgvatUDfsrHGAoxDzN1/wdBbiPxLlHadkstaFu
 qMPiB/2JlO7wttuFRXI/oaicbkJGC88MCO02+AAnggGrO2LxFJUo2EbVlrbA75cn8nmt
 mvEJWTnc/pUREgtJtzwdoU3fuO1j4CahRE/ntBgEvjY7lcP6Y48TA1EJ/LxTG1ifNhw7
 uE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618532; x=1746223332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlBLbxntRUUfx4xOxxyMO9j5UdD0Y4Fp3dPe9IgrB78=;
 b=k7lKwVW7jcbh1kgEQLyQQ7m3IT9y8kztONa1sc0q88er0f4gb+NWALqPWofBhJJnLm
 0nnpx1q2wGhaaTeOWm5p4rhkTErNXFUglVUPZ1pKeQI+t+Q+loUEbp0feI2RTImlnbNQ
 /awXNHcrgR8z815YUO3NyHPkWUsf90XlTAMhodhQ3eREkD3u6oIxUARQlcc5sBVlOY5a
 Oae228Q5ogi1hrCZGXJxsKsHvq2xMXh3kgMSy/R9GqL6TVCFAfUShFb8FzxxFAXeoaz2
 d6m4+of2b25R/YK2xzsVgusJa/mGaShD0T6H8rAQOeDJEhJoH/L3TtkV8+HhFce8XMIl
 z7Xw==
X-Gm-Message-State: AOJu0Yw8zzTeF3y08D8y8MNAJkaD70fg8tzhWGUxp19WX0mUG+0qMU8M
 65BnbXjAKMFddBzSmXLhptnvjRo8H6TjNI/ZlE8UmiW4HMUGgINsSU++y+Ng+NHZx83AqLUbJ56
 b
X-Gm-Gg: ASbGncvCmpYp5PaMMPr2F+Ne0dl7trjaLmu2agnAvl0559oYw6FB+P+YCTQ6vaPHsdw
 6WMxCBCPW12Nv4frYniJor/SP8XFQKRr6LxZLcerqEvmtliJIsvwyv9RsisjU4Yj9Kv+RZZWrXS
 9BC3CuGy3ohJlfMwQh+F70St9aziMMcShYxRtIUZNHVha2dfUi3OlIvyXZG0Ph4s9L0r4D0I+Mk
 7yc6tZ8/ErirNoC5WvlFu83HkAZmcWH5/foZFkSjnbSswyf7d5XReEUyfkMEiUWfA/CSgGnGnCu
 knPFiHwjL5nRlL7qEbUdjMzBTfLMwaKKKcMou5pW7OX8CvxyVQBnEExwJR6O1vnlVLwHqA2PboM
 =
X-Google-Smtp-Source: AGHT+IETyj6U+MHei/n1Kow3ONNK3VBokZCLc2YS+NOCNr4JpBF/Rab8fWUAyqeEuWgdRwxeZyA6HA==
X-Received: by 2002:a17:902:da83:b0:224:26fd:82e5 with SMTP id
 d9443c01a7336-22dbf743713mr55637315ad.48.1745618532386; 
 Fri, 25 Apr 2025 15:02:12 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 102/159] tcg: Convert extu_i32_i64 to TCGOutOpUnary
Date: Fri, 25 Apr 2025 14:53:56 -0700
Message-ID: <20250425215454.886111-103-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 15 ++++++++++++---
 tcg/aarch64/tcg-target.c.inc     |  2 --
 tcg/i386/tcg-target.c.inc        |  2 --
 tcg/loongarch64/tcg-target.c.inc |  2 --
 tcg/mips/tcg-target.c.inc        |  2 --
 tcg/ppc/tcg-target.c.inc         |  2 --
 tcg/riscv/tcg-target.c.inc       |  2 --
 tcg/s390x/tcg-target.c.inc       |  4 ----
 tcg/sparc64/tcg-target.c.inc     |  2 --
 tcg/tci/tcg-target.c.inc         |  2 --
 10 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 6bce097eac..0b2dc17600 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1083,6 +1083,16 @@ static const TCGOutOpUnary outop_exts_i32_i64 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_exts_i32_i64,
 };
+
+static void tgen_extu_i32_i64(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_extu_i32_i64(s, a0, a1);
+}
+
+static const TCGOutOpUnary outop_extu_i32_i64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extu_i32_i64,
+};
 #endif
 
 /*
@@ -1140,6 +1150,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
 #else
     OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
     OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
+    OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
 #endif
 };
 
@@ -5430,9 +5441,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     /* emit instruction */
     TCGType type = TCGOP_TYPE(op);
     switch (op->opc) {
-    case INDEX_op_extu_i32_i64:
-        tcg_out_extu_i32_i64(s, new_args[0], new_args[1]);
-        break;
     case INDEX_op_extrl_i64_i32:
         tcg_out_extrl_i64_i32(s, new_args[0], new_args[1]);
         break;
@@ -5493,6 +5501,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     case INDEX_op_bswap64:
     case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
         assert(TCG_TARGET_REG_BITS == 64);
         /* fall through */
     case INDEX_op_ctpop:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 68f7a1cec2..44314f6a0f 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2710,7 +2710,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -3176,7 +3175,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 14b912beb7..8371cfaf5a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3413,7 +3413,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -4000,7 +3999,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
         return C_O1_I1(r, r);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 2a9c7fc10a..60356d5dfd 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1943,7 +1943,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -2464,7 +2463,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(r, r, r);
 
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ld8s_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index e992a468eb..b6b7070fbb 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2364,7 +2364,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -2390,7 +2389,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index fea767573c..e1767f1d6c 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3640,7 +3640,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -4269,7 +4268,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index e5fe15c338..48d4325097 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2630,7 +2630,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -2873,7 +2872,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 5c5a38c2c8..d81b8fb8f4 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2997,7 +2997,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -3470,9 +3469,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_extu_i32_i64:
-        return C_O1_I1(r, r);
-
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index e93ef8e7f2..d52907f7e3 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1883,7 +1883,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     default:
         g_assert_not_reached();
     }
@@ -1908,7 +1907,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index ecff90404f..3cf2913acd 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -55,7 +55,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
@@ -1108,7 +1107,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
-- 
2.43.0


