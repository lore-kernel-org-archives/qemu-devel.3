Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D672C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JO-0002gz-Vb; Thu, 17 Sep 2026 04:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JG-0002fs-Vo
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:36 -0400
Received: from mail-oa2-x26.google.com ([2607:f8b0:4864:30::26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JE-0001vD-1x
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:34 -0400
Received: by mail-oa2-x26.google.com with SMTP id
 586e51a60fabf-466cc88a9b9so284711fac.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633050; x=1790237850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lupB/6KhAhLSazkAiCLGBwJiEtAirKu82VIBuG4qBnI=;
 b=s5WtqpAfU95HKQ6b/4lvzkBR7RDOTsNFHgoc4nA+wJbi1jiiK62AWUXrMwunf30pO9
 FENddfcnbuFxOLqpcZSzOEDpRMQWXhvIBbzcM6OrqyA6g/vg4ko2yCI7V85kfQuOvqpn
 E7+UyQw/ndMN7IoDWV9CwvixNeTbrIjXVb1prsK7Bg12yssPj2WyMEItSDZLshtY0eb5
 QW6rCifRfq+1L/08YT23qhZpdFkx2utxIHRMSuYFcc+9A52GzoORlFu8P8e1vpzZNBPO
 +bF8ucRMu4TkoeyYx3W2d3JED274EfVvm/bCTy4qZc8dHuAoEPxqom/55OV8FBEOzMcH
 6RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633050; x=1790237850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lupB/6KhAhLSazkAiCLGBwJiEtAirKu82VIBuG4qBnI=;
 b=raFGQ4JYQHb4siil73/gCcKLJ8qZobwiHYRG32vwheQAYq1MGvYqoYO523cAMfOvE5
 brnY94Y2f0nqta/sKL1JLc9O9Ccg1PLCBe9ouJqWq4Am/isH6NIDuzEXopzlGdHQXn/5
 LGjzRoHlfAn+HSx0UHNqspsgR+VlRKlzE+uDiwBtoKakNdsursXB/oBjCqoky+XpCgVP
 eGkrvg6JqUT1s5ju/Jta5kjMoi+b3WMRAfSiqeg56mbSZ5xnbVwlgDjc8KVxcn1+DH/I
 iBy2EDDsWFusXG1IE9fONRamIhjhHMR5NqMvuPS+x6YxrwaYzRziGq6LdGLEkj6EuMNw
 9OxQ==
X-Gm-Message-State: AFuF++n8l4jXe2NpvKGr1x9/K77Iy19OwHHI5IbhF6fWqRshK0DX19Bj
 IyXKZoen4P/yzwxc76IFoHGf2zSmmD3ex9OI4NEYz19ka6PzH+oWsZooktd4JEH4rWWrITaXbq6
 g58kLojI=
X-Gm-Gg: AYBFou073BTf5lDeRM+9ERjlQr6pcFjiggT/cf4sCMZh9rKswuqfOr7w8CrTqugR8BN
 qOcbLTu3SOYKt6Ya8LtBcC8g0F6inMpjEEv+ME+eRe0Ip3AimzoYLgKJgyXI4Gsrmpr1OZry7o8
 sTDl29Wjz8+4kO9hbPxv9VimYIw8ScQnyb6p6IU20UyERQFwwAQfXf6ommlD39rZYvzviVW0UJq
 U6JQE5RMx7W9sHnaWtItUzriK8Fhbl1cz9WAzyQhmjCB/wX5uTlIr9ZUkQSeNp5IZiJZYGv9I2J
 4N4N+9+Vyt25Edos9gA/alqHM2/z45+6/R02aez+spY9Jm5mAXs/VPj825zcl2eyXFp3cO4TKBM
 Va54fP4ASJhg373Z6RD8tRFeVVVmIBeadeYLzQIs9Nq0n/rcXmDar+uoH3SItufJ50ZeLR1+sXc
 zXRBwlv/gtZNFlG6LfSjeYpPKBs0JzIbH7aTEPQTERDWMzMmWpj2eeQ5i7Y777YmoLu+HDj7zut
 zUgagRZpJZ1miMFLA==
X-Received: by 2002:a05:6820:1688:b0:6b1:bdd9:453 with SMTP id
 006d021491bc7-6c7d05e7b63mr5461531eaf.12.1789633050071; 
 Thu, 17 Sep 2026 01:17:30 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 10/16] tcg/x86_64: Introduce TCG_REG_NONE
Date: Wed, 16 Sep 2026 22:17:10 -1000
Message-ID: <20260917081716.946668-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::26;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa2-x26.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
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


