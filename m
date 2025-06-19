Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DD8C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 16:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSHwL-0001Y7-Jb; Thu, 19 Jun 2025 12:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHvk-0001Lv-33
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:16:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHve-0003fI-31
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:15:56 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so643401b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750349752; x=1750954552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7zN4lzjHX97r8bgkj2U9G9NZtqeOC5YwH/K0eCJa2k=;
 b=mwN31WqEBu6UbQh4QOxA/VVktQ+SZ5CxYjBAhSCJmaGofF/lFoe+ogmmP6iTzTAdHa
 37jPX+Yrpw1hhsPrwhNmyu+i2kBdd3jyD9Y2mzH/A7l4wRsYlgfgL95tdzdQAXfarlhF
 3GKBzJUc3aapXBfip4Ac1FOAIBrWilPX1xabN6wvGtszzuETCDj2vHxGTZ0bGJBOlNpJ
 o153DrKNqaD1TRQj9+ECHngWod2Ate92Tw/XZgzDhgnLTEviJofI2mS2H2CphM9ebDEP
 /8uLOtMf1FOlVVz1TH553T4HkFH4xN2NaBDIUw7Ft/WI0CqFP+A8vzCz03FJOTLgK9mz
 wP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750349752; x=1750954552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7zN4lzjHX97r8bgkj2U9G9NZtqeOC5YwH/K0eCJa2k=;
 b=U1lC2YBbCKRYcw5cjCkH8xYNll/thBEy5OQ4D5/NZYweipLQpbsBi7LtH3s0+TphnC
 5zh5OZqypIUZWg5UH92XgFkivpg6kehlyo/iHU2lSJSqUG87uAlsGDjfzdigab2pCd5P
 aSDOvbyfSmCGaRr27UUUI2U7WgYv6JOOTIJ75xQXd67n4nXbBEJjY3+LRnmBsXn7t3U8
 XlOIYuxcuS0At17+CcPBuRbfx56ZalcDBW8EAaR5nMHXk0aOKjMxQlaaarqr4815Kuun
 89APumEdwaou67x7hokegS0jlIgIizYjLKfnf8gwwNz3lBpnfvHulCBH577gOnIX85x6
 y2Ag==
X-Gm-Message-State: AOJu0Yy6sZDAw7nh80X7+jMXAQFGZEhYEPZNUVFRXYHPM9TXsfDW93VH
 XIiRuZ2muC58sH5IC3OdfqsbnYQaYY77pDRioSVteqdDtD/eoFaSbtBQko5NKnw6
X-Gm-Gg: ASbGncvyUpH4qUFsxtecqpwtakgCuCmeZrdGQimmBK3H3YIiaysLikzXYa4ttnicBdv
 rRcfOg/qs1ES3unCr0pENHo1UrF276G7RWypPxt0rBvYJgEfxR90lcUEg1II5FyxKNOUX6SHwCd
 fVUCQlF6vOREQ+qyEUMGk5Pvvc5KUtwAJr9XwvkCZ1qpYqlHfdcbWQBBot5roc2OuzICPtr+hvK
 rfQiFr/0blKYXcnCqBlxaLVVKABkQnn/AvlIerY5+nlz9N/ovUEcBmYuG9aro4iWQQyLBV783re
 r4mAj9UERNPB0ItyXkavm9rLySe+zTkYZKClT9x8I/sLpaII1a2iXbRHn9KJ3UpNZOH/aQ0y
X-Google-Smtp-Source: AGHT+IEP5hQ1XF0HvbMkjwZOtOHsz/vvyVBGBrCc8zIwL5zYeVAHwgJgQwtQ/CQ/6wHO4MZt8Ht1xQ==
X-Received: by 2002:a05:6a00:14c2:b0:748:2e1a:84e3 with SMTP id
 d2e1a72fcca58-7489ce0c6bbmr36340091b3a.8.1750349751843; 
 Thu, 19 Jun 2025 09:15:51 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe168a0f8sm13168683a12.53.2025.06.19.09.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 09:15:51 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v13 3/7] plugins: Add enforcement of QEMU_PLUGIN_CB flags in
 register R/W callbacks
