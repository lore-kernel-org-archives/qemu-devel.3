Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0024C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2f-0000Ds-2o; Wed, 02 Jul 2025 06:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2c-0000Ad-HA
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2U-00031N-Ve
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d54214adso47416785e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453404; x=1752058204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uKeRyX0ZAy/lXFW0B3T0haqZQUnDaXH59uMD4XA+u4=;
 b=Da05rEhNrjT5AUcinXJk64b1kLBKbwyBSypqvHML4dFIeggFpCwvwT8PnPH059EiWa
 9BZGO/Q0FYlc4kROHduEz9htjSe/GFLm9DcIHJP+rsUXNz8Gy3wt1xUIRaEqhY/ZFl0y
 xVAH0sxFm+NKT4pLRQ9wb9//wRmYGDqCzzBYKNyMg5nQmDPnHtVXRg5oPdq5qA/oc3TW
 bS4x7tbwz1DOCzrSZABWj4yjOY7gGhdfYtZEydBwQRQJJ4xi6iVMBmO2zjnj5/fiv5xg
 0enw5QcPtqnWU6YPHvA7aqvrPAkGoo3gV4V3acse1PHk/crFiKggc58FjX6K7OctzXh9
 e/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453404; x=1752058204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uKeRyX0ZAy/lXFW0B3T0haqZQUnDaXH59uMD4XA+u4=;
 b=tdFL1bM5yUW0p7zx8QWqwuIjAbT0RUDG9NE+Pgiej3ePHSl5e54dQ+YVcNjPUJwIVQ
 iORpjzEYBxm7A5LpPOM+QKbW7tCXLgYMt6fb+Dt5Zk39hnzWHVyzfaxlaO2EMTnb22jz
 MKUoWxnaELUE6+f6TnVaDvNQAdXheWmMt9hqSPa6dbxp45AJHuf053x2CAktwZdGlmGH
 +gmLCnQBSAqisl8fnVQqLgpZSG/X81QUym8vKKP7f0HoZW6H8rBbMr0gpPgpsMFHGfs2
 9B/s8MeW7CK9tkp0N2SSPp/XGSkj/Ehe1KX+fHB170gjAmq6hUIqJzqBBOJlAbiHOt7w
 NYow==
X-Gm-Message-State: AOJu0YxUF6lwSwAXVcT87Js/zQxdi3czU/nEqwsv1kHsx4r0YmpXtF6R
 MCQTfpONp3b7lKik3BYhdvkNl9RoCSFT9JcEwPCl5x9jY02pOxQwEivusMoczF71VOU=
X-Gm-Gg: ASbGncsi1/yFmtWDwr65hpE5tuTDUgmmmgJHaBnfQInalV3xRXdbSXZAw7QaL87xezP
 5OGXhauKx185/q9CM3feUz5NErU0m7zJ35zNo5nmPOpJbZTPMg60ltDUNETByGbp9AxEO4W3ycs
 ePcWV3n9F/+K9q+C9ovKu0b5r0N8ft1ARsaeq+GCwZaAJYNIOzjV82z6I8TNkUIWS0qgOG+0JVQ
 IIVECf7PNRn+yGGDsCg3BCPTHTPsOY9lHp9knsTYkrcREZdhceNje+rlrF1hQJeis5qziHh81KT
 5vZJQiS/8F4OKniZbCFG9yJoeewIajEfmo6NkIyJbjj1TkoxysoOkUF1P3yEhh0=
X-Google-Smtp-Source: AGHT+IFZN53NjaTDrtkLw2Lr3YjyPouU5qDA5YbmWeaI9ecXrNko70BS1hquRBq6vTITc1cy6AZMbg==
X-Received: by 2002:a05:600c:8588:b0:442:f956:53f9 with SMTP id
 5b1f17b1804b1-454a37a0cd4mr19918415e9.18.1751453404301; 
 Wed, 02 Jul 2025 03:50:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a57c2sm194174645e9.12.2025.07.02.03.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:50:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 72B785F8E1;
 Wed, 02 Jul 2025 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 07/15] plugins: Add enforcement of QEMU_PLUGIN_CB flags in
 register R/W callbacks
Date: Wed,  2 Jul 2025 11:49:47 +0100
Message-ID: <20250702104955.3778269-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

This patch adds functionality to enforce the requested QEMU_PLUGIN_CB_
flags level passed when registering a callback function using the
plugins API. Each time a callback is about to be invoked, a thread-local
variable will be updated with the level that callback requested. Then,
called API functions (in particular, the register read and write API)
will call qemu_plugin_get_cb_flags() to check the level is at least the
level they require.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-4-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-8-alex.bennee@linaro.org>

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
index eb9281fe54..c6e9ef1478 100644
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
-- 
2.47.2


