Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04A3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we9yO-0002sD-Ug; Mon, 29 Jun 2026 07:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>)
 id 1we9yN-0002rz-9K; Mon, 29 Jun 2026 07:16:19 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>)
 id 1we9yJ-0008Hl-Hr; Mon, 29 Jun 2026 07:16:18 -0400
X-UUID: eb9d403873ab11f1aa26b74ffac11d73-20260629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f9197264-437b-4870-a93c-1a4239483f18, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:5a80457207a80c2ddef7fffd9592b4ca,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
 DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
 :0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: eb9d403873ab11f1aa26b74ffac11d73-20260629
X-User: yujun@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yujun@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1822416471; Mon, 29 Jun 2026 19:16:05 +0800
From: yujun <yujun@kylinos.cn>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] tcg/aarch64: Use TBNZ for 16-byte alignment check on i128
 ld/st
Date: Mon, 29 Jun 2026 19:16:02 +0800
Message-Id: <20260629111602.282742-1-yujun@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=yujun@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Without FEAT_LSE2, 128-bit guest loads and stores that require full
atomicity but only guarantee 8-byte alignment must choose between an
LDXP+STXP loop and a pair of 8-byte accesses at runtime.  When the
required alignment is MO_64, prepare_host_addr() has already verified
8-byte alignment, so only bit 3 needs testing.

Use TBNZ on bit 3 instead of ANDSI #15 plus B.cond, saving one
instruction on the common path.  Keep the wider test for lesser
alignments.

Fixes: 929124ec0b ("tcg/aarch64: Support 128-bit load/store")
Signed-off-by: yujun <yujun@kylinos.cn>
---
 tcg/aarch64/tcg-target.c.inc | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index cc9c2a5158..36b129363f 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1898,14 +1898,18 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
          * may be handled with two 8-byte loads.
          */
         if (h.aa.align < MO_128) {
-            /*
-             * TODO: align should be MO_64, so we only need test bit 3,
-             * which means we could use TBNZ instead of ANDS+B_C.
-             */
-            tcg_out_logicali(s, Ilogic_imm_ANDSI, 0, TCG_REG_XZR, addr_reg,
-                             15);
             branch = s->code_ptr;
-            tcg_out_insn(s, bcond_imm, B_C, TCG_COND_NE, 0);
+            if (h.aa.align == MO_64) {
+                /*
+                 * 8-byte alignment is already verified; test bit 3 to
+                 * distinguish 8- from 16-byte alignment.
+                 */
+                tcg_out_insn(s, tbz, TBNZ, addr_reg, 3, 0);
+            } else {
+                tcg_out_logicali(s, Ilogic_imm_ANDSI, 0, TCG_REG_XZR, addr_reg,
+                                 15);
+                tcg_out_insn(s, bcond_imm, B_C, TCG_COND_NE, 0);
+            }
             use_pair = true;
         }
 
@@ -1944,7 +1948,11 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
         if (use_pair) {
             /* "b .+8", branching across the one insn of use_pair. */
             tcg_out_insn(s, branch, B, 2);
-            reloc_pc19(branch, tcg_splitwx_to_rx(s->code_ptr));
+            if (h.aa.align == MO_64) {
+                reloc_pc14(branch, tcg_splitwx_to_rx(s->code_ptr));
+            } else {
+                reloc_pc19(branch, tcg_splitwx_to_rx(s->code_ptr));
+            }
         }
     }
 
-- 
2.25.1


