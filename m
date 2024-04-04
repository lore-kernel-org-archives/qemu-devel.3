Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CC2CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAV-00028F-HA; Thu, 04 Apr 2024 19:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAR-000272-Au
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:47 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAL-0007ox-Qp
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:44 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so1126937a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712272000; x=1712876800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSa2977I3Rq8Xc+67Y2/yCKgEWXvHU4DRnUfHiUzUVE=;
 b=xO+zmGXVMPg0Us5fPhv6Fjv83GcbyrgECUj6JbXfisfn6lSNzsINhsxVORngNwg2li
 OWNS+grktLrMraxpmpKBRkGRQPXH+6z2SYUnxXfSsNg6onQry1/5asWYgboDiiYsgaAo
 wihH8Exv/zrojpfgwNZyVAlYEQKF4YIkah09bkoYWZbrYRCUZ9Fn9DENOBPg+UAV1qdb
 a8RVvFaARbh07hB58awocumjSZGHhM8zVPKwAsw7ZvCo1zsSt0U31iVFDksFgnfxOrps
 VfwQ5ia/MUpbnf+qwjDVjjnu9LZmEiHn6lw/+0XDa2tlRbhrz0FBdltOFKlWTL1KVAxw
 Njug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712272000; x=1712876800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSa2977I3Rq8Xc+67Y2/yCKgEWXvHU4DRnUfHiUzUVE=;
 b=Mwr/m/VPYXrFljkw+9od6hOE272xo1qj8wXVZBH4vz3RFDQfrn0aJJgJl1GKEHKBDc
 vvqadngD1JZGhW0PAwx8fgx92RQeme8DQa+xjxGs343L8iPSjPOPUvRT/qxBXIjnb6Lh
 2dFT3g+TtBcN0NOTZQyzaWoy7MetXfDKnWQVe3Er9JXbwwl9yhcWeNi775or7kZcG6zC
 V8nF8jVHNAX8XYKYuv4OMJWBF0jwpid8HPLUQuN5eP8VPFagBWyohYNzeAls1FkefP2M
 JOnv95dECJrZ3mYskxFyBpi5lB25VRFJyHN+lIM2jAcKGrnZy1jp1Uym/1VWl4dKTVeA
 wx6Q==
X-Gm-Message-State: AOJu0Yyph2FBuXVCo55MIdNfoVFny4uHPr2IKN4V6GnM0lVBCx3awuKF
 1yRZuOybvN5Gx7iT6KMH53vP7TbrPJXekLf4KvxQh+pAKPoDxgZDw2b4cqyjpx5sQmZfnec2Kmr
 f
X-Google-Smtp-Source: AGHT+IFJYcHzYY0rDK188uYBIlwpFDfEgZawsHuD2PpJm28X56udPNkyYFfqbeem8ot8bCMcQyVK8Q==
X-Received: by 2002:a17:90b:3e82:b0:2a1:fcc2:bf36 with SMTP id
 rj2-20020a17090b3e8200b002a1fcc2bf36mr3594875pjb.22.1712272000656; 
 Thu, 04 Apr 2024 16:06:40 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 20/21] plugins: Inline plugin_gen_empty_callback
Date: Thu,  4 Apr 2024 13:06:10 -1000
Message-Id: <20240404230611.21231-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Each caller can use tcg_gen_plugin_cb directly.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c0cbc26984..d914d64de0 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -60,19 +60,6 @@ enum plugin_gen_from {
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
@@ -362,7 +349,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
         ptb->mem_only = mem_only;
         ptb->mem_helper = false;
 
-        plugin_gen_empty_callback(PLUGIN_GEN_FROM_TB);
+        tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
     }
 
     tcg_ctx->plugin_insn = NULL;
@@ -419,12 +406,12 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
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


