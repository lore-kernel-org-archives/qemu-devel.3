Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AE1103E2E0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 20:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0QLa-0006aa-18; Wed, 11 Mar 2026 16:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w0QLX-0006Ym-RD
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 16:39:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w0QLT-0002Cj-3g
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 16:39:58 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BHHGfk3369413; Wed, 11 Mar 2026 20:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=BsLjO
 9ynNveyU00eCvfgm3sqcdjJewkquOAyXCg2+00=; b=picgNzD8GaD1/O0QOWL7+
 LvFFz5A3RfFErPDIFmTvK9S0Fwb5/bBwx/uACG20Zgef4d8bA0MhTMUgn2Igszrs
 +1m/5PqiDYUi4VnGJuyDR/EIbhyHo5/aIuV7F3eZFlQWh7IJA+rzb1uMKUKUAhtr
 I6zYkf6hv2C/CI9487cMujCUb6H25XIoVUtwIl+eEHCKHya2eiWAVWRrbDjc2NRY
 q8g/ypcEb89iWZtPZ0GdzaKjEBZmxYeFD/i865SEm5xO3Xjmb/eoGXOsSQKi6wSx
 BIu3+LGt1eF3t1IlkJiH2eRKl/PrLnvHhagNigc6qtQvpvTATZJN1Ic6/xdWqV7c
 w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csjnunsu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 20:39:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62BKCScd014947; Wed, 11 Mar 2026 20:39:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4crafgaky2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 20:39:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62BKdiEf019039;
 Wed, 11 Mar 2026 20:39:45 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4crafgakx4-3; Wed, 11 Mar 2026 20:39:45 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: sarunkod@amd.com, qemu@demindiro.com, mst@redhat.com,
 clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH 2/2] amd_iommu: Reject non-decreasing NextLevel in fetch_pte()
Date: Wed, 11 Mar 2026 20:39:43 +0000
Message-ID: <20260311203943.2309841-3-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311203943.2309841-1-alejandro.j.jimenez@oracle.com>
References: <20260311203943.2309841-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110175
X-Proofpoint-GUID: XL71UK7Wsw1xx8iul5RBdfBFbfQf7mnw
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=69b1d312 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8
 a=-NnEBHSy68KfNGN4co4A:9 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:12271
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE3NSBTYWx0ZWRfX1Fg+OD/a0oNM
 4dirQwr/xChrpGy/HI8nJN2LRgSdon1IDSIJAwNdydLVgz5wH5yH7E/5Co1D6G+x0WBSTy+s7/8
 4U/SYa0W8f7BA7VUTC7TNUdXmHm9emzivH/XnYxCC42FJZws/uDeFqeRC7jVJq3T9qc3YBDJhGV
 rldhkSFUYkMXiAejQaNbBzadpN81Km5vd1ZvGF94dnyzIcLmRoghy76V1PdQI7mdv5R/jI+E+4c
 cJvlOlhyNMNpByVgX9BZsatUD/pSGPpLgqj22o21i5XVUQTg99Nw1CTVAS32WE4vm44KT8w8aoi
 efLi3XB8NTTcxFa8uGE/n4RjSj4G73eM8EPn4RwPHwpLuakdjTxQRfh2vutP+iZRhryy+uaSTu/
 ZZ3TzOp0EzQAqFc3K6lzxxaped3PowonBhnxwVUr4RuBI9CGtfhwwETTMasAkOlak+vtTW12juu
 TbIHqk0wIgvk5jNAFzbHEZBMqfqxA0ye3j1h6ybo=
X-Proofpoint-ORIG-GUID: XL71UK7Wsw1xx8iul5RBdfBFbfQf7mnw
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 991c6c379a..a5c873b705 100644
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


