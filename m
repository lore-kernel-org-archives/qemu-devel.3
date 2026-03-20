Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F1E1098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aiX-0002x6-PX; Fri, 20 Mar 2026 10:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiU-0002w4-NR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiS-0007QA-IX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8YfvV2601039; Fri, 20 Mar 2026 14:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=4pKiP
 N0UZLV3R994mn1SAhPIcdW74P8eqNMb5OK2Yj0=; b=W34XtsnjNMQhq4++lDRns
 GC+eUrt0Ghp263xf2QC57rOtpaCOBF/SLQZWG+fIL4qmTtSF9Ml3iCXm4Q2cQdN7
 kDIV8JkkPl7Vt/o4iZKkIWCegiTiiR7aoHQGaquS8gq+flcffrQqGVPLapPrfhls
 UJlXD7rTXAxjdezWeUwlNa2btx/bbTylfQpQOhA4Y+8Z7Bol6UkcCW6B9jsgepbO
 Sw1g5gDFMzvgYmGjwkwQu3vq61M3VffAKLM2VhfqMBiZUusPTowjY2qfjC8vLk6U
 pbZ1lLctIdVqoaKKeBjvJCvJioq16qK7NrXYVDSyMpDpQMC+NEb9CiJKJNLAjdE3
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x9th3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KDEaMW030672; Fri, 20 Mar 2026 14:20:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb40t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:23 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jb016730;
 Fri, 20 Mar 2026 14:20:22 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-4; Fri, 20 Mar 2026 14:20:22 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 03/14] virtio,virtio-net: virtio-delta VMSD - VQ state
Date: Fri, 20 Mar 2026 14:20:04 +0000
Message-ID: <20260320142015.3856652-4-jonah.palmer@oracle.com>
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
X-Proofpoint-GUID: abe9vLnBy0tzKWjSa2fVzIVBn-jw87Xj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfX5c+7A5zubeMD
 KQ18sgWYZX7wf6rsTXvG7eeLrEVxdtx3uTqR7pLCqQoKsfmr8674WebmDGsnN9oPsav9IFJKAzv
 YeSgV+Ext5wPzpkt7YV25QrJgOpIROoze9IqIu1GZxnf5lYFEMsN7D+vuCBpFgXwtnxFO6BUkis
 Wy/FhOtIP+AhgZm0F8erA080ZkbdrausPi3S11EMweGMy09JGDs5y5VwHxLxPeyjQISKatrSagB
 k3fUt7Bk8bGfjRBWQKLFLOyE0mzumM6N+GrmEJFauEcZnGRR8nqyIWI0Jf5Ri4XomFg+1F4rNIl
 s9TbyT3/QlIt93FwIy0cWM1QOtfYdGuRQJT3wc0rk8f2ALUoI4l0Lb+D5xxoPT4+oV4TYpfj9YM
 q5WH1Nv7Vlcp/GZWKpWOKnurspSntWhtHmx1I8MDHU5aadI/OAOSMSEm4zwRbSgsG+LIkISL833
 yfpQ4H5GZNIIzitBZdA==
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69bd57a8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=5Z4hCT9oO6PqrKkAV_EA:9
X-Proofpoint-ORIG-GUID: abe9vLnBy0tzKWjSa2fVzIVBn-jw87Xj
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce a new virtio VMStateDescription vmstate_virtio_delta for
VirtIODevices.

This parent VMSD will be used by virtio devices that send their state
early (before the stop-and-copy phase) and only need to resend any
state that changed since then. Any data that is re-sent is done during
the stop-and-copy phase, when the source has been paused.

This patch also adds subsections to vmstate_virtio_delta for resyncing a
VirtIODevice's VQs' state. Since it's more likely than not that these
fields changed since they were sent early, we just send their updated
values without checking if they did indeed change.

After loading delta VQ state, re-sync runtime shadow queue indices to the
delta-loaded avail indices and clear signalled_used_valid so runtime
queue bookkeeping stays consistent for both split and packed rings.

Lastly, this new VirtIODevice parent VMSD is registered for a virtio-net
device only if it has its early-mig property enabled.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c        |   2 +
 hw/virtio/virtio.c         | 150 +++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h |   3 +
 3 files changed, 155 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ddd6ed6e62..5d71ad235e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4090,6 +4090,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
             vdev->migration->early_load = false;
 
             vmstate_register_any(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
+            virtio_delta_vmsd_register(vdev);
         }
     }
 }
@@ -4142,6 +4143,7 @@ static void virtio_net_device_unrealize(DeviceState *dev)
         vdev->migration = NULL;
 
         vmstate_unregister(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
+        virtio_delta_vmsd_unregister(vdev);
     }
 }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 48de4a430b..47236bf7d7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2780,6 +2780,13 @@ static bool virtio_virtqueue_needed(void *opaque)
     return virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1);
 }
 
