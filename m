Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72C0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldR-0003l6-UB; Wed, 24 Apr 2024 19:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldO-0003kG-Im
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:38 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldM-0002db-Rh
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:38 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so305092a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999755; x=1714604555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NiZ3HGz3Hc6pId3zVyG1cXL7lbYUMaIMlfQHI2GKrk=;
 b=kHWi8C+BRybJihUi0HcN0UuWRa+4RHWuuRPEjbOpVwDOzy1XnFThREV/H66pgr1ns2
 ZDZtrgqiTA4QNYp0S0KWvJNieqzfig3yqNmYUlBXKSvFZwA/xjGZYUX6FdE2sl8C4swA
 rag1Jye4c+Fho8cf76HLfUXzsJtLdnVpYhyZ+/5+MRamabnDjLdy81krKDUVLtrhBm3e
 s18BwMmkR1Up8hVTYS3jGcJhU875xbATNEODD/2M3mdOTNvtngG8Sgus8beIcj2riG4z
 0Jm0X6pLSkLadIrPagD+MgrRxHXhtlDWK5etOtiUTRAWU3hFshre9XH+pMPRlDjM+b2k
 PoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999755; x=1714604555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NiZ3HGz3Hc6pId3zVyG1cXL7lbYUMaIMlfQHI2GKrk=;
 b=lu0UCSdoKpoLpksZrMf/jbu7iK8/trqiqSC+1vN3LfR4g08uGIu2Ua4m1nKNqFNpsg
 BE8B7g8JjG5f0QbQfrgq8boD5VP4PByeIiXkwU3uih2f05QAE1/o90sljaVsqh7N5pP3
 F4aJpVqVu+dgc/sXuz49Qy3+QoHWSYHBakA+JG1tGog9Xsl1Qsxwen+mNQ/atnf+CgFY
 DjaFYy58fN8zXATTnsAvJy48A7fTR94efKO9otw429B+AZ75Xm2HYLl/DygikHXqgYus
 x0ej+xxXb4Te8UucdAoy2oTFn+1H2ue2uqW6rSbCvcZ98v5jQw+OsPlAEY8tyK8piNjj
 r/4w==
X-Gm-Message-State: AOJu0YwJUxVHatlYHGYgJrHLmxuWlwtyn9SnXyYhm6uPVQmlvuO9sUwq
 b8eISqkU4jdfqZeNE/SDcycqUA1nEWAwK7QZ+iYQoGTROYMGtQR58R33Bbolm/M6b2JxixpKm6K
 L
X-Google-Smtp-Source: AGHT+IE34UPsB8eN6sxboJDIvUS0Kmy0YIl9bYu5Ue6bGZ7gky0h86rS4v3oMcbKdJFDtc1c1VRFkQ==
X-Received: by 2002:a05:6a20:244e:b0:1aa:5aab:567a with SMTP id
 t14-20020a056a20244e00b001aa5aab567amr4595232pzc.41.1713999755443; 
 Wed, 24 Apr 2024 16:02:35 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 08/20] plugins: Add PLUGIN_GEN_AFTER_TB
Date: Wed, 24 Apr 2024 16:02:12 -0700
Message-Id: <20240424230224.941028-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Delay test of plugin_tb->mem_helper until the inject pass.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c803fe8e96..1faa49cb8f 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -69,6 +69,7 @@ enum plugin_gen_from {
     PLUGIN_GEN_FROM_INSN,
     PLUGIN_GEN_FROM_MEM,
     PLUGIN_GEN_AFTER_INSN,
+    PLUGIN_GEN_AFTER_TB,
     PLUGIN_GEN_N_FROMS,
 };
 
@@ -609,20 +610,9 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
 /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
 void plugin_gen_disable_mem_helpers(void)
 {
-    /*
-     * We could emit the clearing unconditionally and be done. However, this can
-     * be wasteful if for instance plugins don't track memory accesses, or if
-     * most TBs don't use helpers. Instead, emit the clearing iff the TB calls
-     * helpers that might access guest memory.
-     *
-     * Note: we do not reset plugin_tb->mem_helper here; a TB might have several
-     * exit points, and we want to emit the clearing from all of them.
-     */
-    if (!tcg_ctx->plugin_tb->mem_helper) {
-        return;
+    if (tcg_ctx->plugin_insn) {
+        tcg_gen_plugin_cb(PLUGIN_GEN_AFTER_TB);
     }
-    tcg_gen_st_ptr(tcg_constant_ptr(NULL), tcg_env,
-                   offsetof(CPUState, plugin_mem_cbs) - offsetof(ArchCPU, env));
 }
 
 static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
@@ -673,14 +663,11 @@ static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     inject_mem_enable_helper(ptb, insn, begin_op);
 }
 
-static void gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
-                                   struct qemu_plugin_insn *insn)
+static void gen_disable_mem_helper(void)
 {
-    if (insn->mem_helper) {
-        tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
-                       offsetof(CPUState, plugin_mem_cbs) -
-                       offsetof(ArchCPU, env));
-    }
+    tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
+                   offsetof(CPUState, plugin_mem_cbs) -
+                   offsetof(ArchCPU, env));
 }
 
 static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
@@ -806,9 +793,17 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
             tcg_ctx->emit_before_op = op;
 
             switch (from) {
+            case PLUGIN_GEN_AFTER_TB:
+                if (plugin_tb->mem_helper) {
+                    gen_disable_mem_helper();
+                }
+                break;
+
             case PLUGIN_GEN_AFTER_INSN:
                 assert(insn != NULL);
-                gen_disable_mem_helper(plugin_tb, insn);
+                if (insn->mem_helper) {
+                    gen_disable_mem_helper();
+                }
                 break;
 
             case PLUGIN_GEN_FROM_TB:
-- 
2.34.1


