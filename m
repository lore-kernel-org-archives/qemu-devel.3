Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF473CF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCRd-0000qs-DE; Mon, 30 Sep 2024 05:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCRW-0000bW-FX
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:47 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCRT-0004XP-IW
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:46 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37cc810ce73so2354053f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687495; x=1728292295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QhDoekpFyldPlQdJYrNU9meNhoETaKUrN8Umy5eIAI=;
 b=ps1Jw4bWCezUraDLV9ca4l8aOhKBkFZdrSJPjvyw+jgNLj8Uexc7/kfoTxrWC5jvZZ
 5nZvvobPC0u1Plm5RjNzLtAY2vcISxpBYHSn3wuVIsgJBVbYcHKKXum7flP57rV5U+Ck
 MqhHhpDbR3uB8B+cxwdg9NTHv/UqC5cyppI2Z6jypdbv4hbGrrb5s2P9VONIn+ybU1MO
 b52iGn/sT6dAgBIgyJndj444Ghfj87h0RYs79B1El2chYk5GysYaYeHw57zyOQ0k4f4R
 w0hxhgvI3HaFn64m0IEL/1qFENQKiMYrctOL5h5rjAfLbBdZXx5BW0dptoWWla8Ui3VS
 29Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687495; x=1728292295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QhDoekpFyldPlQdJYrNU9meNhoETaKUrN8Umy5eIAI=;
 b=prPgDn4AKKQaEVMD4/1K8nc7pjjZnVRGeqABDngcWm9P+93ohRCFqsDEIgvhal1U49
 BKV5PFPxkxetKrLRQqheKvIu/VA6EOcQb5b2p4BUbTzlrT8rVJJuIxKO0NqdHrDDgS2v
 pr/Ov0h/P2LtA90A7MVqKQ4ZGYSWdHeA+FL+GYKEvJ5XvX3v7ViTLW1REw6e/HDuO7UX
 qHcvc3aqF6rZH0r2N3Do/IkVf7q+yS/l0TLmp3GYST0Uh/cBNKG6f7OcAYLxej1MB8vt
 /wZ8gukJWd+/rBqIad3gqeUx2AjkVKRYBhFJeAzFXCU3ObaOoM+8ym7KtGtZp7XUORBp
 7VsA==
X-Gm-Message-State: AOJu0YzqfXyUX06lhmS7N4/vj47Pjccmtw9HNNrs9D8dv0e6JYQKX32x
 Il7rwY72+v982P8sj/onF9aN3ZFNPHLbMfe7L90OQ4+ue+R3W+Q0+8l86WRqJDcyuZvw7932kRU
 K
X-Google-Smtp-Source: AGHT+IHbJZMtSvXM2rJRXIzWlyE59PFwfl7Z30loVoLD0QxJot3py644zZglOycwtv7X/LxoEpZqYw==
X-Received: by 2002:adf:fec3:0:b0:37c:ca21:bc5d with SMTP id
 ffacd0b85a97d-37cd5aa9ab4mr5030789f8f.17.1727687494884; 
 Mon, 30 Sep 2024 02:11:34 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd55a5414sm8663530f8f.0.2024.09.30.02.11.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:11:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 04/12] target/mips: Convert mips16e decr_and_load/store()
 macros to functions
Date: Mon, 30 Sep 2024 11:10:53 +0200
Message-ID: <20240930091101.40591-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
---
 target/mips/tcg/mips16e_translate.c.inc | 101 +++++++++++++-----------
 1 file changed, 53 insertions(+), 48 deletions(-)

diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 5cffe0e412..31bc14f9ca 100644
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


