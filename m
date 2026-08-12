Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE03CC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFSp-00088d-9x; Wed, 12 Aug 2026 16:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFSm-00087v-WE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:22:13 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFSk-000731-L6
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:22:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU26PJncim9qODK99cQOxaxVeDxuLGJOuZ8cD9TXiWq7BrkQ5jdGMhp1co8XWLODQ5fWC/rWcPfjh6vi7U2p5jIwnIUIa2al/rDLwqeNU9C2HiRvAhWVjdqdnfP6ApbczrZVyhijf5VR15zpLvp/beFjJkfmeIgFk5p6YcYfBIXjF6Va+eaCJcLtodbO2xdOWcWk0lg3MZqz5ScSZKG9QbYgR3ztquFiNKT7yuy0vfJhXwbgWlCHWZHk0O3+GaeXV9fy+PEBBTvNC1st+/DPVkOfxqAXctJlokLg4mBV03yg6sqaSLW9NwuP7aTavDD2fbjgHcFTuY9Xjs4qBiUp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LJ1b66olMDgzidvEQWaCHuIZDcY0DAWjn3nK7Qdqvg=;
 b=Byge+9oaR3iY1yANxmF2qvU1DyYN25We/4B8N6h4n9B5TXoc/BxYuLcxhUCESo/SW1tJQfyA4jK5mmhi1TseyW5Qh0zfJkbzhcBWqL7yhYhOPlHgDc7yRIGLCDicfkXnTCyPEMd5GGnNjL7yvty1aP8nsqVC8OxL0jsCKlUwmGuctGnXN8h8Mb3/ORTpYhQIsZnUSc8E7Xxna01QuUA5+5U/r9ZC7jPd9F1TWRLwTm9L8RkRgpSMz0nsxbOF4MZWc92kdyb7fxICs4RZ13hlIr4jMlTFcTIAahayVZfW7sGw0kgpd/Z6o/DjWldKhQp01kQEmc1NfD0xhT3ydUiUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LJ1b66olMDgzidvEQWaCHuIZDcY0DAWjn3nK7Qdqvg=;
 b=RfT6GIDPYd/uwJRHauMgEiE0etFWadFdcjjL70z0F/OL7L6sHoZAjBAXEWfLh4Kk6NG+Vv/XHNNam63lo5RCjqxjJ9r8m/Njvxh2jGCetuS2ZHSsj9swWwl4qyQiI6XfyyOwz6zjpOj49Mx9bDdnrPikgYtV7LtA5hrKdeBrLec=
Received: from SJ0PR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:332::35)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 20:22:03 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::a8) by SJ0PR05CA0090.outlook.office365.com
 (2603:10b6:a03:332::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 20:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:22:03 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:22:02 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 00/12] KVM/hostmem: Support init-shared guest-memfd as VM
 backends
