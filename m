Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50ABC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8i-0000xb-Po; Wed, 15 May 2024 05:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8O-0006xL-Fp
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8L-0001io-Om
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41fd5dc0439so44821495e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766071; x=1716370871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3G2DK0EX9Noz2yBNpV4zSuKlrdMpRgaC2kALcGrAt4=;
 b=s0CatD/m+z6uHwAnQxRbf+OwuALGScW/HRa0PJskf8twufLmjaLiGeJHwNiKJUZw0n
 KE/uKXvMfwOIvb1Ir+GM3qO9KxHkUnEMNy8wA+B+eNMeiVqGcuaY10HIXEybL+MRze8l
 vJwy0uYO3tBBW7G7/9cl3IuB7zFXvjCy0sVSZNNZgu33mQZudhUzJqb6fw66+0FGG2Gm
 wcOXRV4e7Apy5YaFc/pwgDRXPsRQcxgyKlKSoWw3IYXnXjGyJ62AvicwrPEDOavtIbw7
 bBoRYBpCLxKX+A4YUKEfi0qZxDgRWB1QLIk8uHKhSTv6zK66AlsyO0d7FzF/2J3aZPug
 BnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766071; x=1716370871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p3G2DK0EX9Noz2yBNpV4zSuKlrdMpRgaC2kALcGrAt4=;
 b=gDFjbjB7FEnmYHiES09DnvPYqoTPTITbTWimx6EFpdgw/f9DesKtMUoRgABrea0VFQ
 klNf4oS8OSjSnqf2zumTJNI7TrgDpiPslyVe7QWDqTf+fY6GIaW4dFOkIVesIMSpVrfU
 UP94jIoSN+ju77UbwR5yWdHdvm9LqPXsb8cUo55arE3x+t5G8jCZxnpkoG6Lo7FbjeO5
 eUarVhhohH70UU7diQwOFFYMIeA5/gR1dSt44r9qCLnRDrRptvYAbIq68rdrEHq6ZJCz
 08KntDq4mZx29T8X28ig7STd0ujw5aarQiTC7xKLzuwLqLn+0sWTMSwhqrE4Zl28PkA7
 COUw==
X-Gm-Message-State: AOJu0Yz5fOkBosdQvyU3EET08IoWaNXPJOtZUCL/VqkFTWgAB9dZTb0p
 6VIvygXPBtvajEWkTflV5qUndftglDqOc+l0lIFyI7LOInTjpx8e1RFTX5Myb9LMzU71aXgGEV2
 ImLM=
X-Google-Smtp-Source: AGHT+IEBcoZG+T7ZClnIEYdCFNtuiMsUmsnINtVdrs+YiNagjvhnMfgRrJyX+/6KRMh48cCHW2uWLQ==
X-Received: by 2002:a05:6000:150:b0:34a:a754:eb48 with SMTP id
 ffacd0b85a97d-3504a969261mr10962225f8f.48.1715766071268; 
 Wed, 15 May 2024 02:41:11 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 37/43] target/hppa: Implement PSW_B
Date: Wed, 15 May 2024 11:40:37 +0200
Message-Id: <20240515094043.82850-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

PSW_B causes B,GATE to trap as an illegal instruction, removing our
previous sequential execution test that was merely an approximation.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f7d54f4009..f40ac92e98 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2062,11 +2062,8 @@ static void do_page_zero(DisasContext *ctx)
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
 
@@ -3965,23 +3962,13 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
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


