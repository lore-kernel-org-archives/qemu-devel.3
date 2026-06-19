Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E56CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXDg-00012e-HV; Fri, 19 Jun 2026 07:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waXDe-00011U-FW
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:17:06 -0400
Received: from mail-westusazon11010069.outbound.protection.outlook.com
 ([52.101.85.69] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waXDc-0003n8-6E
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:17:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzFdNmiNG61UtkbwcyBmXWreVE5QYofoM/2Abxi8FCs/lUbp1SJ59/FbUo9022OGPGivIdo/Ecpusg4XdYrThfGUAq20NJrZNI1+IhqoWF63J0HycShA+1LmByJ+6AfFv7WSEuHc6YHQKu7UrGP2gtyLmc1JQjjwOaoGMx5lAp7g6fYwv0WEpO3l/1iiwGu++toWSzWhrjTsp/GhORI/CtKMGL0q80QTU4cjzZHPfDqnpQy3juFDfVePx97cYSD1S5+RBQs3kU9MtEUUo66lUjOmqnnFgk3fdYavZaMyYFeDMHlgMuphYuBz9+r2lyGHTjuB0oQ65g1oeWxiv6GDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgHZrsnWiBg3/lx+zW9K5OAxKuj/+PmAGjROG8wslYw=;
 b=MJsXOEKoiE+JR8UvuJDw0ZAZHTHXzv7Op0di7PIk4EUoSjhWutfOacDVH9ekQwF9Fg3Odcv6MexzOj18/V7zXOH93zOyvSJwpgqNbqP80Ix8JeoK4i643/7MT8gClrTONCvb3/31E4iTql+NdnHcOPCCbvYDB5MhgRW4toZ1fydbmwpUHPNgdgxR8V49c0QisoaQI6FV+H0N/7O9wSymBPlsvcWu3kCBy/320e4ypnA7hft+bTr0dPnSlYKJpCHBHBMVnVfwfp8dlrFfW2Y59O8BgqLY+tPgQf8czjEspHWGqg8fEAUdZZk8hd3d5p/+hHz8rJCvbCKJXXn74GyQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgHZrsnWiBg3/lx+zW9K5OAxKuj/+PmAGjROG8wslYw=;
 b=cIlGyzzRPTep0ke6U4l3nMBBbyBeAgSJPkgwqtVNgmASqkbvqB4V28W72KfSiZyvLxAIAnBchvIoiq5C+Q2yG8lfCDHBr/+n6YtAmzgWVG8nd9npG7/H61NOItqxRM8uzU3IKxXZP25X1NP7Af3gLEHtnpYLoLfIiEuoccQTdEY=
Received: from SJ0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:a03:33e::22)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 11:11:56 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::63) by SJ0PR03CA0047.outlook.office365.com
 (2603:10b6:a03:33e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 11:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 11:11:56 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 06:11:53 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <mst@redhat.com>, <gourry@gourry.net>, <philmd@mailo.com>
CC: <peterx@redhat.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v13 00/10] hw/mem: add sp-mem device for Specific Purpose
 Memory
