Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E224C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wBt-000527-IS; Tue, 14 May 2024 13:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBg-0004tA-Vz
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:41 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBP-0004up-9C
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:32 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a5a8cd78701so76615266b.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715708583; x=1716313383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wX54r7jCIt7Ntr/JPAUQCG6KDcJXp0GRrKzlLq1dFvc=;
 b=BuHoXIdw7RIL+66Pzf8odZaT4ne55f0wOOcF8sAzRc/aqRURtuGTBAcPcqDzsrGLBO
 vyXExiH2uU23ITl2WyQwv4gFq6V1UlZhZ7/wCOvsjx87tVRFQMHlLYTM4fmkqmTD+TuD
 KSJxQy1iWXrgqeD26bPAYElM6ITtFNZHx6Sd3vlwhYlhJB32euMquGEu2WMFaF4ao7Z6
 8+ihyoCnb9D+HKASlu9IugVPQsNhyeOGOIGilqWZGCL3C8PziCyQy4iTdJ7P52NbPnWA
 AnY2y7rJgTX/M3vgPA9XVOL5ZidjuxDnAM0w22NvLav3I4A6PMcqf229bdcXBiFUyWfi
 VVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708583; x=1716313383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wX54r7jCIt7Ntr/JPAUQCG6KDcJXp0GRrKzlLq1dFvc=;
 b=uneFTjaibJtMkJJ9yYI+yGkwUg4mdZaNYbGW5B7dXArbhPLZ2Hb3CNcD4L5gEv4cbX
 /kHiGWLu78cK3b4kyity0walh0Kn+hzAOO/Lw0TPYrjGMZhiCj0xOOKOrQGLpez8ec4O
 NtKHl+3KKh4aFA9fdEAfwWeMUI6wKeA14qC93hWC9QHd0rSKhEefNjoDhCpn8TfsouLZ
 tfcJxLThFABhWFwdwKT3XQvJ7pJebsrYDDEZm3iDChGzuwkv4yCDcE00gThBsVumJEeQ
 Hao3CvYi8IAIuyIPFw2E4k1B+TJATlAH9w2O31RoO0nJm29gcN91r3Tbqir1KWRGqdXT
 O2og==
X-Gm-Message-State: AOJu0Yy8GIsa1STq5BlvTaOdd9hcsVtWlIpcEGsDYu9MOkEc4sJgVGND
 EuPZWd7UpPTV800TC0bhd+QOj9wvkCvR8UyxRFTKZ0AZNwysEIj7SaS2c4O1wFU=
X-Google-Smtp-Source: AGHT+IEEm8if6cO+V4OoKGPeUlZc+f/UVsA1islY8nRhToFglFPeBdObP3vdNhGRst6SUpPSd5SFJw==
X-Received: by 2002:a17:907:6d12:b0:a59:6fab:afee with SMTP id
 a640c23a62f3a-a5a2d65f2aamr1125993166b.62.1715708582838; 
 Tue, 14 May 2024 10:43:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cfa7sm743009466b.33.2024.05.14.10.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 10:42:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CCB095FA2B;
 Tue, 14 May 2024 18:42:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 09/11] plugins: distinct types for callbacks
Date: Tue, 14 May 2024 18:42:51 +0100
Message-Id: <20240514174253.694591-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240514174253.694591-1-alex.bennee@linaro.org>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/plugin.h  | 46 ++++++++++++++-----------
 plugins/plugin.h       |  2 +-
 accel/tcg/plugin-gen.c | 58 +++++++++++++++++---------------
 plugins/core.c         | 76 ++++++++++++++++++++++--------------------
 4 files changed, 98 insertions(+), 84 deletions(-)

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


