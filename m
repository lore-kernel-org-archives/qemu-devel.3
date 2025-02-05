Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1B1C02198
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 14:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfgrG-0007c5-El; Wed, 05 Feb 2025 09:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tfgrE-0007Zn-BU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:58:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tfgrC-0008UX-HI
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:58:28 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515DRada010506;
 Wed, 5 Feb 2025 14:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=HPQY3
 t7lqz3YfjREFEdRfiqO06SmhyTkaYjOQn9gbQI=; b=HSXvI/tGmqM3NMTqdGM5C
 4+BlPkrp26IeteU4f7BmV4fa+blq7sKh5e3KFIKgKLRxxAioD67APBIYRQoIlx+q
 8e5i8uiXVHvVnfpSkG8CxyeTGrFM0gk6l6N6lFBLptSVGT392ht00JhpickSw4LA
 Q1jYPYKQs408cUSBgCccnko1+NWazyBT60DCyFzSBp84eQItLSRA52Xj6Dy1VBEH
 rI81nvv15PREh09KKT3/EjaXvr2oM+Yyqt+nTnSIK/fAvC1OieNJlk6GMcnjHJtv
 2e+Qh2QYMFuzgggN9FrkJgbEJSQZgx9uCqdxTe6os8h7J9g01JiqW82txUWVcV7I
 Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy876f2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 14:58:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515EmIYt022525; Wed, 5 Feb 2025 14:58:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8e96bj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 14:58:23 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 515EwGhD022923;
 Wed, 5 Feb 2025 14:58:23 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-182-246.vpn.oracle.com
 [10.65.182.246])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 44j8e96bbx-4; Wed, 05 Feb 2025 14:58:23 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH 3/4] svq: Support translations via GPAs in
 vhost_svq_translate_addr
Date: Wed,  5 Feb 2025 09:58:09 -0500
Message-ID: <20250205145813.394915-4-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250205145813.394915-1-jonah.palmer@oracle.com>
References: <20250205145813.394915-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502050117
X-Proofpoint-GUID: np663eQ_7tpc2Iz2XqD5eR4xPY4F198m
X-Proofpoint-ORIG-GUID: np663eQ_7tpc2Iz2XqD5eR4xPY4F198m
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Propagates the GPAs (in_addr/out_addr) of a VirtQueueElement to
vhost_svq_translate_addr() to translate GPAs to IOVAs via the GPA->IOVA
tree when descriptors are backed by guest memory.

GPAs are unique in the guest's address space, ensuring unambiguous IOVA
translations. This avoids the issue where different GPAs map to the same
HVA, causing the HVA->IOVA translation to potentially return an IOVA
associated with the wrong intended GPA.

For descriptors backed by host-only memory, the existing partial SVQ
IOVA->HVA tree is used.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 45 ++++++++++++++++--------------
 hw/virtio/vhost-shadow-virtqueue.h |  5 ++--
 net/vhost-vdpa.c                   |  2 +-
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index a53492fd36..30ba565f03 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -16,7 +16,6 @@
 #include "qemu/log.h"
 #include "qemu/memalign.h"
 #include "linux-headers/linux/vhost.h"
-#include "exec/ramblock.h"
 
 /**
  * Validate the transport device features that both guests can use with the SVQ
@@ -79,10 +78,11 @@ uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
  * @vaddr: Translated IOVA addresses
  * @iovec: Source qemu's VA addresses
  * @num: Length of iovec and minimum length of vaddr
+ * @gpas: Descriptors' GPAs, if backed by guest memory
  */
 static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
                                      hwaddr *addrs, const struct iovec *iovec,
