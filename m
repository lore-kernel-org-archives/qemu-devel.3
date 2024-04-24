Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EECC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldb-0003sI-AK; Wed, 24 Apr 2024 19:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldY-0003qD-Bn
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:49 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldW-0002fW-J3
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ed627829e6so502380b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999765; x=1714604565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3LtGKJ/E6t3oKQLojhaCAB+/niRzlzRz3BS8xhiLDs=;
 b=wuV6QoWw42iktFgmXcXz9JGWu4MYTzgIYm6nyDXbyVI/6QWvMvQ5wmqF0r8VIWZRLA
 ZtPaEs/kUkAEUWFU7riKTuVgtf7a9WlRJpCVpfd/uUaBGfqKlnS2JNvFab4KRCzO/peF
 brcMQGtMbYmTenCqIVsRY53buCn382v05O8tN1zSkR1on7zg70+cdgVqgJD7X8lCs/q2
 ydG7OC7gO70lvNthBah6wVZd5+C9JCToSDlq5AxMsNVrgqxaeZ+plXmF43hcV6qB5KlA
 kVq+KdOG3wlMNZgUATf3TXJWcccpfwhjdTEIip0nQqsLqjbfu55fkxTb1yBenz5m8G1p
 edSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999765; x=1714604565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3LtGKJ/E6t3oKQLojhaCAB+/niRzlzRz3BS8xhiLDs=;
 b=Bg2h2ZO+ZV+ium8qE4S23xgTRsPQo7dK3rRxdO4jIOn8+QpT7vRC1riaHNwQlbl4zr
 EUNiekP9cExg5YkW6BZheJOWc9tFxg8ZRwaRJcLt24g/g1YZVY02CJHby3pI/HAmYBqM
 oQ/Lhe8ZjLagre+WeXo49skZmFBawIhozWCCtv1a/ilLsl3BbxvFaJ/FFKRc186Ycfw9
 SwG4RxgNXUQQrIGnxaUZCqhoBS2akSb4L3Gk11kzrHNbnUJqrN9K94t7XsC+OuE1vCpp
 eDTUxzEsBBsA097zt+TyY7N2d+/96JnrA5E8/K21ilzAzd0gB6GE660k4hxRChlVYMby
 BO4A==
X-Gm-Message-State: AOJu0Yz0uBh1pVDe7NxbL/rwBFIAn+oEmHAmfL2zVnIdc/RKMHfQh7CP
 MM0c2nRcThzxH3JkLIL+hEnlWuxJEsZljLplw+BV3i2MIDRyUyorYPOUzdSu40RmPspPyd2kLqV
 9
X-Google-Smtp-Source: AGHT+IHXCkQKCNc2ZEYnwRg/udvNqpx2kQenTEV2MHVTNDjYBvIwOX7rM24VWsjz5ygipbBGd5OWlA==
X-Received: by 2002:a05:6a21:3991:b0:1a7:c67:82ff with SMTP id
 ad17-20020a056a21399100b001a70c6782ffmr5103506pzc.13.1713999765221; 
 Wed, 24 Apr 2024 16:02:45 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 18/20] plugins: Merge qemu_plugin_tb_insn_get to
 plugin-gen.c
Date: Wed, 24 Apr 2024 16:02:22 -0700
Message-Id: <20240424230224.941028-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Merge qemu_plugin_insn_alloc and qemu_plugin_tb_insn_get into
plugin_gen_insn_start, since it is used nowhere else.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 39 ---------------------------------------
 accel/tcg/plugin-gen.c | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 34498da717..07b1755990 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -128,14 +128,6 @@ static inline void qemu_plugin_insn_cleanup_fn(gpointer data)
     g_byte_array_free(insn->data, true);
 }
 
