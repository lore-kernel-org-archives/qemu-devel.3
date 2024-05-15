Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ADBC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 20:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7LAH-0001Bw-SI; Wed, 15 May 2024 16:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LAA-000162-27
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:46 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA7-0004G0-OS
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:45 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-571ba432477so2591134a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715804622; x=1716409422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bXHRvWlSsrqLOU+JD9FMWAnLR6DYfiZlr5lK1ZGdEPU=;
 b=lpYx4HDI2r/FVSrY+0A7S20UycC4sNSQcQTP3SCvVKSP5ePY9YrKf3g2a542XrTFAS
 4UraRT3L6dY5weyhkWjyyFcLVH/X5fWGXydYywvBripO97+bQvNauVCC/VpPUGzqIkUG
 EQVOIaSXJCYeIWiDLrUW+qrP9Qj5g7D0oU+zlxHUEjiZPqLrM/gqsxI7jjvkW/JCEbo1
 91YyR9dyZHnQMekbvjFG0BGiJGxTKL12axCAaKSzQRKR1AFdGyjJpSzJXOrfoQN5o1ry
 h419qWKM+i55ZYN1qKIYBH4wMyE4QTphuqG00CmtrtAwcRnvglDZj4+5QcWwslZXXI4y
 VcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715804622; x=1716409422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXHRvWlSsrqLOU+JD9FMWAnLR6DYfiZlr5lK1ZGdEPU=;
 b=h9O/pCtQmaLwXjlJGXeEeRO0odc2i2ThsRQaGePoM9QFoh9FfN2hYnONy9ywIV7mrU
 tYgY5i9pCrI/64gLEJSubbA/FhqlJ9YUihfavhoevdzMxNrO9CIJEwW66nebnNP35VuF
 5xV5K2pu8BZ7ZlXhol3+TPRvMUIjU1utZLaiVA6C1r8UTuC5dTelDl6wzB3f8r9NoSLu
 FbagQoTcBb+9HmpDRRwtcOMGcwZScMbUFiWuqkr9LYFb0dM2cgNeq4HUUj9f9sF46OAk
 rVuVYXX75eeR1tP/P5nIshZuDGYFLsM3aqtBI/TJArsPP5RBcz043mv5PngT7eS9n57y
 PqNQ==
X-Gm-Message-State: AOJu0Ywq04AzJVSG+cUB71u1Ru34GPSldTmnpTaRXBHOtuAS9t/sr4nG
 5HtoXRdZNKqJ68mga4RudSML5uJ9XmOBrCK6RZVzzHvdjaQKyfg++WabmVCkkMw=
X-Google-Smtp-Source: AGHT+IHg8jZDOi0deXSQFdBrDI6o59+y4g3LhatUtrvqcvMu+HTp8tPjFgmqP9+842HubuVeo29Gnw==
X-Received: by 2002:a17:906:eb16:b0:a59:9dc5:d655 with SMTP id
 a640c23a62f3a-a5a2d5c9f74mr1131770866b.41.1715804622077; 
 Wed, 15 May 2024 13:23:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7dd4sm898805566b.139.2024.05.15.13.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 13:23:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B4C15FA2B;
 Wed, 15 May 2024 21:23:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 09/11] plugins: distinct types for callbacks
Date: Wed, 15 May 2024 21:23:32 +0100
Message-Id: <20240515202334.710324-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515202334.710324-1-alex.bennee@linaro.org>
References: <20240515202334.710324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

To prevent errors when writing new types of callbacks or inline
operations, we split callbacks data to distinct types.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240502211522.346467-8-pierrick.bouvier@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240514174253.694591-10-alex.bennee@linaro.org>

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index c7b3b1cd66..98d27dded9 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -74,34 +74,40 @@ enum plugin_dyn_cb_type {
     PLUGIN_CB_INLINE_STORE_U64,
 };
 
