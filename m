Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70913C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsoT-0001eR-6w; Tue, 25 Feb 2025 06:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmso3-0001ZC-PH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:58 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmso1-0007lg-0Q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:55 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4399d14334aso47596725e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740481731; x=1741086531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ziKeGk3G2q0jYp9Ya8g4Y6XfpCIgHNkybpH/GkwKVw=;
 b=B1VoHVdAewwfOFojLzRWPPf7qEtj65m8Gdy0PinuTet4RuTgHsIZRnIYavktqDEPoC
 wM9okPJluDspqVzLMhIryqdcquujbUA4+wLVA0MlrSbrUNBnbBZDTBLY0cZwgNfw3Lct
 JQ2wVmKftCftIAL/GNqMfPqbUO/v9sasnYsdBa31InzZoWJnRRcNopfmO77Zp+mOu4jF
 +eE45uTE3yzMEYmAb8YrNxYljxMa7JPjVPmVR71RDtDyhPTc2A6wszM362UfsxYe3qMz
 nGAFCORzNepsd4ZpQafyzY1TJgiAa23FR/NpJd5Ri3lhPBDCN1iYrcz0l11s57/vVr1X
 hpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481731; x=1741086531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ziKeGk3G2q0jYp9Ya8g4Y6XfpCIgHNkybpH/GkwKVw=;
 b=DlVVpCSkIbUUGPHQ2mU0ZapVguwrgRBcEGzZ15oJY8dCGGPI2e72sAeQrHppHS4OhL
 CTnUK2m8wRSKZTMNnTpjsOfyWIcyGT52tqHoM2RMQq+XQep/kvNWLGegDHlaRW1bNYVN
 IITGJTg/WJ+eeas2Fnm4+dE9835ejY2DP65GMPlEaMj+gMr3t/DmpLWJC1L7507bf+Pl
 LPQXgdMx39xVK2IuIc0C0fctyai4BC7k42HhdzpMKNdWYI8C+que2jGasFuKdSf/jhsR
 dF2/wJie1MsmnLsGkvTaFrzAfAmWja/d2TLpYXzIJb3rqRvNCciMK2SdW7VO9XoqAidT
 dO7w==
X-Gm-Message-State: AOJu0YwuhGuuEh4Kw+a+omKdPQeidUYCA2kGikHkxFQjtApgmbPKgc/P
 OxJOhxcidyr50/11Co10fLX55wSPiAX4rKGP3P1xGS9LNZMKrUjfeuHJN/HHyTs=
X-Gm-Gg: ASbGncuyYYLA+bL6+jOAFVspkX9rE6gnyRo8wIboYmQKYwDCp5hh06ikDBpNB7VqHBH
 nkqQU/AWfft1OLECL0o4fgUEfk2nRzroB9XctHA5jDzXWElOF303pi+JgMzPJufHVQ3M6eD8plr
 wl4mmai7y69TLGq+UGmelrBITqUocSt69KoeX126+7VcRUSf84eyjLaxJDtpYQKwxeZ2wO69WRo
 4LzBKRoS86ItJ+0OV6e/7Hei8ZyzAQkZRgxvfZxtqS2R9Oiboz4m3CnCT/7eB7KZtYpoboJ3Ho9
 jGtEL30vfcJ0ABUyDM+XNKy6f656
X-Google-Smtp-Source: AGHT+IHwpKeNhLi91xir7Xj1HC6TMMummO9qdb3nimGAxEXyWR23Sy02RmFCmzaCJLw+RUpzJDqQZg==
X-Received: by 2002:a05:600c:19c9:b0:439:6a7b:7697 with SMTP id
 5b1f17b1804b1-439ae1f349emr169043775e9.14.1740481731490; 
 Tue, 25 Feb 2025 03:08:51 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f23c2sm138795635e9.17.2025.02.25.03.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:08:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 167FD60346;
 Tue, 25 Feb 2025 11:08:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 09/10] plugins/api: split out time control helpers
Date: Tue, 25 Feb 2025 11:08:43 +0000
Message-Id: <20250225110844.3296991-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110844.3296991-1-alex.bennee@linaro.org>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
index b04577424f..61480d3dc1 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -525,44 +525,3 @@ uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry)
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


