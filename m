Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A700CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux3lp-0006Lm-0Q; Fri, 12 Sep 2025 09:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lingshan.Zhu@amd.com>)
 id 1uwx5d-0007x9-MC
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 02:17:03 -0400
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com
 ([40.107.223.69] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lingshan.Zhu@amd.com>)
 id 1uwx5a-0006KB-0a
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 02:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bee1foAx9dmBhVN4aoQNvyhyNjzgBFyTjbxYNl8+TABN+riWh3JFlmQBb5UIZgya5NaJPCEnJV0CDn67Aa8oRpeUl/OaCLZehbdRpRu6Sqb/IhAW7NbPRLXK0mtfV3wLPFGGaiuB1qjGHqH2VrNQ/ZHHFlUytKKGzQb1ixWdPgswnYc+nAt28v7A5njwv9V1XL6RZwXIZDQT+P4c1Ptbbtw5M1+WnDFWnN+c+hMd3vwhpxd35OCJrrXyjWZt2pQK79MikuW0ySZpDx80mgmM9s6Ac00VkY3uSS3OIoBTyeUj0PLCnrb93ND5DeO6qyvdpu2lLwspVsUALQM77Numcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95TWvbCBcQ67oLQB5uLe4Gs5dN6jQgcObsuIGMd1820=;
 b=u7ukzqWwWdTWNNxrfkYXQrE1tgmpOkA8jyjIc4XycYNitBv8SREnZKtZdotJm/mXYeftRyBJz7qJYu800TkgSRMHYIqBez9M9jt4vTIqmOxBEut9CqFu7OFaZPY6mQzJvV4tz3DTRUfx2gClG55AXoF5agehSs9BvDrJOk8/HN+XdAxlRSjIhd8HZiLxwIOzFPP8Ja2BHYYD/ehBNAn/Y3wT7ScvzpDVN3+JQjhWlm+QQOyYBqseqLQa4Z0ZWKZlx2AIehApW26jTrpn4R8hEwOdlTkzJDZLcaHqv6qhefXQXFpLNEvd9K1qdjWLZ7X+b2nrPPptoziTeKkzYivq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95TWvbCBcQ67oLQB5uLe4Gs5dN6jQgcObsuIGMd1820=;
 b=GnaDH7KjTdXV/+l+GJtyImPEand+bdcHltuZV+hu8Vw5eo0GDr0jwAELjm3BzdLS2GNn7j3XnyaB3V2Yvj4zvksm+vubo93Yso9xs8soayLBUY21TY4BdC1gxDV7J1dik0djjbNtMiZdyDZuL2e42lwtfRUC9vcVK7R8f5VY7cE=
