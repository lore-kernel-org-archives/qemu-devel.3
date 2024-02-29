Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B89C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZNE-0004kD-N5; Thu, 29 Feb 2024 00:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfZN9-0004iz-5F
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:54:24 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfZN5-00078J-8F
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:54:22 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d27fef509eso5215411fa.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709186057; x=1709790857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Me3OEI9uAFKvJ39rcqYxa2Su22EDHEjf6zlAWCN02mI=;
 b=x8zFrz32KBvSEdKOJNcMXgI084SvVanunQkjA8Y8ndnB6m4UMBmh+SxoJ1BYIWA9Tp
 yxNIoyEoNxydJH+psCTEbSLV24ywehlFEpoBgZJtSgfssuONl3jC/4BlrUvCD7RKFIqy
 b3g5++kNPeSxqyG6TbH92fOMsY5HA5a9YZlflBmQrnaeKSR70EwRXOCJzyxrOBxnw8HN
 4iCq4u8SaoSo6qrBIUD/X2qJ+/3HrlexZMLlX+Jj9VrSexd25DJYCEE33hwTJf0JWgOn
 dwhpa0l2X8JVp/ZSne4yMujU8JNeVVLTsfF7mZs73MB/6BHhgN4e5KYAXRAuevpG8pL5
 j2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709186057; x=1709790857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Me3OEI9uAFKvJ39rcqYxa2Su22EDHEjf6zlAWCN02mI=;
 b=X4dSexjwyZDCUupuwhkLMuSQb2F/CcsQCrWv2Wh0B9JZHCrNd8yMbIs8kqUVQh6eto
 2X9su+ownZW1fQFk8hGxO1QA2MaSsCDzvoooEMN+dtn9CPLf5O7D97cKdXFoY8CSCDRZ
 IuzjqSk0CX5c4sSUx5js45KwGLpBHvp7NBCp6n9HZrFSQQdVYAlYxYsEoMdXBKhRgUW4
 4oMU7iz4zH8YCNttpHbNnTmfFShonK95CR3+LD3IZ25RKdULLTO9i42JmbK1bo7cNlcg
 NfGavYrn+5wx7eEpUVJg9YtKuSzDiQGL1tX3qK2y0JtDW7tOs0K6hRBxUddo4DTCEI4q
 fDSg==
X-Gm-Message-State: AOJu0YzcfbCmXIWUUK4X9CTnn0JeXAKr9gNwYKIX7DXTI2gap1aVOhiR
 R2VP1LxZSA572F4JNAjbGFl1rg056MF81slGTckavejKOfXo4XslVLCK4Fnbz2mSJzCBbTmutDH
 wpWA=
X-Google-Smtp-Source: AGHT+IHIONfvDI12OPIZ3NasmU43+az96CHi+xIN5iy+IvQboljEA+NadKYOpf9vTVKMaw+Q3WTMVw==
X-Received: by 2002:a2e:9f49:0:b0:2d2:fc30:5bad with SMTP id
 v9-20020a2e9f49000000b002d2fc305badmr486221ljk.29.1709186056688; 
 Wed, 28 Feb 2024 21:54:16 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 ck12-20020a5d5e8c000000b0033d2541b3e1sm721589wrb.72.2024.02.28.21.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 21:54:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/5] plugins: add new inline op STORE_U64
Date: Thu, 29 Feb 2024 09:53:56 +0400
Message-ID: <20240229055359.972151-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
References: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lj1-x22c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h      |   1 +
 include/qemu/qemu-plugin.h |   4 +-
 accel/tcg/plugin-gen.c     | 114 ++++++++++++++++++++++++++++++++++++-
 plugins/api.c              |   2 +
 plugins/core.c             |   4 ++
 5 files changed, 120 insertions(+), 5 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 33a7cbe910c..d92d64744e6 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -75,6 +75,7 @@ enum plugin_dyn_cb_subtype {
     PLUGIN_CB_REGULAR,
     PLUGIN_CB_REGULAR_R,
     PLUGIN_CB_INLINE_ADD_U64,
+    PLUGIN_CB_INLINE_STORE_U64,
     PLUGIN_N_CB_SUBTYPES,
 };
 
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4fc6c3739b2..c5cac897a0b 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -305,12 +305,12 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
  * enum qemu_plugin_op - describes an inline op
  *
  * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t
