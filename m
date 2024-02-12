Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A37DC48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 07:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZR7M-00052R-Ro; Mon, 12 Feb 2024 02:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=9772fda087=schalla@marvell.com>)
 id 1rZR7M-00052J-4t
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 02:52:44 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=9772fda087=schalla@marvell.com>)
 id 1rZR7K-0005QD-Hm
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 02:52:43 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41C3PpKA002601; Sun, 11 Feb 2024 23:52:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=pfpt0220; bh=JSQMvAU4
 8oD6wx8uN1zOZNY11+FR1Hen82jzGbbCzDM=; b=dqU0m6KeaNJBNC0GFZYFB9HA
 4YAqR4QjknURiJ1FnwzaMucLqEeD/r9igsPW+ArQCmTGQeNFb+XioU0ndkmvntdy
 eN1HkNChmDcVOChiWAudeVYDxPJFyy6qs1B0I+WCEc5KbfXYHVmAXEKfRynxDWo8
 fTcCP0RhQgUuvR1XWWhC1cvikHaNotpSuCsMDl0Hxkvb3sucFhcb3SRJu40Zc5pw
 okmLEtKFOJFMuiCVrACjJU4AV9FQ7sV9j29iJXEpvAVMPZ5Whff6qFz0k4BIQ7gJ
 QBxXsue92iiXamF8f405g51W+Z8qhe+KQK3iBZY+1zPwETz7Rrk+5CnuJftE7Q==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w69hkbgge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 11 Feb 2024 23:52:38 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48;
 Sun, 11 Feb 2024 23:52:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 11 Feb 2024 23:52:36 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
 by maili.marvell.com (Postfix) with ESMTP id AEA253F7076;
 Sun, 11 Feb 2024 23:52:34 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <vattunuru@marvell.com>, <jerinj@marvell.com>,
 <schalla@marvell.com>
Subject: [PATCH] virtio-pci: correctly set virtio pci queue mem multiplier
Date: Mon, 12 Feb 2024 13:22:33 +0530
Message-ID: <20240212075233.1507612-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aPRXijM2a60rOMdYmdtpCDVEyTDN1OYT
X-Proofpoint-GUID: aPRXijM2a60rOMdYmdtpCDVEyTDN1OYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_05,2024-02-08_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.156.173;
 envelope-from=prvs=9772fda087=schalla@marvell.com;
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

Currently, virtio_pci_queue_mem_mult function returns 4K when
VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this is not correct
when host has page size as 64K.
This patch fixes the same.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 hw/virtio/virtio-pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e433879542..028df99991 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -316,12 +316,10 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState *d)
     return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) != 0;
 }
 
-#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
-
 static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
 {
     return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
-        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
+        qemu_real_host_page_size()  : 4;
 }
 
 static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
-- 
2.25.1


