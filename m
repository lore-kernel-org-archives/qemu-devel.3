Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08AECD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 07:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS8zZ-0000Ng-Qr; Wed, 27 May 2026 03:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wS8zX-0000NN-6f
 for qemu-devel@nongnu.org; Wed, 27 May 2026 03:47:51 -0400
Received: from mail-centralusazon11011058.outbound.protection.outlook.com
 ([52.101.62.58] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wS8zT-0005hf-80
 for qemu-devel@nongnu.org; Wed, 27 May 2026 03:47:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2ujHgPBZDu6m1izEzixkrgorYQwyeI0ZA5pmsQsVH9gTYSRVxG1+ME8tu7bsWMUXK/PTDmVCrlPMy5SoptSpEL+q6LmXgf4GyYY8PNwBRp4vIBOinoA+X8GOhX45M3rfG2OVmUPr2QjghjG1DPzyvSD/moDv4EGKL59w2p063LeI3JNu2KN0ySgr1q8tO9vn0fWviSiKy1PdkE8fBVK4C+6kAXfPrdybcymNNqlOtgEO5rkbA6+wG8jK/hKiZ8t4G6e0by+9JZHcWZgei8hMJDiZHkc7/s2ooCyCmkp3nGzKGzGm9ut3wnttCSo4t9i3CwR8yrEwT5opdT8K8cYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g8i4fFZEcbffLSZsfq4Gqh+3mjw9747tgKNsZHuejc=;
 b=ZxoXyyO9rRUY0ngWuasHuvIfetzjsoqtt8KxXCTcIW8BbcW7yXA6EUXHZJpDZtA67xC1qTXnKrLsXZKwjmr+c6tMznotFaiBMldObwFQQoKjRSZicBIQi9A1vxk929w0MwaVMb+1Jqa47nhvyC4zNgNtMTYCXco3lZFh0qm9BQ6ZV5CGSJJYMdhCwGtzuNxqI6CnfW8FdpsBEe0QzBPomV4SxhVlEQuCVbn/oQxLly2hkQdmdfayErj5+kiynfwDdDUNZH0CgyDAFpJIaNwZxbczgOKYgoSh33X66Fa2ANraCsQ/tipNSRRFZfPdAb3tnac8OHFi8vUj83xzg++5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g8i4fFZEcbffLSZsfq4Gqh+3mjw9747tgKNsZHuejc=;
 b=BTlTmA19NuLnxiQ2Dzf6oeLqnEHy8vmlxo2nO41Qjftd182ygcKGUMt1yfzOODEv8HUSZomXu0/Fm//0G7wbqzURdjtalVbSShZZq+cxf1jTEihW6dzDwVpsJg4D1oEKHDLuB674s0XtKVhcLD5jSPeSocpEHZDWwQua1vLiyL4=
Received: from IA4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::14)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.11; Wed, 27 May 2026 07:42:36 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::2) by IA4P220CA0001.outlook.office365.com
 (2603:10b6:208:558::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 07:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 07:42:35 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 02:42:33 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <david@kernel.org>,
 <gourry@gourry.net>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v8 0/1] hw/mem: add spm-memory device for Specific Purpose
 Memory
Date: Wed, 27 May 2026 15:42:14 +0800
Message-ID: <20260527074215.229119-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 0964cd5e-f934-40b5-7085-08debbc3852a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|11063799006|6133799003|56012099006|18002099003|43062017;
X-Microsoft-Antispam-Message-Info: p1hWwbiwHQfyt2AYjE9fcqNjhnXDthrmeu2NEjGaxoU1XJ9t78CcVnklOJbG09hemiecVCojaTEVWhb0sD9wK1n4i/2oZu9tmOq+EgOoQU2h59cqpUZx/nAdiGyaKC252QGFSD4vHE8atSEPlxX6WNpGGTVOjo12LrcO6qvCsGunOf67fmBBJ00vD58n5tKQqNjHx22HssZ0LED75T6fiYbo7a7ndSJ2l1mj6ZnPrDWG35/jgct/BR1d3Ve/ZjiNE65Ls47/UttuHjJkQX4ImIw1Iqi0P2yHzLnTjxIUPU8rmT3i/PsDGlNarrRg2c5AbuLeaqBhCy04nkdASS6GdJX+pdBrDqzCyvI7iZC133xrYg27SZtblXZRdnGg0a5S4NAD3fk8BmTPRhF3iKabb0SOzCslTwZfc3VFzBg9ZchOzivDE2d6HUkucPf+LubiBgyy6htBoV97CppATpNhnMzHvBPI3OAqPfRxdtIvzAVZReJQDLSwbM8KdV/HFW+o+EF8iCZEHDDRIyXvVSyTAQyRrAENRUqtbO/1+Kjm8RJYElvKUx4EcrBuQ5iPJpKO231LDEgtkRFG0FsiFyN4R1wKssigCCwjM6t4LDl/y2Wtx6iQkpXw7qTDe9ziGIpBztZE+Lc2SpFYWJe80j2/UxmNNwcZ6iXAjEZnccTpDKZxC5cumcpEftydw8danUD3j5gzswZetBwZEyJr1Tx8kNXjpEdt/8vZitYCFpd4P0W6vGbL+lgv7kYdmWmEde5GOF/ICkIBFBEw33V1svqFqs/+vzBe+uyE3GrzrxjxkBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(11063799006)(6133799003)(56012099006)(18002099003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1FYZ6bwnD26jtsvwe1iuDthK3L145/yFEfea8pCGk/9DxDo7UXjx+aSFgVJXxMbiqaMjA8vD1sETuC5NYuA7MNZUvPYYMM77J02IOBn0eTRA/8ZRZzDglkWSqb9M2ik1pT+cg8LULgx/HbQZbNjqYpYJ5YDuYcHh++j/UfQlUJYX0F3oAn54hi160pDlS6jeGsvKKBH4zSx0QDcAP8tncsG3APDGVbluGp3N0qD/Y0gB5Q945BMPrxb+yvFDHo7h+Puv588QE7U6WXH1nE6DuEW+uWIeNgvEKLAvs+CCfqbSPmTOA3gwbHUDL4hAoCJSTaK4mxkV76auYML5rv+gmtfr1hX3auljC+CaTpcwwb7DldMtXWQFkucUOOj/6zTMFL3WTlG1xPidX4JT02kb1l2vaaZlnKgdx5Gn9Ua/bqvVF8asFAGKyGbG6sb86mEI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 07:42:35.9922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0964cd5e-f934-40b5-7085-08debbc3852a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
Received-SPF: permerror client-ip=52.101.62.58;
 envelope-from=FangSheng.Huang@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

This series adds a TYPE_MEMORY_DEVICE subclass `spm-memory` for boot-time
SOFT_RESERVED guest memory, following the direction from the v7 thread [1].

Background
----------

This series targets coherent CPU + accelerator shared-address-space
systems, where the accelerator's HBM is not a device-private framebuffer
behind a PCIe BAR but a tier of host system memory: visible to the CPU
in the platform physical address space, shared coherently with the
accelerator over the platform fabric, and bound to a NUMA proximity
domain set by platform firmware at boot fabric training.

For such a region to function correctly in the guest, two things must
hold simultaneously: the CPU memory subsystem has to see it in the
system memory map (so the CPU side can address it), and it has to be
reserved exclusively for the accelerator's driver (so the kernel's
general allocator does not hand HBM pages to unrelated workloads). The
SOFT_RESERVED memory type in E820 plus a matching SRAT memory-affinity
entry is the mechanism that delivers both: a firmware-produced topology
that the CPU memory subsystem honors and the accelerator's driver
consumes for its own range.

