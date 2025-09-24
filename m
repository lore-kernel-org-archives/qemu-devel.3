Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822D0CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UpE-00018C-Lc; Wed, 24 Sep 2025 15:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UmC-000727-Pd
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:42 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UkD-0007w1-IO
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2445805aa2eso1394015ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740490; x=1759345290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXPy0lwHBRb6FevOx1kqDpjbK7cTKLdcdo5VmUcuHXc=;
 b=zW7x234Vb/kFkiVIS/uA9kErtpRypwkmmOsebN6idmDnDHlXmmaws/Ws+QUDQaNWIW
 /JKKIyrJMQGKHebGGNp2SUhwrgJPQ7jS8SVjkb+ML0Co5u/a0rVi9dKKoY6Vqy+kWUh1
 cnzXSISqpOAyHzMp6Jc7BYNF1KPrdGfvpZ/TCnbW/fHjjMrEU8JV5BaqorLw0bYrsl9+
 ip6mG3XQY76hIfvHP+4WEd0zHhigFnWaW6CE4AeN7ICMBwnUNsNIzvrpOV8JmNLmCmVc
 ARb3lIZNZUgfgiDlJ6UoP7D/vsPXLGZHBmp6Hn620zqOiNtQLvyTt4gxiugnEt3nHMWf
 loKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740490; x=1759345290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXPy0lwHBRb6FevOx1kqDpjbK7cTKLdcdo5VmUcuHXc=;
 b=JzJmDgfmcnr760fs099BkDtgFXRe8qBkYueh749msHYsrc7oeGwgGJvm9VwWspN/q+
 OCyqPNEZ1QE3ii/okw/yZ0ELd9tvxdNtQ5PPzdyjE0/FcqnMqS5RNpEhNu6XxEstDr2+
 Fri3I7gDVgLKW0EwRPFMSpoBBJpJLA3XeP7YGBpzTtUu/4fqeQ29o60al0bWnqwfloO0
 HzIVRtMuiQlSaEGahB5d3U8hHc7VObbgBJhcM2cKGtjDm/vl6wZQGUSSDimXvS4BthTu
 Mq9ZilWmW8rFgUfV3YzU0FburPyDNfxKNqUd36Op6m4kCh5U5tWouz930Sptvh30OB6T
 A1Hw==
X-Gm-Message-State: AOJu0YzQym8TECTPy5XyALQHX8ObcZoY1h5z7Ct5HCKEyyN8pH5EP6T7
 wpRr65StE7xztJbIOSMpLCMK4w/OH2RACBvPfUDCYTFRDB6XaJNeLEiGhoxibyl/Ms+22euieAf
 BJENw
X-Gm-Gg: ASbGncvBjGAD90CAtSrldEh5fqWOUuFL/nmus8BOWTTGwyQIjGvEXzL8I4fAB4gNLrR
 uVv0iGt4U7trbaPVP7qxNN/QFfvq0clJU1AnEC2SoFjOnIXirK8BTF1E59Vr7B0m8X7I8URT3IT
 t8F0cslG9n79MFMqmt5LNMXi2QQ5oPDaHXTGwiV3sEheqwB6FaHRMhbEraxus9cp/Lpb34GfhET
 5eormEHb1qp3gxTa6JWo8ZSvIR6t+22K2SB0JU2jGUDW55vxoeTkAB9C94r9z8ym+PGXhfJMq25
 C38eYFYlmjBpwAWUCX7YkhnzPNjg+sP6cGpMsovHfd4O+gkX2lCc82n/qxMuW9tp7/6egjKgsko
 BHzUF523zmWEizT9af3+bYSw8Q/25T1HCMu5pTuQ=
X-Google-Smtp-Source: AGHT+IHCJtuBckeJqt+8ru82tZ2JfM3+Xfhn3kesUZcc4dUuWdGsvLopcXwcMuJ1OBUJo+BomYGs5Q==
X-Received: by 2002:a17:903:2304:b0:266:7871:37dc with SMTP id
 d9443c01a7336-27ed4a7c891mr8126815ad.36.1758740488967; 
 Wed, 24 Sep 2025 12:01:28 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/32] accel/tcg: Create queue_tb_flush from tb_flush
Date: Wed, 24 Sep 2025 12:01:02 -0700
Message-ID: <20250924190106.7089-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index b4566a81d7..c45fd42366 100644
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


