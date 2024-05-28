Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B863DC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByJT-0000id-VI; Tue, 28 May 2024 11:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJS-0000i7-9z
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:30 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJN-00078d-As
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:26 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a5d67064885so146589566b.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716908424; x=1717513224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWF1+LjOwHyVGVJbyrAhhwZo8V1u6vIK8N/LCyR6jZU=;
 b=l95LtmX4tXNiOC0AGpE+akSLkmuDfud8vzNpnGwt1uaFbfHBN0yEC2XvLdrScqgwft
 Jsw0j4+1Cln8ip7Ewou7S8IycRdtVvCM6deHucg6XW2CLmtXY7yyQ4041o77aWPBdlu5
 z3MPKHkVddrmeRrJcpWfOFHv0gYD3z8ZqYyk2DnH1tE250smyCq6vwK5B+1U4Wty5rH8
 Nm05p9C1KPittcbaZiomwTNeoi1umB6AbSWdr19Obtklg7uatHnUmpIe3V6Ti0YgZCON
 OLBiPdMMb0P76LmcSjbG9JgOsKRKbePuq1hcyCbdnxPGWx3t2GpNvaUVAmH1231kQEhC
 ADaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716908424; x=1717513224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWF1+LjOwHyVGVJbyrAhhwZo8V1u6vIK8N/LCyR6jZU=;
 b=eFBi3zAEHiSgFxzx+dOphbvVDKT7Aj9OOrW3Eaq+bxLyu2lR1EqP1ZX4Yl+R+0y+9s
 QPpuGJhnotEcJZIIyaVlAZ2GYdzWEmBBxsULOglHbXHDLbhOhA/5BIfekTIWjSSnjeCQ
 gLSMC61jojpbMqaxFgm3KFuk82h0jSjuPjce5voAODQCVsioG1l+KeyvUba30hG4sBsK
 gOGpn9z+x4nBQfbgx5+HC330ph+zLBZsAa65jxRRmzCNch2JrGNdAWyyYTRZX7H5Rx8x
 spKYEbGqsCvUdMQZmdrBFpb+tcmFo6qaPxXgIOdnViZbjpOoGlymatjJh27xJTzCXMjy
 /iaA==
X-Gm-Message-State: AOJu0YxI4ys1zxzL37w8QQH4KfMOhmRFwYk9tL5VWzJqgXlUs36NAW8z
 xu1aly5aANTG0VQkHgK4TGeB3vYCqPe2lWGXzSus1unnAX9q7qQRLmYTxjayc1uOVvGL6VgxNzX
 Z
X-Google-Smtp-Source: AGHT+IHNWTrI15G1eDqVz+vxK3M+54ElXygz0ON5eJNwThgTMQ1Qg87WnCbKBBDnUrmkqXYTT8u11w==
X-Received: by 2002:a17:906:5784:b0:a63:7efd:8ec8 with SMTP id
 a640c23a62f3a-a637efd9bb7mr8040066b.70.1716908423651; 
 Tue, 28 May 2024 08:00:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.214.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c97a1fbsm620973466b.92.2024.05.28.08.00.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 08:00:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 5/6] accel: Restrict TCG plugin (un)registration to TCG accel
Date: Tue, 28 May 2024 16:59:51 +0200
Message-ID: <20240528145953.65398-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240528145953.65398-1-philmd@linaro.org>
References: <20240528145953.65398-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use the AccelClass::cpu_common_[un]realize_assigned() handlers
to [un]register the TCG plugin handlers, allowing to remove
accel specific code from the common hw/core/cpu-common.c file.

Remove the now unnecessary qemu_plugin_vcpu_init_hook() and
qemu_plugin_vcpu_exit_hook() stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h |  2 ++
 include/qemu/plugin.h       |  6 ------
 accel/tcg/cpu-exec-common.c | 27 +++++++++++++++++++++++++++
 accel/tcg/tcg-all.c         |  2 ++
 hw/core/cpu-common.c        | 25 -------------------------
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index ec2c6317b7..d900897c6e 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -54,6 +54,8 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc);
 
 bool tcg_exec_realize_unassigned(CPUState *cpu, Error **errp);