Received: from SA0PR11CA0209.namprd11.prod.outlook.com (2603:10b6:806:1bc::34)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 06:11:46 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::8e) by SA0PR11CA0209.outlook.office365.com
 (2603:10b6:806:1bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 06:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 06:11:45 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 23:11:43 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Zhu Lingshan <lingshan.zhu@amd.com>
Subject: [RFC 1/2] virtio: implement virtio data-plane suspend and resume
 facility
Date: Fri, 12 Sep 2025 14:11:24 +0800
Message-ID: <20250912061125.262457-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912061125.262457-1-lingshan.zhu@amd.com>
References: <20250912061125.262457-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: e594e7c4-ffb6-45a2-a097-08ddf1c34061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9dqydwJ1sU24PzmeFoBiA1plKaQGdl0DgxrVSCNUTQL6+gOmUDI04h135Bl7?=
 =?us-ascii?Q?efUFStwG1LMm++aqZtA6iYNPZACj+uHDSw5AmGbjZdbYd+L1yI6FulHMo7PH?=
 =?us-ascii?Q?oWe2ZMSBdycCHnv8pXyWBGrD9ennlZV9ibyYcXqfQBru1NTqEB6yBLhQsaU6?=
 =?us-ascii?Q?4l5znN9FKtEoFuC6yh1fHYPLifx0OgA1RETcbpdWjVVrY1MGi54a5x2PC88I?=
 =?us-ascii?Q?P0V4Q/JXMtibofHpQtKod5uXOCcSinv9zRRTea8OBNcWQmM31WbOiFMJrX2C?=
 =?us-ascii?Q?pTPmBXYCAkmjBDUucXsMv60KsATvXZyYHWpz3Nwogqum6Ao/6gB2tQ0mdkMB?=
 =?us-ascii?Q?pmemANJdX1Hy+qRluzdlH4zEzlazG6bzJxB03Zhr2iGt4KZ1bNKCkatRDNv4?=
 =?us-ascii?Q?ARIEcLGLjZ1DeDTFvBTenBhjZEycW5KLP4ptIJl1+RZO20SaJNpZB5cx9Rnu?=
 =?us-ascii?Q?9rLO8uQYeCRR1H6xAnFXlBvcGE3MffE2PI/G4C7BxFb/ml5AUq14wGqLFflP?=
 =?us-ascii?Q?qMgCP4wu77araT428ETq1N3j5zNA+xZJiH+PeUHMX7cUDGxV5zf/fSNtGUNg?=
 =?us-ascii?Q?kLKuvV2ZE8LRFU6K9bzzHktOP54jJMiOf6NEl28b0jXCk2t/dHzDGzyF6gYs?=
 =?us-ascii?Q?Eyv88ZBUCTqjnJBDFNZruCS2lePMcGpfk71LBYIGryoM6Esal0gAWcOBJWvo?=
 =?us-ascii?Q?RpzXlhaHOZFt0gjnbjEBFuXg45iNq1mXlOzzlbv5paKc1wMcx4VZ8ddD9eYt?=
 =?us-ascii?Q?3i/lPQ72GEXwGq1R59WPdmkOwZuVw0BwDNfRKtQ5xj0jGZb6EEdXWqzg5k5c?=
 =?us-ascii?Q?wWpqua+iLcBaoa13nBTycGJV3On94Gx/RAZ684vbVA2Nuic2ann5YWWoMgAD?=
 =?us-ascii?Q?IYRFvuWpYRY/bnUrixKVE/4rXU1J7L7CgxeiCIozkpcismMZVwkRZU58XFlF?=
 =?us-ascii?Q?C1P+F4M98crzKKSduF0lNBdU5vmFEaoT6eQE81imODHgiARrF7mYMETDgEXo?=
 =?us-ascii?Q?GmtXi2R48kmnNfrjFpywH2KnCIro3FsyoS+xRs9eTDjUh/W2w1UUvp4JdmiD?=
 =?us-ascii?Q?gHBMoZlnk78wvJT+Jl+WLVwUpgTGwdL5wLkabZiJoFfKCPAkmgmyXcma+j6o?=
 =?us-ascii?Q?Rx/5NppB7ljcObGSzSN0Uvd+4nMqdMbkEKOHwN6I+Xy1TpcCxEYFnOImPNWT?=
 =?us-ascii?Q?oEI3Eiw/+naYBxn+VjsdtOX0Rd4YDeLWdHDMXu8pZ8j7fWSgo+L8cAIx/8c9?=
 =?us-ascii?Q?G8Xxib65M980ZobvgYJK12VZ7FEodo6d3aIwkJN21ddAIaRLBGXYggKj4OjB?=
 =?us-ascii?Q?EdWwE39TINQxxl8E5vogW0AYbZAy5oJ7FrtFG7TNqAzsePIwUQT3CVJR9Ets?=
 =?us-ascii?Q?Fch70ZUfo5IpH7i4zFnVfVbFOdKt2nkR/3NpE9QGNt/anjSWyV8kAd30qhfX?=
 =?us-ascii?Q?ID2/2ru8yWOp3m0nhX4PANSo/+qvVDQD4+86+OLYv9fKVqm8EE6vOCVt2LCb?=
 =?us-ascii?Q?9QpgOXc2drd+ick7BW4VhR3t3GqnzMfkUCyw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 06:11:45.6874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e594e7c4-ffb6-45a2-a097-08ddf1c34061
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346
Received-SPF: permerror client-ip=40.107.223.69;
 envelope-from=Lingshan.Zhu@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Sep 2025 09:24:40 -0400
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

This commit implements suspend and resume
facility of virtio data-plane according to the new spec changes,
and a reference design on virtio-net.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 hw/net/virtio-net.c                           | 115 ++++++++++++++++++
 hw/virtio/virtio.c                            |   8 ++
 .../standard-headers/linux/virtio_config.h    |   6 +
 3 files changed, 129 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6b5b5dace3..5989349d2b 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -382,6 +382,109 @@ static void virtio_net_drop_tx_queue_data(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
+static void virtio_net_suspend_dataplane(VirtIONet *n)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    VirtIONetQueue *q;
+    NetClientState *nc;
+    int queue_pairs, cvq, i;
+
+    // suspend vhost
+    if (n->vhost_started) {
+        queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
+        cvq = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ) ?
+              n->max_ncs - n->max_queue_pairs : 0;
+
+        vhost_net_stop(vdev, n->nic->ncs, queue_pairs, cvq);
+        n->vhost_started = 0;
+    }
+
+    // suspend qemu emulated queues
+    for (i = 0; i < n->max_queue_pairs; i++) {
+        q = &n->vqs[i];
+        nc = qemu_get_subqueue(n->nic, i);
+
+        // disable qeueu notifications
+        //virtio_queue_set_notification(q->rx_vq, 0);
+        virtio_queue_set_notification(q->tx_vq, 0);
+
+        // disable timer and BH
+        if (q->tx_timer) {
+            timer_del(q->tx_timer);
+        } else {
+            qemu_bh_cancel(q->tx_bh);
+        }
+        q->tx_waiting = 0;
+
+        // clean queues
+        qemu_purge_queued_packets(nc);
+
+        // clean async transitions
+        if (q->async_tx.elem) {
+            virtqueue_push(q->tx_vq, q->async_tx.elem, 0);
+            virtio_notify(vdev, q->tx_vq);
+            g_free(q->async_tx.elem);
+            q->async_tx.elem = NULL;
+        }
+    }
+}
+
+static int virtio_net_resume_dataplane(VirtIONet *n)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    NetClientState *nc = qemu_get_queue(n->nic);
+    VirtIONetQueue *q;
+    NetClientState *qnc;
+    int queue_pairs, cvq, i, r;
+
+    if (!(vdev->status & VIRTIO_CONFIG_S_SUSPEND))
+        return -1;
+
+    // resume vhost
+    if (get_vhost_net(nc->peer)) {
+        queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
+        cvq = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ) ?
+              n->max_ncs - n->max_queue_pairs : 0;
+        r = vhost_net_start(vdev, n->nic->ncs, queue_pairs, cvq);
+        if (r < 0) {
+            error_report("unable to start vhost net: %d", r);
+            n->vhost_started = 1;
+
+            return -1;
+        }
+
+        n->vhost_started = 1;
+
+        for (i = 0;  i < queue_pairs; i++) {
+            qnc = qemu_get_subqueue(n->nic, i);
+
+            /* Purge both directions: TX and RX. */
+            qemu_net_queue_purge(qnc->peer->incoming_queue, qnc);
+            qemu_net_queue_purge(qnc->incoming_queue, qnc->peer);
+        }
+    }
+
+    // resume qemu emulated queues
+    if (!n->vhost_started) {
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            q = &n->vqs[i];
+            nc = qemu_get_subqueue(n->nic, i);
+
+            if (q->tx_timer) {
+                timer_mod(q->tx_timer,
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
+            } else {
+                replay_bh_schedule_event(q->tx_bh);
+                virtio_queue_set_notification(q->tx_vq, 1);
+            }
+            // flush packets
+            qemu_flush_queued_packets(nc);
+        }
+    }
+
+    return 0;
+}
+
 static int virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
