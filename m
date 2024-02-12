Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C727EC4829F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 13:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWo8-0006Wk-SR; Mon, 12 Feb 2024 08:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWnz-0006Uy-UH
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWnx-0007Bo-Me
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:07 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CDnj8n032235; Mon, 12 Feb 2024 13:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=dnuLDRZ3k3dpBNS10oEuEJoo8H9vYfExkUJEWYOW7Lc=;
 b=MuZkE6jpfN+mr6AoUXVX8e+5028OWIO6DqhOnrbl57rQKtJEkngk2X6wRmgfAYyhQkHq
 Fxuw++wJTZUieSDg1MKC0/JP1IgzFY1utXhyZywJZFBrcyJHEK6c/ss1aMMympXJGM20
 dWDebHdK2soMjZV2Qx+0M40VCU5Uv/8GighnYpNJO+pg41XhwNXFtWihymAr5X2t2tPH
 XH+d6I517oeuXU5cZy5V/3a5fkwpoZttoYgDBe+AJE4QjKYW0UYp/khYVnOF9JcOtxLx
 J403T5ZD7w0WrMsB1UzUMpHOxdebwYbE444Cn6KEakI5V6GBz7Meurxyi62sS/MSy43B 2Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7mj2g0gf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:56:53 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CCPvdK024685; Mon, 12 Feb 2024 13:56:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5ykc20sg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:56:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CDuqi3026744;
 Mon, 12 Feb 2024 13:56:52 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-27-30.vpn.oracle.com
 [10.175.27.30])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3w5ykc20rs-1; Mon, 12 Feb 2024 13:56:52 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH RFCv2 0/8] vfio/iommufd: IOMMUFD Dirty Tracking
Date: Mon, 12 Feb 2024 13:56:35 +0000
Message-Id: <20240212135643.5858-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=843 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120105
X-Proofpoint-GUID: TxmROaYGzyt_9QRovJXohHvw81ujWpb-
X-Proofpoint-ORIG-GUID: TxmROaYGzyt_9QRovJXohHvw81ujWpb-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This small series adds support for Dirty Tracking in IOMMUFD backend.
The sole reason I still made it RFC is because of the second patch,
where we are implementing user-managed auto domains.

In essence it is quite similar to the original IOMMUFD series where we
would allocate a HWPT, until we switched later on into a IOAS attach.
Patch 2 goes into more detail, but the gist is that there's two modes of
using IOMMUFD and by keep using kernel managed auto domains we would end
up duplicating the same flags we have in HWPT but into the VFIO IOAS
attach. While it is true that just adding a flag is simpler, it also
creates duplication and motivates duplicate what hwpt-alloc already has.
But there's a chance I have the wrong expectation here, so any feedback
welcome.

The series is divided into:

* Patch 1: Adds a simple helper to get device capabilities;

* Patches 2 - 5: IOMMUFD backend support for dirty tracking;

The workflow is relatively simple:

1) Probe device and allow dirty tracking in the HWPT
2) Toggling dirty tracking on/off
3) Read-and-clear of Dirty IOVAs

The heuristics selected for (1) were to enable it *if* device supports
migration but doesn't support VF dirty tracking or IOMMU dirty tracking
is supported. The latter is for the hotplug case where we can add a device
without a tracker and thus still support migration.

The unmap case is deferred until further vIOMMU support with migration
is added[3] which will then introduce the usage of
IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
dma unmap bitmap flow.

* Patches 6-8: Add disabling of hugepages to allow tracking at base
page; avoid blocking live migration where there's no VF dirty
tracker, considering that we have IOMMU dirty tracking. And allow
disabling VF dirty tracker via qemu command line.

This series builds on top of Zhengzhong series[0], but only requires the
first 9 patches i.e. up to ("vfio/pci: Initialize host iommu device
instance after attachment")[1] that are more generic IOMMUFD device
plumbing, and doesn't require the nesting counterpart.

This is stored on github:
https://github.com/jpemartins/qemu/commits/iommufd-v5

Note: While Linux v6.7 has IOMMU dirty tracking feature, I suggest folks
use the latest for-rc of iommufd kernel tree as there's some fixes there.

Comments and feedback appreciated.

Cheers,
        Joao

Chances since RFCv1[2]:
* Remove intel/amd dirty tracking emulation enabling
* Remove the dirtyrate improvement for VF/IOMMU dirty tracking
[Will pursue these two in separate series]
* Introduce auto domains support
* Enforce dirty tracking following the IOMMUFD UAPI for this
* Add support for toggling hugepages in IOMMUFD
* Auto enable support when VF supports migration to use IOMMU
when it doesn't have VF dirty tracking
* Add a parameter to toggle VF dirty tracking

[0] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
[1] https://lore.kernel.org/qemu-devel/20240201072818.327930-10-zhenzhong.duan@intel.com/
[2] https://lore.kernel.org/qemu-devel/20220428211351.3897-1-joao.m.martins@oracle.com/
[3] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/

Joao Martins (8):
  backends/iommufd: Introduce helper function
    iommufd_device_get_hw_capabilities()
  vfio/iommufd: Introduce auto domain creation
  vfio/iommufd: Probe and request hwpt dirty tracking capability
  vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
  vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
  backends/iommufd: Add ability to disable hugepages
  vfio/migration: Don't block migration device dirty tracking is
    unsupported
  vfio/common: Allow disabling device dirty page tracking

 backends/iommufd.c            | 133 ++++++++++++++++++++++++++++
 backends/trace-events         |   4 +
 hw/vfio/common.c              |  32 ++++++-
 hw/vfio/iommufd.c             | 162 ++++++++++++++++++++++++++++++++++
 hw/vfio/migration.c           |   5 +-
 hw/vfio/pci.c                 |   3 +
 include/hw/vfio/vfio-common.h |  12 +++
 include/sysemu/iommufd.h      |  17 ++++
 qapi/qom.json                 |   2 +-
 9 files changed, 367 insertions(+), 3 deletions(-)

-- 
2.39.3


