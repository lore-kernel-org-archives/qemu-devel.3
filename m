Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE335D0C604
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 15:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4izJ-0001DM-9H; Sat, 26 Oct 2024 11:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4izI-0001D7-B6
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 11:46:00 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4izG-0007EY-L9
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 11:46:00 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ed9c16f687so2239445a12.0
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729957556; x=1730562356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IzCeCnXZcZFzbEpRCXR1UfcZZKsaCPraEa9wZnEbwSc=;
 b=aycYP/NsJIZn9OZhxUGMYPAA3cAokVMl8b/8T8WUswCwhKw3sw6XefJFCCQeGOxlwV
 tMawu8VKL12JDrpmrHXHGjtE8C60M3JmtE7957u/azgp28Zrn9N2Nj4g1TPljo5WV7zG
 p4Pphaf68Jh0o/01SEGTdoXwxpJW7TsgNc4Fj1XQPLxCDvC3ehWmv62fD368jmbd3FFe
 xeIe68ulRGnJna9LbArvNCtjsSMp2Av0Ol4TwRriY4//VqY6aH/OlC+iTne6j+qhos9i
 hTJmF0FtDoiP+N6fQTSADvhu1NizpjxGwtTuCXnxHzlcMxoQMpYAPKgidg1vVTf+9cIR
 d6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729957556; x=1730562356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzCeCnXZcZFzbEpRCXR1UfcZZKsaCPraEa9wZnEbwSc=;
 b=IRMqU3Fyb6suJxH/HtstmL45pdtjosFRuZyftB2NtCshige/jfEAOxeoSGosqVgWGO
 CeJqy092mEKjfM03cpniTlNAdamf+WUOevR///FsE4wlGyzUE1SpAlMqY1Z5yMX9hIo8
 U/WFssB3WGbYlXJ/EOnfgYGdZY00gcFLYxwv2CLBL8ze+PAwTaqUsaTc5+5Q9xKZBGCM
 kXTqsaTdsngw3M2sgKEYKDMKbj6oX35lk7PiHa1hgNCxoqCMldbxJQLmX405gfTnQfh7
 4FQ37VeNkKCKhS6fryzvgwtLASAhqaEYI9NcXcprwOjbKLfsg9CHLx36CkukvF0V2iDW
 U+KQ==
X-Gm-Message-State: AOJu0YzppGfwPVXwkEtmQKG6BtOIO6sWwDI/LL0PHyrcU+PAJO9orswx
 gK1ujhofsUWwr2kUz3v4M1p5cTNO500YnjQ9UpqGZOkmBVIYGiX6E6F6bUC42nLsozojFYseLry
 X
X-Google-Smtp-Source: AGHT+IGyiBEleuxmFXSzI6E5uLsAZTQCD4h7DOty9dB+1Cwd7m6YfGl5YUeZSuqYiTECP47MUy1WoQ==
X-Received: by 2002:a05:6a20:7a99:b0:1d9:69ca:6b24 with SMTP id
 adf61e73a8af0-1d9a8402dc0mr3757009637.23.1729957556292; 
 Sat, 26 Oct 2024 08:45:56 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8a3d0cesm2902305a12.80.2024.10.26.08.45.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Oct 2024 08:45:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/mips: Remove unreachable 32-bit code on 64-bit
 Loongson Ext
Date: Sat, 26 Oct 2024 12:45:50 -0300
Message-ID: <20241026154550.78880-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Loongson fixed-point multiplies and divisions opcodes are
specific to 64-bit cores (Loongson-2 and Loongson-3 families).
Simplify by removing the 32-bit checks.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20230831203024.87300-1-philmd@linaro.org>
---
 target/mips/tcg/loong_translate.c | 43 +++----------------------------
 target/mips/tcg/translate.c       |  2 +-
 target/mips/tcg/meson.build       |  2 +-
 3 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index c896e64b9e6..91711b8e052 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -31,13 +31,6 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2, *l3;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -61,8 +54,7 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
     tcg_gen_br(l3);
     gen_set_label(l1);
 
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double && TARGET_LONG_BITS == 64
-                                        ? LLONG_MIN : INT_MIN, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double ? LLONG_MIN : INT_MIN, l2);
     tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
     tcg_gen_mov_tl(cpu_gpr[rd], t0);
 
@@ -93,13 +85,6 @@ static bool gen_lext_DIVU_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -147,13 +132,6 @@ static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2, *l3;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -173,8 +151,7 @@ static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
         tcg_gen_ext32u_tl(t1, t1);
     }
     tcg_gen_brcondi_tl(TCG_COND_EQ, t1, 0, l1);
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double && TARGET_LONG_BITS == 64
-                                        ? LLONG_MIN : INT_MIN, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double ? LLONG_MIN : INT_MIN, l2);
     tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
     gen_set_label(l1);
     tcg_gen_movi_tl(cpu_gpr[rd], 0);
@@ -205,13 +182,6 @@ static bool gen_lext_MODU_G(DisasContext *s, int rd, int rs, int rt,
     TCGv t0, t1;
     TCGLabel *l1, *l2;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -257,13 +227,6 @@ static bool gen_lext_MULT_G(DisasContext *s, int rd, int rs, int rt,
 {
     TCGv t0, t1;
 
-    if (is_double) {
-        if (TARGET_LONG_BITS != 64) {
-            return false;
-        }
-        check_mips_64(s);
-    }
-
     if (rd == 0) {
         /* Treat as NOP. */
         return true;
@@ -295,6 +258,8 @@ static bool trans_DMULTu_G(DisasContext *s, arg_muldiv *a)
 
 bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
 {
+    assert(ctx->hflags & MIPS_HFLAG_64);
+
     if ((ctx->insn_flags & INSN_LOONGSON2E)
             && decode_godson2(ctx, ctx->opcode)) {
         return true;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 9839575247e..68a5c21bb2d 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15020,7 +15020,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     if (cpu_supports_isa(env, INSN_VR54XX) && decode_ext_vr54xx(ctx, ctx->opcode)) {
         return;
     }
-    if (decode_ext_loongson(ctx, ctx->opcode)) {
+    if (TARGET_LONG_BITS == 64 && decode_ext_loongson(ctx, ctx->opcode)) {
         return;
     }
 #if defined(TARGET_MIPS64)
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index fbb6d6eb407..fd91148df74 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -16,7 +16,6 @@ mips_ss.add(files(
   'fpu_helper.c',
   'ldst_helper.c',
   'lmmi_helper.c',
-  'loong_translate.c',
   'msa_helper.c',
   'msa_translate.c',
   'op_helper.c',
@@ -31,6 +30,7 @@ mips_ss.add(when: 'TARGET_MIPS64', if_true: files(
   'tx79_translate.c',
   'octeon_translate.c',
   'lcsr_translate.c',
+  'loong_translate.c',
 ), if_false: files(
   'mxu_translate.c',
 ))
-- 
2.45.2


