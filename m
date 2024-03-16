Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A4CC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJJQ-00032Q-TD; Fri, 15 Mar 2024 21:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJE-0002xO-7W
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:05 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJ9-0000md-Rb
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:03 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1def59b537cso8376075ad.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554278; x=1711159078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXNCxUw+xNH5pFREtrweHMcItwOMy2358ghWL5eYh0A=;
 b=VWyWNssJ4rLZ6EAcfD2JJO6Rrc+YuJA6pYt9il/iy3rtihEEeR+96ecZ5VMc/ih49W
 3yHGrIox1ox1NpdsrhrmdXpzzlHsQX8nhFzkg9dIQ2Kguj8C2Feyoc+aAVRvUTUMdtmA
 oDRwf9RPQmJQchdTH6lFccbKBlL4c020a5rI2o53VBrg500guxg9wJCWJ8V03diV1yDA
 2AkOPI8FTl7IYfkT/ZRsQuGDnd2Sq5ircz0Rmxjufwx3m/90nFpqf2CGlIC5irjrZHJ6
 uz4yO1JX14/dD5I80U/nr13PwwBYf0KhFIhrJx8xtt+Xe32sYSK0VNVuXgXvYHIRfiMG
 a3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554278; x=1711159078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aXNCxUw+xNH5pFREtrweHMcItwOMy2358ghWL5eYh0A=;
 b=p0bfvRvfhoRyFWACeoE6svKNeChk+Ucwn/SjsZG3BF1PQLLmlIqqaNGZznrY8UcJCl
 2r0//0vAVMd6AbJart7SkD2zNkLVg/3rnVT4WYZTdjGNb3sOVX1YiM7XmAzyvJSgWhin
 CFx3IBXTCQ+K5MnlDQTdMQolEwcLtnTfS6YMcAq2X1CvyP4PSoSIRr2TkmS+MKoM98o3
 fqCAAght16zuYh+AIRw5AruNlq1HJm5T8Ur113Wer/+ZKQSL498S9OvGvkwCSEXK2iOl
 aSJ3OknuzA+9oby475Ay4jncujtqZApASUr4kP3D/1a2B0MF3FX+bneT6j8LilckpZQs
 32kw==
X-Gm-Message-State: AOJu0YyDHeyo7lO5HiiRnqNVz9i6KYOgy+9Hf96DA+eJ9USF/vtVXD/P
 7YXaAaRo5wrhz6PzL7UoKyadq6jXVnyMq4idevilgOmgoOiKhbVCqQhlz+KkyL+bCSJtqGNUqca
 W
X-Google-Smtp-Source: AGHT+IEa7/xVuz/BjBPjS7ki6yuhBcu8dAus7uMDFzYQCplrSliiYzMZn/x3ZvT9oOF0V00UjY3u3g==
X-Received: by 2002:a17:902:e54c:b0:1dd:a33f:5916 with SMTP id
 n12-20020a170902e54c00b001dda33f5916mr5630078plf.4.1710554278476; 
 Fri, 15 Mar 2024 18:57:58 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 17/22] plugins: Replace pr_ops with a proper debug dump flag
Date: Fri, 15 Mar 2024 15:57:15 -1000
Message-Id: <20240316015720.3661236-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

The DEBUG_PLUGIN_GEN_OPS ifdef is replaced with "-d op_plugin".
The second pr_ops call can be obtained with "-d op".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/log.h     |  1 +
 include/tcg/tcg.h      |  1 +
 accel/tcg/plugin-gen.c | 68 ++++++++----------------------------------
 tcg/tcg.c              | 29 +++++++++++++++++-
 util/log.c             |  4 +++
 5 files changed, 46 insertions(+), 57 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index df59bfabcd..e10e24cd4f 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -36,6 +36,7 @@ bool qemu_log_separate(void);
 #define LOG_STRACE         (1 << 19)
 #define LOG_PER_THREAD     (1 << 20)
 #define CPU_LOG_TB_VPU     (1 << 21)
+#define LOG_TB_OP_PLUGIN   (1 << 22)
 
 /* Lock/unlock output. */
 
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index df66e8f012..753d7ca3e0 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1065,5 +1065,6 @@ static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
 }
 
 bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);
+void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs);
 
 #endif /* TCG_H */
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 6f0731b479..10d917abd3 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -44,6 +44,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/plugin.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
@@ -58,6 +59,7 @@
 # define CONFIG_SOFTMMU_GATE 0
 #endif
 
+/* Update plugin_from_name in tcg.c. */
 enum plugin_gen_from {
     PLUGIN_GEN_FROM_TB,
     PLUGIN_GEN_FROM_INSN,
@@ -192,66 +194,21 @@ static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
     tcg_temp_free_i32(cpu_index);
 }
 