- *
- * Note: currently only a single inline op is supported.
+ * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t
  */
 
 enum qemu_plugin_op {
     QEMU_PLUGIN_INLINE_ADD_U64,
+    QEMU_PLUGIN_INLINE_STORE_U64,
 };
 
 /**
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 494467e0833..02c894106e2 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -46,8 +46,9 @@
 #include "qemu/plugin.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
-#include "tcg/tcg-temp-internal.h"
+#include "tcg/tcg-internal.h"
 #include "tcg/tcg-op.h"
+#include "tcg/tcg-temp-internal.h"
 #include "exec/exec-all.h"
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
@@ -82,6 +83,7 @@ enum plugin_gen_cb {
     PLUGIN_GEN_CB_UDATA,
     PLUGIN_GEN_CB_UDATA_R,
     PLUGIN_GEN_CB_INLINE_ADD_U64,
+    PLUGIN_GEN_CB_INLINE_STORE_U64,
     PLUGIN_GEN_CB_MEM,
     PLUGIN_GEN_ENABLE_MEM_HELPER,
     PLUGIN_GEN_DISABLE_MEM_HELPER,
@@ -153,6 +155,30 @@ static void gen_empty_inline_cb_add_u64(void)
     tcg_temp_free_i32(cpu_index);
 }
 
+static void gen_empty_inline_cb_store_u64(void)
+{
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
+    TCGv_i64 val = tcg_temp_ebb_new_i64();
+    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
+
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    /* second operand will be replaced by immediate value */
+    tcg_gen_mul_i32(cpu_index, cpu_index, cpu_index);
+    tcg_gen_ext_i32_ptr(cpu_index_as_ptr, cpu_index);
+    tcg_gen_movi_ptr(ptr, 0);
+    tcg_gen_add_ptr(ptr, ptr, cpu_index_as_ptr);
+
+    tcg_gen_movi_i64(val, 0);
+    tcg_gen_st_i64(val, ptr, 0);
+
+    tcg_temp_free_ptr(ptr);
+    tcg_temp_free_i64(val);
+    tcg_temp_free_ptr(cpu_index_as_ptr);
+    tcg_temp_free_i32(cpu_index);
+}
+
 static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
@@ -218,6 +244,8 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
         /* emit inline op before any callback */
         gen_wrapped(from, PLUGIN_GEN_CB_INLINE_ADD_U64,
                     gen_empty_inline_cb_add_u64);
+        gen_wrapped(from, PLUGIN_GEN_CB_INLINE_STORE_U64,
+                    gen_empty_inline_cb_store_u64);
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb_no_rwg);
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA_R, gen_empty_udata_cb_no_wg);
         break;
@@ -235,6 +263,11 @@ void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info)
     gen_empty_inline_cb_add_u64();
     tcg_gen_plugin_cb_end();
 
+    gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM,
+                        PLUGIN_GEN_CB_INLINE_STORE_U64, rw);
+    gen_empty_inline_cb_store_u64();
+    tcg_gen_plugin_cb_end();
+
     gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM, PLUGIN_GEN_CB_MEM, rw);
     gen_empty_mem_cb(addr, info);
     tcg_gen_plugin_cb_end();
@@ -352,6 +385,20 @@ static TCGOp *copy_st_i64(TCGOp **begin_op, TCGOp *op)
     return op;
 }
 
+static TCGOp *copy_mov_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        op->args[1] = tcgv_i32_arg(TCGV_LOW(tcg_constant_i64(v)));
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        op->args[1] = tcgv_i32_arg(TCGV_HIGH(tcg_constant_i64(v)));
+    } else {
+        op = copy_op(begin_op, op, INDEX_op_mov_i64);
+        op->args[1] = tcgv_i64_arg(tcg_constant_i64(v));
+    }
+    return op;
+}
+
 static TCGOp *copy_add_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
 {
     if (TCG_TARGET_REG_BITS == 32) {
@@ -455,6 +502,24 @@ static TCGOp *append_inline_cb_add_u64(const struct qemu_plugin_dyn_cb *cb,
     return op;
 }
 
+static TCGOp *append_inline_cb_store_u64(const struct qemu_plugin_dyn_cb *cb,
+                                       TCGOp *begin_op, TCGOp *op,
+                                       int *unused)
+{
+    char *ptr = cb->inline_insn.entry.score->data->data;
+    size_t elem_size = g_array_get_element_size(
+        cb->inline_insn.entry.score->data);
+    size_t offset = cb->inline_insn.entry.offset;
+    op = copy_ld_i32(&begin_op, op);
+    op = copy_mul_i32(&begin_op, op, elem_size);
+    op = copy_ext_i32_ptr(&begin_op, op);
+    op = copy_const_ptr(&begin_op, op, ptr + offset);
+    op = copy_add_ptr(&begin_op, op);
+    op = copy_mov_i64(&begin_op, op, cb->inline_insn.imm);
+    op = copy_st_i64(&begin_op, op);
+    return op;
+}
+
 static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
                             TCGOp *begin_op, TCGOp *op, int *cb_idx)
 {
@@ -542,6 +607,12 @@ inject_inline_cb_add_u64(const GArray *cbs, TCGOp *begin_op, op_ok_fn ok)
     inject_cb_type(cbs, begin_op, append_inline_cb_add_u64, ok);
 }
 
+static void
+inject_inline_cb_store_u64(const GArray *cbs, TCGOp *begin_op, op_ok_fn ok)
+{
+    inject_cb_type(cbs, begin_op, append_inline_cb_store_u64, ok);
+}
+
 static void
 inject_mem_cb(const GArray *cbs, TCGOp *begin_op)
 {
@@ -583,13 +654,14 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
                                      struct qemu_plugin_insn *plugin_insn,
                                      TCGOp *begin_op)
 {
-    GArray *cbs[2];
+    GArray *cbs[3];
     GArray *arr;
     size_t n_cbs, i;
 
     /* emit inline op before any callback */
     cbs[0] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE_ADD_U64];
-    cbs[1] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
+    cbs[1] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE_STORE_U64];
+    cbs[2] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
 
     n_cbs = 0;
     for (i = 0; i < ARRAY_SIZE(cbs); i++) {
@@ -662,6 +734,13 @@ static void plugin_gen_tb_inline_add_u64(const struct qemu_plugin_tb *ptb,
                              begin_op, op_ok);
 }
 
