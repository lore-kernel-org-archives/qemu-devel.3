Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E67D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 19:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfqr-0000i5-Eo; Fri, 19 Dec 2025 14:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqY-0000cp-KU
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:09:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqV-0006qU-9O
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:09:02 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso18783305e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766171338; x=1766776138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exhExtIFkfMLYG9IcRv/g6zEaHCsYLLw3EKLbf6kTV8=;
 b=L9jS7TA6Olkqqjb4VURbPfJYp7k16GwdX7odVYiejS88xXy2o7AphJsRz+JzOjcldQ
 3vczdLvFLGnALH5r4Uchv3+C0AlnrqA68Ph1NwQ38S1Y/w6BMZq3xRuHoGZVJMXX/vhy
 Of1XQODUe3f8isULCgbSxQa6yUKFBOMQHbqWe2Xmn986hitN4psVrW9q8ZJbzzjJvmDI
 GCs+Ya5qXYAMXxmtUwXt/8c6Nf0FjxOc2WD8yNXRhxZ0Ei9bsFMzW+PVl9Pi9i3A8j8A
 KfcGDmfguhY05DPO/OpUP58tdnnk3MCE4Phd0YtULKUxeaIL/jme2vue6rDmI58oRQtB
 qKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766171338; x=1766776138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=exhExtIFkfMLYG9IcRv/g6zEaHCsYLLw3EKLbf6kTV8=;
 b=bkeheMTyMc3X3EP3FWKU1O4TSG4U2X5zvq4IM/LmDVPkEhVlYqhCcDTDuV8roJLfQK
 71WdWRI4Il/JLbuQTrFGnLqklIj1KkZPPMPb3X5TcQvizthOMvC6AtxyXzum/UpU6qup
 Q0FJuZ7lZmoKO9iSq+Xz2CVqLPaokKVHEcqixcxeTkp2bf/6Q+pK/TKX2Cc1MjUwyIRO
 fZ1JTKM9KPNXQgXvi8UMrydzW/ykHqESLx03vO3OWQ00wZBNHT1j1WNfVI2RHvsCgoHg
 ctHAccnWVXKkhdlM54A16bWZ8OyJxZrLxJNGqYbGJmJMZA6WlFxuJzRtI1i3UacsSuf1
 3c6g==
X-Gm-Message-State: AOJu0Yy6M8CRx1JBscwHwo1DLI9wKEtO3yu2FKYeRaNvICccfmbwjDH9
 3g5s84Qcmud8GVNlc21l/P5meFU6Rr0onlHbftkHGiff8A5KW599a0znmcodYDjgnAM=
X-Gm-Gg: AY/fxX7JIynDxfbIm4/Oa2pz/C2BZk2F44gDP3sWZiG2L0lsV2YkZgix25I41akvmw7
 Kb77QXuqL36GYAyiHzjXAYgTNvKwCSZTpFlAHV4TBuh3SARmez+XAHfNa9H1m6IbVrFRJF/DGKP
 xt2x3+Bot39rZEOqRnGCoayoKDW+039etV+/l8ykXGK9BwsxAioR8jWjG9z8KxiPubRwA/ttond
 xzQhsdvFaUIHRPYGmP070qJjWjlwdOfoAWq/RiSnaeHyAEaX/6zxKr7vBwCVgOVV8JS8vrRPTBL
 bRfD2QR/lco1VADT3RuSY8Iqn2yuPTWAjtusoNakZZCuUk4Vab8iVpOIcP8MYy+jxNFzY6a20Oe
 pnbUw76Zlu7Mg1rkv2EExMGl/R2Qw0GGrUSb/nCX1iGAGmoa7e2J9i2FEqfmyRZQHs0un7D+xCT
 u8zLoBFKrBg68=
X-Google-Smtp-Source: AGHT+IFJALMRzI5PGuNMXQPR8fO9l2JZcG1tkgYlhqKkofOlFKniutHsE5LdORNLcgPau9hBLUaCrw==
X-Received: by 2002:a05:600c:1d1d:b0:477:9c73:267f with SMTP id
 5b1f17b1804b1-47d195aa4bfmr43379675e9.33.1766171337575; 
 Fri, 19 Dec 2025 11:08:57 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273e4d5sm112791785e9.6.2025.12.19.11.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:08:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 959B5600A1;
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ziyang Zhang <functioner@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>
Subject: [RFC PATCH 07/12] linux-user: add plugin API to filter syscalls
Date: Fri, 19 Dec 2025 19:08:44 +0000
Message-ID: <20251219190849.238323-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219190849.238323-1-alex.bennee@linaro.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ziyang Zhang <functioner@sjtu.edu.cn>

This commit adds a syscall filter API to the TCG plugin API set.
Plugins can register a filter callback to QEMU to decide whether
to intercept a syscall, process it and bypass the QEMU syscall
handler.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251214144620.179282-2-functioner@sjtu.edu.cn>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
index 1100dae2123..7f3c5927f1f 100644
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
index cea0a68858b..91df1e78d2c 100644
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
index 29663591ebf..e8db7a72545 100644
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
+ * @sysret: reference of the syscall return value, must set this if filtered
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
index 9bd7ca19c84..4ee6c4e5134 100644
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
index 2060e561a20..9ae3c5bfbd7 100644
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
index 267fa2fd503..a98c0d3e41a 100644
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
index b4b783008f7..85fabf9ec81 100644
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
2.47.3


