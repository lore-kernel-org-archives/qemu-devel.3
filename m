Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141ABC7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYJ7-0002gV-0i; Tue, 17 Jun 2025 11:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRYI8-0001Fx-Rv
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRXra-0006sQ-Bk
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:04:39 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEX1rs010319;
 Tue, 17 Jun 2025 15:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=VaMXU
 iOKm3NgnC47V/YBeh8gXdNxCaiFo4kpyggwQGI=; b=RMOfi5HHCTn+GRyz9m9mi
 E2zmZELDzQOYw4Ox9ZCVCnnJQ1EXyZdW6rcyXX5VA46YHfo6f+vbUH1n3fLVpZas
 /9KhyHo1o20yuBYWiiCKwlAuEMkmCb2H+1Hf4/E4ExVobjSZPBpVVx80Qzc1lsdr
 5dtD3ZQlunFPNAMOxAk53nj+2H2GZ5FprG3rogEA/XqllFx76ZT1hEmQ2Vzi/VQq
 JfWm9mEG2IKgQ/4Pp8IFPVYFN/vPcv11Z9EWnK1aJhXx/5+idFCNDYAUivhlrAJ0
 0O0N56/2fbIcLaWuxUIrTznoJnu1fTG+hRDEV7W6j/bAAI0QNCVASz0IHtmuqohl
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47914enfq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55HEdFdO001536; Tue, 17 Jun 2025 15:04:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 478yh9bxqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55HF4SvZ014869;
 Tue, 17 Jun 2025 15:04:28 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 478yh9bxny-2; Tue, 17 Jun 2025 15:04:28 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: ethan.milon@eviden.com, mst@redhat.com, pbonzini@redhat.com,
 mjt@tls.msk.ru, marcel.apfelbaum@gmail.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, brijesh.singh@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com, philmd@linaro.org
Subject: [PATCH v4 1/8] amd_iommu: Fix Miscellaneous Information Register 0
 encoding
Date: Tue, 17 Jun 2025 15:04:20 +0000
Message-ID: <20250617150427.20585-2-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExOCBTYWx0ZWRfX7+GJzZSbpBGm
 GMSn8KSAyLa5X0tCwiZUB/rLvEkF64FKIxj1VxLSGGLfOV1pjGLzriWkofPsN0Vnoy5fycUejh9
 DHEqSl7+9X+u8HsdG+huP/CM8fvUfoVc1L71vS6FQyp79JN7USHhVccOyPZj+6NhVTryoT7O270
 ZbegtDELf1NXYYX4VkdvslTx7cvHPZwOoQJF2jKQ+5KE7LCp+ukw9hIx+JRlu45Esy397uVwUmJ
 f4g5moyqaFDB0lvnSZc86pBcrJiio8A3XQ8atycsbOAlly1HHwA06Nzq/5ouUpVHEz99pozSkKs
 M4P1EAZbK5IVYpWJqPgfknlXIcIY3HRM0v/yUcFIYzjB5f1cmZvOCKs/6AfDJ2epN9sCDbotpwc
 jaau7T8uRaKl3wrdB8g/19UarqpnwTWhLmtWjk5IaqOP4rynX9AtkHJ/0CjTBdH0IUm/XuCL
X-Authority-Analysis: v=2.4 cv=U4CSDfru c=1 sm=1 tr=0 ts=685183fe b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6IFa9wvqVegA:10 a=69wJf7TsAAAA:8 a=3GnX9RwCAAAA:8 a=yPCof4ZbAAAA:8
 a=zUuKy9m3MhjO6OJNN2oA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 a=RF-RJRjNljZ93lortB_0:22 cc=ntf awl=host:13206
X-Proofpoint-GUID: P_YT3rtlxZfKXLGmQSOCej4tLboYNUcM
X-Proofpoint-ORIG-GUID: P_YT3rtlxZfKXLGmQSOCej4tLboYNUcM
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

The definitions encoding the maximum Virtual, Physical, and Guest Virtual
Address sizes supported by the IOMMU are using incorrect offsets i.e. the
VASize and GVASize offsets are switched. The value in the GVAsize field is
also modified, since it was incorrectly encoded.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Co-developed-by: Ethan MILON <ethan.milon@eviden.com>
Signed-off-by: Ethan MILON <ethan.milon@eviden.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 5672bdef89071..3b1d2e9da5347 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -196,9 +196,9 @@
 #define AMDVI_PAGE_SHIFT_4K 12
 #define AMDVI_PAGE_MASK_4K  (~((1ULL << AMDVI_PAGE_SHIFT_4K) - 1))
 
-#define AMDVI_MAX_VA_ADDR          (48UL << 5)
-#define AMDVI_MAX_PH_ADDR          (40UL << 8)
-#define AMDVI_MAX_GVA_ADDR         (48UL << 15)
+#define AMDVI_MAX_GVA_ADDR      (2UL << 5)
+#define AMDVI_MAX_PH_ADDR       (40UL << 8)
+#define AMDVI_MAX_VA_ADDR       (48UL << 15)
 
 /* Completion Wait data size */
 #define AMDVI_COMPLETION_DATA_SIZE    8
-- 
2.43.5


