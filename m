Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4ADC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueCKl-0003V9-Io; Tue, 22 Jul 2025 08:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJQ-0002Ld-8A
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJL-0006KK-Fo
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:39 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TCVY006880;
 Tue, 22 Jul 2025 12:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=mTAkC
 kg5NAr+U2BQKhXP4vrQ5SSm+w/ZkB8cpu8ucqg=; b=Sr1yqCfpxA+8tmpIoa+M+
 ci/wx/UOLEB9E9mxgrsAAQnGfjBKJWWLxqvfk8h/dNN3hmP6104kC6E22YZkzgvA
 oz04QjLQJ57otU047clRhBMZecp5lCUZuKrGCTKJxdWafmwbsNdJo07ChdWno3io
 +J/s84cCuJL7MliCgpc6gQuffOAF7buNjn85kf99dE0d2jZO5lgW4WtpOuZMAWzu
 ptoc3Ppu0fdb70/IdSNAlWQwiq18uAVV1lNYrVDfysh/aD4ZIIMD/VJqzEVxUASR
 +wziQTDajmKAzN8lLvxv1STvP8b8auuQGNjqk3aWGpMAfFzalDm6BS08IH+rgBVb
 w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2d2p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56MBf90X010337; Tue, 22 Jul 2025 12:41:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4801t99gb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:32 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56MCfT3r039536;
 Tue, 22 Jul 2025 12:41:32 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4801t99g9h-3; Tue, 22 Jul 2025 12:41:32 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 jasowang@redhat.com, mst@redhat.com, si-wei.liu@oracle.com,
 eperezma@redhat.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 2/6] virtio-net: Reorder vmstate_virtio_net and helpers
Date: Tue, 22 Jul 2025 12:41:23 +0000
Message-ID: <20250722124127.2497406-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250722124127.2497406-1-jonah.palmer@oracle.com>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220104
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687f86fd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=Su2gMDwvtMPhgmBzyZ4A:9
X-Proofpoint-GUID: xUTt2it9AJpkryHbhhZzSjwf3L0gGEq_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEwNCBTYWx0ZWRfX4bhky5bqli0E
 bS429T/LqkVW9q/wgc4y8CkbV17MHl34sg34hU9uiaFx9JetLDIJgJIM6qb9Whp7fvYnUgSnmjx
 c9VQXePx6IVD45aHI6q1GQH1P9FDGZH5vzCE9IOvh36TOYLiaD46hktkUcSMpLqKznbOvpSgllm
 KaP0OA+flBsKRlOFYPtRgdMpUlVNmqoZMB9PpncQGlRe0sIBm4JZr0x+Pg++wN7gVNLipkt3a1v
 3oALySrMeJMqeumhCHO4pCt5H4Y81I8N3ByJTLTkvimF6gchv4B6xhyh5qqRK30KmMB+MV2WShx
 WenYmjbdYKlKVVp+hueUpyNqFCOcLwIHQDAI6hImbwO6Ko5pEGhw3y5of5NZEpSmM/w01oVZ6Gl
 heBya98Zi7DWawlFMDVsRI9c6Bh+EH05yQcfgSRbRLsy0cdnzmAb1PtICQlTAO7T+JS4+Pt4
X-Proofpoint-ORIG-GUID: xUTt2it9AJpkryHbhhZzSjwf3L0gGEq_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reordering makes the vmstate_virtio_net available for use by future
virtio-net SaveVMHandlers hooks that will need to be placed before
virtio_net_device_realize.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/net/virtio-net.c | 90 ++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 221252e00a..93029104b3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3746,6 +3746,51 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     return qatomic_read(&n->failover_primary_hidden);
 }
 
+static int virtio_net_pre_save(void *opaque)
+{
+    VirtIONet *n = opaque;
+
+    /* At this point, backend must be stopped, otherwise
+     * it might keep writing to memory. */
+    assert(!n->vhost_started);
+
+    return 0;
+}
+
+static bool primary_unplug_pending(void *opaque)
+{
+    DeviceState *dev = opaque;
+    DeviceState *primary;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIONet *n = VIRTIO_NET(vdev);
+
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
+        return false;
+    }
+    primary = failover_find_primary_device(n);
+    return primary ? primary->pending_deleted_event : false;
+}
+
+static bool dev_unplug_pending(void *opaque)
+{
+    DeviceState *dev = opaque;
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(dev);
+
+    return vdc->primary_unplug_pending(dev);
+}
+
+static const VMStateDescription vmstate_virtio_net = {
+    .name = "virtio-net",
+    .minimum_version_id = VIRTIO_NET_VM_VERSION,
+    .version_id = VIRTIO_NET_VM_VERSION,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+    .pre_save = virtio_net_pre_save,
+    .dev_unplug_pending = dev_unplug_pending,
+};
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -4016,51 +4061,6 @@ static void virtio_net_instance_init(Object *obj)
     ebpf_rss_init(&n->ebpf_rss);
 }
 
-static int virtio_net_pre_save(void *opaque)
-{
-    VirtIONet *n = opaque;
-
-    /* At this point, backend must be stopped, otherwise
-     * it might keep writing to memory. */
-    assert(!n->vhost_started);
-
-    return 0;
-}
-
-static bool primary_unplug_pending(void *opaque)
-{
-    DeviceState *dev = opaque;
-    DeviceState *primary;
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VirtIONet *n = VIRTIO_NET(vdev);
-
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
-        return false;
-    }
-    primary = failover_find_primary_device(n);
-    return primary ? primary->pending_deleted_event : false;
-}
-
-static bool dev_unplug_pending(void *opaque)
-{
-    DeviceState *dev = opaque;
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(dev);
-
-    return vdc->primary_unplug_pending(dev);
-}
-
-static const VMStateDescription vmstate_virtio_net = {
-    .name = "virtio-net",
-    .minimum_version_id = VIRTIO_NET_VM_VERSION,
-    .version_id = VIRTIO_NET_VM_VERSION,
-    .fields = (const VMStateField[]) {
-        VMSTATE_VIRTIO_DEVICE,
-        VMSTATE_END_OF_LIST()
-    },
-    .pre_save = virtio_net_pre_save,
-    .dev_unplug_pending = dev_unplug_pending,
-};
-
 static const Property virtio_net_properties[] = {
     DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
                     VIRTIO_NET_F_CSUM, true),
-- 
2.47.1