-                                     size_t num)
+                                     size_t num, const hwaddr *gpas)
 {
     if (num == 0) {
         return true;
@@ -91,22 +91,19 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
     for (size_t i = 0; i < num; ++i) {
         Int128 needle_last, map_last;
         size_t off;
-        RAMBlock *rb;
-        hwaddr gpa;
-        ram_addr_t offset;
         const DMAMap *map;
         DMAMap needle;
 
-        rb = qemu_ram_block_from_host(iovec[i].iov_base, false, &offset);
-        if (rb) {
-            gpa = rb->offset + offset;
-
+        /* Check if the descriptor is backed by guest memory  */
+        if (gpas) {
+            /* Search the GPA->IOVA tree */
             needle = (DMAMap) {
-                .translated_addr = gpa,
+                .translated_addr = gpas[i],
                 .size = iovec[i].iov_len,
             };
             map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
         } else {
+            /* Search the IOVA->HVA tree */
             needle = (DMAMap) {
                 .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
                 .size = iovec[i].iov_len,
@@ -148,6 +145,7 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
  * @sg: Cache for hwaddr
  * @iovec: The iovec from the guest
  * @num: iovec length
+ * @addr: Descriptors' GPAs, if backed by guest memory
  * @more_descs: True if more descriptors come in the chain
  * @write: True if they are writeable descriptors
  *
@@ -155,7 +153,8 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
  */
 static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
                                         const struct iovec *iovec, size_t num,
-                                        bool more_descs, bool write)
+                                        const hwaddr *addr, bool more_descs,
+                                        bool write)
 {
     uint16_t i = svq->free_head, last = svq->free_head;
     unsigned n;
@@ -167,7 +166,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         return true;
     }
 
-    ok = vhost_svq_translate_addr(svq, sg, iovec, num);
+    ok = vhost_svq_translate_addr(svq, sg, iovec, num, addr);
     if (unlikely(!ok)) {
         return false;
     }
@@ -192,8 +191,9 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
 
 static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
                                 const struct iovec *out_sg, size_t out_num,
+                                const hwaddr *out_addr,
                                 const struct iovec *in_sg, size_t in_num,
-                                unsigned *head)
+                                const hwaddr *in_addr, unsigned *head)
 {
     unsigned avail_idx;
     vring_avail_t *avail = svq->vring.avail;
@@ -209,13 +209,14 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
         return false;
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num > 0,
-                                     false);
+    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_addr,
+                                     in_num > 0, false);
     if (unlikely(!ok)) {
         return false;
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, true);
+    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr, false,
+                                     true);
     if (unlikely(!ok)) {
         return false;
     }
@@ -265,8 +266,9 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
  * Return -EINVAL if element is invalid, -ENOSPC if dev queue is full
  */
 int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
-                  size_t out_num, const struct iovec *in_sg, size_t in_num,
-                  VirtQueueElement *elem)
+                  size_t out_num, const hwaddr *out_addr,
+                  const struct iovec *in_sg, size_t in_num,
+                  const hwaddr *in_addr, VirtQueueElement *elem)
 {
     unsigned qemu_head;
     unsigned ndescs = in_num + out_num;
@@ -276,7 +278,8 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
         return -ENOSPC;
     }
 
-    ok = vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qemu_head);
+    ok = vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg, in_num,
+                             in_addr, &qemu_head);
     if (unlikely(!ok)) {
         return -EINVAL;
     }
@@ -292,8 +295,8 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
 static int vhost_svq_add_element(VhostShadowVirtqueue *svq,
                                  VirtQueueElement *elem)
 {
-    return vhost_svq_add(svq, elem->out_sg, elem->out_num, elem->in_sg,
-                         elem->in_num, elem);
+    return vhost_svq_add(svq, elem->out_sg, elem->out_num, elem->out_addr,
+                         elem->in_sg, elem->in_num, elem->in_addr, elem);
 }
 
 /**
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 19c842a15b..9c273739d6 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -118,8 +118,9 @@ uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq);
 void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
                          const VirtQueueElement *elem, uint32_t len);
 int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
-                  size_t out_num, const struct iovec *in_sg, size_t in_num,
-                  VirtQueueElement *elem);
+                  size_t out_num, const hwaddr *out_addr,
+                  const struct iovec *in_sg, size_t in_num,
+                  const hwaddr *in_addr, VirtQueueElement *elem);
 size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num);
 
 void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 5a3a57203d..bd01866878 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -649,7 +649,7 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s,
     VhostShadowVirtqueue *svq = g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
     int r;
 
-    r = vhost_svq_add(svq, out_sg, out_num, in_sg, in_num, NULL);
+    r = vhost_svq_add(svq, out_sg, out_num, NULL, in_sg, in_num, NULL, NULL);
     if (unlikely(r != 0)) {
         if (unlikely(r == -ENOSPC)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device queue\n",
-- 
2.43.5


