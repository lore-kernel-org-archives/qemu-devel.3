Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2294C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8T-0002A7-0q; Mon, 08 Apr 2024 13:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8P-00029Z-Q4
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:21 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8A-0003iZ-7c
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:21 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-29e0229d6b5so3889663a91.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598604; x=1713203404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFanGzrvK8VkKk4csReRv0GVjABsPRaur2/zSeJo0ZU=;
 b=uwIFljoGv92YbwCOlvRKIcXNoBXgui3Skk03YLupbSsyS+ah40scL0kXq6AmbLYJWc
 r3WYfP3QcAO0EOs7nQaqsWwuwg6CR69SALzbCYRQBNT1lsgXK4DYCn3iqlTElF3BWO1E
 n4pDgo0KtRgwvcNFBQYAfsbEXD3n8Q6TlTrzC/IDF6bOnJF4ueInscl8DdQMgaj/O+mj
 v2lo8ZAf9EQ+H7SdLmhbsomk12lKEXjlho/sSB8Jb8AhdtVY2FUneXdhrWMvluFdic7a
 /yUCdbOJGEMyylUnxbaqUD8Vra01ZGnRfV5E10Bet6xTlqX0+/Kf3b3wKMsNOTCu2DEv
 HqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598604; x=1713203404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFanGzrvK8VkKk4csReRv0GVjABsPRaur2/zSeJo0ZU=;
 b=PIexFw/0RWefzA6VpHqYBnLmtQO3oAVJL00jofXy7VqTDBQUdeafwJxpBPNqTK8D1Z
 H7XPpN2M5UwZeow+AKYVeM1afmvFIeFx5W/1k15/4CQrCM4ETQbRBvwUPfN2pmF1Znpu
 sWsuPLsRhPbuK+xB8OitUk0IAKHYajHpLwcAM8zKNDxYsVQbw8bLnW18XBm3NWmpofR5
 Hrx8ccd64szw/csz0m6dxOanlMadaKwe52eBRRqf8x2IVSIIwQQ4/nBx0iZUn/qYGJib
 2s/W4sd8yL7ovUdJ+WIFdyFeOy0ui5Wr+sriYM7in4FxQbb72t18ufdc4EOGLp7776w7
 92Dg==
X-Gm-Message-State: AOJu0YyqwPlz1+iWt2NLCp10QMlNu2enUNwJoLTElT+WEa8cBAr3hAbK
 MIo6BYYWKB1kyYmB3XVklPOcTbwjGydtRPZJK48wWhBBn3ifksm5eTBkjmrjTGSiVbT32BVXEgM
 B
X-Google-Smtp-Source: AGHT+IEVjLISCSOMNT9SjrRAHWJxBYCVsRFpdFzWs3IC/iyoqBaBoeCu25HW/CV86UzfBRDHBoQPjw==
X-Received: by 2002:a17:90a:ba82:b0:2a4:e9d:9888 with SMTP id
 t2-20020a17090aba8200b002a40e9d9888mr8099681pjr.16.1712598603795; 
 Mon, 08 Apr 2024 10:50:03 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/35] target/hppa: Use insn_start from DisasContextBase
Date: Mon,  8 Apr 2024 07:49:16 -1000
Message-Id: <20240408174929.862917-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

To keep the multiple update check, replace insn_start
with insn_start_updated.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8a1a8bc3aa..42fa480950 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -44,7 +44,6 @@ typedef struct DisasCond {
 typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
-    TCGOp *insn_start;
 
     uint64_t iaoq_f;
     uint64_t iaoq_b;
@@ -62,6 +61,7 @@ typedef struct DisasContext {
     int privilege;
     bool psw_n_nonzero;
     bool is_pa20;
+    bool insn_start_updated;
 
 #ifdef CONFIG_USER_ONLY
     MemOp unalign;
@@ -300,9 +300,9 @@ void hppa_translate_init(void)
 
 static void set_insn_breg(DisasContext *ctx, int breg)
 {
-    assert(ctx->insn_start != NULL);
-    tcg_set_insn_start_param(ctx->insn_start, 2, breg);
-    ctx->insn_start = NULL;
+    assert(!ctx->insn_start_updated);
+    ctx->insn_start_updated = true;
+    tcg_set_insn_start_param(ctx->base.insn_start, 2, breg);
 }
 
 static DisasCond cond_make_f(void)
@@ -4694,7 +4694,7 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     tcg_gen_insn_start(ctx->iaoq_f, ctx->iaoq_b, 0);
-    ctx->insn_start = tcg_last_op();
+    ctx->insn_start_updated = false;
 }
 
 static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
-- 
2.34.1


