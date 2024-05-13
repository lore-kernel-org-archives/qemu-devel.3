Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35A0C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QQi-0004A1-UR; Mon, 13 May 2024 03:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPW-0002yf-LC
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPT-0001QU-0j
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41ff5e3dc3bso17922065e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586465; x=1716191265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5GRNpEQvFWJc+tF6eTBVa97b3dnETbzXExkDc8WgAI=;
 b=bRnU31lbRThKVjamRSWRV4tRWEMwInbq6T/yw1cHp1hx6xtKNSxWh2ckjB5/HeuRkB
 +nafIWRJUukeU1lLyZPt89SWrBdZvyzr0o6/VJZ0Y0Ht42W9FNLgLiCNIcKzyOQOt9J+
 uqtCbBjutY/6krV3aUwJVsUlUUxQafg6BexUdAZcuYO7AosYaLlcCs/oZbTF7GCjCm4T
 TL+QUD4iA20Cgpfvqik7ZW20SA8D9Le9+nVVVrNrGZzuJzdFy6EVb22RA3UbaxrIYJRg
 On6HiBFTdiyt7AnUPn7/UMlII/iNWLkPJZvVQU/PV/xaB+oPNNzm8kALcsfN0TdtYuSn
 w3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586465; x=1716191265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e5GRNpEQvFWJc+tF6eTBVa97b3dnETbzXExkDc8WgAI=;
 b=DaQGk1oz1f9fNJOf9oOxVAPkPfQttzahWZm/avMfdFnvdTTWJpFBsEPMC/uUSRnqmh
 Sri8qIEv3D9RcMlCVbjphaAwn5bWwgmzMKkJrN3a03Iw2BNow8bXBJR89SA+1jJSid2P
 BdHUzlbyUX8EIz4pxVWdHud3f0PGcci7G8DMWGiByDxne5eRfj3PrPuUVgA4CTBur1/t
 oR0NUYa4u/gUNzolYoqS+3mc85MRL+9o2crvylwy/G3qnQv5sH3klvWx5rmgcXE72oJq
 XdnpjnGIlAbpZOntj3Cpd3tRUWja15rP4dHvRKoV4zo9xX57/QN55g/2ypNZnKWEg7SJ
 NhZw==
X-Gm-Message-State: AOJu0YxYc0hTmcbnsHtf1sP110u29EgZCy5+jJ8WCDEWN4/AP44fzAHE
 SBfYkbbMwRjkzZWSYW5zlEEVXeOkT1Cpd4GRAeXaS9cw1NGctbl1BxTuEZ79LLTcaF/DTlV27/y
 CsFQ=
X-Google-Smtp-Source: AGHT+IHO/w8dlaY4PL/nHAw9GUPeAfqhDiPAAWIOTNAIIhCUx6L1QcsT8Ugfe6YJ7S896z2jVPkUcg==
X-Received: by 2002:a05:600c:1c9a:b0:41b:8660:c530 with SMTP id
 5b1f17b1804b1-41fea932021mr76999535e9.5.1715586465612; 
 Mon, 13 May 2024 00:47:45 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 37/45] target/hppa: Implement PSW_B
Date: Mon, 13 May 2024 09:47:09 +0200
Message-Id: <20240513074717.130949-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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
index 1a6a140d6f..2d8410b8ea 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2061,11 +2061,8 @@ static void do_page_zero(DisasContext *ctx)
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
 
@@ -3964,23 +3961,13 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
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


