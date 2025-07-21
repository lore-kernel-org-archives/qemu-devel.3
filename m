Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DDFC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uds2I-0002hl-Om; Mon, 21 Jul 2025 11:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uds1z-0002V6-Ji
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:02:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uds1x-00026M-IT
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:02:19 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LEu4fd019378;
 Mon, 21 Jul 2025 15:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=feC4XMB/gTHRp8AVmzUNKO+oifJ4K
 UBpomZbfrH4rEo=; b=kl/qMaufAHX0Aj3ISzqA7jOkcO+Y0dE3nEYAYueCnw4iv
 LGMdKo7w3kEVTPMECnMy3YKAowjqL3Y9UbjroRtPZpA7pSgfHFpuL3Og15Ir0GZF
 1TraSapAT5+eg4jEZqw+kK/HfgCX3ZG/DqtU+vTYKzdWnOZKXMZB/UmUuPqS4oTO
 G8UrZmvcOlIkpFoGDBDiGIRya3q/evAkx/tE+3G4cUMAH3HhQJDb4ju8tS7MplmV
 DacUreoY2MDrKidOmPkeLkSDOKynA7kJHoXgjA+gzt1aqwvu1IkUDI3J+1EeDqBA
 QrOktQ7mbOYp276e0SHAKoIB62MoWTmdIfrZJhMMA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057qty3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Jul 2025 15:02:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56LETBOp010340; Mon, 21 Jul 2025 15:02:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4801t85s01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Jul 2025 15:02:09 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56LF29Bg036816;
 Mon, 21 Jul 2025 15:02:09 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4801t85rxk-1; Mon, 21 Jul 2025 15:02:09 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, mst@redhat.com,
 jasowang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 terrynini38514@gmail.com
Subject: [PATCH] virtio: fix off-by-one and invalid access in
 virtqueue_ordered_fill
Date: Mon, 21 Jul 2025 15:02:08 +0000
Message-ID: <20250721150208.2409779-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507210134
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=687e5673 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=djd2ks-o-hz2YHr8Um8A:9
X-Proofpoint-ORIG-GUID: -ytwO018jgkc_LIkph46ln8GxIx_a8Lx
X-Proofpoint-GUID: -ytwO018jgkc_LIkph46ln8GxIx_a8Lx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzMyBTYWx0ZWRfX5GE3eFcGOCud
 SWQkF/lrLUpN8wuAN6n6E9rfF4DjSjdbuV7lJerGYkaO4BPZKphuJSb+YaQSpJJxeO0/V47JtXU
 QF85zDT6gly+q2niIEXVxzk+E1vCuen6lESsUb8dw3HpnLajykZc0RRxdyoEWMXfyXW1nOfFsau
 OI6TIAmnoU1quG//mPpgjnHoORmmocilhccV6urr50fzzOL2Olyv3YcIgfQ6JW8pEhiWOgmFjab
 X2otGreofdI+y3w20f6CLFHNqceWjgBrPEBXz+Dp/E/wtdj4+DA2Y5IiCTXKit2W6TzK1mJ10bl
 VQDH9HeGg5a/CqiWQwwklRO6BwOK3fcJBLoLV4f85Hg/JSF3tYsx/CRv2mSgryIwUYfbZwRRy41
 I/CHz+qTJISbdJCoR8sgey7htmTUoeSMMQYrzseEt/ZcddbC1yazjNH2h8sQIkTn5t/eqhlf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit b44135daa372 introduced virtqueue_ordered_fill for
VIRTIO_F_IN_ORDER support but had a few issues:

* Conditional while loop used 'steps <= max_steps' but should've been
  'steps < max_steps' since reaching steps == max_steps would indicate
  that we didn't find an element, which is an error. Without this
  change, the code would attempt to read invalid data at an index
  outside of our search range.

* Incremented 'steps' using the next chain's ndescs instead of the
  current one.

This patch corrects the loop bounds and synchronizes 'steps' and index
increments.

We also add a defensive sanity check against malicious or invalid
descriptor counts to avoid a potential infinite loop and DoS.

Fixes: b44135daa372 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER support")
Reported-by: terrynini <terrynini38514@gmail.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 82a285a31d..cc1c072cf7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -938,18 +938,18 @@ static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement *elem,
 static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
                                    unsigned int len)
 {
-    unsigned int i, steps, max_steps;
+    unsigned int i, steps, max_steps, ndescs;
 
     i = vq->used_idx % vq->vring.num;
     steps = 0;
     /*
-     * We shouldn't need to increase 'i' by more than the distance
-     * between used_idx and last_avail_idx.
+     * We shouldn't need to increase 'i' by more than or equal to
+     * the distance between used_idx and last_avail_idx (max_steps).
      */
     max_steps = (vq->last_avail_idx - vq->used_idx) % vq->vring.num;
 
     /* Search for element in vq->used_elems */
-    while (steps <= max_steps) {
+    while (steps < max_steps) {
         /* Found element, set length and mark as filled */
         if (vq->used_elems[i].index == elem->index) {
             vq->used_elems[i].len = len;
@@ -957,8 +957,18 @@ static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
             break;
         }
 
-        i += vq->used_elems[i].ndescs;
-        steps += vq->used_elems[i].ndescs;
+        ndescs = vq->used_elems[i].ndescs;
+
+        /* Defensive sanity check */
+        if (unlikely(ndescs == 0 || ndescs > vq->vring.num)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: %s invalid ndescs %u at position %u\n",
+                          __func__, vq->vdev->name, ndescs, i);
+            return;
+        }
+
+        i += ndescs;
+        steps += ndescs;
 
         if (i >= vq->vring.num) {
             i -= vq->vring.num;
-- 
2.47.1