+struct qemu_plugin_regular_cb {
+    union qemu_plugin_cb_sig f;
+    TCGHelperInfo *info;
+    void *userp;
+    enum qemu_plugin_mem_rw rw;
+};
+
+struct qemu_plugin_inline_cb {
+    qemu_plugin_u64 entry;
+    enum qemu_plugin_op op;
+    uint64_t imm;
+    enum qemu_plugin_mem_rw rw;
+};
+
+struct qemu_plugin_conditional_cb {
+    union qemu_plugin_cb_sig f;
+    TCGHelperInfo *info;
+    void *userp;
+    qemu_plugin_u64 entry;
+    enum qemu_plugin_cond cond;
+    uint64_t imm;
+};
+
 /*
  * A dynamic callback has an insertion point that is determined at run-time.
  * Usually the insertion point is somewhere in the code cache; think for
  * instance of a callback to be called upon the execution of a particular TB.
  */
 struct qemu_plugin_dyn_cb {
-    void *userp;
     enum plugin_dyn_cb_type type;
-    /* @rw applies to mem callbacks only (both regular and inline) */
-    enum qemu_plugin_mem_rw rw;
-    /* fields specific to each dyn_cb type go here */
     union {
-        struct {
-            union qemu_plugin_cb_sig f;
-            TCGHelperInfo *info;
-        } regular;
-        struct {
-            union qemu_plugin_cb_sig f;
-            TCGHelperInfo *info;
-            qemu_plugin_u64 entry;
-            enum qemu_plugin_cond cond;
-            uint64_t imm;
-        } cond;
-        struct {
-            qemu_plugin_u64 entry;
-            enum qemu_plugin_op op;
-            uint64_t imm;
-        } inline_insn;
+        struct qemu_plugin_regular_cb regular;
+        struct qemu_plugin_conditional_cb cond;
+        struct qemu_plugin_inline_cb inline_insn;
     };
 };
 
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 7d4b4e21f7..80d5daa917 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -108,7 +108,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
                                  enum qemu_plugin_mem_rw rw,
                                  void *udata);
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
+void exec_inline_op(struct qemu_plugin_inline_cb *cb, int cpu_index);
 
 int plugin_num_vcpus(void);
 
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index f2190f3511..e018728573 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -101,13 +101,13 @@ static void gen_disable_mem_helper(void)
                    offsetof(ArchCPU, env));
 }
 
-static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
+static void gen_udata_cb(struct qemu_plugin_regular_cb *cb)
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
 
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    tcg_gen_call2(cb->regular.f.vcpu_udata, cb->regular.info, NULL,
+    tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
     tcg_temp_free_i32(cpu_index);
@@ -153,21 +153,21 @@ static TCGCond plugin_cond_to_tcgcond(enum qemu_plugin_cond cond)
     }
 }
 
-static void gen_udata_cond_cb(struct qemu_plugin_dyn_cb *cb)
+static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
 {
-    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->cond.entry);
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->entry);
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGLabel *after_cb = gen_new_label();
 
     /* Condition should be negated, as calling the cb is the "else" path */
-    TCGCond cond = tcg_invert_cond(plugin_cond_to_tcgcond(cb->cond.cond));
+    TCGCond cond = tcg_invert_cond(plugin_cond_to_tcgcond(cb->cond));
 
     tcg_gen_ld_i64(val, ptr, 0);
-    tcg_gen_brcondi_i64(cond, val, cb->cond.imm, after_cb);
+    tcg_gen_brcondi_i64(cond, val, cb->imm, after_cb);
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    tcg_gen_call2(cb->cond.f.vcpu_udata, cb->cond.info, NULL,
+    tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
     gen_set_label(after_cb);
@@ -177,37 +177,37 @@ static void gen_udata_cond_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_ptr(ptr);
 }
 
-static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
+static void gen_inline_add_u64_cb(struct qemu_plugin_inline_cb *cb)
 {
-    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->entry);
     TCGv_i64 val = tcg_temp_ebb_new_i64();
 
     tcg_gen_ld_i64(val, ptr, 0);
