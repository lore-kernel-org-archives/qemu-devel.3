Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6150DC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 13:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEtq-0004GG-4O; Wed, 14 Feb 2024 08:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEt6-0003kL-VS
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:01:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEt4-0007ou-VN
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:01:20 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EBlfNL019286; Wed, 14 Feb 2024 13:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=wcldqlJ0WkgHTEBFlI+FRx8WnhlS1lDT2rZR+pTlAWU=;
 b=KKrxSy7seIvAEoXSzydJ7CN4OIgSslNYeBOHdoM0mg27/Z+i7HPiiax0zxZRn3olCG2B
 1DIFTRWKh+xRXjZtowaBgH5WKIHF7l/o7bh1oGu0ynpfesjCA0lrbB+U+Z+vX2ttOHIN
 4uGh9VgaUO9PKZfuSMun1tQsbams8j7tpYy4Ll/cDAVguy5o7A+2OBx8F3MBvC3rDmNr
 7BKjdI72P6k1QPTe8+VQXoDW9LZnnEnJdsdamhdqVWLwcforfD9RkjHqHDaCLJZPux9A
 AmXAy/fa0wrc+rp7Nw9M4NU3XyWk0b0e8AYuFhqZF35YiudsEtu4zrbwySVp+IIFk8SH kQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8varg702-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 13:01:17 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41EBM87Z024673; Wed, 14 Feb 2024 13:01:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5ykf6exg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 13:01:16 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41ED1FUm027943;
 Wed, 14 Feb 2024 13:01:16 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3w5ykf6ewh-2; Wed, 14 Feb 2024 13:01:16 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, joao.m.martins@oracle.com,
 si-wei.liu@oracle.com
Subject: [PATCH v2 2/2] vhost: Perform memory section dirty scans once per
 iteration
Date: Wed, 14 Feb 2024 03:50:19 -0800
Message-Id: <1707911419-11758-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1707911419-11758-1-git-send-email-si-wei.liu@oracle.com>
References: <1707911419-11758-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140099
X-Proofpoint-GUID: Ae-SrAcoULu7DvGG6xuof3Ow33LaAlUM
X-Proofpoint-ORIG-GUID: Ae-SrAcoULu7DvGG6xuof3Ow33LaAlUM
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On setups with one or more virtio-net devices with vhost on,
dirty tracking iteration increases cost the bigger the number
amount of queues are set up e.g. on idle guests migration the
following is observed with virtio-net with vhost=on:

48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14

With high memory rates the symptom is lack of convergence as soon
as it has a vhost device with a sufficiently high number of queues,
the sufficient number of vhost devices.

On every migration iteration (every 100msecs) it will redundantly
query the *shared log* the number of queues configured with vhost
that exist in the guest. For the virtqueue data, this is necessary,
but not for the memory sections which are the same. So
essentially we end up scanning the dirty log too often.

To fix that, select a vhost device responsible for scanning the
log with regards to memory sections dirty tracking. It is selected
when we enable the logger (during migration) and cleared when we
disable the logger. If the vhost logger device goes away for some
reason, the logger will be re-selected from the rest of vhost
devices.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost.c         | 75 +++++++++++++++++++++++++++++++++++++++++++----
 include/hw/virtio/vhost.h |  1 +
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ef6d9b5..997d560 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -45,6 +45,9 @@
 
 static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
 static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
+static struct vhost_dev *vhost_mem_logger[VHOST_BACKEND_TYPE_MAX];
+static QLIST_HEAD(, vhost_dev) vhost_mlog_devices =
+    QLIST_HEAD_INITIALIZER(vhost_mlog_devices);
 
 /* Memslots used by backends that support private memslots (without an fd). */
 static unsigned int used_memslots;
@@ -149,6 +152,53 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
     }
 }
 
+static bool vhost_log_dev_enabled(struct vhost_dev *dev)
+{
+    assert(dev->vhost_ops);
+    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
+    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
+
+    return dev == vhost_mem_logger[dev->vhost_ops->backend_type];
+}
+
+static void vhost_mlog_set_dev(struct vhost_dev *hdev, bool enable)
+{
+    struct vhost_dev *logdev = NULL;
+    VhostBackendType backend_type;
+    bool reelect = false;
+
+    assert(hdev->vhost_ops);
+    assert(hdev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
+    assert(hdev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
+
+    backend_type = hdev->vhost_ops->backend_type;
+
+    if (enable && !QLIST_IS_INSERTED(hdev, logdev_entry)) {
+        reelect = !vhost_mem_logger[backend_type];
+        QLIST_INSERT_HEAD(&vhost_mlog_devices, hdev, logdev_entry);
+    } else if (!enable && QLIST_IS_INSERTED(hdev, logdev_entry)) {
+        reelect = vhost_mem_logger[backend_type] == hdev;
+        QLIST_REMOVE(hdev, logdev_entry);
+    }
+
+    if (!reelect)
+        return;
+
+    QLIST_FOREACH(hdev, &vhost_mlog_devices, logdev_entry) {
+        if (!hdev->vhost_ops ||
+            hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_NONE ||
+            hdev->vhost_ops->backend_type >= VHOST_BACKEND_TYPE_MAX)
+            continue;
+
+        if (hdev->vhost_ops->backend_type == backend_type) {
+            logdev = hdev;
+            break;
+        }
+    }
+
+    vhost_mem_logger[backend_type] = logdev;
+}
+
 static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
                                    MemoryRegionSection *section,
                                    hwaddr first,
@@ -166,12 +216,14 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
     start_addr = MAX(first, start_addr);
     end_addr = MIN(last, end_addr);
 
-    for (i = 0; i < dev->mem->nregions; ++i) {
-        struct vhost_memory_region *reg = dev->mem->regions + i;
-        vhost_dev_sync_region(dev, section, start_addr, end_addr,
-                              reg->guest_phys_addr,
-                              range_get_last(reg->guest_phys_addr,
-                                             reg->memory_size));
+    if (vhost_log_dev_enabled(dev)) {
+        for (i = 0; i < dev->mem->nregions; ++i) {
+            struct vhost_memory_region *reg = dev->mem->regions + i;
+            vhost_dev_sync_region(dev, section, start_addr, end_addr,
+                                  reg->guest_phys_addr,
+                                  range_get_last(reg->guest_phys_addr,
+                                                 reg->memory_size));
+        }
     }
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
@@ -382,6 +434,7 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
         g_free(log);
     }
 
+    vhost_mlog_set_dev(dev, false);
     dev->log = NULL;
     dev->log_size = 0;
 }
@@ -997,6 +1050,15 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
             goto err_vq;
         }
     }
+
+    /*
+     * At log start we select our vhost_device logger that will scan the
+     * memory sections and skip for the others. This is possible because
+     * the log is shared amongst all vhost devices for a given type of
+     * backend.
+     */
+    vhost_mlog_set_dev(dev, enable_log);
+
     return 0;
 err_vq:
     for (; i >= 0; --i) {
@@ -2072,6 +2134,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
             VHOST_OPS_DEBUG(r, "vhost_set_log_base failed");
             goto fail_log;
         }
+        vhost_mlog_set_dev(hdev, true);
     }
     if (vrings) {
         r = vhost_dev_set_vring_enable(hdev, true);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 0247778..d75faf4 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -129,6 +129,7 @@ struct vhost_dev {
     void *opaque;
     struct vhost_log *log;
     QLIST_ENTRY(vhost_dev) entry;
+    QLIST_ENTRY(vhost_dev) logdev_entry;
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
     const VhostDevConfigOps *config_ops;
-- 
1.8.3.1


