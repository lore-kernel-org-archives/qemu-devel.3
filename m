Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF27C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLGp-0006hQ-HF; Thu, 17 Jul 2025 05:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL0O-0001n6-FX; Thu, 17 Jul 2025 05:34:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL0L-0001md-Ss; Thu, 17 Jul 2025 05:34:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 39714137CE8;
 Thu, 17 Jul 2025 12:34:04 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1CA0D2491E2;
 Thu, 17 Jul 2025 12:34:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 40/65] target/i386: fix TB exit logic in
 gen_movl_seg() when writing to SS
Date: Thu, 17 Jul 2025 12:33:36 +0300
Message-ID: <20250717093412.728292-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Before commit e54ef98c8a ("target/i386: do not trigger IRQ shadow for LSS"), any
write to SS in gen_movl_seg() would cause a TB exit. The changes introduced by
this commit were intended to restrict the DISAS_EOB_INHIBIT_IRQ exit to the case
where inhibit_irq is true, but missed that a DISAS_EOB_NEXT exit can still be
required when writing to SS and inhibit_irq is false.

Comparing the PE(s) && !VM86(s) section with the logic in x86_update_hflags(), we
can see that the DISAS_EOB_NEXT exit is still required for the !CODE32 case when
writing to SS in gen_movl_seg() because any change to the SS flags can affect
hflags. Similarly we can see that the existing CODE32 case is still correct since
a change to any of DS, ES and SS can affect hflags. Finally for the
gen_op_movl_seg_real() case an explicit TB exit is not needed because the segment
register selector does not affect hflags.

Update the logic in gen_movl_seg() so that a write to SS with inhibit_irq set to
false where PE(s) && !VM86(s) will generate a DISAS_EOB_NEXT exit along with the
inline comment. This has the effect of allowing Win98SE to boot in QEMU once
again.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: e54ef98c8a ("target/i386: do not trigger IRQ shadow for LSS")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2987
Link: https://lore.kernel.org/r/20250611130315.383151-1-mark.cave-ayland@ilande.co.uk
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 0f1d6606c28d0ae81a1b311972c5c54e5e867bf0)
Fixes: 0f1d6606c2 ("target/i386: do not trigger IRQ shadow for LSS" in 10.0.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 50cf56175f..7e590ef79c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2000,8 +2000,11 @@ static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src, bool inhibit
         tcg_gen_trunc_tl_i32(sel, src);
         gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), sel);
 
-        /* For move to DS/ES/SS, the addseg or ss32 flags may change.  */
-        if (CODE32(s) && seg_reg < R_FS) {
+        /*
+         * For moves to SS, the SS32 flag may change. For CODE32 only, changes
+         * to SS, DS and ES may change the ADDSEG flags.
+         */
+        if (seg_reg == R_SS || (CODE32(s) && seg_reg < R_FS)) {
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
     } else {
-- 
2.47.2


