Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F82C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI1z-00025D-OO; Wed, 26 Feb 2025 09:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI1M-0001Dq-6q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:23 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI1F-0005qZ-EE
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:17 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43989226283so47091945e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578649; x=1741183449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3uOOlAeKCJac1lfZ8pMilX54y2FsqgRLkG3Q0WCNcI=;
 b=ntEWogRFVmn8tSKvkSTwriYCHQoGwBbtQzk+XS5r/ADe5EhM0rYB2KPP30wy7HFUfi
 2Xc6zqEiILcnbIzKy3koyTBB6oWWpDy7DlW1ePlKuNiGWSahAUzK6bqpdtb5WfBi+Gtc
 r7dPzSthYkjvnlzu8yETZouhoR5xTiOqgrS9phyJQQwjv6j259MUbqXz2ygCITFCSpJH
 te7dKkDq1+ldhfJ9qpjBS+ea0vHN6+QAexBTJPdUeFmORlfTnAJgOTeREabK821BZL9Z
 tmX3mzN01gtgRRqUmApCJrEYWTPJ1OOJmBGKwhQ6NRAGfHo173lFoBuyI6gL28fgmwVW
 xOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578649; x=1741183449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3uOOlAeKCJac1lfZ8pMilX54y2FsqgRLkG3Q0WCNcI=;
 b=ZuhbjRKyFtDElhn2I98H2GyT9vw/Ycu3BVwab7U803LQpWMt6USSz0JziovDpToiQS
 HPo5PESgMCYX3agLYKnXZIY673C6w+RDcvtfTLrkZNc3baEAj9rWGVxzKDibkBUd5rWB
 jmSYjq+Yvglzxsm7Ox2uPawwQKFM5OQ9tJakwUSjfWL/1D+3Sjp0KkVWvllXl7B442uU
 mYwfAaRncywj1jsZoDxlrTvlx982fFUC8yzTux1B+JoYMHZF7iF7qu0/hLoNhnxzvp4b
 P2UdIxmBwi+Ef7r4kfsRGCETOZY0Irk21/qCnqu/NFrbTU0ffiKdq/p19Rd+6+87QtpW
 0epw==
X-Gm-Message-State: AOJu0YwS30gIXf4ptE2B49FmPYaoMEoDdtYXvXpSU7FQFOutpXz28ycK
 QQIEP2DTE8B3G/7AGO+Q8a3UcLnrLPgkOGzKVdXEMLGtq281mtKQRmdJvZlL8DQ=
X-Gm-Gg: ASbGncscWhWnsDS0d4JbAi9jp26fv6hqxIT2zWanQbH6b8h2423cNRufvCInHmFwUlU
 yvrVgoBEiUHJxvRm+CQD78bOZGFl2r5KpwMAwKkyqhvf8VCSckNiaUt67NY9TZPZ9DN25HoaHn+
 xnhYUBkH7ZU1rGICtvo/hmNKvz7RyCScSoCiytS1fUFpyXIxxPMcbc1dSSPhMC3rh/qxr2RUMuc
 ztUuhFVih22Lz9z9Bv5G38kqecz7jBNUTl1TaFciYnwevp2mYWZgmVdA9FGBnyYZL+hbhodHCSY
 nyXAYEXNR6V0KTYaztM6gZIDrwsa
X-Google-Smtp-Source: AGHT+IF8NulBNBahVpJJW0ZPTOINlMChCVCOta14Z1oqxQC08yOAIUKIrVUeowIUhMlvEOeDIdOfHw==
X-Received: by 2002:a5d:5849:0:b0:390:df7f:c20a with SMTP id
 ffacd0b85a97d-390df7fc33bmr583361f8f.33.1740578648457; 
 Wed, 26 Feb 2025 06:04:08 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390dfab57b9sm371164f8f.68.2025.02.26.06.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:04:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 36ECE601A1;
 Wed, 26 Feb 2025 14:03:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 23/25] plugins/api: split out time control helpers
Date: Wed, 26 Feb 2025 14:03:41 +0000
Message-Id: <20250226140343.3907080-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

