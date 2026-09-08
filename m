Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6EFC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vwx-0001je-Kq; Tue, 08 Sep 2026 09:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vwv-0001jK-LE
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:33:21 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vwt-0005Ws-CH
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:33:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKT8gqTHj7JowmFllEVSNFKcYgwAqCWcyTUEMWfEa/BsQqwsGnfu78T4QDsDDS+w18Jks9loIcldqf/qN6SVAiBjZeu7FxZWKQrMevSuw9GO/IrR+n/o3XQ6vVtVI9uYA8Ok8/XfxRz8l1+cGHSJeAUivAma4cfn2enmf6Rmr+BADEhEZ90FhhdoUwjY3NbFK32B7hLnFzXTcrCrucFFXqgf19OylDZuspbsfQbKkd+1h6AP3HxzUaYAs3kSKWpiVSw9N+M+kLf8TMXWP7tHP0LqxQgupEwQxiv7MWWsQGJhiKxRinpLCN/96GDE/Wea8wR4cajKqB8NxFIucLmA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1oSQxSOJoFUbtGYho3HhACVddtr5yeK6kSER9oo28o=;
 b=Pp/rpcHyrUfsWqzxjJVL9WlUZgxtIfGj4GaFte5lE7Wfr2ezuN+p6PHqum9Foyu+Cvfh7P3ykbMZKCCA/2J36VRJ879SIvLXIdoo+LAWQGvQsAiAe82nrc7w5ytaKz9y+QeEKcpnUk68yMf06f7d1jNWFbWL1a41yojtKEdpX49PgxIGX8Z/z+JLkPB3jm2/JHycXJnsFahanfkE102sdAzPPWUNyPJ9M+c/KpW3JmMICZ1vLqm8rh+MqqEd6Y+YU8qbp5ogbhpCWgS7Knx1vE9HaCWuEpxUg2qN9+iHPsPpIs8wwuwYegA6oHLlEvUWYq0Rn/u3HsR4mFmjADR+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1oSQxSOJoFUbtGYho3HhACVddtr5yeK6kSER9oo28o=;
 b=xSrPl94DozaRD7O71dkjWkHB997/Mt1u8ChjMse9FLiOnGqWYVOxuHH1/z5UzxWY+OsBFSgI1cgS0HodNJwmOFoKB3rFv+3aazxs1N+g3vtWSlXuMbTaWyxbl2VLlLQf3ksp24qd6MvciMpqIuinGA6/5fNZeqDrm0lLyH4mv6Y=
