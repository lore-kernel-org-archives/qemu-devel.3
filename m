Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1B7C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3p5-0003ck-FR; Wed, 05 Jun 2024 23:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3oq-0003X1-Vu
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:41 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3ok-0003mA-36
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:40 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c20eed350fso399203a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717644570; x=1718249370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7X+3P14YSYVXNQMiOZZLhD74NHSTkNTZimCmiwm+qG4=;
 b=vfv9bDgt7VZELKC8/LhwrdjvZ4s8H1FZr3z2oWQRkwvh/R9Oi6LosJP3fgicYpB6xM
 7JBnpemJaIrHLfyVLX3BgCHu6a3PjnkWArmtWGz4EJoVdmnlErVZbDrttiH18W53GqbH
 8PWTaf9NwOpobzc2gJX3eWJz9Uxjl7iTPbV84NsB10br1Db79RLmS85oCdYDY7z0LyT0
 xsS25yilctzdIsSiDIwKp4wLm2juoXIqNsScJdM1Vz6bsLwPqU4b5z+My72Q3Ov4c+xQ
 En61LgVFMhugHeTPxjMFu2LYROcLKiMhu8TYl4Q9TwpPquyY7dPPerdoLFKctkTXiMnR
 950Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717644570; x=1718249370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7X+3P14YSYVXNQMiOZZLhD74NHSTkNTZimCmiwm+qG4=;
 b=Q7uHGln+MLGxYZl1FnC6ukS4XAPzOfVgJe32Lh4krq2oXS4gSVFse5qp8atohjlZlZ
 reyj+bejOJEUUZJkBBRW6Q3tl03bvCxAEAJ0x9mqm950uMWPQR8KqORsRVq1hxLIkJBR
 MQRff45TLqqNLO/78ylGC/MhY3JTzwVLcx/8G5+Lw3LRXs9Yk3SHyN/TznmnCGJz8LTh
 qoV7AcwkYGXCQXz8XgjWV9laoMGUmNJmwSS7rMt3YoJ5nYXllddEp8m6kR0D+iMYoPtw
 Lns7otIIkW+LZ0mhEPnT5ajSGo54qqFaQsA69CH0ltRid9bQ6MmNGPfFHclswGieZatg
 fOQA==
X-Gm-Message-State: AOJu0YxYBvN77xxelFbmVmNE0g/tVug1uvbfCSAsTLyZqCj1R/YltiKT
 GjfhK/oTno3VdVCi1sdtHofkpD3aqKG34E49+lkPtv2XJYHQ8pGx0aLV8nHg0y5+XB4/QVNErZD
 p
X-Google-Smtp-Source: AGHT+IFF8JpYm/i1GEUNlbiFGSFApbwjZuHATKkk/TN+XaVkVhCRbWTQdr3xXlLHVs4AZV2LpMSL4Q==
X-Received: by 2002:a17:90a:f00e:b0:2b4:b306:ffbc with SMTP id
 98e67ed59e1d1-2c27db117f0mr4016140a91.17.1717644569714; 
 Wed, 05 Jun 2024 20:29:29 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c254a76729sm4826265a91.0.2024.06.05.20.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 20:29:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 2/9] accel/tcg: Set CPUState.plugin_ra before all plugin
 callbacks
