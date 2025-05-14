Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD74C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHRv-0007YX-1C; Wed, 14 May 2025 15:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHMw-0005Ve-TC; Wed, 14 May 2025 15:02:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHMk-0007bg-RH; Wed, 14 May 2025 15:02:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D8C79121D9B;
 Wed, 14 May 2025 22:00:32 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DFDF520BA8D;
 Wed, 14 May 2025 22:00:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 17/23] target/i386: do not trigger IRQ shadow for LSS
Date: Wed, 14 May 2025 22:00:29 +0300
Message-Id: <20250514190041.104759-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Because LSS need not trigger an IRQ shadow, gen_movl_seg can't just use
the destination register to decide whether to inhibit IRQs.  Add an
argument.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit e54ef98c8a80d16158bab4341d9a898701270528)
(back-ported to 10.0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0fa1664a24..b4dcb46e81 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -352,7 +352,7 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
         break;
     case X86_OP_SEG:
         /* Note that gen_movl_seg takes care of interrupt shadow and TF.  */
-        gen_movl_seg(s, op->n, s->T0);
+        gen_movl_seg(s, op->n, v, op->n == R_SS);
         break;
     case X86_OP_INT:
         if (op->has_ea) {
@@ -2372,7 +2372,7 @@ static void gen_lxx_seg(DisasContext *s, X86DecodedInsn *decode, int seg)
     gen_op_ld_v(s, MO_16, s->T1, s->A0);
 
     /* load the segment here to handle exceptions properly */
-    gen_movl_seg(s, seg, s->T1);
+    gen_movl_seg(s, seg, s->T1, false);
 }
 
 static void gen_LDS(DisasContext *s, X86DecodedInsn *decode)
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a8935f487a..390018fdec 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1992,25 +1992,32 @@ static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
 
 /* move SRC to seg_reg and compute if the CPU state may change. Never
    call this function with seg_reg == R_CS */
-static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src)
+static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src, bool inhibit_irq)
 {
     if (PE(s) && !VM86(s)) {
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, src);
-        gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), s->tmp2_i32);
-        /* abort translation because the addseg value may change or
-           because ss32 may change. For R_SS, translation must always
-           stop as a special handling must be done to disable hardware
-           interrupts for the next instruction */
-        if (seg_reg == R_SS) {
-            s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
-        } else if (CODE32(s) && seg_reg < R_FS) {
+        TCGv_i32 sel = tcg_temp_new_i32();
+
+        tcg_gen_trunc_tl_i32(sel, src);
+        gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), sel);
+
+        /* For move to DS/ES/SS, the addseg or ss32 flags may change.  */
+        if (CODE32(s) && seg_reg < R_FS) {
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
     } else {
         gen_op_movl_seg_real(s, seg_reg, src);
-        if (seg_reg == R_SS) {
-            s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
-        }
+    }
+
+    /*
+     * For MOV or POP to SS (but not LSS) translation must always
+     * stop as a special handling must be done to disable hardware
+     * interrupts for the next instruction.
+     *
+     * DISAS_EOB_INHIBIT_IRQ is a superset of DISAS_EOB_NEXT which
+     * might have been set above.
+     */
+    if (inhibit_irq) {
+        s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
     }
 }
 
-- 
2.39.5


