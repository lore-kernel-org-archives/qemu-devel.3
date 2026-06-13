Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75D5CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUfK-0001cc-HX; Sat, 13 Jun 2026 16:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUfH-0001X0-9f; Sat, 13 Jun 2026 16:09:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUfF-0002kH-ME; Sat, 13 Jun 2026 16:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381070; bh=Rw04CJ7iJKVLfo5V6cQGHcttrvSihQhZJ9mGh5ztY7w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NsE/DJjjaJPqHU1Px9oXLF1LOr2FKzlQcqxCJeadKZUxB3AGq6iE8O8hJyK+aqVBF
 3SX3gEo9y1rh2utKPdZX1VlCER1tLVspwWAQSUlQpQlxGMzC6bFbI+knOhuaPhT0ul
 bWBwmoGNnxU4/8JDzqaRspco7RPetxhzEtNU1J9eL23txAyZjt76WkHu+lvV/vnQYA
 pMCXop1XDgDmZcrHPiCLugfhdBO2ZyR9xXG6VvCVqeCHIuTZfWlIaTSn1ya4Pa9Mix
 4SgikOXdqcUTfIWqvQ4IzLSnV/16cKLbGuLnYziYjjdvJgsMGRmOomT6HZ2S8o6I45
 8TTzvk7luvIZA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5B03F1B6EA1;
 Sat, 13 Jun 2026 23:04:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AB0F93CE8FC;
 Sat, 13 Jun 2026 23:04:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Farhan Ali <alifm@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Omar Elghoul <oelghoul@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 50/61] s390x/pci: Fix interrupt forwarding disable for
 interpreted devices
Date: Sat, 13 Jun 2026 23:03:33 +0300
Message-ID: <20260613200411.1808021-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
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

From: Farhan Ali <alifm@linux.ibm.com>

Remove the FH_MASK_ENABLE check when disabling interrupt forwarding
during device reset. This check was broken for the default case in
the switch statement above, preventing proper cleanup of interrupt
forwarding.

The pbdev->aif check in s390_pci_kvm_aif_disable() already guards
against double-disabling of interrupt forwarding.

Cc: qemu-stable@nongnu.org
Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
Message-ID: <20260521182946.1607-1-alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 442f727b8bebabf20a4f6a7536a4ff2885402030)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 52820894fa..4ed4e45cb9 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1504,7 +1504,7 @@ static void s390_pci_device_reset(DeviceState *dev)
         break;
     }
 
-    if (pbdev->interp && (pbdev->fh & FH_MASK_ENABLE)) {
+    if (pbdev->interp) {
         /* Interpreted devices were using interrupt forwarding */
         s390_pci_kvm_aif_disable(pbdev);
     } else if (pbdev->summary_ind) {
-- 
2.47.3


