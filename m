Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13791C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vCm-0005S5-0T; Thu, 24 Sep 2026 21:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vCi-0005BW-HO
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:58:24 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vCf-0006NR-NS
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:58:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUrLxFxjkHkNiPw/qEJ+NpH9zJMYj1yV/MtrmpULaUz+UQuZgn4/1rZtsrfiBweSXBbQ8AMRdpXZIrP3mgtm3Yq/nRksLQxaPxrrGdKLykJYJhLhqle7A/HuzNgqkoSBd6z1GLPPWgT6vJNTEOHsYrcAVk1EBrtG7aTPKLN/YgMw4JQaPLmHFobz4Ah8T7fEmwT3Hcfp+nqFNA7vwRYR/sjdQZCXiwudSlZHy9vWoI4tQ2VMawGxjgBa4+JtUzT9adVWHRnedoyD5wcZ11X/NwjJ3TixjXMPvv871mjSKb1icFaNj7SknrBwxMmfA40k+pfF9slLlOT+n9O8YsKs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klS3wUlvAVbcjA9krAlFxSHdeYduPWM3HASITmUpEvA=;
 b=QVBz6TooDbVsS7ipQMU/moYtGH98KnidxeUMtps7WEkibafMJD783hvTqv4knlbCKBnDB+Jg5TjFfvME77xZOFrFZc/VVCZZVy8bG+MoobYoWoUsQlQoVjnQulaIeZVvA9YpNklegYPwVv/+rq1aFMQtnjC6ky021AX778TJzwgRnYSqveZa430PMAezkCzTa/INJdVi/Nuysg1hBcM7XJVg+URehwdWhO6z/7OQZRU9jVwfSlHOLWZlZxhgl6eXngOxIpx63WChbyXSarlMmx19KZGaJKSwOm6fTrLTFEZnFXUhk3LKO/2u+0MHgVCfwdiMrEx+2pDOoJTppr6BVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klS3wUlvAVbcjA9krAlFxSHdeYduPWM3HASITmUpEvA=;
 b=qMODPlE7i0IwZNtykr+cDP+l+ykotWPIXu0MG8OhS6EavSaC6NKomwqDqDwNdi1sDMgYRbP/DRHCUZHWRi1rXptnrazN9npiLMtx8mKaWJ7D2W6WoHUWGFp4wBE2yY3zM8WIJpRz9YdQDangc+LugBFwOERimDHJ1ltbvDz+FBc=
