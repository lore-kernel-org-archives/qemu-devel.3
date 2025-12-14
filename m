Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC00D59D99
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Dec 2025 14:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUmpP-0006D4-K9; Sun, 14 Dec 2025 09:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vUmpN-0006Cw-10
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 09:12:01 -0500
Received: from smtp232.sjtu.edu.cn ([202.120.2.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vUmpH-0001jz-L6
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 09:11:59 -0500
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 0D5A5100AFC2A;
 Sun, 14 Dec 2025 22:11:22 +0800 (CST)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id D475D37C91E;
 Sun, 14 Dec 2025 22:11:21 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH v3 1/2] linux-user: add plugin API to filter syscalls
Date: Sun, 14 Dec 2025 22:10:21 +0800
Message-Id: <20251214141022.173340-2-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251214141022.173340-1-functioner@sjtu.edu.cn>
References: <20251214141022.173340-1-functioner@sjtu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.232;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp232.sjtu.edu.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit adds a syscall filter API to the TCG plugin API set.
Plugins can register a filter callback to QEMU to decide whether
to intercept a syscall, process it and bypass the QEMU syscall
handler.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
---
 include/qemu/plugin-event.h  |  1 +
 include/qemu/plugin.h        | 33 +++++++++++++++++++++++---------
 include/qemu/qemu-plugin.h   | 32 +++++++++++++++++++++++++++++++
 include/user/syscall-trace.h | 17 +++++++++++++++++
 linux-user/syscall.c         |  7 +++++--
 plugins/api.c                |  7 +++++++
 plugins/core.c               | 37 ++++++++++++++++++++++++++++++++++++
 7 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
index 1100dae212..7f3c5927f1 100644
--- a/include/qemu/plugin-event.h
+++ b/include/qemu/plugin-event.h
@@ -23,6 +23,7 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_INTERRUPT,
     QEMU_PLUGIN_EV_VCPU_EXCEPTION,
     QEMU_PLUGIN_EV_VCPU_HOSTCALL,
+    QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER,
     QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
 };
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index cea0a68858..91df1e78d2 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -55,15 +55,16 @@ void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head);
 int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
 
 union qemu_plugin_cb_sig {
-    qemu_plugin_simple_cb_t          simple;
-    qemu_plugin_udata_cb_t           udata;
-    qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
-    qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
-    qemu_plugin_vcpu_discon_cb_t     vcpu_discon;
-    qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
-    qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
-    qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
-    qemu_plugin_vcpu_syscall_ret_cb_t vcpu_syscall_ret;
+    qemu_plugin_simple_cb_t              simple;
+    qemu_plugin_udata_cb_t               udata;
+    qemu_plugin_vcpu_simple_cb_t         vcpu_simple;
+    qemu_plugin_vcpu_udata_cb_t          vcpu_udata;
+    qemu_plugin_vcpu_discon_cb_t         vcpu_discon;
+    qemu_plugin_vcpu_tb_trans_cb_t       vcpu_tb_trans;
+    qemu_plugin_vcpu_mem_cb_t            vcpu_mem;
+    qemu_plugin_vcpu_syscall_cb_t        vcpu_syscall;
+    qemu_plugin_vcpu_syscall_ret_cb_t    vcpu_syscall_ret;
+    qemu_plugin_vcpu_syscall_filter_cb_t vcpu_syscall_filter;
     void *generic;
 };
 
@@ -169,6 +170,11 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
                          uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
                          uint64_t a6, uint64_t a7, uint64_t a8);
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret);
+bool
+qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
+                                uint64_t a2, uint64_t a3, uint64_t a4,
+                                uint64_t a5, uint64_t a6, uint64_t a7,
+                                uint64_t a8, uint64_t *ret);
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              uint64_t value_low,
@@ -280,6 +286,15 @@ static inline
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 { }
 
+static inline bool
+qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
+                                uint64_t a2, uint64_t a3, uint64_t a4,
+                                uint64_t a5, uint64_t a6, uint64_t a7,
+                                uint64_t a8, uint64_t *ret)
+{
+    return false;
+}
+
 static inline void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                                            uint64_t value_low,
                                            uint64_t value_high,
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 60de4fdd3f..f3bff82257 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -798,6 +798,33 @@ typedef void
                                  uint64_t a3, uint64_t a4, uint64_t a5,
                                  uint64_t a6, uint64_t a7, uint64_t a8);
 
