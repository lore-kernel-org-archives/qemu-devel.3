Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7815C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJcW-0005xI-3b; Thu, 20 Jun 2024 11:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcU-0005uc-PC
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:38 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcR-000801-Kf
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:38 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6f1da33826so130637966b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718896954; x=1719501754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bnw8wtrxQn8og2FDwWWp7AmT3nbEagSCExx0Sw+yVA=;
 b=ukhJ2k9nXkE8KQXr1cJY6xkgU8hcFQKG7rpHvUtxqb0CjsxZVKybF6Z+LKvcYfU3FD
 qW8p1p6UFStWu/vhN4vVWd/uKbqEcazAyf937fBtmw6FVq6ARjFvsyMTuOj0k5sKmb/z
 TEqS+T12i9Vo33OC7oEJ9XUWLFxOYN6byY5aGkUlJqu4lx0Euw/Fo4pf/JzPs6nuQ94l
 sKD3ZO0yqmRNo8KVmBekoGYxIaephoTm0p2n5JmcUZGVpz+zsrlV4MXmzLqMcvnGy7il
 gRnLuXpIafgsHlvgyX3qXONbz5Fe4iJlAkuuMJ3EHTx8fxV5VNqHxRkEZKVg4vCfHRF3
 ciBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896954; x=1719501754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bnw8wtrxQn8og2FDwWWp7AmT3nbEagSCExx0Sw+yVA=;
 b=WXCxBSAk3rkCaeIRLAszZMdfzNuLQDPJNmDrrce/HLU+gulb0sYbkGXqVAMcZiE87m
 KttYaLxVvpkm/PlYMiVFMwF765W79oEpKa/TU9b+7UBjn5vFrRoKyqXPI30Z3NBUYx6J
 J51U7vgZ9UwhyaDjHdorsp/A218PQmhDMeRAEM1XqvaHKDY7krUt9L9fzszsCK7veX4d
 Owl6X2yzSN0PQx9TymM5Z3AUGMTt084RPFKOQWj4w/bB/x2CFr6+XejBYPPlgZ160xD0
 gSW7kGm3+AH9J0/HSE8riKahudfX5cS2sT/Oo6vPqLfTtld7bgDfidxTDTe8UU7uIzMd
 7UPg==
X-Gm-Message-State: AOJu0YyohEur9KFhmQB5WIJWJKnOQrt1GFPuQRouXPI57TPyd8Rbc2N/
 qCS7Ts52oGyhI6ksepF4/nVCCOujxUU05SEUJc25Cw9RvM4NvorqAIqUa/aHy74=
X-Google-Smtp-Source: AGHT+IH2DovLg9WwgVHZUoNTkAIC+HvMNQYXd4BSqH/mpbcJPFM2PUXUQxyUB+bFIycF54XbJ/zPYg==
X-Received: by 2002:a17:907:a787:b0:a6f:ad2f:ac4b with SMTP id
 a640c23a62f3a-a6fad2fad01mr374136066b.2.1718896953649; 
 Thu, 20 Jun 2024 08:22:33 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db5b98sm774609266b.86.2024.06.20.08.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 08:22:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CDBB15FA06;
 Thu, 20 Jun 2024 16:22:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Nicholas Piggin <npiggin@gmail.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/12] plugins: add time control API
Date: Thu, 20 Jun 2024 16:22:16 +0100
Message-Id: <20240620152220.2192768-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620152220.2192768-1-alex.bennee@linaro.org>
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240530220610.1245424-6-pierrick.bouvier@linaro.org>

---
plugins/next
  - make qemu_plugin_update_ns a NOP in user-mode
v2
  - remove From: header
  - merged in plugins: missing QEMU_PLUGIN_API for time control
---
 include/qemu/qemu-plugin.h   | 27 +++++++++++++++++++++++++++
 plugins/api.c                | 35 +++++++++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  2 ++
 3 files changed, 64 insertions(+)

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


