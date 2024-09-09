Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD11AECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC7-0005co-0y; Mon, 09 Sep 2024 13:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBy-0004tN-5r
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:46 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBw-00063d-BA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2057835395aso41030935ad.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902922; x=1726507722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jgxR3ACwEZdh0fOwka7bHIaCcpswZg47RQZTNXAvtg=;
 b=V2UmtbqWtXHfPILhYjAmsDQeCItXuO7WFvoMp5XZUwCfZUxrB/8NyM3j7P0yhrTG6r
 1ILQj6TiQiFB1nuhg0qh9Ub487ykRAkgZNsynH0jhxKxoeXrVP5YQYVoKXNIeL6piuw9
 WQJUer4BZLt7yKCmX7WbeZcOcRWPXgjNjyVec1j+dZvWIP3FjxieD6C7okFKVerMlcqc
 lGvZQjpI6F8Up4muDcCVFgW2Lj7xNKixKIsvuZchf+xbDjOjy9nxvSslBPnG9bIenOAK
 6NOmShOwuAfqXSPbZRxRB2wWexCBMgo2/QPZDZqNPhjlG+3b4CBzgKgQdEd/oQVZMSa6
 ol9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902922; x=1726507722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3jgxR3ACwEZdh0fOwka7bHIaCcpswZg47RQZTNXAvtg=;
 b=OLXS+LNTLMWXULe1d4Id9XD1sUI1BhXKINTTPUpdA6G7e0JoTDpycv9gpWmXjQaceg
 ApFeuGpsC43z59+1P9SWcw/wVQJQnKtSHY3a62a1CTizlXo8+wm2wDpuSKC6JaCo6gzQ
 u/ZcasbqI4OHVj3NurjFdG85CxgpznFi8HjJ6K4a/yf/jI2DeB8kUadR0qlCjY8Bl53x
 NjdE6hhPU+bgIBo7B34P6PqxVUM95Xm5xGegpQXwiCgJISsunwV7BGWeL+7HY3OU+A9I
 fr9kY2Px87DlmKGl1WVinDDkEKadvTmoL0qNuHW7MAnn6+XEo/pGrWgcpyCkllKkkuA4
 UWUQ==
X-Gm-Message-State: AOJu0YyorzkaemciQmjbS8k3KthGP+w+pQlcuyhQr7df38zZ/zGes2aM
 sx4fDY6Kn81/pERaNv8HwVopBm2C+b6q5+6uBukpXQ6pQ2YS1PfHYsmpn1x88XVTO5HkzmuSPsl
 f
X-Google-Smtp-Source: AGHT+IELMx12wt45Bga39AHSyrjViOXcDKUXvJAybNX962o0MawWWZxZTMVdGoCu//iE9OyZB6/ZpA==
X-Received: by 2002:a17:903:120c:b0:206:add9:624 with SMTP id
 d9443c01a7336-2070a5793a2mr103491765ad.36.1725902922391; 
 Mon, 09 Sep 2024 10:28:42 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 19/26] target/m68k: Split gen_ea_mode_fp for load/store
Date: Mon,  9 Sep 2024 10:28:16 -0700
Message-ID: <20240909172823.649837-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
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

Replace with gen_load_mode_fp and gen_store_mode_fp.
Return bool for success from the new functions.
Remove gen_ldst_fp and ea_what as unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 125 +++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 60 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 5bfdf9aadf..c81d093c61 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -329,12 +329,6 @@ static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val,
     }
 }
 
-typedef enum {
-    EA_STORE,
-    EA_LOADU,
-    EA_LOADS
-} ea_what;
-
 /* Read a 16-bit immediate constant */
 static inline uint16_t read_im16(CPUM68KState *env, DisasContext *s)
 {
@@ -1001,60 +995,38 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
     }
 }
 
