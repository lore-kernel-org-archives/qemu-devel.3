Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B673CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzimL-0006kY-5O; Fri, 19 Sep 2025 17:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimD-0006jM-L6
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzils-0002XP-So
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:06 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtpRH015796;
 Fri, 19 Sep 2025 21:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=ogtve
 lwYDGDwpJzy4TWUdwP4+IWTrL7XEspxps49GZI=; b=VqWQgIzylxsKW1FDNL9l5
 BUXd1HLTzDT7YWeRBrp3tEQdNHjf9D+BGwaxFkC96vCIuuDkhgiQYVliD+z0g2VJ
 yXSH2nDvIAeGsC1AMNx1NixfkDAeI18p7Gb3MdXmMYYEY9azeK9x0+sFPjYOzBfe
 /JQ1VBTLJHKmIc3yAUU7+lbuGgeE0qgJImm5st3+rOikjYGSF2ERkL2l5dIrD0Uj
 JkUXTcsfel5ge5AJnGLv17/Pf2WlJ7zjeCqGxYrOGCe4ekiOJzfkB/fUCTxHIuwN
 AAtNj+RtcpUL6w4LghzjPG/Ies7jE/9XovZYdqmao02zpA8CM0n4c22kh71jqUy+
 w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx96b6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JL5Paa033754; Fri, 19 Sep 2025 21:35:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:50 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0P004301;
 Fri, 19 Sep 2025 21:35:50 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-14; Fri, 19 Sep 2025 21:35:50 +0000
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
Subject: [PATCH v3 13/22] amd_iommu: Add replay callback
Date: Fri, 19 Sep 2025 21:35:06 +0000
Message-ID: <20250919213515.917111-14-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: ZWMqaa_SP8j9a4Va7opjbuiHGtX7oDLF
X-Proofpoint-GUID: ZWMqaa_SP8j9a4Va7opjbuiHGtX7oDLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX03w4T2Fwxk7I
 G85P/wC2n2NHz7t1NW8+Qan+iIQKmQwymK1CFrlLIc6Rh61S/vzkdysoB2uoMO4+704OonyAKEQ
 A3tmVLQjPFamJMJP4dCCpalXWhBBsYdeP0pOk8z2dRhM8Sa17F1cSlBs4DlaLkp4n/RmVAhTjim
 gaWXTAPOd8sHiyuZ+hB954Q2BfHb/Za06pgMKMFezyJeTvCr/nzyLYk1RjFWi8/SbkRJyaDrm0f
 vqkuOos0YZFkknC3t/+KcXpz2JQvjVInneKBw24rMyoXwPwl3uPK2dGV/CYN4Ntm6DQlWsj4xQG
 qoCZLRbmXK2mybytjJdK2E7udTIxlttmMZm1t4gWuRourWG5gFGVH20SkuR7u8wcHfUmj3wTItM
 0KsCt+Vd
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cdccb8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=TyYeUvuNVc17vi0sGpoA:9
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
index 497f18c540666..9027f7c0544a7 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -918,6 +918,29 @@ static void amdvi_address_space_unmap_all(AMDVIState *s)
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
@@ -2364,6 +2387,7 @@ static void amdvi_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = amdvi_translate;
     imrc->notify_flag_changed = amdvi_iommu_notify_flag_changed;
+    imrc->replay = amdvi_iommu_replay;
 }
 
 static const TypeInfo amdvi_iommu_memory_region_info = {
-- 
2.43.5


