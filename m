Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E507C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 14:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1nVz-0005DX-Ot; Mon, 07 Apr 2025 10:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u1nVq-0005Af-J9; Mon, 07 Apr 2025 10:31:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u1nVp-0007WP-00; Mon, 07 Apr 2025 10:31:46 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537A0H6D030668;
 Mon, 7 Apr 2025 14:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=ZliIQUEfXEKouwul7P5Wy7tl0WSM
 7KqQFyVlZu1etog=; b=htRwpT6vD3vJAvDmwVmaN1jWtT1XAGQtDx3lhdSJj1JN
 qE9ktuZ5YozPCsh8+Cgiw3nXPWMzJHGo6P8NtvcuQ0d/ooPVJIDKQnPqoHt7HZAs
 vDEmJgIIPF81cnp6fG9EP6VAB7GHoSektPjhCK8S7iSGFEezi/c69eyOb7DDBoM7
 1IJeHvvSOi6GCZPlMVnuUgo4nwCxJ+LJU/QKbZokQI+RnTlKiGydz67qPh8Jn68A
 gK7ysgHdpHchv3K6kLfgzqVWMOkGdSyWfWv3+FnriAS9yHx95SROkdjZkrtUdoeP
 6EXgjF83BWpKUdJWThseJWLCazcaKyHOe0sWKmF+Bw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45uwswvj5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:31:42 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 537ER8Bm015766;
 Mon, 7 Apr 2025 14:31:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45uwswvj5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:31:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 537EF7Xn013823;
 Mon, 7 Apr 2025 14:31:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufune6xd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:31:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 537EVb0158720764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Apr 2025 14:31:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5A9D2004B;
 Mon,  7 Apr 2025 14:31:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6384F20043;
 Mon,  7 Apr 2025 14:31:34 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com.com (unknown
 [9.124.220.105])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Apr 2025 14:31:34 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 1/2] vfio/spapr: Enhance error handling in
 vfio_spapr_create_window()
Date: Mon,  7 Apr 2025 20:01:18 +0530
Message-ID: <20250407143119.1304513-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ox90s79gL2xVKwpqvFiPLoMmpb5-WYWr
X-Proofpoint-ORIG-GUID: CCSR8IGRc-jNlq0DGxRm8EiOpAR3ni-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=956 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504070102
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


