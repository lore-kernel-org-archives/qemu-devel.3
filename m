Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2CCCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB2n-0001cI-Gj; Sat, 17 Oct 2026 16:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2F-00087U-G6; Sat, 17 Oct 2026 16:29:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2D-00045J-Q5; Sat, 17 Oct 2026 16:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268856; bh=KrG1b4APP6QPHE6ELPpAwTWi5YrV4AhaQMaoKa0pOUY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZKXWRQNw45WAFL/3Tti0ra0zOMYbZjsYn1I8qhIpkMLyqBscnAjTjBENamF+GiZdt
 TxGY5/Mlbf8rRb88qIhHyMNEWHQ5kTHprdI6Q4beR5G6rORCMpljIHvTgyp+Gk5TxF
 5TziG2Lb61nJSVlJMJWr13edOV9y+41Ei3GFWjuRwrzOewyC65HG4wSX8Ym9JnEwnJ
 nQAuM7laIGz+h+var5TjDVa7OGm507hPuJW/kbBMfxilPerruTceekyFWkFwyvolSs
 K3UOm8MiFX+LFuueH0sbqFYfCcjhxkD9EvQLjbw8EYddOZsP/Q4exsbnxUTkQB92mn
 SfIs/6LBxTJOw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9B4AB1DE75B;
 Sat, 17 Oct 2026 23:27:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AD47D443431;
 Sat, 17 Oct 2026 23:27:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Jakub=20Lipov=C3=BD?= <lipovyjakub@tillia.cz>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 31/73] target/i386/tcg: raise #GP(0) on null SS load
 with RPL != CPL
Date: Sat, 17 Oct 2026 23:25:49 +0300
Message-ID: <20261017202638.728621-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jakub Lipový <lipovyjakub@tillia.cz>

In 64-bit mode, loading a null selector into SS raises #GP(0) if CPL = 3,
or if CPL < 3 and CPL != RPL.  helper_load_seg() only implemented the
first case: the null-selector path never examined the selector's RPL, so
a null selector with non-zero RPL (such as 0x0003) loaded successfully at
CPL < 3.

This was caught by test_sreg() in kvm-unit-tests x86/emulator64.c, which
additionally fails its subsequent non-null check because the wrongly
succeeded load leaves 3 in SS.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4204
Cc: qemu-stable@nongnu.org
Signed-off-by: Jakub Lipový <lipovyjakub@tillia.cz>
Link: https://lore.kernel.org/r/20260818164414.245189-1-lipovyjakub@tillia.cz
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 8d496d8f9fcea2199f6dc32f700d13b1d9ed3358)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 6d424349a5..cad19f9ca6 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1411,11 +1411,12 @@ void helper_load_seg(CPUX86State *env, int seg_reg, int selector)
 
     selector &= 0xffff;
     cpl = env->hflags & HF_CPL_MASK;
+    rpl = selector & 3;
     if ((selector & 0xfffc) == 0) {
         /* null selector case */
         if (seg_reg == R_SS
 #ifdef TARGET_X86_64
-            && (!(env->hflags & HF_CS64_MASK) || cpl == 3)
+            && (!(env->hflags & HF_CS64_MASK) || cpl == 3 || cpl != rpl)
 #endif
             ) {
             raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
@@ -1439,7 +1440,6 @@ void helper_load_seg(CPUX86State *env, int seg_reg, int selector)
         if (!(e2 & DESC_S_MASK)) {
             raise_exception_err_ra(env, EXCP0D_GPF, selector & 0xfffc, GETPC());
         }
-        rpl = selector & 3;
         dpl = (e2 >> DESC_DPL_SHIFT) & 3;
         if (seg_reg == R_SS) {
             /* must be writable segment */
-- 
2.47.3


