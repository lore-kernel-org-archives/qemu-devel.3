Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCC7C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIeZ-00058Y-0W; Wed, 28 Feb 2024 07:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeQ-0004lq-2C
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeM-00035Z-VE
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:05 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412b5a3d2e3so2934965e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121781; x=1709726581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5gI8EUY5DFBBef2QZLwJknMk02YZ7ugqhbMHpkMVd7s=;
 b=nDdsqSx+EXjeTR1U2NMJ0YbZp8uxIR/kJvjfF4EKwczHK9OhlbfryQlTA3KtmfCErp
 XlqlAkKPwi/+rP9IBkYK0l9bdrnkBQMbYm/CevkO0EjAfyibHHw98g/VoWuwqi3exTWm
 4Sql5M7AtOg1dX7uKOORbZy7Mw67DIvtvJikZkFffePwdQqppYkj6/KrOn5w1jQvaFt6
 me+TpEseBdqKSTwTrSzs0i6yHLMHCHV+A8zVze44C/danqFsEw6vhu2y+mKZQk+LIDxz
 uE9at0yA30TpVpdWcnZNxe0po+LjdtxoeYq8G8txscM7wmz04hRtGXYK5Vnosjvnt8Uv
 TLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121781; x=1709726581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5gI8EUY5DFBBef2QZLwJknMk02YZ7ugqhbMHpkMVd7s=;
 b=v1yx7tPEv2MsnORB94FAva+34R0ROp+bmZCFtCizH7R/tUf31AVE6nxuLpiai+YLbS
 6fz/1eS/i+M2mUNUqp9/XjpWYqc35zPnVrfx9Pe7vYliwExP0nvoB2fki/1K6m60dFmh
 yF63lbL6rk77pDvLzGH5vpzHuxIH6IPqcdnF1kfpY8oqz/bJgwukxJXPjEnarfbQJZir
 rDBbxMFVeK4bvUAe92hIVXuBhOLPbzWyxSkNhmPqgtnuKfeapDItj0Hxz+ebu8HAaPPH
 uUnY3WKNw+rGnUecR0vxvW5DQBu+4W94oBDtYiYqlJ6tVWGLbARcq5/NeXnlQQHmOdNZ
 D+rQ==
X-Gm-Message-State: AOJu0Ywfmh3yIZTv3VhmmSRE+OgJmHGUuwGf2BktjruVPe3H0V+mCZsL
 mAaQVv8kdPBhjexKrn8o8gOZwu62SF7ZUF9a67jyMT7jcWiMcSxl752N0DV82LU=
X-Google-Smtp-Source: AGHT+IG0Y/wSYc3xkx7ija3bbNUCAYfbj3pnZnlGc5YzAkz/UhJiFbPM6pp8HaGwtPQpq4sGid2BKg==
X-Received: by 2002:a05:600c:4885:b0:412:981d:2889 with SMTP id
 j5-20020a05600c488500b00412981d2889mr8425789wmp.40.1709121781462; 
 Wed, 28 Feb 2024 04:03:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z7-20020a05600c220700b00412b65672d2sm998696wml.9.2024.02.28.04.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 04:02:59 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 147FD5F929;
 Wed, 28 Feb 2024 11:57:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 22/29] plugins: create CPUPluginState and migrate plugin_mask
Date: Wed, 28 Feb 2024 11:56:54 +0000
Message-Id: <20240228115701.1416107-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

As we expand the per-vCPU data for plugins we don't want to pollute
CPUState. For now this just moves the plugin_mask (renamed to
event_mask) as the memory callbacks are accessed directly by TCG
generated code.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-23-alex.bennee@linaro.org>

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4b659799b00..af1a29526d4 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -31,7 +31,6 @@
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
-#include "qemu/plugin-event.h"
 #include "qom/object.h"
 
 typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
@@ -434,7 +433,8 @@ struct qemu_work_item;
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
  * @work_list: List of pending asynchronous work.
- * @plugin_mask: Plugin event bitmap. Modified only via async work.
+ * @plugin_mem_cbs: active plugin memory callbacks
+ * @plugin_state: per-CPU plugin state
  * @ignore_memory_transaction_failures: Cached copy of the MachineState
  *    flag of the same name: allows the board to suppress calling of the
  *    CPU do_transaction_failed hook function.
