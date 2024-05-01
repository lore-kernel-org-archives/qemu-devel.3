Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42DBC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B6M-00032L-EG; Wed, 01 May 2024 10:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5v-0002j1-Rk
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:38:04 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5u-0002Cb-2z
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:38:03 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ec4b2400b6so15852765ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574280; x=1715179080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8VOItWkFsBquzhiz/l7Y2hIgNzVUVvjoEVZSZUA8wY=;
 b=H7+ZAyILik/agYQQPephKxCc/UzAY6YTsy0NL//xa2bYVM3f8TI+sjGws++OEqaCm6
 3lMDVtYzvda3+X421DRloF1q9pkz/RLY89/gNGQz5e1WCYXk4MoOgfJayoziILDgQjiE
 nlRVPKaqAGFBFum+Hig5s0QGlpfne20MAdPImu6J0EAETFrJcEVwHh14MNHVypfT+HQz
 dMJWobyMyEbha0Xm4SGEPFWHR0tnvuaxIhSqZht0HDb2eEzJ/tPT1GWSZXP0gup2PHV3
 WhjqTn0jTxu+AHC5wM/SgiJCGs1w4+HMp6dcp7AJ3PMMO7E50oJlnG9Jbq7geN+IbLNq
 h6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574280; x=1715179080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8VOItWkFsBquzhiz/l7Y2hIgNzVUVvjoEVZSZUA8wY=;
 b=rwhO+ePRbRPZ2dz0gd+sqsCcDHXcqI4aFc3OEpDI77BkMaNl2Od37rHJRFr10xYK7O
 187tWH0dJRsp1TRQE2vUNDgIh50EOa2Iuc/E6gNelkcKJjNANbmTc1mkP4qew6sZ6Az3
 bdqm+j9tpytixAYh1AcVxqGA2sVmc0hbsh6IqNh1+8KdPpxFKDTiKhqVuiRGErK7nDiW
 /J+ED+MKkS+0RLVy5goAZIf4dHhcdQwkSDcjpGDx/GYX4DahnUSoN1HSAoJtGb6Luqsc
 NBm9QadAgWC5Br5q1hE+UPEeIonCxxnzOXUVAU9BNDRvsJPuyRD/sfsJ/vBBZOg0oigv
 +fMA==
X-Gm-Message-State: AOJu0Yycbmdx8RjQYCsKCToqvhPuxeYOnpbdPTedSKotxUAthTPTcCUO
 T+slZXxjdX7F7FJijEs1ItkypiFMlBngqJf4e+HLXb5oTcPI05Ykn6D47ktN9xVL/Q9moE9RoYA
 V
X-Google-Smtp-Source: AGHT+IGkqbLMH+BnpkzLGVQzfbdsNqe1px9mcqHECVSYpuT1qMqwGY83dILCVJsBieRigWkQFBQTMg==
X-Received: by 2002:a17:903:428a:b0:1ec:53de:a527 with SMTP id
 ju10-20020a170903428a00b001ec53dea527mr2271451plb.59.1714574278584; 
 Wed, 01 May 2024 07:37:58 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 18/20] plugins: Merge qemu_plugin_tb_insn_get to plugin-gen.c
Date: Wed,  1 May 2024 07:37:37 -0700
Message-Id: <20240501143739.10541-19-richard.henderson@linaro.org>
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

Merge qemu_plugin_insn_alloc and qemu_plugin_tb_insn_get into
plugin_gen_insn_start, since it is used nowhere else.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 39 ---------------------------------------
 accel/tcg/plugin-gen.c | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index f5a08b1220..18062528c1 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -129,14 +129,6 @@ static inline void qemu_plugin_insn_cleanup_fn(gpointer data)
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
@@ -153,37 +145,6 @@ struct qemu_plugin_tb {
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


