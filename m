Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BC5CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27uM-0004su-VT; Fri, 26 Sep 2025 08:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27uA-0004on-Kx; Fri, 26 Sep 2025 08:50:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27u0-0007aH-1A; Fri, 26 Sep 2025 08:50:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E5DB157F64;
 Fri, 26 Sep 2025 15:45:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DA186290F22;
 Fri, 26 Sep 2025 15:45:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 28/38] target/sparc: Loosen decode of RDPSR for v7
Date: Fri, 26 Sep 2025 15:45:28 +0300
Message-ID: <20250926124540.2221746-28-mjt@tls.msk.ru>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

For v7, bits [18:0] are ignored.
For v8, bits [18:14] are reserved and bits [13:0] are ignored.

Fixes: 668bb9b755e ("target/sparc: Move RDPSR, RDHPR to decodetree")
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit a0345f628394fbd001276c80fd02c8ad0d1b7ee2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 74848996ae..1c6403ad8a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -158,14 +158,16 @@ CALL    01 i:s30
 }
 
 {
-  RDPSR             10 rd:5  101001 00000 0 0000000000000
-  RDHPR_hpstate     10 rd:5  101001 00000 0 0000000000000
+  [
+    RDHPR_hpstate       10 rd:5  101001 00000 0 0000000000000
+    RDHPR_htstate       10 rd:5  101001 00001 0 0000000000000
+    RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
+    RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
+    RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
+    RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
+  ]
+  RDPSR                 10 rd:5  101001 ----- - -------------
 }
-RDHPR_htstate       10 rd:5  101001 00001 0 0000000000000
-RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
-RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
-RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
-RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
 
 {
   WRPSR             10 00000 110001 ..... . .............  @n_r_ri
-- 
2.47.3


