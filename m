Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DC1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYK-0008Re-FO; Wed, 24 Apr 2024 20:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXz-0008Je-2e
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:07 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXv-0006Jr-UU
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e9320c2ef6so2777025ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003261; x=1714608061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nB3u9roeckcA1AeJ8eQuq7GKVBVSdTSl/FRX2Yw2q30=;
 b=cVvXfVXqk/w0mKPLcJ4nK4lvB244EQ+14We0heQ6ikX2GfHLgDJN2NaBCJYMoahwe6
 h/H3x+ByxUri9rh6tV8Vlv+dCeUuJF7q6rDn61Q5fCnBN/TNv/ZHX2FKSQZwaFbDDqjI
 wGwhvOUqhKizysfwoP+kZeCAo0sgAG9mesEMlwKPV3hV274/7QZHdwBfN3oehN935+MA
 xit2gbRPqgqkRasxi8VacC9ZVuXiicCSGit3bKv4MD3NLJSPOrCEmJHBEAqUv9KYbbOJ
 dvIn/SE7kxDDmxs8ZdlpLXbrCxeWOw001w8nJqXUdK8RTA3MYQE3oIjoV/VaZYCshK52
 PvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003261; x=1714608061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nB3u9roeckcA1AeJ8eQuq7GKVBVSdTSl/FRX2Yw2q30=;
 b=JSMI1tEVCrvVqbcx9L/BRXq4wRHD73K/DJfd18NMpb2rpP5J/WIXkfe/1dKCmEyUtQ
 4R0Ey3l3S9rGAuT5TIdZrXNJoiPhA0GeI45wtpBa9c5CPmvMx7OydgptqG03Gxfn4oiI
 YGXnY03luugd3qDf4D2TvbAzdNI46Y+BbfDQB9NDNeA4Ep7V6StKwxbo187cExXSF71k
 3LlLGkKsdxONAx6tToRo5Dmgwcu1MDQmS0n5bDgXdYdXbz+L+QEMY8+iN2uhu46QBmzg
 cE1szvLX2C3eE623L6winhLGDMsm2yrqeklAUNFRzkrmHMGR9jNWkCjapeDzBtTH4kpl
 HW1A==
X-Gm-Message-State: AOJu0YzkHrT8GNF0rVIAJT4aE7yIki2wloWtUVhCtkV7lzUvLGR8TF4W
 YFMEzOkocxOhut7CO0eQSp0qLJM0SM+FeD9vjLaHv2QQXirVX2xA2vDta61u5s0APU1bgQQK/hw
 z
X-Google-Smtp-Source: AGHT+IEj13InH1OQZxksukctGiP+E8fGtOUbVjn92Qz++Cl82Ywk5m8GuiBKahPkFLBuxVjddn7Uxw==
X-Received: by 2002:a17:903:120b:b0:1e2:16b6:e9b6 with SMTP id
 l11-20020a170903120b00b001e216b6e9b6mr4787724plh.48.1714003260824; 
 Wed, 24 Apr 2024 17:01:00 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.01.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:01:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/45] target/hppa: Implement PSW_B
Date: Wed, 24 Apr 2024 17:00:15 -0700
Message-Id: <20240425000023.1002026-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

PSW_B causes B,GATE to trap as an illegal instruction, removing
the sequential execution test that was merely an approximation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a49cf09518..a4200742bd 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2060,11 +2060,8 @@ static void do_page_zero(DisasContext *ctx)
         g_assert_not_reached();
     }
 
-    /* Check that we didn't arrive here via some means that allowed
-       non-sequential instruction execution.  Normally the PSW[B] bit
-       detects this by disallowing the B,GATE instruction to execute
-       under such conditions.  */
-    if (iaqe_variable(&ctx->iaq_b) || ctx->iaq_b.disp != 4) {
+    /* If PSW[B] is set, the B,GATE insn would trap. */
+    if (ctx->psw_xb & PSW_B) {
         goto do_sigill;
     }
 
@@ -3963,23 +3960,13 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 {
     int64_t disp = a->disp;
 
-    nullify_over(ctx);
-
-    /* Make sure the caller hasn't done something weird with the queue.
-     * ??? This is not quite the same as the PSW[B] bit, which would be
-     * expensive to track.  Real hardware will trap for
-     *    b  gateway
-     *    b  gateway+4  (in delay slot of first branch)
-     * However, checking for a non-sequential instruction queue *will*
-     * diagnose the security hole
-     *    b  gateway
-     *    b  evil
-     * in which instructions at evil would run with increased privs.
-     */
-    if (iaqe_variable(&ctx->iaq_b) || ctx->iaq_b.disp != ctx->iaq_f.disp + 4) {
+    /* Trap if PSW[B] is set. */
+    if (ctx->psw_xb & PSW_B) {
         return gen_illegal(ctx);
     }
 
+    nullify_over(ctx);
+
 #ifndef CONFIG_USER_ONLY
     if (ctx->tb_flags & PSW_C) {
         int type = hppa_artype_for_page(cpu_env(ctx->cs), ctx->base.pc_next);
-- 
2.34.1


