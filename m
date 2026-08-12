Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C20C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAQE-0008UE-Aq; Wed, 12 Aug 2026 10:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQ7-0007zp-Op; Wed, 12 Aug 2026 10:59:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQ4-0001Py-GF; Wed, 12 Aug 2026 10:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=YZd2o8ioWP3TLYC15aSzKKpuMufkREXIn4EkSL5U3i0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wePOu7QKpMEv8P/IUYngb/4x1GG5PHv2H4I0zcERpwiLiInjPBjcbBhLa/TNyC1Ig
 pzyRYE2WT5ZRcaG1HZRdY/pZcdxJyNBNTqJI1+wLfF201ScLmu3i89Hkqgj92b/NLy
 W2hwCEtIt9keUo6P4IU1ZlHaBKkBya6HvwVtTjzeZFIrCSydkPxAHjwCHwKFQZz1qk
 0QnK7g2o/6lMLvxj1+ezgTALTkdXkpfgDMKy2WONng8bdUAb4dYjNkKuIpHP8LSjR5
 lx17szf4dxPPARAIXzJEAu0lLzGIh1daVjeFqqPAPaFhr4T7XTzeYan53NTofp8Ira
 YLUOXlCjs+azQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 24F011CA659;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7FF57409D9B;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DE1582FA0D; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Paziyski <danielpaziyski@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 085/120] hw/nvme: fix assertion failure on subregion
 removal
Date: Wed, 12 Aug 2026 17:49:08 +0300
Message-ID: <20260812144955.649205-85-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Daniel Paziyski <danielpaziyski@gmail.com>

When a controller is created with a MSI-X exclusive BAR, the bar0 memory region
is not used at all, and so, the iomem region is not added as a subregion of it.
However, when removing a NVMe controller, the iomem region is unconditionally
removed as a subregion of bar0, causing an assertion failure. Remove the iomem
memory region as a subregion of bar0 only if not using a MSI-X exclusive BAR.

QEMU options (requires a hotunplug-aware OS):

        -M q35 -device pcie-root-port,id=rp0 \
        -device nvme,serial=ctrl0,id=ctrl0,bus=rp0,msix-exclusive-bar=on

In the QEMU monitor, or by causing an ejection from the OS:

        device_del ctrl0

Message in stderr:

qemu-system-x86_64: ../system/memory.c:2617: memory_region_del_subregion: Assertion `subregion->container == mr' failed.

Fixes: fa905f65c554 ("hw/nvme: add machine compatibility parameter to enable msix exclusive bar")
Fixes: 9162f1012576 ("hw/nvme: fix msix_uninit with exclusive bar")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4090
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 6e5ca34f3870a8cad7a61395f82d40df62cb5d52)
(Mjt: context fixup across v11.0.0-2637-g5320d335fb8d
 "hw/nvme: add migration blockers for non-supported cases")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 582a04542cd..164c0ab0d4b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9392,9 +9392,9 @@ static void nvme_exit(PCIDevice *pci_dev)
         msix_uninit_exclusive_bar(pci_dev);
     } else {
         msix_uninit(pci_dev, &n->bar0, &n->bar0);
+        memory_region_del_subregion(&n->bar0, &n->iomem);
     }
 
-    memory_region_del_subregion(&n->bar0, &n->iomem);
 }
 
 static const Property nvme_props[] = {
-- 
2.47.3


