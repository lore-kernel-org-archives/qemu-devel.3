Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393E7C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2Dg-0001yV-PX; Sat, 08 Mar 2025 17:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DT-0001iW-VD
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:23 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DQ-0001vm-T6
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:18 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39143200ddaso58247f8f.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741471215; x=1742076015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfKDPE2ADf1xfgVapevP6D/Chiq1U5Ky1BisB2XM/tE=;
 b=OQSnbxpaNo6dRTk/d+HMm0GFcFPi+2ETWDCXKoUNhpVjVrfK3tMCMi1pMsCmXqfSiz
 AIJsGIpy9rEiQwziJzNF9DYBwL1X9nE0ourrmE3x80vn2ynfVQPWZHGJFSBs2No9EwYB
 UcB3xtsDhZh0jBdpRb+obVFxlytORzGQaZiAIrdXIwP9fxt/jPhJD4doDyfIvdFUemsj
 D+zwd+Ts5uepzVKx0VfycgzJTF8p61Y4l1chgsDcDgny7DDkN0tyMC5lOyDyyQfIsPjS
 +M+v4EAfrFnWcyOX8H2SY9oc43tlGqJwKL8gaRJCRtQ4g6BLubX63TA4ok9sJoBLYkFZ
 P7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741471215; x=1742076015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XfKDPE2ADf1xfgVapevP6D/Chiq1U5Ky1BisB2XM/tE=;
 b=sBrrU2ZXAzn/XoKS5GM6EnaXKvqfOZU7acE1tRlhi6U0viPYHZkANBkEXZKyzYReXI
 Z5EKDgleu+7bxRCknuoNLo3S/6iNkFwUlE00kKbItJpU0LsFhoLidb6g4FV14oufNxec
 mix+Lgvw4HyzhLGGnwuD6EZhNK92cfcIdOB/U7CBOnAHURkAakm6tW84gA5WImLMg5KR
 LTQIEbVO/Ya3tPUffj5h9jO6/vqXE+Q5rRVs5MEvV9dh4XN1zdD3nORx/im80HXDqILX
 k53NRonkzj9rJZUDqhshfpMiiT3/96xuCpoVt8bcYu5tPTRhieFJm4TYupMV5q9zWWgT
 gBGQ==
X-Gm-Message-State: AOJu0YxDW4YYCpy/ct5MhBJhortJhq4RUosG0RDoLP9NZlCDMSpKsmmD
 v2F2iADzd7wahXGW7qGJR5iOqQNnwgTSdHZyZ8Rg4dkX2onZL2xnXQAcno7Td2Y=
X-Gm-Gg: ASbGncvTFEfgjHCfPBk5G+UCnvWe28CHD+HfnUtkhegnzPJxceP72rY7VfxbkIut8TO
 7xwNY1rRvPGFj0mfT6zEvAD0Fiv5RdA1YSK8zS/dQcOzbiGRxPGgggn5bZQHX0LfnI6Syp7L8eM
 uaNZq7GLqvuHJpnaOtEfpn1kOke3D7BMF0TXrvXkC+Pn+pR8fhvAJqq8JnsDqQvB0ugG9OAAPLJ
 uHoWcMoF0Kaa7cEhBD6AdT/2qhrITtTw/dVD0QLxzTQtSxDde37lKFcOFYgchXBXuM1pQQ8EFSm
 nbXqIPYgixxJFL93AEfkzG9/WB4/dAhZJ8DFswCNdQUimyQ=
X-Google-Smtp-Source: AGHT+IHWkz7SEfH+Q+bKlg0z7yiokxqXA5kHU8rbQSlKK8AYa1t+TyZUSaCixmJc5apsW592t06OMA==
X-Received: by 2002:a05:6000:18a3:b0:391:2d8f:dd56 with SMTP id
 ffacd0b85a97d-39132d98ea9mr5175331f8f.29.1741471215104; 
 Sat, 08 Mar 2025 14:00:15 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bee262esm9950035f8f.0.2025.03.08.14.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:00:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E3D760B5A;
 Sat,  8 Mar 2025 21:53:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 28/31] plugins/api: split out time control helpers
Date: Sat,  8 Mar 2025 21:53:23 +0000
Message-Id: <20250308215326.2907828-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

These are only usable in system mode where we control the timer. For
user-mode make them NOPs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-29-alex.bennee@linaro.org>

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


