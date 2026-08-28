Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3147C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jp-00013P-Ay; Fri, 28 Aug 2026 18:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jo-00012G-4i
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:04 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jm-0004NC-1N
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:03 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3964e480f76so1915742a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957101; x=1788561901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IGVbaoEVsWIydAAkJGpVk0FOSYkkpsgqDdITVO8oMWQ=;
 b=JeUSknt+5AOPJS1cetoThswAhwz2FKv2+6s1dJ+Ph/Wh+meSK1rqVm9H4fWHhF7Ohq
 CcDD0UnmvrPERp1JvOSckMKBUfhjJsslAU4RzWdSlT+QsjiqY+QjD+0XweILp7ZUrvPj
 IVWC8jH07WWoX/iO9iaa6syZci+6hv+Iebh0GcB3p9a969LuFhGjlCryhm37JQqG+HJ7
 em8JS2e870rtih0un33Ydo6gOZOFGIvWTNHHf4kGnEYNAraeNYg62NbqptCJDC8pNEjd
 +CswXvYJAo0H7koL+gGw+3embyl+kN39woM3jWDcLJCJ27rct96K/VmoT5VZbLiF46kh
 0CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957101; x=1788561901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IGVbaoEVsWIydAAkJGpVk0FOSYkkpsgqDdITVO8oMWQ=;
 b=d0HuoHXnDwPrENFutx8ErJhFxIfVbpStJgiq0vOqplb73T3RKPTbDKtOGLmBZCvU/x
 1wdDIRUDcOyQCSrcnj9/lcmII5pLvbxKFhxkQV+SpCqZ0GUrre/GdwzX+RxbQLpypUYk
 bQiPBHiYMFQeEZq2C14p1baB29eAwQEL6vGJrcFbSkM6Mm4vV/HCz73l7ep+Lyd4Fc6z
 J4zVYH1KmqMg5kWCeKhhVpKh7qww2tS/BRQEWSQcWhDB6cCVmk6qLqpAM5Lq1MTKn8mZ
 ssnRE2inC9yR6NGiWnlobfsBiEZnqt75FXWvfy+su+je2KL0/ndB5g25SR96x92BHy2t
 xNSQ==
X-Gm-Message-State: AFuF++mE/8nI3eHCfyGsBRfMa20S25k1eBtulZ8wTwf+MWUqGICzjJNT
 9X6Cmqh8aNYPBGjLG6XCb3o4Al4yzv1bm7+seLPx6rDJU00VUiyqYnACrdsIab64967lB2jTG/6
 ptQnyiQw=
X-Gm-Gg: AYBFou3ObGQxeEl0qGF7CBFsSzu09wCtrW8GWKJesngpAzPKMnf+kWd9vGodmHLOiFn
 aR1WBnAOhQK5LZzAUjm2anhYOVMC5DtU9PlXpGazAggGTeVm5hBYxST5tYaj074iuw96hrWatzn
 5CQMTQUlcelXjcDWB95Jo+wXL/RNgEVzhNTp18vwj8MIm7DE2pMEr4huND4zun3Tlg1mqRk91SC
 T7ukucxoYRvrP+SFVlotckTF+4Uphrebr0BuUxkHu4/VMfk3tJFZ9f6qZ36sDVE5Hk1ebQJMXz8
 5RWx/gLarpVY01Jgkq9YuE1YCUj18L9YoeWSR0UEPScGDsnrWWoOkGmzzyrX0BnhnmPdF8ldyOq
 KtErDdXOeR++cd/K313SjztzRzaQwZ1U1sBUIQJYK6ag7lwDs3DODgAGuxJhl4i2ddudcOj5JHq
 ++nUIJDXPzBtjeUOjzgA0SX9E0q1yIY1MdebPq0OAREP8toCcT+egl3q77OSMoCSlr0KgZBeeGM
 4yvmoAdeBkpgEgc5jtR
X-Received: by 2002:a17:90b:2b90:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-396d0fce294mr20370427a91.12.1787957100629; 
 Fri, 28 Aug 2026 15:45:00 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:45:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 10/16] tcg/x86_64: Introduce TCG_REG_NONE
Date: Fri, 28 Aug 2026 15:44:45 -0700
Message-ID: <20260828224451.1564072-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Rather than hard-code -1, or compare < 0, use something
more descriptive.  This also allows more use of TCGReg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/x86_64/tcg-target.h     |  1 +
 tcg/x86_64/tcg-target.c.inc | 66 ++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/tcg/x86_64/tcg-target.h b/tcg/x86_64/tcg-target.h
