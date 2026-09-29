Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C286CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhep-0006MC-6i; Tue, 29 Sep 2026 19:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhen-0006Lf-5g
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:54:45 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhel-0007kS-6M
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:54:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqdlEo4DSeCtjnhavtCMvTE6i/D4YwdnV22vSrd3RoPfSg3Eq9xoWF1Ev5mUWaacIBmHTeGu9H6gfNlOUfGyJhzqv0kccKvQWsZpK8y2aXOsqQ+S5AOe5Dy6NIkuGgaQuHcyxTtJKMglEbBMM7f30VN/zvj+/WW7L/gIszIOlIwxUuvzBPooR+DP8dYAfojdZXnVHuPGvQzby35mqPTB/jSEVHymDh+FCTHAXZDGlmZCyiZt47Ipuo3Mdi624QT1sCY7mW/0sds6Ibq6F78cSwUcFfyzgP3SNTBtS5fbRlxJj7uJ2MNWIjIchhBfGFTuNVpHqBmtjSCqEzMFv6LRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/DzXpvyioAongRk3R0nHg5KMJ1NUfYsIo7SNGJXWDg=;
 b=q8Ce9oBApqfBmTkWd2apkt0vVnxV6/+li4k5F6c/dUcWzxV4CXsrKbBWyov2tC6caoKWBLCYc3WJE+hDXuRzJLvG2BKzhgaApfsJJvKR7jjXNz2hoqk6xw19v4d2+tom+4T9+FzP5o3ly7tsbmCg05WDtqO3Ovpg0G/LuY9X7y03jCewfA6ARir7yhfeO5+VXYXtmnSzcA14jFvWn6Rn/C8ro81bjOS6qcPHNqZfo9uqtEr45ofSHxjcjTxSTVSM6a5OkUgmWHX2GxeIAs0PKf/73C0ydEINQsMteKXKXjFgrFPJOghmA9wZ420qwMWMo8jiF6xuw06hIKiEHwJvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/DzXpvyioAongRk3R0nHg5KMJ1NUfYsIo7SNGJXWDg=;
 b=3qjN/JXMcyUcTAYPtl4Ww4sqZP8LIORqrsJ1r6YlITnJMGeYb+E38B0xdiXBIavwfKAvau51pkZP0+TBAMAaM/sQy7N9T4vnaq8Uo5jzpEdRImMHhMnM9sKXtXJApOuGjdyof5A13Z5RvQ4Q6dviyqMPtHkSwFlVZHADy8X19Ew=
Received: from BN1PR12CA0005.namprd12.prod.outlook.com (2603:10b6:408:e1::10)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 23:54:35 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::99) by BN1PR12CA0005.outlook.office365.com
 (2603:10b6:408:e1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 23:54:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:54:31 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:54:30 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>
Subject: [PATCH v7 00/12] KVM/hostmem: Support init-shared guest-memfd as VM
 backends
Date: Tue, 29 Sep 2026 18:50:06 -0500
Message-ID: <20260929235109.1398509-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 7826a87c-0dd4-49f5-df62-08df1e850194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|56012099006|11063799006|3023799007|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: Qq7ixYEJVxuyobUU/rMYO5JpUpGIbbazo989CqkDYoGMoxrI60PWyM2t/X90Ja4V6f90vRCSZBOmbNuOy5r+3wm+nSfY3KfvK+uT68SG7Km4NtfY73efXw9I6i3t15T1Bf0nvAvXaC0EPWz670lYrcJG/mKXnXJSdkgvB9CeJJsmkeJ94211IeLrx+anguzjHUx98wFBxw0RjIREH5W6bUERGC72BkHtV0GIKeW/bk4Le/DOUCsWDkfGDl4iW7vuYmFLQiGSROErJdy8IWBMPJ0nrkO4+kAz40WQsTIhUY034NUmyHQ3s2RgF1HeKjocwBjT0pzcJihNcVpPvrfa+jea4VxfKkSA5CA4rfiiyXkHXIRQ52RZe9P31vJdqxNq6UEn9HcPA7x+7ExxRz/OZxol0mEEw+C6J0CYSr8qZNNhIOhsr68x/GJddcoT7Zkxclf3xF8chok6g1Xt9ZgJHmW++AJyxFTSfxDUpMXJJRU6hv/rBlFnftpizUSFEpDDnRlwVYUJNfnU7SthSx20UHZ5zHRpT4aYKm68+jlXV7KQUVPXlVqOQr2oUcCrcCc6Ivc9pWoghwi4HZRJqByE3M5a1RlCOdGLTf8KQZnAnFBObqfS5UC4V93qu3ZnwF6o4pTtEW15m4OrVdxlNgl9dDD8gBCipSQ6JDtvLxJ0Cvk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rbznumStKtMDBNrE6ohIZlVHHvI6L1VI9o9Y9D9wTWctvKqpB4RNdVHHas9CCAmwsKfbr11q0BtA0XcXFEcShUwRwDzt1KDlwJL+7PV1HM0NJBLDdy3FtHNk38kmYyFkT88sPBZPeprY5na++3Brcrzo4H3BYRimHgtMtcfSMiIo0F35aYRPPWIJ6aW8shfgcUM+77kHvzq8+y3O4d7QB6A2pRMrH/xdSG20BAqQPvSQ3/+tOSfF+Z8eI7Pl6sEKqqJZHrqZRFHwLgl5dCrs5wCrbHQKz804SJq8vNCLmvEBg2T35T5cZ+T9KasWzAWOk/CcJvmb3OSTWZGc5RL76c0N7QJOKegdPaiwDxxzR3yGdkmYUenEVvJuO6GkdaPOXggZ7t28ZSGms5PdkWfX11gb2PlS24LnH0roeAJdLsAuH4gZCqydgi9IyHfwuT/e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:54:31.5493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7826a87c-0dd4-49f5-df62-08df1e850194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Michael.Roth@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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
v6: https://lore.kernel.org/qemu-devel/20260925015700.1260501-1-michael.roth@amd.com/
v7:
- Drop the 'x-' prefix from 'guest-memfd' property and mark as 'unstable'
  (Peter, Markus)
- Document expected behavior for 'auto' default (Markus)
- Use a link when referencing the guest-memfd docs in the schema (Markus)
- Rebase on QEMU master

This patchset is also available at:

  https://github.com/amdese/qemu/commits/gmem-shared-mem-v7

and is based on top of qemu master (81ce3a8773)


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

  -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on

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
 qapi/qom.json                              | 15 ++++++-
 system/memory.c                            | 14 +++---
 system/physmem.c                           | 52 +++++++++++++---------
 target/i386/kvm/kvm.c                      |  3 +-
 tests/qtest/migration/framework.c          | 60 ++++++++++++++++++++++++++
 tests/qtest/migration/framework.h          |  4 ++
 tests/qtest/migration/precopy-tests.c      |  9 ++++
 27 files changed, 333 insertions(+), 76 deletions(-)
 create mode 100644 docs/system/guest-memfd.rst