Date: Wed,  5 Jun 2024 20:29:19 -0700
Message-Id: <20240606032926.83599-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606032926.83599-1-richard.henderson@linaro.org>
References: <20240606032926.83599-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Store a host code address to use with the tcg unwinder when called
from a plugin.  Generate one such store per guest insn that uses
a plugin callback.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h  |  4 +---
 accel/tcg/plugin-gen.c | 49 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a2c8536943..19b7fcc9f3 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -354,9 +354,7 @@ typedef union IcountDecr {
 typedef struct CPUNegativeOffsetState {
     CPUTLB tlb;
 #ifdef CONFIG_PLUGIN
-    /*
-     * The callback pointer are accessed via TCG (see gen_empty_mem_helper).
-     */
+    uintptr_t plugin_ra;
     GArray *plugin_mem_cbs;
 #endif
     IcountDecr icount_decr;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index cc1634e7a6..650e3810e6 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -37,6 +37,12 @@ enum plugin_gen_from {
     PLUGIN_GEN_AFTER_TB,
 };
 
+enum plugin_gen_ra {
+    GEN_RA_DONE,
+    GEN_RA_FROM_TB,
+    GEN_RA_FROM_INSN,
+};
+
 /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
 void plugin_gen_disable_mem_helpers(void)
 {
@@ -213,11 +219,37 @@ static void gen_mem_cb(struct qemu_plugin_regular_cb *cb,
     tcg_temp_free_i32(cpu_index);
 }
 
-static void inject_cb(struct qemu_plugin_dyn_cb *cb)
+static void inject_ra(enum plugin_gen_ra *gen_ra)
+{
+    TCGv_ptr ra;
 
+    switch (*gen_ra) {
+    case GEN_RA_DONE:
+        return;
+    case GEN_RA_FROM_TB:
+        ra = tcg_constant_ptr(NULL);
+        break;
+    case GEN_RA_FROM_INSN:
+        ra = tcg_temp_ebb_new_ptr();
+        tcg_gen_plugin_pc(ra);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_gen_st_ptr(ra, tcg_env,
+                   offsetof(CPUState, neg.plugin_ra) -
+                   offsetof(ArchCPU, env));
+    tcg_temp_free_ptr(ra);
+    *gen_ra = GEN_RA_DONE;
+}
+
+static void inject_cb(struct qemu_plugin_dyn_cb *cb,
+                      enum plugin_gen_ra *gen_ra)
 {
     switch (cb->type) {
     case PLUGIN_CB_REGULAR:
+        inject_ra(gen_ra);
         gen_udata_cb(&cb->regular);
         break;
     case PLUGIN_CB_COND:
@@ -235,19 +267,21 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
 }
 
 static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
+                          enum plugin_gen_ra *gen_ra,
                           enum qemu_plugin_mem_rw rw,
                           qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
     switch (cb->type) {
     case PLUGIN_CB_MEM_REGULAR:
         if (rw && cb->regular.rw) {
+            inject_ra(gen_ra);
             gen_mem_cb(&cb->regular, meminfo, addr);
         }
         break;
     case PLUGIN_CB_INLINE_ADD_U64:
     case PLUGIN_CB_INLINE_STORE_U64:
         if (rw && cb->inline_insn.rw) {
-            inject_cb(cb);
+            inject_cb(cb, gen_ra);
         }
         break;
     default:
@@ -260,6 +294,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 {
     TCGOp *op, *next;
     int insn_idx = -1;
+    enum plugin_gen_ra gen_ra;
 
     if (unlikely(qemu_loglevel_mask(LOG_TB_OP_PLUGIN)
                  && qemu_log_in_addr_range(tcg_ctx->plugin_db->pc_first))) {
@@ -279,10 +314,12 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
      */
     memset(tcg_ctx->free_temps, 0, sizeof(tcg_ctx->free_temps));
 
+    gen_ra = GEN_RA_FROM_TB;
     QTAILQ_FOREACH_SAFE(op, &tcg_ctx->ops, link, next) {
         switch (op->opc) {
         case INDEX_op_insn_start:
             insn_idx++;
+            gen_ra = GEN_RA_FROM_INSN;
             break;
 
         case INDEX_op_plugin_cb:
@@ -318,7 +355,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 cbs = plugin_tb->cbs;
                 for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
                     inject_cb(
-                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i));
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i),
+                        &gen_ra);
                 }
                 break;
 
@@ -330,7 +368,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 cbs = insn->insn_cbs;
                 for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
                     inject_cb(
-                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i));
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i),
+                        &gen_ra);
                 }
                 break;
 
@@ -362,7 +401,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
             cbs = insn->mem_cbs;
             for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
                 inject_mem_cb(&g_array_index(cbs, struct qemu_plugin_dyn_cb, i),
-                              rw, meminfo, addr);
+                              &gen_ra, rw, meminfo, addr);
             }
 
             tcg_ctx->emit_before_op = NULL;
-- 
2.34.1


