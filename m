Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0392C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7wb-0001HM-NB; Mon, 04 Mar 2024 08:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7wX-0001Co-2B
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:21 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7wU-0000ew-Nt
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:20 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so194062266b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709557275; x=1710162075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jjoQrO6mChD+KnOPiCs1kl1THA8ae3OKxiuRsgoNmgw=;
 b=C047OIAquKkLtNpdFo/IDei7iwm4k+komxgKak18oDQ340WKX6wRag5uhmO3Y5Squr
 1XkWePPZBQerR36HoEjphB5r6AxMMnHKFgri4ohnVMgXF34+emM1fLn/3DECndOdLiqY
 ammRl5vgGKCP7NdKwvmHAmC49DMmQHDgttqeX95p79RcrO4jW1Z6/ZeWmjTYXF9MjE+N
 CGEhbRzGjJsPstZxLSgScUiQJbphqYIaB19krdr+5PwdoPBuRFGU+BU/kvkrq62JB7Mk
 9PVNgTXgqN7l3k3/WrC2BjDDj97rDs5sTArdXmtj2u9Ju+6nL+h+DNBIJ3CDzjHTb7xg
 p9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709557275; x=1710162075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jjoQrO6mChD+KnOPiCs1kl1THA8ae3OKxiuRsgoNmgw=;
 b=Q9DOScEvAKVLpbQGaVZTUoendTNzK7InJFkfhpBSmVGOGsyNOOjuoDdw02VHCjOg17
 /zj6MMxOTbX76tr8Os3orQN/FqnIXA26ux4Zsd6dMkWB3nhuK9Uanq0BxpCK0mHZXHQa
 u9iA2xWy+W+5YXgh5g3JCuYS9UwEOmSWeugNJAcTlZG9IJwL1wgvKJB2+jccpD46nt4W
 K0kNFf9y8YalSw6WOftq18sqVDhLsg6m5ktbvx9T+bJCLUeMcxnU903UI1hMZszXNG5l
 0iFWmUS21SXmynjmrAi5+5nQKXIjvq1mrtT/hDg/K4/UaE2t85HQ/pyfrv5hFviwrRRe
 yUpQ==
X-Gm-Message-State: AOJu0Yxxe/FySK783Zb+ypN17g6s6XkWO26MPhC+xpITaPkKbH4TpYrb
 MnCS64Pv/PymvOs2lOZquuxPGPWN75ob3MPVrl6Zit1VTIk0InSzYtc0OXPrdaBV8BFf/vE96O/
 tl+0=
X-Google-Smtp-Source: AGHT+IFx3CDR2jk80TmBbTpsYsbQWhELHXgVmkBrxTckVgtV2LC+HdsU1jNVHE/ZBdTMmy4vnKppJw==
X-Received: by 2002:a17:906:81d4:b0:a45:3792:fac8 with SMTP id
 e20-20020a17090681d400b00a453792fac8mr2029733ejx.25.1709557274919; 
 Mon, 04 Mar 2024 05:01:14 -0800 (PST)
Received: from debian.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 tj7-20020a170907c24700b00a413d1eda4bsm4806136ejc.87.2024.03.04.05.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:01:14 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 04/12] plugins: add inline operation per vcpu
Date: Mon,  4 Mar 2024 17:00:28 +0400
Message-Id: <20240304130036.124418-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
References: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x62b.google.com
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

Extends API with three new functions:
qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline_per_vcpu().

Those functions takes a qemu_plugin_u64 as input.

This allows to have a thread-safe and type-safe version of inline
operations.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h        |  1 +
 include/qemu/qemu-plugin.h   | 51 +++++++++++++++++++++++++++++++++++-
 plugins/plugin.h             |  6 +++++
 accel/tcg/plugin-gen.c       |  7 +++++
 plugins/api.c                | 37 +++++++++++++++++++++++++-
 plugins/core.c               | 23 ++++++++++++++++
 plugins/qemu-plugins.symbols |  3 +++
 7 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index bf96d2c2aa3..12a96cea2a4 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -92,6 +92,7 @@ struct qemu_plugin_dyn_cb {
     /* fields specific to each dyn_cb type go here */
     union {
         struct {
+            qemu_plugin_u64 entry;
             enum qemu_plugin_op op;
             uint64_t imm;
         } inline_insn;
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index ebf9a645e15..6bbad068c01 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -328,6 +328,22 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm);
 
+/**
+ * qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu() - execution inline op
+ * @tb: the opaque qemu_plugin_tb handle for the translation
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @entry: entry to run op
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op on a given scoreboard entry.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+    struct qemu_plugin_tb *tb,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm);
+
 /**
  * qemu_plugin_register_vcpu_insn_exec_cb() - register insn execution cb
  * @insn: the opaque qemu_plugin_insn handle for an instruction
@@ -358,6 +374,22 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm);
 
+/**
+ * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inline op
+ * @insn: the opaque qemu_plugin_insn handle for an instruction
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @entry: entry to run op
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op to every time an instruction executes.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm);
+
 /**
  * qemu_plugin_tb_n_insns() - query helper for number of insns in TB
  * @tb: opaque handle to TB passed to callback
@@ -583,7 +615,24 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_op op, void *ptr,
                                           uint64_t imm);
 
-
+/**
+ * qemu_plugin_register_vcpu_mem_inline_per_vcpu() - inline op for mem access
+ * @insn: handle for instruction to instrument
+ * @rw: apply to reads, writes or both
+ * @op: the op, of type qemu_plugin_op
+ * @entry: entry to run op
+ * @imm: immediate data for @op
+ *
+ * This registers a inline op every memory access generated by the
+ * instruction.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_mem_rw rw,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm);
 
 typedef void
 (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 3bf1aaf5c2d..f6fa10a0f56 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -73,6 +73,12 @@ void plugin_register_inline_op(GArray **arr,
                                enum qemu_plugin_op op, void *ptr,
                                uint64_t imm);
 
+void plugin_register_inline_op_on_entry(GArray **arr,
+                                        enum qemu_plugin_mem_rw rw,
+                                        enum qemu_plugin_op op,
+                                        qemu_plugin_u64 entry,
+                                        uint64_t imm);
+
 void plugin_reset_uninstall(qemu_plugin_id_t id,
                             qemu_plugin_simple_cb_t cb,
                             bool reset);
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 0f8be53d394..47e05ec6347 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -443,6 +443,13 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
     char *ptr = cb->userp;
     size_t elem_size = 0;
     size_t offset = 0;
+    if (!ptr) {
+        /* use inline entry */
+        ptr = cb->inline_insn.entry.score->data->data;
+        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
+        offset = cb->inline_insn.entry.offset;
+    }
+
     op = copy_ld_i32(&begin_op, op);
     op = copy_mul_i32(&begin_op, op, elem_size);
     op = copy_ext_i32_ptr(&begin_op, op);
