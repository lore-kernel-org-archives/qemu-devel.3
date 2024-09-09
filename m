Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8319CECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC4-0005N2-Ln; Mon, 09 Sep 2024 13:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBt-0004YT-ET
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBr-00062R-1b
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:41 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20551eeba95so40961145ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902917; x=1726507717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Q+lRBnZtbiSxP2XFIjmwjdFQ0N8KmnUCAkdueIhYHQ=;
 b=HSyGpaUuQ/orhP/U4RXU3WfOeg7r2cfq71wza2KSCW9c0IKtje6e2c2A5LBCvotBz2
 wNGdsxVMfA+C9oRCeSnkMWzYRYyck1oaoHAoGq4gevUvpCBg9Bd3uvYqFixYPUt8gAYh
 63A8yeTbwc9gnbveynZD5wOTm74T6phQy4nBZdS9qG6I0MYMRKM6i61zg2x95/f0SxII
 UNzZmwhqzxhDfYBEKEh0bFH9pEMhFMT4S3KP78Mk8rufldBGsYkFoqSh/OTXodGGJBW3
 8O7lm9OfHSfOQWaTJjUcvJnj0YbZHoeBFbnjyueajR5X35yRUwukapOxCWHHUbNynak5
 VpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902917; x=1726507717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Q+lRBnZtbiSxP2XFIjmwjdFQ0N8KmnUCAkdueIhYHQ=;
 b=RuD1vzXkHhQeMD/iBnT9buSXfsSqRh31Vd44WZLWr2GEHMB0bQIfLoL/DolW6ntcxd
 cldXOtxkgTd1et/wR/AAIV0CzDgdC7jnj1zzEJRcmHTdOZi9dow7tszKvxI8TPloPEgZ
 K8mKZu9DCtlM8LPa7SXL1+5hKUnUiNliZSkWtfKLDyBe3qsUVG1NAY42UbUdkULVDLT1
 zH84rZVH64fHLy157YGhXk0DJCGkEAKpE7N3BBAkEJvZWLsGvC9l2k/z9oU5A29/hcc1
 TTAbmyBj9FeTn2BFXM3A6ygPdp4BoKquQxGSS21z2NnVtFlMQqtQu64TUZRKSXvBmIZV
 vMmg==
X-Gm-Message-State: AOJu0YzRtuEYWmbFjTYBTT4rpIOg5moj+m0orIwnZe6fPm/UHHk1aJVm
 /TndJpjDCGdpbfEWYuLuR/U3KjNsF46yntPmsfYwyNkAQGWNB39f6WY0mnPf2WOJZgqiwIpGNhy
 w
X-Google-Smtp-Source: AGHT+IGXv6J6kfGLh/peM94sZJy0shw9RNV6Hgbzli5EwCsH2O9LbIbtBYFi916L2UawRZeCHqTBxQ==
X-Received: by 2002:a17:902:e80e:b0:206:d6ac:854f with SMTP id
 d9443c01a7336-206f049d45amr97386985ad.3.1725902917127; 
 Mon, 09 Sep 2024 10:28:37 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 13/26] target/m68k: Split gen_ea_mode for load/store
Date: Mon,  9 Sep 2024 10:28:10 -0700
Message-ID: <20240909172823.649837-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
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

Replace with gen_load_mode and gen_store_mode.
Return bool for success from gen_store_mode,
which makes store_dummy unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 155 ++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 79 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index c6b901ff83..2c0852ac3a 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -59,8 +59,6 @@ static TCGv_i64 cpu_macc[4];
 
 static TCGv NULL_QREG;
 #define IS_NULL_QREG(t) (t == NULL_QREG)
-/* Used to distinguish stores from bad addressing modes.  */
-static TCGv store_dummy;
 
 void m68k_tcg_init(void)
 {
@@ -104,7 +102,6 @@ void m68k_tcg_init(void)
     }
 
     NULL_QREG = tcg_global_mem_new(tcg_env, -4, "NULL");
-    store_dummy = tcg_global_mem_new(tcg_env, -8, "NULL");
 }
 
 /* internal defines */
@@ -338,21 +335,6 @@ typedef enum {
     EA_LOADS
 } ea_what;
 
