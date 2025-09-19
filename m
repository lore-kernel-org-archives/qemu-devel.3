Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17AECAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzild-000682-GD; Fri, 19 Sep 2025 17:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilb-00067E-TG
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilQ-0002Tv-S2
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:43 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDu89K017342;
 Fri, 19 Sep 2025 21:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=V/4Pz1/87AAhu3CcpJuxVCfYIxxOH
 oAxn+kecmnC1Bo=; b=aHZ+x+3sRnY/zG+bOzI2eSwaxw13s4dcp3HSooXg2Cvis
 w0ssb1XAGR8nsAz/8FZIraEYZeMPfkIqexbVYZEzoOjH0zeI14N/czgSH8NrOKp9
 k9igiD2fUcTxhhh9sSYwwNl/Nc+MR64gE10hPROdHI17VZpdag8SuOwAsREK58Po
 egH9W9JLlgVeWBl/1dyjVNr2E6hYsEv07c06tfi5xEzfiRtivMOEdF/ouT9ONty9
 2v/BKdsqi4080T2iM1YNO8flP2yMo6YxDfMSWnyGsFkQLrCT+JA1zSVDDnZ1NWuV
 c4VMXDK+DD1YFTZuhDHIaG8lNKsCv+6leNWTTgg1w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kefyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JLUdjt033676; Fri, 19 Sep 2025 21:35:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUmxv004301;
 Fri, 19 Sep 2025 21:35:18 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-1; Fri, 19 Sep 2025 21:35:18 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 00/22] AMD vIOMMU: DMA remapping support for VFIO devices
Date: Fri, 19 Sep 2025 21:34:53 +0000
Message-ID: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190201
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cdcc98 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=zd2uoN0lAAAA:8 a=q3mIixbF9PrL_VaT-24A:9
X-Proofpoint-GUID: 9GGOd0kfiJRJxl_4g2g_cbAB0eTbTXds
X-Proofpoint-ORIG-GUID: 9GGOd0kfiJRJxl_4g2g_cbAB0eTbTXds
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX516t+2TUB5bM
 +MOOpWR6bU0lzR6cKCLkv2wazKkW34S81O45i4m8SZxlo5e4UHDiKlc+6AKSmxV3iZHj2CKp+lN
 cQ2vQgPbhDgjA4vsrEwgt+BNNDIo8OsXRnklAZp6JNQsPE7/O5yOHeUAm5T70BQ2ENgEHbFCcAl
 qCaUVe6wyiiVago5kyRjGrz9Udb/s/iwZGx+sAO/fDwNzxmu3At/3iD8gzXvnYfv8LR733O7ksp
 6kGs6TraiMRnXF8JTN1zwwNk4m3VM6PePnezInNbVmZlnDhCJ9+iaB2hDhUAKCB6CjTmmbSp7Xa
 p3Dk1Aqsi0L9xBTX8RroQ4DHvsR7ojzKAjhBugnSkzl6rdEwe+0T/ZAXs6aX7G5DhkMD0o2fha1
 7qeTfLN1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series adds support for guests using the AMD vIOMMU to enable DMA remapping
for VFIO devices. Please see v1[0] cover letter for additional details such as
example QEMU command line parameters used in testing.

I have sanity tested on an AMD EPYC Genoa host, booting a Linux guest with
'iommu.passthrough=0' and several CX6 VFs, and there are no issues during
typical guest operation.

When using the non-default parameter 'iommu.forcedac=1' in the guest kernel
cmdline, this initially fails due to a VFIO integer overflow bug which requires
the following fix in the host kernel:

https://github.com/aljimenezb/linux/commit/014be8cafe7464d278729583a2dd5d94514e2e2a
This is a work in progress as there are other locations in the driver that are
susceptible to overflows, but the above is sufficient to fix the initial
problem.

Even after that fix is applied, I see an issue on guest reboot when 'forcedac=1'
is in use. Although the guest boots, the VF is not properly initialized, failing
with a timeout. Once the guest reaches userspace the VF driver can be reloaded
and it then works as expected. I am still investigating the root cause for this
issue, and will need to discuss all the steps I have tried to eliminate
potential sources of errors in a separate thread.

I am sending v3 despite this known issue since forcedac=1 is not a default or
commonly known/used setting. Having the large portions of the infrastructure for
DMA remapping already in place (and working) will make it easier to debug this
corner case and get feedback/testing from the community. I hope this is a viable
approach, otherwise I am happy to discuss all the steps I have taken to debug
this issue in this thread and test any suggestions to address it.

Changes since v2[2]:
- P5: Fixed missed check for AMDVI_FR_DTE_RTR_ERR in amdvi_do_translate() (Sairaj)
- P6: Reword commit message to clarify the need to discern between empty PTEs and errors (Vasant)
- P9: Use correct enum type for notifier flags and remove whitespace changes (Sairaj)
- P11: Fixed integer overflow bug when guest uses iommu.forcedac=1. Fixed in P8. (Sairaj)
- P15: Fixed typo in commit message (Sairaj)
- P16: On reset, use passthrough mode by default on all address spaces (Sairaj)
- P18: Enforce isolation by using DMA mode on errors retrieving DTE (Ethan & Sairaj)
- P20: Removed unused pte_override_page_mask() and pte_get_page_mask() to avoid -Wunused-function error.
- Add HATDis support patches from Joao Martins (HATDis available in Linux since [1])

Thank you,
Alejandro

[0] https://lore.kernel.org/all/20250414020253.443831-1-alejandro.j.jimenez@oracle.com/
[1] https://lore.kernel.org/all/cover.1749016436.git.Ankit.Soni@amd.com/
[2] https://lore.kernel.org/qemu-devel/20250502021605.1795985-1-alejandro.j.jimenez@oracle.com/

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
  amd_iommu: Set all address spaces to use passthrough mode on reset
  amd_iommu: Add dma-remap property to AMD vIOMMU device
  amd_iommu: Toggle address translation mode on devtab entry
    invalidation
  amd_iommu: Do not assume passthrough translation when DTE[TV]=0
  amd_iommu: Refactor amdvi_page_walk() to use common code for page walk

Joao Martins (2):
  i386/intel-iommu: Move dma_translation to x86-iommu
  amd_iommu: HATDis/HATS=11 support

 hw/i386/acpi-build.c        |    6 +-
 hw/i386/amd_iommu.c         | 1056 ++++++++++++++++++++++++++++++-----
 hw/i386/amd_iommu.h         |   51 ++
 hw/i386/intel_iommu.c       |    5 +-
 hw/i386/x86-iommu.c         |    1 +
 include/hw/i386/x86-iommu.h |    1 +
 qemu-options.hx             |   23 +
 system/memory.c             |   10 +-
 8 files changed, 999 insertions(+), 154 deletions(-)


base-commit: ab8008b231e758e03c87c1c483c03afdd9c02e19
-- 
2.43.5


