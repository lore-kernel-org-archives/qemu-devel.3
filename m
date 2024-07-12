Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63AEC3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGrA-0001kW-Bp; Fri, 12 Jul 2024 10:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGr0-0001G6-PW
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGqx-0005wV-Q7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIfXZ023475;
 Fri, 12 Jul 2024 14:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=EU/zcw9pA4bSEmPOvY/bmmNwuOR1JofunRmYAaSvopg=; b=
 JKcBlsmdxvDhr2WoA0IYtiPTaVBycNF6W72guM+IxuzLsneU4ndO1C4/tLLP3X2a
 k0uSvQW1kZGiABDmKN50/7JJc2eP17jRPIpfujUR9r4bLlgccivVANBA2XkbMfib
 gKYlzJMOCW4c9uULZInTZNNQIX8ID0GMl+ZA7Ndi8dhQ7/9uaDD2cWYw40q6en96
 vrQRrQEi2vKGq2CWk2E6M4TvQOE66Z6GxS5Dy/DzPI09nHtW933gRd3QwPR9jdZN
 egUVR3iWf4o7mPv2/MdZT85NSW81BjZvZ4FzSWKHovD1OgslGig05cTPABUkNtHL
 JOgjEDWB/gLBIjUVxOnLNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq41v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:24 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CDci7r010950; Fri, 12 Jul 2024 14:02:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv74k0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:22 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CE2DQ2020438;
 Fri, 12 Jul 2024 14:02:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 409vv74jq7-8; Fri, 12 Jul 2024 14:02:22 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 7/7] vdpa/cpr: preserve dma mappings
Date: Fri, 12 Jul 2024 07:02:11 -0700
Message-Id: <1720792931-456433-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
References: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120094
X-Proofpoint-ORIG-GUID: 7XVnE1vpO3qVh9XibFAKGwKVYDS_vpQL
X-Proofpoint-GUID: 7XVnE1vpO3qVh9XibFAKGwKVYDS_vpQL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Preserve dma mappings during CPR restart by suppressing dma_map and
dma_unmap calls.  For devices with capability VHOST_BACKEND_F_IOTLB_REMAP,
convert dma_map calls to VHOST_IOTLB_REMAP to set the new userland VA for
the existing mapping.

However, map and unmap shadow vq buffers normally.  Their pages are not
locked in memory, and they are re-created after CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/virtio/trace-events        |  4 ++--
 hw/virtio/vhost-vdpa.c        | 30 +++++++++++++++++++++++++-----
 scripts/tracetool/__init__.py |  2 +-
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 990c61be79..30d7f5ec69 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -31,8 +31,8 @@ vhost_user_create_notifier(int idx, void *n) "idx:%d n:%p"
 
 # vhost-vdpa.c
 vhost_vdpa_skipped_memory_section(int is_ram, int is_iommu, int is_protected, int is_ram_device, uint64_t first, uint64_t last, int page_mask) "is_ram=%d, is_iommu=%d, is_protected=%d, is_ram_device=%d iova_min=0x%"PRIx64" iova_last=0x%"PRIx64" page_mask=0x%x"
-vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint64_t uaddr, uint8_t perm, uint8_t type) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" uaddr: 0x%"PRIx64" perm: 0x%"PRIx8" type: %"PRIu8
-vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint8_t type) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8
+vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint64_t uaddr, uint8_t perm, uint8_t type, bool shadow, const char *override) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" uaddr: 0x%"PRIx64" perm: 0x%"PRIx8" type: %"PRIu8" shadow: %d %s"
+vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint8_t type, bool shadow, const char *override) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8" shadow: %d %s"
 vhost_vdpa_listener_begin_batch(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
 vhost_vdpa_listener_commit(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
 vhost_vdpa_listener_region_add_unaligned(void *v, const char *name, uint64_t offset_as, uint64_t offset_page) "vdpa_shared: %p region %s offset_within_address_space %"PRIu64" offset_within_region %"PRIu64
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index d9ebc396b7..3ee809abfe 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -22,6 +22,8 @@
 #include "hw/virtio/vhost-vdpa.h"
 #include "exec/address-spaces.h"
 #include "migration/blocker.h"
+#include "migration/cpr.h"
+#include "migration/options.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
 #include "trace.h"
@@ -97,18 +99,29 @@ int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
     struct vhost_msg_v2 msg = {};
     int fd = s->device_fd;
     int ret = 0;
+    bool remap = false, suppress = false;
+
+    if (migrate_mode() == MIG_MODE_CPR_EXEC && !shadow) {
+        remap = !!(s->backend_cap & BIT_ULL(VHOST_BACKEND_F_IOTLB_REMAP));
+        suppress = !remap;
+    }
 
     msg.type = VHOST_IOTLB_MSG_V2;
     msg.asid = asid;
     msg.iotlb.iova = iova;
     msg.iotlb.size = size;
     msg.iotlb.uaddr = (uint64_t)(uintptr_t)vaddr;
-    msg.iotlb.perm = readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
-    msg.iotlb.type = VHOST_IOTLB_UPDATE;
+    msg.iotlb.perm = remap ? 0 : readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
+    msg.iotlb.type = remap ? VHOST_IOTLB_REMAP : VHOST_IOTLB_UPDATE;
 
     trace_vhost_vdpa_dma_map(s, fd, msg.type, msg.asid, msg.iotlb.iova,
                              msg.iotlb.size, msg.iotlb.uaddr, msg.iotlb.perm,
-                             msg.iotlb.type);
+                             msg.iotlb.type, shadow,
+                             remap ? "(remap)" : suppress ? "(suppress)" : "");
+
+    if (suppress) {
+        return 0;
+    }
 
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
@@ -129,6 +142,7 @@ int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
     struct vhost_msg_v2 msg = {};
     int fd = s->device_fd;
     int ret = 0;
+    bool suppress = migrate_mode() == MIG_MODE_CPR_EXEC && !shadow;
 
     msg.type = VHOST_IOTLB_MSG_V2;
     msg.asid = asid;
@@ -137,7 +151,12 @@ int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
     msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
 
     trace_vhost_vdpa_dma_unmap(s, fd, msg.type, msg.asid, msg.iotlb.iova,
-                               msg.iotlb.size, msg.iotlb.type);
+                               msg.iotlb.size, msg.iotlb.type, shadow,
+                               suppress ? "(suppressed)" : "");
+
+    if (suppress) {
+        return 0;
+    }
 
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
@@ -851,7 +870,8 @@ static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
         0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
         0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
         0x1ULL << VHOST_BACKEND_F_SUSPEND |
-        0x1ULL << VHOST_BACKEND_F_NEW_OWNER;
+        0x1ULL << VHOST_BACKEND_F_NEW_OWNER |
+        0x1ULL << VHOST_BACKEND_F_IOTLB_REMAP;
     int r;
 
     if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index bc03238c0f..bfb181cb81 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -253,7 +253,7 @@ def __init__(self, name, props, fmt, args, lineno, filename, orig=None,
         self.event_trans = event_trans
         self.event_exec = event_exec
 
-        if len(args) > 10:
+        if len(args) > 11:
             raise ValueError("Event '%s' has more than maximum permitted "
                              "argument count" % name)
 
-- 
2.39.3