-static inline struct qemu_plugin_insn *qemu_plugin_insn_alloc(void)
-{
-    struct qemu_plugin_insn *insn = g_new0(struct qemu_plugin_insn, 1);
-
-    insn->data = g_byte_array_sized_new(4);
-    return insn;
-}
-
 /* Internal context for this TranslationBlock */
 struct qemu_plugin_tb {
     GPtrArray *insns;
@@ -152,37 +144,6 @@ struct qemu_plugin_tb {
     GArray *cbs;
 };
 
-/**
- * qemu_plugin_tb_insn_get(): get next plugin record for translation.
- * @tb: the internal tb context
- * @pc: address of instruction
- */
-static inline
-struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb,
-                                                 uint64_t pc)
-{
-    struct qemu_plugin_insn *insn;
-
-    if (unlikely(tb->n == tb->insns->len)) {
-        struct qemu_plugin_insn *new_insn = qemu_plugin_insn_alloc();
-        g_ptr_array_add(tb->insns, new_insn);
-    }
-
-    insn = g_ptr_array_index(tb->insns, tb->n++);
-    g_byte_array_set_size(insn->data, 0);
-    insn->calls_helpers = false;
-    insn->mem_helper = false;
-    insn->vaddr = pc;
-    if (insn->insn_cbs) {
-        g_array_set_size(insn->insn_cbs, 0);
-    }
-    if (insn->mem_cbs) {
-        g_array_set_size(insn->mem_cbs, 0);
-    }
-
-    return insn;
-}
-
 /**
  * struct CPUPluginState - per-CPU state for plugins
  * @event_mask: plugin event bitmap. Modified only via async work.
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 5b63b93114..c0cbc26984 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -373,11 +373,34 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
 void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
 {
     struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
-    struct qemu_plugin_insn *pinsn;
+    struct qemu_plugin_insn *insn;
+    size_t n = db->num_insns;
+    vaddr pc;
 
-    pinsn = qemu_plugin_tb_insn_get(ptb, db->pc_next);
-    tcg_ctx->plugin_insn = pinsn;
-    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
+    assert(n >= 1);
+    ptb->n = n;
+    if (n <= ptb->insns->len) {
+        insn = g_ptr_array_index(ptb->insns, n - 1);
+        g_byte_array_set_size(insn->data, 0);
+    } else {
+        assert(n - 1 == ptb->insns->len);
+        insn = g_new0(struct qemu_plugin_insn, 1);
+        insn->data = g_byte_array_sized_new(4);
+        g_ptr_array_add(ptb->insns, insn);
+    }
+
+    tcg_ctx->plugin_insn = insn;
+    insn->calls_helpers = false;
+    insn->mem_helper = false;
+    if (insn->insn_cbs) {
+        g_array_set_size(insn->insn_cbs, 0);
+    }
+    if (insn->mem_cbs) {
+        g_array_set_size(insn->mem_cbs, 0);
+    }
+
+    pc = db->pc_next;
+    insn->vaddr = pc;
 
     /*
      * Detect page crossing to get the new host address.
@@ -385,16 +408,18 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
      * fetching instructions from a region not backed by RAM.
      */
     if (ptb->haddr1 == NULL) {
-        pinsn->haddr = NULL;
+        insn->haddr = NULL;
     } else if (is_same_page(db, db->pc_next)) {
-        pinsn->haddr = ptb->haddr1 + pinsn->vaddr - ptb->vaddr;
+        insn->haddr = ptb->haddr1 + pc - ptb->vaddr;
     } else {
         if (ptb->vaddr2 == -1) {
             ptb->vaddr2 = TARGET_PAGE_ALIGN(db->pc_first);
             get_page_addr_code_hostp(cpu_env(cpu), ptb->vaddr2, &ptb->haddr2);
         }
-        pinsn->haddr = ptb->haddr2 + pinsn->vaddr - ptb->vaddr2;
+        insn->haddr = ptb->haddr2 + pc - ptb->vaddr2;
     }
+
+    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
 }
 
 void plugin_gen_insn_end(void)
-- 
2.34.1


