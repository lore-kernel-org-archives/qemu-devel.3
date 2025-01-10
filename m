Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07871E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 17:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWIVI-0006qM-Lu; Fri, 10 Jan 2025 12:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tWIVG-0006ok-BZ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:08:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tWIVE-00056S-Kk
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:08:58 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AENWhc011275;
 Fri, 10 Jan 2025 17:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=8X1vb
 0fVtbyKljWkZtE+qq7w4VjQvUkZ0RVgGR158aw=; b=ae6tnxz7FqBycqK0A2CWW
 InwlPY/6KFNAEaHRv5Oj/PkTj2Bsl9KJlz3dumKfZmbeLkVsNYgPMVA8O/tp/9FX
 mJpuetwKOOB96eP/hnEujZ09TNfjjAPmeQUuB6+hJ775jcXZFLhuwrbt1Z+fbUAF
 4FUSdOwHp/k3OBy4eTHHuqbbf6XpvyEOHt2oESYSEbFQMiZd00ea9g83jpLViV60
 PILT6wQYxHybF1NHqMOSk20MsUELem6cE1RioG1rqbXfq3LZa1/FGiqEVXniidFe
 n7dUFDms/8T/ylwEFjP0u1v0BqBwVc2zGAHw7fiwUj19o9QylziCDGY+1xN7JbCB
 g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442b8ujw5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 17:08:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50AFFLO0002800; Fri, 10 Jan 2025 17:08:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xuecp0xb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 17:08:54 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50AH1lkW031831;
 Fri, 10 Jan 2025 17:08:53 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-193-76.vpn.oracle.com
 [10.39.193.76])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 43xuecp0qc-6; Fri, 10 Jan 2025 17:08:53 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v3 5/5] svq: Support translations via GPAs in
 vhost_svq_translate_addr
Date: Fri, 10 Jan 2025 12:08:34 -0500
Message-ID: <20250110170837.2747532-6-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250110170837.2747532-1-jonah.palmer@oracle.com>
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_07,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=864 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100134
X-Proofpoint-ORIG-GUID: rsgvGzuY1GwO2TSfcMS7USftEhgDkOdc
X-Proofpoint-GUID: rsgvGzuY1GwO2TSfcMS7USftEhgDkOdc
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.369,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

Propagates the GPAs (in_xlat_addr/out_xlat_addr) of a VirtQueueElement
to vhost_svq_translate_addr() to translate to IOVAs via GPA->IOVA tree
when descriptors are backed by guest memory.

For descriptors backed by guest memory, the translation is performed
using GPAs via the GPA->IOVA tree. GPAs are unique in the guest's
address space, so this ensures unambiguous IOVA translations.

For descriptors not backed by guest memory, the existing IOVA->HVA tree
is used.

This avoids the issue where different GPAs map to the same HVA, causing
the HVA->IOVA translation to potentially return an IOVA associated with
the wrong intended GPA.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 49 ++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 37aca8b431..be0db94ab7 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -78,24 +78,37 @@ uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
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
     }
 
     for (size_t i = 0; i < num; ++i) {
-        DMAMap needle = {
-            .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
-            .size = iovec[i].iov_len,
-        };
+        const DMAMap *map;
+        DMAMap needle;
         Int128 needle_last, map_last;
         size_t off;
 
-        const DMAMap *map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
+        if (gpas) {
+            /* Search the GPA->IOVA tree */
+            needle = (DMAMap) {
+                .translated_addr = gpas[i],
+                .size = iovec[i].iov_len,
+            };
+            map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
+        } else {
+            /* Searh the IOVA->HVA tree */
+            needle = (DMAMap) {
+                .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
+                .size = iovec[i].iov_len,
+            };
+            map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
+        }
         /*
          * Map cannot be NULL since iova map contains all guest space and
          * qemu already has a physical address mapped
@@ -132,12 +145,14 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
  * @num: iovec length
  * @more_descs: True if more descriptors come in the chain
  * @write: True if they are writeable descriptors
+ * @gpas: Descriptors' GPAs, if backed by guest memory
  *
  * Return true if success, false otherwise and print error.
  */
 static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
                                         const struct iovec *iovec, size_t num,
-                                        bool more_descs, bool write)
+                                        bool more_descs, bool write,
+                                        const hwaddr *gpas)
 {
     uint16_t i = svq->free_head, last = svq->free_head;
     unsigned n;
@@ -149,7 +164,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         return true;
     }
 
-    ok = vhost_svq_translate_addr(svq, sg, iovec, num);
+    ok = vhost_svq_translate_addr(svq, sg, iovec, num, gpas);
     if (unlikely(!ok)) {
         return false;
     }
@@ -175,7 +190,8 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
 static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
                                 const struct iovec *out_sg, size_t out_num,
                                 const struct iovec *in_sg, size_t in_num,
-                                unsigned *head)
+                                unsigned *head, const hwaddr *in_gpas,
+                                const hwaddr *out_gpas)
 {
     unsigned avail_idx;
     vring_avail_t *avail = svq->vring.avail;
@@ -192,12 +208,13 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
     }
 
     ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num > 0,
-                                     false);
+                                     false, out_gpas);
     if (unlikely(!ok)) {
         return false;
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, true);
+    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, true,
+                                     in_gpas);
     if (unlikely(!ok)) {
         return false;
     }
@@ -253,12 +270,20 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
     unsigned qemu_head;
     unsigned ndescs = in_num + out_num;
     bool ok;
+    hwaddr *in_gpas = NULL;
+    hwaddr *out_gpas = NULL;
 
     if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
         return -ENOSPC;
     }
 
-    ok = vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qemu_head);
+    if (elem) {
+        in_gpas = elem->in_xlat_addr;
+        out_gpas = elem->out_xlat_addr;
+    }
+
+    ok = vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qemu_head,
+                             in_gpas, out_gpas);
     if (unlikely(!ok)) {
         return -EINVAL;
     }
-- 
2.43.5


