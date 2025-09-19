Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8BCCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzile-00068L-Hc; Fri, 19 Sep 2025 17:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzild-00067u-3e
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzila-0002VJ-Cc
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtqE8014713;
 Fri, 19 Sep 2025 21:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=7H4V2
 VrFjZBy+LVQSl70wmnQDOc7ZHv4McywNcQTxH4=; b=D7vX675QFUcV2ECmi+jX9
 naR7kAdh1u2DGX6M9ZTPTOVD6+dpJ/WsdvY1qu+Ysm3Pl8z7zThTZfT03hrCXnHU
 nOlmr3cWUxt61ttc+L7PVDouOw6/sJhUcBv5rAq9oNEWN8wfF1aVIDC9bXHqtot0
 Kukz8Asa39MT62UA2oXdOHMV5KZV09ks3Fv2q9HyakeJ2RhzjPOSPW8K6oOOS1/N
 Tj92zuxXv+KOiGiVpHXVvxM0ft3NPedV9TxlkbBe8hzU5ycEXl9gr3SmVjUQAxjC
 JXygnHAA1idKxyEXPPqxyHgOhJcnP+9+B6QVUONBO5a1YVdjZmLqQ3YDPRxTTH7J
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbxdpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JL2M1w033717; Fri, 19 Sep 2025 21:35:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm09004301;
 Fri, 19 Sep 2025 21:35:33 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-7; Fri, 19 Sep 2025 21:35:33 +0000
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
Subject: [PATCH v3 06/22] amd_iommu: Return an error when unable to read PTE
 from guest memory
Date: Fri, 19 Sep 2025 21:34:59 +0000
Message-ID: <20250919213515.917111-7-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0uOTTIR7DdZ/
 ih9ay55qMiMZT/btvh9dA8B32/WCCcJZHtHCY2QcT2Ln4WokJ/zKFAO1jieFX69BrGEg7qRJ085
 WToF8kT7WqiemKSpX8f76PTvuuOZFU92/Dtr79ffHBIvaarNe/fEGfOhFvqRkZGeKnnaDOA3ll7
 b3kM7TBGfH6db802kTfqdO4+7fK3UdG1RK5+b9GwFNuXYb4FInJx+o4sppPFnVV96+IVUB5YXr6
 Ztjh+mhgVe0RnUQwAAjv8aXyB0lLS5Y2QjJY27C6OcviPyMWD5pGG03v4Kslu5UCD9/WRBjFhG/
 u1gjs3SpYhD6agifJnnPBOrsXOfN23MzAaxchz99Sd0qbFwZBErWA+KZB83gdpXbKMYpZBLbu5c
 wD9ruir3
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cdcca6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=R37TJkT3toX5d3LG1KMA:9
 a=FjD-8dGO14Yd8gSk4-3N:22
X-Proofpoint-GUID: ka7UQ2L7KNsql_Z6A6UwMCKSIxKpf8h-
X-Proofpoint-ORIG-GUID: ka7UQ2L7KNsql_Z6A6UwMCKSIxKpf8h-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Make amdvi_get_pte_entry() return an error value (-1) in cases where the
memory read fails, versus the current return of 0 to indicate failure.
The reason is that 0 is also a valid value to have stored in the PTE in
guest memory i.e. the guest does not have a mapping. Before this change,
amdvi_get_pte_entry() returned 0 for both an error and for empty PTEs, but
the page walker implementation that will be introduced in upcoming changes
needs a method to differentiate between the two scenarios.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index dc7531fd4a8b9..29ed3f0ef292e 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -528,7 +528,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
                         &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_get_pte_hwerror(pte_addr);
         amdvi_log_pagetab_error(s, devid, pte_addr, 0);
-        pte = 0;
+        pte = (uint64_t)-1;
         return pte;
     }
 
@@ -1081,7 +1081,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
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


