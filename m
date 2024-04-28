Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A5EC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cot-0008Rv-OW; Sun, 28 Apr 2024 18:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cof-0008B4-Gm
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:16 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cod-0005fY-Lh
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:13 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a58e2740cd7so241836166b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342568; x=1714947368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhMcuO2jMQJAbbwElnMhrHO7OE3zltzzXLVSHanA6Q0=;
 b=eftI45vfnyvYf/1+jlGaxzH0eePPlrwogJLcMSJgE1BWZqQ7ulLVRyRlxm1kuGZgqG
 MjmTe5h/dBOsAyt/HWeBdE3NUKtKKXaLji0Azc17Tnr6emh75GsvVK+PuwO2p6hTPqAS
 g9l2adyA84xLoAzlaW3r00qZ1yq7C76lFISzij97MMjEEmCki8l3OG/iUE+xLrS/3DjB
 DBhlsN/8Y+V6f1Vwxbr0WBoTZbKRCSC/64X4Lzm5cuk9/0HtUioBRbfEInbmhGq/gnXa
 9pC440YzNySHbGdrG7xSocYr5DpxMRP+MOtCyNBQ9Drj6xcbewT6z5aYIqu4hpaaR5sa
 TQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342568; x=1714947368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhMcuO2jMQJAbbwElnMhrHO7OE3zltzzXLVSHanA6Q0=;
 b=VRCbymkC08Usbc/uZVk1hsrpxUJj2cJQJNuuqQnOw2RZjMasgSGhCn3wsijl/E8zLO
 qfjtpL8HaXfzTIyfnk222lDkRi+4c5DIlL4LrEtUQTwDkDs4jGzrUQ8tDMKRjnTtYtPu
 1M4LyOVNMGuW5qoAUu4Iq7GJPVbYCZ/NC5AlZoB8OFO8zWXZqR73gCc56WZP9ygRALNf
 HyZMYi3qSD2f5CtdG3QIN3jHJSc9i2cWCg7m3K7Rs0EuaxifaVB3DikTRXrg5/NrvtpK
 fwqK+p6e8SXa/+R5YtR7K1/5rOdhMIb4H/yszDXlVg/rly9lu48gDzqgkXtO/3yq7U0+
 YfAg==
X-Gm-Message-State: AOJu0YzeI4mvnQ0C21VgrUqVh+GPN/yR5GRY/cBui8LpDpMGLg+Cl0vr
 QPQfryxdGHRTWaxWYBboigI4jqjmy7RUm4dicZUZZLlGGrYD9Y2yIIVRw9kXQNKcZviJm+BethA
 s
X-Google-Smtp-Source: AGHT+IFyGR8kSnKbqjSCaphyGIp5gtFTyXIqLNvvMZbdopfODM9/fj9oglIITNm5KHwlpDJDRhd8Ag==
X-Received: by 2002:a17:906:4945:b0:a58:e3d5:87bd with SMTP id
 f5-20020a170906494500b00a58e3d587bdmr4719333ejt.26.1714342568692; 
 Sun, 28 Apr 2024 15:16:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a170906264800b00a52433f0907sm13199806ejc.37.2024.04.28.15.16.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:16:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 14/24] accel/tcg: Move plugin fields to CPUNegativeOffsetState
