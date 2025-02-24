Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51A7C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3t-0007tx-6V; Mon, 24 Feb 2025 12:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc38-00075w-Vi
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:24 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc33-0005nE-1C
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:22 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22113560c57so9984765ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417313; x=1741022113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7puFozR/S/HFtpP6HqziAn/+Q1ih0p7FIn5tWzox+Q=;
 b=YQaRav3mrKs0LN3yds2dZA45NKRg0DyvprG0lhB3dG4eCd/V6sReNDpL4BVLRkra2a
 2HMMJtE2080+qapsOmue2t9Owy5f6GecaF1LyL6yLw6KX5UFkFGnxujeknHNLSbo0cyj
 y5qnYbQpeU/0h7Phyk33tyYjva45ialDYsxM3XzLC1PbDmX/clXjW0qpALu4vdJmzM61
 1hIy9wXfE+50ts3VweIN4bQoY7O12dlpWNW2Ig1EC35JHa4NLXU7gWTT4mZoebNUPla2
 V8r+UeGKiLX7CjlItEglQGwYLk/5OlpUQj1zk5fTHfMX3u6dQqKlRuyJfKEN+0vStAuD
 VHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417313; x=1741022113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7puFozR/S/HFtpP6HqziAn/+Q1ih0p7FIn5tWzox+Q=;
 b=T3t2DGRGrmhHGwHoxirXkfPtpK9oZiacNVA4Jg7NI3THz/NYcMzWLV/K02iQc0xyjo
 OuMkKI9owa26QRVrAkAjfdDKvkjEdAjCfPAgEx07Zecms39QgjVadiP4RBxWPoHrjpuF
 yTX1rpy4DDwbwqXBon5TW0aDsoWwZ9uOaSUkwuijHI7nu8ekfiv2nIZ26NuaKsS0qHkf
 AFv8YCXldH18qbazCiN+GDdPRHsY0ut3hBrA4fk379mq09ZxZUFUGktfLp4FJXXtBNSM
 E/3se2SVzaCZisIC9wf1WckdBsn4j76WOJ9/VY4gMke6Vi4x0j4X7b9SxKEldWDZH1Yb
 z7mw==
X-Gm-Message-State: AOJu0YySZes3MEgoYrLvlhzata+FX3W/2yeMQknfx8OqLcZmI9igRegF
 Lhi5pZNQMnlWVnUXaq1vZ67R6FjTYIy14d0Z61pCIBWTdAdsQkvIu8yo0rADgdTpOaZZ8BxZv+S
 3
X-Gm-Gg: ASbGncu2kN4bNBSYx7dU1JLxp6kCvdBs5SXEpzsC3Q1q905vNCrzKZo7krx2xTv0Wl4
 Lfld0oNZUn+NhNngqtuty7n6tmex/vPZ6JfjO7TGHRdAhvN54XlBnrv3hqn5P2fXp+v7wqOOnpx
 jIEb4K2icqeEaPAlfiFuhLTwCxwUxWhtMeb/zSosNTyp6gqDri/Gl9wo87JxIcMYIeNdXrfiLVY
 Us9bdBAQt9vxq+uY7yzYj9u4J600GE3v5sbzSpSIy3BQbfoAFZV9SDi+wh2o9k7dzcCpcIDjP6w
 2UEnRu0XcWOdHZvCf8jgxTQRGZaB7nQugQ4=
X-Google-Smtp-Source: AGHT+IFXv+ngL/Z1y6mRAAnETbMijv/A3DM5dGguuqdK7Jw7lEzJrVkskVXYOfXsDLh4GKdFD9dSjQ==
X-Received: by 2002:a05:6a00:4b54:b0:732:6217:8c69 with SMTP id
 d2e1a72fcca58-73426c94ad6mr26323245b3a.3.1740417313414; 
 Mon, 24 Feb 2025 09:15:13 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 20/24] target/m68k: Merge gen_store_fp, gen_store_mode_fp
Date: Mon, 24 Feb 2025 09:14:40 -0800
Message-ID: <20250224171444.440135-21-richard.henderson@linaro.org>
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

This enables the exceptions raised by the actual store
to be reflected as a failure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 107 ++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 47311a8579..62e0b05e34 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -902,53 +902,6 @@ static void gen_fp_move(TCGv_ptr dest, TCGv_ptr src)
     tcg_gen_st_i64(t64, dest, offsetof(FPReg, l.lower));
 }
 