+bool tcg_exec_realize_assigned(CPUState *cpu, Error **errp);
+void tcg_exec_unrealize_assigned(CPUState *cpu);
 void tcg_exec_unrealize_unassigned(CPUState *cpu);
 
 #endif
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index bc5aef979e..d39d105795 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -221,12 +221,6 @@ static inline int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
     return 0;
 }
 
-static inline void qemu_plugin_vcpu_init_hook(CPUState *cpu)
-{ }
-
-static inline void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
-{ }
-
 static inline void qemu_plugin_tb_trans_cb(CPUState *cpu,
                                            struct qemu_plugin_tb *tb)
 { }
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index bc9b1a260e..3c4a4c9f21 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -56,3 +56,30 @@ void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
     cpu->exception_index = EXCP_ATOMIC;
     cpu_loop_exit_restore(cpu, pc);
 }
+
+#ifdef CONFIG_PLUGIN
+static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
+{
+    qemu_plugin_vcpu_init_hook(cpu);
+}
+#endif
+
+bool tcg_exec_realize_assigned(CPUState *cpu, Error **errp)
+{
+#ifdef CONFIG_PLUGIN
+    cpu->plugin_state = qemu_plugin_create_vcpu_state();
+    /* Plugin initialization must wait until the cpu start executing code */
+    async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
+#endif
+
+    return true;
+}
+
+/* undo the initializations in reverse order */
+void tcg_exec_unrealize_assigned(CPUState *cpu)
+{
+#ifdef CONFIG_PLUGIN
+    /* Call the plugin hook before clearing the cpu is fully unrealized */
+    qemu_plugin_vcpu_exit_hook(cpu);
+#endif
+}
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c08a6acc21..a32663f507 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -228,6 +228,8 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
     ac->cpu_common_realize_unassigned = tcg_exec_realize_unassigned;
+    ac->cpu_common_realize_assigned = tcg_exec_realize_assigned;
+    ac->cpu_common_unrealize_assigned = tcg_exec_unrealize_assigned;
     ac->cpu_common_unrealize_unassigned = tcg_exec_unrealize_unassigned;
     ac->allowed = &tcg_allowed;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 0f0a247f56..fda2c2c1d5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -30,9 +30,6 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
-#ifdef CONFIG_PLUGIN
-#include "qemu/plugin.h"
-#endif
 
 CPUState *cpu_by_arch_id(int64_t id)
 {
@@ -192,13 +189,6 @@ static void cpu_common_parse_features(const char *typename, char *features,
     }
 }
 
-#ifdef CONFIG_PLUGIN
-static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
-{
-    qemu_plugin_vcpu_init_hook(cpu);
-}
-#endif
-
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
@@ -222,14 +212,6 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         cpu_resume(cpu);
     }
 
-    /* Plugin initialization must wait until the cpu start executing code */
-#ifdef CONFIG_PLUGIN
-    if (tcg_enabled()) {
-        cpu->plugin_state = qemu_plugin_create_vcpu_state();
-        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
-    }
-#endif
-
     /* NOTE: latest generic point where the cpu is fully realized */
 }
 
@@ -237,13 +219,6 @@ static void cpu_common_unrealizefn(DeviceState *dev)
 {
     CPUState *cpu = CPU(dev);
 
-    /* Call the plugin hook before clearing the cpu is fully unrealized */
-#ifdef CONFIG_PLUGIN
-    if (tcg_enabled()) {
-        qemu_plugin_vcpu_exit_hook(cpu);
-    }
-#endif
-
     /* NOTE: latest generic point before the cpu is fully unrealized */
     cpu_exec_unrealizefn(cpu);
 }
-- 
2.41.0


