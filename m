Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078AAC41513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTZz-0007EI-Ch; Thu, 04 Jul 2024 17:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZv-000728-Ht; Thu, 04 Jul 2024 17:01:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZt-0004Ll-S5; Thu, 04 Jul 2024 17:01:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EE12377567;
 Fri,  5 Jul 2024 00:00:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 10AAFFECA1;
 Fri,  5 Jul 2024 00:00:56 +0300 (MSK)
Received: (nullmailer pid 1507743 invoked by uid 1000);
 Thu, 04 Jul 2024 21:00:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.2 10/22] tcg/loongarch64: Fix tcg_out_movi vs some pcrel
 pointers
Date: Fri,  5 Jul 2024 00:00:40 +0300
Message-Id: <20240704210055.1507652-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
References: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

Simplify the logic for two-part, 32-bit pc-relative addresses.
Rather than assume all such fit in int32_t, do some arithmetic
and assert a result, do some arithmetic first and then check
to see if the pieces are in range.

Cc: qemu-stable@nongnu.org
Fixes: dacc51720db ("tcg/loongarch64: Implement tcg_out_mov and tcg_out_movi")
Reviewed-by: Song Gao <gaosong@loongson.cn>
Reported-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 521d7fb3ebdf88112ed13556a93e3037742b9eb8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 06ca1ab11c..8f68bd3e51 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -366,8 +366,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
      * back to the slow path.
      */
 
-    intptr_t pc_offset;
-    tcg_target_long val_lo, val_hi, pc_hi, offset_hi;
+    intptr_t src_rx, pc_offset;
     tcg_target_long hi12, hi32, hi52;
 
     /* Value fits in signed i32.  */
@@ -377,24 +376,23 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     }
 
     /* PC-relative cases.  */
-    pc_offset = tcg_pcrel_diff(s, (void *)val);
-    if (pc_offset == sextreg(pc_offset, 0, 22) && (pc_offset & 3) == 0) {
-        /* Single pcaddu2i.  */
-        tcg_out_opc_pcaddu2i(s, rd, pc_offset >> 2);
-        return;
+    src_rx = (intptr_t)tcg_splitwx_to_rx(s->code_ptr);
+    if ((val & 3) == 0) {
+        pc_offset = val - src_rx;
+        if (pc_offset == sextreg(pc_offset, 0, 22)) {
+            /* Single pcaddu2i.  */
+            tcg_out_opc_pcaddu2i(s, rd, pc_offset >> 2);
+            return;
+        }
     }
 
-    if (pc_offset == (int32_t)pc_offset) {
-        /* Offset within 32 bits; load with pcalau12i + ori.  */
-        val_lo = sextreg(val, 0, 12);
-        val_hi = val >> 12;
-        pc_hi = (val - pc_offset) >> 12;
-        offset_hi = val_hi - pc_hi;
-
-        tcg_debug_assert(offset_hi == sextreg(offset_hi, 0, 20));
-        tcg_out_opc_pcalau12i(s, rd, offset_hi);
+    pc_offset = (val >> 12) - (src_rx >> 12);
+    if (pc_offset == sextreg(pc_offset, 0, 20)) {
+        /* Load with pcalau12i + ori.  */
+        tcg_target_long val_lo = val & 0xfff;
+        tcg_out_opc_pcalau12i(s, rd, pc_offset);
         if (val_lo != 0) {
-            tcg_out_opc_ori(s, rd, rd, val_lo & 0xfff);
+            tcg_out_opc_ori(s, rd, rd, val_lo);
         }
         return;
     }
-- 
2.39.2


