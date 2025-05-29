Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D24C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKixm-0001rN-NV; Thu, 29 May 2025 15:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixZ-0001Mb-JD
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixU-0001En-Eb
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:35 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfsbY028801;
 Thu, 29 May 2025 19:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=mYS068UBWcZqwke51ll5PH+5wr7OO
 nGFQ4vmK8X2Nt8=; b=CFDbLdROEOAG9Y2fn5gO8ojyIbvuFCj+k/cO57LpATce3
 LQbQpcJfBhWuZPdilyhEYMLdkg7I5byEDbxBir/DZehmIoeHq6rGiy8TiuwD1xls
 8kvYin8xLmv9ZaWmws09WiCZWGXmo2OtfTMkQ8BNmIqVYV/HFOvO1WDk5LX6m4WY
 dSVtRNALtXNYeJQoS5NXywUV9ijA766S/G84i0zdf1ZmoH0NUZgFgtAzMdyBi76s
 MivVbi5rePd8dPsk9oh1sld7Xt4dkMwv1ehWlm1caJKMmlfVdjqvZjrBVAsIStZ1
 eEJR4qJ3YMRN0O3KCmEWxZ+hHGGvm0KcVXKqHkdCw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd8r7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJSsCK019346; Thu, 29 May 2025 19:30:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jccry7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:25 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJUOV5005039;
 Thu, 29 May 2025 19:30:24 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jccrx6-1; Thu, 29 May 2025 19:30:24 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, brijesh.singh@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 0/7] amd_iommu: Fixes to align with AMDVi specification
Date: Thu, 29 May 2025 19:30:16 +0000
Message-ID: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
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
X-Proofpoint-ORIG-GUID: GkA5CQPi9FAYpJDhTcayO4PLJPkhjnqM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE5MCBTYWx0ZWRfX5rs2M7HSY1b3
 bx7BfNYBhNXwiPrnR5wVdUmT/r6BCsjFfd86r+/U5nNZV7+FlRq0YOiLD17/vdRjmw0nVKPkwpb
 3oZHGxz1JGg+CDqd4my9IjskUa5xzT/mA98Y+/0IZWEmvLIhZ7000xY0QFHNcz3rpLA4nCJvUAs
 X/0KVZ0zb6vU3Go6iasyMjKey0MLk4OBfw2pKfhrv/hRwJDogBgm2FVnzBbVM8FfS7CvPEMhcnE
 EHvT9QG9Ey/lotrXi+9kpkOKlvJDWzsnUDQhMuLl3B60m801sGgQtOVJhWhIQWEMrBkpwI+Carp
 EAtzjXWCe2Hgc8zMFZVwygOjIPfkF4cPW03PQQ3PUVxyyAWhdl+CK0BS3jkoZI5uzS7dKWZdpeC
 yvhkb3aLeXEQ14vOQJGzxpGJvxtFlpAOCwqMk1sFtQFFylDHPbBzcvhIa8QlhIqfK/+c36iW
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6838b5d2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Xi8gk91kliggzhbz9PoA:9
 cc=ntf awl=host:13206
X-Proofpoint-GUID: GkA5CQPi9FAYpJDhTcayO4PLJPkhjnqM
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

The main reason for sending this new revision so soon is that v2 included a
duplicated [PATCH 5/7]. I fixed a typo in the commit subject and missed
removing the old patch. Apologies for the mistake.

Additional changes in v3:
- Fixed typo on [PATCH 1/7] subject line (s/Miscellanous/Miscellaneous/).
- Added 'Fixes:' tag to [PATCH 5/7].
- Added Vasant's R-b to patches 4,5,7.

Thank you,
Alejandro

v2:
https://lore.kernel.org/qemu-devel/20250528221725.3554040-1-alejandro.j.jimenez@oracle.com/

v1:
https://lore.kernel.org/all/20250311152446.45086-1-alejandro.j.jimenez@oracle.com/


Alejandro Jimenez (7):
  amd_iommu: Fix Miscellaneous Information Register 0 offsets
  amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
  amd_iommu: Update bitmasks representing DTE reserved fields
  amd_iommu: Fix masks for various IOMMU MMIO Registers
  amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
  amd_iommu: Fix the calculation for Device Table size
  amd_iommu: Remove duplicated definitions

 hw/i386/amd_iommu.c | 15 ++++++------
 hw/i386/amd_iommu.h | 59 ++++++++++++++++++++++-----------------------
 2 files changed, 37 insertions(+), 37 deletions(-)


base-commit: 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e
-- 
2.43.5


