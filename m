Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCE6C04FF9
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 06:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwGAk-0001cY-CS; Mon, 15 Apr 2024 02:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lrh2000@pku.edu.cn>)
 id 1rwGAh-0001c1-Qe
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 02:50:31 -0400
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net ([159.65.134.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lrh2000@pku.edu.cn>) id 1rwGAd-0004JL-4G
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 02:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=J7nmHWbIgf
 Oam3kaQDyRbozkPA763qUZT/BorRoWyHY=; b=eC6r9kvD09qzANDGF9BPS0UjIg
 09NmWw+bv7XOAgPOI6lJvxu+vm7DhcwZJUBBCVubSpret/Nh+NxpzT8gpBH0UzXd
 /p8fS50SK4H/YvQVRxYTVQRVsCtKAXfSOErjzTx1NWCo1+MrsRKuMgz2xkN84Uqv
 69lpN9ph40KSuBA8I=
Received: from localhost.localdomain (unknown [36.112.204.196])
 by front01 (Coremail) with SMTP id 5oFpogCHK+EfzhxmpwhiAw--.11576S2;
 Mon, 15 Apr 2024 14:50:11 +0800 (CST)
From: Ruihan Li <lrh2000@pku.edu.cn>
To: qemu-devel@nongnu.org
Cc: Ruihan Li <lrh2000@pku.edu.cn>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] target/i386: Give IRQs a chance when resetting
 HF_INHIBIT_IRQ_MASK
Date: Mon, 15 Apr 2024 14:45:21 +0800
Message-ID: <20240415064518.4951-4-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogCHK+EfzhxmpwhiAw--.11576S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1UAr1kurWrZFy7CrWxJFb_yoW5WF1xpa
 1xCwnFyr4kXF4UGa1xJa1DWFyYyF4rtr1j9Fn7tw4rK3yrKr9YqFn3KFW5KFW5WF4xuFyY
 vr10yFyj9F98XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUB21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
 w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
 IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
 87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
 xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
 wI0_JF0_Jw1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
 0_Kw1UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
 xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
 IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
 6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
 CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU8KZXUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEHBWYavlcgnwADso
Received-SPF: pass client-ip=159.65.134.6; envelope-from=lrh2000@pku.edu.cn;
 helo=zg8tmtu5ljy1ljeznc42.icoremail.net
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_BL=0.01,
 RCVD_IN_MSPIKE_L5=2.5, RCVD_IN_VALIDITY_RPBL=1.31, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
The same problem was discovered two years ago, see [StackOverflow][so].

 [so]: https://stackoverflow.com/questions/68135305/executing-ret-after-sti-doesnt-start-interrupts

Changes since v1:
 - Fix a typo: "RET is followed by STI" -> "STI is followed by RET"
Link to v1:
 - https://lore.kernel.org/qemu-devel/20231210190147.129734-2-lrh2000@pku.edu.cn/

 target/i386/tcg/translate.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 76a42c6..3f0fbdf 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2798,13 +2798,19 @@ static void gen_bnd_jmp(DisasContext *s)
 static void
 do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
 {
+    bool inhibit_reset;
+
     gen_update_cc_op(s);
 
     /* If several instructions disable interrupts, only the first does it.  */
     if (inhibit && !(s->flags & HF_INHIBIT_IRQ_MASK)) {
         gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
-    } else {
+        inhibit_reset = false;
+    } else if (!inhibit && (s->flags & HF_INHIBIT_IRQ_MASK)) {
         gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
+        inhibit_reset = true;
+    } else {
+        inhibit_reset = false;
     }
 
     if (s->base.tb->flags & HF_RF_MASK) {
@@ -2815,7 +2821,9 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
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
2.44.0


