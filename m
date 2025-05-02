Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670ACC369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfxF-0003yY-CL; Thu, 01 May 2025 22:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx5-0003ut-EH
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx3-0007Rx-3t
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:35 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeZl0024646;
 Fri, 2 May 2025 02:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=+Lo/8
 RyqisL+Dcb2sF9z2XBonrejbmXG335l73s1918=; b=Pk9jMzLlhaAygYPSQgcSV
 rkWCnXCy7+gV/o/U5rd+B1kuPVvqzaEUVt2WTICwM3K61A/iRSWsJm6fdH89foac
 jziW9OLaRflLzpXrktteKUI+GTK3foQ+TySFwRWkElhDHs/9h7wqeyEEVWwl9g+l
 RntojcjxzRaij3V6dN0kgQIe7Hk7A26R1CBtAsknlVfQJZQ3TtT2cBjrID2M1KGP
 XkmKG1y81s/GYimOrKwJmaOMSaCeEnvd6ZhrmMrbcyzpuiiaUUxKgGv80mR7Oo03
 HZV9jFBm0rd/j5ctX3z+kUcbYT7xcfBlfp8wNq90alP1Rt1aFDwIZOsVSCI9V0Pd
 Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukvh2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 541NuN4U023769; Fri, 2 May 2025 02:16:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh02h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:16 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEsG011525;
 Fri, 2 May 2025 02:16:15 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-14; Fri, 02 May 2025 02:16:15 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 13/20] amd_iommu: Add replay callback
Date: Fri,  2 May 2025 02:15:58 +0000
Message-ID: <20250502021605.1795985-14-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020015
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNiBTYWx0ZWRfX7NOY773uX7zB
 6L6YS5n311i42inJ8cMtsNTDry4K4l2DL2iwgMzCfqL7z96QIfAk2U66MyIiGP+RG1OVaH2q02t
 1FLfJwjiNI2RFN/scC1S+0SQIkEGjrbmAtW8RDpo0nDuJqKxKHimvma257vs6S3a403JfhZhONt
 /SPJNoNxPOYV3YmpEpwrvm1Rk3vF2IL4QygVznZRTcFgxQiFa0lkh3Y8ZMSaihiX6bMssgcaNlz
 5CjBUVxAO/89lx1+NAPyMY+Al0icX/OrRwxuQS3TfMCAppBE7mT1ZKmxAV/OdP+qCclE6iWmqsd
 mHbhNBWHbgWw0yPiItdGyysP5IQ1tRK9M4e5Wrgq6iPp/s27XfvwKgqA3MmYlZIVaY26DnUcUpP
 82jExQZcc3hJQNi7aCYCWZMNP6LI8JnkXJ8RPvlLssoTAEcbKsxMXEUHmk28mFjJ7YgC1oU8
X-Proofpoint-GUID: Ae1xsQGW63AkSm6jUKnw42cNOOzTACBB
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68142af9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=TyYeUvuNVc17vi0sGpoA:9 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: Ae1xsQGW63AkSm6jUKnw42cNOOzTACBB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A replay() method is necessary to efficiently synchronize the host page
tables after VFIO registers a notifier for IOMMU events. It is called to
ensure that existing mappings from an IOMMU memory region are "replayed" to
a specified notifier, initializing or updating the shadow page tables on the
host.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7bcba47a01ba..5ce74f2c052d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -879,6 +879,29 @@ static void amdvi_address_space_unmap_all(AMDVIState *s)
     }
 }
 
+/*
+ * For every translation present in the IOMMU, construct IOMMUTLBEntry data
+ * and pass it as parameter to notifier callback.
+ */
+static void amdvi_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
+{
+    AMDVIAddressSpace *as = container_of(iommu_mr, AMDVIAddressSpace, iommu);
+    uint64_t dte[4] = { 0 };
+
+    if (!(n->notifier_flags & IOMMU_NOTIFIER_MAP)) {
+        return;
+    }
+
+    if (amdvi_as_to_dte(as, dte)) {
+        return;
+    }
+
+    /* Dropping all mappings for the address space. Also clears the IOVA tree */
+    amdvi_address_space_unmap(as, n);
+
+    amdvi_sync_shadow_page_table_range(as, &dte[0], 0, UINT64_MAX, false);
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -2240,6 +2263,7 @@ static void amdvi_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = amdvi_translate;
     imrc->notify_flag_changed = amdvi_iommu_notify_flag_changed;
+    imrc->replay = amdvi_iommu_replay;
 }
 
 static const TypeInfo amdvi_iommu_memory_region_info = {
-- 
2.43.5


