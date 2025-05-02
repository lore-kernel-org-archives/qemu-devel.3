Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B2BC3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfxG-0003yw-2j; Thu, 01 May 2025 22:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfxD-0003xA-Dp
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx7-0007Sy-RR
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:43 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeZqG002049;
 Fri, 2 May 2025 02:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=MXUbN
 L9dFuyRW6dtsmiXKHbRdnOOnvGvXPT1TmWhgAU=; b=iRwcejQ1xjR8nDYO9u1oR
 ANBqCAOuhPFDiQz01w5ROvyyWSjM+I87N+euS47R7JIdrYWEZAZNM9pIYyhvPekA
 d3hrmydjzrU2mY5EQ02cVwQ8cY3iBHuKg3isGolgNlwG8K3u7uceqlq7Mx9musbD
 QDupGAEF/KrqWhzWSHWlxf5oUTr0lO9UgDda4B4ydrN53jmNmFGKLwPeV+6foad1
 xXG5tShViFRmzSLKKcSGGYebM3+RLKEnYOH6rA6KFIjkYAKlu5ycvXWkW+/7L/5D
 6cN0r1c/zWm4gWT5kQC4jMFj0dbeETVaPpXoT6ffB7UoXiiWX9QBxfYTbJqrtIw8
 g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6umcccr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5421iK59023812; Fri, 2 May 2025 02:16:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh043-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:20 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEsS011525;
 Fri, 2 May 2025 02:16:19 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-20; Fri, 02 May 2025 02:16:19 +0000
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
Subject: [PATCH v2 19/20] amd_iommu: Do not assume passthrough translation
 when DTE[TV]=0
Date: Fri,  2 May 2025 02:16:04 +0000
Message-ID: <20250502021605.1795985-20-alejandro.j.jimenez@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=68142afe b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=QsCEJq6UzS2LWQETwqwA:9 cc=ntf
 awl=host:13130
X-Proofpoint-GUID: tb_-ahigq50pMTY_5TmUU1XM6YnoWtSU
X-Proofpoint-ORIG-GUID: tb_-ahigq50pMTY_5TmUU1XM6YnoWtSU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNiBTYWx0ZWRfX8wpMOcrpJ1KY
 SzxVmKApwCasVkHr8mfeAI8KrLdBze1J1ROIUw6NrZJH3yYQktrp4fYD4chZLLfPNhAyrqnL3oz
 8RuVM83rQATnNcNNN0SOIJrYCSBdsanyGFed4Gt1yFCab36tRDVXn+KqaBGF9x/sfZmaLDOzvRk
 KRHz95/OfTgQE84EtF9C6nCCL+1FO6s9la9d9O7dzC2mOffzn3dp/BMapPy7Zcevz1PU7dG73NE
 W13QGm/ljox4TqsAwzAMN4qmmEAZ9+nb8FTLxb/iExFu2nErIAe/5wk2zB2AM9nBv9GGLApTsZ0
 gcsmAoVPfTdr44YZMNO4E+ArRx0M62pNAteWAIKF3TiEPZNa/+zO2QdZGgyHXjRXH+TJikdOZUw
 TV+5OO91Zafamrih2XUQBft3kkQWrHnxhNFip76VFWItv01rvX4JElbRsgfpLLeKPmFoYBEl
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

The AMD I/O Virtualization Technology (IOMMU) Specification (see Table
8: V, TV, and GV Fields in Device Table Entry), specifies that a DTE
with V=1, TV=0 does not contain a valid address translation information.
If a request requires a table walk, the walk is terminated when this
condition is encountered.

Do not assume that addresses for a device with DTE[TV]=0 are passed
through (i.e. not remapped) and instead terminate the page table walk
early.

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 87 +++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 75a92067f35f..6d1e7cc65f83 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1612,51 +1612,60 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
     uint64_t pte = dte[0], pte_addr, page_mask;
 
     /* make sure the DTE has TV = 1 */
-    if (pte & AMDVI_DEV_TRANSLATION_VALID) {
-        level = get_pte_translation_mode(pte);
-        if (level >= 7) {
-            trace_amdvi_mode_invalid(level, addr);
+    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
+        /*
+         * A DTE with V=1, TV=0 does not have a valid Page Table Root Pointer.
+         * An IOMMU processing a request that requires a table walk terminates
+         * the walk when it encounters this condition. Do the same and return
+         * instead of assuming that the address is forwarded without translation
+         * i.e. the passthrough case, as it is done for the case where DTE[V]=0.
+         */
+        return;
+    }
+
+    level = get_pte_translation_mode(pte);
+    if (level >= 7) {
+        trace_amdvi_mode_invalid(level, addr);
+        return;
+    }
+    if (level == 0) {
+        goto no_remap;
+    }
+
+    /* we are at the leaf page table or page table encodes a huge page */
+    do {
+        pte_perms = amdvi_get_perms(pte);
+        present = pte & 1;
+        if (!present || perms != (perms & pte_perms)) {
+            amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
+            trace_amdvi_page_fault(addr);
             return;
         }
-        if (level == 0) {
-            goto no_remap;
+        /* go to the next lower level */
+        pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
+        /* add offset and load pte */
+        pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
+        pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+        if (!pte) {
+            return;
         }
+        oldlevel = level;
+        level = get_pte_translation_mode(pte);
+    } while (level > 0 && level < 7);
 
-        /* we are at the leaf page table or page table encodes a huge page */
-        do {
-            pte_perms = amdvi_get_perms(pte);
-            present = pte & 1;
-            if (!present || perms != (perms & pte_perms)) {
-                amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
-                trace_amdvi_page_fault(addr);
-                return;
-            }
-
-            /* go to the next lower level */
-            pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
-            /* add offset and load pte */
-            pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
-            pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
-            if (!pte || (pte == (uint64_t)-1)) {
-                return;
-            }
-            oldlevel = level;
-            level = get_pte_translation_mode(pte);
-        } while (level > 0 && level < 7);
+    if (level == 0x7) {
+        page_mask = pte_override_page_mask(pte);
+    } else {
+        page_mask = pte_get_page_mask(oldlevel);
+    }
 
-        if (level == 0x7) {
-            page_mask = pte_override_page_mask(pte);
-        } else {
-            page_mask = pte_get_page_mask(oldlevel);
-        }
+    /* get access permissions from pte */
+    ret->iova = addr & page_mask;
+    ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
+    ret->addr_mask = ~page_mask;
+    ret->perm = amdvi_get_perms(pte);
+    return;
 
-        /* get access permissions from pte */
-        ret->iova = addr & page_mask;
-        ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
-        ret->addr_mask = ~page_mask;
-        ret->perm = amdvi_get_perms(pte);
-        return;
-    }
 no_remap:
     ret->iova = addr & AMDVI_PAGE_MASK_4K;
     ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;
-- 
2.43.5


