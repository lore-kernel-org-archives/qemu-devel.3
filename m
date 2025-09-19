Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDCECAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzimE-0006jC-W8; Fri, 19 Sep 2025 17:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimB-0006iy-B9
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzils-0002XR-T8
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:05 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtoGr023213;
 Fri, 19 Sep 2025 21:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=AGKSa
 u1n2tIPXwY1/aAFUf6FxEh3fO8tz4q32caa7UM=; b=qMhTe8rw+sNb2jFpQsYAi
 Orrmenq1zDVLHUTshLy3ztDvjXH+CTIeo9PMrlc3t7Mg2/Lb1br/TQdIi5Wm67sm
 xSnZyxoW2srqrojsVitCnCOJu55rkppCSD+oKLLonRzaWeoGRYDTw6vLzTnA4Nhb
 y242hxwmOmpfqsfKiQbbbZlzN80TvJ514MKc+g8jSHyxjsipnB8I5HyEvpnyFqRD
 WAvKzoPQLLn3D9b1CaY/Y3k3looT9ZRWv2Kan6oZIeekJnEj0BprHYSc4yolq1p6
 cnlv1oe0EUfTyt1UYgsb/Kxk887sOPkWFWa6GdSh4FBGYJ2huDIWUhDEUP4JUPmT
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6pdw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JJJk1Z033700; Fri, 19 Sep 2025 21:35:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0R004301;
 Fri, 19 Sep 2025 21:35:52 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-15; Fri, 19 Sep 2025 21:35:52 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 14/22] amd_iommu: Invalidate address translations on
 INVALIDATE_IOMMU_ALL
Date: Fri, 19 Sep 2025 21:35:07 +0000
Message-ID: <20250919213515.917111-15-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190201
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cdccba b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=_2-mevsZ5CH5rBQasQwA:9
X-Proofpoint-GUID: pmO5ewxk_y571blfdstdsQHflDP7MRDh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9EV/cJ6lBwuk
 S51k+1o9QAE1l8Dk2MQyAK8CMi+sc3MGltv//lyupebBwcsU8cNnhZoVdOVNxWiHz+QTieCyI6x
 MEuEZuLtenJlIMU3nsV97J3BO6pmD/tWX5J1/U/OIhj3z1bSYj/NWkjnk5AcUuHwj0Aqo9bxRM9
 if0XCqLeW7HlPAkFX78PG172q1NSPpRNGVQA9g5SsHoAS6xBsWpss9yXj81Yq4r8e5ydv/hKjcM
 IzdljVfIQddFuLMek/5kY17RCPopMqRJZW2h4vUY9Amf5fFf4lkEGRJRc4K4oMvQsPL33oT7f6M
 Hd+A/MXk+rvrcoZfxz8rJHoWLyJY4L+U2Zsr+dvCQjt9PQ/qyXKzOyG+MDgttOhIg9dhR8tFAxp
 PpJLiFYU
X-Proofpoint-ORIG-GUID: pmO5ewxk_y571blfdstdsQHflDP7MRDh
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

When the kernel IOMMU driver issues an INVALIDATE_IOMMU_ALL, the address
translation and interrupt remapping information must be cleared for all
Device IDs and all domains. Introduce a helper to sync the shadow page table
for all the address spaces with registered notifiers, which replays both MAP
and UNMAP events.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9027f7c0544a7..d74d42b3dda8e 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -941,6 +941,47 @@ static void amdvi_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     amdvi_sync_shadow_page_table_range(as, &dte[0], 0, UINT64_MAX, false);
 }
 
+static void amdvi_address_space_sync(AMDVIAddressSpace *as)
+{
+    IOMMUNotifier *n;
+    uint64_t dte[4] = { 0 };
+
+    /* If only UNMAP notifiers are registered, drop all existing mappings */
+    if (!(as->notifier_flags & IOMMU_NOTIFIER_MAP)) {
+        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+            /*
+             * Directly calling memory_region_unmap_iommu_notifier_range() does
+             * not guarantee that the addr_mask eventually passed as parameter
+             * to the notifier is valid. Use amdvi_address_space_unmap() which
+             * ensures the notifier range is divided into properly aligned
+             * regions, and issues notifications for each one.
+             */
+            amdvi_address_space_unmap(as, n);
+        }
+        return;
+    }
+
+    if (amdvi_as_to_dte(as, dte)) {
+        return;
+    }
+
+    amdvi_sync_shadow_page_table_range(as, &dte[0], 0, UINT64_MAX, true);
+}
+
+/*
+ * This differs from the replay() method in that it issues both MAP and UNMAP
+ * notifications since it is called after global invalidation events in order to
+ * re-sync all address spaces.
+ */
+static void amdvi_iommu_address_space_sync_all(AMDVIState *s)
+{
+    AMDVIAddressSpace *as;
+
+    QLIST_FOREACH(as, &s->amdvi_as_with_notifiers, next) {
+        amdvi_address_space_sync(as);
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -983,6 +1024,13 @@ static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
     amdvi_intremap_inval_notify_all(s, true, 0, 0);
 
     amdvi_iotlb_reset(s);
+
+    /*
+     * Fully replay the address space i.e. send both UNMAP and MAP events in
+     * order to synchronize guest and host IO page tables tables.
+     */
+    amdvi_iommu_address_space_sync_all(s);
+
     trace_amdvi_all_inval();
 }
 
-- 
2.43.5


