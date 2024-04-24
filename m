Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D654C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5i-0005vI-HU; Wed, 24 Apr 2024 19:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5d-0005qV-Et
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:49 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5b-0003TG-FA
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:48 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2a78c2e253aso362284a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001505; x=1714606305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KENF3qoIai8EKBqtt1xiPdTvHherBETdFHxGPatGjNo=;
 b=ay3UI16VzwPNIR9/lwrs7GlF7Ug8G0PovI0WsPM9Pt1ads0+DM6/qO8oS8J/SysXjX
 k1d9UhSdpUst50BCjJ5FfNPpH6SStn3FHkgjp4HjmGutWEUdaLNnm1sGSmt9NeHGGA2/
 +GvFiBO7/L+yccob6tL92zpLQJqcMlgZ3VyHF5kjpwSVfPUVsDWCBssskwd1mQbBGBLA
 bxWCEzGTNTGpj45W/7E1L8HNJLczXJLYY7lfur+q8vkji5JByhBDfeQmE6IoEsd2/jWp
 GQyqe924WSSwEHbNWuJpt6N8aDKqis+epHrw6XbW34GnHThcKUZO1W7WGQnlA3yEIUEb
 RLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001505; x=1714606305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KENF3qoIai8EKBqtt1xiPdTvHherBETdFHxGPatGjNo=;
 b=mVzWtNykNKifOYrcvKSsiykvpTBx3eIdRRnnORJ/gtsTfCy//1dFJMAKmHUvJuxr94
 yx23R9c2w5FDAhC+n9T002WOYp0cKzR/Op27DLeAP+kD6OrddV1CSsruS1VKLjlrdIIh
 Fu7rTxafZuAKMEdM5Un1I71lf/pAfNtsiEbMQZ4Tm59EZv+6MXgHnJ1/EosVgzRXy/tu
 CBVN1T3dc3lFxz5NSgmaHr0V14iTTZSdDSDz2xXhkpDFeVuIuOgp6pmw90jZT1ukli+k
 I3QYouPwfo2nxelqX4/3yy3ERcnRyVllcyageNPQYulgJQMx9Q8wzsTF/YmtQyS6bche
 jQ6w==
X-Gm-Message-State: AOJu0YwX2SGKGaYvBRwvayIv0x5OnlXIXb+FIXjeBrpFX7G7BSkbTJm5
 J7V+s8ZMonlxK+wCoT1ou7tWzWaywIy5nxwZCj12JdaUNyI0oESXxw24detYhOslqrHOVXNnG/T
 W
X-Google-Smtp-Source: AGHT+IFJn1RiMXYPk4yNLmKC2HHb1p615H+FUV03h3IwA0E+iZBC/VmxfWt/JZiDK8qTQUB4VIEzMg==
X-Received: by 2002:a17:90a:fd07:b0:2a2:5e8c:3a47 with SMTP id
 cv7-20020a17090afd0700b002a25e8c3a47mr3694685pjb.48.1714001505432; 
 Wed, 24 Apr 2024 16:31:45 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 14/33] plugins: Use DisasContextBase for
 qemu_plugin_tb_vaddr
Date: Wed, 24 Apr 2024 16:31:12 -0700
Message-Id: <20240424233131.988727-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

We do not need to separately record the start of the TB.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 1 -
 accel/tcg/plugin-gen.c | 3 +--
 plugins/api.c          | 3 ++-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 3db0e75d16..340e10ef12 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -117,7 +117,6 @@ struct qemu_plugin_scoreboard {
 struct qemu_plugin_tb {
     GPtrArray *insns;
     size_t n;
-    uint64_t vaddr;
 
     /* if set, the TB calls helpers that might access guest memory */
     bool mem_helper;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b036773d3c..2c52306f80 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -188,7 +188,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
     int insn_idx = -1;
 
     if (unlikely(qemu_loglevel_mask(LOG_TB_OP_PLUGIN)
-                 && qemu_log_in_addr_range(plugin_tb->vaddr))) {
+                 && qemu_log_in_addr_range(tcg_ctx->plugin_db->pc_first))) {
         FILE *logfile = qemu_log_trylock();
         if (logfile) {
             fprintf(logfile, "OP before plugin injection:\n");
@@ -318,7 +318,6 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db)
 
         ret = true;
 
-        ptb->vaddr = db->pc_first;
         ptb->mem_helper = false;
 
         tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
diff --git a/plugins/api.c b/plugins/api.c
index 4b6690c7d6..36ab47cdae 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -200,7 +200,8 @@ size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb)
 
 uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
 {
-    return tb->vaddr;
+    const DisasContextBase *db = tcg_ctx->plugin_db;
+    return db->pc_first;
 }
 
 struct qemu_plugin_insn *
-- 
2.34.1


