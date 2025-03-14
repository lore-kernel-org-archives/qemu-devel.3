Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85F3C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4gR-0005hE-Vy; Fri, 14 Mar 2025 09:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tt4gB-0005do-Ib
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:02:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tt4g7-0005wP-9N
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:02:22 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBlrNQ017176;
 Fri, 14 Mar 2025 13:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Z6UP7Vc7G3f7Pnu8rPtsRsAOzo09/pDLhdAKQgUc4Ek=; b=
 jiq+Dr50sCIT12RqEjFNFcAapQfowj7troCai0UZT1AFUJvfKhyc9SGKA54Ml33i
 MjAA4A9tQz2rSJV8WAHUqGhePS+0NEb4VFjJOLDYGac7tyZDQj/ZPL5Gcz7guwY1
 5N8IaPHz1xSHf/iFeqwhxbBMi9WY9fsnAV1lRF9r0GVLlUybEXT8IqzATCcuQ6FF
 79qpX1NQcD5sL2xUh4X+0fhlhVLsJ01iJuhJz//l248YEae4G1vTFtX9ReOZirD+
 GlZDs0m83tOxSQY60FSmxcqkGUD41J3pINRfkiTvrp/TKStf5dpBeEu6Oq7NfQke
 JNUIVd/iqZHrWG3pFWcLkA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dpet0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 13:02:16 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52EBDGc1012103; Fri, 14 Mar 2025 13:02:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45atn41d6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 13:02:14 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52ED27RJ015104;
 Fri, 14 Mar 2025 13:02:14 GMT
Received: from jonah-ol8.us.oracle.com
 (dhcp-10-43-73-135.usdhcp.oraclecorp.com [10.43.73.135])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 45atn41d05-7; Fri, 14 Mar 2025 13:02:14 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
 jasowant@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyan@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH v3 6/7] vdpa: move iova_tree allocation to net_vhost_vdpa_init
Date: Fri, 14 Mar 2025 09:01:53 -0400
Message-ID: <20250314130204.11380-7-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250314130204.11380-1-jonah.palmer@oracle.com>
References: <20250314130204.11380-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503140103
X-Proofpoint-GUID: 904v7Sk9ndWDCqhIb_m4KEH1A7vN_uvm
X-Proofpoint-ORIG-GUID: 904v7Sk9ndWDCqhIb_m4KEH1A7vN_uvm
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
index 5bc945d3e0..4254ca7c36 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -235,6 +235,7 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         return;
     }
     qemu_close(s->vhost_vdpa.shared->device_fd);
+    g_clear_pointer(&s->vhost_vdpa.shared->iova_tree, vhost_iova_tree_delete);
     g_free(s->vhost_vdpa.shared);
 }
 
@@ -350,16 +351,8 @@ static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
 
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
@@ -406,19 +399,12 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
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
@@ -589,24 +575,6 @@ out:
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
@@ -1715,6 +1683,8 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
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