Date: Thu, 19 Jun 2025 09:15:43 -0700
Message-ID: <20250619161547.1401448-4-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619161547.1401448-1-rowanbhart@gmail.com>
References: <20250619161547.1401448-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch adds functionality to enforce the requested QEMU_PLUGIN_CB_
flags level passed when registering a callback function using the
plugins API. Each time a callback is about to be invoked, a thread-local
variable will be updated with the level that callback requested. Then,
called API functions (in particular, the register read and write API)
will call qemu_plugin_get_cb_flags() to check the level is at least the
level they require.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 accel/tcg/plugin-gen.c     | 30 ++++++++++++++++++++++++++++++
 include/hw/core/cpu.h      |  1 +
 include/qemu/plugin.h      | 15 +++++++++++++++
 include/qemu/qemu-plugin.h | 19 +++++++++++++------
 plugins/api.c              |  4 ++++
 plugins/core.c             | 33 +++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c1da753894..9920381a84 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -117,10 +117,20 @@ static TCGv_i32 gen_cpu_index(void)
 static void gen_udata_cb(struct qemu_plugin_regular_cb *cb)
 {
     TCGv_i32 cpu_index = gen_cpu_index();
+    enum qemu_plugin_cb_flags cb_flags =
+        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
+    TCGv_i32 flags = tcg_constant_i32(cb_flags);
+    TCGv_i32 clear_flags = tcg_constant_i32(QEMU_PLUGIN_CB_NO_REGS);
+    tcg_gen_st_i32(flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_gen_st_i32(clear_flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_temp_free_i32(cpu_index);
+    tcg_temp_free_i32(flags);
+    tcg_temp_free_i32(clear_flags);
 }
 
 static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
@@ -173,10 +183,20 @@ static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
     tcg_gen_ld_i64(val, ptr, 0);
     tcg_gen_brcondi_i64(cond, val, cb->imm, after_cb);
     TCGv_i32 cpu_index = gen_cpu_index();
+    enum qemu_plugin_cb_flags cb_flags =
+        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
+    TCGv_i32 flags = tcg_constant_i32(cb_flags);
+    TCGv_i32 clear_flags = tcg_constant_i32(QEMU_PLUGIN_CB_NO_REGS);
+    tcg_gen_st_i32(flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_gen_st_i32(clear_flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_temp_free_i32(cpu_index);
+    tcg_temp_free_i32(flags);
+    tcg_temp_free_i32(clear_flags);
     gen_set_label(after_cb);
 
     tcg_temp_free_i64(val);
@@ -210,12 +230,22 @@ static void gen_mem_cb(struct qemu_plugin_regular_cb *cb,
                        qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
     TCGv_i32 cpu_index = gen_cpu_index();
+    enum qemu_plugin_cb_flags cb_flags =
+        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
+    TCGv_i32 flags = tcg_constant_i32(cb_flags);
+    TCGv_i32 clear_flags = tcg_constant_i32(QEMU_PLUGIN_CB_NO_REGS);
+    tcg_gen_st_i32(flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_gen_call4(cb->f.vcpu_mem, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_i32_temp(tcg_constant_i32(meminfo)),
                   tcgv_i64_temp(addr),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_gen_st_i32(clear_flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_temp_free_i32(cpu_index);
+    tcg_temp_free_i32(flags);
+    tcg_temp_free_i32(clear_flags);
 }
 
 static void inject_cb(struct qemu_plugin_dyn_cb *cb)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 33296a1c08..162a56a5da 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -368,6 +368,7 @@ typedef struct CPUNegativeOffsetState {
     GArray *plugin_mem_cbs;
     uint64_t plugin_mem_value_low;
     uint64_t plugin_mem_value_high;
+    int32_t plugin_cb_flags;
 #endif
     IcountDecr icount_decr;
     bool can_do_io;
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9726a9ebf3..f355c7cb8a 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -209,6 +209,21 @@ void qemu_plugin_user_prefork_lock(void);
  */
 void qemu_plugin_user_postfork(bool is_child);
 
+enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags);
+
+static inline void qemu_plugin_set_cb_flags(CPUState *cpu,
+                                            enum qemu_plugin_cb_flags flags)
+{
+    assert(cpu);
+    cpu->neg.plugin_cb_flags = flags;
+}
+
+static inline enum qemu_plugin_cb_flags qemu_plugin_get_cb_flags(void)
+{
+    assert(current_cpu);
+    return current_cpu->neg.plugin_cb_flags;
+}
+
 #else /* !CONFIG_PLUGIN */
 
 static inline void qemu_plugin_add_opts(void)
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index cfe1692ecb..9c9ebf6ce0 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -254,9 +254,6 @@ typedef struct {
  * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
- *
- * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
- * system register state.
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
@@ -901,7 +898,12 @@ GArray *qemu_plugin_get_registers(void);
  * @buf: A GByteArray for the data owned by the plugin
  *
  * This function is only available in a context that register read access is
- * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
+ * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag, if called inside a
+ * callback that can be registered with a qemu_plugin_cb_flags argument. This
+ * function can also be used in any callback context that does not use a flags
+ * argument, such as in a callback registered with
+ * qemu_plugin_register_vcpu_init_cb(), except for callbacks registered with
+ * qemu_plugin_register_atexit_cb() and qemu_plugin_register_flush_cb().
  *
  * Returns the size of the read register. The content of @buf is in target byte
  * order. On failure returns -1.
@@ -916,8 +918,13 @@ int qemu_plugin_read_register(struct qemu_plugin_register *handle,
  * @handle: a @qemu_plugin_reg_handle handle
  * @buf: A GByteArray for the data owned by the plugin
  *
- * This function is only available in a context that register write access is
- * explicitly requested via the QEMU_PLUGIN_CB_RW_REGS flag.
+ * This function is only available in a context that register read access is
+ * explicitly requested via the QEMU_PLUGIN_CB_RW_REGS flag, if called inside a
+ * callback that can be registered with a qemu_plugin_cb_flags argument. This
+ * function can also be used in any callback context that does not use a flags
+ * argument, such as in a callback registered with
+ * qemu_plugin_register_vcpu_init_cb(), except for callbacks registered with
+ * qemu_plugin_register_atexit_cb() and qemu_plugin_register_flush_cb().
  *
  * The size of @buf must be at least the size of the requested register.
  * Attempting to write a register with @buf smaller than the register size
diff --git a/plugins/api.c b/plugins/api.c
index 6514f2c76a..3f04399c26 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -437,6 +437,10 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 {
     g_assert(current_cpu);
 
+    if (qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_NO_REGS) {
+        return -1;
+    }
+
     return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
 }
 
diff --git a/plugins/core.c b/plugins/core.c
index eb9281fe54..6ae5bbc0ef 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -15,6 +15,7 @@
 #include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "qemu/plugin.h"
+#include "qemu/qemu-plugin.h"
 #include "qemu/queue.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/rcu.h"
@@ -266,7 +267,9 @@ static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
     plugin_grow_scoreboards__locked(cpu);
     qemu_rec_mutex_unlock(&plugin.lock);
 
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
 }
 
 void qemu_plugin_vcpu_init_hook(CPUState *cpu)
@@ -279,7 +282,9 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
 {
     bool success;
 
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_EXIT);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
 
     assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
     qemu_rec_mutex_lock(&plugin.lock);
@@ -367,6 +372,7 @@ void plugin_register_dyn_cb__udata(GArray **arr,
     static TCGHelperInfo info[3] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
@@ -396,6 +402,7 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
     static TCGHelperInfo info[3] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
@@ -434,6 +441,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
     static TCGHelperInfo info[3] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
@@ -473,7 +481,9 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_tb_trans_cb_t func = cb->f.vcpu_tb_trans;
 
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
         func(cb->ctx->id, tb);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
 
@@ -498,7 +508,9 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
         func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
 
@@ -520,7 +532,9 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
 
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
         func(cb->ctx->id, cpu->cpu_index, num, ret);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
 
@@ -528,14 +542,18 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
     /* idle and resume cb may be called before init, ignore in this case */
     if (cpu->cpu_index < plugin.num_vcpus) {
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
 
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
     if (cpu->cpu_index < plugin.num_vcpus) {
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
 
@@ -615,9 +633,13 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
         switch (cb->type) {
         case PLUGIN_CB_MEM_REGULAR:
             if (rw & cb->regular.rw) {
+                qemu_plugin_set_cb_flags(cpu,
+                    tcg_call_to_qemu_plugin_cb_flags(cb->regular.info->flags));
+
                 cb->regular.f.vcpu_mem(cpu->cpu_index,
                                        make_plugin_meminfo(oi, rw),
                                        vaddr, cb->regular.userp);
+                qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
             }
             break;
         case PLUGIN_CB_INLINE_ADD_U64:
@@ -760,3 +782,14 @@ void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
     g_array_free(score->data, TRUE);
     g_free(score);
 }
+
+enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags)
+{
+    if (flags & TCG_CALL_NO_RWG) {
+        return QEMU_PLUGIN_CB_NO_REGS;
+    } else if (flags & TCG_CALL_NO_WG) {
+        return QEMU_PLUGIN_CB_R_REGS;
+    } else {
+        return QEMU_PLUGIN_CB_RW_REGS;
+    }
+}
\ No newline at end of file
-- 
2.49.0