@@ -389,6 +492,18 @@ static int virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
     int i;
     uint8_t queue_status;
 
+    if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+        (status & VIRTIO_CONFIG_S_SUSPEND) &&
+        (virtio_vdev_has_feature(vdev, VIRTIO_F_SUSPEND))) {
+        virtio_net_suspend_dataplane(n);
+    }
+
+    if ((!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) &&
+        (vdev->status & VIRTIO_CONFIG_S_SUSPEND) &&
+        (status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+        virtio_net_resume_dataplane(n);
+        }
+
     virtio_net_vnet_endian_status(n, status);
     virtio_net_vhost_status(n, status);
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e..e5abbc4601 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2268,6 +2268,14 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
     }
     vdev->status = val;
 
+    /* The driver suspends the device */
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_SUSPEND) &&
+        (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+        (val & VIRTIO_CONFIG_S_SUSPEND)  && !ret) {
+            virtio_set_started(vdev, false);
+            vdev->status &= !VIRTIO_CONFIG_S_DRIVER_OK;
+    }
+
     return ret;
 }
 
diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
index 45be0fa1bc..ba380f2b52 100644
--- a/include/standard-headers/linux/virtio_config.h
+++ b/include/standard-headers/linux/virtio_config.h
@@ -40,6 +40,8 @@
 #define VIRTIO_CONFIG_S_DRIVER_OK	4
 /* Driver has finished configuring features */
 #define VIRTIO_CONFIG_S_FEATURES_OK	8
+/* Driver has suspended the device. */
+#define VIRTIO_CONFIG_S_SUSPEND		16
 /* Device entered invalid state, driver must reset it */
 #define VIRTIO_CONFIG_S_NEEDS_RESET	0x40
 /* We've given up on this device. */
@@ -117,5 +119,9 @@
  * This feature indicates that the device support administration virtqueues.
  */
 #define VIRTIO_F_ADMIN_VQ		41
+/*
+ * This feature indicates that the driver can suspend the device
+ */
+#define VIRTIO_F_SUSPEND		43
 
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
2.51.0