Date: Fri, 19 Jun 2026 19:11:26 +0800
Message-ID: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e270d3c-fb05-4a94-bfef-08decdf39337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|18002099003|13003099007|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: 8+5bqfa+wH80J07vgMzxCEY1fwiUHgoyT2n06+KcyUhHUoK7rYanFEX5AzUCbN7GHfgtq7MFHA1hNgeUKRTYLIcp12+LcV2FBpiWPFQQGJM92DZ8Ug1OT/roj4url981HoBVhz6EjP0mFVPhXFwc7dVvX+1+BwHmepgv9kiAKNx3bS9JILCMdMS/gXAKZ1Oa1AuAeUjxFpEdLUeX6lLDd52Rr6ywbHdz2KbTaGxsVPL3qGebjOLXhquIDGByBgws5SRNd3SSAs55cQVQ3pw1+oyu8w/RsB1oupbgcNkfYHbMbOyKj9D6TGZzZ3UrM4qb2UTYjXUv6HyXvBJ8CUn0WPXuIMXwbek/FdzApay55rtvXzsFgwJnhe2qA3aWTQKwO+dZDBnmlUHiu55FqI7o77kesoQGZzEWlk2E0MjV3/hGvIBj7qxGhzzlxa8wV8s2E2ECPTXnQWYr0Eu+L9vFUxOEjd/x9FH40Tul2URegCnCo7pwA6+/1XXr/jpu4u1g59aZXGlhQf/nDWF6PMVsQ+6xY+gaao1q8HmwMQIOK+Ase78dUHrawMefCXnKsiQNOIGSjjrdPvyFpmxJJjvfbUWLyQp0EmisTqkV1p8L9DjCqWE8Li0u/KNUm07NNq/d8RB4ZVpwMb+V29kHp+MjkT8i4OV3JQJodScslEzSNq+Y/c6HnEdfidffUFHOJmDm1P0hC0qbGs9xJum1lnEu0mwWh0h7xmJzBkvwbr+yhvV7R5idakb+f76JEnsHGMQ0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(13003099007)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7HJ1Jw0+vudNRVfGj5TdaBMwTbbC1yrmG+JKguphK9C1kpOJqAOpLddWZMWE2b3QkHkyOqhE/F1wB2mT8IZ3c7tWaMoRSvy8uc3an5GE4oEa5EGgnKTCvyPr6sEl+Fhdo80fNI/HRebEiIbHumBHbfFJ3h71Tir2ptpkkt8tGPDgEdiiOY0KM7T8xXLrUXjosP5TtHDXgFSlGRKhiVEp2BumS1drfV8aLsdK13PlwxkR2EofhH4ILg1TRrwbIXI5b3os3z9PIyHMUJudrT/N+40AWUrpDZtD2icQRSCu6UeainkR2oojpQaQQ2XJ0F2/bPnaSb8OOBBj/UUxjWZ9LVAxyP9z/5CxeHy7IpHgF9gpNhpwhzfD9bwqffZb7F3Pz7yGYDReKIucw91aGP2AutTDGgL+YnsrSJMYsYwKJpcLDfwbDtGsJtfV5lTRVCT4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:11:56.2569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e270d3c-fb05-4a94-bfef-08decdf39337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
Received-SPF: permerror client-ip=52.101.85.69;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

This series adds a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
SOFT_RESERVED guest memory, following the direction from the v7
thread [1] and the v8 / v9 / v10 / v11 / v12 reviews [2][3][4][5][6].

Background
----------

This series targets coherent CPU + accelerator shared-address-space
systems, where the accelerator's HBM is not a device-private
framebuffer behind a PCIe BAR but a tier of host system memory:
visible to the CPU in the platform physical address space, shared
coherently with the accelerator over the platform fabric, and bound
to a NUMA proximity domain set by platform firmware at boot fabric
training.

For such a region to function correctly in the guest, two things
must hold simultaneously: the CPU memory subsystem has to see it in
the system memory map (so the CPU side can address it), and it has
to be reserved exclusively for the accelerator's driver (so the
kernel's general allocator does not hand SPM pages to unrelated
workloads). The SOFT_RESERVED memory type in E820 plus a matching
SRAT memory-affinity entry is the mechanism that delivers both: a
firmware-produced topology that the CPU memory subsystem honors and
the accelerator's driver consumes for its own range.

Approach
--------

The series introduces a new TYPE_MEMORY_DEVICE subclass `sp-mem`.
Each instance binds one host memory backend to a single NUMA
proximity domain and is boot-time only; placement, mapped-state
enforcement, and QMP introspection come from the existing
memory-device framework.

Testing
-------

Verified end-to-end on q35 + KVM, with both SeaBIOS and OVMF, for:

- single sp-mem instance
- two sp-mem instances on different NUMA nodes

Guest observations: /proc/iomem shows one SOFT_RESERVED entry per
sp-mem device, dmesg SRAT parsing reports the matching
memory_affinity entries with correct PXM, and the umbrella
HOTPLUGGABLE entry covers the remaining hotplug-memory window
without overlapping the sp-mem ranges.

In-tree coverage: a bios-tables-test case validates the SRAT
partition for two sp-mem devices on distinct nodes, and an e820
fw_cfg test checks the SOFT_RESERVED range.

Changes since v12
-----------------

  - Split the QMP/HMP introspection (query-memory-devices and
    info memory-devices) into its own patch.
  - Drop the device-level unmigratable flag; the device carries no
    migration state of its own.
  - Add tests: a bios-tables-test case for the sp-mem SRAT partition,
    and an e820 fw_cfg test for the SOFT_RESERVED range.

