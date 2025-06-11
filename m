Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251E6C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL7z-00086t-IC; Wed, 11 Jun 2025 09:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uPL7N-00073w-PM; Wed, 11 Jun 2025 09:04:01 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uPL7C-0004zy-Lr; Wed, 11 Jun 2025 09:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=gSeAlrhldGJ6CDc/fuawdB7PxaXoK/BgnXGltMyWnxM=; b=M7vhMSJ+cxLKEVYQ+11kZy5a8r
 sXGAtThm1Uf3rfhCo3FMiLofPnE4K+D9N+5hmvxumGvrc7XFAXNmAUcxU+MDVkOWt+xDzyNngQ2t5
 wzqKzT901SnEwj/PpyZ+lHIrHx24T+9PnvhdnzgNbhm/xuWRumQxSQaDzEBVe7PHGmKBvnZTjlSlU
 jOzInN5ZabTuiOTq617Imhd7meq5hxL4RuoiY6BBhUWDoksHDpnHZFINE69tUv8z+IXGpJJtNNtrs
 uizRnivhuNUIdf7Bmc617dwbf0sakMPdSrnsOjKDEvxmtHqd0Pkbo2ADpgn+JVYVWccAry2OSBaoA
 iI7QrK2k/XvEm49ITkEIrW8t7hSteq06j0cfoxSc0KwurJEZWiEiaJEOK9WpBlNvRR4XnULWO4Fxj
 TOR+H4uCc6RIrJXaQpggEeb899pSUAOp/OGkgfwmJbY7ElJBYygDEaUY2lU8jvlMoU7EIWUUNA6AW
 1sk4z0eHZn8+O2+nDNUtBc/dFZRVFU/8SovdbxbiGQdKCX+vTmleEhbu6h3vcHWfr1zlYeHcKgbrU
 JWg3xE/U+aWdIQSvxLKp7xO2GlCWznxCSQsfaNFufGQVFhGHUf1vDAq9YIUd744oCShSoIkXrG8jK
 ZTZFNDjn40m2f2SWhPlb68W8qonnt0R6JW+fIiLEs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uPL5c-0002P7-G4; Wed, 11 Jun 2025 14:02:01 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-stable@nongnu.org
Date: Wed, 11 Jun 2025 14:03:15 +0100
Message-Id: <20250611130315.383151-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] target/i386: fix TB exit logic in gen_movl_seg() when writing
 to SS
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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
Cc: qemu-stable@nongnu.org
Fixes: e54ef98c8a ("target/i386: do not trigger IRQ shadow for LSS")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2987
---
 target/i386/tcg/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

(Many thanks to Peter Maydell for help with the hflags analysis and for suggesting
 the improved comment wording.)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0fcddc2ec0..0cb87d0201 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2033,8 +2033,11 @@ static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src, bool inhibit
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
2.39.5