-    tcg_gen_addi_i64(val, val, cb->inline_insn.imm);
+    tcg_gen_addi_i64(val, val, cb->imm);
     tcg_gen_st_i64(val, ptr, 0);
 
     tcg_temp_free_i64(val);
     tcg_temp_free_ptr(ptr);
 }
 
-static void gen_inline_store_u64_cb(struct qemu_plugin_dyn_cb *cb)
+static void gen_inline_store_u64_cb(struct qemu_plugin_inline_cb *cb)
 {
-    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
-    TCGv_i64 val = tcg_constant_i64(cb->inline_insn.imm);
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->entry);
+    TCGv_i64 val = tcg_constant_i64(cb->imm);
 
     tcg_gen_st_i64(val, ptr, 0);
 
     tcg_temp_free_ptr(ptr);
 }
 
-static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
+static void gen_mem_cb(struct qemu_plugin_regular_cb *cb,
                        qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
 
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    tcg_gen_call4(cb->regular.f.vcpu_mem, cb->regular.info, NULL,
+    tcg_gen_call4(cb->f.vcpu_mem, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_i32_temp(tcg_constant_i32(meminfo)),
                   tcgv_i64_temp(addr),
@@ -220,16 +220,16 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
 {
     switch (cb->type) {
     case PLUGIN_CB_REGULAR:
-        gen_udata_cb(cb);
+        gen_udata_cb(&cb->regular);
         break;
     case PLUGIN_CB_COND:
-        gen_udata_cond_cb(cb);
+        gen_udata_cond_cb(&cb->cond);
         break;
     case PLUGIN_CB_INLINE_ADD_U64:
-        gen_inline_add_u64_cb(cb);
+        gen_inline_add_u64_cb(&cb->inline_insn);
         break;
     case PLUGIN_CB_INLINE_STORE_U64:
-        gen_inline_store_u64_cb(cb);
+        gen_inline_store_u64_cb(&cb->inline_insn);
         break;
     default:
         g_assert_not_reached();
@@ -240,15 +240,21 @@ static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
                           enum qemu_plugin_mem_rw rw,
                           qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
-    if (cb->rw & rw) {
-        switch (cb->type) {
-        case PLUGIN_CB_MEM_REGULAR:
-            gen_mem_cb(cb, meminfo, addr);
-            break;
-        default:
+    switch (cb->type) {
+    case PLUGIN_CB_MEM_REGULAR:
+        if (rw && cb->regular.rw) {
+            gen_mem_cb(&cb->regular, meminfo, addr);
+        }
+        break;
+    case PLUGIN_CB_INLINE_ADD_U64:
+    case PLUGIN_CB_INLINE_STORE_U64:
+        if (rw && cb->inline_insn.rw) {
             inject_cb(cb);
-            break;
         }
+        break;
+    default:
+        g_assert_not_reached();
+        break;
     }
 }
 
diff --git a/plugins/core.c b/plugins/core.c
index 332474a5bc..1c85edc5e5 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -336,13 +336,13 @@ void plugin_register_inline_op_on_entry(GArray **arr,
 {
     struct qemu_plugin_dyn_cb *dyn_cb;
 
+    struct qemu_plugin_inline_cb inline_cb = { .rw = rw,
+                                               .entry = entry,
+                                               .op = op,
+                                               .imm = imm };
     dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = NULL;
     dyn_cb->type = op_to_cb_type(op);
-    dyn_cb->rw = rw;
-    dyn_cb->inline_insn.entry = entry;
-    dyn_cb->inline_insn.op = op;
-    dyn_cb->inline_insn.imm = imm;
+    dyn_cb->inline_insn = inline_cb;
 }
 
 void plugin_register_dyn_cb__udata(GArray **arr,
@@ -361,14 +361,14 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
+    assert((unsigned)flags < ARRAY_SIZE(info));
 
     struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = udata;
+    struct qemu_plugin_regular_cb regular_cb = { .f.vcpu_udata = cb,
+                                                 .userp = udata,
+                                                 .info = &info[flags] };
     dyn_cb->type = PLUGIN_CB_REGULAR;
-    dyn_cb->regular.f.vcpu_udata = cb;
-
-    assert((unsigned)flags < ARRAY_SIZE(info));
-    dyn_cb->regular.info = &info[flags];
+    dyn_cb->regular = regular_cb;
 }
 
 void plugin_register_dyn_cond_cb__udata(GArray **arr,
@@ -390,17 +390,17 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
+    assert((unsigned)flags < ARRAY_SIZE(info));
 
     struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = udata;
+    struct qemu_plugin_conditional_cb cond_cb = { .userp = udata,
+                                                  .f.vcpu_udata = cb,
+                                                  .cond = cond,
+                                                  .entry = entry,
+                                                  .imm = imm,
+                                                  .info = &info[flags] };
     dyn_cb->type = PLUGIN_CB_COND;
-    dyn_cb->cond.f.vcpu_udata = cb;
-    dyn_cb->cond.cond = cond;
-    dyn_cb->cond.entry = entry;
-    dyn_cb->cond.imm = imm;
-
-    assert((unsigned)flags < ARRAY_SIZE(info));
-    dyn_cb->cond.info = &info[flags];
+    dyn_cb->cond = cond_cb;
 }
 
 void plugin_register_vcpu_mem_cb(GArray **arr,
@@ -432,15 +432,15 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
              dh_typemask(i64, 3) |
              dh_typemask(ptr, 4))
     };
+    assert((unsigned)flags < ARRAY_SIZE(info));
 
     struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = udata;
+    struct qemu_plugin_regular_cb regular_cb = { .userp = udata,
+                                                 .rw = rw,
+                                                 .f.vcpu_mem = cb,
+                                                 .info = &info[flags] };
     dyn_cb->type = PLUGIN_CB_MEM_REGULAR;
-    dyn_cb->rw = rw;
-    dyn_cb->regular.f.vcpu_mem = cb;
-
-    assert((unsigned)flags < ARRAY_SIZE(info));
-    dyn_cb->regular.info = &info[flags];
+    dyn_cb->regular = regular_cb;
 }
 
 /*
@@ -557,20 +557,20 @@ void qemu_plugin_flush_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
+void exec_inline_op(struct qemu_plugin_inline_cb *cb, int cpu_index)
 {
-    char *ptr = cb->inline_insn.entry.score->data->data;
+    char *ptr = cb->entry.score->data->data;
     size_t elem_size = g_array_get_element_size(
-        cb->inline_insn.entry.score->data);
-    size_t offset = cb->inline_insn.entry.offset;
+        cb->entry.score->data);
+    size_t offset = cb->entry.offset;
     uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
-    switch (cb->inline_insn.op) {
+    switch (cb->op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
-        *val += cb->inline_insn.imm;
+        *val += cb->imm;
         break;
     case QEMU_PLUGIN_INLINE_STORE_U64:
-        *val = cb->inline_insn.imm;
+        *val = cb->imm;
         break;
     default:
         g_assert_not_reached();
@@ -590,17 +590,19 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
         struct qemu_plugin_dyn_cb *cb =
             &g_array_index(arr, struct qemu_plugin_dyn_cb, i);
 
-        if (!(rw & cb->rw)) {
-                break;
-        }
         switch (cb->type) {
         case PLUGIN_CB_MEM_REGULAR:
-            cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
-                                   vaddr, cb->userp);
+            if (rw && cb->regular.rw) {
+                cb->regular.f.vcpu_mem(cpu->cpu_index,
+                                       make_plugin_meminfo(oi, rw),
+                                       vaddr, cb->regular.userp);
+            }
             break;
         case PLUGIN_CB_INLINE_ADD_U64:
         case PLUGIN_CB_INLINE_STORE_U64:
-            exec_inline_op(cb, cpu->cpu_index);
+            if (rw && cb->inline_insn.rw) {
+                exec_inline_op(&cb->inline_insn, cpu->cpu_index);
+            }
             break;
         default:
             g_assert_not_reached();
-- 
2.39.2


