Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD24C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGUu-0004fG-3O; Mon, 01 Jul 2024 08:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1sOGUd-0004eK-IG
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:50:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1sOGUW-00041l-Ke
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:50:49 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240701125032epoutp02dfcdba26f8ca85b0ddd7b4ddccbe0b81~eF8K_vfXw2010020100epoutp026
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2024 12:50:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240701125032epoutp02dfcdba26f8ca85b0ddd7b4ddccbe0b81~eF8K_vfXw2010020100epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1719838232;
 bh=5Heeati9uzUvNgn1jWA6lviKTtj2WRkr4ObsGoR7hyg=;
 h=From:To:Cc:Subject:Date:References:From;
 b=YMnZljhAoFSiBos2msmi35iVziF0kyocySdvpL1rQv8gNLgFc6Yr83Qa69tb95xd3
 vlLE5M2+7HDQSbE/5fpgJNTnVN78wPlu6WtgsSyOgn23k1lyLEX+mDnnP7wZZKUkBK
 RGqcdZxBpL0/dWLRiGZAilyJpPNZz9gVFRYsyE7o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20240701125032epcas5p479bb7919d6f65a62d977b336a546efee~eF8KpeTJp0245102451epcas5p4g;
 Mon,  1 Jul 2024 12:50:32 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4WCQr64bTGz4x9Pv; Mon,  1 Jul
 2024 12:50:30 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E2.D3.19174.616A2866; Mon,  1 Jul 2024 21:50:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20240701124037epcas5p2d41333d5175f484db8a7ab2e05291b0f~eFzgLXcow1852318523epcas5p2j;
 Mon,  1 Jul 2024 12:40:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240701124037epsmtrp19b6c1879fd63dd26345e7484e040e546~eFzgKouDp1831518315epsmtrp14;
 Mon,  1 Jul 2024 12:40:37 +0000 (GMT)
