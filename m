Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90306C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nE9-0001Iz-Uh; Fri, 03 May 2024 03:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDy-0001B8-A3
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:54 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDw-0001Lf-Mg
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:54 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2e242b1df60so5213271fa.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714720850; x=1715325650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEwRBwaFx3imllc5jSpZeArCH45vOi4quQKo4jZx97Y=;
 b=AukzeALrzPrqwcMoeRbdFASqAwghMhkLe+6pujo6w2NJBjVrek26d1ZaigJDVrtkrO
 oxm3B7qSis7Q2Bn5P38qFHQhO80WbOQEKs+AP7iuvASyNMuiSE+JBZIH974JpKwhL1x5
 Kzawzdm0jsRK456k1FvHYcD6cpGxuY78T4A9haPg9x92EMuIUYUYTd48aPHfXydhDWFb
 Km+nXdy1hoynG1uSuRxgIA42mEyZj0plRzSiuHXlKrNKPETQs6iLBbKflqwSnOgs7MLk
 EB+dtEG5tRBkgAfbi2ekkQQ/COkBCfM7tvIZpQNfha1EXaAIYhpr2ltal1fOlpLHyT1+
 +pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720850; x=1715325650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEwRBwaFx3imllc5jSpZeArCH45vOi4quQKo4jZx97Y=;
 b=bp1BXxsaxCqjWHESSBAQOPENUR2ns3t9tBbfVJGLvsjGa2KxgDbukSPcBFPhOxgDiA
 eL8qouzLqSUANYnVpnknrd3Ge16cvCLxmtDC5vVDwya4cnRzpfVZ9CqYFebX1j+SlaMh
 riqMM2b14emVfcAOSTJQKjw1Q2sFzX8hQfLrYXa/xPqPeOJjt/Tjz9nQNXwyIMYT9nJm
 MA9W3B6P9QGgJ2tQhOdC4//y08TI0QQeTlkv0IjGL/9Rsk/jLiu8h4S3oJoI8Q7e+Hbw
 sqG6y7CfAofXSvvexvAzkdI5tmTSji2gIacqoRygeT7bDhgHGs5si9mmneUaAzxC3XDN
 g9Vg==
X-Gm-Message-State: AOJu0YxgE7PRCezz7aYg8jvgJTCn6ieDYp4MxH4+X6uDHBsdT/TxZzZ1
 vYESnQkENVjG5ekcBQJNuY/UXAOBO3dudpcp9nvFmvhZl6nt+IxUdzndI1up1xtbpiTqsTMYSKi
 D
X-Google-Smtp-Source: AGHT+IHiSGnqWHri0FSbErtiFzDM+W9Xy1QEjAkFF48+z55omddn+Q+1j5jhSvJg9VZvK4+QfvwQ6w==
X-Received: by 2002:a05:651c:20a:b0:2df:dea1:5378 with SMTP id
 y10-20020a05651c020a00b002dfdea15378mr1378589ljn.16.1714720850570; 
 Fri, 03 May 2024 00:20:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a05600c4ec900b0041c542636bcsm8275564wmq.44.2024.05.03.00.20.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 00:20:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/9] target/alpha: Simplify gen_bcond_internal()
Date: Fri,  3 May 2024 09:20:10 +0200
Message-ID: <20240503072014.24751-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503072014.24751-1-philmd@linaro.org>
References: <20240503072014.24751-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

Richard Henderson explained on IRC:

  bcond_internal() used to insist that both branch
  destination and branch fallthrough are use_goto_tb;
  if not, we'd use movcond to compute an indirect jump.
  But it's perfectly fine for e.g. the branch fallthrough
  to use_goto_tb, and the branch destination to use
  an indirect branch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
[PMD: Split bigger patch, part 4/5]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 41151f002e..079bd5d3fd 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -461,23 +461,20 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
     uint64_t dest = ctx->base.pc_next + disp;
     TCGLabel *lab_true = gen_new_label();
 
-    if (use_goto_tb(ctx, dest)) {
-        tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
-
+    tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
+    if (use_goto_tb(ctx, ctx->base.pc_next)) {
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
         tcg_gen_exit_tb(ctx->base.tb, 0);
-
-        gen_set_label(lab_true);
+    }
+    /* FALLTHRU */
+    gen_set_label(lab_true);
+    if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(1);
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_exit_tb(ctx->base.tb, 1);
     } else {
-        TCGv_i64 i = tcg_constant_i64(imm);
-        TCGv_i64 d = tcg_constant_i64(dest);
-        TCGv_i64 p = tcg_constant_i64(ctx->base.pc_next);
-
-        tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
+        tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_lookup_and_goto_ptr();
     }
 
-- 
2.41.0


