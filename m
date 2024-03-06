Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FABC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsS9-0007k4-G7; Wed, 06 Mar 2024 09:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS6-0007W4-Jc
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:02 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRz-0001UR-HF
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:02 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412f1fc5613so8572795e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736054; x=1710340854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7+jt6o7kz3/aqRrKxY2ocgaFJKGCRn1g3WUam5fQ0Y=;
 b=vGceSL6h/1qkl72t5S9OGzPwU76taEmq21CWH0O9s3ptfXNX+HKXr3tfx1A0R8ysBs
 gsJTUztOQCnNKL8AKkJAIEM+5zK2Aa4WgEvH7t8VbD/UBlujzA3h1fpQhvZuUiKq71gE
 Eur5+OoDlmm67Xuy0KKNXiOzk/Y/gRiN7VpdYQ+IDAJY7JZpHkQ8RvRhJFatVKRD8ffd
 BMlpeW2zx/+PN9QXVa9P/RacsgjXeGQgZP8C8PQMBL0CWT/7tvVBO1RsqG8S0n8+y4UK
 aoaBnkWNyORaRWtbSqjY0HjomJacwYem0t8u+czhUgu67WF5KD1qKzexW46xkzC7pGL6
 xIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736054; x=1710340854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7+jt6o7kz3/aqRrKxY2ocgaFJKGCRn1g3WUam5fQ0Y=;
 b=UdFb99Op+0C5kBCuyyGSp/JzSuf35ODVbn2sAJitMHjYHLWoJIVrGJiqFPhZFDlFL6
 BaO/7suVQTUMUczzB1tHcGH/DpNsZU3oRXD+LMdc5Pd3goblJQNbsj4KA8PEDyv9DCK+
 qjtchGXJg3WkV26e8WQEiBT6Bnj4gbWzq5pAxFVAW8PGaZvwEFYjdLXmgtsqaxHZ9wr9
 s+EPki+/qLId/EXHfGnxdnYlXkq6IjvSAAx0yhoUihYLtGMZ4F7ZZVC/iD6RMufzozbN
 0ONw/TtTlq72zLngFm7K1nC23xRlBaHe6lZ+67BZ+hCEuSDqAR9cMscoEsyawm59UntZ
 KRFg==
X-Gm-Message-State: AOJu0Yw/Ia6Xv0YI9sqfhQ7L/t9EBk8OYMf2OW73yDfXYKnZVEqSDlnL
 8hHYh6Mn1fR0CT3c1XzobC5ynsAIy+bH0qd7ZXfaiLVptD1tBqBl0gWPoTBxc2M=
X-Google-Smtp-Source: AGHT+IHKIQuxhqwm86v1aQJqUi+mDo0urmvXGYrxz1sUrw3l8GURDrPe5QWPzjmhkXw4SheFRwvLgw==
X-Received: by 2002:a05:600c:4691:b0:411:fe7d:ac4 with SMTP id
 p17-20020a05600c469100b00411fe7d0ac4mr11264724wmo.24.1709736054084; 
 Wed, 06 Mar 2024 06:40:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a14-20020a05600c348e00b00412f74d25b6sm1772674wmq.39.2024.03.06.06.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1BC495F9DE;
 Wed,  6 Mar 2024 14:40:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 16/29] plugins: implement inline operation relative to cpu_index
Date: Wed,  6 Mar 2024 14:40:28 +0000
Message-Id: <20240306144041.3787188-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Instead of working on a fixed memory location, allow to address it based
on cpu_index, an element size and a given offset.
Result address: ptr + offset + cpu_index * element_size.

With this, we can target a member in a struct array from a base pointer.

Current semantic is not modified, thus inline operation still targets
always the same memory location.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240304130036.124418-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-17-alex.bennee@linaro.org>

diff --git a/plugins/plugin.h b/plugins/plugin.h
index 043c740067d..3bf1aaf5c2d 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -99,7 +99,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
                                  enum qemu_plugin_mem_rw rw,
                                  void *udata);
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
 
 int plugin_num_vcpus(void);
 
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index ac6b52b9ec9..0f8be53d394 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -133,16 +133,28 @@ static void gen_empty_udata_cb_no_rwg(void)
  */
 static void gen_empty_inline_cb(void)
 {
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
     TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
 
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    /* second operand will be replaced by immediate value */
+    tcg_gen_mul_i32(cpu_index, cpu_index, cpu_index);
+    tcg_gen_ext_i32_ptr(cpu_index_as_ptr, cpu_index);
+
     tcg_gen_movi_ptr(ptr, 0);
+    tcg_gen_add_ptr(ptr, ptr, cpu_index_as_ptr);
     tcg_gen_ld_i64(val, ptr, 0);
-    /* pass an immediate != 0 so that it doesn't get optimized away */
-    tcg_gen_addi_i64(val, val, 0xdeadface);
+    /* second operand will be replaced by immediate value */
+    tcg_gen_add_i64(val, val, val);
+
     tcg_gen_st_i64(val, ptr, 0);
     tcg_temp_free_ptr(ptr);
     tcg_temp_free_i64(val);
+    tcg_temp_free_ptr(cpu_index_as_ptr);
+    tcg_temp_free_i32(cpu_index);
 }
 
 static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
