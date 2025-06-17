Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B417FC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYIG-0001Xb-5L; Tue, 17 Jun 2025 11:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRYI7-0000vN-KB
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRXsQ-00076j-RV
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:05:33 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEXDZG012810;
 Tue, 17 Jun 2025 15:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=66pgN
 YGDKbghLS1TEv4zQ3PHBw3c2sjasWk8q2OjnXQ=; b=QXmAiipKaphBYq1Khf5+V
 uWBIJio00GSH8ZS2R5n/gK8fBEOeoWtrp5mkP5gkZMMB0TyiF7eC0/Jn8kWSpbXR
 sZ48lI9AOR2c8AQbXb0PBhiBgn6Ne7oGvc05YHwyHyfuDOxlPZFAaypwedQKkQO+
 5Y08uTGHWAcCn5lXM/lC8eBo4P+LDch7/DDGFe4d7kBdLrK2Y33fvEdWiGux9nlg
 Hc2mTLhPn2Y27xslian3cRFiit5jRxPO0cPYfcSGB0C66iERpfGYPiDKrYkbAUc5
 nYTvBx0ZSG4ectg7xaJNRBheDlPoKDCVmyhy7XOgFXl8ssIl9Mwt4XBd2Bmzg78k
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47b23xs0wb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:05:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55HEedae000822; Tue, 17 Jun 2025 15:04:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 478yh9bxtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55HF4Svh014869;
 Tue, 17 Jun 2025 15:04:31 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 478yh9bxny-6; Tue, 17 Jun 2025 15:04:31 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: ethan.milon@eviden.com, mst@redhat.com, pbonzini@redhat.com,
 mjt@tls.msk.ru, marcel.apfelbaum@gmail.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, brijesh.singh@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com, philmd@linaro.org
Subject: [PATCH v4 5/8] amd_iommu: Fix mask to retrieve Interrupt Table Root
 Pointer from DTE
Date: Tue, 17 Jun 2025 15:04:24 +0000
Message-ID: <20250617150427.20585-6-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
References: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExOCBTYWx0ZWRfX9lvUNp3uq9Ui
 Uhk5B9Y35QV47FIWRKbEmQ/YgE0oA9aeoph5CAJcTglxoBNuznHY4lLRsCHDPz8Bs8sdkOuTOBB
 zBAil2mE1dUNYHI8kWm1267U06W/uWLuht8tyQxW9cVx2nhdPWu+7nfhV8NdHtM4GdIS0m7ls1/
 0lk5xdJ8IBaXT21MURo5O95rotpTbgMLvvhX7VnxC/Za8113dOuIhEGKipuLjfERpwUey/f74RF
 VKiBOy3pVJw4M7LnqUn7IasmwDwzSBeK755W0AkPMVAbL4tdgMB0gMYBCyyi/tSSbN94M9SYs52
 nj2zzhKZToQceku/5m9B959bBFzlmj8nuswtRuTb+6TUd/UJqu307xZpni5RTIHfI4hB1fViy35
 fOtC8c13CyTuaJOu8Imf+OkPkXvWXxzSbAoiP03uvWvLD4MTn2sHsGEZS7YhBrIiJSFhD76+
X-Authority-Analysis: v=2.4 cv=DM2P4zNb c=1 sm=1 tr=0 ts=68518429 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6IFa9wvqVegA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=VXbWx-IoamzKqho_xYMA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
X-Proofpoint-GUID: Cg3HqFDKm4r5zuNbANtCHWJxyFafQj_s
X-Proofpoint-ORIG-GUID: Cg3HqFDKm4r5zuNbANtCHWJxyFafQj_s
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fix an off-by-one error in the definition of AMDVI_IR_PHYS_ADDR_MASK. The
current definition masks off the most significant bit of the Interrupt Table
Root ptr i.e. it only generates a mask with bits [50:6] set. See the AMD I/O
Virtualization Technology (IOMMU) Specification for the Interrupt Table
Root Pointer[51:6] field in the Device Table Entry format.

Cc: qemu-stable@nongnu.org
Fixes: b44159fe0078 ("x86_iommu/amd: Add interrupt remap support when VAPIC is not enabled")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 988a485f808cc..96fc5b621e609 100644
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


