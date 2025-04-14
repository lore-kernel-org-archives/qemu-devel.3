Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350E7C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49Ai-0007Cf-UV; Sun, 13 Apr 2025 22:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Ab-0007Be-AY
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49AY-0007RV-Eb
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:33 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E1l2ZG003262;
 Mon, 14 Apr 2025 02:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=L8JHC
 loN4n4LiyTm71kSN4RiM9mJbyPdlqdg9IWgMRc=; b=ld0ZWkUzqAJ3Y6WDvtEgO
 qzWGdvsOnLBKYtjR+qoasIGlvjWHwOYIYy5Lvdx+CkDKpdvtCgx/UP/djhGaOdmR
 PUhe7HMQAy2Y6vIj0qsV1j8JYyfgczyg7h8YAVFcjQXwx0y4cgNY59pEfqk/mm/w
 wB39nhggxwEdQDU1Awx9+z/7u9Bp4zZH0uOa9jPdZoPyf++VJkgxYddwHDb5l8JB
 KnSLAVhhPAr3APD823WZKAxWmvCw2sgJN2ijqWLncvxM9MhMudRsHBPA7eLfezRz
 vC9s73MJ4CKq0d6UGGuX7f8RO/1QzWO7jOKkygFQa7KlIPNqilBpxEMorGu0pkuJ
 w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460s0g00b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DMkIIE009162; Mon, 14 Apr 2025 02:03:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:22 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYO035550;
 Mon, 14 Apr 2025 02:03:21 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-2; Mon, 14 Apr 2025 02:03:21 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 01/18] memory: Adjust event ranges to fit within notifier
 boundaries
Date: Mon, 14 Apr 2025 02:02:36 +0000
Message-ID: <20250414020253.443831-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_12,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504140014
X-Proofpoint-ORIG-GUID: jcIdwE-B_hsh_zt1kUn23PG_N7JuGQ-J
X-Proofpoint-GUID: jcIdwE-B_hsh_zt1kUn23PG_N7JuGQ-J
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.266,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Invalidating the entire address space (i.e. range of [0, ~0ULL]) is a
valid and required operation by vIOMMU implementations. However, such
invalidations currently trigger an assertion unless they originate from
device IOTLB invalidations.

Although in recent Linux guests this case is not exercised by the VTD
implementation due to various optimizations, the assertion will be hit
by upcoming AMD vIOMMU changes to support DMA address translation. More
specifically, when running a Linux guest with VFIO passthrough device,
and a kernel that does not contain commmit 3f2571fed2fa ("iommu/amd:
Remove redundant domain flush from attach_device()").

Remove the assertion altogether and adjust the range to ensure it does
not cross notifier boundaries.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 system/memory.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 4c829793a0ad..7d120e25abe8 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2030,13 +2030,9 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
         return;
     }
 
-    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
-        /* Crop (iova, addr_mask) to range */
-        tmp.iova = MAX(tmp.iova, notifier->start);
-        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
-    } else {
-        assert(entry->iova >= notifier->start && entry_end <= notifier->end);
-    }
+    /* Crop (iova, addr_mask) to range */
+    tmp.iova = MAX(tmp.iova, notifier->start);
+    tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
 
     if (event->type & notifier->notifier_flags) {
         notifier->notify(notifier, &tmp);
-- 
2.43.5


