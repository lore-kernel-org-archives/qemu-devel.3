Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BB0C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgmg-0006oS-VV; Mon, 24 Jun 2024 06:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmf-0006ny-Ms
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:49 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgma-0007h7-T0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:49 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a72517e6225so105985666b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224323; x=1719829123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14X8Z5in8w/+qtjupg5LlJdeob+7lldC0gA0O0WPJcM=;
 b=YflQOG2zDMvd5SmwDM311boRCpgJM33X1B8dYsLk0VIQEVxa2hDcPhezXG0Prde634
 g8TxQwpIZURzAQrDR7vgYLKtxMMcbKWJ80DXB7Wgs1cAUox3WMf2Keo4FJwr5Tctt2Jn
 dF5K/M9tcASadcjZcKPdZ9Xp61R+WTQbbPqWo4bRLeTaJ4+ClRQASzoOkeFx9VL7a6jk
 2PG6/6MS+BZggq+MP5HOzefccvybXI3PmbMI/cupO7eVOsOWln4oz5VdM5+sfwgq2yqw
 8n/fFbFQWfTxhtwmSJXC2O91i/2wzb+OWL7Gv+b6tWTiyH3zB383G5BGqq53HzOmaAuy
 fyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224323; x=1719829123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14X8Z5in8w/+qtjupg5LlJdeob+7lldC0gA0O0WPJcM=;
 b=q/FDvF/tmsoFKpO2YU1Xs8FVUs7Dda8MysVhZ5L2Q1r9LEq3scmO4xiU7/oiF/yMSn
 RnZP4WUuKF4RhUJaH8kOe7OYt27AFyhdjxklvDFBgs62HBThKEguol7olnm3YMXqoH+x
 M3kIKU0xpqi0J3LXYE0qf9kDXuMft10pgPEnQg7Xx8l+gjSCd7/j1Sh6kFxW2S1U7BK/
 ytsBXoHZ2wiCVyS8qglUzhME6aGxSqQFRql5RcvDKA/oOnLmWSPn8jwp0Rqt9ayypyNU
 2aFfd/GMsYNakN5crFjkRV9wgk/vtlSzCLMvyZUKPRFp0PnUah7ElD4nl5AVEZiTAmx8
 Vxgw==
X-Gm-Message-State: AOJu0Yx8rT+ymHBcMc5KoTWxq4pLk31odS7ikalCdeyq6memT/lK7Sxy
 gcWhqp+j98EqtBWSvsin1360Qq820uY+8IjGWFOWuCoUFeidDZ+352zMxwGzj3U=
X-Google-Smtp-Source: AGHT+IGVO5Y/HcdTHQZaaQAt1MAV4iUiwO7x4lDbbA68PQqVAMTVJfKADt52/9q2HTfGNGvPN6IU9g==
X-Received: by 2002:a17:907:a806:b0:a6f:ba92:53ca with SMTP id
 a640c23a62f3a-a715f390c1bmr357848966b.21.1719224323238; 
 Mon, 24 Jun 2024 03:18:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fe81449a4sm263361266b.72.2024.06.24.03.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:18:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2361A5FA2A;
 Mon, 24 Jun 2024 11:18:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 08/12] plugins: add time control API
Date: Mon, 24 Jun 2024 11:18:32 +0100
Message-Id: <20240624101836.193761-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624101836.193761-1-alex.bennee@linaro.org>
References: <20240624101836.193761-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

Expose the ability to control time through the plugin API. Only one
plugin can control time so it has to request control when loaded.
There are probably more corner cases to catch here.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
[AJB: tweaked user-mode handling, merged QEMU_PLUGIN_API fix]
Message-Id: <20240530220610.1245424-6-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240620152220.2192768-9-alex.bennee@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 95703d8fec..c71c705b69 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -661,6 +661,33 @@ void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
     qemu_plugin_u64 entry,
     uint64_t imm);
 
+/**
+ * qemu_plugin_request_time_control() - request the ability to control time
+ *
+ * This grants the plugin the ability to control system time. Only one
+ * plugin can control time so if multiple plugins request the ability
+ * all but the first will fail.
+ *
+ * Returns an opaque handle or NULL if fails
+ */
+QEMU_PLUGIN_API
+const void *qemu_plugin_request_time_control(void);
+
+/**
+ * qemu_plugin_update_ns() - update system emulation time
+ * @handle: opaque handle returned by qemu_plugin_request_time_control()
+ * @time: time in nanoseconds
+ *
+ * This allows an appropriately authorised plugin (i.e. holding the
+ * time control handle) to move system time forward to @time. For
+ * user-mode emulation the time is not changed by this as all reported
+ * time comes from the host kernel.
+ *
+ * Start time is 0.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_update_ns(const void *handle, int64_t time);
+
 typedef void
 (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
                                  int64_t num, uint64_t a1, uint64_t a2,
diff --git a/plugins/api.c b/plugins/api.c
index 6bdb26bbe3..4431a0ea7e 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -39,6 +39,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
+#include "qemu/timer.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
@@ -583,3 +584,37 @@ uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry)
     }
     return total;
 }
+
+/*
+ * Time control
+ */
+static bool has_control;
+
+const void *qemu_plugin_request_time_control(void)
+{
+    if (!has_control) {
+        has_control = true;
+        return &has_control;
+    }
+    return NULL;
+}
+
+#ifdef CONFIG_SOFTMMU
+static void advance_virtual_time__async(CPUState *cpu, run_on_cpu_data data)
+{
+    int64_t new_time = data.host_ulong;
+    qemu_clock_advance_virtual_time(new_time);
+}
+#endif
+
+void qemu_plugin_update_ns(const void *handle, int64_t new_time)
+{
+#ifdef CONFIG_SOFTMMU
+    if (handle == &has_control) {
+        /* Need to execute out of cpu_exec, so bql can be locked. */
+        async_run_on_cpu(current_cpu,
+                         advance_virtual_time__async,
+                         RUN_ON_CPU_HOST_ULONG(new_time));
+    }
+#endif
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index aa0a77a319..ca773d8d9f 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -38,6 +38,7 @@
   qemu_plugin_register_vcpu_tb_exec_cond_cb;
   qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_tb_trans_cb;
+  qemu_plugin_request_time_control;
   qemu_plugin_reset;
   qemu_plugin_scoreboard_free;
   qemu_plugin_scoreboard_find;
@@ -51,5 +52,6 @@
   qemu_plugin_u64_set;
   qemu_plugin_u64_sum;
   qemu_plugin_uninstall;
+  qemu_plugin_update_ns;
   qemu_plugin_vcpu_for_each;
 };
-- 
2.39.2


