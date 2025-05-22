Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74F1C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7Nz-0003ak-5c; Thu, 22 May 2025 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7Nr-0003YT-2V
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:58:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7No-0004hT-Hv
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:58:58 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MEtw6h021365;
 Thu, 22 May 2025 14:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=N/BwNgVfAzLjVYeZ/HSjsmOUoaD9wIe7aEkSBAqBb3E=; b=
 V0OvP18SVHNM60FNS0+m/ZLvLSDOB5vSPYoBl9sTOKoiq3SEGU81YPefXbUzXTOx
 brVW+il/7loUOdoE777cqtH1IqB2J8jg4H8Ei3VpwZYft4CqE+KWc8JlbDswJ15V
 lp89a5sQdqpnF6lcEV0KqHlksWStbE2Nncb2ODA8fM2hJzJvsvmPdU1dL7gqjKJP
 Ndql5NnWtho8JhazGCAdIClEWlsq7BWJOKVFNYEjyaTA7dMIUcXH5yYZc+ot9w5l
 d5U81uhTv/zKkfxUnnNKxetLexnRFu8AMbyoiLq7VJOcY5IV1iWGLLdE0e9e8t5Q
 qKb/7nFDFXLZgqQaPDT+Xw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t5b407dt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54ME5rwn034731; Thu, 22 May 2025 14:58:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwer993s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:52 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54MEwiU7010227;
 Thu, 22 May 2025 14:58:51 GMT
Received: from dhcp-10-43-71-124.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-124.usdhcp.oraclecorp.com [10.43.71.124])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46rwer98yj-7; Thu, 22 May 2025 14:58:51 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
Subject: [PATCH v5 6/7] vdpa: move iova_tree allocation to net_vhost_vdpa_init
Date: Thu, 22 May 2025 10:58:38 -0400
Message-ID: <20250522145839.59974-7-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522145839.59974-1-jonah.palmer@oracle.com>
References: <20250522145839.59974-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505220152
X-Proofpoint-ORIG-GUID: GonnYGIWQnH4p32hLqSThEioOgyPdY7l
X-Authority-Analysis: v=2.4 cv=AdaxH2XG c=1 sm=1 tr=0 ts=682f3bad b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=LVXLgEsTiXo56sGS4ecA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: GonnYGIWQnH4p32hLqSThEioOgyPdY7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE1MiBTYWx0ZWRfX6TTPobhuP5pp
 D7Kip/OjxiL+5Y4EOq60Vf8y2hDdHpcxfWr+TRqA+wvKgilIHDWNpeZGGxmTR+NE68mxWYXGXcY
 VD/NV1UxZVPa+w4uGDsfiZO7q5dC9m78bl5c9IEQt0O3XdUv5Ljk/C3EA/AZ0AMKvp+BUPbGqK4
 28VNwmgRv89SZQkZC6xHkdqYveXe1oOst3oMo2uPVLBzDPYTAKHcnVGlt82rh8JIK9Rb3xm10fB
 3dfn07MNANue46+iCc/5Lvaw97k6FLsX00VHKbyXSJiNt9cnWHBuHsxCaKqJdnJZUvHCVVnFoor
 yL/oRhyNGIep+iXFXk94CCm7QdtOrgt5u5ZszI/j7Bhp86Yh47CpbKPls73V0WXkgzUqx72My+U
 pqQbC9A9hE8jeoWEHx5Lv3C9T2CREe87NwGDuzHh9A/dUcwbHzXWw2g8mErBLSIqKPQA+WUt
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
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