-static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
-                         int index)
-{
-    TCGv tmp;
-    TCGv_i64 t64;
-
-    t64 = tcg_temp_new_i64();
-    tmp = tcg_temp_new();
-    switch (opsize) {
-    case OS_BYTE:
-    case OS_WORD:
-    case OS_LONG:
-        gen_helper_reds32(tmp, tcg_env, fp);
-        tcg_gen_qemu_st_tl(tmp, addr, index, opsize | MO_TE);
-        break;
-    case OS_SINGLE:
-        gen_helper_redf32(tmp, tcg_env, fp);
-        tcg_gen_qemu_st_tl(tmp, addr, index, MO_TEUL);
-        break;
-    case OS_DOUBLE:
-        gen_helper_redf64(t64, tcg_env, fp);
-        tcg_gen_qemu_st_i64(t64, addr, index, MO_TEUQ);
-        break;
-    case OS_EXTENDED:
-        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
-            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
-            break;
-        }
-        tcg_gen_ld16u_i32(tmp, fp, offsetof(FPReg, l.upper));
-        tcg_gen_shli_i32(tmp, tmp, 16);
-        tcg_gen_qemu_st_i32(tmp, addr, index, MO_TEUL);
-        tcg_gen_addi_i32(tmp, addr, 4);
-        tcg_gen_ld_i64(t64, fp, offsetof(FPReg, l.lower));
-        tcg_gen_qemu_st_i64(t64, tmp, index, MO_TEUQ);
-        break;
-    case OS_PACKED:
-        /*
-         * unimplemented data type on 68040/ColdFire
-         * FIXME if needed for another FPU
-         */
-        gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static bool gen_load_fp(DisasContext *s, uint16_t insn, int opsize,
                         TCGv_ptr fp, int index)
 {
@@ -1088,12 +1041,13 @@ static bool gen_load_fp(DisasContext *s, uint16_t insn, int opsize,
     return true;
 }
 
-static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
-                              TCGv_ptr fp, int index)
+static bool gen_store_fp(DisasContext *s, uint16_t insn, int opsize,
+                         TCGv_ptr fp, int index)
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    TCGv reg, addr;
+    TCGv reg, addr, tmp;
+    TCGv_i64 t64;
 
     switch (mode) {
     case 0: /* Data register direct.  */
@@ -1127,10 +1081,55 @@ static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
             gen_addr_fault(s);
             return false;
         }
-        gen_store_fp(s, opsize, addr, fp, index);
-        return true;
+        break;
+
+    default:
+        g_assert_not_reached();
     }
-    g_assert_not_reached();
+
+    switch (opsize) {
+    case OS_BYTE:
+    case OS_WORD:
+    case OS_LONG:
+        tmp = tcg_temp_new();
+        gen_helper_reds32(tmp, tcg_env, fp);
+        tcg_gen_qemu_st_tl(tmp, addr, index, opsize | MO_TE);
+        break;
+    case OS_SINGLE:
+        tmp = tcg_temp_new();
+        gen_helper_redf32(tmp, tcg_env, fp);
+        tcg_gen_qemu_st_tl(tmp, addr, index, MO_TEUL);
+        break;
+    case OS_DOUBLE:
+        t64 = tcg_temp_new_i64();
+        gen_helper_redf64(t64, tcg_env, fp);
+        tcg_gen_qemu_st_i64(t64, addr, index, MO_TEUQ);
+        break;
+    case OS_EXTENDED:
+        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
+            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+            return false;
+        }
+        tmp = tcg_temp_new();
+        t64 = tcg_temp_new_i64();
+        tcg_gen_ld16u_i32(tmp, fp, offsetof(FPReg, l.upper));
+        tcg_gen_shli_i32(tmp, tmp, 16);
+        tcg_gen_qemu_st_i32(tmp, addr, index, MO_TEUL);
+        tcg_gen_addi_i32(addr, addr, 4);
+        tcg_gen_ld_i64(t64, fp, offsetof(FPReg, l.lower));
+        tcg_gen_qemu_st_i64(t64, addr, index, MO_TEUQ);
+        break;
+    case OS_PACKED:
+        /*
+         * unimplemented data type on 68040/ColdFire
+         * FIXME if needed for another FPU
+         */
+        gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+        return false;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
 }
 
 typedef struct {
@@ -4889,7 +4888,7 @@ DISAS_INSN(fpu)
     case 3: /* fmove out */
         cpu_src = gen_fp_ptr(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
-        if (gen_store_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
+        if (gen_store_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
             gen_helper_ftst(tcg_env, cpu_src);
         }
         return;
-- 
2.43.0


