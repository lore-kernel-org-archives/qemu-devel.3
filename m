Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D56CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulKL-0000Pu-Hl; Sat, 06 Sep 2025 01:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulK9-0000MJ-Hb
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:54 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJt-0006pG-28
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45cb6428c46so22902595e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135911; x=1757740711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0lsKCQL+YqSEvwOxx8MYwslyW+UoFwzM6ZVUUq2n68=;
 b=SazRQJIzLeP3tLxLQYQ4+U46bx8obuc+XTI6pIfMXXJ8no34Oma+jABNPLvmCwB7/I
 ddMquOdOxjh7aoSi8NyuTJDLqIuVXstXeZWfWvNHSSayPtk4P6eZBeG6AutHytsFcUJ7
 fZfSUt1Y9WYGR7By++LVaAreckpTfHiKnmCGzcpnRqeEUKunBne4KaSGFSnF8xFVKXLC
 oC9PT7M8As4UM6FvniXYAAteUP/Z2cfNLc0X5Ii7gR/aVoqf+ASTVbIIWxSTDKuDYqrR
 Dtk7ImpNl+MYap3s7rlYJ5sLfTvEKye3PlRXvobT/QC40DmvL8wSY2UHp9AaO/F6cAFo
 2C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135911; x=1757740711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0lsKCQL+YqSEvwOxx8MYwslyW+UoFwzM6ZVUUq2n68=;
 b=thhyCIKWByyPX9HYfuk1qx0zpmFxy4NcMfNI+oXFV//mCAJSB6X17SUNt9YuL+3MtY
 MUmh7ftJh2ld4H0/Z5bsRaMCkPUiyOxtjoYqWpHgp0U8YqYQtV+wvjZ+jcifcXC9sBHW
 U1tLOI6WZsOMzeiQBz7v5t6ld+l0bDXDfHrEsMd/e47TgWJZkTYuUoY3R4qzF+0/XznI
 MGF6sKJaY8HHXUuWf9Sh9/N4OivyCtQkPY9O9VygqQj2IQeGpOTAmLNYkAqPTfeRivIs
 HLBOwE5HpC/CL8mhzYpDA3GbVSBJ2cgVYUbLyypce/ddl2gbfXeU1FOZiVNlA1HLG3lo
 uhkw==
X-Gm-Message-State: AOJu0Yx/TuNHTWF+ZqhprZA0txhclZrOAI55iaalZHWh5l2wF8ps5+JN
 V3qG6pT6iXoMbqX5yl098RtZUxRkoQebM2muL29zMnTxwKc9neCOsHucdAq77sACqmZ7XfM0pMF
 6nYDBd5w=
X-Gm-Gg: ASbGnctUVzwNzDQmpwz/8pSFVmrp8ZX4TiepByeoO6Y8YIOxdgnZY8rzTzbiJXBjnVz
 9HehRrjqIvHrIRcamENCDUJH6GNI9cntimFkiXxkHFXRlvgiE9YMbLdnWSAcNE+R64fANGaOfyU
 4Oqy5UrCT5jMojZijmSU1+2Opja3aO0UN5m5tKvDqmIlsDeRaBxuo/XErBdAqXSeNj9CyQSsxZH
 cOt0JQXx8Y5cxpMYBijaAVlDBFTnysIBmaO/CPN+IY31ua61eWNVuH9C74F7xry4jxc8LnQbfkb
 KW3jD9fdnqHx6kTLPP0i1yUJmYVn8ob0UDPXpjox7jvZ7UQEnEx0PX9v46b6N1AcLK01d6lBXOs
 /+4baWWWyhXlN4G/u/GhXmpKEs8wIY8VjJ8XQaBVKqTwaDfGLRnHwt+w6S/payM19Ri+DyedLYC
 r8mJxpnG8=
X-Google-Smtp-Source: AGHT+IEdfjJblnOldJkH6fLe9Qi5fP1TuUCXHGlO3YEW8NIom8f8JUiORAArwcVBdicVFmb10ZKFAA==
X-Received: by 2002:a05:600c:4683:b0:45b:83fe:9cf7 with SMTP id
 5b1f17b1804b1-45ddde95a94mr9680615e9.6.1757135911124; 
 Fri, 05 Sep 2025 22:18:31 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 11/11] accel/tcg: Remove tb_flush
Date: Sat,  6 Sep 2025 07:18:20 +0200
Message-ID: <20250906051820.160432-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

All uses have been replaced with tb_flush__exclusive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tb-flush.h | 19 ++++++++-----------
 accel/tcg/tb-maint.c    | 22 ----------------------
 2 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
index f3898d1826..d6586b9d5f 100644
--- a/include/exec/tb-flush.h
+++ b/include/exec/tb-flush.h
@@ -9,21 +9,18 @@
 #define _TB_FLUSH_H_
 
 /**
- * tb_flush() - flush all translation blocks
- * @cs: CPUState (must be valid, but treated as anonymous pointer)
+ * tb_flush__exclusive() - flush all translation blocks
  *
- * Used to flush all the translation blocks in the system. Sometimes
- * it is simpler to flush everything than work out which individual
- * translations are now invalid and ensure they are not called
- * anymore.
+ * Used to flush all the translation blocks in the system.
+ * Sometimes it is simpler to flush everything than work out which
+ * individual translations are now invalid and ensure they are
+ * not called anymore.
  *
- * tb_flush() takes care of running the flush in an exclusive context
- * if it is not already running in one. This means no guest code will
- * run until this complete.
+ * Must be called from an exclusive context, e.g. start_exclusive
+ * or vm_stop.
  */
-void tb_flush(CPUState *cs);
-
 void tb_flush__exclusive(void);
+
 void tcg_flush_jmp_cache(CPUState *cs);
 
 #endif /* _TB_FLUSH_H_ */
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index d1695be00b..0fe7a0de8a 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -778,28 +778,6 @@ void tb_flush__exclusive(void)
     qemu_plugin_flush_cb();
 }
 
-static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
-{
-    /* If it is already been done on request of another CPU, just retry. */
-    if (tb_ctx.tb_flush_count == tb_flush_count.host_int) {
-        tb_flush__exclusive();
-    }
-}
-
-void tb_flush(CPUState *cpu)
-{
-    if (tcg_enabled()) {
-        unsigned tb_flush_count = qatomic_read(&tb_ctx.tb_flush_count);
-
-        if (cpu_in_serial_context(cpu)) {
-            do_tb_flush(cpu, RUN_ON_CPU_HOST_INT(tb_flush_count));
-        } else {
-            async_safe_run_on_cpu(cpu, do_tb_flush,
-                                  RUN_ON_CPU_HOST_INT(tb_flush_count));
-        }
-    }
-}
-
 /* remove @orig from its @n_orig-th jump list */
 static inline void tb_remove_from_jmp_list(TranslationBlock *orig, int n_orig)
 {
-- 
2.43.0


