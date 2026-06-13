Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB13CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV9E-0000Sg-Ur; Sat, 13 Jun 2026 16:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV8q-0008Vf-72; Sat, 13 Jun 2026 16:39:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV8o-0004EI-JJ; Sat, 13 Jun 2026 16:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382964; bh=LlFJ5MNrrFqn2jreYasQuWyv+SrH/nQ9Zgl3Dd/fIBM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oiulHuJG+q+stsRi/jEB/lrVygzkZImVou2lRENMWGwU0pghw2Klf7KTANMFaMwTp
 D/kYMUW8kcmoNHZLBPik05BGntBeCKSaq2DhSzMOTKyBgH6NX36cRszRkqVQrtRrXw
 T23hkfeVfgB5pv0QmbZfJm2GnfORmeGVZREl/W8998wyT6I7siXMT+3kWKmkGIk5Qv
 Rucgg4wY/2l1ZWwddwbKvU18J0lauy3/jR841hSFVJDQ6nMnFvaw7Y+29oFB+6IUMv
 9KbkRjavlxGjMVEB/nJedLzuDfjFW6jj9xNRbggPJf8GhAwl2tuFIWXaQHJBCiYI0N
 QrqQkeljtwq7A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BAE6C1B6F01;
 Sat, 13 Jun 2026 23:36:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2F0523CE952;
 Sat, 13 Jun 2026 23:36:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 38/72] linux-user/ppc: restore fp_status from FPSCR on
 sigreturn
Date: Sat, 13 Jun 2026 23:35:04 +0300
Message-ID: <20260613203542.1809153-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Matt Turner <mattst88@gmail.com>

restore_user_regs() restores the PPC FPSCR with a direct assignment:

    env->fpscr = (uint32_t) fpscr;

ppc_store_fpscr() exists precisely to write FPSCR and keep the derived
env->fp_status in sync: it calls fpscr_set_rounding_mode() to update
the softfloat rounding mode, and set_float_rebias_overflow/underflow()
to reflect the FP_OE/FP_UE enable bits.  The direct assignment bypasses
all of this.

On sigreturn, interrupted code resumes with whatever rounding mode and
overflow/underflow-rebias state the signal handler last installed in
fp_status, rather than the state that was saved at signal delivery.

Replace the direct assign with ppc_store_fpscr().  The FPSCR_MTFS_MASK
applied inside ppc_store_fpscr() only excludes the computed FP_FEX and
FP_VX bits, which it re-derives correctly from the exception and enable
bits in the restored value.

Fixes: bcd4933a23 ("linux-user: ppc signal handling")
Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 3f50dd46664bdf94f10aca8b76dc4dcb9182a5ae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index a9c10e0987..ab1afea30a 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -420,7 +420,7 @@ static void restore_user_regs(CPUPPCState *env,
             __get_user(*fpr, &frame->mc_fregs[i]);
         }
         __get_user(fpscr, &frame->mc_fregs[32]);
-        env->fpscr = (uint32_t) fpscr;
+        ppc_store_fpscr(env, (uint32_t) fpscr);
     }
 
 #if !defined(TARGET_PPC64)
-- 
2.47.3


