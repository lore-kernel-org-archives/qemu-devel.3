Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC7DC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYIv-0002E9-Jk; Tue, 17 Jun 2025 11:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRYI7-000126-Qt
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRXrn-0006tu-QB
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:04:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEXDrZ013182;
 Tue, 17 Jun 2025 15:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=LjaYa
 fom8TafeELPzF4Q5fuqiXlfP0RnnBbZinxkogk=; b=rEdhCyi0eVq7vth45QDdY
 qRUcUfWT85Dl0MbB6olIaoEa36E1m7WmVtgZJvJ20+z7456n5ktmzNXKySFTOsY8
 n40rVpC0sxqhyyQ4baORJWvjEwUzBeijiMxwT4veubXPGd/cq5rMP4I+oaMtWf0k
 PKAJhoAWEsU/JVsppWXktL7bkFq4Rm5cD2eBePHsWatiT3iy++/BTNtP6LSuNapJ
 OZOFn9nfsVsdsY3MfroOeBncpmcX4AnNCR4rmRIkDHD/OU7WcnQ4Ubu15n0r9WVt
 79xuVmc4bbA0anb30PYQLJ+rms9PjCuqEAYP61Hsl80wZijXuZX15Zc3bx5GP3gH
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd5h68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55HDhs4T000934; Tue, 17 Jun 2025 15:04:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 478yh9bxvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55HF4Svn014869;
 Tue, 17 Jun 2025 15:04:33 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 478yh9bxny-9; Tue, 17 Jun 2025 15:04:33 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: ethan.milon@eviden.com, mst@redhat.com, pbonzini@redhat.com,
 mjt@tls.msk.ru, marcel.apfelbaum@gmail.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, brijesh.singh@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com, philmd@linaro.org
Subject: [PATCH v4 8/8] amd_iommu: Fix truncation of oldval in amdvi_writeq
Date: Tue, 17 Jun 2025 15:04:27 +0000
Message-ID: <20250617150427.20585-9-alejandro.j.jimenez@oracle.com>
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
 mlxlogscore=862 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170117
X-Proofpoint-GUID: aOWDbcyZBpw03LpbfkNrIP4_hH1u6Jq9
X-Proofpoint-ORIG-GUID: aOWDbcyZBpw03LpbfkNrIP4_hH1u6Jq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExOCBTYWx0ZWRfX1lWhqGA6VkSR
 3ubpQ6Q7NAecAtHEn27VsYsS4nNJgwzN+SW6S1B4P65EFYuCgPt1puTKDhjRarhfdm3j25sQPJy
 a6ml2Vf+fHLvtqK7zfitwaDMR4zbqWNLcvXYUkoWljUKoooiftNIdWWKYtmeMspnj8DhdaNbN11
 HjUg46jwv+b+cDN3sQmwBX1CQ/qbirNI5CGT6J/K7+l/td7WEVAUFnHYOcuSWRh4Kj7jXZ0leXe
 LMAU1+qk2Wti80Y4W/SbnuIFhIpGpJ7HsTVSIfnWo0llkMbEVWEktTA9KVIC309f8I/fdjILI4o
 JXmp4jrT2oSet+yKQJHHSWBU1d5k/F1LR38Jqn4QW1ZwgW9LicdxfigK8Z4ZljV4eKsW+qlXNkO
 8jA+8mheaoWsgsVDnH1GTKQqYzMPBWNhJaLR4HaBnlDJ3vTsO3ySMGKzt91sblJBzzSruBok
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=68518405 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6IFa9wvqVegA:10 a=3GnX9RwCAAAA:8 a=69wJf7TsAAAA:8 a=KmqcU8Jcp4AhgOK5lSYA:9
 a=RF-RJRjNljZ93lortB_0:22
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
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

From: Ethan Milon <ethan.milon@eviden.com>

The variable `oldval` was incorrectly declared as a 32-bit `uint32_t`.
This could lead to truncation and incorrect behavior where the upper
read-only 32 bits are significant.

Fix the type of `oldval` to match the return type of `ldq_le_p()`.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Ethan Milon <ethan.milon@eviden.com>
---
 hw/i386/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 92f94dc788c3d..5a24c17548d45 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -140,7 +140,7 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
 {
     uint64_t romask = ldq_le_p(&s->romask[addr]);
     uint64_t w1cmask = ldq_le_p(&s->w1cmask[addr]);
-    uint32_t oldval = ldq_le_p(&s->mmior[addr]);
+    uint64_t oldval = ldq_le_p(&s->mmior[addr]);
     stq_le_p(&s->mmior[addr],
             ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
 }
-- 
2.43.5


