Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D31CD1296
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAX-00029D-90; Thu, 04 Apr 2024 19:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAL-00024X-Af
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:42 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAJ-0007oQ-B9
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:41 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2a2c9903ef0so1149349a91.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271998; x=1712876798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LosuIyCzAc9oB5OxDPZNgW94mh4MJImjLMLCS31GDcs=;
 b=OboIGTMZwcuNF2FF1HLxC0z92zAMXT9T1BPVbYOgbx7zCjFwMB5Ro8znA4SX4daNxZ
 HJFRlpWt434bNppObDsjeasDDcVr8i5z8F5rp+bLC/esQFBV6uRE3Pqmlouoo6jDQgH2
 qqG0/vlJT+wn2Z+LMSkStzClFvHlxI3F1jfjlveiu8LD2FU9J2EEQpxpYRuIlTy5JkBL
 YgCn5Tyw2Tn+zsyPy5v9tB3D4Aktovg9VvMphws19w9dbY91ZUceA0ry1EL5G6GaO8YZ
 vbP6pFZrfgIVS/7KLT/Km5ifgAaRHsdceO2ON+if57fpVns7iSecr9tgo9JBT4yV4aTk
 EEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271998; x=1712876798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LosuIyCzAc9oB5OxDPZNgW94mh4MJImjLMLCS31GDcs=;
 b=dcHFGl+m5Vj81SPoyL6nmkZQpswTSZW8KfzrVCQuFMJRMA5y22mUGsLUSx7sqHqj61
 UejsNzTtg7v2B0fNHFHZ/xlxe/+pXFV4xEVyDP/sijkqKfB2wN0LoUHGli8LSCXo7Z99
 kBhj35867VPHEABta4xksESROQ/wz8aP1OuMcn101gDGp0eAC2xVn4DWNXHznRo99HpU
 CEP5ohRC9MGcltZY2mwvMv/QmnYPYHXa8TK/3p/C6CScooK7InrnSQIC5bqVq8TKhYLf
 juUtsPhcXzWXFZw2uwVvBFhf0jy2lzzcSNjK3fr6kAW5iBk39PydxoXmNR4RJyLU7bkB
 hKIg==
X-Gm-Message-State: AOJu0Yw3xbbLkc6NLvj0UEoRtMoMlGXF749M92h3fBCFPk7czHlbs7wJ
 PLWg5QXqvT31LplOL0z1TOw6uZzAyPLnGrBrNiuvrTdbP0OHjb/xD8uph20XA01UscrlzehAe6b
 h
X-Google-Smtp-Source: AGHT+IHMIRLJhyL9Zn+ySZVosoU5VKM7FZ4SrGuuto1/hTJ+QBTXfWXQFPjcLuht20rS042UVy2log==
X-Received: by 2002:a17:90a:cb8d:b0:2a2:7064:447a with SMTP id
 a13-20020a17090acb8d00b002a27064447amr1166183pju.18.1712271998141; 
 Thu, 04 Apr 2024 16:06:38 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 18/21] plugins: Split out common cb expanders
Date: Thu,  4 Apr 2024 13:06:08 -1000
Message-Id: <20240404230611.21231-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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


