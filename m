Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41971C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlda-0003r9-DC; Wed, 24 Apr 2024 19:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldX-0003pf-GW
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldV-0002fL-Qf
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:47 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6eff2be3b33so456495b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999764; x=1714604564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LosuIyCzAc9oB5OxDPZNgW94mh4MJImjLMLCS31GDcs=;
 b=r3x1wSOqM3FfWc+ZQx1agyLUWDf+RhkTicKLrKuWhFer0XeAzXuq9YUdgZOTXj3Oii
 5Ua6z9sEoj7hYof0IP+EDjquNWg3qb3tD5UvjtSAHve9yPo4KmhGHFCECTaIf1wTOX5W
 CoC2zWH8nn/BtLDQN1KBzdX2ZRa2GI738mwb3iLw0dE2mtJUvL3x4AdUEuwI/0dqOAwO
 LQS3Y9acDC0uu1M9qorfv4b0Aorwbh1Cu8Zku4pdb7ed0r8eP2HDB4rHvcE8hDalcJIo
 dCN0ETegV1AD5wcRFPDjmbflVh8qSab92hyglGwJ3OJP0NleMTUwhuIY2q+SFgIoocSo
 AEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999764; x=1714604564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LosuIyCzAc9oB5OxDPZNgW94mh4MJImjLMLCS31GDcs=;
 b=mHaclyVtyhMM4WuQGCwCJzciP62st6KLZsOiCI7UfsV6cVbjMDMIaC0oFI4b5oIaw6
 gNjRD54Am/8//czYV6f8w8vnTAS9I9Kv3ru7NEtDMx8PxrZUeB/hqyzB7iWVfLc0Oa5x
 8P9fy0ucrjEYuXE7MzKkZw9y5d8JuL/rAJ2syONDcH/dSshrH1ua66Ug8w3orgolToO0
 sSg3JCoyEJVNq6rXcmRpWxAnq8SEO/74K8VRrc1okez5W/iPkV9oz+Oe7GG798ypEams
 fxORYjliVllSKz41DegurSrdoldKLGT5QSLsu/C5ExTT4LTy6kI3jX6MkwRcHfIhmyiW
 wWyw==
X-Gm-Message-State: AOJu0YzvYVHE8JzUs6QWDXdEElY4YiWBcjqpCqZ5ULj2/taB2JWoeQjn
 jWRm+8ckw6+j0kM3Iz3f3tvRgfz+HmUva8i6o1mn2NLW5EidqSok54DUDvNCs+Oqz9Kw8Km6HDV
 x
X-Google-Smtp-Source: AGHT+IEyUCI3SpC1OPzm0uX/ToP1LxMzJwht4R4JfaVPaH8uVnTtteRW7FtWlbiQnZo8NVPc8978kQ==
X-Received: by 2002:a05:6a21:1a5:b0:1ad:12fe:103a with SMTP id
 le37-20020a056a2101a500b001ad12fe103amr4795553pzb.23.1713999764359; 
 Wed, 24 Apr 2024 16:02:44 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 17/20] plugins: Split out common cb expanders
Date: Wed, 24 Apr 2024 16:02:21 -0700
Message-Id: <20240424230224.941028-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 84 +++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 49d9b07438..5b63b93114 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -187,6 +187,37 @@ static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
     tcg_temp_free_i32(cpu_index);
 }
 
+static void inject_cb(struct qemu_plugin_dyn_cb *cb)
+
+{
+    switch (cb->type) {
+    case PLUGIN_CB_REGULAR:
+        gen_udata_cb(cb);
+        break;
+    case PLUGIN_CB_INLINE:
+        gen_inline_cb(cb);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
+                          enum qemu_plugin_mem_rw rw,
+                          qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
+{
+    if (cb->rw & rw) {
+        switch (cb->type) {
+        case PLUGIN_CB_MEM_REGULAR:
+            gen_mem_cb(cb, meminfo, addr);
+            break;
+        default:
+            inject_cb(cb);
+            break;
+        }
+    }
+}
+
 static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 {
     TCGOp *op, *next;
@@ -248,19 +279,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
                 cbs = plugin_tb->cbs;
                 for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
-                    struct qemu_plugin_dyn_cb *cb =
-                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
-
-                    switch (cb->type) {
-                    case PLUGIN_CB_REGULAR:
-                        gen_udata_cb(cb);
-                        break;
-                    case PLUGIN_CB_INLINE:
-                        gen_inline_cb(cb);
-                        break;
-                    default:
-                        g_assert_not_reached();
-                    }
+                    inject_cb(
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i));
                 }
                 break;
 
@@ -271,19 +291,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
                 cbs = insn->insn_cbs;
                 for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
-                    struct qemu_plugin_dyn_cb *cb =
-                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
-
-                    switch (cb->type) {
-                    case PLUGIN_CB_REGULAR:
-                        gen_udata_cb(cb);
-                        break;
-                    case PLUGIN_CB_INLINE:
-                        gen_inline_cb(cb);
-                        break;
-                    default:
-                        g_assert_not_reached();
-                    }
+                    inject_cb(
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i));
                 }
                 break;
 
@@ -300,33 +309,22 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
         {
             TCGv_i64 addr = temp_tcgv_i64(arg_temp(op->args[0]));
             qemu_plugin_meminfo_t meminfo = op->args[1];
+            enum qemu_plugin_mem_rw rw =
+                (qemu_plugin_mem_is_store(meminfo)
+                 ? QEMU_PLUGIN_MEM_W : QEMU_PLUGIN_MEM_R);
             struct qemu_plugin_insn *insn;
             const GArray *cbs;
-            int i, n, rw;
+            int i, n;
 
             assert(insn_idx >= 0);
             insn = g_ptr_array_index(plugin_tb->insns, insn_idx);
-            rw = qemu_plugin_mem_is_store(meminfo) ? 2 : 1;
 
             tcg_ctx->emit_before_op = op;
 
             cbs = insn->mem_cbs;
             for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
-                struct qemu_plugin_dyn_cb *cb =
-                    &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
-
-                if (cb->rw & rw) {
-                    switch (cb->type) {
-                    case PLUGIN_CB_MEM_REGULAR:
-                        gen_mem_cb(cb, meminfo, addr);
-                        break;
-                    case PLUGIN_CB_INLINE:
-                        gen_inline_cb(cb);
-                        break;
-                    default:
-                        g_assert_not_reached();
-                    }
-                }
+                inject_mem_cb(&g_array_index(cbs, struct qemu_plugin_dyn_cb, i),
+                              rw, meminfo, addr);
             }
 
             tcg_ctx->emit_before_op = NULL;
-- 
2.34.1


