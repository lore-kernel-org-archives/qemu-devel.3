Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3321C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 22:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKP67-0003Ce-3z; Wed, 28 May 2025 18:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKP5v-00039O-4h
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:17:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKP5m-0000xK-1X
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:17:54 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SINEq8004604;
 Wed, 28 May 2025 22:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=vFNiR
 Oykw8a6G+qyAhVhibH5fEcHzpM0icJPAFmJjes=; b=fwzLEuE5xid+LGzJsrBhE
 b024ekw9ocC23c5lSruEpHdkjicSa3iYBkQQZQLo5LBsSnrTUmoxvA48mbLY83HT
 cmCB1s2qCarSzsTXnxtJ6YErWvQEcAtNBJja5Hue4TnQS+aNDH2MtrvUDzaJtSPm
 mGLncYkP6MKl7SuMBVuFSwm6m2KS3AH3rbHd+iZpcb2AaDYvs4gnMw3HKS2kvJFG
 Keb3YKdbvEudAnMmDnbYntjwAvp4khS6hxMsnH8UopjqsG1jfCyVPDhGqr5mt/9U
 a8ry0BoDno4MmUCfnkLiq5TwjEpcW6nvf2enRjsKkANalJ7Uj59xGNtWSDzhkeSt
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46ty26m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 22:17:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SKveXK024624; Wed, 28 May 2025 22:17:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jb86vn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 22:17:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SMHQsb018695;
 Wed, 28 May 2025 22:17:29 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jb86u3-7; Wed, 28 May 2025 22:17:28 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 5/7] amd_iommu: Fix mask to retrive Interrupt Table Root
 Pointer from DTE
Date: Wed, 28 May 2025 22:17:23 +0000
Message-ID: <20250528221725.3554040-7-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
References: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280194
X-Proofpoint-GUID: XWNJp3W08e6ZRYp8SQFURDghWWSIrRL1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE5NCBTYWx0ZWRfX2TGwiB4MR0X7
 kgdgyzrzUJyE8qsK+obuWQrT+Jaf2x86lpp9IRio72slXl9Rmf0DGiulEPd3/ck5OeaiKRmlaVC
 oRPJdhUb70dGCFAZv2N70N60AXrD9nLddJPzm3F/eTzfNz73fMo8BBy3GWpwvw/7hPaplMP4uXG
 z7LBq2/ijdcb/pajTwhf9LlljDkmvbkVXceniGzDfP75vUF6P9f8/7nKgr2U7fSASa2V4Ea3Vyj
 SbV4jGWzWn30GAI0s5QVvA24dF9x5yepdnHwTSfGgMyl9GZi2H5/Un+nNaT4cOld11PwFdq+w/i
 2H4Qr7Tz+1sy5qukORibQHa5EH3uUK1bKF2k871ylLlXuxbDYgQY91dvNr2lUE+ygt5fKSfMbJd
 DNeowYBcgBLBDiCIPeYEW+3PP8ICisy2B/8WpkWpCVbyTPrbMxHieWVVEVziyPskP1EL30W9
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=68378b7b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=VXbWx-IoamzKqho_xYMA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: XWNJp3W08e6ZRYp8SQFURDghWWSIrRL1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) DKIMWL_WL_MED=-0.498, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix an off-by-one error in the definition of AMDVI_IR_PHYS_ADDR_MASK. The
current definition masks off the most significant bit of the Interrupt Table
Root ptr i.e. it only generates a mask with bits [50:6] set. See the AMD I/O
Virtualization Technology (IOMMU) Specification for the Interrupt Table
Root Pointer[51:6] field in the Device Table Entry format.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 09352672bdcc2..1836b7061d848 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -231,7 +231,7 @@
 #define AMDVI_IR_INTCTL_PASS            1
 #define AMDVI_IR_INTCTL_REMAP           2
 
-#define AMDVI_IR_PHYS_ADDR_MASK         (((1ULL << 45) - 1) << 6)
+#define AMDVI_IR_PHYS_ADDR_MASK         GENMASK64(51, 6)
 
 /* MSI data 10:0 bits (section 2.2.5.1 Fig 14) */
 #define AMDVI_IRTE_OFFSET               0x7ff
-- 
2.43.5


