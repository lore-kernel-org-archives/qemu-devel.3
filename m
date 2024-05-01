Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BD8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B6I-0002wR-GY; Wed, 01 May 2024 10:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5s-0002i3-1r
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:38:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5q-0002BA-9u
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e834159f40so54901245ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574277; x=1715179077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LosuIyCzAc9oB5OxDPZNgW94mh4MJImjLMLCS31GDcs=;
 b=vTCB5tQvM50YpdBeVz8D6pebQI80Q+7T455w0ay2f0krxCo2D/Dn6uyWahXq3s0+EN
 07BGdZzCraE2Eki8QbZXK7omRAKirB8k+DRfGdPgTr0NEELmoU9LQwhupvmn+0do72eb
 Zbpq/st4Y8Yvy2Gq5kFYMxzZ+irkdkf+7WlLCJO9+tHb9SNcsxjWYUeHB+TC2AAtWr+C
 js/hrmHOpigU4H/F2Mv+xxN7UCXvQlcrX0J20BDUgKeHzx1VmQj2Fnwx/fhYkjv1gCiE
 rV5EmG1CDnEuhpuDjGLGV9aTrVeJZKbK7OrYEUgPRrkLG6keXO/mbK+cg5Lo4/JTU1zE
 VDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574277; x=1715179077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LosuIyCzAc9oB5OxDPZNgW94mh4MJImjLMLCS31GDcs=;
 b=ZsoF6Mtw2UH8lTsY2vl19SAi/MpDmtt8L9Fm2Wv57nQr4OMEevev6CUZEKfHLrYMwp
 anKfkYtAxcBMB+COW1cwKZZRQPcAOc+hgZORtmkZML0mr0yQ+1c/YBVlH8VMAPv6nJ3K
 VrFL7v3jpET6hjbs1HqqWp1FworGFJv+VoORRfJoHcx04H6xljGZm5f81qpQ1GoHSEXe
 vx9HUf2B1nMKoU7uPLbfppOAT3AAjnh3ZlB7GQjKS8+UohKPYkKMkLABayLGCh+rb73N
 LzZNvP8ElsrNtcJ5JLb8ikZnnUTmdHh/PXPffNjy/Evm1Z7oXZY+EYRnLypDsefMO/HP
 0ZUA==
X-Gm-Message-State: AOJu0Yx+qQcwrETPXYHQmwD87cmgavoGlznlabpQbySiRw565O4URTpH
 xDwU6PsFJjR8ozONYH8U6JbM3E/xpSs8NImnGYsqI3IKhzcKM4q743YQeNMYEQc2jYZE6IgT/vv
 j
X-Google-Smtp-Source: AGHT+IF+y7oen/nC5CMg+KmtOnc7dTRsuA7S5HcdrsUy4BA6fz3On2HA/UmBGQ7nUn9tYRvTFsx3rQ==
X-Received: by 2002:a17:903:1d1:b0:1e4:d548:81a0 with SMTP id
 e17-20020a17090301d100b001e4d54881a0mr2275720plh.67.1714574276973; 
 Wed, 01 May 2024 07:37:56 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 17/20] plugins: Split out common cb expanders
Date: Wed,  1 May 2024 07:37:36 -0700
Message-Id: <20240501143739.10541-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


