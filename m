Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABEBC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 06:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdnt-0007sQ-SN; Tue, 29 Jul 2025 02:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugdnc-0007fR-Kq
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:26:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugdna-0007Rl-J5
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753770414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpitLwFSHBUSLoDxUzXl4x0I0kpob6qjDvHD3JbbN90=;
 b=IoKMS9oy8P8rG+4C6ilSG1IjyPXfCYruUqCryFvjKuvRXL/r+n/SGLloFebNrBw4QNx+W0
 yK+SXg9IQ6syzISYk/9jNPo74HgBuVTA138EJncLVFH0KWbcQK78SPL8RwIxK8cwgQ3TZG
 YDar4H/0uCHCbPCilwgVlnOksRyP/U0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-U0mTL71YM-2mgCHUckhA6g-1; Tue,
 29 Jul 2025 02:26:50 -0400
X-MC-Unique: U0mTL71YM-2mgCHUckhA6g-1
X-Mimecast-MFC-AGG-ID: U0mTL71YM-2mgCHUckhA6g_1753770409
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DA18180010A; Tue, 29 Jul 2025 06:26:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 295381955F16; Tue, 29 Jul 2025 06:26:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 3/5] vfio: fix sub-page bar after cpr
Date: Tue, 29 Jul 2025 08:26:31 +0200
Message-ID: <20250729062633.452522-4-clg@redhat.com>
In-Reply-To: <20250729062633.452522-1-clg@redhat.com>
References: <20250729062633.452522-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Regions for sub-page BARs are normally mapped here, in response to the
guest writing to PCI config space:

  vfio_pci_write_config()
    pci_default_write_config()
      pci_update_mappings()
        memory_region_add_subregion()
    vfio_sub_page_bar_update_mapping()
      ... vfio_dma_map()

However, after CPR, the guest does not reconfigure the device and the
code path above is not taken.  To fix, in vfio_cpr_pci_post_load, call
vfio_sub_page_bar_update_mapping for each sub-page BAR with a valid
address.

Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1752520890-223356-1-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h |  1 +
 hw/vfio/cpr.c |  2 ++
 hw/vfio/pci.c | 14 ++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 248e5c4b16269cb536e53c75aedfadeafb8a3752..bca289035aaebb6c4422b31e26bb1dd76ab5ae72 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -219,6 +219,7 @@ void vfio_pci_write_config(PCIDevice *pdev,
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
+void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
 bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
 bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_vga_quirk_setup(VFIOPCIDevice *vdev);
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index af0f12a7adf5a3bc331afcedae3a4e23309e4d2e..384b56c4c74d8224df0ceecb2b8ea4e1a1f40562 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -116,6 +116,8 @@ static int vfio_cpr_pci_post_load(void *opaque, int version_id)
     PCIDevice *pdev = &vdev->pdev;
     int nr_vectors;
 
+    vfio_sub_page_bar_update_mappings(vdev);
+
     if (msix_enabled(pdev)) {
         vfio_pci_msix_set_notifiers(vdev);
         nr_vectors = vdev->msix->entries;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 0c4606d9cb5e163b8c533ed9b89d4d73eafaae24..f5bc5359eb8bdb8ddfa5f2b50d7387f2638bbeb4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2824,6 +2824,20 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
     return ret;
 }
 
+void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    int page_size = qemu_real_host_page_size();
+    int bar;
+
+    for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
+        PCIIORegion *r = &pdev->io_regions[bar];
+        if (r->addr != PCI_BAR_UNMAPPED && r->size > 0 && r->size < page_size) {
+            vfio_sub_page_bar_update_mapping(pdev, bar);
+        }
+    }
+}
+
 static VFIODeviceOps vfio_pci_ops = {
     .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
     .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
-- 
2.50.1