-/* #define DEBUG_PLUGIN_GEN_OPS */
-static void pr_ops(void)
-{
-#ifdef DEBUG_PLUGIN_GEN_OPS
-    TCGOp *op;
-    int i = 0;
-
-    QTAILQ_FOREACH(op, &tcg_ctx->ops, link) {
-        const char *name = "";
-        const char *type = "";
-
-        if (op->opc == INDEX_op_plugin_cb_start) {
-            switch (op->args[0]) {
-            case PLUGIN_GEN_FROM_TB:
-                name = "tb";
-                break;
-            case PLUGIN_GEN_FROM_INSN:
-                name = "insn";
-                break;
-            case PLUGIN_GEN_FROM_MEM:
-                name = "mem";
-                break;
-            case PLUGIN_GEN_AFTER_INSN:
-                name = "after insn";
-                break;
-            default:
-                break;
-            }
-            switch (op->args[1]) {
-            case PLUGIN_GEN_CB_UDATA:
-                type = "udata";
-                break;
-            case PLUGIN_GEN_CB_INLINE:
-                type = "inline";
-                break;
-            case PLUGIN_GEN_CB_MEM:
-                type = "mem";
-                break;
-            case PLUGIN_GEN_ENABLE_MEM_HELPER:
-                type = "enable mem helper";
-                break;
-            case PLUGIN_GEN_DISABLE_MEM_HELPER:
-                type = "disable mem helper";
-                break;
-            default:
-                break;
-            }
-        }
-        printf("op[%2i]: %s %s %s\n", i, tcg_op_defs[op->opc].name, name, type);
-        i++;
-    }
-#endif
-}
-
 static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 {
     TCGOp *op, *next;
     int insn_idx = -1;
 
-    pr_ops();
+    if (unlikely(qemu_loglevel_mask(LOG_TB_OP_PLUGIN)
+                 && qemu_log_in_addr_range(plugin_tb->vaddr))) {
+        FILE *logfile = qemu_log_trylock();
+        if (logfile) {
+            fprintf(logfile, "OP before plugin injection:\n");
+            tcg_dump_ops(tcg_ctx, logfile, false);
+            fprintf(logfile, "\n");
+            qemu_log_unlock(logfile);
+        }
+    }
 
     /*
      * While injecting code, we cannot afford to reuse any ebb temps
@@ -389,7 +346,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
             break;
         }
     }
-    pr_ops();
 }
 
 bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 363a065e28..d248c52e96 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2540,6 +2540,15 @@ static const char bswap_flag_name[][6] = {
     [TCG_BSWAP_IZ | TCG_BSWAP_OS] = "iz,os",
 };
 
+#ifdef CONFIG_PLUGIN
+static const char * const plugin_from_name[] = {
+    "from-tb",
+    "from-insn",
+    "after-insn",
+    "after-tb",
+};
+#endif
+
 static inline bool tcg_regset_single(TCGRegSet d)
 {
     return (d & (d - 1)) == 0;
@@ -2558,7 +2567,7 @@ static inline TCGReg tcg_regset_first(TCGRegSet d)
 #define ne_fprintf(...) \
     ({ int ret_ = fprintf(__VA_ARGS__); ret_ >= 0 ? ret_ : 0; })
 
-static void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
+void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
 {
     char buf[128];
     TCGOp *op;
@@ -2714,6 +2723,24 @@ static void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                     i = k = 1;
                 }
                 break;
+#ifdef CONFIG_PLUGIN
+            case INDEX_op_plugin_cb:
+                {
+                    TCGArg from = op->args[k++];
+                    const char *name = NULL;
+
+                    if (from < ARRAY_SIZE(plugin_from_name)) {
+                        name = plugin_from_name[from];
+                    }
+                    if (name) {
+                        col += ne_fprintf(f, "%s", name);
+                    } else {
+                        col += ne_fprintf(f, "$0x%" TCG_PRIlx, from);
+                    }
+                    i = 1;
+                }
+                break;
+#endif
             default:
                 i = 0;
                 break;
diff --git a/util/log.c b/util/log.c
index d36c98da0b..6219819855 100644
--- a/util/log.c
+++ b/util/log.c
@@ -466,6 +466,10 @@ const QEMULogItem qemu_log_items[] = {
       "show micro ops after optimization" },
     { CPU_LOG_TB_OP_IND, "op_ind",
       "show micro ops before indirect lowering" },
+#ifdef CONFIG_PLUGIN
+    { LOG_TB_OP_PLUGIN, "op_plugin",
+      "show micro ops before plugin injection" },
+#endif
     { CPU_LOG_INT, "int",
       "show interrupts/exceptions in short format" },
     { CPU_LOG_EXEC, "exec",
-- 
2.34.1