index 7ebae56a7d7..7109722f240 100644
--- a/tcg/x86_64/tcg-target.h
+++ b/tcg/x86_64/tcg-target.h
@@ -31,6 +31,7 @@
 #define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
 
 typedef enum {
+    TCG_REG_NONE = -1,
     TCG_REG_EAX = 0,
     TCG_REG_ECX,
     TCG_REG_EDX,
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 660350b963d..ec397e287c0 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -210,7 +210,8 @@ static bool tcg_target_const_match(int64_t val, int ct,
     return 0;
 }
 
-# define LOWREGMASK(x)	((x) & 7)
+#define LOWREGMASK(x)   ((x) & 7)
+#define REGOR0(x)       ((x) == TCG_REG_NONE ? 0 : (x))
 
 #define P_EXT		0x100		/* 0x0f opcode prefix */
 #define P_EXT38         0x200           /* 0x0f 0x38 opcode prefix */
@@ -524,7 +525,7 @@ static const uint8_t tcg_cond_to_jcc[] = {
     [TCG_COND_TSTNE] = JCC_JNE,
 };
 
-static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
+static void tcg_out_opc(TCGContext *s, int opc, TCGReg r, TCGReg rm, TCGReg x)
 {
     int rex;
 
@@ -572,14 +573,14 @@ static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
     tcg_out8(s, opc);
 }
 
-static void tcg_out_modrm(TCGContext *s, int opc, int r, int rm)
+static void tcg_out_modrm(TCGContext *s, int opc, TCGReg r, TCGReg rm)
 {
     tcg_out_opc(s, opc, r, rm, 0);
     tcg_out8(s, 0xc0 | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
 }
 
-static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
-                            int rm, int index)
+static void tcg_out_vex_opc(TCGContext *s, int opc, TCGReg r, TCGReg v,
+                            TCGReg rm, TCGReg index)
 {
     int tmp;
 
@@ -630,8 +631,8 @@ static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
     tcg_out8(s, opc);
 }
 
-static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
-                             int rm, int index, int aaa, bool z)
+static void tcg_out_evex_opc(TCGContext *s, int opc, TCGReg r, TCGReg v,
+                             TCGReg rm, TCGReg index, int aaa, bool z)
 {
     /* The entire 4-byte evex prefix; with R' and V' set. */
     uint32_t p = 0x08041062;
@@ -676,7 +677,8 @@ static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
     tcg_out8(s, opc);
 }
 
