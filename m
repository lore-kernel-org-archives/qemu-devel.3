Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E5ACAC5BC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27uP-00050q-4w; Fri, 26 Sep 2025 08:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27tr-0003dY-39; Fri, 26 Sep 2025 08:50:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27tg-0007Kd-TP; Fri, 26 Sep 2025 08:50:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 64927157F63;
 Fri, 26 Sep 2025 15:45:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C7E7D290F21;
 Fri, 26 Sep 2025 15:45:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 27/38] target/sparc: Loosen decode of RDY for v7
Date: Fri, 26 Sep 2025 15:45:27 +0300
Message-ID: <20250926124540.2221746-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

Bits [18:0] are not decoded with v7, and for v8 unused values
of rs1 simply produce undefined results.

Fixes: af25071c1d ("target/sparc: Move RDASR, STBAR, MEMBAR to decodetree")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
(cherry picked from commit 49d669ccf33a772e3baf3fe4ebb996dc015f46c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1b1b85e9c2..74848996ae 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -91,6 +91,7 @@ CALL    01 i:s30
     STBAR_v9        10 00000 101000 01111 0 0000000000000
     MEMBAR          10 00000 101000 01111 1 000000 cmask:3 mmask:4
 
+    RDY_v9          10 rd:5  101000 00000 0 0000000000000
     RDCCR           10 rd:5  101000 00010 0 0000000000000
     RDASI           10 rd:5  101000 00011 0 0000000000000
     RDTICK          10 rd:5  101000 00100 0 0000000000000
@@ -118,8 +119,15 @@ CALL    01 i:s30
   # This confirms that bit 13 is ignored, as 0x8143c000 is STBAR.
   STBAR_v8          10 ----- 101000 01111 - -------------
 
-  # Before v8, all rs1 accepted; otherwise rs1==0.
-  RDY               10 rd:5  101000 rs1:5 0 0000000000000
+  # For v7, bits [18:0] are ignored.
+  # For v8, bits [18:14], aka rs1, are repurposed and rs1 = 0 is RDY,
+  # and other values are RDASR.  However, the v8 manual explicitly
+  # says that rs1 in 1..14 yield undefined results and do not cause
+  # an illegal instruction trap, and rs1 in 16..31 are available for
+  # implementation specific usage.
+  # Implement not causing an illegal instruction trap for v8 by
+  # continuing to interpret unused values per v7, i.e. as RDY.
+  RDY_v7            10 rd:5  101000 ----- - -------------
 }
 
 {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 53183dc609..b54285e491 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2864,18 +2864,8 @@ static TCGv do_rdy(DisasContext *dc, TCGv dst)
     return cpu_y;
 }
 
-static bool trans_RDY(DisasContext *dc, arg_RDY *a)
-{
-    /*
-     * TODO: Need a feature bit for sparcv8.  In the meantime, treat all
-     * 32-bit cpus like sparcv7, which ignores the rs1 field.
-     * This matches after all other ASR, so Leon3 Asr17 is handled first.
-     */
-    if (avail_64(dc) && a->rs1 != 0) {
-        return false;
-    }
-    return do_rd_special(dc, true, a->rd, do_rdy);
-}
+TRANS(RDY_v7, 32, do_rd_special, true, a->rd, do_rdy)
+TRANS(RDY_v9, 64, do_rd_special, true, a->rd, do_rdy)
 
 static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
 {
-- 
2.47.3


