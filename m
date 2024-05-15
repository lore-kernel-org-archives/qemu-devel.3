Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ED6C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rl-0004BG-Q5; Wed, 15 May 2024 03:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rf-00047c-2B
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:03 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rc-0001aT-OS
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:02 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41fc53252ceso45478685e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759579; x=1716364379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+l6G3m8cadQ7WYYi4wJCHAd6krJgJAZNy2Yqel8DyXU=;
 b=F0cFWyU5ns3IO7WNAir0D79+zuBBm4SmC8z7APXwfAcMqFILVO68TSuL6IClGYPUUA
 2l7b8241YefEkmLhvjQYz/+Ol4QJVeO9zJH87EwVYf47rpDGNE8fM1OytMnrkFTU33zA
 dwAoOdvFFN7LwWb1rY5t/Kz/B7N3cuUGQ6Rk/mqkc8aiHQX/gdvgGbc8eAgNk06FbqzG
 flzlQ6wZpDIDSaYmOqw116LV0+N6x3BWidQd/GorbtN5/HryKRvT2PskM7pz2ZlXMU+B
 E/ofZXbwBky3LB+34zK6GChsoukJ0c4/fIU6VAAdGdRPtET3Hm6hyYqhXTNFdZ+fAEVH
 BzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759579; x=1716364379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+l6G3m8cadQ7WYYi4wJCHAd6krJgJAZNy2Yqel8DyXU=;
 b=IVKxy2hr/V9BYk811jpzZf0xVjxLaJDAFRQlDJAV3ngFOXPec3n4ZJRtYK6W9TmAzp
 kd24P7RE4tgiZWIVXYRGk2M639mmcTpEvP3YC20UpgZo9TVgVR3Tx3ThN4QxdQM81LEw
 JlQrlvCuIu3Pa8xFGuDVhW7jYYhLa1U2UHH7ssgk8M9fXpaomrFLGdr7M3NdDNMRhRP8
 ClWn6mrP1IyubDL54PM2fKcOledhmcSWfiUjGwb6c2uAN+vU1alkGQkB2zfaiLCQH1Ws
 ZkEuR38rMbzCrl/nS1aaYa47eUQK4NPJ4Ofufn1mRCtvDLUqT7guQg0pcTqbAQup1dUg
 hNeA==
X-Gm-Message-State: AOJu0YwCgNMH6v0Smua9FuH/24ftzdoAqHyyk1PxEep8+kz1fGTAYcY/
 jSjoXO2mWplhZYe9NOC0uIdpsWmlOL5qljKN+0VuG/v6Uk9svjAoPFIfBqKiG/4kJoLo8iZUvGk
 1t4o=
X-Google-Smtp-Source: AGHT+IG3/qUZoGRC/O0keLBWwyrTKOPzY6M6kMYhKO0VuoSqQmlTAYaxSMWHmDqVfpzBGSif8jElXQ==
X-Received: by 2002:a05:600c:a46:b0:41f:f144:5623 with SMTP id
 5b1f17b1804b1-41ff1445732mr117845125e9.14.1715759579343; 
 Wed, 15 May 2024 00:52:59 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/34] plugins: Merge alloc_tcg_plugin_context into
 plugin_gen_tb_start
Date: Wed, 15 May 2024 09:52:28 +0200
Message-Id: <20240515075247.68024-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 36 ++++++++++++++++++++----------------
 tcg/tcg.c              | 11 -----------
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b54494712a..54b08ffc9e 100644
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
index 71daa5d268..34e3056380 100644
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