Date: Mon, 29 Apr 2024 00:14:40 +0200
Message-ID: <20240428221450.26460-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h  | 22 ++++++++++------------
 include/qemu/plugin.h  |  2 +-
 accel/tcg/plugin-gen.c |  8 +++++---
 hw/core/cpu-common.c   |  2 +-
 plugins/core.c         |  8 ++++----
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index beb37342e9..ef8b85b6fe 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -342,9 +342,18 @@ typedef union IcountDecr {
  * CPUNegativeOffsetState: Elements of CPUState most efficiently accessed
  *                         from CPUArchState, via small negative offsets.
  * @can_do_io: True if memory-mapped IO is allowed.
+ * @plugin_mem_cbs: active plugin memory callbacks
+ * @plugin_state: per-CPU plugin state
  */
 typedef struct CPUNegativeOffsetState {
     CPUTLB tlb;
+#ifdef CONFIG_PLUGIN
+    /*
+     * The callback pointer are accessed via TCG (see gen_empty_mem_helper).
+     */
+    GArray *plugin_mem_cbs;
+    CPUPluginState *plugin_state;
+#endif
     IcountDecr icount_decr;
     bool can_do_io;
 } CPUNegativeOffsetState;
@@ -416,8 +425,6 @@ struct qemu_work_item;
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
  * @work_list: List of pending asynchronous work.
- * @plugin_mem_cbs: active plugin memory callbacks
- * @plugin_state: per-CPU plugin state
  * @ignore_memory_transaction_failures: Cached copy of the MachineState
  *    flag of the same name: allows the board to suppress calling of the
  *    CPU do_transaction_failed hook function.
@@ -508,15 +515,6 @@ struct CPUState {
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
 
-#ifdef CONFIG_PLUGIN
-    /*
-     * The callback pointer stays in the main CPUState as it is
-     * accessed via TCG (see gen_empty_mem_helper).
-     */
-    GArray *plugin_mem_cbs;
-    CPUPluginState *plugin_state;
-#endif
-
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
@@ -1120,7 +1118,7 @@ void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
 static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
 {
 #ifdef CONFIG_PLUGIN
-    return !!cpu->plugin_mem_cbs;
+    return !!cpu->neg.plugin_mem_cbs;
 #else
     return false;
 #endif
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 41db748eda..99a32446e9 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -229,7 +229,7 @@ void qemu_plugin_add_dyn_cb_arr(GArray *arr);
 
 static inline void qemu_plugin_disable_mem_helpers(CPUState *cpu)
 {
-    cpu->plugin_mem_cbs = NULL;
+    cpu->neg.plugin_mem_cbs = NULL;
 }
 
 /**
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index cd78ef94a1..3766870108 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -178,7 +178,7 @@ static void gen_empty_mem_helper(void)
     TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
 
     tcg_gen_movi_ptr(ptr, 0);
-    tcg_gen_st_ptr(ptr, tcg_env, offsetof(CPUState, plugin_mem_cbs) -
+    tcg_gen_st_ptr(ptr, tcg_env, offsetof(CPUState, neg.plugin_mem_cbs) -
                                  offsetof(ArchCPU, env));
     tcg_temp_free_ptr(ptr);
 }
@@ -634,7 +634,8 @@ void plugin_gen_disable_mem_helpers(void)
         return;
     }
     tcg_gen_st_ptr(tcg_constant_ptr(NULL), tcg_env,
-                   offsetof(CPUState, plugin_mem_cbs) - offsetof(ArchCPU, env));
+                   offsetof(CPUState, neg.plugin_mem_cbs) -
+                   offsetof(ArchCPU, env));
 }
 
 static void plugin_gen_tb_udata(const struct qemu_plugin_tb *ptb,
@@ -871,7 +872,8 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
 {
     bool ret = false;
 
-    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_state->event_mask)) {
+    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS,
+                 cpu->neg.plugin_state->event_mask)) {
         struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
         int i;
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cbafc79033..3e00ea94be 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -213,7 +213,7 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
     /* Plugin initialization must wait until the cpu start executing code */
 #ifdef CONFIG_PLUGIN
     if (tcg_enabled()) {
-        cpu->plugin_state = qemu_plugin_create_vcpu_state();
+        cpu->neg.plugin_state = qemu_plugin_create_vcpu_state();
         async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
     }
 #endif
diff --git a/plugins/core.c b/plugins/core.c
index 09c98382f5..1286a18f09 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -55,7 +55,7 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id)
 
 static void plugin_cpu_update__async(CPUState *cpu, run_on_cpu_data data)
 {
-    bitmap_copy(cpu->plugin_state->event_mask,
+    bitmap_copy(cpu->neg.plugin_state->event_mask,
                 &data.host_ulong, QEMU_PLUGIN_EV_MAX);
     tcg_flush_jmp_cache(cpu);
 }
@@ -396,7 +396,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL;
 
-    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
+    if (!test_bit(ev, cpu->neg.plugin_state->event_mask)) {
         return;
     }
 
@@ -418,7 +418,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_RET;
 
-    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
+    if (!test_bit(ev, cpu->neg.plugin_state->event_mask)) {
         return;
     }
 
@@ -496,7 +496,7 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
-    GArray *arr = cpu->plugin_mem_cbs;
+    GArray *arr = cpu->neg.plugin_mem_cbs;
     size_t i;
 
     if (arr == NULL) {
-- 
2.41.0


