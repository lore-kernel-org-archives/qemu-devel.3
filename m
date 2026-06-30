Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC400C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegdW-0007aW-QP; Tue, 30 Jun 2026 18:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wegcs-000776-Q2
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:08:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wegcp-0005tI-VC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:08:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UKtmIl1032476; Tue, 30 Jun 2026 22:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=iSUOo
 q/ySilwD8VG7eWnuavW3yvMxybrd6vtj6jAJWA=; b=SgNkzZ7q4Lwe95wVpDImo
 rZZ3sPXnnhsDm+r8JszjqOaNK6avhQ6sXvijIfY8Y748eqzXv9SV0W1uYBby3b3Q
 YsMDaw+SPr8YucolGTARIfVcYohmAHIO6awsNDin2r5qKpj9t0N19TsLoUoiXe4p
 ElNlkHDAEnFOcqxGeORdzFPkM7HnCIRqk3BHgPjguVLKVSRPw4dY5MwZ2FmDeyhS
 P21UgdkROqBXZZxKUqXq9hmg8SY0QffGyXn2bXreKfUAKsPX7ul6nbImjy2NJVYu
 nwXJnju36ijXmgq3CD5bklPMhCRcTYPMxK3uAlgbltuaDtnZfci15hYa8aMFQHtx
 A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26jq55wr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 22:08:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65UM3V96033998; Tue, 30 Jun 2026 22:08:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4f3u1w75w4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 22:08:08 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65UM87gF008507;
 Tue, 30 Jun 2026 22:08:07 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4f3u1w75vm-2; Tue, 30 Jun 2026 22:08:07 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: sarunkod@amd.com, qemu@demindiro.com, imammedo@redhat.com,
 peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 1/5] amd_iommu: Fix opcode reported in invalid command handling
Date: Tue, 30 Jun 2026 22:08:02 +0000
Message-ID: <20260630220806.1758748-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
References: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606300215
X-Proofpoint-ORIG-GUID: Vh-IPNQvkskqaW9-ML0_Uy9-DuQ2Iqqq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX8y3cGcuFztvT
 OmTkww++zBUeZMY1+Ch1zuRIgcs1AcjdOm0EYs4n99fNpFRbEpEwYkYkiOSbTN2kTZaWtGN5k7S
 /SITkWsWx4VhICq08Sl1qjb3jS8jJzRN78ePiE9wl+Hm2mXXuKf37E51c+7EHmNHdwgU5QE8UsX
 G2LmETKkLReiWgTNrVsMXJ1I4qZTBFBAWvc0DQ76kjqKQl9jIQvwOCuE6EpFsSktNDYsQSfcqK5
 9wI/mMAjsvLTKL0O2TnQDJT3X6V6pJSq0gK7tKoYj8HKA8J8rwN+CsCJjsZScGJykIoXif1g1sP
 ilRqQDbAt89cPguUIDLkZf+4Z5SNrC54uIzliXz1V3X8YHslNkz6UZWkfhjtgxXxeBYPO3wRnym
 0fXi/yogh4mcVgyCYuZo21E6zqSxVVH1oLvRuYdOile08i0p0rZbz/YC/md0WXmcVlHEOJS32P7
 mJwjnqEOe3PYmzV7/sJiN/CpeLJEbqOahy2sPU/4=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX2k5wxWP3iiOn
 L3751/yx/BzWO6a5jHs9cYlwcfRshC+Np+M9I0s+0TM9bZJ3CJx2WtD/w/MmpfVcL55aHu1ocFE
 dSd8Wk3oEDmfweKILuiT9ccSUBRkhAUKMyKk5tdeXKXSouBDq+K2
X-Proofpoint-GUID: Vh-IPNQvkskqaW9-ML0_Uy9-DuQ2Iqqq
X-Authority-Analysis: v=2.4 cv=XrbK/1F9 c=1 sm=1 tr=0 ts=6a443e48 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=RWxpEp7VAAAA:8 a=zd2uoN0lAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=GzNvJYq7lnVrn9pzyLoA:9 a=O8hF6Hzn-FEA:10
 a=3unh6Pbajv6CBnL1DxgC:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12313
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: David Hoppenbrouwers <qemu@demindiro.com>

According to the AMD I/O Virtualization Technology (IOMMU) Specification
(Rev 3.10), Section 2.4 Commands, the Generic Command Buffer Entry Format
encodes the opcode in bits [63:60] of the command buffer.

When handling illegal opcodes, the traces for unhandled commands and event
log info extract the opcode from an incorrect offset in the command buffer.
Fix this issue to avoid potential confusion with mismatched opcodes in
traces and unlikely errors in guest event processing.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: David Hoppenbrouwers <qemu@demindiro.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 79216fb305..05b7c638f4 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1509,9 +1509,9 @@ static void amdvi_cmdbuf_exec(AMDVIState *s)
         amdvi_inval_all(s, cmd);
         break;
     default:
-        trace_amdvi_unhandled_command(extract64(cmd[1], 60, 4));
+        trace_amdvi_unhandled_command(extract64(cmd[0], 60, 4));
         /* log illegal command */
-        amdvi_log_illegalcom_error(s, extract64(cmd[1], 60, 4),
+        amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
 }
-- 
2.47.3


