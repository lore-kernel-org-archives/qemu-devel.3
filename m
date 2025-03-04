Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3ECC282D3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaia-0007eL-Ig; Tue, 04 Mar 2025 17:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpahF-0005T2-5N
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:09 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpahA-0006ZQ-Fi
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:03 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-abf3cf3d142so560528966b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127095; x=1741731895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3uOOlAeKCJac1lfZ8pMilX54y2FsqgRLkG3Q0WCNcI=;
 b=VfY4TaqosyYOcfSNOqmnNoQ6Jl0SoUx3AM9LAnYw4F2oKaTIL0J09AbKBnp/IRHDSg
 BXvT6HYpEaKZwxfqDDKazlxEATVGK2VrFTGvydyZGvh1W5tNuaoa7K9iJfp1Of1vlePm
 99ujkARQBmFIyQbjFFFMehCmHnxiWvPsRREv8C2i4q5l+XD3GdPikJzWBiHTfnhD7HjQ
 GKm7q2fbGq6YujxYIMTiATHQX7qYHlPgqXM22vHZhn46MLgJQju5iBPl5y3WgaLPeJ/r
 h9fR+N/gHv5Q5TL3Dw7ufISYqzp4BRBy791ikEszidJkxvKsoog0r6td68D1yQR4ci2b
 dDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127095; x=1741731895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3uOOlAeKCJac1lfZ8pMilX54y2FsqgRLkG3Q0WCNcI=;
 b=eJ8CGMkxD5IB8iOksUjhkVoLImKsEHayeMX+rqxw7rhKdh7JaMXkxwsmAkEHAWBTjD
 mEG3xB4HJn8V9/qW8ahYERaBkJXd35I4GK2pXp6avS6TkjFXZKUoyYBEZm8YGi+/Gby8
 lj0P8MWPL2V2Fb/JPpdqRmpSzaeYo9pkgc1e2F3xrfqvyo3RR3ghFJUJQz1K8amTZKfX
 kzM4ImOAx96JbAROXrkZimH2AsGCHC/GRVXpRhl5sZoIeXFDJ7epg9lwIO72f/NAZWHg
 0/IJmwbt00PWmzj2JVhElF8rRYBq+PbwzVHmRni11Q2v/C10X2ebNu8DZFOxVeLcYQK6
 FtAg==
X-Gm-Message-State: AOJu0YybaqrbJUwZ4AfzanTG9iZ8G24OKtARIhi48noXqSfqNwvSlXWW
 YfxZcP86THUjfhwQ/r8I6tjncrBDFpW62Nr7lKOJd2HJOSoQTUVRJy3dhz7wT/U=
X-Gm-Gg: ASbGnct+Zr7U/5IdteXDVHo2o3MqeIKJhfzEdNe4XXRFHlnOBzHnRconOKsQoS6QSml
 Mye1IHIBCW7bxSVbVWvAVacNahCRw1tI1QvWDj+6/lywVrgY4SmDhjBu6taxejPhKpYm6bYeqRj
 4XePkcysBMiGhFJS388fOp61vKnzGKo4752Jehq+9Sx0/ECbj5TGVHlvJyh6z8FlNmYsbUrjPst
 axU1jOYiuw7S7FO8JCmhkIwi1Ko6WH1t+uF3U/+TMVID6flmykGJGeRllZfTuQ/a+bTlmw45/k7
 yrbO3abbeQvej5hr3mDx5hh2nfvlpOotfzo8Rqovnag02cs=
X-Google-Smtp-Source: AGHT+IGaadTtLa+efPVTRVGNMcZ9/hVpc+7WylVY+IrrVajvic6aMQWZRncktVfBbR2ONsLp91l5pg==
X-Received: by 2002:a05:6402:2114:b0:5de:a6a8:5ec6 with SMTP id
 4fb4d7f45d1cf-5e59f3d3780mr1642524a12.10.1741127094677; 
 Tue, 04 Mar 2025 14:24:54 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf6166d3f7sm583129566b.57.2025.03.04.14.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3E0AC625E2;
 Tue,  4 Mar 2025 22:24:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 28/32] plugins/api: split out time control helpers
Date: Tue,  4 Mar 2025 22:24:35 +0000
Message-Id: <20250304222439.2035603-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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


