Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B2EC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjnm-000200-63; Wed, 07 May 2025 14:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnk-0001zo-VU
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjni-0004sx-Ti
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547IbJoL032093;
 Wed, 7 May 2025 18:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=wRVDFQOXmZbMZmR3HoHi1Kyr/y8yrgG2D0xYtgMWtVA=; b=
 TkbCT3P5uEfirTeMSO2Uebb529bwdvhShBnKP1kNHxlsEPpsJGW1FYJrec/jt8ve
 sewg1SByHeDODZkGT9AUVNkjxtda+D+N8DgfxqC+m2sJ3E8THs2+J9vaiSGR7loS
 lm0cFXI9KkkD0Cs3INJ88jv5QY/MP71ExYVaQ+wBv3hvzz8APHJ4g5+Z2kpio37m
 acaOTblxjPEVcgrCMqaUYuvH07mk6f+Ugo2Euxj7ucsd31F0BVQ1t+QlN+upYJB9
 iqSO5RobP42u0Q8VMP7YMBr6Ouvj1YQ58aIEEf7nTysVX4LRoKeOQhjYf4KqaJfW
 fu1Th3X/NRzUOrM/ru0qkQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gcxx80m1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 547IaIX6036083; Wed, 7 May 2025 18:47:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46d9kbhdfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:21 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 547Il3j7029452;
 Wed, 7 May 2025 18:47:20 GMT
Received: from dhcp-10-43-71-250.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-250.usdhcp.oraclecorp.com [10.43.71.250])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46d9kbhd41-7; Wed, 07 May 2025 18:47:20 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com
Subject: [PATCH v4 6/7] vdpa: move iova_tree allocation to net_vhost_vdpa_init
Date: Wed,  7 May 2025 14:46:46 -0400
Message-ID: <20250507184647.15580-7-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507184647.15580-1-jonah.palmer@oracle.com>
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070170
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3MCBTYWx0ZWRfX2haZOI8LKaIT
 26JZsCZoq3oHvxHc+wgh63ODH6A43L1b5/rB9sUYP36bjNpecketH1GhwrGJJMwwSAyouvYK+rN
 stWRicVKOAfMxiSKScq0pDoDVuRTU09KtrcNMpVZOdeVKCvLulP+ydpTnpcveHAvXoYeJrLrEn4
 hhqWmrIW0vYCJuOjuUgYAtxkkNHeYTCT+SRW5Lt2G21QPZ11nkJQcq1TOHJGwMKEZfX5sKgKarH
 Zz/w9oJXPBEYdQ93qIArnSkzGjIqmqjeEGtWhc37Zf0f6BnKYWPjcV2Fos4V7jV1NwnYhqCuhlb
 Q4MKSviVcCgFqGjLEEB2og5uSYdfr5DKD0WDU6t+LsObwOOUOZZqrr/D+t+WYfXdEwTP/rYkr1F
 mt7IpNu3q8vcDcpo3UQUJulGid9ZxzX6JvQu9oBRngZnkcNsNqfaYoHkmw4NCUrGHB5UlXkg
X-Authority-Analysis: v=2.4 cv=feqty1QF c=1 sm=1 tr=0 ts=681baaba cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=O3ABKvNJdirydfY1GWgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: boe-Fy53Ooa2B3txG5UIM4Ch0GV7XAgo
X-Proofpoint-ORIG-GUID: boe-Fy53Ooa2B3txG5UIM4Ch0GV7XAgo
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

As we are moving to keep the mapping through all the vdpa device life
instead of resetting it at VirtIO reset, we need to move all its
dependencies to the initialization too.  In particular devices with
x-svq=on need a valid iova_tree from the beginning.

Simplify the code also consolidating the two creation points: the first
data vq in case of SVQ active and CVQ start in case only CVQ uses it.

Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 include/hw/virtio/vhost-vdpa.h | 16 ++++++++++++++-
 net/vhost-vdpa.c               | 36 +++-------------------------------
 2 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 221840987e..449bf5c840 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -43,7 +43,21 @@ typedef struct vhost_vdpa_shared {
     struct vhost_vdpa_iova_range iova_range;
     QLIST_HEAD(, vdpa_iommu) iommu_list;
 
-    /* IOVA mapping used by the Shadow Virtqueue */
+    /*
+     * IOVA mapping used by the Shadow Virtqueue
+     *
+     * It is shared among all ASID for simplicity, whether CVQ shares ASID with
+     * guest or not:
+     * - Memory listener need access to guest's memory addresses allocated in
+     *   the IOVA tree.
+     * - There should be plenty of IOVA address space for both ASID not to
+     *   worry about collisions between them.  Guest's translations are still
+     *   validated with virtio virtqueue_pop so there is no risk for the guest
+     *   to access memory that it shouldn't.
+     *
+     * To allocate a iova tree per ASID is doable but it complicates the code
+     * and it is not worth it for the moment.
+     */
     VhostIOVATree *iova_tree;
 
     /* Copy of backend features */
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index decb826868..58d738945d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -235,6 +235,7 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         return;
     }
     qemu_close(s->vhost_vdpa.shared->device_fd);
+    g_clear_pointer(&s->vhost_vdpa.shared->iova_tree, vhost_iova_tree_delete);
     g_free(s->vhost_vdpa.shared);
 }
 
@@ -362,16 +363,8 @@ static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
 
 static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
 {
-    struct vhost_vdpa *v = &s->vhost_vdpa;
-
     migration_add_notifier(&s->migration_state,
                            vdpa_net_migration_state_notifier);
-
-    /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
-    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
-        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
-                                                   v->shared->iova_range.last);
-    }
 }
 
 static int vhost_vdpa_net_data_start(NetClientState *nc)
@@ -418,19 +411,12 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
 static void vhost_vdpa_net_client_stop(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
-    struct vhost_dev *dev;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
     if (s->vhost_vdpa.index == 0) {
         migration_remove_notifier(&s->migration_state);
     }
-
-    dev = s->vhost_vdpa.dev;
-    if (dev->vq_index + dev->nvqs == dev->vq_index_end) {
-        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
-                        vhost_iova_tree_delete);
-    }
 }
 
 static NetClientInfo net_vhost_vdpa_info = {
@@ -602,24 +588,6 @@ out:
         return 0;
     }
 
-    /*
-     * If other vhost_vdpa already have an iova_tree, reuse it for simplicity,
-     * whether CVQ shares ASID with guest or not, because:
-     * - Memory listener need access to guest's memory addresses allocated in
-     *   the IOVA tree.
-     * - There should be plenty of IOVA address space for both ASID not to
-     *   worry about collisions between them.  Guest's translations are still
-     *   validated with virtio virtqueue_pop so there is no risk for the guest
-     *   to access memory that it shouldn't.
-     *
-     * To allocate a iova tree per ASID is doable but it complicates the code
-     * and it is not worth it for the moment.
-     */
-    if (!v->shared->iova_tree) {
-        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
-                                                   v->shared->iova_range.last);
-    }
-
     r = vhost_vdpa_cvq_map_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer,
                                vhost_vdpa_net_cvq_cmd_page_len(), false);
     if (unlikely(r < 0)) {
@@ -1728,6 +1696,8 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         s->vhost_vdpa.shared->device_fd = vdpa_device_fd;
         s->vhost_vdpa.shared->iova_range = iova_range;
         s->vhost_vdpa.shared->shadow_data = svq;
+        s->vhost_vdpa.shared->iova_tree = vhost_iova_tree_new(iova_range.first,
+                                                              iova_range.last);
     } else if (!is_datapath) {
         s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
                                      PROT_READ | PROT_WRITE,
-- 
2.43.5