+/**
+ * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter callback
+ * function type
+ * @id: plugin id
+ * @vcpu_index: the executing vCPU
+ * @num: the syscall number
+ * @a1: the 1st syscall argument
+ * @a2: the 2nd syscall argument
+ * @a3: the 3rd syscall argument
+ * @a4: the 4th syscall argument
+ * @a5: the 5th syscall argument
+ * @a6: the 6th syscall argument
+ * @a7: the 7th syscall argument
+ * @a8: the 8th syscall argument
+ * @sysret: the reference of the syscall return value, must set this if filtered
+ *
+ * Returns true if you want to filter this syscall (i.e. stop it being
+ * handled further), otherwise returns false.
+ */
+typedef bool
+(*qemu_plugin_vcpu_syscall_filter_cb_t)(qemu_plugin_id_t id,
+                                        unsigned int vcpu_index,
+                                        int64_t num, uint64_t a1, uint64_t a2,
+                                        uint64_t a3, uint64_t a4, uint64_t a5,
+                                        uint64_t a6, uint64_t a7, uint64_t a8,
+                                        uint64_t *sysret);
+
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb);
@@ -811,6 +838,11 @@ void
 qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t cb);
 
+QEMU_PLUGIN_API
+void
+qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_syscall_filter_cb_t cb);
+
 
 /**
  * qemu_plugin_insn_disas() - return disassembly string for instruction
diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index 9bd7ca19c8..4ee6c4e513 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -39,5 +39,22 @@ static inline void record_syscall_return(CPUState *cpu, int num, abi_long ret)
     gdb_syscall_return(cpu, num);
 }
 
+static bool send_through_syscall_filters(CPUState *cpu, int num,
+                                         abi_long arg1, abi_long arg2,
+                                         abi_long arg3, abi_long arg4,
+                                         abi_long arg5, abi_long arg6,
+                                         abi_long arg7, abi_long arg8,
+                                         abi_long *sysret)
+{
+    uint64_t sysret64 = 0;
+    bool filtered = qemu_plugin_vcpu_syscall_filter(cpu, num, arg1, arg2,
+                                                    arg3, arg4, arg5, arg6,
+                                                    arg7, arg8, &sysret64);
+    if (filtered) {
+        *sysret = sysret64;
+    }
+    return filtered;
+}
+
 
 #endif /* SYSCALL_TRACE_H */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..9ae3c5bfbd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -14201,8 +14201,11 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
         print_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
-    ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
-                      arg5, arg6, arg7, arg8);
+    if (!send_through_syscall_filters(cpu, num, arg1, arg2, arg3, arg4, arg5,
+                                      arg6, arg7, arg8, &ret)) {
+        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
+                          arg5, arg6, arg7, arg8);
+    }
 
     if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_syscall_ret(cpu_env, num, ret, arg1, arg2,
diff --git a/plugins/api.c b/plugins/api.c
index eac04cc1f6..478d0c8889 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -208,6 +208,13 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_RET, cb);
 }
 
+void
+qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_syscall_filter_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER, cb);
+}
+
 /*
  * Plugin Queries
  *
diff --git a/plugins/core.c b/plugins/core.c
index b4b783008f..85fabf9ec8 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -564,6 +564,43 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
+bool
+qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
+                                uint64_t a2, uint64_t a3, uint64_t a4,
+                                uint64_t a5, uint64_t a6, uint64_t a7,
+                                uint64_t a8, uint64_t *sysret)
+{
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER;
+    bool filtered = false;
+
+    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
+        return false;
+    }
+
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+
+    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+        qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
+
+        if (func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4,
+                 a5, a6, a7, a8, sysret)) {
+            filtered = true;
+            break;
+        }
+    }
+
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
+
+    return filtered;
+}
+
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
     /* idle and resume cb may be called before init, ignore in this case */
-- 
2.34.1