These are only usable in system mode where we control the timer. For
user-mode make them NOPs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250225110844.3296991-10-alex.bennee@linaro.org>
---
 plugins/api-system.c | 34 ++++++++++++++++++++++++++++++++++
 plugins/api-user.c   | 17 +++++++++++++++++
 plugins/api.c        | 41 -----------------------------------------
 3 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/plugins/api-system.c b/plugins/api-system.c
index 38560de342..cc190b167e 100644
--- a/plugins/api-system.c
+++ b/plugins/api-system.c
@@ -95,3 +95,37 @@ const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
         return g_intern_static_string("RAM");
     }
 }
+
+/*
+ * Time control
+ */
+static bool has_control;
+static Error *migration_blocker;
+
+const void *qemu_plugin_request_time_control(void)
+{
+    if (!has_control) {
+        has_control = true;
+        error_setg(&migration_blocker,
+                   "TCG plugin time control does not support migration");
+        migrate_add_blocker(&migration_blocker, NULL);
+        return &has_control;
+    }
+    return NULL;
+}
+
+static void advance_virtual_time__async(CPUState *cpu, run_on_cpu_data data)
+{
+    int64_t new_time = data.host_ulong;
+    qemu_clock_advance_virtual_time(new_time);
+}
+
+void qemu_plugin_update_ns(const void *handle, int64_t new_time)
+{
+    if (handle == &has_control) {
+        /* Need to execute out of cpu_exec, so bql can be locked. */
+        async_run_on_cpu(current_cpu,
+                         advance_virtual_time__async,
+                         RUN_ON_CPU_HOST_ULONG(new_time));
+    }
+}
diff --git a/plugins/api-user.c b/plugins/api-user.c
index 867b420339..28704a89e8 100644
--- a/plugins/api-user.c
+++ b/plugins/api-user.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/plugin.h"
+#include "exec/log.h"
 
 /*
  * Virtual Memory queries - these are all NOPs for user-mode which
@@ -38,3 +39,19 @@ const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
 {
     return g_intern_static_string("Invalid");
 }
+
+/*
+ * Time control - for user mode the only real time is wall clock time
+ * so realistically all you can do in user mode is slow down execution
+ * which doesn't require the ability to mess with the clock.
+ */
+
+const void *qemu_plugin_request_time_control(void)
+{
+    return NULL;
+}
+
+void qemu_plugin_update_ns(const void *handle, int64_t new_time)
+{
+    qemu_log_mask(LOG_UNIMP, "user-mode can't control time");
+}
diff --git a/plugins/api.c b/plugins/api.c
index 82241699a5..832bf6ee5e 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -526,44 +526,3 @@ uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry)
     return total;
 }
 
-/*
- * Time control
- */
-static bool has_control;
-#ifdef CONFIG_SOFTMMU
-static Error *migration_blocker;
-#endif
-
-const void *qemu_plugin_request_time_control(void)
-{
-    if (!has_control) {
-        has_control = true;
-#ifdef CONFIG_SOFTMMU
-        error_setg(&migration_blocker,
-                   "TCG plugin time control does not support migration");
-        migrate_add_blocker(&migration_blocker, NULL);
-#endif
-        return &has_control;
-    }
-    return NULL;
-}
-
-#ifdef CONFIG_SOFTMMU
-static void advance_virtual_time__async(CPUState *cpu, run_on_cpu_data data)
-{
-    int64_t new_time = data.host_ulong;
-    qemu_clock_advance_virtual_time(new_time);
-}
-#endif
-
-void qemu_plugin_update_ns(const void *handle, int64_t new_time)
-{
-#ifdef CONFIG_SOFTMMU
-    if (handle == &has_control) {
-        /* Need to execute out of cpu_exec, so bql can be locked. */
-        async_run_on_cpu(current_cpu,
-                         advance_virtual_time__async,
-                         RUN_ON_CPU_HOST_ULONG(new_time));
-    }
-#endif
-}
-- 
2.39.5