Approach
--------

The patch adds a new TYPE_MEMORY_DEVICE subclass `spm-memory`. Each
instance binds one host memory backend to a single NUMA proximity
domain and is boot-time only; placement, hotplug rejection, and QMP
introspection come from the existing memory-device framework. The
device emits one E820 SOFT_RESERVED entry per instance at
machine_done and one SRAT memory-affinity entry per instance at
acpi-build, the latter flagged ENABLED only.

The device_memory SRAT umbrella entry in hw/i386/acpi-build.c is
restructured into a per-kind partition: for each plugged
TYPE_SPM_MEMORY device the partition emits an ENABLED entry at the
device's proximity_domain, and the remaining sub-ranges (gaps between
SPM devices, leading and trailing padding, and ranges occupied by
non-SPM memory devices) are emitted as HOTPLUGGABLE | ENABLED entries
at the placeholder PXM (nb_numa_nodes - 1).

No firmware-side change is required: the existing OVMF and SeaBIOS
handling for E820 SOFT_RESERVED and ACPI SRAT covers the guest-facing
contract.

Testing
-------

Verified end-to-end on SeaBIOS and OVMF, q35 + KVM, for:

- single spm-memory instance (natural placement and explicit addr=)
- two spm-memory instances on different NUMA nodes (tight pack and
  with inter-device gap)
- one spm-memory + one pc-dimm on different NUMA nodes

Guest observations: /proc/iomem shows SOFT_RESERVED at the expected
addresses, dmesg SRAT parsing finds the per-device memory_affinity
entries with correct PXM.

Previous versions
-----------------

  v1: https://lore.kernel.org/qemu-devel/20250924103324.2074819-1-FangSheng.Huang@amd.com/
  v2: https://lore.kernel.org/qemu-devel/20251020090701.4036748-1-FangSheng.Huang@amd.com/
  v3: https://lore.kernel.org/qemu-devel/20251208105137.2058928-1-FangSheng.Huang@amd.com/
  v4: https://lore.kernel.org/qemu-devel/20251209093841.2250527-1-FangSheng.Huang@amd.com/
  v5: https://lore.kernel.org/qemu-devel/20260123024312.1601732-1-FangSheng.Huang@amd.com/
  v6: https://lore.kernel.org/qemu-devel/20260226105023.256568-1-FangSheng.Huang@amd.com/
  v7: https://lore.kernel.org/qemu-devel/20260306082735.1106690-1-FangSheng.Huang@amd.com/

  [1] v7 thread above, closed out by:
      https://lore.kernel.org/qemu-devel/666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com/

fanhuang (1):
  hw/mem: add spm-memory device for Specific Purpose Memory

 MAINTAINERS                  |   2 +
 hw/i386/Kconfig              |   2 +
 hw/i386/acpi-build.c         | 105 ++++++++++++--
 hw/i386/e820_memory_layout.h |  11 +-
 hw/mem/Kconfig               |   4 +
 hw/mem/meson.build           |   1 +
 hw/mem/spm-memory.c          | 269 +++++++++++++++++++++++++++++++++++
 include/hw/mem/spm-memory.h  |  43 ++++++
 qapi/machine.json            |  43 +++++-
 9 files changed, 459 insertions(+), 21 deletions(-)
 create mode 100644 hw/mem/spm-memory.c
 create mode 100644 include/hw/mem/spm-memory.h

-- 
2.34.1