+static bool virtio_split_virtqueue_needed(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    return !virtio_host_has_feature(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static bool virtio_packed_virtqueue_needed(void *opaque)
 {
     VirtIODevice *vdev = opaque;
@@ -2842,6 +2849,18 @@ static const VMStateDescription vmstate_virtqueue = {
     }
 };
 
+static const VMStateDescription vmstate_split_virtqueue = {
+    .name = "split_virtqueue_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(last_avail_idx, struct VirtQueue),
+        VMSTATE_UINT16(used_idx, struct VirtQueue),
+        VMSTATE_UINT32(inuse, struct VirtQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_packed_virtqueue = {
     .name = "packed_virtqueue_state",
     .version_id = 1,
@@ -2856,6 +2875,89 @@ static const VMStateDescription vmstate_packed_virtqueue = {
     }
 };
 
+/*
+ * Temporary type used with VMSTATE_WITH_TMP to migrate
+ * active VQs only for VirtIODevices that participated
+ * in early live migration.
+ */
+typedef struct VirtIOMigVQsTmp {
+    VirtIODevice *parent;
+    VirtQueue *vqs;
+    uint16_t num_vqs;
+} VirtIOMigVQsTmp;
+
+static int virtio_delta_vqs_pre_save(void *opaque)
+{
+    VirtIOMigVQsTmp *tmp = opaque;
+    tmp->vqs = tmp->parent->vq;
+    tmp->num_vqs = virtio_get_num_queues(tmp->parent);
+    return 0;
+}
+
+static int virtio_delta_vqs_pre_load(void *opaque)
+{
+    VirtIOMigVQsTmp *tmp = opaque;
+    uint16_t num_vqs = virtio_get_num_queues(tmp->parent);
+
+    tmp->vqs = tmp->parent->vq;
+    tmp->num_vqs = num_vqs;
+
+    if (tmp->num_vqs > VIRTIO_QUEUE_MAX) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
+/* Re-sync runtime shadow queue indices with final delta-loaded indices */
+static int virtio_delta_vqs_post_load(void *opaque, int version_id)
+{
+    VirtIOMigVQsTmp *tmp = opaque;
+    bool packed = virtio_vdev_has_feature(tmp->parent, VIRTIO_F_RING_PACKED);
+    int i;
+
+    for (i = 0; i < tmp->num_vqs; i++) {
+        VirtQueue *vq = &tmp->vqs[i];
+
+        if (!vq->vring.desc) {
+            continue;
+        }
+
+        vq->shadow_avail_idx = vq->last_avail_idx;
+        if (packed) {
+            vq->shadow_avail_wrap_counter = vq->last_avail_wrap_counter;
+        }
+        vq->signalled_used_valid = false;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_virtio_delta_split_vqs_tmp = {
+    .name = "virtio-delta/split_vqs_tmp",
+    .pre_save = virtio_delta_vqs_pre_save,
+    .pre_load = virtio_delta_vqs_pre_load,
+    .post_load = virtio_delta_vqs_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT16(vqs, VirtIOMigVQsTmp, num_vqs,
+                                             vmstate_split_virtqueue,
+                                             VirtQueue),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_virtio_delta_packed_vqs_tmp = {
+    .name = "virtio-delta/packed_vqs_tmp",
+    .pre_save = virtio_delta_vqs_pre_save,
+    .pre_load = virtio_delta_vqs_pre_load,
+    .post_load = virtio_delta_vqs_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT16(vqs, VirtIOMigVQsTmp, num_vqs,
+                                             vmstate_packed_virtqueue,
+                                             VirtQueue),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_virtio_virtqueues = {
     .name = "virtio/virtqueues",
     .version_id = 1,
@@ -3053,6 +3155,54 @@ static const VMStateDescription vmstate_virtio = {
     }
 };
 
+static const VMStateDescription vmstate_virtio_delta_split_virtqueues = {
+    .name = "virtio-delta/split_virtqueues",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_split_virtqueue_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_WITH_TMP(VirtIODevice, VirtIOMigVQsTmp,
+                         vmstate_virtio_delta_split_vqs_tmp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_virtio_delta_packed_virtqueues = {
+    .name = "virtio-delta/packed_virtqueues",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_packed_virtqueue_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_WITH_TMP(VirtIODevice, VirtIOMigVQsTmp,
+                         vmstate_virtio_delta_packed_vqs_tmp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_virtio_delta = {
+    .name = "virtio-delta",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_virtio_delta_split_virtqueues,
+        &vmstate_virtio_delta_packed_virtqueues,
+        NULL
+    }
+};
+
+void virtio_delta_vmsd_register(VirtIODevice *vdev)
+{
+    vmstate_register_any(VMSTATE_IF(vdev), &vmstate_virtio_delta, vdev);
+}
+
+void virtio_delta_vmsd_unregister(VirtIODevice *vdev)
+{
+    vmstate_unregister(VMSTATE_IF(vdev), &vmstate_virtio_delta, vdev);
+}
+
 int virtio_save(VirtIODevice *vdev, QEMUFile *f)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 4c886eb48b..74fed8c324 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -305,6 +305,9 @@ int virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
+void virtio_delta_vmsd_register(VirtIODevice *vdev);
+void virtio_delta_vmsd_unregister(VirtIODevice *vdev);
+
 int virtio_save(VirtIODevice *vdev, QEMUFile *f);
 
 extern const VMStateInfo virtio_vmstate_info;
-- 
2.51.0