diff --git a/plugins/api.c b/plugins/api.c
index d8b461bc69c..ac3982c6636 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -111,6 +111,18 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
     }
 }
 
+void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+    struct qemu_plugin_tb *tb,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm)
+{
+    if (!tb->mem_only) {
+        plugin_register_inline_op_on_entry(
+            &tb->cbs[PLUGIN_CB_INLINE], 0, op, entry, imm);
+    }
+}
+
 void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             qemu_plugin_vcpu_udata_cb_t cb,
                                             enum qemu_plugin_cb_flags flags,
@@ -136,6 +148,18 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
     }
 }
 
+void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm)
+{
+    if (!insn->mem_only) {
+        plugin_register_inline_op_on_entry(
+            &insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE], 0, op, entry, imm);
+    }
+}
+
 
 /*
  * We always plant memory instrumentation because they don't finalise until
@@ -148,7 +172,7 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       void *udata)
 {
     plugin_register_vcpu_mem_cb(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR],
-                                    cb, flags, rw, udata);
+                                cb, flags, rw, udata);
 }
 
 void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
@@ -160,6 +184,17 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                               rw, op, ptr, imm);
 }
 
+void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_mem_rw rw,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64 entry,
+    uint64_t imm)
+{
+    plugin_register_inline_op_on_entry(
+        &insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE], rw, op, entry, imm);
+}
+
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t cb)
 {
diff --git a/plugins/core.c b/plugins/core.c
index 65d5611f797..7852590da88 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -332,6 +332,23 @@ void plugin_register_inline_op(GArray **arr,
     dyn_cb->inline_insn.imm = imm;
 }
 
+void plugin_register_inline_op_on_entry(GArray **arr,
+                                        enum qemu_plugin_mem_rw rw,
+                                        enum qemu_plugin_op op,
+                                        qemu_plugin_u64 entry,
+                                        uint64_t imm)
+{
+    struct qemu_plugin_dyn_cb *dyn_cb;
+
+    dyn_cb = plugin_get_dyn_cb(arr);
+    dyn_cb->userp = NULL;
+    dyn_cb->type = PLUGIN_CB_INLINE;
+    dyn_cb->rw = rw;
+    dyn_cb->inline_insn.entry = entry;
+    dyn_cb->inline_insn.op = op;
+    dyn_cb->inline_insn.imm = imm;
+}
+
 void plugin_register_dyn_cb__udata(GArray **arr,
                                    qemu_plugin_vcpu_udata_cb_t cb,
                                    enum qemu_plugin_cb_flags flags,
@@ -480,6 +497,12 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
     char *ptr = cb->userp;
     size_t elem_size = 0;
     size_t offset = 0;
+    if (!ptr) {
+        /* use inline entry */
+        ptr = cb->inline_insn.entry.score->data->data;
+        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
+        offset = cb->inline_insn.entry.offset;
+    }
     uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
     switch (cb->inline_insn.op) {
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 6204453d0fd..0d8141b85f1 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -28,13 +28,16 @@
   qemu_plugin_register_vcpu_init_cb;
   qemu_plugin_register_vcpu_insn_exec_cb;
   qemu_plugin_register_vcpu_insn_exec_inline;
+  qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_mem_cb;
   qemu_plugin_register_vcpu_mem_inline;
+  qemu_plugin_register_vcpu_mem_inline_per_vcpu;
   qemu_plugin_register_vcpu_resume_cb;
   qemu_plugin_register_vcpu_syscall_cb;
   qemu_plugin_register_vcpu_syscall_ret_cb;
   qemu_plugin_register_vcpu_tb_exec_cb;
   qemu_plugin_register_vcpu_tb_exec_inline;
+  qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_tb_trans_cb;
   qemu_plugin_reset;
   qemu_plugin_scoreboard_free;
-- 
2.39.2


