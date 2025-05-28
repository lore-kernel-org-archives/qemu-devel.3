Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C31C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 22:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKP6Q-0003KG-2N; Wed, 28 May 2025 18:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKP5y-0003AJ-13
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:17:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKP5o-0000x8-Ou
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:17:57 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SINFQW026722;
 Wed, 28 May 2025 22:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=6w8lc
 8uwVkcsZ44yUBLqPwjDfl/iXA+3yeIb/VWXrIo=; b=I97Zs35ZBf7+lpBC7cyDv
 Qb3f7CH9F48QPcekYThuLU4gv3gbxtpXyBuP1w+r+zSm4J1xxSnOfnxqXyN6bU/m
 NcfiQVcnPNckLPXZhMq/8bhKA/FzN288kb4Bd/2ZCln4DDs+lxI82TmsoL2+9HnH
 j7W/8S/F6es+VZB07NuvZIutEtQydP3KAVrkcX491sRn1MHacwdv0jE1CQaiGd30
 xSTboNyxFV09w35oHcTJBoo8KDJGdrnoKJxGIhl0TDqgn7cxjfnalYUuYvzrfZmz
 NVkgMZ6MMqRZnbgxukrPZ1tBH39NjYSTmCOu2xi/b58uZgPmllSi7JtPp1PGzWal
 A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd6v91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 22:17:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SLFJdS024428; Wed, 28 May 2025 22:17:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jb86uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 22:17:27 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SMHQsT018695;
 Wed, 28 May 2025 22:17:27 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jb86u3-3; Wed, 28 May 2025 22:17:26 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 2/7] amd_iommu: Fix Device ID decoding for
 INVALIDATE_IOTLB_PAGES command
Date: Wed, 28 May 2025 22:17:19 +0000
Message-ID: <20250528221725.3554040-3-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: NjM1b47wVkTAzco_E--bh7cUjgYQeCkj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE5MyBTYWx0ZWRfX0Mds9ZleCYq7
 AAicvsz1m+X4671iBLo6ZYfPR2SBYII+5BOv3lBqfD+QdhhVucTLvVCZ77ifEFn3ut4o2FOYqwd
 Uj+P+tUgAmRRAie7ys0ML0qukAs+RUuHUmjOMaMUiLQX84OT//O5Df7qhGAasmMjIIncn9+xp4l
 vTaN3Tx+q0/9DHHWCCSr4uiCd+/gLEBkJhSfFQ/WTUS5VJOxmpGVM2dk4O6bKhhTeouIPC4kX6a
 rFFUUAmYWOU5mhfzBUG1ic7vbsUctZVw4EC7QSysLCGW4isviqNb2Pz6hWAIqJSQyxwj1j+Il7s
 OCkLO/L8fCUxOsFN7GP6R3627QWHQuVjXSL6itja904CWf9zDQQNbBAN/J9Byh3Nu7aLs8egSu8
 GmKSxVPXywrkzfCOuWHKCVC/BOrqRmAtmci30TA7YVKKcetJB3pUHn/6bv4mcMXssylNdI7f
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=68378b79 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=r9zmrm_j51NoiylAmAIA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
X-Proofpoint-GUID: NjM1b47wVkTAzco_E--bh7cUjgYQeCkj
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) DKIMWL_WL_MED=-0.498, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The DeviceID bits are extracted using an incorrect offset in the call to
amdvi_iotlb_remove_page(). This field is read (correctly) earlier, so use
the value already retrieved for devid.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 0775c8f3bba8f..55202eb9ef7d6 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -508,7 +508,7 @@ static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
 static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
 {
 
-    uint16_t devid = extract64(cmd[0], 0, 16);
+    uint16_t devid = cpu_to_le16(extract64(cmd[0], 0, 16));
     if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
         extract64(cmd[1], 6, 6)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
@@ -521,7 +521,7 @@ static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
                                     &devid);
     } else {
         amdvi_iotlb_remove_page(s, cpu_to_le64(extract64(cmd[1], 12, 52)) << 12,
-                                cpu_to_le16(extract64(cmd[1], 0, 16)));
+                                devid);
     }
     trace_amdvi_iotlb_inval();
 }
-- 
2.43.5


