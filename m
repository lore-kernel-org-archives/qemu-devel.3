Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1910C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTec-0004Vn-4q; Tue, 05 Mar 2024 07:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTdV-00027R-8a
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:11:09 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcr-0001Vm-F4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:11:08 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412e68b8594so13695825e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640620; x=1710245420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIcFUMFR8l8AdO4VO4aK3T+8dAGB+Lm2FLrmrkejrpQ=;
 b=uhug2XDSn1JSjIGxqC6Q2vUpLWNCpXAqRLiWReZnE2SurvNRpOT1ymAAVqr/8ap/1T
 ngTYOWCQLiAb3ELovdy894AcKZ0BPGnFFbtbb+EE3Dgiks+ea4Kq3mffS4ZStI8JF/6H
 lf5+F3Gfyvemt3mnmZ/Idpn/vemq4xvWryFqKCwtxRLgU26mDza0hnHtfj23UmkrOlMu
 IMpmUA8wibqVPTeQy3EHrrhENewzyYZbH8Mz0GfHiZcjUUICfBf4WN1QaR1JVm9nEiAG
 Ebiqwi2658WHogGUJZVBNpRUORTKbwOGCyZeGDtcqtasIGBQPitUa01TTm6mL0LNq1hZ
 quiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640620; x=1710245420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIcFUMFR8l8AdO4VO4aK3T+8dAGB+Lm2FLrmrkejrpQ=;
 b=bZRihmUeixDmhIRbZMp/Kgc8CgRDrp9qkAOe1H7rndjI37eUumLhEmUFH4RIqxzE2z
 KVaXruHmlr6EEbBrNwX8m+1OW4Wv2aVOhRGTgSFNVi3CocpAujvB757FhxV1Ycv3RXJ6
 +cogWwtSwugj9t2a/p5eVoGsZhSjVXEhebJ+KyprK0J61e4wjRhJMpn96t7HaQwEV7H9
 hWV0xzP3Dmjcrs5IEYDLXuWxF9yJAaDDsnci4kzTR3oLnNeYoz4pmuLIbQVEQlNu3FVH
 WnYlvqgBfwnlETRjiqon3EisG63cMvm7IHhHK+BTIZt0U34jCBPLl5NB/IzbTxHbvs3u
 fnmA==
X-Gm-Message-State: AOJu0Yw+T0X7O6WWMQN0xyUYu3uQ1p0QZh/kDM0sTXOUD+eCEaBudorR
 yDu7c8Oa+Be/quSdYFzJLSGlrvcqhvbU+Wlzo/xxrXgEOhEklt9M/g7PicGSsVw=
X-Google-Smtp-Source: AGHT+IFjCeMtWgA+j8gDbHxFGwMV2Nr9SqNrT+WkzlaxJmoXUVMOBCmP6QtzdfYFB85G+30bmPnMyg==
X-Received: by 2002:a05:600c:b89:b0:412:ea5c:20cb with SMTP id
 fl9-20020a05600c0b8900b00412ea5c20cbmr1787146wmb.11.1709640620256; 
 Tue, 05 Mar 2024 04:10:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h5-20020adf9cc5000000b0033dd9b050f9sm14657874wre.14.2024.03.05.04.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2234C5F9E2;
 Tue,  5 Mar 2024 12:10:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 17/29] plugins: add inline operation per vcpu
Date: Tue,  5 Mar 2024 12:09:53 +0000
Message-Id: <20240305121005.3528075-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Extends API with three new functions:
qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline_per_vcpu().

Those functions takes a qemu_plugin_u64 as input.

This allows to have a thread-safe and type-safe version of inline
operations.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240304130036.124418-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
index fa1daee8254..6470f1dc0f2 100644
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