-static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
+static void tcg_out_vex_modrm(TCGContext *s, int opc, TCGReg r,
+                              TCGReg v, TCGReg rm)
 {
     if (opc & P_EVEX) {
         tcg_out_evex_opc(s, opc, r, v, rm, 0, 0, false);
@@ -687,7 +689,7 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
 }
 
 static void tcg_out_vex_modrm_type(TCGContext *s, int opc,
-                                   int r, int v, int rm, TCGType type)
+                                   TCGReg r, TCGReg v, TCGReg rm, TCGType type)
 {
     if (type == TCG_TYPE_V256) {
         opc |= P_VEXL;
@@ -695,8 +697,8 @@ static void tcg_out_vex_modrm_type(TCGContext *s, int opc,
     tcg_out_vex_modrm(s, opc, r, v, rm);
 }
 
-static void tcg_out_evex_modrm_type(TCGContext *s, int opc, int r, int v,
-                                    int rm, int aaa, bool z, TCGType type)
+static void tcg_out_evex_modrm_type(TCGContext *s, int opc, TCGReg r, TCGReg v,
+                                    TCGReg rm, int aaa, bool z, TCGType type)
 {
     if (type == TCG_TYPE_V256) {
         opc |= P_VEXL;
@@ -710,12 +712,12 @@ static void tcg_out_evex_modrm_type(TCGContext *s, int opc, int r, int v,
    mode for absolute addresses, ~RM is the size of the immediate operand
    that will follow the instruction.  */
 
-static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
+static void tcg_out_sib_offset(TCGContext *s, TCGReg r, TCGReg rm, TCGReg index,
                                int shift, intptr_t offset)
 {
     int mod, len;
 
-    if (index < 0 && rm < 0) {
+    if (index == TCG_REG_NONE && rm == TCG_REG_NONE) {
         /*
          * Try for a rip-relative addressing mode.  This has replaced
          * the 32-bit-mode absolute addressing encoding.
@@ -746,7 +748,7 @@ static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
 
     /* Find the length of the immediate addend.  Note that the encoding
        that would be used for (%ebp) indicates absolute addressing.  */
-    if (rm < 0) {
+    if (rm == TCG_REG_NONE) {
         mod = 0, len = 4, rm = 5;
     } else if (offset == 0 && LOWREGMASK(rm) != TCG_REG_EBP) {
         mod = 0, len = 0;
@@ -758,7 +760,7 @@ static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
 
     /* Use a single byte MODRM format if possible.  Note that the encoding
        that would be used for %esp is the escape to the two byte form.  */
-    if (index < 0 && LOWREGMASK(rm) != TCG_REG_ESP) {
+    if (index == TCG_REG_NONE && LOWREGMASK(rm) != TCG_REG_ESP) {
         /* Single byte MODRM format.  */
         tcg_out8(s, mod | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
     } else {
@@ -767,7 +769,7 @@ static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
         /* Note that the encoding that would place %esp into the index
            field indicates no index register.  In 64-bit mode, the REX.X
            bit counts, so %r12 can be used as the index.  */
-        if (index < 0) {
+        if (index == TCG_REG_NONE) {
             index = 4;
         } else {
             tcg_debug_assert(index != TCG_REG_ESP);
@@ -784,32 +786,34 @@ static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
     }
 }
 
-static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
-                                     int index, int shift, intptr_t offset)
+static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, TCGReg r,
+                                     TCGReg rm, TCGReg index,
+                                     int shift, intptr_t offset)
 {
-    tcg_out_opc(s, opc, r, rm < 0 ? 0 : rm, index < 0 ? 0 : index);
+    tcg_out_opc(s, opc, r, REGOR0(rm), REGOR0(index));
     tcg_out_sib_offset(s, r, rm, index, shift, offset);
 }
 
-static void tcg_out_vex_modrm_sib_offset(TCGContext *s, int opc, int r, int v,
-                                         int rm, int index, int shift,
+static void tcg_out_vex_modrm_sib_offset(TCGContext *s, int opc,
+                                         TCGReg r, TCGReg v, TCGReg rm,
+                                         TCGReg index, int shift,
                                          intptr_t offset)
 {
-    tcg_out_vex_opc(s, opc, r, v, rm < 0 ? 0 : rm, index < 0 ? 0 : index);
+    tcg_out_vex_opc(s, opc, r, v, REGOR0(rm), REGOR0(index));
     tcg_out_sib_offset(s, r, rm, index, shift, offset);
 }
 
 /* A simplification of the above with no index or shift.  */
-static inline void tcg_out_modrm_offset(TCGContext *s, int opc, int r,
-                                        int rm, intptr_t offset)
+static void tcg_out_modrm_offset(TCGContext *s, int opc, TCGReg r,
+                                 TCGReg rm, intptr_t offset)
 {
-    tcg_out_modrm_sib_offset(s, opc, r, rm, -1, 0, offset);
+    tcg_out_modrm_sib_offset(s, opc, r, rm, TCG_REG_NONE, 0, offset);
 }
 
-static inline void tcg_out_vex_modrm_offset(TCGContext *s, int opc, int r,
-                                            int v, int rm, intptr_t offset)
+static void tcg_out_vex_modrm_offset(TCGContext *s, int opc, TCGReg r,
+                                     TCGReg v, TCGReg rm, intptr_t offset)
 {
-    tcg_out_vex_modrm_sib_offset(s, opc, r, v, rm, -1, 0, offset);
+    tcg_out_vex_modrm_sib_offset(s, opc, r, v, rm, TCG_REG_NONE, 0, offset);
 }
 
 /* Output an opcode with an expected reference to the constant pool.  */
@@ -1889,7 +1893,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 
 #ifdef CONFIG_USER_ONLY
 static HostAddress x86_guest_base = {
-    .index = -1
+    .index = TCG_REG_NONE
 };
 
 #if defined(__linux__)
@@ -2173,7 +2177,7 @@ static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
     HostAddress h;
 
     ldst = prepare_host_addr(s, &h, addr, oi, true);
-    tcg_out_qemu_ld_direct(s, data, -1, h, type, get_memop(oi));
+    tcg_out_qemu_ld_direct(s, data, TCG_REG_NONE, h, type, get_memop(oi));
 
     if (ldst) {
         ldst->type = type;
@@ -2311,7 +2315,7 @@ static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
     HostAddress h;
 
     ldst = prepare_host_addr(s, &h, addr, oi, false);
-    tcg_out_qemu_st_direct(s, data, -1, h, get_memop(oi));
+    tcg_out_qemu_st_direct(s, data, TCG_REG_NONE, h, get_memop(oi));
 
     if (ldst) {
         ldst->type = type;
-- 
2.53.0


