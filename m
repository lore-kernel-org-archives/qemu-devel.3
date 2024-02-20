Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF6C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcKGB-00086m-5p; Tue, 20 Feb 2024 02:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=978002c08f=schalla@marvell.com>)
 id 1rcKGA-00086N-AP
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:09:46 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=978002c08f=schalla@marvell.com>)
 id 1rcKG7-0007z7-NA
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:09:46 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41K3qUJ5005734; Mon, 19 Feb 2024 23:09:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=pfpt0220; bh=tLzNhQ+o
 AsfNu7fDJNDGZh1uzfuL9hQ0OaDv5nEqAxQ=; b=TqMv/2Q5YHt4jtkvbj3aJL5+
 SCQvI8M5dRoojDQGQ3dTxoeksFF+nsQrOtlRg2M/mBW45NwtPVNfR800sufeQVcw
 JbSY7FQoPgSp/ijN9xc0NeaikWeloj1/KG1PqSpjlWGd9ti6atWcnVnqRqFOyc0Y
 gruzTm9OrI+0vniTuUr/RNjwzHb7CLsGeNc7SEfsykgg5TP1W0VGS1DqdkOmapkX
 amBZ5DjMAkEmk1i101+2psYTHx115GUfUhK+nUJlRBahL2awV9TvAEwYyvPCTJrv
 Z51pdvkAY2uu1ZM6/DYlLpx1uoPVlY64r9GZ2cuX5ZUvp55DIIDQBG3Og94vug==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wcmjcrddf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 23:09:39 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48;
 Mon, 19 Feb 2024 23:09:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 19 Feb 2024 23:09:38 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
 by maili.marvell.com (Postfix) with ESMTP id 461323F7043;
 Mon, 19 Feb 2024 23:09:36 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <vattunuru@marvell.com>, <jerinj@marvell.com>,
 <schalla@marvell.com>
Subject: [PATCH v2] virtio-pci: correctly set virtio pci queue mem multiplier
Date: Tue, 20 Feb 2024 12:39:35 +0530
Message-ID: <20240220070935.1617570-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PqaqoYjhZNP647250LkCygJWOnh2oG5C
X-Proofpoint-GUID: PqaqoYjhZNP647250LkCygJWOnh2oG5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.148.174;
 envelope-from=prvs=978002c08f=schalla@marvell.com;
 helo=mx0b-0016f401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, virtio_pci_queue_mem_mult function always returns 4K
when VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this won't
work for vhost vdpa when host has page size other than 4K.
This patch introduces a new property(page-per-vdpa-vq) for vdpa
use case to fix the same.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
v1->v2:
- Introduced a new property to get virtqueue mem multiplier for
  vdpa use case.

 hw/virtio/virtio-pci.c         | 10 ++++++++--
 include/hw/virtio/virtio-pci.h |  5 +++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1a7039fb0c..28dd6ab8b5 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -320,8 +320,12 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState *d)
 
 static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
 {
-    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
-        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
+    if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)
+        return QEMU_VIRTIO_PCI_QUEUE_MEM_MULT;
+    else if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ)
+        return qemu_real_host_page_size();
+    else
+        return 4;
 }
 
 static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
@@ -2301,6 +2305,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_AER_BIT, false),
+    DEFINE_PROP_BIT("page-per-vdpa-vq", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ_BIT, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 59d88018c1..10a30c26a2 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -43,6 +43,7 @@ enum {
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
     VIRTIO_PCI_FLAG_AER_BIT,
     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
+    VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -89,6 +90,10 @@ enum {
 #define VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED \
   (1 << VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT)
 
+/* page per vdpa vq flag to be used for vhost vdpa backends */
+#define VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ \
+    (1 << VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ_BIT)
+
 typedef struct {
     MSIMessage msg;
     int virq;
-- 
2.25.1


