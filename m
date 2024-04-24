Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9443C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5j-0005wW-G7; Wed, 24 Apr 2024 19:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5e-0005qt-SL
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:51 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5b-0003TQ-JL
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:50 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so344158a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001506; x=1714606306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ftBOVEixPIVqS15sO6yzpwdLAXRK5ukeZC44nc/EnDQ=;
 b=eZXE+hPQo+TLs2J+VlJtfV+zSCEsYfKkcx5dbde8bS8iDnGMWzPAe9nN/hCmjaPzp/
 kH2uMFGMhqfespvwt/IRdzj7C+AJi2ebjP1bn0EuFg/aI4ti0er/UGTzkH+zv+nw/9tE
 QOjqQ3fx99RSPMw/NXCVBLu1+RNrufgTGY6ZTC5BHiPlHP6Ggvpqu2enZVQg4zx+RxbR
 xY3M23DkDWU+x226ircCJ89VGUdC9oGOaaPUYO5FhI0NKhM15h5s3uaJxzTsDzNgz5sJ
 i6Z+gGjHJAzL4nflFJY5hI0Z4dFB3Fk8MPtmyNh7eTOV7dWP0Uc4VDu8M/10/kqpPDVM
 /51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001506; x=1714606306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftBOVEixPIVqS15sO6yzpwdLAXRK5ukeZC44nc/EnDQ=;
 b=tqVRXM7eG59i0giacv3rYsNZ/tFtOz6qfHw5dpr/NZKzjMdL4X4Enx/jGZkpCkqHuv
 WXD/jC4NViuGe2zi05aTMsPBs0ejlB3FjkoqPiTcXPe7xrCa/diFsXothh5mdzNJdnlQ
 woalsIr3GlToNxqmEehfextIj77vn7Loq1XVavMMuh0y/ksvOYosCke3Z6MgE4rd3qyf
 bbJF/h4dmvtQA1peGNy0ONVaGG29DZ/ZqxB3v3tpABlLiftQbOblEiD4f2wsZDkaYaXT
 fH7bC5HoJr2kbX4WzIIEsZiPsWk27kdq1WDA+EdcU5CVqO3PvbiwYNsGiNAXKDQviKtz
 wQrg==
X-Gm-Message-State: AOJu0YyJkadcsOs2stl+ZbHmKHlk2RM9HrkZDil12fDmoaeYa39omkAg
 OcPjga/INjYFFkzbVHnbGZvj65Vs5fW1s5Zofjm+qvnBLmZAILr8Tq8HPVWQOrOY8CiVrEvF6Xo
 l
X-Google-Smtp-Source: AGHT+IGBTjB5DjeHT/L3xK8JmZkBDvlWp4B4GmOxwt/oiKR5Eq3cB6JbgeLHhlFWxcAmkPEKN0taNg==
X-Received: by 2002:a17:90a:e58d:b0:29b:c31:1fe1 with SMTP id
 g13-20020a17090ae58d00b0029b0c311fe1mr1740865pjz.10.1714001506267; 
 Wed, 24 Apr 2024 16:31:46 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/33] plugins: Merge alloc_tcg_plugin_context into
 plugin_gen_tb_start
Date: Wed, 24 Apr 2024 16:31:13 -0700
Message-Id: <20240424233131.988727-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

We don't need to allocate plugin context at startup,
we can wait until we actually use it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 36 ++++++++++++++++++++----------------
 tcg/tcg.c              | 11 -----------
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 2c52306f80..8ebf215645 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -305,28 +305,32 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
 bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db)
 {
-    bool ret = false;
+    struct qemu_plugin_tb *ptb;
 
-    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_state->event_mask)) {
-        struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
-
-        /* reset callbacks */
-        if (ptb->cbs) {
-            g_array_set_size(ptb->cbs, 0);
-        }
-        ptb->n = 0;
-
-        ret = true;
-
-        ptb->mem_helper = false;
-
-        tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
+    if (!test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS,
+                  cpu->plugin_state->event_mask)) {
+        return false;
     }
 
     tcg_ctx->plugin_db = db;
     tcg_ctx->plugin_insn = NULL;
+    ptb = tcg_ctx->plugin_tb;
 
-    return ret;
+    if (ptb) {
+        /* Reset callbacks */
+        if (ptb->cbs) {
+            g_array_set_size(ptb->cbs, 0);
+        }
+        ptb->n = 0;
+        ptb->mem_helper = false;
+    } else {
+        ptb = g_new0(struct qemu_plugin_tb, 1);
+        tcg_ctx->plugin_tb = ptb;
+        ptb->insns = g_ptr_array_new();
+    }
+
+    tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
+    return true;
 }
 
 void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 691b2342a2..6cc9f205c4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -761,14 +761,6 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                   < MIN_TLB_MASK_TABLE_OFS);
 #endif
 
-static void alloc_tcg_plugin_context(TCGContext *s)
-{
-#ifdef CONFIG_PLUGIN
-    s->plugin_tb = g_new0(struct qemu_plugin_tb, 1);
-    s->plugin_tb->insns = g_ptr_array_new();
-#endif
-}
-
 /*
  * All TCG threads except the parent (i.e. the one that called tcg_context_init
  * and registered the target's TCG globals) must register with this function
@@ -813,7 +805,6 @@ void tcg_register_thread(void)
     qatomic_set(&tcg_ctxs[n], s);
 
     if (n > 0) {
-        alloc_tcg_plugin_context(s);
         tcg_region_initial_alloc(s);
     }
 
@@ -1360,8 +1351,6 @@ static void tcg_context_init(unsigned max_cpus)
         indirect_reg_alloc_order[i] = tcg_target_reg_alloc_order[i];
     }
 
-    alloc_tcg_plugin_context(s);
-
     tcg_ctx = s;
     /*
      * In user-mode we simply share the init context among threads, since we
-- 
2.34.1


