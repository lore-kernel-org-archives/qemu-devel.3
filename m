Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD101C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP0-0002zA-2o; Sun, 11 May 2025 16:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOy-0002pW-94
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:00 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOw-0006LR-2t
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:59 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af59c920d32so2372301a12.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995756; x=1747600556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5X0bW5oGNdaC6Q+SbgRZ65ujphXeQtH0NWLlxtiES8=;
 b=AMEFSNvp8osd8gqQgHDeEbFcjaiFdC4iK6Mb/fiN0+v9vuLP64JQGHTtd+gXSTQNtj
 m/X6hJoEoiEJPmbyRQK9swHl+jgvIks4SXbGq8s+sESpLHJhthzG/uyidMjtoHTMOUHs
 rdVvDkWt+UmSLkBEXuIEjfj88Yz09tuMsm5QIU379EnIv3YrAHBUHoBuYLVWWM9vFGPl
 neqy4C++av2W86q5wjMuEtUDd56QwWqRu/34ZIJqehmSebTVCw8ERGH/VP1yd8v0ydea
 kQg+ndDEgkZ0gKztTGK3Iu70A2BCFXWMemimcLkLnSePHQlvjs8veV1YV83Vqt7hi6M5
 qS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995756; x=1747600556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c5X0bW5oGNdaC6Q+SbgRZ65ujphXeQtH0NWLlxtiES8=;
 b=heU2rhDeN+7rR2oD99waFCH1MGs1+8QfACQrHhrrBR7gISCeJdXozug11oW67evHDO
 TJSi6L5SdD/0GEt6jNr31A+yO4JBs6AhiFRYEky2HiYDdJVwnd2DWbgnHpNfu/k/6FIF
 maPC5QyaDJNGymlVkjThT8D0n0DKumqO+4HBBxgEw8jJHGwc241mboxD05tzdjCGQxKw
 o1i2VP0eKT/3ObqCWucVnKe9sbSJS2h/hAh71UACqGERmrGanCKxeV05XUMdPXWXRl3x
 co/rUUP6KonRORT5c5AQWOzQ+iehUmHarCRRmArydbNSZMAwwLEeV2lht6sCYz8BqQN/
 5wjw==
X-Gm-Message-State: AOJu0YzgcwppkBrecy0AAV19Vac7dlOM2WGJpBwZAbx0+78nOjZu5iz9
 PlT6eCggSof0n9XLeBXm8linpxBIdmB2u+dPcv5xMrmZQX5C9vxx6DVVbjbFEgWKNI8HpnsAfUA
 L
X-Gm-Gg: ASbGncv8XqRtnRD5iB3ZhC0EmZBdS8STx32t9n3tvOIDYHH35tRqzNLb6jXKgUmfOjd
 jq0FSva6cSJhXhvKh5KcjTca6PUHhl0dTY4D6ym6u8Vs9/uKfmVnk51Bksw5UdNK6wty2pMP2O4
 HHZi8NHO4OhhtMzTq5sSAaJp+oxH/ud2MRJEe5eA7YMzRR4oCa0loqedJP+IhFp34sR4tUSuyCq
 lMaJuSYxnQFDg7R5uRu127f82qbJqITSXCaAa+yGtJHBeZTZU8T2Di3zGCFsCNfs8orFpyjh/ar
 WdDGbbEMwPacBujBYwgdX+8UHOO9OK0XkNr4TvBn/Gs01M3qnSkl4k78cKJXBqN5f1Kja5Bwdff
 4ta2oj7i4/Vuid0Fy2Xng
X-Google-Smtp-Source: AGHT+IFsrVzLeC2Js4MIrOsPcb5zT4RTU8qmyGNHRjVXgPuLjpaGI2RrEqtTogfdRz0yTt9M30L4mg==
X-Received: by 2002:a17:902:ecd0:b0:216:2bd7:1c2f with SMTP id
 d9443c01a7336-22fc8b412ddmr125000665ad.18.1746995756322; 
 Sun, 11 May 2025 13:35:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	schwab@linux-m68k.org
Subject: [PATCH v6 11/24] target/m68k: Split gen_ea_mode for load/store
Date: Sun, 11 May 2025 13:35:33 -0700
Message-ID: <20250511203546.139788-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
 target/m68k/translate.c | 157 ++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 80 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 593ff9ba2d..c16925670d 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -60,8 +60,6 @@ static TCGv_i64 cpu_macc[4];
 
 static TCGv NULL_QREG;
 #define IS_NULL_QREG(t) (t == NULL_QREG)
-/* Used to distinguish stores from bad addressing modes.  */
-static TCGv store_dummy;
 
 void m68k_tcg_init(void)
 {
@@ -105,7 +103,6 @@ void m68k_tcg_init(void)
     }
 
     NULL_QREG = tcg_global_mem_new(tcg_env, -4, "NULL");
-    store_dummy = tcg_global_mem_new(tcg_env, -8, "NULL");
 }
 
 /* internal defines */
@@ -339,21 +336,6 @@ typedef enum {
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
@@ -795,9 +777,9 @@ static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
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
@@ -805,40 +787,28 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
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
@@ -857,17 +827,13 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
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
@@ -880,6 +846,43 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
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
@@ -1322,13 +1325,9 @@ static void gen_exit_tb(DisasContext *s)
 
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
@@ -1337,10 +1336,10 @@ static void gen_exit_tb(DisasContext *s)
 
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
@@ -1702,15 +1701,14 @@ DISAS_INSN(abcd_mem)
 
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
@@ -1739,15 +1737,14 @@ DISAS_INSN(sbcd_mem)
 
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
@@ -2171,7 +2168,7 @@ DISAS_INSN(arith_im)
     TCGv im;
     TCGv src1;
     TCGv dest;
-    TCGv addr;
+    TCGv addr = NULL;
     int opsize;
     bool with_SR = ((insn & 0x3f) == 0x3c);
 
@@ -3124,11 +3121,11 @@ DISAS_INSN(cmpm)
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


