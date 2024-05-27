Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B5CC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVeN-0003ul-Cc; Mon, 27 May 2024 04:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVdG-0001LL-0d; Mon, 27 May 2024 04:23:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVdE-0000sV-9N; Mon, 27 May 2024 04:23:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C64476A56F;
 Mon, 27 May 2024 11:22:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F170CD850C;
 Mon, 27 May 2024 11:21:39 +0300 (MSK)
Received: (nullmailer pid 66406 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ruihan Li <lrh2000@pku.edu.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 18/44] target/i386: Give IRQs a chance when resetting
 HF_INHIBIT_IRQ_MASK
Date: Mon, 27 May 2024 11:21:09 +0300
Message-Id: <20240527082138.66217-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ruihan Li <lrh2000@pku.edu.cn>

When emulated with QEMU, interrupts will never come in the following
loop. However, if the NOP instruction is uncommented, interrupts will
fire as normal.

	loop:
		cli
    		call do_sti
		jmp loop

	do_sti:
		sti
		# nop
		ret

This behavior is different from that of a real processor. For example,
if KVM is enabled, interrupts will always fire regardless of whether the
NOP instruction is commented or not. Also, the Intel Software Developer
Manual states that after the STI instruction is executed, the interrupt
inhibit should end as soon as the next instruction (e.g., the RET
instruction if the NOP instruction is commented) is executed.

This problem is caused because the previous code may choose not to end
the TB even if the HF_INHIBIT_IRQ_MASK has just been reset (e.g., in the
case where the STI instruction is immediately followed by the RET
instruction), so that IRQs may not have a change to trigger. This commit
fixes the problem by always terminating the current TB to give IRQs a
chance to trigger when HF_INHIBIT_IRQ_MASK is reset.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Message-ID: <20240415064518.4951-4-lrh2000@pku.edu.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 6a5a63f74ba5c5355b7a8468d3d814bfffe928fb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 76a42c679c..c84196c00b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2798,13 +2798,17 @@ static void gen_bnd_jmp(DisasContext *s)
 static void
 do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
 {
+    bool inhibit_reset;
+
     gen_update_cc_op(s);
 
     /* If several instructions disable interrupts, only the first does it.  */
-    if (inhibit && !(s->flags & HF_INHIBIT_IRQ_MASK)) {
-        gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
-    } else {
+    inhibit_reset = false;
+    if (s->flags & HF_INHIBIT_IRQ_MASK) {
         gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
+        inhibit_reset = true;
+    } else if (inhibit) {
+        gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
     }
 
     if (s->base.tb->flags & HF_RF_MASK) {
@@ -2815,7 +2819,9 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
         tcg_gen_exit_tb(NULL, 0);
     } else if (s->flags & HF_TF_MASK) {
         gen_helper_single_step(tcg_env);
-    } else if (jr) {
+    } else if (jr &&
+               /* give irqs a chance to happen */
+               !inhibit_reset) {
         tcg_gen_lookup_and_goto_ptr();
     } else {
         tcg_gen_exit_tb(NULL, 0);
-- 
2.39.2


