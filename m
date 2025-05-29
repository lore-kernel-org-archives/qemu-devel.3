Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE7AC5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKixm-0001rT-PG; Thu, 29 May 2025 15:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixZ-0001Mv-NP
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixU-0001Ei-ES
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:35 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfx59003915;
 Thu, 29 May 2025 19:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=6w8lc
 8uwVkcsZ44yUBLqPwjDfl/iXA+3yeIb/VWXrIo=; b=STDhsQi8rw+sMZgGylA/3
 nhjT6tSMWDJqnhITszTRn/hMrT+E+9Syyajio6U6Ai/WaKbDaNZmei+M9ZKCxJL7
 1Jt6sOXZnUst7d2+VvwD/fTcYJWb2vFg1pv5dFLQPF6pBB22Xcq7wjcWItUxSKtJ
 kXajEGIKabWiBF6ofUgRoFAUyC1KK6edrLA912jP+ctG96nTZRSxT9JJ/2itPVfb
 bMmwaU0PIlxhGQ4D3WFY3Qb2zIzmMZpCaX9TGuiaOTFFDCeWpVJsaH/mAYK8bNfY
 mbKgYfU6ik6ggckvWdDDtO1O1d+kF/zc25ydcCoZqIPY6SUSYjzD71s7X7LB1LCs
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2pf0nbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THeh1G019225; Thu, 29 May 2025 19:30:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jccs0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:26 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJUOV9005039;
 Thu, 29 May 2025 19:30:25 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jccrx6-3; Thu, 29 May 2025 19:30:25 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, brijesh.singh@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 2/7] amd_iommu: Fix Device ID decoding for
 INVALIDATE_IOTLB_PAGES command
Date: Thu, 29 May 2025 19:30:18 +0000
Message-ID: <20250529193023.3590780-3-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: cNGxpxmsXuo-A7v9nCfPLGS1q_TvxGXG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE5MCBTYWx0ZWRfX9/YThrV3Lxaa
 Om8r5wGIZ1H1DwD+gmOWvTU5tiaXkFsj4bu5rA8sLe3gwf+OFeMrNK8egl/8b8+V7NBQtVRg1w9
 L6kEriO5z3vrDGNk2H8KAi3ETZCuXdv0bTrl9K3ZAJitsvfJGNm1IOgntKhCoH9FttAW5OnuNhd
 5ZbMYX/OHhZc9CA+Fi1mDZZlj6m2yJslt9ssT9899e2qDsuVCZUg/4QXWdYOUp9gYndeVn3zIqU
 obRhWDVphsg57UZwlI+ewgN8QFMaEG453okDtRx73gFXX3IDQ+Jxonx0xdRnQbHkVOCvIo0Uy39
 pRxNH5ZGSvK9LkhovkwT5FYuAGi1K7xmJuPhQfD2RUTnHFBrdLniRzirIqX/A55wsjOKg9spnNe
 1Nl3KZe5VeXUlwPX97Edgza9F/szn3pKT/MTKv0mTvd7RsOs57RWYjmPVB/L0zKued2up4fg
X-Proofpoint-GUID: cNGxpxmsXuo-A7v9nCfPLGS1q_TvxGXG
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=6838b5d3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=r9zmrm_j51NoiylAmAIA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
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


