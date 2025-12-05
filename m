Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038E6D32D8A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 14:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXFf-00052m-Kq; Fri, 05 Dec 2025 09:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vRXFd-00052J-R2
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 09:57:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vRXFc-0004qz-FJ
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 09:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764946658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VwumzNpliOTN0Zo+0UIBDlVATpWTRIApdu7VTg2khBQ=;
 b=Ylp8w09W97vJqZX010zGOzt9/xvWb8v9VU0lPzan1kP3+FhDrE86+lKHe3d2Qem2NhGOoC
 UoSKoXb8okj3Z9/hMU4YM4CAVKqTULncLVViCYLADAVWmqMcHd33r3E819iABYGRwzKjB5
 ydko8aWJ58Gh7pHlhDbIsjUkg5C4PZM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-shU7WiXWM6q0PllZWNAk9w-1; Fri,
 05 Dec 2025 09:57:33 -0500
X-MC-Unique: shU7WiXWM6q0PllZWNAk9w-1
X-Mimecast-MFC-AGG-ID: shU7WiXWM6q0PllZWNAk9w_1764946652
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A5C51956054; Fri,  5 Dec 2025 14:57:32 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.174])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFC7719560B4; Fri,  5 Dec 2025 14:57:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, mst@redhat.com,
 akihiko.odaki@daynix.com, qemu-stable@nongnu.org
Subject: [PATCH] pcie_sriov: Fix PCI_SRIOV_* accesses in pcie_sriov_pf_exit()
Date: Fri,  5 Dec 2025 15:57:18 +0100
Message-ID: <20251205145718.55136-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

PCI_SRIOV_* are offsets into the SR-IOV capability, not into the PCI
config space. pcie_sriov_pf_exit() erroneously takes them as the latter,
which makes it read PCI_HEADER_TYPE and PCI_BIST when it tries to read
PCI_SRIOV_TOTAL_VF.

In many cases we're lucky enough that the PCI config space will be 0
there, so we just skip the whole for loop, but this isn't guaranteed.
For example, setting the multifunction bit on the PF and then doing a
'device_del' on it will get a larger number and cause a segfault.

Fix this and access the real PCI_SRIOV_* fields in the capability.

Cc: qemu-stable@nongnu.org
Fixes: 19e55471d4e8 ('pcie_sriov: Allow user to create SR-IOV device')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/pci/pcie_sriov.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index c4f88f09757..d467284cbda 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -195,14 +195,17 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 
 void pcie_sriov_pf_exit(PCIDevice *dev)
 {
+    uint8_t *cfg;
+
     if (dev->exp.sriov_cap == 0) {
         return;
     }
+    cfg = dev->config + dev->exp.sriov_cap;
 
     if (dev->exp.sriov_pf.vf_user_created) {
         uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
-        uint16_t total_vfs = pci_get_word(dev->config + PCI_SRIOV_TOTAL_VF);
-        uint16_t vf_dev_id = pci_get_word(dev->config + PCI_SRIOV_VF_DID);
+        uint16_t total_vfs = pci_get_word(cfg + PCI_SRIOV_TOTAL_VF);
+        uint16_t vf_dev_id = pci_get_word(cfg + PCI_SRIOV_VF_DID);
 
         unregister_vfs(dev);
 
@@ -213,8 +216,6 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
             pci_config_set_device_id(dev->exp.sriov_pf.vf[i]->config, vf_dev_id);
         }
     } else {
-        uint8_t *cfg = dev->config + dev->exp.sriov_cap;
-
         unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
     }
 }
-- 
2.52.0


