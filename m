Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356341098788
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aiZ-0002xz-Si; Fri, 20 Mar 2026 10:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiX-0002wn-5F
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w3aiU-0007QL-OP
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:20:48 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K8Y3OH3323029; Fri, 20 Mar 2026 14:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=gjr6X
 6FjLOGEcEwKsJNBVN5o5O7x2XraQbiJzpXv154=; b=J7XLN43yJByLpY61H20lh
 Yn90q1t2zuD7r9Y/qss0Ul040frInlOCgC1m+bT5Op4vPBziOvADd0cJOUoGA3RU
 5P8pZbTFiqmyCT6qTi6RU2UtBpjrnnn7Hq3vX65RwtJ9oD9eRvGC8+fZkIj4fRgY
 m/+knvA9P+hKtkqMhApE7bwcr7NmE2qsPzcLsL9qb6oJbV1PIBLPht3HUPJ5rEo/
 3/SrDmZ6iPVBJBA8k0E5jl/d0aw8+xiIi8s/VTxrz+qdWZBXFGB9+fHaRL6xLvNc
 BenlqmIMjS14XEfjppihsyqZvP48Xj3L7ddC1DE8AKvHZCo7wvU34N3U/Y65NeRc
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8htjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62KDoNif030576; Fri, 20 Mar 2026 14:20:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4eb44d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 14:20:28 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62KEK2Jd016730;
 Fri, 20 Mar 2026 14:20:28 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cvx4eb3ue-5; Fri, 20 Mar 2026 14:20:28 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, jonah.palmer@oracle.com
Subject: [RFC v2 04/14] virtio-net: detect VirtIODevice status mid-migration
 change
Date: Fri, 20 Mar 2026 14:20:05 +0000
Message-ID: <20260320142015.3856652-5-jonah.palmer@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExNCBTYWx0ZWRfX3u40vBUkEWlC
 qWI3mSxS7+eaID9dEKs1HyJG3Z1BWl8jwybKNBDjjSoG8hFK2VV3mxGPHBAscFR1SAI4qlrYeKQ
 FqHVi6emQ286kwC+Mfpsg4vfqOnJTuNKs2r5d4tJb3XUw1mUoQIFYwQhKymza7GUnr72oBJZ0ws
 1/zXtmeqn95rnpfjdTxI4mGOenm0uPhfAhJSfBGbSkrCjNh5As10YpLdMpzyUYXx2XhhBLJKy3V
 AL82zwC6RiW4+JAN44ZjidfIUhWZZ5R4f2R8lyEXuNh040YABasCj6BfwnLnTvfDEI72gTZ0zja
 IvdX227Hxy65CecY/2wewG5mZ+xrkLIril93OWla99Xqdy1y8o3xFRPHxlvvJ4S+3g4Dmvpbh2T
 oJZPveiIsE7FL+VihQN/uLEeBOCIEWi6sA6Cr2dW6/cqcOketEmjvJu8HVNmgZoCfqqsGutixQq
 i0LbK/+qhWfQSjCS31A==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69bd57ad b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=3r8ui8mxyQxcokH5ohsA:9
X-Proofpoint-GUID: SPzg3wI3BoN1i1W-kmlVJ-2P1y3qFRMv
X-Proofpoint-ORIG-GUID: SPzg3wI3BoN1i1W-kmlVJ-2P1y3qFRMv
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

This patch introduces the mechanism in which this series will use to
detect VirtIODevice & VirtIONet state deltas, starting with the
VirtIODevice's 'status' member of a virtio-net device.

Before we send the device's state early, we save each piece of its state
in a temporary structure via virtio_net_early_pre_save. Later, once the
source VM has been paused, we compare the current values of those pieces
to what we saved earlier. If any mismatch is found, virtio-net's VMSD
(vmstate_virtio_net) is enabled and resends all state and device prep
work (as it's normally done today when live migrating a virtio-net
device).

Once all relevant delta checks are in place, a no-delta case will skip
vmstate_virtio_net and only resend updated VQ indices.

For this patch, keep a temporary always-true fallback in
virtio_net_has_delta/virtio_net_needed until follow-up patches cover the
remaining VirtIONet & VirtIODevice deltas.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c        | 40 ++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5d71ad235e..2733e0130c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3864,6 +3864,16 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     return qatomic_read(&n->failover_primary_hidden);
 }
 
+static int virtio_net_early_pre_save(void *opaque)
+{
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    VirtIODevMigration *vdev_mig = vdev->migration;
+
+    vdev_mig->status_early = vdev->status;
+    return 0;
+}
+
 static int virtio_net_early_pre_load(void *opaque)
 {
     VirtIONet *n = opaque;
@@ -3887,6 +3897,7 @@ static const VMStateDescription vmstate_virtio_net_early = {
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
     .version_id = VIRTIO_NET_VM_VERSION,
     .early_setup = true,
+    .pre_save = virtio_net_early_pre_save,
     .pre_load = virtio_net_early_pre_load,
     .post_load = virtio_net_early_post_load,
     .fields = (const VMStateField[]) {
@@ -4231,10 +4242,39 @@ static bool dev_unplug_pending(void *opaque)
     return vdc->primary_unplug_pending(dev);
 }
 
+static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
+{
+    VirtIODevMigration *vdev_mig = vdev->migration;
+
+    /* Has the VirtIODevice's status changed? */
+    if (vdev->status != vdev_mig->status_early) {
+        return true;
+    }
+
+    /*
+     * Always return true for now until we're able to detect all possible
+     * changes to a VirtIONet device.
+     */
+    return true;
+}
+
+static bool virtio_net_needed(void *opaque)
+{
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    if (!n->early_mig) {
+        return true;
+    }
+
+    return virtio_net_has_delta(n, vdev);
+}
+
 static const VMStateDescription vmstate_virtio_net = {
     .name = "virtio-net",
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
     .version_id = VIRTIO_NET_VM_VERSION,
+    .needed = virtio_net_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 74fed8c324..752c46ce53 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -102,9 +102,11 @@ enum virtio_device_endian {
 /**
  * struct VirtIODevMigration - Common VirtIODevice migration structure
  * @early_load: Flag to indicate an early virtio_load for the device.
+ * @status_early: Device status at the time it was sent early.
  */
 typedef struct VirtIODevMigration {
     bool early_load;
+    uint8_t status_early;
 } VirtIODevMigration;
 
 /**
-- 
2.51.0


