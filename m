Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C094C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 14:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1nOV-0002Lr-KZ; Mon, 07 Apr 2025 10:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u1nOR-0002LW-RX; Mon, 07 Apr 2025 10:24:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u1nOP-0006E5-B0; Mon, 07 Apr 2025 10:24:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5379oKe2017720;
 Mon, 7 Apr 2025 14:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=ZliIQUEfXEKouwul7P5Wy7tl0WSM
 7KqQFyVlZu1etog=; b=qmbs358BfHpK1qDOaUeysQ75h0ERLt69Ufna2aw8TbbD
 CyYH9zPmAxsxM/oah/YVCQSSRT1HspyAH3Tav/d2Gb3fBYNrxm7+IxB2X7v7gVOA
 C8HZSViKk0yWteBH+Pc3tCQdkgoULxXrNHLi10ZWyPIzMzT7k756PJSgiKS+NM6c
 gUp6SeF7nvHaX379Cx2DvfB0UV47tSJQlvIzvZzot1kmS84XbuRHAGjBmHfO74Vs
 u/eQoW03eRRhsW8SFMMG/xo+UCUmfb5eSGwR2UBbwHjuzTO77l5gPEB2rWkHssvs
 UM+BAh/nXuky+Umgvu221e6joYd+QEp5JNv1NI/TSg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45v0u0kxme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:24:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 537EJQ1S020183;
 Mon, 7 Apr 2025 14:24:01 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45v0u0kxmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:24:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 537As9r9017702;
 Mon, 7 Apr 2025 14:24:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kdyct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:24:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 537ENtRD54657498
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Apr 2025 14:23:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83F452004D;
 Mon,  7 Apr 2025 14:23:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32BA520043;
 Mon,  7 Apr 2025 14:23:53 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com.com (unknown
 [9.124.220.105])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Apr 2025 14:23:52 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/2] vfio/spapr: Enhance error handling in
 vfio_spapr_create_window()
Date: Mon,  7 Apr 2025 19:53:36 +0530
Message-ID: <20250407142337.1272599-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fGLJ4WKFZWcuAVcpQ-NluoKTzkMupNQt
X-Proofpoint-GUID: s_RAopRt-GUp0tcE9lY1rJwuTVDSMldU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 phishscore=0 malwarescore=0 mlxlogscore=951 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504070098
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce an Error ** parameter to vfio_spapr_create_window() to enable
structured error reporting. This allows the function to propagate
detailed errors back to callers.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 hw/vfio/spapr.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 1a5d1611f2cd..4f2858b43f36 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -232,7 +232,7 @@ static int vfio_spapr_remove_window(VFIOContainer *container,
 
 static int vfio_spapr_create_window(VFIOContainer *container,
                                     MemoryRegionSection *section,
-                                    hwaddr *pgsize)
+                                    hwaddr *pgsize, Error **errp)
 {
     int ret = 0;
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -252,10 +252,10 @@ static int vfio_spapr_create_window(VFIOContainer *container,
     pgmask = bcontainer->pgsizes & (pagesize | (pagesize - 1));
     pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
     if (!pagesize) {
-        error_report("Host doesn't support page size 0x%"PRIx64
-                     ", the supported mask is 0x%lx",
-                     memory_region_iommu_get_min_page_size(iommu_mr),
-                     bcontainer->pgsizes);
+        error_setg(errp, "Host doesn't support page size 0x%"PRIx64
+                   ", the supported mask is 0x%lx",
+                   memory_region_iommu_get_min_page_size(iommu_mr),
+                   bcontainer->pgsizes);
         return -EINVAL;
     }
 
@@ -302,16 +302,16 @@ static int vfio_spapr_create_window(VFIOContainer *container,
         }
     }
     if (ret) {
-        error_report("Failed to create a window, ret = %d (%m)", ret);
+        error_setg_errno(errp, -ret, "Failed to create a window, ret = %d (%m)", ret);
         return -errno;
     }
 
     if (create.start_addr != section->offset_within_address_space) {
         vfio_spapr_remove_window(container, create.start_addr);
 
-        error_report("Host doesn't support DMA window at %"HWADDR_PRIx", must be %"PRIx64,
-                     section->offset_within_address_space,
-                     (uint64_t)create.start_addr);
+        error_setg(errp, "Host doesn't support DMA window at %"HWADDR_PRIx
+                   ", must be %"PRIx64, section->offset_within_address_space,
+                   (uint64_t)create.start_addr);
         return -EINVAL;
     }
     trace_vfio_spapr_create_window(create.page_shift,
@@ -334,6 +334,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
                                                   container);
     VFIOHostDMAWindow *hostwin;
     hwaddr pgsize = 0;
+    Error *local_err = NULL;
     int ret;
 
     /*
@@ -377,9 +378,9 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
         }
     }
 
-    ret = vfio_spapr_create_window(container, section, &pgsize);
+    ret = vfio_spapr_create_window(container, section, &pgsize, &local_err);
     if (ret) {
-        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
+        error_propagate(errp, local_err);
         return false;
     }
 

base-commit: 53f3a13ac1069975ad47cf8bd05cc96b4ac09962
-- 
2.49.0


