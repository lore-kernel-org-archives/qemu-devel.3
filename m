Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8961098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aia-0002y9-A6; Fri, 20 Mar 2026 10:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiV-0002wI-St
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiS-0007QH-PJ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8YO2i3950545; Fri, 20 Mar 2026 14:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=u0Cek
 u5uwY3Rhyqmj+7G8YPzYEyaStJkZcVRk2j5kng=; b=rIkyGOFwjQ2Yo/4RLpIIc
 uadqLmgHnXUu2j+T55B9p1anOUp79kogWfYczBOBP1yPTIqV4WfWKBDqSo01jTCn
 JaWIhkPedyAb+EzaJzPpweYMphBRAV5Zp/vT6wLhBdZ2w4nI+0Ei1FWzCSLI0rkT
 zj19adOJ2n89Rz1g+qNhIzQ0xQ4O+9BfSU66ebLHzfz0OknW+Y+5gCVwNXlAbULY
 qr45aDahd6T+FgHfCPNPIqBZmGWdm2IfKBL31I16xB0reX4tzzj/9/G/NY1p0tQb
 FdVUU7+pZJZN0hOJVL+f/OUQxtdeQkATuVOmTK3RcW2SVW0y5XgCgfob47HXltbG
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9s1kgm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KCoWWF030490; Fri, 20 Mar 2026 14:20:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb464-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:32 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jh016730;
 Fri, 20 Mar 2026 14:20:31 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-7; Fri, 20 Mar 2026 14:20:31 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 06/14] virtio-net: detect VirtIONet MAC addr mid-migration
 change
Date: Fri, 20 Mar 2026 14:20:07 +0000
Message-ID: <20260320142015.3856652-7-jonah.palmer@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69bd57b1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=9wsuJtwwkntus7d062oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfXyyFzzK7o/aBO
 3KQXYq37R7JjW4bTVqd7R2C8qfza03KtRDB4/JlHQNjFoTI2RxS03q+eS/qUCoWeYpbgswLe/R/
 E4DobyzYWovLnLddn/jsSL1E3RBUcqEdCsDpgBvUqnN+EylDSoiHEJX8IedTBMVCrNzlS4VD9Lj
 +wdY4JCqgaH4ifz/Gy9hCalXNoX+5y5ckxxXKRJ/nyfbvHZpqySThGThlX3AEcIsS/TT1h654W2
 Ktre2lEWg/Mdd0l+ivI8Dj1kzZPBO8wDOakDlmHSVRN7QLe8yYDrscOcr6wNniXgcqugOuoyvMM
 oXEFBr0FTpLJBwWt3haeMxeZ6HrC2L4r8uVw2mmIoCylTAzbNXyo+B1xnmy/TDCEnysbxSSOrGN
 TBp5fWEFGyNJLL4MBmRxuA+KlKltHgSFYbq7p1xEl+Z0x7zhCyNdGBe9OfORULS+xKjsEmwXHIs
 pDeomjxOf19fJTaCweQ==
X-Proofpoint-GUID: p0YQkDncQrnu9JJj-q7vy6oDV1X4PGEC
X-Proofpoint-ORIG-GUID: p0YQkDncQrnu9JJj-q7vy6oDV1X4PGEC
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch saves the virtio-net device's MAC address to compare with
later during the stop-and-copy phase.

Also introduce VirtIONetMigration, a per-device migration scratch
structure used to store early snapshots of VirtIONet state for later
delta comparison.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c            | 15 +++++++++++++++
 include/hw/virtio/virtio-net.h |  9 +++++++++
 2 files changed, 24 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ca4385df1a..4f14bba510 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3869,6 +3869,7 @@ static int virtio_net_early_pre_save(void *opaque)
     VirtIONet *n = opaque;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     VirtIODevMigration *vdev_mig = vdev->migration;
+    VirtIONetMigration *vnet_mig = n->migration;
 
     vdev_mig->status_early = vdev->status;
 
@@ -3880,6 +3881,10 @@ static int virtio_net_early_pre_save(void *opaque)
     } else {
         vdev_mig->config_early = NULL;
     }
+
+    /* VirtIONet MAC info snapshot */
+    memcpy(vnet_mig->mac_early, n->mac, ETH_ALEN);
+
     return 0;
 }
 
@@ -4108,6 +4113,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         } else {
             vdev->migration = g_new0(VirtIODevMigration, 1);
             vdev->migration->early_load = false;
+            n->migration = g_new0(VirtIONetMigration, 1);
 
             vmstate_register_any(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
             virtio_delta_vmsd_register(vdev);
@@ -4165,6 +4171,9 @@ static void virtio_net_device_unrealize(DeviceState *dev)
         g_free(vdev->migration);
         vdev->migration = NULL;
 
+        g_free(n->migration);
+        n->migration = NULL;
+
         vmstate_unregister(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
         virtio_delta_vmsd_unregister(vdev);
     }
@@ -4257,6 +4266,7 @@ static bool dev_unplug_pending(void *opaque)
 static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
 {
     VirtIODevMigration *vdev_mig = vdev->migration;
+    VirtIONetMigration *vnet_mig = n->migration;
 
     /* Has the VirtIODevice's status changed? */
     if (vdev->status != vdev_mig->status_early) {
@@ -4272,6 +4282,11 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
         return true;
     }
 
+    /* Has the VirtIONet's MAC info changed? */
+    if (memcmp(n->mac, vnet_mig->mac_early, ETH_ALEN) != 0) {
+        return true;
+    }
+
     /*
      * Always return true for now until we're able to detect all possible
      * changes to a VirtIONet device.
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index ddb141fefc..280155366c 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -167,8 +167,17 @@ typedef struct VirtIONetQueue {
     struct VirtIONet *n;
 } VirtIONetQueue;
 
+/**
+ * struct VirtIONetMigration - VirtIONet migration structure
+ * @mac_early: MAC address early migration snapshot.
+ */
+typedef struct VirtIONetMigration {
+    uint8_t mac_early[ETH_ALEN];
+} VirtIONetMigration;
+
 struct VirtIONet {
     VirtIODevice parent_obj;
+    VirtIONetMigration *migration;
     uint8_t mac[ETH_ALEN];
     uint16_t status;
     VirtIONetQueue *vqs;
-- 
2.51.0


