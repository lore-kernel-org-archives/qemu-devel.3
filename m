Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE16E66884
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 19:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfrM-0001WP-Fk; Fri, 19 Dec 2025 14:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqW-0000aT-6x
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:09:01 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqT-0006pK-Vl
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:08:59 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so1646626f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 11:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766171336; x=1766776136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vw9O7QGKvNUJmURJtZXiXFfCdZcxW9QGykR9gjCW338=;
 b=eRHoRXV4GGK2tCs+S3+hmyGhB8rHzXLi69+Jzqy6JB+39KeS5clZKbeCM7Csh1z57s
 mI0yr0iKpcsQJGLR112X29WdtaD4BLPVar/z5dJFFEZ+JTIgyuUCbo3Hz0dgAGwG1n6Y
 Nz7v3FSq3L1U4LMInMHTera1X1cOQJjXrzjXjwoVYotnqtWnKuTUs/klWnGf2TO0Tbdc
 is5FshGVhdOseqPZihUnyOJ34c07rs0YIqyv/MAq1hUaTtlXK3pegKRyVHvNqsnON0ei
 e/lvuHc5zIsNLg0spKxsgFxE4njvRjhywqMuhI60oruKDIsviTchBKm7O/boDntPV/nH
 evfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766171336; x=1766776136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vw9O7QGKvNUJmURJtZXiXFfCdZcxW9QGykR9gjCW338=;
 b=e/GoR9l3GKpAd0LjmRcWXSh3znlNfX36epb9t6tvABH6HFLV7ckkH7a+WU5XfICm5T
 HF838ohXuJoSveZfunOB0lEXcvZUtYR8AggmeJQhx6GNyp1a3C+/usglcN0m4yqvZOpb
 BszVyZmXJOoRi7R5AWfarYb8mTY2Z/7lCw/5xzkRgdXHaFa7Jx965fuEck+4WQM94ReV
 THzOYYvXcEZlNiNRsnfnPNC2WhQWOp/LpJ54wLrqSnaKR3AOQkRXdZaL6DBeAHBIUDG1
 6YjFcuJyEmAByuc0+aze+7ULyHbPJBdGP7b9oQ8RgKT4AdM1DKEVZU8jQNWwrgc/woRz
 HFvA==
X-Gm-Message-State: AOJu0YyMn1Ndv+Okw7k4aiMaMVjkVditkLV6YfjSRnBOvfdg3zh5rawT
 nyrFQgzCfdA5JkEdPIJ6iIS1GYZE8EL1zdOANAkOSxY11gpWrZHYar4nGCDIU2NvAco=
X-Gm-Gg: AY/fxX4eK6ns3LeOVksJB6yJKrlc2PgBxWAkWQM6FOTehu7pzNWTC1WgoqZs+ZMdNM0
 ENmq4IPk0ga0lCCfa5gM+pSTj39JW4hbnfyFHM2s9mALY2iHLkXzLsTzuQPOrXfYFIYGbzG04UR
 i1w+fJq7eGFAh87M7Y1I8pVikt+iL7pXmJqRrQ3Mi1x58IxCr80E6Ki8XFedZvHnD29kYfzIU5n
 tW8+suAO8rEIQknJXDFn9gzMSnE0xP0Q++2LZxWaRogg2BQjBOqf4dxDxdYd0Lczk8NECKBkfCp
 VwIFZqu9XLRSHOo3if8oWsNU4XKp5lscLaZVGq+kRFsQ+BimqUp02ry3fN9mHYsnch+UCdVNA6J
 SPJNXyQfHmtlIg8/QS6sEFb77bJ5iWdHYXTHtpNd/tuNgdFTUA7bR2GEFZ+IaDtZA0DPaBRvDxS
 KyPDZwyxKVozQ=
X-Google-Smtp-Source: AGHT+IHtTFs6vXCwjjVmQbvO8bYOulTtaBQfMoJqmyIsUtGzdORgJKGX6cvOfTdiHWf3m2HcGiN/dw==
X-Received: by 2002:a05:6000:2305:b0:431:9b2:61c8 with SMTP id
 ffacd0b85a97d-4324e4c3864mr4833959f8f.10.1766171336269; 
 Fri, 19 Dec 2025 11:08:56 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm6544516f8f.35.2025.12.19.11.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:08:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC6A16017D;
 Fri, 19 Dec 2025 19:08:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Burton <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 09/12] plugins: split init_hook into create and reset
Date: Fri, 19 Dec 2025 19:08:46 +0000
Message-ID: <20251219190849.238323-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219190849.238323-1-alex.bennee@linaro.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