-static void gen_ldst_fp(DisasContext *s, int opsize, TCGv addr,
-                        TCGv_ptr fp, ea_what what, int index)
-{
-    if (what == EA_STORE) {
-        gen_store_fp(s, opsize, addr, fp, index);
-    } else {
-        gen_load_fp(s, opsize, addr, fp, index);
-    }
-}
-
-static int gen_ea_mode_fp(DisasContext *s, int mode, int reg0, int opsize,
-                          TCGv_ptr fp, ea_what what, int index)
+static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
+                             TCGv_ptr fp, int index)
 {
+    int mode = extract32(insn, 3, 3);
+    int reg0 = REG(insn, 0);
     TCGv reg, addr, tmp;
     TCGv_i64 t64;
 
     switch (mode) {
     case 0: /* Data register direct.  */
         reg = cpu_dregs[reg0];
-        if (what == EA_STORE) {
-            switch (opsize) {
-            case OS_BYTE:
-            case OS_WORD:
-            case OS_LONG:
-                gen_helper_reds32(reg, tcg_env, fp);
-                break;
-            case OS_SINGLE:
-                gen_helper_redf32(reg, tcg_env, fp);
-                break;
-            default:
-                g_assert_not_reached();
-            }
-        } else {
-            tmp = tcg_temp_new();
-            switch (opsize) {
-            case OS_BYTE:
-            case OS_WORD:
-            case OS_LONG:
-                tcg_gen_ext_i32(tmp, reg, opsize | MO_SIGN);
-                gen_helper_exts32(tcg_env, fp, tmp);
-                break;
-            case OS_SINGLE:
-                gen_helper_extf32(tcg_env, fp, reg);
-                break;
-            default:
-                g_assert_not_reached();
-            }
+        tmp = tcg_temp_new();
+        switch (opsize) {
+        case OS_BYTE:
+        case OS_WORD:
+        case OS_LONG:
+            tcg_gen_ext_i32(tmp, reg, opsize | MO_SIGN);
+            gen_helper_exts32(tcg_env, fp, tmp);
+            break;
+        case OS_SINGLE:
+            gen_helper_extf32(tcg_env, fp, reg);
+            break;
+        default:
+            g_assert_not_reached();
         }
-        return 0;
+        return true;
+
     case 1: /* Address register direct.  */
-        return -1;
+        return false;
 
     case 7: /* Other */
-        if (reg0 == 4 && what != EA_STORE) {
+        if (reg0 == 4) {
             switch (opsize) {
             case OS_BYTE:
                 tmp = tcg_constant_i32((int8_t)read_im8(s->env, s));
@@ -1096,7 +1068,7 @@ static int gen_ea_mode_fp(DisasContext *s, int mode, int reg0, int opsize,
             default:
                 g_assert_not_reached();
             }
-            return 0;
+            return true;
         }
         /* fall through */
 
@@ -1107,20 +1079,55 @@ static int gen_ea_mode_fp(DisasContext *s, int mode, int reg0, int opsize,
     case 6: /* Indirect index + displacement.  */
         addr = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(addr)) {
-            return -1;
+            return false;
         }
-        gen_ldst_fp(s, opsize, addr, fp, what, index);
-        return 0;
+        gen_load_fp(s, opsize, addr, fp, index);
+        return true;
     }
     g_assert_not_reached();
 }
 
-static int gen_ea_fp(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                       int opsize, TCGv_ptr fp, ea_what what, int index)
+static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
+                              TCGv_ptr fp, int index)
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    return gen_ea_mode_fp(s, mode, reg0, opsize, fp, what, index);
+    TCGv reg, addr;
+
+    switch (mode) {
+    case 0: /* Data register direct.  */
+        reg = cpu_dregs[reg0];
+        switch (opsize) {
+        case OS_BYTE:
+        case OS_WORD:
+        case OS_LONG:
+            gen_helper_reds32(reg, tcg_env, fp);
+            break;
+        case OS_SINGLE:
+            gen_helper_redf32(reg, tcg_env, fp);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        return true;
+
+    case 1: /* Address register direct.  */
+        return false;
+
+    case 2: /* Indirect register */
+    case 3: /* Indirect postincrement.  */
+    case 4: /* Indirect predecrememnt.  */
+    case 5: /* Indirect displacement.  */
+    case 6: /* Indirect index + displacement.  */
+    case 7: /* Other */
+        addr = gen_lea_mode(s, mode, reg0, opsize);
+        if (IS_NULL_QREG(addr)) {
+            return false;
+        }
+        gen_store_fp(s, opsize, addr, fp, index);
+        return true;
+    }
+    g_assert_not_reached();
 }
 
 typedef struct {
@@ -4880,8 +4887,7 @@ DISAS_INSN(fpu)
     case 3: /* fmove out */
         cpu_src = gen_fp_ptr(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
-        if (gen_ea_fp(env, s, insn, opsize, cpu_src,
-                      EA_STORE, IS_USER(s)) == -1) {
+        if (!gen_store_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
             gen_addr_fault(s);
         }
         gen_helper_update_fpsr(tcg_env, cpu_src);
@@ -4902,8 +4908,7 @@ DISAS_INSN(fpu)
         /* Source effective address.  */
         opsize = ext_opsize(ext, 10);
         cpu_src = gen_fp_result_ptr();
-        if (gen_ea_fp(env, s, insn, opsize, cpu_src,
-                      EA_LOADS, IS_USER(s)) == -1) {
+        if (!gen_load_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
             gen_addr_fault(s);
             return;
         }
-- 
2.43.0


