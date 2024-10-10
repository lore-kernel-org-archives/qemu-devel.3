Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5310AD24455
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz13v-0007ek-2N; Thu, 10 Oct 2024 17:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13p-0007QE-Ji
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:05 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13m-0004fb-Is
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:05 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20c71603217so12527905ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597059; x=1729201859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOOJxTdMLVXErkbjYWqNoVc3nM10oJqf8XDD2AIWBko=;
 b=EmS5H0pCr7+IYy0IJeNRl9eHtHcHaCMX4c48A5vbdSB2XaT40KEj06AyZWetlCWrEm
 e9ZWLCQsjbU0xEI/4R6svxRKZ6QwdrfdZX+Sk0NUq+qww7xL16H9GfPMOI2DC38eJIml
 L1/4pZBQbNtS7ghYx/XbXF90qn3oPSyq5blnf6++DDxbGseaLjzYDhAlo3nL+3WoGHDx
 mESVD6zkrYVBqCv9y0JeUvJ1bKki+yycgvjlDG66iIfRdr7izw+JUmrUKkP0KvWBpFtk
 0G84YwNR7LrtcGsLQVzJHuVWUmco03c4QNnEiucbobjTN9gXdrl5aUEuhoqjvc/Y8aAN
 HCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597059; x=1729201859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOOJxTdMLVXErkbjYWqNoVc3nM10oJqf8XDD2AIWBko=;
 b=RHSuglNNFxbhRQzQ4jAND8hLGPEHmYWS9toRjdZk7Ha3nUTG4kFXhgXu9Az3cJjU8I
 +zdhMdQJZP53HPY0Ig8BNLxGuDlPJGotqYBP6li5MpVD9C8JqXaSAmQXfvkEQm7yZO3Z
 aaXW4jOtml48LEi/LZlz16jBgvBjezPckeOCf6WB18tOPVXTS3IRQAKnOBARxHC69/cx
 c2v5USJQlf2LUEhBghOIjiEEj6WfWAEAttFxuxIbaiSOuVRknTHs95yqmJVEA9Tk6P/8
 k1U+gmRG61V/OElFyuHP9qT2/fQi63RzhAJVtOBQEsyQm57NwPpxYkO4AhWoPc+Kl0uJ
 6XQA==
X-Gm-Message-State: AOJu0Yyep7yW8ju+enATZ0TM4BeyH9Y7O7GDmWVv64nB9P6jVr/LOgpj
 Ck2eVPJ+SlqXesSalE5I4KV4DUsP3joLDoqs303K4oQi2ShjtuFYNQp+QIQsT5AbRf+ur4JDa+q
 a
X-Google-Smtp-Source: AGHT+IFiYJaSjhH7i6lctKbazZAj82fii/s/d2aqMiBaqdNSJO5YGvm9SR55+fFLiNLfbN/Tpv6fvw==
X-Received: by 2002:a17:902:e845:b0:20b:449c:8978 with SMTP id
 d9443c01a7336-20ca147a5b6mr4811645ad.31.1728597059570; 
 Thu, 10 Oct 2024 14:50:59 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c345e46sm13587675ad.271.2024.10.10.14.50.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:50:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 05/16] target/mips: Convert mips16e decr_and_load/store()
 macros to functions
Date: Thu, 10 Oct 2024 18:50:03 -0300
Message-ID: <20241010215015.44326-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x632.google.com
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

Functions are easier to rework than macros. Besides,
there is no gain here in inlining these.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/mips16e_translate.c.inc | 101 +++++++++++++-----------
 1 file changed, 53 insertions(+), 48 deletions(-)

diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 5cffe0e412d..31bc14f9ca6 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -122,11 +122,23 @@ enum {
 
 static int xlat(int r)
 {
-  static int map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
+  static const int map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
 
   return map[r];
 }
 
+static void decr_and_store(DisasContext *ctx, unsigned regidx, TCGv t0)
+{
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+
+    tcg_gen_movi_tl(t2, -4);
+    gen_op_addr_add(ctx, t0, t0, t2);
+    gen_load_gpr(t1, regidx);
+    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+                       ctx->default_tcg_memop_mask);
+}
+
 static void gen_mips16_save(DisasContext *ctx,
                             int xsregs, int aregs,
                             int do_ra, int do_s0, int do_s1,
@@ -196,46 +208,38 @@ static void gen_mips16_save(DisasContext *ctx,
 
     gen_load_gpr(t0, 29);
 
-#define DECR_AND_STORE(reg) do {                                 \
-        tcg_gen_movi_tl(t2, -4);                                 \
-        gen_op_addr_add(ctx, t0, t0, t2);                        \
-        gen_load_gpr(t1, reg);                                   \
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |       \
-                           ctx->default_tcg_memop_mask);         \
-    } while (0)
-
     if (do_ra) {
-        DECR_AND_STORE(31);
+        decr_and_store(ctx, 31, t0);
     }
 
     switch (xsregs) {
     case 7:
-        DECR_AND_STORE(30);
+        decr_and_store(ctx, 30, t0);
         /* Fall through */
     case 6:
-        DECR_AND_STORE(23);
+        decr_and_store(ctx, 23, t0);
         /* Fall through */
     case 5:
-        DECR_AND_STORE(22);
+        decr_and_store(ctx, 22, t0);
         /* Fall through */
     case 4:
-        DECR_AND_STORE(21);
+        decr_and_store(ctx, 21, t0);
         /* Fall through */
     case 3:
-        DECR_AND_STORE(20);
+        decr_and_store(ctx, 20, t0);
         /* Fall through */
     case 2:
-        DECR_AND_STORE(19);
+        decr_and_store(ctx, 19, t0);
         /* Fall through */
     case 1:
-        DECR_AND_STORE(18);
+        decr_and_store(ctx, 18, t0);
     }
 
     if (do_s1) {
-        DECR_AND_STORE(17);
+        decr_and_store(ctx, 17, t0);
     }
     if (do_s0) {
-        DECR_AND_STORE(16);
+        decr_and_store(ctx, 16, t0);
     }
 
     switch (aregs) {
@@ -270,23 +274,34 @@ static void gen_mips16_save(DisasContext *ctx,
     }
 
     if (astatic > 0) {
-        DECR_AND_STORE(7);
+        decr_and_store(ctx, 7, t0);
         if (astatic > 1) {
-            DECR_AND_STORE(6);
+        decr_and_store(ctx, 6, t0);
             if (astatic > 2) {
-                DECR_AND_STORE(5);
+                decr_and_store(ctx, 5, t0);
                 if (astatic > 3) {
-                    DECR_AND_STORE(4);
+                    decr_and_store(ctx, 4, t0);
                 }
             }
         }
     }
-#undef DECR_AND_STORE
 
     tcg_gen_movi_tl(t2, -framesize);
     gen_op_addr_add(ctx, cpu_gpr[29], cpu_gpr[29], t2);
 }
 
+static void decr_and_load(DisasContext *ctx, unsigned regidx, TCGv t0)
+{
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+
+    tcg_gen_movi_tl(t2, -4);
+    gen_op_addr_add(ctx, t0, t0, t2);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TESL |
+                       ctx->default_tcg_memop_mask);
+    gen_store_gpr(t1, regidx);
+}
+
 static void gen_mips16_restore(DisasContext *ctx,
                                int xsregs, int aregs,
                                int do_ra, int do_s0, int do_s1,
@@ -294,52 +309,43 @@ static void gen_mips16_restore(DisasContext *ctx,
 {
     int astatic;
     TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
     TCGv t2 = tcg_temp_new();
 
     tcg_gen_movi_tl(t2, framesize);
     gen_op_addr_add(ctx, t0, cpu_gpr[29], t2);
 
-#define DECR_AND_LOAD(reg) do {                            \
-        tcg_gen_movi_tl(t2, -4);                           \
-        gen_op_addr_add(ctx, t0, t0, t2);                  \
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TESL | \
-                           ctx->default_tcg_memop_mask);   \
-        gen_store_gpr(t1, reg);                            \
-    } while (0)
-
     if (do_ra) {
-        DECR_AND_LOAD(31);
+        decr_and_load(ctx, 31, t0);
     }
 
     switch (xsregs) {
     case 7:
-        DECR_AND_LOAD(30);
+        decr_and_load(ctx, 30, t0);
         /* Fall through */
     case 6:
-        DECR_AND_LOAD(23);
+        decr_and_load(ctx, 23, t0);
         /* Fall through */
     case 5:
-        DECR_AND_LOAD(22);
+        decr_and_load(ctx, 22, t0);
         /* Fall through */
     case 4:
-        DECR_AND_LOAD(21);
+        decr_and_load(ctx, 21, t0);
         /* Fall through */
     case 3:
-        DECR_AND_LOAD(20);
+        decr_and_load(ctx, 20, t0);
         /* Fall through */
     case 2:
-        DECR_AND_LOAD(19);
+        decr_and_load(ctx, 19, t0);
         /* Fall through */
     case 1:
-        DECR_AND_LOAD(18);
+        decr_and_load(ctx, 18, t0);
     }
 
     if (do_s1) {
-        DECR_AND_LOAD(17);
+        decr_and_load(ctx, 17, t0);
     }
     if (do_s0) {
-        DECR_AND_LOAD(16);
+        decr_and_load(ctx, 16, t0);
     }
 
     switch (aregs) {
@@ -374,18 +380,17 @@ static void gen_mips16_restore(DisasContext *ctx,
     }
 
     if (astatic > 0) {
-        DECR_AND_LOAD(7);
+        decr_and_load(ctx, 7, t0);
         if (astatic > 1) {
-            DECR_AND_LOAD(6);
+            decr_and_load(ctx, 6, t0);
             if (astatic > 2) {
-                DECR_AND_LOAD(5);
+                decr_and_load(ctx, 5, t0);
                 if (astatic > 3) {
-                    DECR_AND_LOAD(4);
+                    decr_and_load(ctx, 4, t0);
                 }
             }
         }
     }
-#undef DECR_AND_LOAD
 
     tcg_gen_movi_tl(t2, framesize);
     gen_op_addr_add(ctx, cpu_gpr[29], cpu_gpr[29], t2);
-- 
2.45.2


