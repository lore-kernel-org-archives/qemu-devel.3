Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D5ECCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9bw-0002xx-RT; Sat, 17 Oct 2026 14:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9bg-0002Wg-A8; Sat, 17 Oct 2026 14:58:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9be-0003pb-8t; Sat, 17 Oct 2026 14:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263392; bh=gAUs2yr/5f4nsR0oLds1KQvQ2Mm0MC9rJNKjOG9/Pr0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OvHf6+msp4dKwmTbMYs+1/XHgnmFPcSFl8/o03azq0segMBJlcwPlyjk4le2rUPeX
 8kJPVXazLPLUMjqq9ekQIVd5OkUGSS09wp4TJv7cr6sML5yZcv/B4Z1hBNX7WcVRPi
 rEtOB20FHXRXWZvfPltkD5wIt6sErpagy/9vAVMdEiLJauNsQDLz/CbwInONkXPtOd
 mr53sNfXPcZyvtNPR+Q5UuJD4GoGmBrXWynDR+ZbbwqyS48UF6Jd1aUOKAeORSiqjL
 YUaTS1hLS35dqxKprJ+gwkQbzK/3fv5vySueNpbAdJr6l4E7lGTueVL3SzFzVdQKnU
 Mff+coKex66GQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B7001DE6BD;
 Sat, 17 Oct 2026 21:56:32 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E9161443388;
 Sat, 17 Oct 2026 21:56:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Simon Scherer <scherer.simon89@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 29/63] target/i386: clear C1 for all x87 compare
 instructions
Date: Sat, 17 Oct 2026 21:54:45 +0300
Message-ID: <20261017185528.722197-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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

From: Simon Scherer <scherer.simon89@gmail.com>

The SDM specifies that FCOM/FCOMP/FCOMPP/FUCOM/FUCOMP/FUCOMPP/FICOM/FICOMP/
FCOMI/FCOMIP/FUCOMI/FUCOMIP unconditionally clear C1 in the FPU status word,
regardless of the comparison result.

helper_fcom_ST0_FT0/helper_fucom_ST0_FT0 only cleared C3, C2, C0 (mask
0x4500) before OR-ing in the comparison result, leaving C1 (bit 9) at
whatever value it already had. FICOM/FICOMP dispatch through the same
helpers after converting their integer operand, so they inherited the
same bug.

helper_fcomi_ST0_FT0/helper_fucomi_ST0_FT0 never touched the FPU status
word at all, so C1 was left untouched by those too.

This patch clears C1 explicitly in all four helpers, adding the clear
into the existing fpus mask for fcom/fucom since fcom_ccval never sets
bit 9. For fcomi/fucomi add a new separate clear.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4378
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260828082235.128360-1-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 6802a4b2391936ccb2ea0f76851bd1a43413b0b5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 3e312c7a8b..184cf8b4e8 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -538,7 +538,8 @@ void helper_fcom_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
-    env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus = (env->fpus & ~0x4700) | fcom_ccval[ret + 1];
     merge_exception_flags(env, old_flags);
 }
 
@@ -548,7 +549,8 @@ void helper_fucom_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
-    env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus = (env->fpus & ~0x4700) | fcom_ccval[ret + 1];
     merge_exception_flags(env, old_flags);
 }
 
@@ -563,6 +565,8 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
@@ -575,6 +579,8 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
-- 
2.47.3


