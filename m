Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CD1C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7xI-0002pp-98; Mon, 04 Mar 2024 08:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7xD-0002HZ-Fo
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:02:03 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7xB-0000sJ-Kf
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:02:03 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so731166566b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709557320; x=1710162120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZL1sDUa615DpN6u4uUnKzORTHjZpx0D0T2egeXx6mM=;
 b=MMlrYDHyHluzj0dg0b/aBQCkangsEPWcQGnh1JFuo1TfYpdm2fj6rTtq54AlorwrFk
 3ytOOlvLnwKrJWyZp7UwJV/efkLi6BNdBmRuaaNnb92WX2yW/CuMkCX/IDo2pA0cAO0o
 crS4uJmxV29OVPjv+4naqw4C150Tt1XwbclPF6UKmvDghp2JYDM9LxXtqv/kP2JM52JN
 6yKkLeX+TneeIA8O7f7O9KDIK2z5bdWW19xjKqT/PFnHTjHKpzk2oIwyzcEnbKK2fghu
 CrvJOiyLkGIHMVaEMo+5p9JGEsP3VGrSYKd/4N6oH0/ok1+plKPJy0r5K1pgAwajnjE4
 1UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709557320; x=1710162120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZL1sDUa615DpN6u4uUnKzORTHjZpx0D0T2egeXx6mM=;
 b=dGNvVmDINY5A0XxXCUuht/PRKJQWKpa+wWbp5WuST5nMUnBaxDXIr/cWdoK04yumtS
 o5kP38xz3mJ3HIVPeUZv3XXWIEDBQordAZFBCUzRui/lLJeMCGiFqCcnOSSXtyovOf59
 fdXfCY4A5KoV5knWxx+kh2wfh/yqN5GrxDqKUInE1haR4FvIHRzlO/yG6vTB0RZ+CjM+
 s6798BkX6jG+vYrwUAHttJauYUAAPiymuJ+PByx20OBA//oJR74qjTqisMmEG8V6NuN+
 tK9AFv6i5XNFef5DAnCHUwz1+hJdglz5AQsadV1w39wUXwE9dpwP5MkyctZvbcCWbOzZ
 BW+w==
X-Gm-Message-State: AOJu0YzpC3iz9xf6kfsLoYsfInTWPIqCFFqHRy27x0ogVLkOCJEYN/87
 T1xvK6yfWLXy0RYyvVBosXnlmdhZNaZn0GtCR615AKvPhChfNrLKXveRzywy96ZG94Jfv/esdfh
 JmBY=
X-Google-Smtp-Source: AGHT+IGad8vCuPdvDaWGAMCdseGkTigwLuSunTmNDXGLNICFDtlXc5jv33POwVLihcnB/7+npQ9yfA==
X-Received: by 2002:a17:907:1049:b0:a3f:4926:a91c with SMTP id
 oy9-20020a170907104900b00a3f4926a91cmr6318889ejb.35.1709557319967; 
 Mon, 04 Mar 2024 05:01:59 -0800 (PST)
Received: from debian.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 tj7-20020a170907c24700b00a413d1eda4bsm4806136ejc.87.2024.03.04.05.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:01:59 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 12/12] plugins: cleanup codepath for previous inline
 operation
Date: Mon,  4 Mar 2024 17:00:36 +0400
Message-Id: <20240304130036.124418-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
References: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x633.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/plugin.h       |  5 -----
 accel/tcg/plugin-gen.c | 13 ++++---------
 plugins/core.c         | 29 ++++-------------------------
 3 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/plugins/plugin.h b/plugins/plugin.h
index f6fa10a0f56..7c34f23cfcb 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -68,11 +68,6 @@ struct qemu_plugin_ctx {
 
 struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id);
 
-void plugin_register_inline_op(GArray **arr,
-                               enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op, void *ptr,
-                               uint64_t imm);
-
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
                                         enum qemu_plugin_op op,
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 47e05ec6347..8028786c7bb 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -440,15 +440,10 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
                                TCGOp *begin_op, TCGOp *op,
                                int *unused)
 {
-    char *ptr = cb->userp;
-    size_t elem_size = 0;
-    size_t offset = 0;
-    if (!ptr) {
-        /* use inline entry */
-        ptr = cb->inline_insn.entry.score->data->data;
-        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
-        offset = cb->inline_insn.entry.offset;
-    }
+    char *ptr = cb->inline_insn.entry.score->data->data;
+    size_t elem_size = g_array_get_element_size(
+        cb->inline_insn.entry.score->data);
+    size_t offset = cb->inline_insn.entry.offset;
 
     op = copy_ld_i32(&begin_op, op);
     op = copy_mul_i32(&begin_op, op, elem_size);
diff --git a/plugins/core.c b/plugins/core.c
index 7852590da88..11ca20e6267 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -316,22 +316,6 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
     return &g_array_index(cbs, struct qemu_plugin_dyn_cb, cbs->len - 1);
 }
 
-void plugin_register_inline_op(GArray **arr,
-                               enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op,
-                               void *ptr,
-                               uint64_t imm)
-{
-    struct qemu_plugin_dyn_cb *dyn_cb;
-
-    dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = ptr;
-    dyn_cb->type = PLUGIN_CB_INLINE;
-    dyn_cb->rw = rw;
-    dyn_cb->inline_insn.op = op;
-    dyn_cb->inline_insn.imm = imm;
-}
-
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
                                         enum qemu_plugin_op op,
@@ -494,15 +478,10 @@ void qemu_plugin_flush_cb(void)
 
 void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 {
-    char *ptr = cb->userp;
-    size_t elem_size = 0;
-    size_t offset = 0;
-    if (!ptr) {
-        /* use inline entry */
-        ptr = cb->inline_insn.entry.score->data->data;
-        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
-        offset = cb->inline_insn.entry.offset;
-    }
+    char *ptr = cb->inline_insn.entry.score->data->data;
+    size_t elem_size = g_array_get_element_size(
+        cb->inline_insn.entry.score->data);
+    size_t offset = cb->inline_insn.entry.offset;
     uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
     switch (cb->inline_insn.op) {
-- 
2.39.2


