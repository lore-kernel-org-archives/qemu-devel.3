Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616A11098788
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3anP-0000PQ-8r; Fri, 20 Mar 2026 10:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3anL-0000P7-ID
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:25:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3anI-0008Cf-QU
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:25:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8Y3bP2600046; Fri, 20 Mar 2026 14:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=11O1n
 lIAbwkDq0XsRmbItWfRrNrfkL+vYhFfZeFFKIE=; b=J8IuqtpFb4ZZ42H8T18nd
 VNLDIrZ4WU2L0XGGisRZQF0yOpgTYij8Qdpv3RbWJfnRClVqJ8wXt/cBapI6v3ge
 hMX9in6TJVGSZx4L8AFu1M2MRj/RUTSUH7uwgVE4X8iGwgUpOwkXMtr5BRLcA0dn
 OwbPyEVax5HK8NK2Pk5cr4uGjDq8b5aTOt8UQZcyvPzRPT2Lobf5SUNfhUpvoCmf
 P4ttipcpM7fozcv+K6OL8jJARFGqV2njJEiaq+1vJzmt/9z0EGeCemi2MBDAT3QS
 Th7V0BrVX+oGD7o6eVK5e8BWlMu9KcHBET7aEmg/9eVT+UeH7ubjiJr+WCoOxSX1
 w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x9th0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KCi27c030664; Fri, 20 Mar 2026 14:20:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb3yf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2JZ016730;
 Fri, 20 Mar 2026 14:20:21 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-3; Fri, 20 Mar 2026 14:20:21 +0000
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 02/14] virtio,
 virtio-net: add initial early VMSD for setup-phase migration
Date: Fri, 20 Mar 2026 14:20:03 +0000
Message-ID: <20260320142015.3856652-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320142015.3856652-1-jonah.palmer@oracle.com>
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200114
X-Proofpoint-GUID: T4Kn0Sbe6OIZqz5paG60HduzP2ce9Ftr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfX3vf6EZP7WzT3
 9xJSWJIPO2RIqY6zo4ZuHxDOtwPqSdGfO6OpQFHn3wXQv2ycZOzUZ032+uDApguk0G8MrGKOM73
 jkDInwEWMGLXVANk1tmsGylPjFN//T/G7ibsoo/aOUG6WobQAcRTbdXVYVCtq5uVtQtEht1PWGV
 OW2Eit+pEYZkV9zJ5yr8yyGs9y6cJz9wGYfgeWHkvbTle9xdYkAovnzy1kAqv2PeQsh1O0igbOl
 hGHBV1ZWeZ54BnIuk5WsbEgbU65esRVEphf94+1l5FWLzEP8JiGrGmReMAfwvpg1z5/8KA6oPRq
 VGvGaHJuki/W7+Lcrij8ga6h05EZXTNNTS1aTwYIILYdA/YJavA0XzVXBPYg6O9sXATh36WbAvp
 e3BRgsraeIIBnzts8WYzYW5k5344FCV6dhK4UOvs+NihFwR/R1UKxi0rA5iO+TX0p5d8zSHTbFT
 dJ7A3vViPEIgYgvKTYw==
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69bd57a7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=n8FzOVadAr_i4xXxhBoA:9
X-Proofpoint-ORIG-GUID: T4Kn0Sbe6OIZqz5paG60HduzP2ce9Ftr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Jonah Palmer <jonah.palmer@oracle.com>
From:  Jonah Palmer via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds a separate VMStateDescription for virtio-net that uses the
.early_setup feature. With this feature, we can migrate a virtio-net
device's state earlier, before the stop-and-copy phase.

Future patches will utilize this to move control plane operations out of
the stop-and-copy phase to reduce the downtime latency caused by
migrating a virtio-net device.

A VirtIODevMigration migration data structure is also introduced here
for VirtIODevices to help track the current state of a migration.

