Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BDBC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldU-0003n7-TW; Wed, 24 Apr 2024 19:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldT-0003mE-Fn
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:43 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldR-0002eS-Gl
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f30f69a958so381062b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999760; x=1714604560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUzW5EpE6psTv3wNqcRJ2QohJfV0nsRef4r1zjcLMwE=;
 b=Lkf1T/s3EDd/ml7QWuJ8ii9k6ZZE9j++4tYtebUQfWry73t6mrz6Ivbi+VUpL0Fslp
 0PBINn9JqHdU8j52Bbw73sKj4NPgmUny6Qfuz1SGBDUSC7yyJnMchwxseJDuSZ2XPCvF
 rILqiRJPQS3BLImp+XqrM2b5cJcSgbVexoFbeafLb3sdizeFq31wp/xx4tnFYelDADux
 TsB3zMeGR+g4I+1FEE3Y7Mtv9nFA47Q6VW+CYiRW+EENJZl8NT4IIyLfgKMu+rB7OvTr
 MnmjGlU7ydGuYsqwlgn+wyORkim1554VLPJzhMsoSjfHs05dau8Z9EvxxBIxgIEThhyD
 13ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999760; x=1714604560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUzW5EpE6psTv3wNqcRJ2QohJfV0nsRef4r1zjcLMwE=;
 b=KGJsc5ScfXeIp43y/wxLnnWTLBWMeDhD7escqm0QhabZUQsv2hsurkNtO6kSUuMHrX
 pjeqWM4C7UJklkW9Iw3eYzI2XCtMJGxLQ7Rh9oRQNGWUvsDYNVSKFZ1y5SdIhZ04yr+D
 LwefLJzu2D8r2F2NE+RBWbD+0FacoF9HPsnTJ+aP3xzSgBGMCN9qqzkgbzV1Wjy7vJpk
 UrYvH2bbW/zVdKgPaaOjHu95ATFEaA3taTpTAqcJtVInbdVu1VImBDU3nGHyLOFMdgl1
 Wxiwj2dmqDEnYYlLxRDWjHb2vFdgP6kchOTI3KHE1J1y5+v8nvIUM31qlsYoKa106ScT
 pQ+Q==
X-Gm-Message-State: AOJu0YyBvJ57rqhFQdFRo/5x1REoGeBdlUhlML+V5+b/ivr9M4C5c3le
 IHtiXVfz2sV9wj9VhQFpBVSLLlD75WG3uzDMOgvXp5Nr8GUkns7Z2ip9/rXs4JgD9mL8NS9F92j
 x
X-Google-Smtp-Source: AGHT+IGd03z96+f6rKMdGBvt5f38YLGwM9R5htw3pTtWgiHR8/XKZdC9vsVGIyB0pPICwfw8KLhIQg==
X-Received: by 2002:a05:6a20:5525:b0:1a7:2ce0:633d with SMTP id
 ko37-20020a056a20552500b001a72ce0633dmr3716580pzb.5.1713999760251; 
 Wed, 24 Apr 2024 16:02:40 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 13/20] tcg: Remove INDEX_op_plugin_cb_{start,end}
Date: Wed, 24 Apr 2024 16:02:17 -0700
Message-Id: <20240424230224.941028-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

These opcodes are no longer used.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  2 --
 include/tcg/tcg-opc.h       |  2 --
 accel/tcg/plugin-gen.c      | 18 ------------------
 tcg/tcg-op.c                | 10 ----------
 4 files changed, 32 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 72b80b20d0..009e2778c5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -76,8 +76,6 @@ void tcg_gen_lookup_and_goto_ptr(void);
 
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
-void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr);
-void tcg_gen_plugin_cb_end(void);
 
 /* 32 bit ops */
 
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index be9e36e386..546eb49c11 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -199,8 +199,6 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
-DEF(plugin_cb_start, 0, 0, 3, TCG_OPF_NOT_PRESENT)
-DEF(plugin_cb_end, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 /* Replicate ld/st ops for 32 and 64-bit guest addresses. */
 DEF(qemu_ld_a32_i32, 1, 1, 1,
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index fb77585ac0..d9ee9bb2ec 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -52,29 +52,11 @@
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
 
-/*
- * plugin_cb_start TCG op args[]:
- * 0: enum plugin_gen_from
- * 1: enum plugin_gen_cb
- * 2: set to 1 for mem callback that is a write, 0 otherwise.
- */
-
 enum plugin_gen_from {
     PLUGIN_GEN_FROM_TB,
     PLUGIN_GEN_FROM_INSN,
     PLUGIN_GEN_AFTER_INSN,
     PLUGIN_GEN_AFTER_TB,
-    PLUGIN_GEN_N_FROMS,
-};
-
-enum plugin_gen_cb {
-    PLUGIN_GEN_CB_UDATA,
-    PLUGIN_GEN_CB_UDATA_R,
-    PLUGIN_GEN_CB_INLINE,
-    PLUGIN_GEN_CB_MEM,
-    PLUGIN_GEN_ENABLE_MEM_HELPER,
-    PLUGIN_GEN_DISABLE_MEM_HELPER,
-    PLUGIN_GEN_N_CBS,
 };
 
 static void plugin_gen_empty_callback(enum plugin_gen_from from)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0ae12fa49d..eff3728622 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -322,16 +322,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, tcgv_i64_arg(addr), meminfo);
 }
 
-void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr)
-{
-    tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
-}
-
-void tcg_gen_plugin_cb_end(void)
-{
-    tcg_emit_op(INDEX_op_plugin_cb_end, 0);
-}
-
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
-- 
2.34.1


