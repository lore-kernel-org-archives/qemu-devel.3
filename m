Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA12DCFA773
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 12:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swhg3-0004Wu-IG; Fri, 04 Oct 2024 08:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1swhg1-0004WC-4L
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:44:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1swhfy-0005EY-FY
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:44:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494CMYR0026749;
 Fri, 4 Oct 2024 12:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Q
 AJuSOyaE4Dz4mMOJfpiJfDTVKFK/928JyeyEQvN5c8=; b=SRmyqSuOeNEBtyVlZ
 Nv7TLzBq3Q4wSquZ3GY/36yAt/6zROr0M0B0jtzET/zReZ35hzbxjaNtqJ1fm+FO
 vPLSj2OadC3PlBACEHi7fosle7HgRIGx4QZFImNC5ZGW9Z3qE44JernBE1X5UlJt
 IGYz/XXw+BDL26AoAQErM5PsRVhMyrXUsnAwxkUhZKcW9nWuJkvm7cnXYaeTbwkk
 GXIMONomCs4D41EA8iofuWmaeDgW8jUCVPzSRTQS8lAyVYM6FhdqWxir2teVukR9
 1UBG7iEXZKPP8QSYuHggjQNU8HTtcrIJViWjYDck04Y0v/aS9biTITdcDeK5AT7K
 vJ76w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4220489htt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Oct 2024 12:44:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 494Bct3m005903; Fri, 4 Oct 2024 12:44:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422056fcfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Oct 2024 12:44:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494Cimo6020535;
 Fri, 4 Oct 2024 12:44:50 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-167-128.vpn.oracle.com
 [10.65.167.128])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 422056fce8-3; Fri, 04 Oct 2024 12:44:50 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v2 2/2] vhost-svq: Translate guest-backed memory with IOVA->GPA
 tree
Date: Fri,  4 Oct 2024 08:44:42 -0400
Message-ID: <20241004124445.3802090-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241004124445.3802090-1-jonah.palmer@oracle.com>
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_10,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040093
X-Proofpoint-ORIG-GUID: k9ss4RUbAR95It_w3A179Ws9CrbK7vjV
X-Proofpoint-GUID: k9ss4RUbAR95It_w3A179Ws9CrbK7vjV
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

Implements searching the IOVA->GPA tree when translating guest-backed
memory (and searching the IOVA->HVA tree when translating host-only
memory).

By using the IOVA->GPA tree to find IOVA translations, we avoid the
issue where, if the guest has overlapping memory regions, HVAs backed by
guest memory can lead to multiple different GPAs. In other words, we may
translate to an incorrect IOVA if we search the IOVA->HVA tree using an
HVA that's backed by guest memory.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 61 ++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index fc5f408f77..a72093c00b 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -16,6 +16,7 @@
 #include "qemu/log.h"
 #include "qemu/memalign.h"
 #include "linux-headers/linux/vhost.h"
+#include "exec/ramblock.h"
 
 /**
  * Validate the transport device features that both guests can use with the SVQ
@@ -78,24 +79,55 @@ uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
  * @vaddr: Translated IOVA addresses
  * @iovec: Source qemu's VA addresses
  * @num: Length of iovec and minimum length of vaddr
+ * @is_guest_memory: True if iovec is backed by guest memory
  */
 static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
                                      hwaddr *addrs, const struct iovec *iovec,
-                                     size_t num)
+                                     size_t num, bool is_guest_memory)
 {
     if (num == 0) {
         return true;
     }
 
     for (size_t i = 0; i < num; ++i) {
-        DMAMap needle = {
-            .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
-            .size = iovec[i].iov_len,
-        };
         Int128 needle_last, map_last;
         size_t off;
+        const DMAMap *map;
+        DMAMap needle;
+
+        /*
+         * If the HVA is backed by guest memory, find its GPA and search the
+         * IOVA->GPA tree for the translated IOVA
+         */
+        if (is_guest_memory) {
+            RAMBlock *rb;
+            hwaddr gpa;
+            ram_addr_t offset;
+
+            rb = qemu_ram_block_from_host(iovec[i].iov_base, false, &offset);
+            if (unlikely(!rb)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "No expected RAMBlock found at HVA 0x%"HWADDR_PRIx"",
+                              (hwaddr)(uintptr_t)iovec[i].iov_base);
+                return false;
+            }
+            gpa = rb->offset + offset;
+
+            /* Search IOVA->GPA tree */
+            needle = (DMAMap) {
+                .translated_addr = gpa,
+                .size = iovec[i].iov_len,
+            };
+            map = vhost_iova_gpa_tree_find_iova(svq->iova_tree, &needle);
+        } else {
+            /* Search IOVA->HVA tree */
+            needle = (DMAMap) {
+                .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
+                .size = iovec[i].iov_len,
+            };
+            map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
+        }
 
-        const DMAMap *map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
         /*
          * Map cannot be NULL since iova map contains all guest space and
          * qemu already has a physical address mapped
@@ -132,12 +164,14 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
  * @num: iovec length
  * @more_descs: True if more descriptors come in the chain
  * @write: True if they are writeable descriptors
+ * @is_guest_memory: True if iovec is backed by guest memory
  *
  * Return true if success, false otherwise and print error.
  */
 static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
                                         const struct iovec *iovec, size_t num,
-                                        bool more_descs, bool write)
+                                        bool more_descs, bool write,
+                                        bool is_guest_memory)
 {
     uint16_t i = svq->free_head, last = svq->free_head;
     unsigned n;
@@ -149,7 +183,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         return true;
     }
 
-    ok = vhost_svq_translate_addr(svq, sg, iovec, num);
+    ok = vhost_svq_translate_addr(svq, sg, iovec, num, is_guest_memory);
     if (unlikely(!ok)) {
         return false;
     }
@@ -175,7 +209,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
 static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
                                 const struct iovec *out_sg, size_t out_num,
                                 const struct iovec *in_sg, size_t in_num,
-                                unsigned *head)
+                                unsigned *head, bool is_guest_memory)
 {
     unsigned avail_idx;
     vring_avail_t *avail = svq->vring.avail;
@@ -192,12 +226,13 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
     }
 
     ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num > 0,
-                                     false);
+                                     false, is_guest_memory);
     if (unlikely(!ok)) {
         return false;
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, true);
+    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, true,
+                                     is_guest_memory);
     if (unlikely(!ok)) {
         return false;
     }
@@ -253,12 +288,14 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
     unsigned qemu_head;
     unsigned ndescs = in_num + out_num;
     bool ok;
+    bool is_guest_memory = (elem != NULL) ? true : false;
 
     if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
         return -ENOSPC;
     }
 
-    ok = vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qemu_head);
+    ok = vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qemu_head,
+                             is_guest_memory);
     if (unlikely(!ok)) {
         return -EINVAL;
     }
-- 
2.43.5