+static void plugin_gen_tb_inline_store_u64(const struct qemu_plugin_tb *ptb,
+                                         TCGOp *begin_op)
+{
+    inject_inline_cb_store_u64(ptb->cbs[PLUGIN_CB_INLINE_STORE_U64],
+                             begin_op, op_ok);
+}
+
 static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
                                   TCGOp *begin_op, int insn_idx)
 {
@@ -686,6 +765,14 @@ static void plugin_gen_insn_inline_add_u64(const struct qemu_plugin_tb *ptb,
         insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE_ADD_U64], begin_op, op_ok);
 }
 
+static void plugin_gen_insn_inline_store_u64(const struct qemu_plugin_tb *ptb,
+                                             TCGOp *begin_op, int insn_idx)
+{
+    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
+    inject_inline_cb_store_u64(
+        insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE_STORE_U64], begin_op, op_ok);
+}
+
 static void plugin_gen_mem_regular(const struct qemu_plugin_tb *ptb,
                                    TCGOp *begin_op, int insn_idx)
 {
@@ -701,6 +788,15 @@ static void plugin_gen_mem_inline_add_u64(const struct qemu_plugin_tb *ptb,
                              begin_op, op_rw);
 }
 
+static void plugin_gen_mem_inline_store_u64(const struct qemu_plugin_tb *ptb,
+                                            TCGOp *begin_op, int insn_idx)
+{
+    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
+    inject_inline_cb_store_u64(
+        insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE_STORE_U64],
+        begin_op, op_rw);
+}
+
 static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
                                          TCGOp *begin_op, int insn_idx)
 {
@@ -750,6 +846,9 @@ static void pr_ops(void)
             case PLUGIN_GEN_CB_INLINE_ADD_U64:
                 type = "inline add u64";
                 break;
+            case PLUGIN_GEN_CB_INLINE_STORE_U64:
+                type = "inline store u64";
+                break;
             case PLUGIN_GEN_CB_MEM:
                 type = "mem";
                 break;
@@ -801,6 +900,9 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 case PLUGIN_GEN_CB_INLINE_ADD_U64:
                     plugin_gen_tb_inline_add_u64(plugin_tb, op);
                     break;
+                case PLUGIN_GEN_CB_INLINE_STORE_U64:
+                    plugin_gen_tb_inline_store_u64(plugin_tb, op);
+                    break;
                 default:
                     g_assert_not_reached();
                 }
@@ -820,6 +922,9 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 case PLUGIN_GEN_CB_INLINE_ADD_U64:
                     plugin_gen_insn_inline_add_u64(plugin_tb, op, insn_idx);
                     break;
+                case PLUGIN_GEN_CB_INLINE_STORE_U64:
+                    plugin_gen_insn_inline_store_u64(plugin_tb, op, insn_idx);
+                    break;
                 case PLUGIN_GEN_ENABLE_MEM_HELPER:
                     plugin_gen_enable_mem_helper(plugin_tb, op, insn_idx);
                     break;
@@ -839,6 +944,9 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 case PLUGIN_GEN_CB_INLINE_ADD_U64:
                     plugin_gen_mem_inline_add_u64(plugin_tb, op, insn_idx);
                     break;
+                case PLUGIN_GEN_CB_INLINE_STORE_U64:
+                    plugin_gen_mem_inline_store_u64(plugin_tb, op, insn_idx);
+                    break;
                 default:
                     g_assert_not_reached();
                 }
diff --git a/plugins/api.c b/plugins/api.c
index e3bcacfa99a..4a033c16f83 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -60,6 +60,8 @@ static enum plugin_dyn_cb_subtype op_to_cb_subtype(enum qemu_plugin_op op)
     switch (op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
         return PLUGIN_CB_INLINE_ADD_U64;
+    case QEMU_PLUGIN_INLINE_STORE_U64:
+        return PLUGIN_CB_INLINE_STORE_U64;
     default:
         g_assert_not_reached();
     }
diff --git a/plugins/core.c b/plugins/core.c
index a641a366ef9..11f72594229 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -489,6 +489,9 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
     case QEMU_PLUGIN_INLINE_ADD_U64:
         *val += cb->inline_insn.imm;
         break;
+    case QEMU_PLUGIN_INLINE_STORE_U64:
+        *val = cb->inline_insn.imm;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -516,6 +519,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                            vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE_ADD_U64:
+        case PLUGIN_CB_INLINE_STORE_U64:
             exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
-- 
2.43.0