X-AuditID: b6c32a50-b33ff70000004ae6-d8-6682a616b802
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F6.E9.29940.4C3A2866; Mon,  1 Jul 2024 21:40:36 +0900 (KST)
Received: from localhost.sa.corp.samsungelectronics.net (unknown
 [107.99.41.223]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240701124035epsmtip1b157dd55c437f5640516a2355212b297~eFze04uRk2358023580epsmtip1S;
 Mon,  1 Jul 2024 12:40:35 +0000 (GMT)
From: Arun Kumar <arun.kka@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Arun Kumar
 <arun.kka@samsung.com>
Subject: [PATCH v2] hw/nvme: add cross namespace copy support
Date: Mon,  1 Jul 2024 12:38:55 +0530
Message-ID: <20240701070855.837309-1-arun.kka@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmuq7YsqY0g9dzFSzm3LewODElzGL/
 wW+sFpMOXWO0ON67g8WB1WPKtGvsHud2nGf32LSqk83jybXNTB59W1YxBrBGZdtkpCampBYp
 pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
 6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnvFs7l6lg8l3G
 isvnNrM3MHZMZuxi5OSQEDCR6N2wlr2LkYtDSGAPo8SfDf8ZIZxPjBINa49COd+AnD0P4Fq6
 571hhUjsZZT4emIvE4TTxiTx514TM0gVm4C6xNqZO5hAbBEBSYnfXafB4swC8RLfFi1lAbGF
 BWwlDq05BRTn4GARUJVYdMUAJMwrYCVxYM9RZohl8hKLdyxnhogLSpyc+YQFYoy8RPPW2cwg
 eyUE9rFLXHk4kwWiwUXi/5R1bBC2sMSr41vYIWwpiZf9bVB2vcSZmXuYIOwORomn36Hi9hIX
 9/xlArmHWUBTYv0ufYiwrMTUU+uYIPbySfT+fgLVyiuxYx6MrSRxb+tPqDESEnOufGcEGSMh
 4CHRfMwNxBQSiJVoP+8+gVF+FpJnZiF5ZhbC3gWMzKsYpVILinPTU5NNCwx181LL4TGbnJ+7
 iRGcBrUCdjCu3vBX7xAjEwfjIUYJDmYlEd7AX/VpQrwpiZVVqUX58UWlOanFhxhNgSE8kVlK
 NDkfmIjzSuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpg8rFWVSx4
 dCosXe2f1ctCg4U20Z7Obesunoietywn7ZbhLWmt5Y+7Z7ZPZo/8tXHNtOeKZfHfS9Z+fOuv
 U/H9qd8Dne0PTmzWuqD2Zs4U/8bHK1UqpuYu9Mqss1ktb1HYWHJn5m3hcz3PNh+fuLnyP9Pp
 hCuTueXfsR76++jDesnjsw9JntYV+HnCvsR7ZZ1+9eltO24duWbBGPY107uoslB047MbS/j+
 rpDr9j6wXq/Uhe8A84nUV094uHr06h8WrrsUWXrq9Lyz7/Ob52//tsnzRNQxlQdqR+05n80X
 UmB+2PDutqRRSURJ1yPd/F0pO2/dPxH2tfND+2Yd7t5HmpnSE9j1424JCHa3mKw9o6/EUpyR
 aKjFXFScCAA96e/sDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSnO7RxU1pBlcULebct7A4MSXMYv/B
 b6wWkw5dY7Q43ruDxYHVY8q0a+we53acZ/fYtKqTzePJtc1MHn1bVjEGsEZx2aSk5mSWpRbp
 2yVwZbxbO5epYPJdxorL5zazNzB2TGbsYuTkkBAwkeie94a1i5GLQ0hgN6PExoM3oRISEj++
 fIOyhSVW/nvODlHUwiRx+dkWJpAEm4C6xNqZO8BsEQFJid9dp5m7GDk4mAWSJV7/8AUJCwvY
 ShxacwoszCKgKrHoigFImFfASuLAnqPMEOPlJRbvWM4MEReUODnzCQuIzQwUb946m3kCI98s
 JKlZSFILGJlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEh6OW5g7G7as+6B1iZOJg
 PMQowcGsJMIb+Ks+TYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv+IveFCGB9MSS1OzU1ILUIpgs
 EwenVANTUP+/B3F+a0XXHzfw3Fj3UeD4woNbJRZs1ehmf3GStY2v5+DVyZVVlS7uHFv/uYou
 VvZN6V7n8LPYPUPfn4N9xlmBzZOu1k1SYNonuXXyk26Dw519xXJLLMw43+28yjHrwCN54TuK
 AgUe/zJ/PzU7lbuhO9mz9rv4AR7hv9ULbJ5w/NyyqpYzRKzndZn9Xr2X0RuPmgg9f5JXx7t/
 /+aMf9P15vYL8852P7vz4hn73RVnZqW8vnH5munzuy523fdmhNQ6Fp2X9d1Xk+r0JoffX8Zi
 yYR527YolXDLBNXOTMt8X2JVenqD2ow40+UHd8TrXp4iMdG9vbCecXoYi7Hbaz8jVi+t6k+b
 qzw9KlOUWIozEg21mIuKEwEG/oC+tgIAAA==
X-CMS-MailID: 20240701124037epcas5p2d41333d5175f484db8a7ab2e05291b0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240701124037epcas5p2d41333d5175f484db8a7ab2e05291b0f
References: <CGME20240701124037epcas5p2d41333d5175f484db8a7ab2e05291b0f@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.25; envelope-from=arun.kka@samsung.com;
 helo=mailout2.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Extend copy command to copy user data across different namespaces via
support for specifying a namespace for each source range

Signed-off-by: Arun Kumar <arun.kka@samsung.com>
---

Notes:
    v1->v2: updated commit message

 hw/nvme/ctrl.c       | 355 ++++++++++++++++++++++++++++++++-----------
 include/block/nvme.h |  37 +++--
 2 files changed, 289 insertions(+), 103 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..c181caae38 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2696,6 +2696,7 @@ typedef struct NvmeCopyAIOCB {
     BlockAIOCB common;
     BlockAIOCB *aiocb;
     NvmeRequest *req;
+    NvmeCtrl *n;
     int ret;
 
     void *ranges;
@@ -2714,6 +2715,8 @@ typedef struct NvmeCopyAIOCB {
     uint64_t slba;
 
     NvmeZone *zone;
+    NvmeNamespace *sns;
+    uint32_t tcl;
 } NvmeCopyAIOCB;
 
 static void nvme_copy_cancel(BlockAIOCB *aiocb)
@@ -2760,13 +2763,19 @@ static void nvme_copy_done(NvmeCopyAIOCB *iocb)
 
 static void nvme_do_copy(NvmeCopyAIOCB *iocb);
 
-static void nvme_copy_source_range_parse_format0(void *ranges, int idx,
-                                                 uint64_t *slba, uint32_t *nlb,
-                                                 uint16_t *apptag,
-                                                 uint16_t *appmask,
-                                                 uint64_t *reftag)
+static void nvme_copy_source_range_parse_format0_2(void *ranges,
+                                                   int idx, uint64_t *slba,
+                                                   uint32_t *nlb,
+                                                   uint32_t *snsid,
+                                                   uint16_t *apptag,
+                                                   uint16_t *appmask,
+                                                   uint64_t *reftag)
 {
-    NvmeCopySourceRangeFormat0 *_ranges = ranges;
+    NvmeCopySourceRangeFormat0_2 *_ranges = ranges;
+
+    if (snsid) {
+        *snsid = le32_to_cpu(_ranges[idx].sparams);
+    }
 
     if (slba) {
         *slba = le64_to_cpu(_ranges[idx].slba);
@@ -2789,13 +2798,19 @@ static void nvme_copy_source_range_parse_format0(void *ranges, int idx,
     }
 }
 
-static void nvme_copy_source_range_parse_format1(void *ranges, int idx,
-                                                 uint64_t *slba, uint32_t *nlb,
-                                                 uint16_t *apptag,
-                                                 uint16_t *appmask,
-                                                 uint64_t *reftag)
+static void nvme_copy_source_range_parse_format1_3(void *ranges, int idx,
+                                                   uint64_t *slba,
+                                                   uint32_t *nlb,
+                                                   uint32_t *snsid,
+                                                   uint16_t *apptag,
+                                                   uint16_t *appmask,
+                                                   uint64_t *reftag)
 {
-    NvmeCopySourceRangeFormat1 *_ranges = ranges;
+    NvmeCopySourceRangeFormat1_3 *_ranges = ranges;
+
+    if (snsid) {
+        *snsid = le32_to_cpu(_ranges[idx].sparams);
+    }
 
     if (slba) {
         *slba = le64_to_cpu(_ranges[idx].slba);
@@ -2827,18 +2842,20 @@ static void nvme_copy_source_range_parse_format1(void *ranges, int idx,
 
 static void nvme_copy_source_range_parse(void *ranges, int idx, uint8_t format,
                                          uint64_t *slba, uint32_t *nlb,
-                                         uint16_t *apptag, uint16_t *appmask,
-                                         uint64_t *reftag)
+                                         uint32_t *snsid, uint16_t *apptag,
+                                         uint16_t *appmask, uint64_t *reftag)
 {
     switch (format) {
     case NVME_COPY_FORMAT_0:
-        nvme_copy_source_range_parse_format0(ranges, idx, slba, nlb, apptag,
-                                             appmask, reftag);
+    case NVME_COPY_FORMAT_2:
+        nvme_copy_source_range_parse_format0_2(ranges, idx, slba, nlb, snsid,
+                                               apptag, appmask, reftag);
         break;
 
     case NVME_COPY_FORMAT_1:
-        nvme_copy_source_range_parse_format1(ranges, idx, slba, nlb, apptag,
-                                             appmask, reftag);
+    case NVME_COPY_FORMAT_3:
+        nvme_copy_source_range_parse_format1_3(ranges, idx, slba, nlb, snsid,
+                                               apptag, appmask, reftag);
         break;
 
     default:
@@ -2854,10 +2871,10 @@ static inline uint16_t nvme_check_copy_mcl(NvmeNamespace *ns,
     for (int idx = 0; idx < nr; idx++) {
         uint32_t nlb;
         nvme_copy_source_range_parse(iocb->ranges, idx, iocb->format, NULL,
-                                     &nlb, NULL, NULL, NULL);
+                                     &nlb, NULL, NULL, NULL, NULL);
         copy_len += nlb;
     }
-
+    iocb->tcl = copy_len;
     if (copy_len > ns->id_ns.mcl) {
         return NVME_CMD_SIZE_LIMIT | NVME_DNR;
     }
@@ -2869,11 +2886,11 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
+    NvmeNamespace *dns = req->ns;
     uint32_t nlb;
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, NULL,
-                                 &nlb, NULL, NULL, NULL);
+                                 &nlb, NULL, NULL, NULL, NULL);
 
     if (ret < 0) {
         iocb->ret = ret;
@@ -2882,8 +2899,8 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
         goto out;
     }
 
-    if (ns->params.zoned) {
-        nvme_advance_zone_wp(ns, iocb->zone, nlb);
+    if (dns->params.zoned) {
+        nvme_advance_zone_wp(dns, iocb->zone, nlb);
     }
 
     iocb->idx++;
@@ -2896,25 +2913,25 @@ static void nvme_copy_out_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
+    NvmeNamespace *dns = req->ns;
     uint32_t nlb;
     size_t mlen;
     uint8_t *mbounce;
 
-    if (ret < 0 || iocb->ret < 0 || !ns->lbaf.ms) {
+    if (ret < 0 || iocb->ret < 0 || !dns->lbaf.ms) {
         goto out;
     }
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, NULL,
-                                 &nlb, NULL, NULL, NULL);
+                                 &nlb, NULL, NULL, NULL, NULL);
 
-    mlen = nvme_m2b(ns, nlb);
-    mbounce = iocb->bounce + nvme_l2b(ns, nlb);
+    mlen = nvme_m2b(dns, nlb);
+    mbounce = iocb->bounce + nvme_l2b(dns, nlb);
 
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, mbounce, mlen);
 
-    iocb->aiocb = blk_aio_pwritev(ns->blkconf.blk, nvme_moff(ns, iocb->slba),
+    iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_moff(dns, iocb->slba),
                                   &iocb->iov, 0, nvme_copy_out_completed_cb,
                                   iocb);
 
@@ -2928,12 +2945,15 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
+    NvmeNamespace *sns = iocb->sns;
+    NvmeNamespace *dns = req->ns;
+    NvmeCopyCmd *copy = NULL;
+    uint8_t *mbounce = NULL;
     uint32_t nlb;
     uint64_t slba;
     uint16_t apptag, appmask;
     uint64_t reftag;
-    size_t len;
+    size_t len, mlen;
     uint16_t status;
 
     if (ret < 0) {
@@ -2944,43 +2964,51 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     }
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, &slba,
-                                 &nlb, &apptag, &appmask, &reftag);
-    len = nvme_l2b(ns, nlb);
+                                 &nlb, NULL, &apptag, &appmask, &reftag);
 
     trace_pci_nvme_copy_out(iocb->slba, nlb);
 
-    if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
-        NvmeCopyCmd *copy = (NvmeCopyCmd *)&req->cmd;
+    len = nvme_l2b(sns, nlb);
+
+    if (NVME_ID_NS_DPS_TYPE(sns->id_ns.dps)) {
+        copy = (NvmeCopyCmd *)&req->cmd;
 
         uint16_t prinfor = ((copy->control[0] >> 4) & 0xf);
-        uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
 
-        size_t mlen = nvme_m2b(ns, nlb);
-        uint8_t *mbounce = iocb->bounce + nvme_l2b(ns, nlb);
+        mlen = nvme_m2b(sns, nlb);
+        mbounce = iocb->bounce + nvme_l2b(sns, nlb);
 
-        status = nvme_dif_mangle_mdata(ns, mbounce, mlen, slba);
+        status = nvme_dif_mangle_mdata(sns, mbounce, mlen, slba);
         if (status) {
             goto invalid;
         }
-        status = nvme_dif_check(ns, iocb->bounce, len, mbounce, mlen, prinfor,
+        status = nvme_dif_check(sns, iocb->bounce, len, mbounce, mlen, prinfor,
                                 slba, apptag, appmask, &reftag);
         if (status) {
             goto invalid;
         }
+    }
+
+    if (NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
+        copy = (NvmeCopyCmd *)&req->cmd;
+        uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
+
+        mlen = nvme_m2b(dns, nlb);
+        mbounce = iocb->bounce + nvme_l2b(dns, nlb);
 
         apptag = le16_to_cpu(copy->apptag);
         appmask = le16_to_cpu(copy->appmask);
 
         if (prinfow & NVME_PRINFO_PRACT) {
-            status = nvme_check_prinfo(ns, prinfow, iocb->slba, iocb->reftag);
+            status = nvme_check_prinfo(dns, prinfow, iocb->slba, iocb->reftag);
             if (status) {
                 goto invalid;
             }
 
-            nvme_dif_pract_generate_dif(ns, iocb->bounce, len, mbounce, mlen,
+            nvme_dif_pract_generate_dif(dns, iocb->bounce, len, mbounce, mlen,
                                         apptag, &iocb->reftag);
         } else {
-            status = nvme_dif_check(ns, iocb->bounce, len, mbounce, mlen,
+            status = nvme_dif_check(dns, iocb->bounce, len, mbounce, mlen,
                                     prinfow, iocb->slba, apptag, appmask,
                                     &iocb->reftag);
             if (status) {
@@ -2989,13 +3017,13 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
         }
     }
 
-    status = nvme_check_bounds(ns, iocb->slba, nlb);
+    status = nvme_check_bounds(dns, iocb->slba, nlb);
     if (status) {
         goto invalid;
     }
 
-    if (ns->params.zoned) {
-        status = nvme_check_zone_write(ns, iocb->zone, iocb->slba, nlb);
+    if (dns->params.zoned) {
+        status = nvme_check_zone_write(dns, iocb->zone, iocb->slba, nlb);
         if (status) {
             goto invalid;
         }
@@ -3008,7 +3036,10 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    iocb->aiocb = blk_aio_pwritev(ns->blkconf.blk, nvme_l2b(ns, iocb->slba),
+    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write, 0,
+                     BLOCK_ACCT_WRITE);
+
+    iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_l2b(dns, iocb->slba),
                                   &iocb->iov, 0, nvme_copy_out_cb, iocb);
 
     return;
@@ -3023,23 +3054,22 @@ out:
 static void nvme_copy_in_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
-    NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
+    NvmeNamespace *sns = iocb->sns;
     uint64_t slba;
     uint32_t nlb;
 
-    if (ret < 0 || iocb->ret < 0 || !ns->lbaf.ms) {
+    if (ret < 0 || iocb->ret < 0 || !sns->lbaf.ms) {
         goto out;
     }
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, &slba,
-                                 &nlb, NULL, NULL, NULL);
+                                 &nlb, NULL, NULL, NULL, NULL);
 
     qemu_iovec_reset(&iocb->iov);
-    qemu_iovec_add(&iocb->iov, iocb->bounce + nvme_l2b(ns, nlb),
-                   nvme_m2b(ns, nlb));
+    qemu_iovec_add(&iocb->iov, iocb->bounce + nvme_l2b(sns, nlb),
+                   nvme_m2b(sns, nlb));
 
-    iocb->aiocb = blk_aio_preadv(ns->blkconf.blk, nvme_moff(ns, slba),
+    iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, nvme_moff(sns, slba),
                                  &iocb->iov, 0, nvme_copy_in_completed_cb,
                                  iocb);
     return;
@@ -3048,14 +3078,78 @@ out:
     nvme_copy_in_completed_cb(iocb, ret);
 }
 
+static inline bool nvme_csi_supports_copy(uint8_t csi)
+{
+    return csi == NVME_CSI_NVM || csi == NVME_CSI_ZONED;
+}
+
+static inline bool nvme_copy_ns_format_match(NvmeNamespace *sns,
+                                             NvmeNamespace *dns)
+{
+    return sns->lbaf.ds == dns->lbaf.ds && sns->lbaf.ms == dns->lbaf.ms;
+}
+
+static bool nvme_copy_matching_ns_format(NvmeNamespace *sns, NvmeNamespace *dns,
+                                         bool pi_enable)
+{
+    if (!nvme_csi_supports_copy(sns->csi) ||
+        !nvme_csi_supports_copy(dns->csi)) {
+        return false;
+    }
+
+    if (!pi_enable && !nvme_copy_ns_format_match(sns, dns)) {
+            return false;
+    }
+
+    if (pi_enable && (!nvme_copy_ns_format_match(sns, dns) ||
+        sns->id_ns.dps != dns->id_ns.dps)) {
+            return false;
+    }
+
+    return true;
+}
+
+static inline bool nvme_copy_corresp_pi_match(NvmeNamespace *sns,
+                                              NvmeNamespace *dns)
+{
+    return sns->lbaf.ms == 0 &&
+           ((dns->lbaf.ms == 8 && dns->pif == 0) ||
+           (dns->lbaf.ms == 16 && dns->pif == 1));
+}
+
+static bool nvme_copy_corresp_pi_format(NvmeNamespace *sns, NvmeNamespace *dns,
+                                        bool sns_pi_en)
+{
+    if (!nvme_csi_supports_copy(sns->csi) ||
+        !nvme_csi_supports_copy(dns->csi)) {
+        return false;
+    }
+
+    if (!sns_pi_en && !nvme_copy_corresp_pi_match(sns, dns)) {
+        return false;
+    }
+
+    if (sns_pi_en && !nvme_copy_corresp_pi_match(dns, sns)) {
+        return false;
+    }
+
+    return true;
+}
+
 static void nvme_do_copy(NvmeCopyAIOCB *iocb)
 {
     NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
+    NvmeNamespace *sns;
+    NvmeNamespace *dns = req->ns;
+    NvmeCopyCmd *copy = (NvmeCopyCmd *)&req->cmd;
+    uint16_t prinfor = ((copy->control[0] >> 4) & 0xf);
+    uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
     uint64_t slba;
     uint32_t nlb;
     size_t len;
     uint16_t status;
+    uint32_t dnsid = le32_to_cpu(req->cmd.nsid);
+    uint32_t snsid = dnsid;
 
     if (iocb->ret < 0) {
         goto done;
@@ -3065,40 +3159,124 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
         goto done;
     }
 
-    nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, &slba,
-                                 &nlb, NULL, NULL, NULL);
-    len = nvme_l2b(ns, nlb);
+    if (iocb->format == 2 || iocb->format == 3) {
+        nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format,
+                                     &slba, &nlb, &snsid, NULL, NULL, NULL);
+        if (snsid != dnsid) {
+            if (snsid == NVME_NSID_BROADCAST ||
+                !nvme_nsid_valid(iocb->n, snsid)) {
+                status = NVME_INVALID_NSID | NVME_DNR;
+                goto invalid;
+            }
+            iocb->sns = nvme_ns(iocb->n, snsid);
+            if (unlikely(!iocb->sns)) {
+                status = NVME_INVALID_FIELD | NVME_DNR;
+                goto invalid;
+            }
+        } else {
+            if (((slba + nlb) > iocb->slba) &&
+                ((slba + nlb) < (iocb->slba + iocb->tcl))) {
+                status = NVME_CMD_OVERLAP_IO_RANGE | NVME_DNR;
+                goto invalid;
+            }
+        }
+    } else if (iocb->format == 0 || iocb->format == 1) {
+        nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format,
+                                     &slba, &nlb, NULL, NULL, NULL, NULL);
+    }
+
+    sns = iocb->sns;
+    if ((snsid == dnsid) && NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
+        ((prinfor & NVME_PRINFO_PRACT) != (prinfow & NVME_PRINFO_PRACT))) {
+        status = NVME_INVALID_FIELD | NVME_DNR;
+        goto invalid;
+    } else if (snsid != dnsid) {
+        if (!NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
+            !NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
+            if (!nvme_copy_matching_ns_format(sns, dns, false)) {
+                status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                goto invalid;
+            }
+        }
+        if (NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
+            NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
+            if ((prinfor & NVME_PRINFO_PRACT) !=
+                (prinfow & NVME_PRINFO_PRACT)) {
+                status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                goto invalid;
+            } else {
+                if (!nvme_copy_matching_ns_format(sns, dns, true)) {
+                    status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                    goto invalid;
+                }
+            }
+        }
+
+        if (!NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
+            NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
+            if (!(prinfow & NVME_PRINFO_PRACT)) {
+                status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                goto invalid;
+            } else {
+                if (!nvme_copy_corresp_pi_format(sns, dns, false)) {
+                    status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                    goto invalid;
+                }
+            }
+        }
+
+        if (NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
+            !NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
+            if (!(prinfor & NVME_PRINFO_PRACT)) {
+                status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                goto invalid;
+            } else {
+                if (!nvme_copy_corresp_pi_format(sns, dns, true)) {
+                    status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                    goto invalid;
+                }
+            }
+        }
+    }
+    len = nvme_l2b(sns, nlb);
 
     trace_pci_nvme_copy_source_range(slba, nlb);
 
-    if (nlb > le16_to_cpu(ns->id_ns.mssrl)) {
+    if (nlb > le16_to_cpu(sns->id_ns.mssrl)) {
         status = NVME_CMD_SIZE_LIMIT | NVME_DNR;
         goto invalid;
     }
 
-    status = nvme_check_bounds(ns, slba, nlb);
+    status = nvme_check_bounds(sns, slba, nlb);
     if (status) {
         goto invalid;
     }
 
-    if (NVME_ERR_REC_DULBE(ns->features.err_rec)) {
-        status = nvme_check_dulbe(ns, slba, nlb);
+    if (NVME_ERR_REC_DULBE(sns->features.err_rec)) {
+        status = nvme_check_dulbe(sns, slba, nlb);
         if (status) {
             goto invalid;
         }
     }
 
-    if (ns->params.zoned) {
-        status = nvme_check_zone_read(ns, slba, nlb);
+    if (sns->params.zoned) {
+        status = nvme_check_zone_read(sns, slba, nlb);
         if (status) {
             goto invalid;
         }
     }
 
+    g_free(iocb->bounce);
+    iocb->bounce = g_malloc_n(le16_to_cpu(sns->id_ns.mssrl),
+                              sns->lbasz + sns->lbaf.ms);
+
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    iocb->aiocb = blk_aio_preadv(ns->blkconf.blk, nvme_l2b(ns, slba),
+    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, 0,
+                     BLOCK_ACCT_READ);
+
+    iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, nvme_l2b(sns, slba),
                                  &iocb->iov, 0, nvme_copy_in_cb, iocb);
     return;
 
@@ -3117,9 +3295,7 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
                                       nvme_misc_cb, req);
     uint16_t nr = copy->nr + 1;
     uint8_t format = copy->control[0] & 0xf;
-    uint16_t prinfor = ((copy->control[0] >> 4) & 0xf);
-    uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
-    size_t len = sizeof(NvmeCopySourceRangeFormat0);
+    size_t len = sizeof(NvmeCopySourceRangeFormat0_2);
 
     uint16_t status;
 
@@ -3128,13 +3304,9 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
     iocb->ranges = NULL;
     iocb->zone = NULL;
 
-    if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps) &&
-        ((prinfor & NVME_PRINFO_PRACT) != (prinfow & NVME_PRINFO_PRACT))) {
-        status = NVME_INVALID_FIELD | NVME_DNR;
-        goto invalid;
-    }
-
-    if (!(n->id_ctrl.ocfs & (1 << format))) {
+    if (!(n->id_ctrl.ocfs & (1 << format)) ||
+        ((format == 2 || format == 3) &&
+         !(n->features.hbs.cdfe & (1 << format)))) {
         trace_pci_nvme_err_copy_invalid_format(format);
         status = NVME_INVALID_FIELD | NVME_DNR;
         goto invalid;
@@ -3145,14 +3317,14 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    if ((ns->pif == 0x0 && format != 0x0) ||
-        (ns->pif != 0x0 && format != 0x1)) {
+    if ((ns->pif == 0x0 && (format != 0x0 && format != 0x2)) ||
+        (ns->pif != 0x0 && (format != 0x1 && format != 0x3))) {
         status = NVME_INVALID_FORMAT | NVME_DNR;
         goto invalid;
     }
 
     if (ns->pif) {
-        len = sizeof(NvmeCopySourceRangeFormat1);
+        len = sizeof(NvmeCopySourceRangeFormat1_3);
     }
 
     iocb->format = format;
@@ -3188,17 +3360,13 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
     iocb->idx = 0;
     iocb->reftag = le32_to_cpu(copy->reftag);
     iocb->reftag |= (uint64_t)le32_to_cpu(copy->cdw3) << 32;
-    iocb->bounce = g_malloc_n(le16_to_cpu(ns->id_ns.mssrl),
-                              ns->lbasz + ns->lbaf.ms);
 
     qemu_iovec_init(&iocb->iov, 1);
 
-    block_acct_start(blk_get_stats(ns->blkconf.blk), &iocb->acct.read, 0,
-                     BLOCK_ACCT_READ);
-    block_acct_start(blk_get_stats(ns->blkconf.blk), &iocb->acct.write, 0,
-                     BLOCK_ACCT_WRITE);
-
     req->aiocb = &iocb->common;
+    iocb->sns = req->ns;
+    iocb->n = n;
+    iocb->bounce = NULL;
     nvme_do_copy(iocb);
 
     return NVME_NO_COMPLETE;
@@ -4407,10 +4575,6 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
                           req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode));
 
-    if (!nvme_nsid_valid(n, nsid)) {
-        return NVME_INVALID_NSID | NVME_DNR;
-    }
-
     /*
      * In the base NVM command set, Flush may apply to all namespaces
      * (indicated by NSID being set to FFFFFFFFh). But if that feature is used
@@ -4430,10 +4594,15 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
      * device only supports namespace types that includes the NVM Flush command
      * (NVM and Zoned), so always do an NVM Flush.
      */
+
     if (req->cmd.opcode == NVME_CMD_FLUSH) {
         return nvme_flush(n, req);
     }
 
+    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
     ns = nvme_ns(n, nsid);
     if (unlikely(!ns)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -8248,7 +8417,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(NVME_MAX_NAMESPACES);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES | NVME_ONCS_DSM |
-                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
+                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
+                           NVME_ONCS_NVMCSA | NVME_ONCS_NVMAFC);
 
     /*
      * NOTE: If this device ever supports a command set that does NOT use 0x0
@@ -8259,7 +8429,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
      */
     id->vwc = NVME_VWC_NSID_BROADCAST_SUPPORT | NVME_VWC_PRESENT;
 
-    id->ocfs = cpu_to_le16(NVME_OCFS_COPY_FORMAT_0 | NVME_OCFS_COPY_FORMAT_1);
+    id->ocfs = cpu_to_le16(NVME_OCFS_COPY_FORMAT_0 | NVME_OCFS_COPY_FORMAT_1 |
+                            NVME_OCFS_COPY_FORMAT_2 | NVME_OCFS_COPY_FORMAT_3);
     id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN);
 
     nvme_init_subnqn(n);
diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9a..706e32d0f4 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -799,6 +799,8 @@ typedef struct QEMU_PACKED NvmeDsmRange {
 enum {
     NVME_COPY_FORMAT_0 = 0x0,
     NVME_COPY_FORMAT_1 = 0x1,
+    NVME_COPY_FORMAT_2 = 0x2,
+    NVME_COPY_FORMAT_3 = 0x3,
 };
 
 typedef struct QEMU_PACKED NvmeCopyCmd {
@@ -820,25 +822,30 @@ typedef struct QEMU_PACKED NvmeCopyCmd {
     uint16_t    appmask;
 } NvmeCopyCmd;
 
-typedef struct QEMU_PACKED NvmeCopySourceRangeFormat0 {
-    uint8_t  rsvd0[8];
+typedef struct QEMU_PACKED NvmeCopySourceRangeFormat0_2 {
+    uint32_t sparams;
+    uint8_t  rsvd4[4];
     uint64_t slba;
     uint16_t nlb;
-    uint8_t  rsvd18[6];
+    uint8_t  rsvd18[4];
+    uint16_t sopt;
     uint32_t reftag;
     uint16_t apptag;
     uint16_t appmask;
-} NvmeCopySourceRangeFormat0;
+} NvmeCopySourceRangeFormat0_2;
 
-typedef struct QEMU_PACKED NvmeCopySourceRangeFormat1 {
-    uint8_t  rsvd0[8];
+typedef struct QEMU_PACKED NvmeCopySourceRangeFormat1_3 {
+    uint32_t sparams;
+    uint8_t  rsvd4[4];
     uint64_t slba;
     uint16_t nlb;
-    uint8_t  rsvd18[8];
+    uint8_t  rsvd18[4];
+    uint16_t sopt;
+    uint8_t  rsvd24[2];
     uint8_t  sr[10];
     uint16_t apptag;
     uint16_t appmask;
-} NvmeCopySourceRangeFormat1;
+} NvmeCopySourceRangeFormat1_3;
 
 enum NvmeAsyncEventRequest {
     NVME_AER_TYPE_ERROR                     = 0,
@@ -937,6 +944,8 @@ enum NvmeStatusCodes {
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
     NVME_CMD_SIZE_LIMIT         = 0x0183,
+    NVME_CMD_INCOMP_NS_OR_FMT   = 0x0185,
+    NVME_CMD_OVERLAP_IO_RANGE   = 0x0187,
     NVME_INVALID_ZONE_OP        = 0x01b6,
     NVME_NOZRWA                 = 0x01b7,
     NVME_ZONE_BOUNDARY_ERROR    = 0x01b8,
@@ -1194,11 +1203,15 @@ enum NvmeIdCtrlOncs {
     NVME_ONCS_TIMESTAMP     = 1 << 6,
     NVME_ONCS_VERIFY        = 1 << 7,
     NVME_ONCS_COPY          = 1 << 8,
+    NVME_ONCS_NVMCSA        = 1 << 9,
+    NVME_ONCS_NVMAFC        = 1 << 10,
 };
 
 enum NvmeIdCtrlOcfs {
     NVME_OCFS_COPY_FORMAT_0 = 1 << NVME_COPY_FORMAT_0,
     NVME_OCFS_COPY_FORMAT_1 = 1 << NVME_COPY_FORMAT_1,
+    NVME_OCFS_COPY_FORMAT_2 = 1 << NVME_COPY_FORMAT_2,
+    NVME_OCFS_COPY_FORMAT_3 = 1 << NVME_COPY_FORMAT_3,
 };
 
 enum NvmeIdctrlVwc {
@@ -1332,7 +1345,9 @@ typedef struct NvmeHostBehaviorSupport {
     uint8_t     acre;
     uint8_t     etdas;
     uint8_t     lbafee;
-    uint8_t     rsvd3[509];
+    uint8_t     rsvd3;
+    uint16_t    cdfe;
+    uint8_t     rsvd6[506];
 } NvmeHostBehaviorSupport;
 
 typedef struct QEMU_PACKED NvmeLBAF {
@@ -1832,8 +1847,8 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeZonedResult) != 8);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmRange) != 16);
-    QEMU_BUILD_BUG_ON(sizeof(NvmeCopySourceRangeFormat0) != 32);
-    QEMU_BUILD_BUG_ON(sizeof(NvmeCopySourceRangeFormat1) != 40);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeCopySourceRangeFormat0_2) != 32);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeCopySourceRangeFormat1_3) != 40);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDeleteQ) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCreateCq) != 64);
-- 
2.43.0


