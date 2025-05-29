Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB5FC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiyI-0002G3-2e; Thu, 29 May 2025 15:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixZ-0001O3-Ud
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixX-0001FU-4D
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:36 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfqEk020744;
 Thu, 29 May 2025 19:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=ntEFO
 93N8wrcKDEMr4ZnQ7O4S1mRGt3UAzbpiqpqRTs=; b=h00o/Lno2Enj7GoHObuer
 /mtv8+2EIhS1AjHQ1Z/qTbAgLFT4jlrLzISh5Tkphjxjiq9sQPBjf9QbmZTIeAZB
 TQYTaEPoJoiq7120/FyEWzE1BZaHAjETdLVsYQemq8CTm+ayh8nQKs5lAUveJeUp
 JKhIoYfrf8ULQszESrefDF5e1/PaBD1mHXvV1Sxk3XObp+bmg954OHnPp10kBxHp
 HLXvgp/lIU8L5WsRGwUJRrRKaCUJ6azp+u0eMpmxsGXrs/YNN2fmgJkec5n1XNgt
 SrJMAPbkAze/d5OXhm9j9C2a7QpuWQhmiR18Xx4qxAUXMCJGwzaeTlVRBJcIRscL
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcmx8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJQgBF019271; Thu, 29 May 2025 19:30:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jccs2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJUOVJ005039;
 Thu, 29 May 2025 19:30:28 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jccrx6-8; Thu, 29 May 2025 19:30:28 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, brijesh.singh@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 7/7] amd_iommu: Remove duplicated definitions
Date: Thu, 29 May 2025 19:30:23 +0000
Message-ID: <20250529193023.3590780-8-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-GUID: -_mRZglMsFltSOsRc1dnqKk4joF--OaV
X-Proofpoint-ORIG-GUID: -_mRZglMsFltSOsRc1dnqKk4joF--OaV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE5MCBTYWx0ZWRfX7o5ZNeeUZ1qK
 xt0Xx0ARxRx5WJXRUYRza3UsQ2MPlO5v1DRWgTbkcMW6xFFXeIFQIkVlqt7Me8JHkdv/JAlgZ1K
 0O1gHw41ayslieJdNaDYyN0Ty6DckTwtHcURgrSWzCA/cys7Ysn/s7Qd6dodvNEFoCHpELV96cZ
 hs8wvCWrgw/3/2ZpVnbpFS/BvxjfwdWdihDqRwkDzGKpAXOu0TGpiPRdpinIZpOeC6tXHiy4gmX
 zSgro5iVqMuupzz95mG/oBwl0PLWNQD6ZHywO9zMqItFdmR2wr86zJB5gFd2M7MUkYfRCaccuHF
 iVPyp59m0fQN0/z/Yi04WYM/CQMxIIKXGcnMm8IA1XFCG2BDxRXK3xXjnVMM50HBDsIbEw66Zm0
 8VkOY1jBkm6+QV7zLpfeOwvAtKWnfOeq1Qk8T+rqMJiwmTCbdYiLC7h1yHArK8LaMM1Pd+Z7
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=6838b5d5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8 a=LyhGpKROpydgPnGzpJcA:9
 cc=ntf awl=host:13206
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

No functional change.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 1836b7061d848..31e473924fa20 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -206,10 +206,6 @@
 /* Completion Wait data size */
 #define AMDVI_COMPLETION_DATA_SIZE    8
 
-#define AMDVI_COMMAND_SIZE   16
-/* Completion Wait data size */
-#define AMDVI_COMPLETION_DATA_SIZE    8
-
 #define AMDVI_COMMAND_SIZE   16
 
 #define AMDVI_INT_ADDR_FIRST    0xfee00000
-- 
2.43.5


