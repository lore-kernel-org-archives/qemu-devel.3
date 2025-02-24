Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264E4C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3D-000772-Nm; Mon, 24 Feb 2025 12:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc34-000757-Fi
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:18 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2y-0005mr-VU
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:15 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2211acda7f6so104548965ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417309; x=1741022109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zu7LgByTLkm57wi4I6iwTMStawHq/LqzM76f9LTUk5c=;
 b=Enx62qk2pbq5qGA5Ww+9qfa6XOl3G3YoRnYnGUw8dIjlfoH6RRETse8d0N4OOhllHM
 j5tmIiLUIh7sufU3EfjUDELWpWA9m3DhLD0DAZ9f1wBBEslawLk2fOmub/FICTXWqjIa
 Y5trb8NdOuKZ4z0J9CrlJB3c7PeSVSnufisk0PjW4l8klH21xdqje9F8o3WGX7FFiIZf
 LA+w4ikony08t0kAPv6wbNAaBkAbKnXMbSExeBfOIDuOm/r2reFr/9Nm3ikdR4lB/8Tr
 yj80OhdFkTw4TiCyarpTprwoI+9OAr9/AcCMkhGX1CP/JeVY9yEz0zXqyjG4PEy0TSXN
 zbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417309; x=1741022109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zu7LgByTLkm57wi4I6iwTMStawHq/LqzM76f9LTUk5c=;
 b=u5J8R8H+h4V+GB6yNHRitxvkeqImFSfm4MyWdFsHCwU/T+/uc+C+m+AE3BpL5M+ygj
 P1drP8bANCeq12IUhog5ec6pKA5XkUzwv8YuspFlFUmaKX8ARnj6oYT/UdcCc4fxcJsb
 ON9SWPxUxh/GMb27FwIQ7QGNs4FBp1CytvZPxAP90HniiyONTpLCt+bwkufAjdEZ6fTO
 KeaKpeaVCJ3mDUDf2rboY/+TetyFKPTCjZFQOpBYTupCX8feW9FFpGALlDrEuy5jP+Xn
 YcfB7SUuFgXCMDsYk0UCoasJ9YUCpUrkRJTaj4aNJfPHEZ4pYOjOdCxBl8BC8BJTFr7m
 Hybg==
X-Gm-Message-State: AOJu0Yxh9Ovxh5G2287I3zTve8uTU3Jj7kBAFOqI78pzEglUu0wXIShx
 8b6lwVjwRJkaRu+LAuV3VlAVU9a9zbAsOzBt9cGODC/R+sSmKsr+fWeldOEN4mJknnh4q2JhT6B
 l
X-Gm-Gg: ASbGncsDdj3/XGTMn3HnETHszAuU8SEFO1t/Xi6Vf27t30UtU1z/CpI6/Ds7Qes1dJ2
 hcKh1kEnc0/wwoiiRA13EX5dlAWigMEsAsJMVnvNzAf0oE22Ej4nUYuZhDMC4QwempbWedCBF5B
 oSf0Z8FaK75ZvIjeI+6lCKL4VADKNY5bWPFZVzRv1KwH3MmA1dfj0DrIODFJJFTOPpLvLbZ9nvD
 O2lD3nPasoS5rT2gK0GIIrVJe59WVoVN7yvYJsvNAj6dyGwx+gw0c3Yh4JnP2PYZ1Kjo2U3ChKU
 zwhOLsXSYaxyx/BPZGcD1qBWttt3rPWKOM0=
X-Google-Smtp-Source: AGHT+IHv0nHX59dazINJtt8b8uqmXczF8Cz24C3CD5f4QvDgZAx+gH5h+DhyHqPp75l2B3E+CPPb1A==
X-Received: by 2002:a05:6a00:2e87:b0:732:2269:a15c with SMTP id
 d2e1a72fcca58-73426d8f207mr20425669b3a.20.1740417309388; 
 Mon, 24 Feb 2025 09:15:09 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 17/24] target/m68k: Split gen_ea_mode_fp for load/store
Date: Mon, 24 Feb 2025 09:14:37 -0800
Message-ID: <20250224171444.440135-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Replace with gen_load_mode_fp and gen_store_mode_fp.
Return bool for success from the new functions.
Remove gen_ldst_fp and ea_what as unused.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 125 +++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 60 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 368188ce28..78d9f24970 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -330,12 +330,6 @@ static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val,
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
@@ -1002,60 +996,38 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
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
@@ -1097,7 +1069,7 @@ static int gen_ea_mode_fp(DisasContext *s, int mode, int reg0, int opsize,
             default:
                 g_assert_not_reached();
             }
-            return 0;
+            return true;
         }
         /* fall through */
 
@@ -1108,20 +1080,55 @@ static int gen_ea_mode_fp(DisasContext *s, int mode, int reg0, int opsize,
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
         gen_helper_ftst(tcg_env, cpu_src);
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


