Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C75B1061B25
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7K9z-0007u5-DK; Mon, 30 Mar 2026 17:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w7K9t-0007tX-Qr
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:28:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w7K9r-0006FJ-AU
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:28:29 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UDE4rN2688916; Mon, 30 Mar 2026 21:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=PUBDt
 J6AfZbEHbQfS8h18N/UDHSyrsuMjYLAhmKpNQM=; b=e8IozFdEgIGIktsQXCc5C
 HuNKVnUw29NZKQJYs0pmfDgORMmyRV35AkAoV71I3/fJXSOD/NhQF+7j7qSAB86c
 XBgLY2EOlH60RTq6biDE4OreIuO4xC3fPU3RbqCskv9jB/TDDdHaVfSRKII+EGOe
 RUIZc6WH2lXzMluxTa9cMwf+t/QeRZ0EoufnZ5m+l/NKbTrnEfQGNAGOBtJHinKk
 a3s3tDLwbnA2Qw5yXV5eLvkEQjvQ9HJa1UGpHNpQF0LWk8RYMd3yEAJG2PWfo0n9
 /Jf26B8KdIDNVwW2SBMnxO+OXu/2LvYDeuSKqgT1FecEg/OSR4p1qt7Aerfnng/O
 w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d66v5k3en-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 21:28:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62UK8468036391; Mon, 30 Mar 2026 21:28:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4d65efn547-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 21:28:19 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62ULSIT1018888;
 Mon, 30 Mar 2026 21:28:18 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4d65efn53s-3; Mon, 30 Mar 2026 21:28:18 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, sarunkod@amd.com, qemu@demindiro.com, qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com
Subject: [PATCH for-11.0 2/2] amd_iommu: Reject non-decreasing NextLevel in
 fetch_pte()
Date: Mon, 30 Mar 2026 21:28:17 +0000
Message-ID: <20260330212817.992673-3-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330212817.992673-1-alejandro.j.jimenez@oracle.com>
References: <20260330212817.992673-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603300182
X-Proofpoint-GUID: 93S0iHTJ_2KG967CT-dWA0_fFxS7C-Li
X-Authority-Analysis: v=2.4 cv=G7cR0tk5 c=1 sm=1 tr=0 ts=69caeaf4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=69wJf7TsAAAA:8 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8
 a=-NnEBHSy68KfNGN4co4A:9 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:12276
X-Proofpoint-ORIG-GUID: 93S0iHTJ_2KG967CT-dWA0_fFxS7C-Li
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE4MiBTYWx0ZWRfX6MdBkpAgDwY2
 09QFsxs3H/Src6HuLPHJvK7EUovIexMUgBNn+1/qxNyricjf0LECjvtoKFciKo5BFHQU4FuNXQR
 S/V4o1ENRqROLW5WkbgQ6lXWN6GOG19I55EK/kAWPTypzMFaAKxBSpnTkD4F6Q30/vW7QOMEVH+
 ehONb/LbLoJtOI0lzPGZix8F7HuBpHoOLGIkBEj+d5kUpWG0j6G48RGPa35ITlj6H5aS+Ky+pCr
 hGD3yOCQEdZGasa8CJExbtGhUJDHMHRcI+n0oo4coB5WLzK3JKcsHfkZNw3Ds2x3phSyDf/jGQg
 7OJ66NfbRhtZhicXhSAErNnhqEohQBA0CA+oxcZqlvI07vJsg2IoNWyDwy/v8X/qhJfmE6uTQsY
 7aSdGl5gnC7Jz4VP44RopcGqoxglfxIox5wwkZY1uMocNspd9WwePoB351eFunph4nXvgaxwcNV
 ILiSMuj2ls9/1ymUuasgSB1zyMpuGTkzolaxJo+o=
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The AMD-Vi specification requires that the NextLevel field for a page table
entry must not be greater or equal to the current page table entry level.
Enforce this to avoid infinite page walk loops on corrupted or buggy guest
page tables.

The initial implementation of fetch_pte() did not implement this check, but
was not vulnerable since the page walk code explicitly decremented the level
instead of retrieving it from the page table entry.

Cc: qemu-stable@nongnu.org
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 04acfa645f..603fb91004 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -771,6 +771,10 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
             break;
         }
 
+        /* Next level must always be less than current level */
+        if (pt_level <= next_pt_level) {
+            return -AMDVI_FR_PT_ENTRY_INV;
+        }
         pt_level = next_pt_level;
 
         /*
-- 
2.47.3


