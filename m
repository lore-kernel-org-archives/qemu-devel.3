Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BB4CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUSL-0000hP-Iq; Sat, 13 Jun 2026 15:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUSG-0000NG-62; Sat, 13 Jun 2026 15:55:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUSD-0004h8-5m; Sat, 13 Jun 2026 15:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380261; bh=5/rsleK4VKiBqumnsjYhUN9Uc6/t1nX/VfUewIfRMcc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RcDCt4CGlMKVb46QqVCU0g0v9OQBaKLu0CjsSsZM1SJe6Baqz1rrz4C6/jJjGLoKt
 FL+vs8xOaAu1hYKA1hlavsDhsqPG0KaHW0IzymTh/0GS40bP+NMRLxvdT8MIgdSQ2V
 8nY68SvJtT6AAXyNhC5HICvVImmxcPMv10WIZjL8+7GnbWMKdsLlXhzWnDy1ZlUqff
 3guAh1ScuC+qMgZgkXzF00wUwFmQLN1r1uLdBoRxfYSKK48qqaTcNrDgS1ZvsX0gCw
 gm42nDCwNOyCvluTh/gnf1uOWNNsQEn94h3mh40OwASgezuPu99sUSZ5WL7QhR9za/
 TPF9uz6IKIXew==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 03A0A1B6E3C;
 Sat, 13 Jun 2026 22:51:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4E3423CE8B6;
 Sat, 13 Jun 2026 22:51:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Farhan Ali <alifm@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Omar Elghoul <oelghoul@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 45/56] s390x/pci: Fix interrupt forwarding disable
 for interpreted devices
Date: Sat, 13 Jun 2026 22:50:59 +0300
Message-ID: <20260613195116.1807273-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
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
index 2591ee49c1..8b63156c30 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1492,7 +1492,7 @@ static void s390_pci_device_reset(DeviceState *dev)
         break;
     }
 
-    if (pbdev->interp && (pbdev->fh & FH_MASK_ENABLE)) {
+    if (pbdev->interp) {
         /* Interpreted devices were using interrupt forwarding */
         s390_pci_kvm_aif_disable(pbdev);
     } else if (pbdev->summary_ind) {
-- 
2.47.3


