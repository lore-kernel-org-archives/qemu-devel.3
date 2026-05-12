Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C623CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuBP-00020k-9a; Tue, 12 May 2026 16:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBA-0001ic-BX; Tue, 12 May 2026 16:58:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuB7-00046t-LK; Tue, 12 May 2026 16:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619275; bh=NXvklHLMe/1G/6v/zFdrKIGMlkdSHYR/Psz+Ummg+1c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vlz05jTFwUtiQucGsmhVsPFvJB+IwFIclr3meCAwmJTAGVM15kB4w93olBvU8AX0/
 hpfT3JmCwndxj6YcoJBcMwtdDb4zN4/qZmoTIWIxs32MmWKUxM+y7xmMo4FoHhR+dM
 EQaaVCJPfTI33ij1PcKE/rQFI83S7hhLiqdxhDonB1b98pLTngpM+6/ko41oG4NVd/
 qxUjSc1miYj3CVifJj3/NC8TjXWXAsvbhty2OqKN81KXy9+5EacxmwWdUhin2KeHtF
 oWPSSM7EUqQL89/v4nHqiryWkIqZJ1sam3BKedV9Flc1KeDpP0wqqNBqRfXLZs77UV
 C0g0p0AcJhDUA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 85B7D1AA2EF;
 Tue, 12 May 2026 23:54:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 93CE53ABC60;
 Tue, 12 May 2026 23:54:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 035/107] lsi53c895a: do not do anything else if a
 reset is requested by writing ISTAT0
Date: Tue, 12 May 2026 23:53:22 +0300
Message-ID: <20260512205437.360850-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Paolo Bonzini <pbonzini@redhat.com>

If the device is reset, anything that is done before will not really
be visible.  So do the reset and exit immediately if that is one
of the requests in the value written to ISTAT0.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 64807c84e83f767c135aa9ba4b5f61162bb177ef)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index bf58212fb1..a5598931f9 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1949,6 +1949,10 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
     CASE_SET_REG32(dsa, 0x10)
     case 0x14: /* ISTAT0 */
         s->istat0 = (s->istat0 & 0x0f) | (val & 0xf0);
+        if (val & LSI_ISTAT0_SRST) {
+            device_cold_reset(DEVICE(s));
+            return;
+        }
         if (val & LSI_ISTAT0_ABRT) {
             lsi_script_dma_interrupt(s, LSI_DSTAT_ABRT);
         }
@@ -1962,9 +1966,6 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
             s->dsp = s->dnad;
             lsi_execute_script(s);
         }
-        if (val & LSI_ISTAT0_SRST) {
-            device_cold_reset(DEVICE(s));
-        }
         break;
     case 0x16: /* MBOX0 */
         s->mbox0 = val;
-- 
2.47.3