@@ -526,10 +526,13 @@ struct CPUState {
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
 
-    DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
-
 #ifdef CONFIG_PLUGIN
+    /*
+     * The callback pointer stays in the main CPUState as it is
+     * accessed via TCG (see gen_empty_mem_helper).
+     */
     GArray *plugin_mem_cbs;
+    CPUPluginState *plugin_state;
 #endif
 
     /* TODO Move common fields from CPUArchState here. */
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index b0c5ac68293..b3c94a34aa4 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -186,6 +186,19 @@ struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb,
     return insn;
 }
 
+/**
+ * struct CPUPluginState - per-CPU state for plugins
+ * @event_mask: plugin event bitmap. Modified only via async work.
+ */
+struct CPUPluginState {
+    DECLARE_BITMAP(event_mask, QEMU_PLUGIN_EV_MAX);
+};
+
+/**
+ * qemu_plugin_create_vcpu_state: allocate plugin state
+ */
+CPUPluginState *qemu_plugin_create_vcpu_state(void);
+
 void qemu_plugin_vcpu_init_hook(CPUState *cpu);
 void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index d7c703b4ae9..a028dba4d0b 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -42,6 +42,7 @@ typedef struct CompatProperty CompatProperty;
 typedef struct ConfidentialGuestSupport ConfidentialGuestSupport;
 typedef struct CPUAddressSpace CPUAddressSpace;
 typedef struct CPUArchState CPUArchState;
+typedef struct CPUPluginState CPUPluginState;
 typedef struct CpuInfoFast CpuInfoFast;
 typedef struct CPUJumpCache CPUJumpCache;
 typedef struct CPUState CPUState;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b37ce7683e6..ac6b52b9ec9 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -43,6 +43,7 @@
  * CPU's index into a TCG temp, since the first callback did it already.
  */
 #include "qemu/osdep.h"
+#include "qemu/plugin.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
@@ -831,7 +832,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
 {
     bool ret = false;
 
-    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_mask)) {
+    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_state->event_mask)) {
         struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
         int i;
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 68786360ea5..0108fb11dbc 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -194,10 +194,12 @@ static void cpu_common_parse_features(const char *typename, char *features,
     }
 }
 
+#ifdef CONFIG_PLUGIN
 static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
 {
     qemu_plugin_vcpu_init_hook(cpu);
 }
+#endif
 
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
@@ -223,9 +225,12 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
     }
 
     /* Plugin initialization must wait until the cpu start executing code */
+#ifdef CONFIG_PLUGIN
     if (tcg_enabled()) {
+        cpu->plugin_state = qemu_plugin_create_vcpu_state();
         async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
     }
+#endif
 
     /* NOTE: latest generic point where the cpu is fully realized */
 }
diff --git a/plugins/core.c b/plugins/core.c
index 2392bbb8889..2db4d31354b 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "qemu/lockable.h"
 #include "qemu/option.h"
+#include "qemu/plugin.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/xxhash.h"
 #include "qemu/rcu.h"
@@ -53,7 +54,8 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id)
 
 static void plugin_cpu_update__async(CPUState *cpu, run_on_cpu_data data)
 {
-    bitmap_copy(cpu->plugin_mask, &data.host_ulong, QEMU_PLUGIN_EV_MAX);
+    bitmap_copy(cpu->plugin_state->event_mask,
+                &data.host_ulong, QEMU_PLUGIN_EV_MAX);
     tcg_flush_jmp_cache(cpu);
 }
 
@@ -208,6 +210,11 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,
     do_plugin_register_cb(id, ev, func, udata);
 }
 
+CPUPluginState *qemu_plugin_create_vcpu_state(void)
+{
+    return g_new0(CPUPluginState, 1);
+}
+
 void qemu_plugin_vcpu_init_hook(CPUState *cpu)
 {
     bool success;
@@ -356,7 +363,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL;
 
-    if (!test_bit(ev, cpu->plugin_mask)) {
+    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
         return;
     }
 
@@ -378,7 +385,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_RET;
 
-    if (!test_bit(ev, cpu->plugin_mask)) {
+    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
         return;
     }
 
-- 
2.39.2


