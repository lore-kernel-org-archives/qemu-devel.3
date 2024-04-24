Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F2FC19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5i-0005vL-TI; Wed, 24 Apr 2024 19:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5d-0005qW-FP
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5b-0003T5-7q
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e2b1cd446fso3240685ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001504; x=1714606304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wv67pMXMsVcEOwYDni8f26C2u4kTVwgef8xc6CDT8l8=;
 b=sLV5oU+Uw0T4UL4iQlbocUTMqV2YHv6NCaNJketkZ14ADOQTQM5TFyeRhBEoNBy4g9
 QsQbEvn84naHPlVGpVMFkevl9cd6092hEYDrATsu8Q1sdeJ17PsCYdvdPUTUAPw+YGrT
 28Uvg4HrzesgQt5jInifMX1HA4lgN5pMHRwoKNoKo7vOcFT0PNAhrUb2aDJxw1Iw7qWX
 NnSawB0/mQeJeqO4i+gqj0QwCKcFI+wW32f1HHavS1c6pnX2SSaY0ngT0CE20xsm5bw7
 k178U9IkzxU04pWG1hg/KMSBOMACDT6LtqEODa0yViVv08BQOVmkm6HUElrbL1uGoE7V
 2Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001504; x=1714606304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wv67pMXMsVcEOwYDni8f26C2u4kTVwgef8xc6CDT8l8=;
 b=MzRwfZdlc98kdPhZqnLcJpzhLEfulNy7Q4gx/51ROF91ixX19NdXYunhFcvohhcjmK
 B3SXDfBZ7H3AL6AVn+kcWwTUN6vFfMAbwdYGP7Az4QHoGG7zYLU8kAPPIz9nCFb5G83k
 AU6jrU6aNSZLfqWWqkKxiZ7tAfZEC5nzpsjgqcD69eY4O2kaQzcMNHKoHBxBOU1mAmPQ
 37pHpMgkbstiCrOIfzBIRQYy28IKxlc/coriwVGKC4Y9idIUFjayN0gdi9hgU8oDnSoz
 YkU0eowD0rqTCezQQxEMfz4AiAVopdajCAEBasrWqKGwRjdELImbJBk9cLojD4V52SWa
 hQoQ==
X-Gm-Message-State: AOJu0YwMeGJVOUXdD3n8BuGj12dTvTVJKQnQi7gp2NsTPz4t3xa4Q1r9
 +Q4iA9akReOyLHtQxIuJLO549g1mNcOJ0SXcSJmwX+pfkAxIF9NtRtAY8ENh1cX2lNbqsmBvv0J
 E
X-Google-Smtp-Source: AGHT+IG0YCejzMgIysj8hAViX1iOXTrDp+CuqlSgVZMZTQeUImhzqMeORAakjTD5zxf6SCNUERmJ2g==
X-Received: by 2002:a17:90a:ec15:b0:2a2:d498:eec2 with SMTP id
 l21-20020a17090aec1500b002a2d498eec2mr3678391pjy.40.1714001504519; 
 Wed, 24 Apr 2024 16:31:44 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/33] plugins: Use DisasContextBase for
 qemu_plugin_insn_haddr
Date: Wed, 24 Apr 2024 16:31:11 -0700
Message-Id: <20240424233131.988727-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
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

We can delay the computation of haddr until the plugin
actually requests it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  |  4 ----
 accel/tcg/plugin-gen.c | 20 --------------------
 plugins/api.c          | 25 ++++++++++++++++++++++++-
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 03081be543..3db0e75d16 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -98,7 +98,6 @@ struct qemu_plugin_dyn_cb {
 /* Internal context for instrumenting an instruction */
 struct qemu_plugin_insn {
     uint64_t vaddr;
-    void *haddr;
     GArray *insn_cbs;
     GArray *mem_cbs;
     uint8_t len;
@@ -119,9 +118,6 @@ struct qemu_plugin_tb {
     GPtrArray *insns;
     size_t n;
     uint64_t vaddr;
-    uint64_t vaddr2;
-    void *haddr1;
-    void *haddr2;
 
     /* if set, the TB calls helpers that might access guest memory */
     bool mem_helper;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index a4656859c6..b036773d3c 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -319,9 +319,6 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db)
         ret = true;
 
         ptb->vaddr = db->pc_first;
-        ptb->vaddr2 = -1;
-        ptb->haddr1 = db->host_addr[0];
-        ptb->haddr2 = NULL;
         ptb->mem_helper = false;
 
         tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
@@ -363,23 +360,6 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
     pc = db->pc_next;
     insn->vaddr = pc;
 
-    /*
-     * Detect page crossing to get the new host address.
-     * Note that we skip this when haddr1 == NULL, e.g. when we're
-     * fetching instructions from a region not backed by RAM.
-     */
-    if (ptb->haddr1 == NULL) {
-        insn->haddr = NULL;
-    } else if (is_same_page(db, db->pc_next)) {
-        insn->haddr = ptb->haddr1 + pc - ptb->vaddr;
-    } else {
-        if (ptb->vaddr2 == -1) {
-            ptb->vaddr2 = TARGET_PAGE_ALIGN(db->pc_first);
-            get_page_addr_code_hostp(cpu_env(cpu), ptb->vaddr2, &ptb->haddr2);
-        }
-        insn->haddr = ptb->haddr2 + pc - ptb->vaddr2;
-    }
-
     tcg_gen_plugin_cb(PLUGIN_GEN_FROM_INSN);
 }
 
diff --git a/plugins/api.c b/plugins/api.c
index 39895a1cb1..4b6690c7d6 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -242,7 +242,30 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
 
 void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
 {
-    return insn->haddr;
+    const DisasContextBase *db = tcg_ctx->plugin_db;
+    vaddr page0_last = db->pc_first | ~TARGET_PAGE_MASK;
+
+    if (db->fake_insn) {
+        return NULL;
+    }
+
+    /*
+     * ??? The return value is not intended for use of host memory,
+     * but as a proxy for address space and physical address.
+     * Thus we are only interested in the first byte and do not
+     * care about spanning pages.
+     */
+    if (insn->vaddr <= page0_last) {
+        if (db->host_addr[0] == NULL) {
+            return NULL;
+        }
+        return db->host_addr[0] + insn->vaddr - db->pc_first;
+    } else {
+        if (db->host_addr[1] == NULL) {
+            return NULL;
+        }
+        return db->host_addr[1] + insn->vaddr - (page0_last + 1);
+    }
 }
 
 char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)
-- 
2.34.1


