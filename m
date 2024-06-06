Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFD9C27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9oX-0000Cc-GG; Thu, 06 Jun 2024 05:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9oW-0000CM-CW
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:53:44 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9oU-0002HY-Lp
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=0fw8uNour2vCQNrEWKbV/I2YIRMH10+1YFPBwmXuJ3w=; b=DI4f0lIRdxeMGsRtG5iXw18rh5
 bpWSCRtPQXq70NUEyPawJHrr4xBf5j5k/N8ilRfASkuyUSK/foVJb5isbt52O3sdlInkvZXSNmvYx
 XUTN4yYCikHECjVSOO4Z0dbJIcnJziWgU327G5XbRZU9YIlB9o/sTbZF+AjQ8FYYoTTL0DcQvTf4x
 2DTfbq75TnxyBILipZYiJFIIlH/xZQE7TqDF/s7M/Ygq78FNl/Z4ok1Z6CPi6EoMj5RaWRE2tZDkS
 t1kXu2Qn9l/p/BVnLv8VfdSRPjyOgIgb/rOvoZtx/wIG/hh/H9x3rbQ3i1gPo3PBvRfoMBGU8rsP6
 Uc6Y3YK45m8AmPK4d9TL6z0pdA2gtO22JrGM2PT8OKZgty+PUyrI3X90EYaE09XlIjGjUtJb1ZHVR
 KqW/tmm0xrSjWJP+Qp8A39bl8mO+XQCe6zdt3qo0nlH8ypXtUi+NDsO5Ya3JSqveoASz4yke+C0QY
 1Hu8zuQFsJ0+wnlBmW23hREhINeGuGQ3S7O7gux0mnFYCjoWdWh001Ahiq+Oug9T1BBgblMgVbGLX
 GY5OCnjNDCTSjYvojt6DXtNVM0HZvZoTARkTZTP2Iz1ycaHDYdj2/XNIbNTWZuGkkAx75qDzn6Fud
 784bw/eL00GVts/DUDS/IlYJr/0eAT6rebT+/6rgI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9nC-0004cT-03; Thu, 06 Jun 2024 10:52:25 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2024 10:53:18 +0100
Message-Id: <20240606095319.229650-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606095319.229650-1-mark.cave-ayland@ilande.co.uk>
References: <20240606095319.229650-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 3/4] target/i386: fix SP when taking a memory fault during POP
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When OS/2 Warp configures its segment descriptors, many of them are configured with
the P flag clear to allow for a fault-on-demand implementation. In the case where
the stack value is POPped into the segment registers, the SP is incremented before
calling gen_helper_load_seg() to validate the segment descriptor:

IN:
0xffef2c0c:  66 07                    popl     %es

OP:
 ld_i32 loc9,env,$0xfffffffffffffff8
 sub_i32 loc9,loc9,$0x1
 brcond_i32 loc9,$0x0,lt,$L0
 st16_i32 loc9,env,$0xfffffffffffffff8
 st8_i32 $0x1,env,$0xfffffffffffffffc

 ---- 0000000000000c0c 0000000000000000
 ext16u_i64 loc0,rsp
 add_i64 loc0,loc0,ss_base
 ext32u_i64 loc0,loc0
 qemu_ld_a64_i64 loc0,loc0,noat+un+leul,5
 add_i64 loc3,rsp,$0x4
 deposit_i64 rsp,rsp,loc3,$0x0,$0x10
 extrl_i64_i32 loc5,loc0
 call load_seg,$0x0,$0,env,$0x0,loc5
 add_i64 rip,rip,$0x2
 ext16u_i64 rip,rip
 exit_tb $0x0
 set_label $L0
 exit_tb $0x7fff58000043

If helper_load_seg() generates a fault when validating the segment descriptor then as
the SP has already been incremented, the topmost word of the stack is overwritten by
the arguments pushed onto the stack by the CPU before taking the fault handler. As a
consequence things rapidly go wrong upon return from the fault handler due to the
corrupted stack.

Update the logic for the existing writeback condition so that a POP into the segment
registers also calls helper_load_seg() first before incrementing the SP, so that if a
fault occurs the SP remains unaltered.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198
---
 target/i386/tcg/emit.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 2d5dc11548..f905a67380 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2567,7 +2567,7 @@ static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     X86DecodedOp *op = &decode->op[0];
     MemOp ot = gen_pop_T0(s);
 
-    if (op->has_ea) {
+    if (op->has_ea || op->unit == X86_OP_SEG) {
         /* NOTE: order is important for MMU exceptions */
         gen_writeback(s, decode, 0, s->T0);
         op->unit = X86_OP_SKIP;
-- 
2.39.2


