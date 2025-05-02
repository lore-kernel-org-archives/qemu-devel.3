Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9C7C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfwx-0003rg-5H; Thu, 01 May 2025 22:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwt-0003qk-Pf
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwq-0007Op-RZ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:23 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5420OHYU008471;
 Fri, 2 May 2025 02:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=l8wqSnafwZD21ajKRWeLUWplHfz0z
 PtGNDCyTkVPJ10=; b=eDbbfEi/5qBTegg+JG7U5FxQjeMXOTFoWDuScppIWkNK9
 NP7erfqqPO4g1HP7lmHKKsIw6eJNq7PHqoPCYshmB9OenAb6bRqevGiFV2rkGiPJ
 l/SoeZxrzK6NtC9wbKKSqJkBCZDfSMIqHpQd112BpTj4eXjNk6toVyRu96V3krjE
 XlfhJhjnu7A6dCGgtOInafxa/rUilw6inLoSnG/NfhjWjn9NxNUHbDgEG1MmN0vK
 XEJF4xjvxZb9V9aP+qhho+tVS0Ew/I13Do248DIodhRsSqEXXxka3NRk2jXAL5v8
 hO20D+ruAv56MVDjVzD1XK0f16Zy0qhTTPi+FhxFw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukmea1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 542006AC023886; Fri, 2 May 2025 02:16:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkgyw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:07 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEro011525;
 Fri, 2 May 2025 02:16:06 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-1; Fri, 02 May 2025 02:16:06 +0000
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
Subject: [PATCH v2 00/20] AMD vIOMMU: DMA remapping support for VFIO devices
Date: Fri,  2 May 2025 02:15:45 +0000
Message-ID: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
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
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=68142ae8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ygo2aSQCugHJ6TXgb6IA:9
 cc=ntf awl=host:13130
X-Proofpoint-GUID: k5bAkTrL87qpt1dZHx6WPBqONiLJ3Bcb
X-Proofpoint-ORIG-GUID: k5bAkTrL87qpt1dZHx6WPBqONiLJ3Bcb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNSBTYWx0ZWRfX9KKDQWDuqNyd
 NtCn7nFRJkccfnOgGO5REshumkkneO1OghTOdei62Bx7XCeOCvCWi71GVoftdGkaGfTKQCd3Y7y
 Ma8UA4yWGIH6avoNgC7szl/XdPSvDfRK7wLasNRIeY4PfOIl48nvDuFDnekcG4hZrfiik9r/rn9
 HxezBiznCZb90GC17l6ZrF73CA5+OsNHUyqcAdGi+21IKGHTywS15XfUqWTyZM9q6SlcqpM5yIh
 4L7eiOX5OGzhwR6QWDm2tnYuShzYZBZFSbcO6V/TgVFVfw7B8y3SysHdek38+W4bT68FdW7JexN
 mdNkHpG+4bT5QKKM5BHCvD6rzYOTiPPcu7MIl7qg1Yd8yAEPCBDQ3x3/FaJqXzWaiPbvWmFAMeM
 WaAtWj1gsIMcjAhKjU2YuYvSVhAqfUw97tASfriq4ksvXAzNv72J3V0dU09r6GtFPwvm1cum
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

This series adds support for guests using the AMD vIOMMU to enable DMA
remapping for VFIO devices. In addition to the currently supported
passthrough (PT) mode, guest kernels are now able to to provide DMA
address translation and access permission checking to VFs attached to
paging domains, using the AMD v1 I/O page table format.

Please see v1[0] cover letter for additional details such as example
QEMU command line parameters used in testing.

Changes since v1[0]:
- Added documentation entry for '-device amd-iommu'
- Code movement with no functional changes to avoid use of forward
  declarations in later patches [Sairaj, mst]
- Moved addr_translation and dma-remap property to separate commits.
  The dma-remap feature is only available for users to enable after
  all required functionality is implemented [Sairaj]
- Explicit initialization of significant fields like addr_translation
  and notifier_flags [Sairaj]
- Fixed bug in decoding of invalidation size [Sairaj]
- Changed fetch_pte() to use an out parameter for pte, and be able to
  check for error conditions via negative return value [Clement]
- Removed UNMAP-only notifier optimization, leaving vhost support for
  later series [Sairaj]
- Fixed ordering between address space unmap and memory region activation
  on devtab invalidation [Sairaj]
- Fixed commit message with "V=1, TV=0" [Sairaj]
- Dropped patch removing the page_fault event. That area is better
  addressed in separate series.
- Independent testing by Sairaj (thank you!)

Thank you,
Alejandro

[0] https://lore.kernel.org/all/20250414020253.443831-1-alejandro.j.jimenez@oracle.com/

Alejandro Jimenez (20):
  memory: Adjust event ranges to fit within notifier boundaries
  amd_iommu: Document '-device amd-iommu' common options
  amd_iommu: Reorder device and page table helpers
  amd_iommu: Helper to decode size of page invalidation command
  amd_iommu: Add helper function to extract the DTE
  amd_iommu: Return an error when unable to read PTE from guest memory
  amd_iommu: Add helpers to walk AMD v1 Page Table format
  amd_iommu: Add a page walker to sync shadow page tables on
    invalidation
  amd_iommu: Add basic structure to support IOMMU notifier updates
  amd_iommu: Sync shadow page tables on page invalidation
  amd_iommu: Use iova_tree records to determine large page size on UNMAP
  amd_iommu: Unmap all address spaces under the AMD IOMMU on reset
  amd_iommu: Add replay callback
  amd_iommu: Invalidate address translations on INVALIDATE_IOMMU_ALL
  amd_iommu: Toggle memory regions based on address translation mode
  amd_iommu: Set all address spaces to default translation mode on reset
  amd_iommu: Add dma-remap property to AMD vIOMMU device
  amd_iommu: Toggle address translation mode on devtab entry
    invalidation
  amd_iommu: Do not assume passthrough translation when DTE[TV]=0
  amd_iommu: Refactor amdvi_page_walk() to use common code for page walk

 hw/i386/amd_iommu.c | 1005 ++++++++++++++++++++++++++++++++++++-------
 hw/i386/amd_iommu.h |   52 +++
 qemu-options.hx     |   23 +
 system/memory.c     |   10 +-
 4 files changed, 934 insertions(+), 156 deletions(-)


base-commit: 5134cf9b5d3aee4475fe7e1c1c11b093731073cf
-- 
2.43.5


