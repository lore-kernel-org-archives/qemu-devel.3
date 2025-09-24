Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7691CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Rni-00039D-1T; Wed, 24 Sep 2025 11:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v1RnZ-00038d-LR
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v1RnS-0001rW-Bq
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758729163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u7lXuePxzOzYt4UWtbo1RmvyGupM6Ucgui12K9Ck/i0=;
 b=cr/nkHybcCfJEe/wzBqTlyoHZVwwTr1O8ykJDg6lwCLjFtTGnADYMFWnQHHIkBJZmx/N8d
 iwHzBFNt30VVPh3UfCoaZE0+Ly4S/MRPNReGPm3Q95eASEml2hlW0Rr/LgNAojM+qFPhHv
 RY/XVw83SkVEGnaeaEKoKeRJp8HnxgI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-0p8kFn9bP0eibMMyZIg5mA-1; Wed,
 24 Sep 2025 11:52:38 -0400
X-MC-Unique: 0p8kFn9bP0eibMMyZIg5mA-1
X-Mimecast-MFC-AGG-ID: 0p8kFn9bP0eibMMyZIg5mA_1758729157
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2268519560AB; Wed, 24 Sep 2025 15:52:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.207])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 339011955F22; Wed, 24 Sep 2025 15:52:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Qing Wang <qinwang@redhat.com>
Subject: [PATCH] pcie_sriov: make pcie_sriov_pf_exit() safe on non-SR-IOV
 devices
Date: Wed, 24 Sep 2025 11:51:53 -0400
Message-ID: <20250924155153.579495-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 3f9cfaa92c96 ("virtio-pci: Implement SR-IOV PF") added an
unconditional call from virtio_pci_exit() to pcie_sriov_pf_exit().

pcie_sriov_pf_exit() reads from the SR-IOV Capability in Configuration
Space:

  uint8_t *cfg = dev->config + dev->exp.sriov_cap;
  ...
  unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This results in undefined behavior when dev->exp.sriov_cap is 0 because
this is not an SR-IOV device. For example, unparent_vfs() segfaults when
total_vfs happens to be non-zero.

Fix this by returning early from pcie_sriov_pf_exit() when
dev->exp.sriov_cap is 0 because this is not an SR-IOV device.

Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Michael S. Tsirkin <mst@redhat.com>
Reported-by: Qing Wang <qinwang@redhat.com>
Buglink: https://issues.redhat.com/browse/RHEL-116443
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/pci/pcie_sriov.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 8a4bf0d6f7..cf1b5b5c05 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -195,7 +195,9 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 
 void pcie_sriov_pf_exit(PCIDevice *dev)
 {
-    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+    if (dev->exp.sriov_cap == 0) {
+        return;
+    }
 
     if (dev->exp.sriov_pf.vf_user_created) {
         uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
@@ -211,6 +213,8 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
             pci_config_set_device_id(dev->exp.sriov_pf.vf[i]->config, vf_dev_id);
         }
     } else {
+        uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+
         unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
     }
 }
-- 
2.51.0


