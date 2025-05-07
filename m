Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5800C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm5K-0006Hh-NG; Wed, 07 May 2025 17:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4x-0006CZ-T4
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4u-0006FR-Dd
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so370316b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652398; x=1747257198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHgGr6AIObpnYWHjAOdcgxhm8gRRf7ROs3UzR4seVSk=;
 b=Whl0b7x54ub4qYgR36abfULGBUnJqbYP22fY+CyQOcW54gOosUYqzbHrNiEP8/TFqU
 1+SbgWlTTxP7hKdScTYwM/mv9Ton9wokfGRlsefumRsrbmcLyrDV8mWpWLQOVIaLko4p
 Hx92LzmDrdMrmkjPtmvrQO81wZ/2ZSNR8gd9F9CmWWqtNTS3ZNf5Mma2at1aPoHKTDoN
 cTQLOlOXLMiiRccuuxKCJ9XgfoM9YplXbkiHYEkKysf11quEW/LHvq0PUKvn5UF12LfZ
 KBwvYSFe8E6cLOYck0oroIKpsfYFhm3o6q1UJWFnku07IXdJWrI68eEoIf6WOO/gZyXt
 YilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652398; x=1747257198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHgGr6AIObpnYWHjAOdcgxhm8gRRf7ROs3UzR4seVSk=;
 b=bPhOtYflYrpvvDbCy1/L4O2oRkFRewrT8QSv8fouVwSlNcCytS72YfC04XvMOuH3CN
 tke1hw+5kMT6q9FFriVTRvVP1KPTebMjsOgB6mUadoKpkllENTVMifVmR6/UI/aW/8v9
 J5SXjTP7/aZ5QUsp6vpoOUfADZ5+/myyf5ncXYsuHMO+5axOGs+9QUKePhamoNK5+YDN
 9O3oIcwqPfk52X78z+Xvt3ffLQtPDxVVwT8Yrj1a4p7S3tefc7SjIq1xORr6IGsdkv9H
 0BeV6R/FVsRq+uKdebxilRJkAt2m4OFTTu0oNqYINuzb9OXbUVPkd4MxbJjwIFQtsLl4
 z1sA==
X-Gm-Message-State: AOJu0Yy7O13Q3ulX3JguQNA7TPWlSBsq+TcuK8qlRGI6LytR/j1Rp8Jp
 wAF3c8ldL7Jox4t4wLymjCwTKnaWxINIG1u8Kh5S/OK9766M2xIc8gznc5Z0RsueUXsZsgbivNt
 I
X-Gm-Gg: ASbGnctzRbVGJ3XIAe6Ag9ipSZeONUmsBv/TQyPDeemRrqbEd+ZEmTEPLiw1wqT8InV
 NIu4h0q5L98YtvmCOb9GpVOtnFyHA88hN7crioDI/4rljox1K0W6vPTYjBfsO9Ef68Z0bShLaM4
 snwJqAxzGnJ7etwoa2S7nipCfxBOU6GRUB7jKQ9xg2QRsgaYR+7SvOYtXHeWHA5Ksan+o4iNgDG
 dILuzk6Z9YQArJeD+2fsfkfEzzrBLPMrEPP0fdF0x+I06G7a9PV2Y6Sc0e5ObAqfnZ4FGhnP8BA
 D48fCEc+7fiPyPN3Rq57lGLToi0a+ODh8EwRPeBMMerqpVlCtuAD1pT8qvG6c5OHmhO6Tn0lRU8
 =
X-Google-Smtp-Source: AGHT+IE2fWAcdZs9lzvjtrwh/TLO6Et1nw1yXPpoVmFyMo6W9T0+mB4Ug8/kFvF5IIbLHZxjCPUfbQ==
X-Received: by 2002:a05:6a20:72aa:b0:1f5:a3e8:64c8 with SMTP id
 adf61e73a8af0-2148d42cc3dmr8562656637.36.1746652398364; 
 Wed, 07 May 2025 14:13:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 20/24] target/m68k: Merge gen_store_fp, gen_store_mode_fp
Date: Wed,  7 May 2025 14:12:55 -0700
Message-ID: <20250507211300.9735-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
index 711f1477c8..af5b20989c 100644
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