@@ -290,12 +302,37 @@ static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
     return op;
 }
 
+static TCGOp *copy_ld_i32(TCGOp **begin_op, TCGOp *op)
+{
+    return copy_op(begin_op, op, INDEX_op_ld_i32);
+}
+
+static TCGOp *copy_ext_i32_ptr(TCGOp **begin_op, TCGOp *op)
+{
+    if (UINTPTR_MAX == UINT32_MAX) {
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+    } else {
+        op = copy_op(begin_op, op, INDEX_op_ext_i32_i64);
+    }
+    return op;
+}
+
+static TCGOp *copy_add_ptr(TCGOp **begin_op, TCGOp *op)
+{
+    if (UINTPTR_MAX == UINT32_MAX) {
+        op = copy_op(begin_op, op, INDEX_op_add_i32);
+    } else {
+        op = copy_op(begin_op, op, INDEX_op_add_i64);
+    }
+    return op;
+}
+
 static TCGOp *copy_ld_i64(TCGOp **begin_op, TCGOp *op)
 {
     if (TCG_TARGET_REG_BITS == 32) {
         /* 2x ld_i32 */
-        op = copy_op(begin_op, op, INDEX_op_ld_i32);
-        op = copy_op(begin_op, op, INDEX_op_ld_i32);
+        op = copy_ld_i32(begin_op, op);
+        op = copy_ld_i32(begin_op, op);
     } else {
         /* ld_i64 */
         op = copy_op(begin_op, op, INDEX_op_ld_i64);
@@ -331,6 +368,13 @@ static TCGOp *copy_add_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
     return op;
 }
 
+static TCGOp *copy_mul_i32(TCGOp **begin_op, TCGOp *op, uint32_t v)
+{
+    op = copy_op(begin_op, op, INDEX_op_mul_i32);
+    op->args[2] = tcgv_i32_arg(tcg_constant_i32(v));
+    return op;
+}
+
 static TCGOp *copy_st_ptr(TCGOp **begin_op, TCGOp *op)
 {
     if (UINTPTR_MAX == UINT32_MAX) {
@@ -396,18 +440,17 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
                                TCGOp *begin_op, TCGOp *op,
                                int *unused)
 {
-    /* const_ptr */
-    op = copy_const_ptr(&begin_op, op, cb->userp);
-
-    /* ld_i64 */
+    char *ptr = cb->userp;
+    size_t elem_size = 0;
+    size_t offset = 0;
+    op = copy_ld_i32(&begin_op, op);
+    op = copy_mul_i32(&begin_op, op, elem_size);
+    op = copy_ext_i32_ptr(&begin_op, op);
+    op = copy_const_ptr(&begin_op, op, ptr + offset);
+    op = copy_add_ptr(&begin_op, op);
     op = copy_ld_i64(&begin_op, op);
-
-    /* add_i64 */
     op = copy_add_i64(&begin_op, op, cb->inline_insn.imm);
-
-    /* st_i64 */
     op = copy_st_i64(&begin_op, op);
-
     return op;
 }
 
diff --git a/plugins/api.c b/plugins/api.c
index 8910cbb2c46..fa1daee8254 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -106,7 +106,8 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               void *ptr, uint64_t imm)
 {
     if (!tb->mem_only) {
-        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE], 0, op, ptr, imm);
+        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
+                                  0, op, ptr, imm);
     }
 }
 
diff --git a/plugins/core.c b/plugins/core.c
index 63f4c6c6ce3..65d5611f797 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -318,7 +318,8 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
 
 void plugin_register_inline_op(GArray **arr,
                                enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op, void *ptr,
+                               enum qemu_plugin_op op,
+                               void *ptr,
                                uint64_t imm)
 {
     struct qemu_plugin_dyn_cb *dyn_cb;
@@ -474,9 +475,12 @@ void qemu_plugin_flush_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb)
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 {
-    uint64_t *val = cb->userp;
+    char *ptr = cb->userp;
+    size_t elem_size = 0;
+    size_t offset = 0;
+    uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
     switch (cb->inline_insn.op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
@@ -509,7 +513,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                            vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE:
-            exec_inline_op(cb);
+            exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
             g_assert_not_reached();
-- 
2.39.2


