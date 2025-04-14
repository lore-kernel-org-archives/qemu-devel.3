Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBE9C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49BN-0007SD-5q; Sun, 13 Apr 2025 22:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49BG-0007QI-6g
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:04:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49BE-0007XA-Dj
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:04:13 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E1liQP004620;
 Mon, 14 Apr 2025 02:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=KWHMQ
 BoKGuIOHdy/PT307zIcc4q7NfhSS2apO/cVzl8=; b=KU5qpGmMJfBx/GJStkwri
 azvniJI+Sq6/U9oINb9rYYKtqunBIjrykF3pHkmsOvf54DEbhhZbGDPTVwgzzpoN
 y9U4oqyWDyUT7xqeHNcJ5YcN7w7vjK1+XZocPRzcuCISeGpauxWsGCAhbKRhtq65
 /bc91P4/musUmm1sCB7R8Tk6zYwrK08XyZl0ydyArACrO7OmPFpBj5fFHXeUkSO5
 61zGzE97kSWBbcam+tHg+NVAC4jjS3ThU3jXZlDjj6IpVzjchxDI18oD+S2/2pBb
 wLqqmBIkDOXjZrghsZR4BekhrFSZ6ocp316QP1KhNEBhsTBizb15s8FqB0hgkJzW
 A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460s0g00bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:57 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DMo8Ms009250; Mon, 14 Apr 2025 02:03:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYw035550;
 Mon, 14 Apr 2025 02:03:56 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-19; Mon, 14 Apr 2025 02:03:56 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 18/18] amd_iommu: Do not emit I/O page fault events during
 replay()
Date: Mon, 14 Apr 2025 02:02:53 +0000
Message-ID: <20250414020253.443831-19-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: 90zBZi6XK4qruQdvdzpO1LU31LpZHWbB
X-Proofpoint-GUID: 90zBZi6XK4qruQdvdzpO1LU31LpZHWbB
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

Do not emit an I/O page fault on amdvi_page_walk() when a valid mapping
is not found. The current role of amdvi_page_walk() is to be a helper
for the translate() method and ultimately the IOMMU replay()
functionality. These operations might be executed while the guest is
running, but do not necessarily correspond 1:1 with guest-initiated page
walks.

One example of such scenario is when VFIO code calls
memory_region_iommu_replay() (which ends up calling amdvi_walk_page())
to sync the dirty bitmap, or after registering a new notifier. The guest
would get IO_PAGE_FAULT events for all the regions where a mapping
doesn't currently exist, which is not correct.

Note that after this change there are no users of amdvi_page_fault(),
but since the IO page fault handling will be addressed in upcoming work,
I am choosing to mark it as unused rather than deleting it.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index dc29a52bd845..ac7000dbafc7 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -263,8 +263,8 @@ static void amdvi_encode_event(uint64_t *evt, uint16_t devid, uint64_t addr,
  *
  * @addr: virtual address in translation request
  */
-static void amdvi_page_fault(AMDVIState *s, uint16_t devid,
-                             hwaddr addr, uint16_t info)
+static void __attribute__((unused))
+amdvi_page_fault(AMDVIState *s, uint16_t devid, hwaddr addr, uint16_t info)
 {
     uint64_t evt[2];
 
@@ -1254,9 +1254,6 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
      */
     if ((pte == (uint64_t)-1) || (pte == (uint64_t)-2) ||
         !IOMMU_PTE_PRESENT(pte) || perms != (perms & amdvi_get_perms(pte))) {
-
-        amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
-        trace_amdvi_page_fault(addr);
         return;
     }
 
-- 
2.43.5


