Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F84C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJJO-00031o-UO; Fri, 15 Mar 2024 21:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJK-0002zg-72
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJI-0000oz-1Q
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:09 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1def3340682so9382885ad.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554287; x=1711159087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4SjKUXNEFn8jDbcremHLBaU7vP8s71moqLjJgD1MWo=;
 b=xzA0WqcAHeHxjLeWnIhZg/prJCBfMEv2ET1JtrkHP5YZPeah3Tq/71Husc1FUnFWym
 N2F+Mxeufi8y54joz/9vFarUPoK4xn/+f1sFdOg30YflAfQg5B5xzDxsSanIqZH7hxTF
 QTcBPPvyzvvW7YZV9r0F1mMM7jy72ifWa5zWe3j4uOl1hNK9R/G7V4zc2h9Efjo5YnDn
 9mxCb/z1nWW1pDl7/9t9WH74CcxLjc1ReT8od1bQ3bAlUYBqfHWZXfCh4CAbVfVwOhDI
 xTk63QBkz6Gbcl8ZCTKVecks0tC5t2i0uvGgE7QcTU8RKZUrHz/rnID+LB7EMvAfVK5g
 lW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554287; x=1711159087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4SjKUXNEFn8jDbcremHLBaU7vP8s71moqLjJgD1MWo=;
 b=JOPERhGsLQgxGm8Owas9HzhOr1z47Fx2b962LtwM7bi/U/LS7n9Op+yN6GzRmMg6jr
 C2YLya2G+8dyFDomPm2H04dZwzQUAwoqHuH2tm+NBl9pcyS6/ZNrw2VYDrW4UzAoWnXz
 3CO+l6g58qWQ/GovbosQz0yiuMgEN6VQ69dbMyJuqIEhoLBNzJ5TUwAdOYFJ6U0qPiWQ
 c3HmHBAmW2NgQ74X+fK+7FpjoFfW8fGm+3BXm2/BQrwvOWLW07IDkl8eFxBUmxwI0kl7
 PURXXL7l/M/iogfbak40tX7cfkhcOuvvOynI3gWNTt8zoZPTxO+ZaTQEXrijcba81CFk
 UE2A==
X-Gm-Message-State: AOJu0YzHrXdvKRpZO4H/lu8dI/FAGbop4q5mODEnMNzxh3Cyye5xFU5J
 OpzCQuPB9CW1cq3HRpgKmJDC+gasxjQPVwh9ZVzK+ntlVHX+CCYZ4uKAXLjWz3eL54kovJPQ978
 R
X-Google-Smtp-Source: AGHT+IFIwvdSo7tuP3JFks4kY7xZI62itBZPyVC5EFH5PpO9hMd25d1/82zIKz6i04zm7Y2FxAaCMw==
X-Received: by 2002:a17:903:1108:b0:1da:1daa:e2bd with SMTP id
 n8-20020a170903110800b001da1daae2bdmr8335452plh.19.1710554286810; 
 Fri, 15 Mar 2024 18:58:06 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:58:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 21/22] plugins: Inline plugin_gen_empty_callback
Date: Fri, 15 Mar 2024 15:57:19 -1000
Message-Id: <20240316015720.3661236-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Each caller can use tcg_gen_plugin_cb directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 70914c3bf8..fd52ea3987 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -67,19 +67,6 @@ enum plugin_gen_from {
     PLUGIN_GEN_AFTER_TB,
 };
 
-static void plugin_gen_empty_callback(enum plugin_gen_from from)
-{
-    switch (from) {
-    case PLUGIN_GEN_AFTER_INSN:
-    case PLUGIN_GEN_FROM_TB:
-    case PLUGIN_GEN_FROM_INSN:
-        tcg_gen_plugin_cb(from);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
 void plugin_gen_disable_mem_helpers(void)
 {
@@ -369,7 +356,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
         ptb->mem_only = mem_only;
         ptb->mem_helper = false;
 
-        plugin_gen_empty_callback(PLUGIN_GEN_FROM_TB);
+        tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
     }
 
     tcg_ctx->plugin_insn = NULL;
@@ -426,12 +413,12 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
         insn->haddr = ptb->haddr2 + pc - ptb->vaddr2;
     }
 
-    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
+    tcg_gen_plugin_cb(PLUGIN_GEN_FROM_INSN);
 }
 
 void plugin_gen_insn_end(void)
 {
-    plugin_gen_empty_callback(PLUGIN_GEN_AFTER_INSN);
+    tcg_gen_plugin_cb(PLUGIN_GEN_AFTER_INSN);
 }
 
 /*
-- 
2.34.1