Date: Wed, 12 Aug 2026 15:16:38 -0500
Message-ID: <20260812201938.198915-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8c83e6-4c49-4d04-3292-08def8af5f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|56012099006|11063799006|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: sLsv15oKKg3eVF64zKS7ZowlEoIPYbPcypXwx7xWE27tLjcR2ScPuLsmfj135idG05iBG4yDUb7RQOVWrtZDEa9HTMYVnlfA2+I+vX5xonyu2+NUwo0FeU1mme+f8eDldCVEeT1FJGlxpPbOsS7MjkPopcrtXeEfQLBZqbMZHdRRFjs0j7vQAG8h/VLb2RmPPJmDg+EJsU7g7LdOUespr58N/WEZpgtFg6Od7sjyDTSa5wP/4O+hm++H77Y4X+e8X49feRiHJ6OuEQxMM2/AG+mx8yb//FRiroMIQXdYGZCTXfNUiiArrOdBmw5KMI3cD2g1Cx67Z/iYinD4UR5qQLoEnshX3Sp4p12uC1TUB5jHd5uU3176V2G2DeDG1jlYOenrFk9bbohtVbk7qyXvou+NXfQXDjHq646/gE+tfslJVzKi0PrlVGv/sdlg2hELpWGdK2AUGBed7kwA3mw1QFa8hlGeLth8ox8G/ejLjWJjcdXD0Ebhqwrv3u1H2LWC7FDkAzmPKF2YOViKtXaxcXsWJajRXv49G4Q8h6S6hjGrelBppE84BsulnWoxE/wCyUqtQgvKjdlnb+hzsoDmKGnK7SdueN09dcQwwSHuJ+3mI0fydc9ZeGoYWZZwAPKBjnQ5z0QniV0rZa05rROJa5s8TJzv5vGJhAd0CEpc5zXeaosAuDqBblW+VpK/IhNbzaad5M2NASUhtGaMT0UPKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VCCwIMbsmO3jRUcNcVImkTjm402exFsh0S21mDiptXilyUN2MLl3kDihKLIjTmtBTf3MhYgifCG3nEqTsUM3kfr+d+Khs5zhpZqsV8/PCXSCWVV6wmOW/lUdbR9tzshpHJVlGlR4tQmejdnPyiy9yumNRfdtumFlNQs+T9xHvWglihN0nxV8dMl+0f9E3c5PDM8y7dVna3N4dMUwWvu8mhKdRl/pwuzOJPFmF8gU278H0EzuHn+U6drI+mM7gUgqHYzLf+0GlF/cmsi8GLuGTzSqbzjq/OC/FIBeBq8aNzm0oDn9IF2mtVWbyTE6J+Yq1nepy27htBgoViZaogsIRkeaA8rVF6UigyUw1X/bB5w64vG33cnEM8bPCXlz05wf0hDeaGSqtzGGaT0nfB8U131L3+DvHe8eWt1jU+fMyfxrbeQGv6Mk/cZnhSnKiiLu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:22:03.0102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8c83e6-4c49-4d04-3292-08def8af5f0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Michael.Roth@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
v3: https://lore.kernel.org/r/20251215205203.1185099-1-peterx@redhat.com/
v4:
- Picked up v3 series from Peter Xu and rebased on 11.1.0
- Collected pending Reviewed-by's
- Per-patch changes:
  [01/12] Fix blank space (Xiaoyao)
          Fix commit message typos
  [02/12] Drop duplicated error-handling for capability checks
  [05/12] Fix up commit message, disambigurate "in-place" terminology (Xiaoyao)
  [07/12] Fix up commit message, disambigurate "in-place" terminology (Xiaoyao)
  [08/12] Disallow 'seal' and 'hugetlb' options based on guest-memfd=on
          Fix minor typo in comment
  [11/12] Fix up typo in g_test_skip() reason
          Pending: Move kvm_guest_memfd_init_shared_supported() to
            migration-util.c (Fabiano)

This patchset is also available at:

  https://github.com/amdese/qemu/commits/gmem-shared-mem-v4

and is based on top of v11.1.0


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

This approach so far also does not involve gmem bindings to KVM instances,
hence it is not prone to issues when the same chunk of RAM will be attached
to more than one KVM memslots.

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

 qapi/qom.json                         |  6 ++-
 include/hw/boards.h                   |  2 +-
 include/system/hostmem.h              |  2 +-
 include/system/kvm.h                  |  1 +
 include/system/memory.h               | 27 ++++++------
 include/system/ram_addr.h             |  2 +-
 include/system/ramblock.h             |  7 +++-
 tests/qtest/migration/framework.h     |  4 ++
 accel/kvm/kvm-all.c                   | 33 ++++++++++++---
 accel/stubs/kvm-stub.c                |  6 +++
 backends/hostmem-file.c               |  2 +-
 backends/hostmem-memfd.c              | 55 +++++++++++++++++++++---
 backends/hostmem-ram.c                |  2 +-
 backends/hostmem-shm.c                |  2 +-
 backends/hostmem.c                    |  2 +-
 backends/igvm.c                       |  4 +-
 hw/core/machine.c                     |  2 +-
 hw/i386/pc.c                          |  6 +--
 hw/i386/pc_sysfw.c                    |  8 ++--
 hw/i386/x86-common.c                  |  8 ++--
 system/memory.c                       | 17 ++++----
 system/physmem.c                      | 37 ++++++++++-------
 target/i386/kvm/kvm.c                 |  3 +-
 tests/qtest/migration/framework.c     | 60 +++++++++++++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 12 ++++++
 25 files changed, 239 insertions(+), 71 deletions(-)

-- 
2.50.1




