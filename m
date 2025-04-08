Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A19C369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 12:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28HN-0005Bh-1c; Tue, 08 Apr 2025 08:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u28GZ-0004zd-8X; Tue, 08 Apr 2025 08:41:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u28GW-0003Kx-Ks; Tue, 08 Apr 2025 08:41:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538CS5nO017819;
 Tue, 8 Apr 2025 12:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eLq4JT
 KIvTfnaUNR5/XBq5lpo+hkmCaQ3fmBoOxDbdY=; b=fgmNEGr6Wqx0EavUO78bwt
 oE+u9iOGmOmIwmv5qAoHwBHZNrZpG8WyPpmGi68NB2B7QR3Ow1j8WZBqAuK6jJz/
 VqnnHsndwcuA2PAZv7dkMQ3jmilFxEf/CCT5QiLPvmXrVJIcUkwX/+JrAdK3NsYd
 vrtXjcUBrNn1AGDMi/A+D1ImxPp8/LPybbT0us16RDDYbAudV31fjaeErn5NGDRu
 riqeUaV3AfSnKgFmIvxTVQgwXf0hM3jelDQODFNEWJAGN5kq8ldk+uzhMZB9pevQ
 fJxQnR/l9fs/GwqQJYMweuXunSOKG7AvxuK9hpe/LtC2aPawXo8wa5DPaNQgKg/Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w3u301r7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 12:41:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 538CSdmP018774;
 Tue, 8 Apr 2025 12:41:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w3u301r4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 12:41:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5388FCOL013858;
 Tue, 8 Apr 2025 12:41:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunjmpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 12:41:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538CfDM551446016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 12:41:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A93720040;
 Tue,  8 Apr 2025 12:41:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E106420043;
 Tue,  8 Apr 2025 12:41:10 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.in.ibm.com (unknown
 [9.109.198.22]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 12:41:10 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 1/2] vfio/spapr: Enhance error handling in
 vfio_spapr_create_window()
Date: Tue,  8 Apr 2025 18:10:41 +0530
Message-ID: <20250408124042.2695955-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408124042.2695955-1-amachhiw@linux.ibm.com>
References: <20250408124042.2695955-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8pm62huVGEN-3k3V_r7FbcW8hnJE2Ukg
X-Proofpoint-ORIG-GUID: PAVgheuuSZT9m7TvfdDE2qQaeMOm3VIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_04,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080088
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Introduce an Error ** parameter to vfio_spapr_create_window() to enable
structured error reporting. This allows the function to propagate
detailed errors back to callers.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 hw/vfio/spapr.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 1a5d1611f2cd..dd9207679dbe 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -230,9 +230,9 @@ static int vfio_spapr_remove_window(VFIOContainer *container,
     return 0;
 }
 
-static int vfio_spapr_create_window(VFIOContainer *container,
+static bool vfio_spapr_create_window(VFIOContainer *container,
                                     MemoryRegionSection *section,
-                                    hwaddr *pgsize)
+                                    hwaddr *pgsize, Error **errp)
 {
     int ret = 0;
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -252,11 +252,11 @@ static int vfio_spapr_create_window(VFIOContainer *container,
     pgmask = bcontainer->pgsizes & (pagesize | (pagesize - 1));
     pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
     if (!pagesize) {
-        error_report("Host doesn't support page size 0x%"PRIx64
-                     ", the supported mask is 0x%lx",
-                     memory_region_iommu_get_min_page_size(iommu_mr),
-                     bcontainer->pgsizes);
-        return -EINVAL;
+        error_setg_errno(errp, EINVAL, "Host doesn't support page size 0x%"PRIx64
+                         ", the supported mask is 0x%lx",
+                         memory_region_iommu_get_min_page_size(iommu_mr),
+                         bcontainer->pgsizes);
+        return false;
     }
 
     /*
@@ -302,17 +302,17 @@ static int vfio_spapr_create_window(VFIOContainer *container,
         }
     }
     if (ret) {
-        error_report("Failed to create a window, ret = %d (%m)", ret);
-        return -errno;
+        error_setg_errno(errp, errno, "Failed to create a window, ret = %d", ret);
+        return false;
     }
 
     if (create.start_addr != section->offset_within_address_space) {
         vfio_spapr_remove_window(container, create.start_addr);
 
-        error_report("Host doesn't support DMA window at %"HWADDR_PRIx", must be %"PRIx64,
-                     section->offset_within_address_space,
-                     (uint64_t)create.start_addr);
-        return -EINVAL;
+        error_setg_errno(errp, EINVAL, "Host doesn't support DMA window at %"HWADDR_PRIx
+                         ", must be %"PRIx64, section->offset_within_address_space,
+                         (uint64_t)create.start_addr);
+        return false;
     }
     trace_vfio_spapr_create_window(create.page_shift,
                                    create.levels,
@@ -320,7 +320,7 @@ static int vfio_spapr_create_window(VFIOContainer *container,
                                    create.start_addr);
     *pgsize = pagesize;
 
-    return 0;
+    return true;
 }
 
 static bool
@@ -377,9 +377,8 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
         }
     }
 
-    ret = vfio_spapr_create_window(container, section, &pgsize);
-    if (ret) {
-        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
+    ret = vfio_spapr_create_window(container, section, &pgsize, errp);
+    if (!ret) {
         return false;
     }
 
-- 
2.49.0


