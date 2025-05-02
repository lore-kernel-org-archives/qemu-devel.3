Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7E2C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfwx-0003rk-5t; Thu, 01 May 2025 22:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwu-0003ql-Io
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwr-0007P6-B0
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:24 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeNlu009470;
 Fri, 2 May 2025 02:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=hKrBO
 z8OIwOttjAENHLGK1nsTuVaVp/DcWOGP++OoSY=; b=a4zmTwlUpNPhQ+a9fMz6l
 e6x5emBF62Aea3zFGNuniQJY3+EFpqw0EIifGEbiFe2lH5Lm9/A18+n8kdN4wBYI
 /LUvnBUpjwQ1oLg82PAUXaXxn1txsrmT/SJQO7cZ/0IrxffiD8FMyvKYsSX/SxrN
 XjhbfKhvJeM2lTFb9bk92eAU1F7DYFIxa4JcisycKbTPjrlLnQsLsNkZeSKLQ4tx
 +P38sjPJMDq2uptEqx4yLRWQyHS1nu1J1j6jwoml8aDlimQj8mF11TbVJ6+hPdcZ
 y1BA1zagEQXh7Zd6Sjav0V7OA0L4YB1vyuulwJo9ZDcbbg6lMiHRf4e2XCtg3tnl
 g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utcbqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:09 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5421MJBX023814; Fri, 2 May 2025 02:16:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkgywb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:07 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FErq011525;
 Fri, 2 May 2025 02:16:07 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-2; Fri, 02 May 2025 02:16:07 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 01/20] memory: Adjust event ranges to fit within notifier
 boundaries
Date: Fri,  2 May 2025 02:15:46 +0000
Message-ID: <20250502021605.1795985-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020015
X-Proofpoint-GUID: G_5WN9qPnXwEZv7UuO8SS6CE95BnrHbd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNCBTYWx0ZWRfX+2mUSjIEkhj2
 YkjZPV5Xn1Lf8jVPfEBKOt8AgzqKfGUMEI/sJRP8NH/nbl7eVI+frvs9MtV6PeCRyMm40dLpqrq
 J3Doby5XZRUm0b6S9eg+PA5mF+KWHKTNgRxPfT+L1JCHgj+D4CUGxF6iHwrMCf49la+Ob8x5hXZ
 o2RFQKBe4Ejv2M31RRS8kD+Z/p7FD/Tv8NXoJndetZlYLH2ZbrniGTHx1q0VSDIZK+9ZQ33g3IK
 Fgf8daBqRVJSPHbHBCvt9OD6+cpkoJlqpKuYwl1MAKzG0rcnbUmTbLIIA1YQG1ng4fhBCPI6iJk
 mYs+gE+dUKDCekOZendPHIUmFVv5+YTZEvahGmXGEtJGA337cEepLfqVzqq5eiEKLPW6chqveE6
 do5cL5CBrKr7VNbMlcnW+l8lrg29iISNfF1kJiP7AS086vqiQyZ6gmgGpmIRGy4iWCf012PG
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=68142ae9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=JiNCCaSHPG-izbK7Su4A:9 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: G_5WN9qPnXwEZv7UuO8SS6CE95BnrHbd
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Invalidating the entire address space (i.e. range of [0, ~0ULL]) is a
valid and required operation by vIOMMU implementations. However, such
invalidations currently trigger an assertion unless they originate from
device IOTLB invalidations.

Although in recent Linux guests this case is not exercised by the VTD
implementation due to various optimizations, the assertion will be hit
by upcoming AMD vIOMMU changes to support DMA address translation. More
specifically, when running a Linux guest with VFIO passthrough device,
and a kernel that does not contain commmit 3f2571fed2fa ("iommu/amd:
Remove redundant domain flush from attach_device()").

Remove the assertion altogether and adjust the range to ensure it does
not cross notifier boundaries.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 system/memory.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 71434e7ad02c..7ad2fc098341 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2021,13 +2021,9 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
         return;
     }
 
-    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
-        /* Crop (iova, addr_mask) to range */
-        tmp.iova = MAX(tmp.iova, notifier->start);
-        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
-    } else {
-        assert(entry->iova >= notifier->start && entry_end <= notifier->end);
-    }
+    /* Crop (iova, addr_mask) to range */
+    tmp.iova = MAX(tmp.iova, notifier->start);
+    tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
 
     if (event->type & notifier->notifier_flags) {
         notifier->notify(notifier, &tmp);
-- 
2.43.5


