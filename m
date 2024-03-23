Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D05C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 21:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro8iN-0006sc-0K; Sat, 23 Mar 2024 17:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1ro8iL-0006sM-Jm
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 17:15:41 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1ro8iJ-0006k9-6x
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 17:15:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 54FF0CE000E;
 Sat, 23 Mar 2024 21:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71101C433F1;
 Sat, 23 Mar 2024 21:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711228524;
 bh=4LtswzyTGJgbT0Yx5dz7Zyeh3dJL9PInNwccyHY2vgE=;
 h=Date:From:To:Subject:From;
 b=fgg6YFGJ0i2MMxpq8nV9dlZLBP2cTKleE5UkXzAq3XNGrHRKgTelyzckxGL5Kh/00
 hfnbL7SGc9FiAu2eATbMgA3VsNyjcEk8EblscaZQkoBLMCyMlDA8YO6IJ+w002YM3Y
 w1jX6VDzK00MOhqvzxaK/xhNitJJZcMe9nA0bPbBZBGSEdtuRxEJL2WhoN1a+7CZT5
 o1cEyL8Iq/iEGsM4p0XNJ7EdaelHUxHVmmlJIYzTKw+YITp+7GIEk8HFOyWbFLRpaZ
 ZtDV9WuqmBECpX6/80iXO80ip6iGd2WWdcLhzGDXM0CvUsX+Ts/KpYbRQq4LkkIp3C
 CsR/iY4QB2oGQ==
Date: Sat, 23 Mar 2024 22:15:20 +0100
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, svens@stackframe.org,
 qemu-devel@nongnu.org
Subject: [PATCH][RFC] target/hppa: Avoid nullification for uaddcmt instruction
Message-ID: <Zf9GaFSsAJ5AAzKk@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The uaddcmt (UNIT ADD COMPLEMENT AND TRAP ON CONDITION) instruction
triggers a trap if the condition is true, and stores the result of the
addition in the target register otherwise.
It does not use the condition to nullify the following instruction, so
drop the calculated condition and do not install it as null_cond.

This patch is not tested and as such sent as RFC.
I just stumbled over the apparently wrong behaviour while debugging the
uaddcm instruction.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 46b2d6508d..6088e9bbf3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1363,7 +1363,11 @@ static void do_unit(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
         save_gpr(ctx, rt, dest);
 
         cond_free(&ctx->null_cond);
-        ctx->null_cond = cond;
+        if (is_tc) {
+            cond_free(&cond);
+        } else {
+            ctx->null_cond = cond;
+        }
     }
 }
 

