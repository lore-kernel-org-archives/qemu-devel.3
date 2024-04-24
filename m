Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B076C19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldb-0003t3-L5; Wed, 24 Apr 2024 19:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldW-0003pW-Mm
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldU-0002f7-ST
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:46 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f043f9e6d7so455036b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999763; x=1714604563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4O/S7CzC0zSv8/mdbOPeo5wN+nYsN/0iJkrPrfvvWjE=;
 b=s0CtbHUIa0PJNpQt8o1pNlP5ZEgMQ3tOlDXJe0yeuyJ8rbZJ2I4HfHi9kV36dit41S
 3O2mJe68twYfKGA+duQ9TdhjQ11InHosqJr5qGba05raY1IOjoItV0q/s7PogeuoWR5C
 ST4aNJlUOUatrsCWbg/YZ5lVLWShe+u3eaxM1RGgWzNjPEmmOxHw18oqnSQ4qrFrHXVg
 ZOGyC+EUy8aVjRhpIRT2sLuBMOmGtbta2yGQLlQKxATNLOa/ko01ls4iHF3KTTyp9+G9
 GEq7jvGifEJp8R8hj876e1tL8gFDD2D0aiMP8Vk/DmTa0JzCHY0772R6cmHY5p82JuEX
 P6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999763; x=1714604563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4O/S7CzC0zSv8/mdbOPeo5wN+nYsN/0iJkrPrfvvWjE=;
 b=QQWWC5inRbRj/CMRYFbTdGRCIWrXB+2qmpIa7ToYXsWQqgGpXLsnv3j4tbz/R/T1FX
 u1EMwRXCi/OGOXUcwaemEX8aocCvE7UggldE35kyIB2EkJOPMhV9k0W6nQz9yKWPAJyP
 UmLMirILwSFMdbm9gWSItY0+t+2Ac/r9iHEWPxZa959kIe1kS9eIFY0rPDnugs4PGQez
 Tee4qDpMruYeDXQLPqV0qsATgdbysn27jAJMnGqlkrK8/T+7Xa8u+/UYeMP3ET6uwEXm
 34xekSSVdtnpYACp/MTTqdpbDJzSJv58Ckozad6ZugwxUFqa5hQpsCSHZ1BAhE+yzmny
 ++Lg==
X-Gm-Message-State: AOJu0YzvOgRs6LtQ3QEAJK17bujDiygDRveehYRPW9pq+ZqfrrshjMJH
 vlGZpVWoMYguX0j3BlMYFd6C42IFgdzAvPZ3wSRtcP+0xgrkkyEt8BlzS0I/76gWkpqhwOwswbJ
 3
X-Google-Smtp-Source: AGHT+IEPRG5BQPquldb103X65HUYDt7gxHlH1+Ea+UwXsJBeRghUk56M2EiRYIkic+rf8XzBgfDKvw==
X-Received: by 2002:a05:6a20:394b:b0:1a9:9547:1145 with SMTP id
 r11-20020a056a20394b00b001a995471145mr4919301pzg.47.1713999763484; 
 Wed, 24 Apr 2024 16:02:43 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 16/20] plugins: Replace pr_ops with a proper debug dump flag
Date: Wed, 24 Apr 2024 16:02:20 -0700
Message-Id: <20240424230224.941028-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

The DEBUG_PLUGIN_GEN_OPS ifdef is replaced with "-d op_plugin".
The second pr_ops call can be obtained with "-d op".

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/log.h     |  1 +
 include/tcg/tcg.h      |  1 +
 accel/tcg/plugin-gen.c | 67 +++++++-----------------------------------
 tcg/tcg.c              | 29 +++++++++++++++++-
 util/log.c             |  4 +++
 5 files changed, 45 insertions(+), 57 deletions(-)

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
index 196e3b7ba1..135e36d729 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1070,5 +1070,6 @@ static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
 }
 
 bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);
+void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs);
 
 #endif /* TCG_H */
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c545303956..49d9b07438 100644
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
@@ -186,66 +187,21 @@ static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
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
@@ -383,7 +339,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
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


