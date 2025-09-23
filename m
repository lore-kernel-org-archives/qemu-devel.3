Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94A7CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ay8-0006L4-FZ; Tue, 23 Sep 2025 17:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay4-0006KE-Pq
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:37 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay2-0003jC-SD
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:36 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-279e2554b6fso21093095ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758664473; x=1759269273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H70urNHQexc8XRiqcQIbAPa7e6Ad5kGXAtjgrs13aaQ=;
 b=xeSp5pi9r4tp+K8RQupdFZPEkZ05QFJ2wslvv4ltkNpFZAf0UXY0raacdD94cye8pq
 eoLMkh6cKpR6iRtPiZqo8nymCz6IvGWn+xUiztEhGBMNXqLAZm443+qjQkJIx6ISWOOH
 G86LN/SZ5/PW13dmCOod4IQuycFgvKUPABINTpvqJt+3BsQwMpVa8Of6eZCItXTXCvRI
 qbhmyDyLrnMshnWSr+4ff51vC1oLxEG0m1bI0QhBQEWaUQSeGeB+12XkRLdKVg4xdkra
 AH34NpXhg789oBdgsJvOI3K9cm7nZBiRtpWvkdFYMkwQLU7/ZVLU0c10x9ci/GhiSb6W
 wMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758664473; x=1759269273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H70urNHQexc8XRiqcQIbAPa7e6Ad5kGXAtjgrs13aaQ=;
 b=tmg0Rx997XaKva0L/qta7XHsOJtC3/apFnntIoSbhWiLtjLrmgR92xpPQhwG/eGzMz
 KMso17eW+1uY646k52Ik74gfZOBVgGRKbP7Kbzb9ifHj+sdpfF08b+69XYBxLbkSE7rT
 N5CcSzZ33MAe0v8iV9VLzs2FdWw/R/aLu0AsvMXRp9D+mj5KAsOf4DGKZLXuDX/7S81w
 CVVZvZ3KmAZKTcD2J8fh2/ToqtY6lKDd5lnzV5ZhSV7BI8pEzvxyFOUMblRzAoHffBYv
 fkVOYFlWhqCijc7GYUFDnLoPphZFLMImAk5iJuYC/Y92vzhEe/D+L6prMBdLkdokVtRt
 e7rA==
X-Gm-Message-State: AOJu0YykRZ2PjxIoGVIGCAI5YgTs+anYCQXvSD9VdDjem1GjzyNDUQ/X
 KFL7AHUv9a9Dn2i8Q6oYao2aXLhUh4U+05BVVsmvX+4T75Q5VwaklfGaNbUkPCqT7ViB+7bXS0s
 Pi4Hc
X-Gm-Gg: ASbGncvao3NorhEcztV5Pp+JpawPTPZZbbRTi0bT7NtH5/53YDVKWI2VVgQyw3iVa8r
 3efjM/HdGph664V21aI87N8tXPaj9kztkLI2QqRfxpRHWxm4ugdVr/8sLMzVrp/6aRsaVvfW2iD
 ooRSqTcW+l/dmjpQumXAKwC/dxd3l4tW23O+oUM5v6qrq9CEkko8cvQK1CvSHM5qzNAD5uhl+Ge
 wSjR/oHJnG9e0lZt9zHn52j/GopCY7oPP1AL7as8oGMH2Juadv5/sAcAJGEGTFoljQnVIjrrV9k
 A4AEmW0WYtvvak9sOj6JJyxftUi4HGt0+yeA95Ij5J62PQFWY70zv4a69vbEyQ4Q+eTzGe9HmB2
 dt1cAkC5ePJiwe0ZDvgfk9OLlsszg
X-Google-Smtp-Source: AGHT+IE4VnkWCZPZB5EluoVwlER8YTxdkUD+SnXUSxSQZpZHz1svfYsZXI8xOLj77okZbqgJnvxjGA==
X-Received: by 2002:a17:902:ce0a:b0:27b:472e:3a23 with SMTP id
 d9443c01a7336-27cc1858b01mr48890545ad.14.1758664473543; 
 Tue, 23 Sep 2025 14:54:33 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802e14f1sm168294035ad.71.2025.09.23.14.54.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 14:54:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/10] accel/tcg: Create queue_tb_flush from tb_flush
Date: Tue, 23 Sep 2025 14:54:23 -0700
Message-ID: <20250923215425.3685950-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923215425.3685950-1-richard.henderson@linaro.org>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Rename the function and remove the path which
performs the flush immediately.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tb-flush.h   | 17 ++++++-----------
 accel/tcg/tb-maint.c      | 11 +++--------
 accel/tcg/translate-all.c |  2 +-
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
index 090ffc8818..e971d4ba6d 100644
--- a/include/exec/tb-flush.h
+++ b/include/exec/tb-flush.h
@@ -24,19 +24,14 @@
 void tb_flush__exclusive_or_serial(void);
 
 /**
- * tb_flush() - flush all translation blocks
- * @cs: CPUState (must be valid, but treated as anonymous pointer)
+ * queue_tb_flush() - add flush to the cpu work queue
+ * @cs: CPUState
  *
- * Used to flush all the translation blocks in the system. Sometimes
- * it is simpler to flush everything than work out which individual
- * translations are now invalid and ensure they are not called
- * anymore.
- *
- * tb_flush() takes care of running the flush in an exclusive context
- * if it is not already running in one. This means no guest code will
- * run until this complete.
+ * Flush all translation blocks the next time @cs processes the work queue.
+ * This should generally be followed by cpu_loop_exit(), so that the work
+ * queue is processed promptly.
  */
-void tb_flush(CPUState *cs);
+void queue_tb_flush(CPUState *cs);
 
 void tcg_flush_jmp_cache(CPUState *cs);
 
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 7be9a1c4de..5b1a5b599e 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -797,17 +797,12 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     }
 }
 
-void tb_flush(CPUState *cpu)
+void queue_tb_flush(CPUState *cs)
 {
     if (tcg_enabled()) {
         unsigned tb_flush_count = qatomic_read(&tb_ctx.tb_flush_count);
-
-        if (cpu_in_serial_context(cpu)) {
-            do_tb_flush(cpu, RUN_ON_CPU_HOST_INT(tb_flush_count));
-        } else {
-            async_safe_run_on_cpu(cpu, do_tb_flush,
-                                  RUN_ON_CPU_HOST_INT(tb_flush_count));
-        }
+        async_safe_run_on_cpu(cs, do_tb_flush,
+                              RUN_ON_CPU_HOST_INT(tb_flush_count));
     }
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d468667b0d..31bc0f8bc5 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -289,7 +289,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(!tb)) {
         /* flush must be done */
-        tb_flush(cpu);
+        queue_tb_flush(cpu);
         mmap_unlock();
         /* Make the execution loop process the flush as soon as possible.  */
         cpu->exception_index = EXCP_INTERRUPT;
-- 
2.43.0


