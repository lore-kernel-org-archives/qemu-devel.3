Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7320606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=N4UIn6Cf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Jg-0005tK-KO; Mon, 16 Nov 2026 15:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3JM-0005KD-22; Mon, 16 Nov 2026 15:28:20 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3JK-0001Ws-Aj; Mon, 16 Nov 2026 15:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860764; bh=2fTT5MjVKf1UbVNeNoM2Bmm4iqg9iMWcVJOJPSWtBsM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N4UIn6CfZhx5rpKAp0tWPHZxUboh4rWcvYWygESOYzPt9LFT3duPzmdWFyp2+P7lY
 Kmiq29tg/fzLeLmbqQ1axeik923KM9GrgZycliduooT5y7yadmYSDkAu3BGECnGLA0
 E2nf4Q76nwjTyyzkeypWgcR4XSJzXHUS+S5r8MdeqpG6LUrt4DtKgVsFaI2tyNzt8z
 n6ZDTCqcI58ru6MVSme4dfdqPQ69svJGSbj25J/Ip5PNzXpiEUXpasGo+4Vc7pW4iU
 lT4BpecqYLscpLsB3crvz5CRaUHMBSNDv0uAN0wthYBc1YIR/e8V9xqD9M/WDSjOEk
 ilXq0gL8VdwjQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 45A8C1E71B0;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4106A45FBDC;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B8275B8E7C; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Farhan Ali <alifm@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Omar Elghoul <oelghoul@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 27/63] s390x/pci: Change reset method from legacy to
 resettable exit
Date: Mon, 16 Nov 2026 23:25:06 +0300
Message-ID: <20261116202554.535325-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Farhan Ali <alifm@linux.ibm.com>

On subsystem reset of the s390 PCI host bridge (TYPE_S390_PCI_HOST_BRIDGE),
child buses S390PCIBus and PCIBus are reset in order. Because S390PCIBus
devices are reset first via the legacy reset hook, IOMMU mappings are torn
down before the PCI device itself is reset. For a PCI passthrough device
this opens a window where the device may issue DMA to addresses that no
longer have valid IOMMU mappings, causing an error (PEC 0x7) on the host.

The QEMU reset documentation (docs/devel/reset.rst) specifies that IOMMUs
should perform teardown in the resettable 'exit' phase, after all devices
have completed their 'hold' phase. Move the S390PCIBusDevice reset logic
from the legacy reset hook to the resettable exit phase to close this
window.

Fixes: 3e5cfba3ca0a ("s390x/pci: introduce S390PCIBusDevice qdev")
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261028224611.240515-2-alifm@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit b71287f0078200b07ee2fa9a28991645a3a92777)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 673ac4ecd19..b9017f98ca7 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1499,9 +1499,9 @@ static void s390_pci_device_realize(DeviceState *dev, Error **errp)
     zpci->fmb.format = ZPCI_FMB_FORMAT;
 }
 
-static void s390_pci_device_reset(DeviceState *dev)
+static void s390_pci_device_reset_exit(Object *obj, ResetType type)
 {
-    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
+    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(obj);
 
     switch (pbdev->state) {
     case ZPCI_FS_RESERVED:
@@ -1582,10 +1582,11 @@ static const VMStateDescription s390_pci_device_vmstate = {
 static void s390_pci_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "zpci device";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    device_class_set_legacy_reset(dc, s390_pci_device_reset);
+    rc->phases.exit = s390_pci_device_reset_exit;
     dc->bus_type = TYPE_S390_PCI_BUS;
     dc->realize = s390_pci_device_realize;
     device_class_set_props(dc, s390_pci_device_properties);
-- 
2.47.3


