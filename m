Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B39CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu9k-00067R-25; Tue, 12 May 2026 16:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu9e-0005xo-Mz; Tue, 12 May 2026 16:56:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu9V-0003Fc-Lb; Tue, 12 May 2026 16:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619274; bh=acKlxLEDYl/rGWwOoSEJZsTAkfqrcjA+SI0dYYGI7p0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fc32KqJOih4dtK8BKE4P1aG13PeVMl93n6LuFacM8Rot3hOEoKoetQzytKgKSFnlA
 7yQiWgW0EF39tNdhhtT3RW/WgyyYbdhE4QYbtoiUey7nbfxbT2HjQYKia+gKoeECEn
 HXI8WF3mEYezBsX0bbXd7Vu2dRY/Nkjq1b6QyWW8gTrBq7kmn6qFJ1iQgMILG7+/0b
 4B8RtBMKVhPWiql/ovwBOUXrSI9kOr/zKylqr8CkzighI5r+DRLMxL84y6VCWoaxS3
 83o6zeX8354ScZSFf5O8RUXIp/Z/R7/b4SQi7CwBCnNgIRgdY3uVEmzdm93pY3hyNn
 vzXBL3G4Y6j/Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A205F1AA2E0;
 Tue, 12 May 2026 23:54:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AD6A93ABC51;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 020/107] hw/net/ftgmac100: Improve DMA error handling
Date: Tue, 12 May 2026 23:53:07 +0300
Message-ID: <20260512205437.360850-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

Currently, DMA memory operation errors in the ftgmac100 model are not
all tested and this can lead to a guest-triggerable denial of service
as described in https://gitlab.com/qemu-project/qemu/-/work_items/3335.

To fix this, check the return value of ftgmac100_write_bd() in the TX
path and exit the TX loop on error to prevent further processing. In
the event of a DMA error, also set FTGMAC100_INT_AHB_ERR interrupt
flag as appropriate.

The FTGMAC100_INT_AHB_ERR interrupt status bit only applies to the
AST2400 SoC; on newer Aspeed SoCs, it is a reserved bit.
Nevertheless, since it is supported by the Linux driver and it should
be safe to use in the QEMU implementation across all SoCs.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260322215732.387383-3-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit fa4a759fc1e19b2185becfadb00c6d8e57462849)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 1f524d7a01..abfb47a824 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -624,7 +624,10 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
         bd.des0 &= ~FTGMAC100_TXDES0_TXDMA_OWN;
 
         /* Write back the modified descriptor.  */
-        ftgmac100_write_bd(&bd, addr);
+        if (ftgmac100_write_bd(&bd, addr)) {
+            s->isr |= FTGMAC100_INT_AHB_ERR;
+            break;
+        }
         /* Advance to the next descriptor.  */
         if (bd.des0 & s->txdes0_edotr) {
             addr = tx_ring;
@@ -1134,7 +1137,10 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
             bd.des0 |= flags | FTGMAC100_RXDES0_LRS;
             s->isr |= FTGMAC100_INT_RPKT_BUF;
         }
-        ftgmac100_write_bd(&bd, addr);
+        if (ftgmac100_write_bd(&bd, addr)) {
+            s->isr |= FTGMAC100_INT_AHB_ERR;
+            break;
+        }
         if (bd.des0 & s->rxdes0_edorr) {
             addr = s->rx_ring;
         } else {
-- 
2.47.3


