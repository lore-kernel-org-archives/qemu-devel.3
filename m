Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E54C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKixh-0001fZ-6J; Thu, 29 May 2025 15:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixW-0001MM-VP
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixU-0001El-Dd
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfqDT014955;
 Thu, 29 May 2025 19:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=1ddmy
 7BlvHA/fNZ2qMHqGnIPgWgsX2CZXKk2KXkuGcI=; b=EvB+dOJb1mSCKOUI0pRzd
 /BXHETts6aWQBIh+mq5CIw2EH/a39FzDv882Dh0lVbE3g6QdVMkmgif9c3yRy8iF
 c0oI39mEiggpeZKHrq7UzyBNSxvYU3LGdP2pCWa6JP9wtDU6holfIIe2btv5d2oC
 3xlEhB98KV5SAdGZ5PWXqxsGNOsO9BtHWi9hG+mwoXg9g7F9fUYh1whm7YoSd+vd
 dflsHkvy2e9hOtsVuijVC+ZyKql7E/6M+setxYwzRtMDak6GEnr9QkIG8xcO8Uni
 yhDcJ2SnJuTcDAwz4doU8V96Vg6NA9ipS7IPv/mCtGB14UgI12GDpsu8xYDjsjU3
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s8tm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJPFnY019186; Thu, 29 May 2025 19:30:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jccs1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJUOVF005039;
 Thu, 29 May 2025 19:30:27 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jccrx6-6; Thu, 29 May 2025 19:30:27 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, brijesh.singh@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 5/7] amd_iommu: Fix mask to retrieve Interrupt Table Root
 Pointer from DTE
Date: Thu, 29 May 2025 19:30:21 +0000
Message-ID: <20250529193023.3590780-6-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
References: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290190
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE5MCBTYWx0ZWRfXx/+b3ZDQuSz0
 q74spNMiWwVkMV1Po+SxCfSDwyz19zFmSu+nRXAaImzbHWDmIQW/B/n/+lho54/QhtMw6pUSwkv
 M5VIqUrIZACmGt7Rks+9fehf1SMl9yLjHGfSaLlaK7kf0hfQ9F41I52BxsHoM4eQkozNn4Toxcr
 Ttt9j7uRf2U7qMSIe5inqO5S9Y8kw3svoJk7p7N++JKxvqpzL/tiLhIhGpdlcwlFoyh5OjP4YBy
 3+38E+q1oP4+IlGiU4yEdEmswvBSlrxRJg81t0bH3muhpqa42YZtkdsDTFP459pR6Zhq53mbV3K
 WflTRntmbxLXpkk2ozH07sK352Sn5r64b8REDk4yxq5jiHXdDaRc1LNQ/9mDjRP+pNOBdB+XdOF
 1gXdLOGROeq4gwjnjr16ucQwmKq6uFtaoi47GzUSrogb9mg6GG/Q9PU/ZfQRxtePbV6+JodF
X-Proofpoint-GUID: ocWV9EOKnEkSBYHkLvoM-C674qOa6p_1
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=6838b5d4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=VXbWx-IoamzKqho_xYMA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: ocWV9EOKnEkSBYHkLvoM-C674qOa6p_1
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
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


