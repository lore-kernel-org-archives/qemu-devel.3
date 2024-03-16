Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08826C54E68
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJJN-00030r-OF; Fri, 15 Mar 2024 21:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJE-0002xM-7W
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:05 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJB-0000n0-S7
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:03 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-29b7caa88c6so2138075a91.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554280; x=1711159080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vZ2v0E2G9TI2cbvq58iFtaf/WAOAxyxcbXki0MuPsM=;
 b=ELUq04eM19IBBI8w78PudLEx6js0bvZL56QiN73/cOSGSSG5n0LZztIbjhkU4qZfja
 A/h7mwnrYwLPnMI0b0uOgr9P6im2obwsjrZm8YXEb3MUhZVEqT5rs47d/+X9qz6eE6t/
 XnTFGzrGyVVI7Ce7Q9vHV25WFHAyLoCTG701mNd41FX1bzcx5ArVi0ms42NLg/BLgEZ/
 K5Hmv9Puc3i9L7QVmztjcN++6ap9v4OKG55PebdYP+6XwMnMmH1K8XNnEawHGsp06dx/
 VbbnRpuhD62Uy3Us4LOb2lE2w2U07lI36Wil+A4JFStEyoaujXNk5gHc80FdV4uyvZfI
 wnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554280; x=1711159080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vZ2v0E2G9TI2cbvq58iFtaf/WAOAxyxcbXki0MuPsM=;
 b=iHPRnNMS+SLa500DO42YC4VHpF/k98iBmRUx/VR1fCGl0AAdkzfmKmFQPRlH/0YQ1P
 J3ClOU1GLIIIVRt3c3v8O23OXuvWa73M+WBgi1dQB7+uYJPwm0lbDfROhD0Hi5CvcE3M
 AfY8OyYyFwGJbQeMlt4zHXHaqJWodL10A814FlGCHBEr6nne3HQ26LWLBSwjy1VB7r8C
 8qXx5w1QVoqRu2LIxMB4lpMnms0yBeBYRVZunDof250FFeMDkq+GtTS6v+mc8Rjgv1yf
 076z2Jji21DELWVpZIFvcLv5Ay2Mm7lR8WJCUvOZiGisuzFjoAr5E6Vp3EdKEzlakZnE
 n/+Q==
X-Gm-Message-State: AOJu0YxBzSHyr7p/+BqyjSqBxlA0GEiztqXIav0lRYOIXL3mWS9N+1HV
 EpZvoEbUhkeK13A4t+aZU8GIMWl2u/qMSOkMSvdYcppD8VnWLedlHkT3p1PbNfJH/uJ9A5l3dk6
 G
X-Google-Smtp-Source: AGHT+IG/tcZgAvWOBK3LBZCBk/nweKj8eJ7PCS+5319GOiNpb5HYWh1qojDtO1ga4WuaKc/H5Js8OA==
X-Received: by 2002:a17:903:2443:b0:1dd:7d64:8f35 with SMTP id
 l3-20020a170903244300b001dd7d648f35mr7444411pls.31.1710554280457; 
 Fri, 15 Mar 2024 18:58:00 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 18/22] plugins: Split out common cb expanders
Date: Fri, 15 Mar 2024 15:57:16 -1000
Message-Id: <20240316015720.3661236-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 84 +++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 10d917abd3..28414c4ff1 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -194,6 +194,37 @@ static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
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
@@ -255,19 +286,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
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
 
@@ -278,19 +298,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
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
 
@@ -307,33 +316,22 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
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


