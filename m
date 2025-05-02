Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B24C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfwz-0003sC-7t; Thu, 01 May 2025 22:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwu-0003qo-K4
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwr-0007Pd-HY
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeXAN022667;
 Fri, 2 May 2025 02:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=ZAvhk
 r82EoqcU30K6m5sDbbLRWd+c6eoZBzX2oz57AU=; b=ITI3fMBm6qtEcnz3sVERB
 Zew2Zd/KWt+hDazdl80QJ86FMX9MN4YoX2kAqTNU0jj8NnI/pGd7SBRAjwvmxGx/
 D9vzwUDwXlXUMenZxXXn/d+P4cZDgx0RlbaK99D/hvkPrvTGeoJrjCyWBw/vPe0H
 VOgnMeM/7J2DXKk2WFlnxwzX2I11JZK511Wjv2El1F754YwUzkvj8y4sMAxvptAU
 frKfxJb1Wb8cai4gLXOLvkHTXGwmXNQ9VcLjTCsuma/mPwiZpN0+w3Qe5I02trJu
 Exw/nWXNcDyQWv0W7r6Rqk/rngMKd4w5SR1HxA0Rdc4Gpnv8/wlPvQaBbjCH1WUV
 g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uumdb1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5421MJBZ023814; Fri, 2 May 2025 02:16:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkgyyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:11 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEs2011525;
 Fri, 2 May 2025 02:16:11 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-7; Fri, 02 May 2025 02:16:11 +0000
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
Subject: [PATCH v2 06/20] amd_iommu: Return an error when unable to read PTE
 from guest memory
Date: Fri,  2 May 2025 02:15:51 +0000
Message-ID: <20250502021605.1795985-7-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNSBTYWx0ZWRfXzDQ/jwJqsFLw
 c6M6rrRjhIW4u5qJ0Qj7/2bAHAy9kStUNNj5uvOSJz91Q0I1yV96B03zn/5Wo0ntfFOunoKW3RJ
 1Sv91Djlir7MsnJumTBIW6Bbzq2cQoi/Y5Xe1ye7g1FW3QPZjQGIESN3rMBcVsg1leyHYvglvVG
 Uyauf5DkcTQUq4KnJtn8cHD3YS8eNNkiFXo/0+xDKcv4Eq5cKkTu4KryEPqJUJ0E7Tt7+vcd7v7
 Colo1Mr+B0auyr280JcylojAxn6zxUc3fNclZkLakiZu4fLL4I8oMgxmx58TRQqAHQ0DZy9pqn1
 qVKs+XpV8Q9cIePvwZFyagU3GZ72c84z7iuUylmTTXUJ39zuq1j0ll3u4lodRJy4BBvrPXM6rTj
 LPHSXlO6umsTrWum/DxQAjLmEKtzXcy8v0G1SBjyqy4TRXSKnXv4nwtMLw2/f9cR0pdQzIHR
X-Authority-Analysis: v=2.4 cv=Ve/3PEp9 c=1 sm=1 tr=0 ts=68142aed b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=NQinGZd54RBmDUk8HW8A:9 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: 1Di0yjZc8NnEXeSz8fupiu1MJdgTsfRH
X-Proofpoint-GUID: 1Di0yjZc8NnEXeSz8fupiu1MJdgTsfRH
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Make amdvi_get_pte_entry() return an error value (-1) in cases where the
memory read fails, versus the current return of 0 to indicate failure.
The reason is that 0 is also a valid PTE value, and it is useful to know
when a PTE points to memory that is zero i.e. the guest unmapped the
page.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5322a614f5d6..698967cc1a88 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -496,7 +496,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
                         &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_get_pte_hwerror(pte_addr);
         amdvi_log_pagetab_error(s, devid, pte_addr, 0);
-        pte = 0;
+        pte = (uint64_t)-1;
         return pte;
     }
 
@@ -1024,7 +1024,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
             /* add offset and load pte */
             pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
             pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
-            if (!pte) {
+            if (!pte || (pte == (uint64_t)-1)) {
                 return;
             }
             oldlevel = level;
-- 
2.43.5