We need to move the plugin vcpu_init callback to the reset phase so
all register information is available to plugins. However so as not to
complicate the initialisation code we still want the call once to do
our housekeeping.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/plugin.h      | 19 ++++++++++++++-----
 include/qemu/qemu-plugin.h |  4 +++-
 hw/core/cpu-common.c       | 21 +++++++++++++++------
 plugins/core.c             | 31 +++++++++++++++++++++++--------
 4 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 91df1e78d2c..6d38b923c73 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -150,14 +150,23 @@ struct CPUPluginState {
 };
 
 /**
- * qemu_plugin_create_vcpu_state: allocate plugin state
+ * qemu_plugin_vcpu_create_hook() - called on vcpu creation
+ * @cpu: vCPU CPUState
  *
- * The returned data must be released with g_free()
- * when no longer required.
+ * We don't expose creation to plugins but we need to do internal
+ * housekeeping of stuff. Called once per vCPU creation.
  */
-CPUPluginState *qemu_plugin_create_vcpu_state(void);
+void qemu_plugin_vcpu_create_hook(CPUState *cpu);
+
+/**
+ * qemu_plugin_vcpu_reset_hook() - called on vcpu reset
+ * @cpu: vCPU CPUState
+ *
+ * Called each time the vcpu is reset. This can happen multiple times
+ * for a given vCPU. We expose this to plugins as vcpu_init.
+ */
+void qemu_plugin_vcpu_reset_hook(CPUState *cpu);
 
-void qemu_plugin_vcpu_init_hook(CPUState *cpu);
 void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index e8db7a72545..a75e323f31d 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -238,7 +238,9 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
  * @id: plugin ID
  * @cb: callback function
  *
- * The @cb function is called every time a vCPU is initialized.
+ * The @cb function is called every time a vCPU is initialised. This
+ * includes resets. NOTE: not all register information may be
+ * available the first time this is called.
  *
  * See also: qemu_plugin_register_vcpu_exit_cb()
  */
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 8c306c89e45..8113d83713f 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -100,8 +100,18 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
 void cpu_reset(CPUState *cpu)
 {
     device_cold_reset(DEVICE(cpu));
-
     trace_cpu_reset(cpu->cpu_index);
+
+#ifdef CONFIG_TCG
+    /*
+     * Because vCPUs get "started" before the machine is ready we often
+     * can't provide all the information plugins need during
+     * cpu_common_initfn. However the vCPU will be reset a few times
+     * before we eventually set things going giving plugins an
+     * opportunity to update things.
+     */
+    qemu_plugin_vcpu_reset_hook(cpu);
+#endif
 }
 
 static void cpu_common_reset_hold(Object *obj, ResetType type)
@@ -328,14 +338,13 @@ static void cpu_common_initfn(Object *obj)
     cpu_exec_initfn(cpu);
 
     /*
-     * Plugin initialization must wait until the cpu start executing
-     * code, but we must queue this work before the threads are
-     * created to ensure we don't race.
+     * Called once at vCPU creation so the plugin subsystem can do its
+     * housekeeping. See also cpu_reset() and
+     * qemu_plugin_vcpu_reset_hook() above.
      */
 #ifdef CONFIG_PLUGIN
     if (tcg_enabled()) {
-        cpu->plugin_state = qemu_plugin_create_vcpu_state();
-        qemu_plugin_vcpu_init_hook(cpu);
+        qemu_plugin_vcpu_create_hook(cpu);
     }
 #endif
 }
diff --git a/plugins/core.c b/plugins/core.c
index 85fabf9ec81..d303256c851 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -226,7 +226,7 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,
     do_plugin_register_cb(id, ev, func, udata);
 }
 
-CPUPluginState *qemu_plugin_create_vcpu_state(void)
+static CPUPluginState *qemu_plugin_create_vcpu_state(void)
 {
     return g_new0(CPUPluginState, 1);
 }
@@ -279,7 +279,25 @@ static void plugin_grow_scoreboards__locked(CPUState *cpu)
     end_exclusive();
 }
 
-static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
+static void qemu_plugin_vcpu_reset__async(CPUState *cpu, run_on_cpu_data unused)
+{
+    assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
+
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
+}
+
+void qemu_plugin_vcpu_reset_hook(CPUState *cpu)
+{
+    async_run_on_cpu(cpu, qemu_plugin_vcpu_reset__async, RUN_ON_CPU_NULL);
+}
+
+/*
+ * This is purely internal to plugins as we need to expand scoreboards
+ * each time a new vCPU is created.
+ */
+static void qemu_plugin_vcpu_create__async(CPUState *cpu, run_on_cpu_data unused)
 {
     bool success;
 
@@ -292,16 +310,13 @@ static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
     g_assert(success);
     plugin_grow_scoreboards__locked(cpu);
     qemu_rec_mutex_unlock(&plugin.lock);
-
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
 }
 
-void qemu_plugin_vcpu_init_hook(CPUState *cpu)
+void qemu_plugin_vcpu_create_hook(CPUState *cpu)
 {
+    cpu->plugin_state = qemu_plugin_create_vcpu_state();
     /* Plugin initialization must wait until the cpu start executing code */
-    async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
+    async_run_on_cpu(cpu, qemu_plugin_vcpu_create__async, RUN_ON_CPU_NULL);
 }
 
 void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
-- 
2.47.3