The feature patches (acpi-build, pc, MAINTAINERS) are unchanged from
v12; the MAINTAINERS patch retains the Acked-by from Igor and David.

Previous versions
-----------------

  v1: https://lore.kernel.org/qemu-devel/20250924103324.2074819-1-FangSheng.Huang@amd.com/
  v2: https://lore.kernel.org/qemu-devel/20251020090701.4036748-1-FangSheng.Huang@amd.com/
  v3: https://lore.kernel.org/qemu-devel/20251208105137.2058928-1-FangSheng.Huang@amd.com/
  v4: https://lore.kernel.org/qemu-devel/20251209093841.2250527-1-FangSheng.Huang@amd.com/
  v5: https://lore.kernel.org/qemu-devel/20260123024312.1601732-1-FangSheng.Huang@amd.com/
  v6: https://lore.kernel.org/qemu-devel/20260226105023.256568-1-FangSheng.Huang@amd.com/
  v7: https://lore.kernel.org/qemu-devel/20260306082735.1106690-1-FangSheng.Huang@amd.com/
  v8: https://lore.kernel.org/qemu-devel/20260527074215.229119-1-FangSheng.Huang@amd.com/
  v9: https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/
  v10: https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/
  v11: https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/
  v12: https://lore.kernel.org/qemu-devel/20260616090808.3047939-1-FangSheng.Huang@amd.com/

  [1] v7 thread closeout:
      https://lore.kernel.org/qemu-devel/666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com/
  [2] v8 review:
      https://lore.kernel.org/qemu-devel/20260601105057.2d764e55@imammedo/
  [3] v9 review:
      https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/T/
  [4] v10 review:
      https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/T/
  [5] v11 review:
      https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/T/
  [6] v12 review:
      https://lore.kernel.org/qemu-devel/20260616090808.3047939-1-FangSheng.Huang@amd.com/T/

fanhuang (10):
  hw/mem: add sp-mem device for Specific Purpose Memory
  qapi, hmp: introspection for the sp-mem device
  i386/acpi-build: partition device_memory SRAT umbrella for sp-mem
  hw/i386: hook sp-mem into the pc machine plug path
  MAINTAINERS: cover sp-mem under Memory devices, add R: tag
  tests/acpi: add empty expected blobs for sp-mem SRAT test
  tests/acpi: add bios-tables-test case for sp-mem
  tests/acpi: generate expected blobs for sp-mem SRAT test
  tests/qtest: add e820 fw_cfg test
  tests/qtest: cover sp-mem SOFT_RESERVED e820 entry

 MAINTAINERS                        |   3 +
 qapi/machine.json                  |  43 +++++++++-
 hw/i386/e820_memory_layout.h       |  11 +--
 include/hw/mem/sp-mem.h            |  33 ++++++++
 hw/core/machine-hmp-cmds.c         |  11 +++
 hw/i386/acpi-build.c               |  96 ++++++++++++++++++++-
 hw/i386/pc.c                       |  36 ++++++++
 hw/mem/sp-mem.c                    | 128 ++++++++++++++++++++++++++++
 tests/qtest/bios-tables-test.c     |  21 +++++
 tests/qtest/e820-test.c            | 129 +++++++++++++++++++++++++++++
 hw/i386/Kconfig                    |   2 +
 hw/mem/Kconfig                     |   4 +
 hw/mem/meson.build                 |   1 +
 tests/data/acpi/x86/q35/DSDT.spmem | Bin 0 -> 9910 bytes
 tests/data/acpi/x86/q35/SRAT.spmem | Bin 0 -> 384 bytes
 tests/qtest/meson.build            |   1 +
 16 files changed, 508 insertions(+), 11 deletions(-)
 create mode 100644 include/hw/mem/sp-mem.h
 create mode 100644 hw/mem/sp-mem.c
 create mode 100644 tests/qtest/e820-test.c
 create mode 100644 tests/data/acpi/x86/q35/DSDT.spmem
 create mode 100644 tests/data/acpi/x86/q35/SRAT.spmem


base-commit: b0df6e2f2c6c45df8d4d286933799c623e124d98
-- 
2.34.1


