Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD47C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 05:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdO5V-00077o-S2; Fri, 23 Feb 2024 00:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=97838892c8=schalla@marvell.com>)
 id 1rdO4t-0006uc-9S
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:26:35 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=97838892c8=schalla@marvell.com>)
 id 1rdO4q-0006xJ-Ri
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:26:30 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41ML8Snq001850; Thu, 22 Feb 2024 21:26:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=pfpt0220; bh=d+ckUkce
 OoyeR4yJF6ZJfUSbi8m5w2Y0NH+3evoWjW0=; b=ABat2nioXhED1Wgwwu/GT2xm
 skMRvNDbnPD4otH1uWKBzjBsfTNabRqDNFi97BXPbJs9CtcIlzaUiC5tpjyNe3SQ
 1U4WuiFS0+FAyAvU/dwjo+ZtDt02U4KBvg7jduc7OXA3eFAsYnCTtO4bQnNNewLo
 PVfImwqJYwPuF2WO0m9z8wwDe+7wPznJmgjhArLWJsX0A4rEdhScW0ckpnMFHZZ9
 WiL53ut6XAfRpQhjV4vuiJzwMbexY7tz0n4wzRgRegwrT8W1NICGMKOsmDSfm2oZ
 mTul9iNm3u87c33P6qUxrCZ0lJjW8YnKx2do7auWqExDibeoLwE05gaWc26jLg==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wedwxhd6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 22 Feb 2024 21:26:23 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48;
 Thu, 22 Feb 2024 21:26:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 22 Feb 2024 21:26:21 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
 by maili.marvell.com (Postfix) with ESMTP id 0C99A3F7068;
 Thu, 22 Feb 2024 21:26:18 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <vattunuru@marvell.com>,
 <jerinj@marvell.com>, <schalla@marvell.com>
Subject: [PATCH v3] virtio-pci: correctly set virtio pci queue mem multiplier
Date: Fri, 23 Feb 2024 10:56:17 +0530
Message-ID: <20240223052617.1867132-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sf_XIhcGLMbJ8pFZHlAScyY8j5II3ULh
X-Proofpoint-ORIG-GUID: sf_XIhcGLMbJ8pFZHlAScyY8j5II3ULh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.156.173;
 envelope-from=prvs=97838892c8=schalla@marvell.com;
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
This patch introduces a new property(host-page-per-vq) for vdpa
use case to fix the same.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
v2->v3:
- Modified property name, page-per-vdpa-vq to host-page-per-vq.

v1->v2:
- Introduced a new property to get virtqueue mem multiplier for
  vdpa use case.

 hw/virtio/virtio-pci.c         | 10 ++++++++--
 include/hw/virtio/virtio-pci.h |  5 +++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1a7039fb0c..f29e60830b 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -320,8 +320,12 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState *d)
 
 static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
 {
-    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
-        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
+    if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)
+        return QEMU_VIRTIO_PCI_QUEUE_MEM_MULT;
+    else if (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ)
+        return qemu_real_host_page_size();
+    else
+        return 4;
 }
 
 static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
@@ -2301,6 +2305,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_AER_BIT, false),
+    DEFINE_PROP_BIT("host-page-per-vq", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 59d88018c1..81b6de4291 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -43,6 +43,7 @@ enum {
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
     VIRTIO_PCI_FLAG_AER_BIT,
     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
+    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -89,6 +90,10 @@ enum {
 #define VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED \
   (1 << VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT)
 
+/* page per vdpa vq flag to be used for vhost vdpa backends */
+#define VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ \
+    (1 << VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT)
+
 typedef struct {
     MSIMessage msg;
     int virq;
-- 
2.25.1