-/*
- * Generate an unsigned load if VAL is 0 a signed load if val is -1,
- * otherwise generate a store.
- */
-static TCGv gen_ldst(DisasContext *s, int opsize, TCGv addr, TCGv val,
-                     ea_what what, int index)
-{
-    if (what == EA_STORE) {
-        gen_store(s, opsize, addr, val, index);
-        return store_dummy;
-    } else {
-        return gen_load(s, opsize, addr, what == EA_LOADS, index);
-    }
-}
-
 /* Read a 16-bit immediate constant */
 static inline uint16_t read_im16(CPUM68KState *env, DisasContext *s)
 {
@@ -794,9 +776,9 @@ static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
  * a write otherwise it is a read (0 == sign extend, -1 == zero extend).
  * ADDRP is non-null for readwrite operands.
  */
-static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
-                        int opsize, TCGv val, TCGv *addrp, ea_what what,
-                        int index)
+static TCGv gen_load_mode(CPUM68KState *env, DisasContext *s,
+                          int mode, int reg0, int opsize, TCGv *addrp,
+                          int sign, int index)
 {
     TCGv reg, ret, addr = NULL;
     int32_t offset;
@@ -804,40 +786,28 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     switch (mode) {
     case 0: /* Data register direct.  */
         reg = cpu_dregs[reg0];
-        if (what == EA_STORE) {
-            gen_partset_reg(opsize, reg, val);
-            ret = store_dummy;
-        } else {
-            ret = gen_extend(s, reg, opsize, what == EA_LOADS);
-        }
+        ret = gen_extend(s, reg, opsize, sign);
         break;
 
     case 1: /* Address register direct.  */
         reg = get_areg(s, reg0);
-        if (what == EA_STORE) {
-            tcg_gen_mov_i32(reg, val);
-            ret = store_dummy;
-        } else {
-            ret = gen_extend(s, reg, opsize, what == EA_LOADS);
-        }
+        ret = gen_extend(s, reg, opsize, sign);
         break;
 
     case 7: /* Other */
-        if (reg0 == 4 && what != EA_STORE) {
+        if (reg0 == 4) {
             /* Immediate: sign extend values for consistency.  */
             switch (opsize) {
             case OS_BYTE:
-                if (what == EA_LOADS) {
-                    offset = (int8_t)read_im8(env, s);
-                } else {
-                    offset = read_im8(env, s);
+                offset = read_im8(env, s);
+                if (sign) {
+                    offset = (int8_t)offset;
                 }
                 break;
             case OS_WORD:
-                if (what == EA_LOADS) {
-                    offset = (int16_t)read_im16(env, s);
-                } else {
-                    offset = read_im16(env, s);
+                offset = read_im16(env, s);
+                if (sign) {
+                    offset = (int16_t)offset;
                 }
                 break;
             case OS_LONG:
@@ -856,17 +826,13 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     case 4: /* Indirect predecrememnt.  */
     case 5: /* Indirect displacement.  */
     case 6: /* Indirect index + displacement.  */
-        if (what == EA_STORE && addrp && *addrp) {
-            addr = *addrp;
-        } else {
-            addr = gen_lea_mode(env, s, mode, reg0, opsize);
-            if (IS_NULL_QREG(addr)) {
-                ret = addr;
-                addr = NULL;
-                break;
-            }
+        addr = gen_lea_mode(env, s, mode, reg0, opsize);
+        if (IS_NULL_QREG(addr)) {
+            ret = addr;
+            addr = NULL;
+            break;
         }
-        ret = gen_ldst(s, opsize, addr, val, what, index);
+        ret = gen_load(s, opsize, addr, sign, index);
         break;
 
     default:
@@ -879,6 +845,43 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     return ret;
 }
 
+static bool gen_store_mode(CPUM68KState *env, DisasContext *s,
+                           int mode, int reg0, int opsize,
+                           TCGv val, TCGv addr, int index)
+{
+    TCGv reg;
+
+    switch (mode) {
+    case 0: /* Data register direct.  */
+        reg = cpu_dregs[reg0];
+        gen_partset_reg(opsize, reg, val);
+        return true;
+
+    case 1: /* Address register direct.  */
+        reg = get_areg(s, reg0);
+        tcg_gen_mov_i32(reg, val);
+        return true;
+
+    case 2: /* Indirect register */
+    case 3: /* Indirect postincrement.  */
+    case 4: /* Indirect predecrememnt.  */
+    case 5: /* Indirect displacement.  */
+    case 6: /* Indirect index + displacement.  */
+    case 7: /* Other */
+        if (!addr) {
+            addr = gen_lea_mode(env, s, mode, reg0, opsize);
+            if (IS_NULL_QREG(addr)) {
+                return false;
+            }
+        }
+        gen_store(s, opsize, addr, val, index);
+        return true;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static TCGv_ptr gen_fp_ptr(int freg)
 {
     TCGv_ptr fp = tcg_temp_new_ptr();
@@ -1321,13 +1324,9 @@ static void gen_exit_tb(DisasContext *s)
 
 #define SRC_EA(env, result, opsize, op_sign, addrp)                     \
     do {                                                                \
-        TCGv *addrp_ = (addrp);                                         \
-        if (addrp_) {                                                   \
-            *addrp_ = NULL;                                             \
-        }                                                               \
-        result = gen_ea_mode(env, s, extract32(insn, 3, 3),             \
-                             REG(insn, 0), opsize, NULL_QREG, addrp_,   \
-                             op_sign ? EA_LOADS : EA_LOADU, IS_USER(s)); \
+        result = gen_load_mode(env, s, extract32(insn, 3, 3),           \
+                               REG(insn, 0), opsize, addrp,             \
+                               op_sign, IS_USER(s));                    \
         if (IS_NULL_QREG(result)) {                                     \
             gen_addr_fault(s);                                          \
             return;                                                     \
@@ -1336,10 +1335,10 @@ static void gen_exit_tb(DisasContext *s)
 
 #define DEST_EA(env, insn, opsize, val, addrp)                          \
     do {                                                                \
-        TCGv ea_result = gen_ea_mode(env, s, extract32(insn, 3, 3),     \
-                                     REG(insn, 0), opsize, val, addrp,  \
-                                     EA_STORE, IS_USER(s));             \
-        if (IS_NULL_QREG(ea_result)) {                                  \
+        TCGv *addrp_ = (addrp);                                         \
+        if (!gen_store_mode(env, s, extract32(insn, 3, 3),              \
+                            REG(insn, 0), opsize, val,                  \
+                            addrp_ ? *addrp_ : NULL, IS_USER(s))) {     \
             gen_addr_fault(s);                                          \
             return;                                                     \
         }                                                               \
@@ -1701,15 +1700,14 @@ DISAS_INSN(abcd_mem)
 
     /* Indirect pre-decrement load (mode 4) */
 
-    src = gen_ea_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                      NULL_QREG, NULL, EA_LOADU, IS_USER(s));
-    dest = gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                       NULL_QREG, &addr, EA_LOADU, IS_USER(s));
+    src = gen_load_mode(env, s, 4, REG(insn, 0), OS_BYTE,
+                        NULL, false, IS_USER(s));
+    dest = gen_load_mode(env, s, 4, REG(insn, 9), OS_BYTE,
+                         &addr, false, IS_USER(s));
 
     bcd_add(dest, src);
 
-    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr,
-                EA_STORE, IS_USER(s));
+    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -1738,15 +1736,14 @@ DISAS_INSN(sbcd_mem)
 
     /* Indirect pre-decrement load (mode 4) */
 
-    src = gen_ea_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                      NULL_QREG, NULL, EA_LOADU, IS_USER(s));
-    dest = gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                       NULL_QREG, &addr, EA_LOADU, IS_USER(s));
+    src = gen_load_mode(env, s, 4, REG(insn, 0), OS_BYTE,
+                        NULL, false, IS_USER(s));
+    dest = gen_load_mode(env, s, 4, REG(insn, 9), OS_BYTE,
+                         &addr, false, IS_USER(s));
 
     bcd_sub(dest, src);
 
-    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr,
-                EA_STORE, IS_USER(s));
+    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -3123,11 +3120,11 @@ DISAS_INSN(cmpm)
     TCGv src, dst;
 
     /* Post-increment load (mode 3) from Ay.  */
-    src = gen_ea_mode(env, s, 3, REG(insn, 0), opsize,
-                      NULL_QREG, NULL, EA_LOADS, IS_USER(s));
+    src = gen_load_mode(env, s, 3, REG(insn, 0), opsize,
+                        NULL, true, IS_USER(s));
     /* Post-increment load (mode 3) from Ax.  */
-    dst = gen_ea_mode(env, s, 3, REG(insn, 9), opsize,
-                      NULL_QREG, NULL, EA_LOADS, IS_USER(s));
+    dst = gen_load_mode(env, s, 3, REG(insn, 9), opsize,
+                        NULL, true, IS_USER(s));
 
     gen_update_cc_cmp(s, dst, src, opsize);
 }
-- 
2.43.0


