Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E706C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 04:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwa5K-0007xm-ET; Tue, 16 Apr 2024 00:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5I-0007rZ-MA
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:16 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5G-00079h-MQ
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:16 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e5aa82d1f6so21593665ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 21:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713240373; x=1713845173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ETaHVvoHKNHLSSeeGS1BiYVkaanEylQv/HH8WSVcLo=;
 b=EkHcV20Zj/NA54i21wioS079qCAEzd26Ouu+t4j+Z7ZydDaF6JFE79ob5LcCJzspPR
 sP65/pDSCLPX/bQeKw+x+yAfg3tlI7T4vTM3UFxpqUarbop1NXL2Yfp/QASlsgibCzT6
 m355bHJo+93+cqTv3uNg9o6diyenwDwnfY6JdA0nvleHG3qNxRMhlhqJ/I9GzhCpoKVh
 oe3C0ymyW7SzsTFf4mG7PPXaRsiCxp3iohVZQtmvovzrL0ljdkWMC5BzuHpbdAukjBmJ
 yCphbzBPfMeuuo/20VIQHQGtUsN2oeCx34pwapQpR+IWzOm0hzJYQjVUQte+EeOwo70d
 8qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713240373; x=1713845173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ETaHVvoHKNHLSSeeGS1BiYVkaanEylQv/HH8WSVcLo=;
 b=BFXRRlRAtaakOezLgYdJMGPwZO367iNueLRt+tseHjXtJo0hFIGsE6FHnQuR1IY4DY
 UaaC1OB2L4h18K3G9iec5H6cu5VZsMfDDwW1ZgPuCVQWCiiX6PiP7lI/ekc1kKuN6YMz
 3AmFvv1zU9sKj3XqwKP93AmkcCofhK8zvZp0X5O1/aHOLIQJjUzifsqdn9phBIxz+foP
 GzgFPI1S2kxq6ijV65fus2WoSJxtUvhEFiifS2F/DPiNlLp+t9TdevqJBjbZHOM2KiG4
 fau7Rm3cZIS5YW2YOnpAZeJtCRNV9m+6S1/KLzEX4AjRbPi6sowybDJnPYclvRVgygvY
 1FYQ==
X-Gm-Message-State: AOJu0YxYOzZmSbrrST5H8YwdC34//7rB3uQJCjgSN0rd2r601a+alO64
 pbU8vN8ayiAD3OdZjWz+x1TchdJYbVNHp6o5MyFlVfgj5Vf8+8Qwxs8067K5TJY0wJBXUXM1IEX
 b
X-Google-Smtp-Source: AGHT+IFx3xATxmCsX3o/78sxy3qbg3OcoRGZcv09Ai9H6d+f0z6nFXkOle3KQq6Ow+kPggeWhclFag==
X-Received: by 2002:a17:902:e811:b0:1e4:6cd7:30b3 with SMTP id
 u17-20020a170902e81100b001e46cd730b3mr1246254plg.23.1713240373219; 
 Mon, 15 Apr 2024 21:06:13 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a170902f68100b001e3e244e5c0sm8694439plg.78.2024.04.15.21.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 21:06:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 2/7] accel/tcg: Set CPUState.plugin_ra before all plugin
 callbacks
Date: Mon, 15 Apr 2024 21:06:04 -0700
Message-Id: <20240416040609.1313605-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416040609.1313605-1-richard.henderson@linaro.org>
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h  |  1 +
 accel/tcg/plugin-gen.c | 50 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 10cd492aff..f4af37c13d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -350,6 +350,7 @@ typedef union IcountDecr {
 typedef struct CPUNegativeOffsetState {
     CPUTLB tlb;
 #ifdef CONFIG_PLUGIN
+    uintptr_t plugin_ra;
     GArray *plugin_mem_cbs;
 #endif
     IcountDecr icount_decr;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 36e9134a5d..f96b49cce6 100644
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
@@ -151,11 +157,38 @@ static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
     tcg_temp_free_i32(cpu_index);
 }
 
-static void inject_cb(struct qemu_plugin_dyn_cb *cb)
+static void inject_ra(enum plugin_gen_ra *gen_ra)
+{
+    TCGv_ptr ra;
+
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
         gen_udata_cb(cb);
         break;
     case PLUGIN_CB_INLINE:
@@ -167,16 +200,18 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
 }
 
 static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
+                          enum plugin_gen_ra *gen_ra,
                           enum qemu_plugin_mem_rw rw,
                           qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
     if (cb->rw & rw) {
         switch (cb->type) {
         case PLUGIN_CB_MEM_REGULAR:
+            inject_ra(gen_ra);
             gen_mem_cb(cb, meminfo, addr);
             break;
         default:
-            inject_cb(cb);
+            inject_cb(cb, gen_ra);
             break;
         }
     }
@@ -186,6 +221,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 {
     TCGOp *op, *next;
     int insn_idx = -1;
+    enum plugin_gen_ra gen_ra;
 
     if (unlikely(qemu_loglevel_mask(LOG_TB_OP_PLUGIN)
                  && qemu_log_in_addr_range(plugin_tb->vaddr))) {
@@ -205,10 +241,12 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
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
@@ -244,7 +282,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 cbs = plugin_tb->cbs;
                 for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
                     inject_cb(
-                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i));
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i),
+                        &gen_ra);
                 }
                 break;
 
@@ -256,7 +295,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 cbs = insn->insn_cbs;
                 for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
                     inject_cb(
-                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i));
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i),
+                        &gen_ra);
                 }
                 break;
 
@@ -288,7 +328,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
             cbs = insn->mem_cbs;
             for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
                 inject_mem_cb(&g_array_index(cbs, struct qemu_plugin_dyn_cb, i),
-                              rw, meminfo, addr);
+                              &gen_ra, rw, meminfo, addr);
             }
 
             tcg_ctx->emit_before_op = NULL;
-- 
2.34.1