Received: from BY3PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:217::12)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 01:58:14 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::53) by BY3PR04CA0007.outlook.office365.com
 (2603:10b6:a03:217::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 01:58:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 01:58:14 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 20:58:13 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <david@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>
Subject: [PATCH v6 00/12] KVM/hostmem: Support init-shared guest-memfd as VM
 backends
Date: Thu, 24 Sep 2026 20:43:06 -0500
Message-ID: <20260925015700.1260501-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: a5be1c48-3008-48fc-f1f2-08df1aa875ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: cfjp8MDi3iIdt+sMrvYKZcvm3KcsC0mElHeQZWDM2zs8n3jE+zdkKudTphvG2kk9/75Ey4mOGNQvjxOMwabV3ieyauZznrkDJcA24PKtxTEpp/p4BUD0XJa0iu6ZPExrvv7Kk5OyvzEogkuvnoSafyyQ5telAgCWCS/MTvPn6etWcpdYKJmpbxckFGDZoZPBe0gJ4YBOcIsOOXQ+SqgxMyeSNV/Z/4QOWlHJRU+R3P26WZZ7p07CfW3n+A2bnmYk2jlpo9rRUAS68BjbG06lYfOiOBGRzYZWr32tyJ85AQLuevB1GlJGVy+UAmwCwugLvR0S+ioTR1xexCyNOuabiz66HVdtLQLbnVrVrB5QWFV+9FCDyYL3PB20ASI+9js8Lg361nFSEoQTt7veFe7Lar02IpHljNLwJ0lWVf727SZBN1AEu6WFQftkVG5T53p2sR+6f2m/tU3yMou1R8GNnJixb12onqshJ93O5Y8JXcaFw7XMpn4kcwH6imvmJ3MV+M+qRnMO2tCjSIpECByJy8q5O8LwC3ZYmVUsxKvAr3bNUCE4sogWN3KkohaUKERwNTLe8jbdkmD/7jg8c3Y3g0LhcuHIRaaGV5yPsmf2Dj7+2XcOxqVUdiV5h1j+f00FQmC8CurVQu8GZgx2W27YRMgi+lw9NNaWO56mw34nPEw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 37chMewrbZeB0wYDSl2QQHcdrEJe18s9ifDodso9fcC1lKt1eVndHbulWduVtFPqe6xhiMmhM/I2s/oivKEUC7w4gtMPDObfNzyhqQ/Fr1nFBpgDuJY3dlK5PVIiZLITPXvhXJWXpp71+n2X1TZGS8bF3xh/9F/nQOUq1bOI7Mx8m6whhXlgf+HfV1To9LE50OclefHE1lhGToD8UqDgLxR6KJCfvev0/V+GP/mY4gZPuDirbwKQCsLNcNulgftwY6qzXyuSIZDLZT2d8e+3AhbeNPlN1zlMwLiIwkiYFC0UQvm6iHMQ2Ppp+EcXHwnOpptf4qbXqiA+4Kzt3IVK0pTMiQORNXRpolvYQUvn0BT7UfklV7NS8yZPwBVjimCxoFFcEtTTfjOhs4HF+R6zf2kBtW5r4S2uw8zbH7CWrc8of2Admq8Y1nA4A8IYkOx9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 01:58:14.3800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5be1c48-3008-48fc-f1f2-08df1aa875ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Michael.Roth@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
v5: https://lore.kernel.org/qemu-devel/20260908133151.836685-1-michael.roth@amd.com/
v6:
- Rename the hostmem property to 'x-guest-memfd' since initial users
  are expected to be developers or early enablers (Markus)
- Introduce accompanying 'guest-memfd' RST doc and reference it in
  the QAPI schema documentation for x-guest-memfd (Markus)
- Move all renaming patches toward beginning of the series for
  consistency (David)
- Fix mispellings in commit messages (David)
- Drop ramlist lock in new ram_block_add() error path
- Collect Reviewed-by's
- Rebase on QEMU master

This patchset is also available at:

  https://github.com/amdese/qemu/commits/gmem-shared-mem-v6

and is based on top of qemu master (19b46407ee)


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

This is initially added as a experimental option since guest-memfd is not a
drop-in replacement for memfd (e.g. no hugepage support), however it will
be useful for non-experimental purposes once in-place conversion support is
added to QEMU for Confidential Guests[1], and is useful for early
enablement/testing of other features relating guest-memfd. The
guest-memfd.rst documentation introduced in this series documents these in
more detail.


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

  -object memory-backend-memfd,id=ID,size=SIZE,share=on,x-guest-memfd=on

The init-shared guest-memfd relies on a recent kernel (6.18+). When run it on
an older qemu, you'll see errors like:

  qemu-system-x86_64: KVM does not support guest_memfd

One thing to mention is live migration is by default supported, however
postcopy is still currently not supported.  The postcopy support will have
some kernel dependency work to be merged in Linux first.

REFERENCES
==========

[0] https://lore.kernel.org/qemu-devel/20260908205236.838281-1-michael.roth@amd.com/

Thanks,

Mike

----------------------------------------------------------------
Peter Xu (11):
      kvm: Detect guest-memfd flags supported
      kvm: Provide explicit error for kvm_create_guest_memfd()
      ramblock: Rename guest_memfd to guest_memfd_private
      memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
      memory: Rename memory_region_has_guest_memfd() to *_private()
      hostmem: Rename guest_memfd to guest_memfd_private
      machine: Rename machine_require_guest_memfd() to *_private()
      memory: Rename memory_region_init_ram_guest_memfd() to *_private()
      hostmem: Support fully shared guest memfd to back a VM
      tests/migration-test: Support guest-memfd init shared mem type
      tests/migration-test: Add a precopy test for guest-memfd

Xiaoyao Li (1):
      kvm: Decouple memory attribute check from kvm_guest_memfd_supported

 accel/kvm/kvm-all.c                        | 37 +++++++++++++---
 accel/stubs/kvm-stub.c                     |  6 +++
 backends/hostmem-file.c                    |  2 +-
 backends/hostmem-memfd.c                   | 69 +++++++++++++++++++++++++++---
 backends/hostmem-ram.c                     |  2 +-
 backends/hostmem-shm.c                     |  2 +-
 backends/hostmem.c                         |  2 +-
 backends/igvm.c                            |  4 +-
 docs/system/confidential-guest-support.rst |  2 +
 docs/system/guest-memfd.rst                | 60 ++++++++++++++++++++++++++
 docs/system/index.rst                      |  1 +
 hw/core/machine.c                          |  2 +-
 hw/i386/pc.c                               |  6 +--
 hw/i386/pc_sysfw.c                         |  8 ++--
 hw/i386/x86-common.c                       |  8 ++--
 include/hw/core/boards.h                   |  2 +-
 include/system/hostmem.h                   |  2 +-
 include/system/kvm.h                       |  1 +
 include/system/memory.h                    | 27 ++++++------
 include/system/ramblock.h                  |  9 +++-
 qapi/qom.json                              |  7 ++-
 system/memory.c                            | 14 +++---
 system/physmem.c                           | 52 +++++++++++++---------
 target/i386/kvm/kvm.c                      |  3 +-
 tests/qtest/migration/framework.c          | 60 ++++++++++++++++++++++++++
 tests/qtest/migration/framework.h          |  4 ++
 tests/qtest/migration/precopy-tests.c      |  9 ++++
 27 files changed, 325 insertions(+), 76 deletions(-)
 create mode 100644 docs/system/guest-memfd.rst



