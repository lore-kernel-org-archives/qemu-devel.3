Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D87FE6F09F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4ey-0008Vq-S1; Tue, 23 Dec 2025 10:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4ev-0008V5-7H
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:49 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4es-0005Q5-RM
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 283046013B;
 Tue, 23 Dec 2025 15:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12795C113D0;
 Tue, 23 Dec 2025 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766505045;
 bh=/kho4iJSwPdyrQjonMXqdwVBKPpnh7EN0GcAHb9z6aI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o0m/bdrarmHuXizlgihQAx2Mha0dqhNWJYeXzfLUmwWvPaPFknUGLOAUorSdP6ZTN
 PQB2PP44jqq7P1D+mS/ShTJJS+0SSQXyAazr4ou1ylSWhsVgP8CeV3+rxtQO6vx2VI
 awcyOefayfEQDSBTsRlc7APReBLd9eBH8SdkUXepLfMDFPR1X/t3iTkLKNFXK9puzE
 rxlTVInpH3WvKvABBWKDDPwitfirkkJV6x/ubABtBnKAyC+GARsSJi889goHaOKlax
 l1E1dx1HWDH5wDXsePT1W2IjamCUK08dAOSMv2WX3oHk5QVI731sxHZxxUcZcMASPm
 ESctC3cmkgBpQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 04/12] scsi: ncr710: Fix interrupt related register handing
Date: Tue, 23 Dec 2025 16:50:23 +0100
Message-ID: <20251223155031.7110-5-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223155031.7110-1-deller@kernel.org>
References: <20251223155031.7110-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

These fixes ensure proper interrupt signaling and status
register behavior during SCSI operations:
- Mask DFE bit in ncr710_update_irq()
- Remove manual ISTAT_DIP clearing, let ncr710_update_irq()
  handle it consistently
- Fix SSTAT0 read to clear unconditionally when non zero
- Fix SSTAT2 read was returning DSTAT instead
- Preserve DFE status bit when clearing DSTAT

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index ac1ca4cef8..0b7734a129 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -593,7 +593,7 @@ static void ncr710_update_irq(NCR710State *s)
 {
     int level = 0;
 
-    if (s->dstat) {
+    if (s->dstat & ~NCR710_DSTAT_DFE) {
         if (s->dstat & s->dien) {
             level = 1;
         }
@@ -1785,7 +1785,6 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         }
         s->dstat = 0;  /* Clear all DMA interrupt status bits */
         s->dstat |= NCR710_DSTAT_DFE;
-        s->istat &= ~NCR710_ISTAT_DIP;
         ncr710_update_irq(s);
 
         if (s->waiting == NCR710_WAIT_RESELECT && s->current &&
@@ -1811,7 +1810,7 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         return ret;
     case NCR710_SSTAT0_REG: /* SSTAT0 */
         ret = s->sstat0;
-        if (s->sstat0 != 0 && !(s->sstat0 & NCR710_SSTAT0_STO)) {
+        if (s->sstat0 != 0) {
             s->sstat0 = 0;
             s->istat &= ~NCR710_ISTAT_SIP;
             ncr710_update_irq(s);
@@ -1824,14 +1823,7 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         ret = s->sstat0;
         break;
     case NCR710_SSTAT2_REG: /* SSTAT2 */
-        ret = s->dstat;
-
-        if (s->dstat & NCR710_DSTAT_SIR) {
-            /* SIR bit processing */
-        }
-        s->dstat = 0;
-        s->istat &= ~NCR710_ISTAT_DIP;
-        ncr710_update_irq(s);
+        ret = s->sstat2;
         break;
         CASE_GET_REG32(dsa, NCR710_DSA_REG)
         break;
@@ -1902,7 +1894,6 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         if (s->dsps == GOOD_STATUS_AFTER_STATUS &&
             (s->dstat & NCR710_DSTAT_SIR)) {
             s->dstat &= ~NCR710_DSTAT_SIR;
-            s->istat &= ~NCR710_ISTAT_DIP;
             ncr710_update_irq(s);
         }
         break;
-- 
2.52.0


