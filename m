Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E63C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rj-0004Ay-LQ; Wed, 15 May 2024 03:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Re-00047S-Ov
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:02 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rc-0001aB-9z
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:02 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2e27277d2c1so87258511fa.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759578; x=1716364378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAVbhs+RqNvGH8rJ76ZP56RL9rwGY3Fja1sdqAVH2vU=;
 b=ZqU1SAMb72a2nrqKSrweOxm3I8zg1bPTw8TYNOS8U7IT3662bPrIiMKfUSMYk4dzS+
 a3P6B16cp0VXWzx0Sh1glFQgBMXA+oybipod081YalNVN6mMUqsX8qEJM5uY42f5nrlZ
 Q3fpINdDFQ2JxBDwc8JoXBVLvRLh4nzHo8saQyxcvMQ7y9q0g4cCGvmLGkO13LfvTCe0
 Q+i/2YXuHB3ODx7gTEjx84iD/s7FthsBv54FOHHE+zGHKdbU8w8lE8rKBsQW4Qj56lnw
 o4SCIbvBmHvMiDfZdoKKF5PHCUdVPT5AyM3neGKAShCJIvVeQwv2WBsO4+qRxPvS2OT6
 PkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759578; x=1716364378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAVbhs+RqNvGH8rJ76ZP56RL9rwGY3Fja1sdqAVH2vU=;
 b=YfieW+WscxLIeBIzB9UAmY6ucho+tiiZZt7mMAuyfaGxb3uFNxAi/Duv0TSx3z//8m
 PeyQnrQvoW0t/QEVnxUIPRKPA28s6gx1JKyGElGHi71Ddfg531RuAkwe/2QECVcaoWKg
 lbN0toM20UYLcLlCs5aLPBy/88LrRwCyXGkpUxtucB2Fm33AyCw2A+S65yjqX2LOF5YE
 5t4cZM+yqkU+SGxR0AuhywQrXp5gYQa3yQzT3P3JFwJaiqjKONd1c9S5tFf91j2x+E3z
 FkExvyRF/jK/hR3Wx4TXJC8f7hGhXNICvFfHS72St8rOnF5TDfaDmJuwitXburFiMODR
 LPlA==
X-Gm-Message-State: AOJu0Yyv5kJGB46WoJ8dL0PqBCIwPKfG3HTQjnuQXmeW7jUrtvNFPTHD
 CCFdm7mC4gtwhjZavxL/RWrGOwhX4PRPjO06r0bvl10xfdHOSKV0UY/NdqstaUGfx2BHsk5Wohk
 JD8w=
X-Google-Smtp-Source: AGHT+IG7mcS/uvkhCxXKpUA23tYHaP4Ag0Y/Ym0ofG5+1RkYGaNLPkPYDSKrEgKxBGDQdMVZe/ilhw==
X-Received: by 2002:a2e:2a82:0:b0:2d4:3e82:117e with SMTP id
 38308e7fff4ca-2e5203a4a9cmr97733391fa.32.1715759578722; 
 Wed, 15 May 2024 00:52:58 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/34] plugins: Use DisasContextBase for qemu_plugin_tb_vaddr
Date: Wed, 15 May 2024 09:52:27 +0200
Message-Id: <20240515075247.68024-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22c.google.com
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
index da0f37e269..7fda6ef126 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -118,7 +118,6 @@ struct qemu_plugin_scoreboard {
 struct qemu_plugin_tb {
     GPtrArray *insns;
     size_t n;
-    uint64_t vaddr;
 
     /* if set, the TB calls helpers that might access guest memory */
     bool mem_helper;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c36632e8df..b54494712a 100644
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
index 0ae19774df..02014d4c6e 100644
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