The early_load member is used to signal that a VirtIODevice is being
loaded early and to not throw an error regarding vring indices.
Inconsistent indices shouldn't be an issue for a device so long as the
final indices are eventually loaded before the device starts.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c        | 53 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio.c         | 14 +++++++++-
 include/hw/virtio/virtio.h |  9 +++++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 12b3456ca2..ddd6ed6e62 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3864,6 +3864,37 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     return qatomic_read(&n->failover_primary_hidden);
 }
 
+static int virtio_net_early_pre_load(void *opaque)
+{
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    vdev->migration->early_load = true;
+    return 0;
+}
+
+static int virtio_net_early_post_load(void *opaque, int version_id)
+{
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    vdev->migration->early_load = false;
+    return 0;
+}
+
+static const VMStateDescription vmstate_virtio_net_early = {
+    .name = "virtio-net-early",
+    .minimum_version_id = VIRTIO_NET_VM_VERSION,
+    .version_id = VIRTIO_NET_VM_VERSION,
+    .early_setup = true,
+    .pre_load = virtio_net_early_pre_load,
+    .post_load = virtio_net_early_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -4046,6 +4077,21 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
             n->rss_data.specified_hash_types.on_bits |
             n->rss_data.specified_hash_types.auto_bits;
     }
+
+    if (n->early_mig) {
+        if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
+            /*
+             * vhost-user backend is not currently supported for the early
+             * migration path.
+             */
+            n->early_mig = false;
+        } else {
+            vdev->migration = g_new0(VirtIODevMigration, 1);
+            vdev->migration->early_load = false;
+
+            vmstate_register_any(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
+        }
+    }
 }
 
 static void virtio_net_device_unrealize(DeviceState *dev)
@@ -4090,6 +4136,13 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     g_free(n->rss_data.indirections_table);
     net_rx_pkt_uninit(n->rx_pkt);
     virtio_cleanup(vdev);
+
+    if (n->early_mig) {
+        g_free(vdev->migration);
+        vdev->migration = NULL;
+
+        vmstate_unregister(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
+    }
 }
 
 static void virtio_net_reset(VirtIODevice *vdev)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8fcf6cfd0b..48de4a430b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3323,6 +3323,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     int32_t config_len;
     uint32_t num;
     uint32_t features;
+    bool inconsistent_indices;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
@@ -3460,6 +3461,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
 
+            /*
+             * Ring indices will be inconsistent for a VMStateDescription
+             * performing an early load. This shouldn't be an issue as the
+             * final indices will get sent later once the source has been
+             * stopped.
+             */
+            inconsistent_indices = vdev->migration && vdev->migration->early_load;
+
             /*
              * VIRTIO-1 devices migrate desc, used, and avail ring addresses so
              * only the region cache needs to be set up.  Legacy devices need
@@ -3481,12 +3490,15 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
-            if (nheads > vdev->vq[i].vring.num) {
+            if (!inconsistent_indices && nheads > vdev->vq[i].vring.num) {
                 virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
                              "inconsistent with Host index 0x%x: delta 0x%x",
                              i, vdev->vq[i].vring.num,
                              vring_avail_idx(&vdev->vq[i]),
                              vdev->vq[i].last_avail_idx, nheads);
+                inconsistent_indices = true;
+            }
+            if (inconsistent_indices) {
                 vdev->vq[i].used_idx = 0;
                 vdev->vq[i].shadow_avail_idx = 0;
                 vdev->vq[i].inuse = 0;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 6344bd7b68..4c886eb48b 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -99,6 +99,14 @@ enum virtio_device_endian {
     VIRTIO_DEVICE_ENDIAN_BIG,
 };
 
+/**
+ * struct VirtIODevMigration - Common VirtIODevice migration structure
+ * @early_load: Flag to indicate an early virtio_load for the device.
+ */
+typedef struct VirtIODevMigration {
+    bool early_load;
+} VirtIODevMigration;
+
 /**
  * struct VirtIODevice - common VirtIO structure
  * @name: name of the device
@@ -168,6 +176,7 @@ struct VirtIODevice
      */
     EventNotifier config_notifier;
     bool device_iotlb_enabled;
+    VirtIODevMigration *migration;
 };
 
 struct VirtioDeviceClass {
-- 
2.51.0


