Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07E0C25B10
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B6B-0002kY-1o; Wed, 01 May 2024 10:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5k-0002fv-Fb
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5i-00028Q-RS
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:52 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e50a04c317so37747405ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574269; x=1715179069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NiZ3HGz3Hc6pId3zVyG1cXL7lbYUMaIMlfQHI2GKrk=;
 b=MMLs/dbeVHFyXXwBBndTsbPj9oWUIhTen3YuB0jPMk++YeudGpibkJ5quyr7P+I006
 hQ9b10QUI4xQGrqAf0W8oWkbs/LGAzg03t/v89+DyfHMRrR1raUBaols+C673F7ETZd1
 ckiQsoIH50Ik8qHKM+ay3OhUV5162eOu71pmGu1XWYzEyzHJ1QihTid1tFi2dlAhx0F+
 TjxR3xHXXed4Bs1S9ZCvRj3LntFAXXD6ywKatFcgaZ+palce5wna4OrTymqJJtPpYgfH
 0H1D1fV7n553s5gArLBiSZ5PFGIFFjdxwnGLqBCudlaHb/Qqp7XKSgWJwejXJ8CI/MEI
 aQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574269; x=1715179069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NiZ3HGz3Hc6pId3zVyG1cXL7lbYUMaIMlfQHI2GKrk=;
 b=Gx+eK83cjmCzTPkjkkLgZP7dzQ2RP6qcTXdDL01trfFOPQ+/72x8Ce4Vxx9Ejnl20y
 F2QYkD0o2OX20zWJbF1jWG1/SVVAGUQD/AX8pn58VlnlF2xzKPxthvTto/wcDg5fR/Q0
 7Cb8Sgn8pwSYnV/lzrtDMFhyXzffDuwMHHtMRxuFFcbf/4p9EIolZLngfaWilnXjfIw6
 txMAFmXA/f/ZrYdPuxUjFmzr7nsTPEnRe6L6+pYM3ctMfqQ3SraTYW91QNgC2zBFA5dH
 V9DTDhk8BQq44mLlVJY6csvAgfM4VJc0IlOvakWWJDhGfGEheETgbW245wKotgMlHX8w
 DSJA==
X-Gm-Message-State: AOJu0YwTI+7BYtrtqLU8pcM4IEQzqT2bR6CZ/wCE6TQY3pyeST86bXV2
 FiqPtjBUN7NkC87n8cC0C7VVp32/0NZlsQk9ApooKcwjmQ06mGJbxRgiIxO/3hHYTEoEPq/gVSA
 C
X-Google-Smtp-Source: AGHT+IFB8hQnzoOuQylygCrbzwAm7ylIqO9YYM5mP4AmrM+BTZFrGuQUOn0Uq3lD91QAJJ08xbQjMQ==
X-Received: by 2002:a17:902:bb17:b0:1e4:9d6f:593 with SMTP id
 im23-20020a170902bb1700b001e49d6f0593mr2844010plb.36.1714574269116; 
 Wed, 01 May 2024 07:37:49 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/20] plugins: Add PLUGIN_GEN_AFTER_TB
Date: Wed,  1 May 2024 07:37:27 -0700
Message-Id: <20240501143739.10541-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