Received: from MW4PR02CA0025.namprd02.prod.outlook.com (2603:10b6:303:16d::11)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Tue, 8 Sep
 2026 13:33:13 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::5b) by MW4PR02CA0025.outlook.office365.com
 (2603:10b6:303:16d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 13:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC4.mail.protection.outlook.com (10.167.248.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:33:12 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:33:08 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>
Subject: [PATCH v5 00/12] KVM/hostmem: Support init-shared guest-memfd as VM
 backends
Date: Tue, 8 Sep 2026 08:30:50 -0500
Message-ID: <20260908133151.836685-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: a7538d76-e5b5-4b6b-ffb0-08df0dadbacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: rRevZA/5CtugEBJxNBc92R5HZKcbnDcGpm8oe88x4VlP6gsn9qc0R3SC3yNq/7r/ri96d51COiOD3qFOyVVAG3K8oO0jpWlkSNdIN1TV8hMxFg1PIHmmoGk6JS7gV59utld0Z8/j2R/o9D9tdI7R002lBORccja0B2tNEcPMuenHQ/tyeWpEkrf3RavWWq8eQPu0xU/UApnInlL9fzByzQoUbSKIksGgw5vlcipEu0g6TEMyynDmrJRRUCeaQbjkYzYcGP96WVF8aSpW/Y/l5nXgPZJm/+9zfTcjupLjpikvJMZ/tkYq0xfb/Y1PQcNhk1L80R6NAenJE/YEqN64jdAcOrxhefiVe67y/jsJhWCkqlUX6NzxD+OfRLpp+lXlifYCvCd3usbCGbAABtEGR6W+sA7jtIj4CeUWBGN3LnxBn1RCtU983wBsOTj2csbeOzdjt37DiwCnB3MkaXukM1tUdkNFWIfvMJFog+CqQX+Ak2yLVrFiofnGc/UpV3QHAaGEXNiZR0e+S1L0X8Wyl2RoWWTBBFbKSFgiiVu9NhTnu403uXNal0RgBQ5Ta+cAPUhH/CGrzxmXuNUwbX1Y3ZKYpnJ6NgrlvTJyy7dTpDBka+kXSzFb7P6D6V0Q/WELCNq7j+7rlW+yk7TcR3X4l99vaG63up/0TQtk+uvqDEA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 72fZfg16/N3q13Zkel/KTn68xgjQM8yxIevgnOD4vjVHSfx5YHdbsKVspxDAc5P8i/paVNlq6mPh9z102XqmaEHdqqKwRd8qLSVOUjGvZIXoK6568Ro+rzWOms+jnFlGUgOO61QS7r+G5fd22buYyE9avPrxdSOxs1RUHY6k7ZkbpsEfeq7tYqVVfvBL/89Dk3L/4tORJrLK+CTuFbivshYMlJOEWQ8ZJIXj2CQD+YXWXIYKDgHa7aTrRYmaUNeNpYELqpHYKtE25hP2A2i7VQct0VlHopOC1uA64gNegkmaQMnSKLZWvl3IW00qJr29TJXl9YIK25COCW4/QPdkBWggobzA9vj3gv/zc361wl+6tONfGbf0cLx56L2PfIaIx1SvbUVoYOT9b/wjrACPm1krkAGxoN1tbjIouDa8d8E+qumEaCOHt85w4F0+6ZcK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:33:12.3960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7538d76-e5b5-4b6b-ffb0-08df0dadbacc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
v3: https://lore.kernel.org/r/20251215205203.1185099-1-peterx@redhat.com/
v4: https://lore.kernel.org/qemu-devel/20260812201938.198915-1-michael.roth@amd.com/
v5:
- Fix error handling for 'hugetlb' when guest-memfd=on (Daniel, Peter)
- Default to 'seal' option being allowed/on for guest-memfd=on since
  it already satisfies the documented semantics (Peter)
- Don't explicitly set a placeholder URI for qtest/migration-test
  as the code now relies on NULL for this path (Peter)
- Clarify rationale for checking for kvm_enabled() in 
  kvm_create_guest_memfd() (Philippe, Peter)

This patchset is also available at:

  https://github.com/amdese/qemu/commits/gmem-shared-mem-v5

and is based on top of qemu master (99e54ab5e7)


OVERVIEW
========

(cover letter shamelessly adapted from Peter's prior postings)

Recent kernels allow guest_memfd to be initialized with an 'init-shared'
flag that will default to allocating normal/non-private memory that can be
used to back non-confidential VMs.

This allows QEMU to make use of these init-shared guest_memfd instances via
a common memory backend that's usable for either provide a common memory
backend.

On the QEMU side, before this series, guest_memfd was only used for private
guest memory (and thus only applied to confidential VMs), and the guest_memfd
FDs would be created implicitly whenever a confidential environment was
detected/specified.

With this series, users can now explicitly configure QEMU to use guest_memfd
for non-private memory; thus, it can be used for non-confidential
VMs. It also has implications for confidential VMs, since with this series an
init-shared guest_memfd instance can now be specified for the shared memory
while the internally-allocated guest_memfd continues to be used for private
memory. This same infrastructure will also be used as the base for enabling
in-place conversion for confidential VMs, where these separate shared/private
paths will be modified to act on the same underlying guest_memfd instance and
use a unified pool of shared/private memory.


IMPLEMENTATION
==============

In the current patchset, I reused the memory-backend-memfd object, rather
than creating a new type of object.  After all, guest-memfd (at least from
userspace POV) works similarly like a memfd, except that it was tailored
for VM's use case. While there is potential that new guest_memfd features
may eventually necessitate introducing a dedicated guest_memfd memory
backend object, for now the memory-backend-memfd object is a good fit for
the current feature set.

This will also make it easier when in-place conversion comes around, since
confidential VMs typically already use memory-backend-memfd for their shared
memory, so by also making using that approach to specify the guest_memfd
backend for in-place conversion the command-line syntax remains similar, and
even allow choosing between memfd vs. guest_memfd to be handled automatically
based on whether or not we're dealing with a Confidential VM with in-place
conversion enabled.

Now, instead of using a normal memfd backend using:

  -object memory-backend-memfd,id=ID,size=SIZE,share=on

One can also boot a VM with guest-memfd:

  -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on

The init-shared guest-memfd relies on a recent kernel (6.18+). When run it on
an older qemu, you'll see errors like:

  qemu-system-x86_64: KVM does not support guest_memfd

One thing to mention is live migration is by default supported, however
postcopy is still currently not supported.  The postcopy support will have
some kernel dependency work to be merged in Linux first.


Thanks,

Mike


Peter Xu (11):
      kvm: Detect guest-memfd flags supported
      kvm: Provide explicit error for kvm_create_guest_memfd()
      ramblock: Rename guest_memfd to guest_memfd_private
      memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
      memory: Rename memory_region_has_guest_memfd() to *_private()
      hostmem: Rename guest_memfd to guest_memfd_private
      hostmem: Support fully shared guest memfd to back a VM
      machine: Rename machine_require_guest_memfd() to *_private()
      memory: Rename memory_region_init_ram_guest_memfd() to *_private()
      tests/migration-test: Support guest-memfd init shared mem type
      tests/migration-test: Add a precopy test for guest-memfd

Xiaoyao Li (1):
      kvm: Decouple memory attribute check from kvm_guest_memfd_supported

 accel/kvm/kvm-all.c                   | 38 ++++++++++++++++++----
 accel/stubs/kvm-stub.c                |  6 ++++
 backends/hostmem-file.c               |  2 +-
 backends/hostmem-memfd.c              | 60 +++++++++++++++++++++++++++++++----
 backends/hostmem-ram.c                |  2 +-
 backends/hostmem-shm.c                |  2 +-
 backends/hostmem.c                    |  2 +-
 backends/igvm.c                       |  4 +--
 hw/core/machine.c                     |  2 +-
 hw/i386/pc.c                          |  6 ++--
 hw/i386/pc_sysfw.c                    |  8 ++---
 hw/i386/x86-common.c                  |  8 ++---
 include/hw/core/boards.h              |  2 +-
 include/system/hostmem.h              |  2 +-
 include/system/kvm.h                  |  1 +
 include/system/memory.h               | 27 ++++++++--------
 include/system/ramblock.h             |  9 ++++--
 qapi/qom.json                         |  6 +++-
 system/memory.c                       | 14 ++++----
 system/physmem.c                      | 51 +++++++++++++++++------------
 target/i386/kvm/kvm.c                 |  3 +-
 tests/qtest/migration/framework.c     | 60 +++++++++++++++++++++++++++++++++++
 tests/qtest/migration/framework.h     |  4 +++
 tests/qtest/migration/precopy-tests.c |  9 ++++++
 24 files changed, 252 insertions(+), 76 deletions(-)


