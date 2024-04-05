Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5826BCD1296
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglC-00060A-4m; Fri, 05 Apr 2024 06:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglA-0005zo-IP
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl8-0004kf-7N
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e6b22af648so2323932b3a.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312721; x=1712917521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ftBOVEixPIVqS15sO6yzpwdLAXRK5ukeZC44nc/EnDQ=;
 b=Mz4R7dWh6vnP+F3zkl0Ub75STRTodaSho6kQ2OIAdIMA+KrSgaADONEt+k/MXhaKGl
 hXYH8CCJDAHCVo9TnCSZU1mn+Jpim4v5bJtoz+Rh22qBq+KPuKY2huQUrz5SbcdHoZYy
 iVErrJOx7LGd58Bc/eDbbKLtUnbiRDPvaP/XlGy7BJCozc6fgWjGSKhpqlm4dm805Bnf
 6t4RcjxfkzAjnsLfVS1SjL9mMKP/Ik9u7iMhdAPkDQPjWDQUGHLh+b1SFan1ljqPGoC+
 0VlWkyBQmwMaknqZPXJlm70fQhSfTKAUCt5p3xVtvr6HPEMB296ROI25CWYKEdWcK+DO
 u/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312721; x=1712917521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftBOVEixPIVqS15sO6yzpwdLAXRK5ukeZC44nc/EnDQ=;
 b=Jlg+jO93FfPS5LpOzRgJcfWNPSjuNRqqtCCEiB/mfnnTtqfUPX0REPI66DTMh/Xx+l
 OIeAfG3PAX5g8Olhh6ay5LUUVxl8vHuofHPt7rjIwz9xlce5xjrUJByXuC8Opa9A/5T/
 pHe1a/RAeZ/nimcnuFWekjna8oTsLvzTFjkfYJ1hclJmWqYt1t36I/JIcvbgqLH811Ft
 YLrwAxajnmH07juPC1tSonkYMJM7s4+fqFZMNd3rU2MIaILRxVva3PWPhQL0ZzYriO2o
 ROQwfrcfUNYJBDKGZ+XTLJF1RYPzTZ6rczMuF3QOyE+RXQxfirCv/jgAFc+/c0+Q5y4e
 VD0Q==
X-Gm-Message-State: AOJu0Yw87VEnH+ScSBWmehK6tdN7liPcDyk7VI0RqojsNjlVQQSuiDTt
 MSWeEOenlLBdXtlTjw/aGnKXt5I0eAIcRwkUEEPU6Olplyl9IX0DPl6RCS68i9vSLmU4Rfg7WsK
 w
X-Google-Smtp-Source: AGHT+IFYGpfZAoaSqAkkONGw2QW8mANLQHjh89n8j4mrpRUXryEneI0uWKWijB6MskslS4bWig4Tqw==
X-Received: by 2002:a05:6a21:9994:b0:1a7:398d:6709 with SMTP id
 ve20-20020a056a21999400b001a7398d6709mr2745855pzb.21.1712312720905; 
 Fri, 05 Apr 2024 03:25:20 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/32] plugins: Merge alloc_tcg_plugin_context into
 plugin_gen_tb_start
Date: Fri,  5 Apr 2024 00:24:42 -1000
Message-Id: <20240405102459.462551-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

We don't need to allocate plugin context at startup,
we can wait until we actually use it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 36 ++++++++++++++++++++----------------
 tcg/tcg.c              | 11 -----------
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 2c52306f80..8ebf215645 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -305,28 +305,32 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
 bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db)
 {
-    bool ret = false;
+    struct qemu_plugin_tb *ptb;
 
-    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_state->event_mask)) {
-        struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
-
-        /* reset callbacks */
-        if (ptb->cbs) {
-            g_array_set_size(ptb->cbs, 0);
-        }
-        ptb->n = 0;
-
-        ret = true;
-
-        ptb->mem_helper = false;
-
-        tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
+    if (!test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS,
+                  cpu->plugin_state->event_mask)) {
+        return false;
     }
 
     tcg_ctx->plugin_db = db;
     tcg_ctx->plugin_insn = NULL;
+    ptb = tcg_ctx->plugin_tb;
 
-    return ret;
+    if (ptb) {
+        /* Reset callbacks */
+        if (ptb->cbs) {
+            g_array_set_size(ptb->cbs, 0);
+        }
+        ptb->n = 0;
+        ptb->mem_helper = false;
+    } else {
+        ptb = g_new0(struct qemu_plugin_tb, 1);
+        tcg_ctx->plugin_tb = ptb;
+        ptb->insns = g_ptr_array_new();
+    }
+
+    tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
+    return true;
 }
 
 void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 691b2342a2..6cc9f205c4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -761,14 +761,6 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                   < MIN_TLB_MASK_TABLE_OFS);
 #endif
 
-static void alloc_tcg_plugin_context(TCGContext *s)
-{
-#ifdef CONFIG_PLUGIN
-    s->plugin_tb = g_new0(struct qemu_plugin_tb, 1);
-    s->plugin_tb->insns = g_ptr_array_new();
-#endif
-}
-
 /*
  * All TCG threads except the parent (i.e. the one that called tcg_context_init
  * and registered the target's TCG globals) must register with this function
@@ -813,7 +805,6 @@ void tcg_register_thread(void)
     qatomic_set(&tcg_ctxs[n], s);
 
     if (n > 0) {
-        alloc_tcg_plugin_context(s);
         tcg_region_initial_alloc(s);
     }
 
@@ -1360,8 +1351,6 @@ static void tcg_context_init(unsigned max_cpus)
         indirect_reg_alloc_order[i] = tcg_target_reg_alloc_order[i];
     }
 
-    alloc_tcg_plugin_context(s);
-
     tcg_ctx = s;
     /*
      * In user-mode we simply share the init context among threads, since we
-- 
2.34.1


