Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F5DD1D882
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jle-0005NI-5t; Tue, 15 Oct 2024 11:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlW-0004sM-Or
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:19 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlU-00010W-U8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:18 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e3fce4a60so2832827b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007235; x=1729612035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e10gg62bVZR218Yi+lSWU64iaPNDemXQBedt5af7g0A=;
 b=OnVOx5ldc1JcdM4L2Rnon4BAA3sJRrMqq1LFnhNprLdLt2CMXWwjZKGnE6Mp/7zZ/w
 xzIQWe/xoiSfQBJqAKpgnGkjAPfHx5erTkhiZno6YqNTIIDOIrkGIwuq16IHJ3e8ccOd
 EO24xiSf2Gjl5jTbZnr0gzklrws+7cF+0cLpiB1h6VezRhEiJHD/esnrYUlXhug9rBPL
 kPuX2gHyP6PALx/4VxUgxm30+n8AzUaCeiWTSxeFZh9vrOdi2AVqlXg/jnpol0b8P0HD
 nTphx8BCyG9QeVDVUpXC3AAC3OWKaCZTL5u9EnooqbO5QATtdiWWMaeW7ZgEKgpV5nuU
 TBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007235; x=1729612035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e10gg62bVZR218Yi+lSWU64iaPNDemXQBedt5af7g0A=;
 b=T5BV1BGcnr56XOq6YxLcrW1KT9aR0ZlXKNbVr1Y5EFNSy0iMdybHCZxqu7elz4XuhN
 /BMXzlP67Y8W4PXX8eMsgqVBCt8lORonnnxGcGZk9SIQ0ZAsEsAScF0p2xZ0jWFeFerq
 FEy058jBALLi+3FRNu8c+Dtv2fSiZtfO2s2fNuqMWyJCair8nuU1TZqIEQ3ppcwB1XfU
 k/OMmxCqkDG9oi9wwDmU6qiZh06QTDf8GMf3ajHwn2ll7Duxte+bG8dO5sWhuFJjngfG
 12NuilqlV9sd2UY081EhM8Gj1OtxXyXF8qMLv65ANsutzcf9Otc6owb4c0X6i1ry7mgd
 VNuA==
X-Gm-Message-State: AOJu0YwxyPwIDA9+ohQ4qfhmd/5NFpkN5pWpXZ1rUA+XK99v6nI0leq0
 fA4Ub6I1UyY0sYJrcrixpW/hazk7YD6/KF19LWyRwkHH/dx+jWSjglIYtVHTQyZA87Y4iccfzJw
 3
X-Google-Smtp-Source: AGHT+IFLJZ8vUemhdWtsGqnmEZti9p3l/91aeBAnw9CJlYOaZmJIkDpo/P8ENyCG9uwUU3UdpjbN8A==
X-Received: by 2002:a05:6a00:3392:b0:710:5848:8ae1 with SMTP id
 d2e1a72fcca58-71e7da10f78mr1179926b3a.4.1729007235181; 
 Tue, 15 Oct 2024 08:47:15 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e774cc2c7sm1410866b3a.164.2024.10.15.08.47.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:47:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/33] target/mips: Convert mips16e decr_and_load/store()
 macros to functions
Date: Tue, 15 Oct 2024 12:44:30 -0300
Message-ID: <20241015154443.71763-22-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42e.google.com
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
Message-Id: <20241010215015.44326-6-philmd@linaro.org>
---
 target/mips/tcg/mips16e_translate.c.inc | 101 +++++++++++++-----------
 1 file changed, 53 insertions(+), 48 deletions(-)

diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 5cffe0e412d..cabc17345f4 100644
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
+            decr_and_store(ctx, 6, t0);
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


