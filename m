Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD70C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKlH-000396-0B; Tue, 02 Jun 2026 04:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUKlB-000372-F6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:46:07 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUKl7-0004On-43
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:46:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk7MoXxDnz/MCqLNY0ehimM+4ZK7AB8GNgtQ4lqC5wBqX6ckrQpCsVHmB0mvvaQkYupPph6IuJSIlObn9l2/Ggtcrl0OXbWV8D3s639HuMTBQ4nEZMZ3QonCl9E3v0voCyMxRuKYkJ/9q/v4NfBcmqWSpIlt3Bs/UTSM1Fev8D5prn9abEPImUDoMe3njE9y231Kqk1C7d+pGBbaax8FeXpHUT4e8IJhpE7Pndd6AhWq/xwLbMN1J3cRulMiWNPeMRsoqej3WVPn/UqWDDpILW788g1pdnO446bpBduGdJ/Bp1Not3yJPUuQblUdWVQ089A4gTDMIuRPkxrwECKpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzvUfwhT8uf+JImY8b9bjh18dkBBpAPPhX5z1MF8U3o=;
 b=TQmZ3an69D0VNTXKhKt+KQgug9Cs6JFZdbe5cFGnIqgcGbCHyh850oxziFLS4SghSiT3PsZGf+VhZuuIna8aPX0bWvIcdm0xr8zpvlzH/x5aP0qyRyLVWOQdMKgLUBZklbDH6aDB6W6nFzFhDrMxhTBEVQ4vI//2/EDMKPQwI5DZtnoQsJe2zZTTu5PJOGUMkzGgSHVHCLyi0m3aeK4Nzb/uJAzZz2y3ii3zE5uO5z2Ia5v+c+ihuSAE7vVgh/Y+WzNWy3IkNK1bjRJ6bej17+EcRZ27P0y1wEM4u8GaujgF23+glDzYT3QJqsPeX4vjsuypTDM9Bbe6uk0ZJz2WKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzvUfwhT8uf+JImY8b9bjh18dkBBpAPPhX5z1MF8U3o=;
 b=NdxosZjbo/zBR0FaIg6rA3VaXl606hSGlaWSHCuR84DI4+d1CNxZs4oluAp+OsL7BL++WKyAXjAGXPQ9UcFvLUd6wZ+EA4Gv7ErGkw76cxvZvMCksNi4R7YTDrqHzOE7sX3NWRonTNDeEWIQgttlLuh5KmDR+zNonBTeIVfJHWc=
Received: from CH0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:610:e4::16)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 08:45:49 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::46) by CH0PR03CA0191.outlook.office365.com
 (2603:10b6:610:e4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 08:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 08:45:48 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 03:45:46 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <david@kernel.org>,
 <gourry@gourry.net>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v9 0/4] hw/mem: add spm-memory device for Specific Purpose
 Memory
Date: Tue, 2 Jun 2026 16:44:43 +0800
Message-ID: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3de61b-e9ad-4749-1dad-08dec0835837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|18002099003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: 6hKsz97pW0BfmQJdnDRwArAi43qsKUQIeR19KHH4HXXMtj4X3ZoGLInDcuWBGNu2jLIs6FGuCSju+osR/21aNhN37Gn+pA8N+ugSSLwcpfZDJMZuYoq1e11uh+XZF5XGAtsmoJsKgvb51s0YdSW7/mSm+q33/3yQBRs5HucFQrq4Tpk/Rb51txxWvQkMMcr7qJwu9Ld2PafKdVVmSCa0zIeP1zSHj3tqjEB8/Ben2b3Sx2hD/BUYkShXzKpvGZTFVb+r7A0c114rxqlITlWw9N/tF4yp8nw1UpjoNawmEt7UiHp4CNtZO5GfExpgNA+ma8Sy8RhznMD5aueonKXa/zwinnw0uw9FX+Z7cOwa7khLvFRJLOiRKjK4h6ymG/ZvlidzH56XBm73a9BRJk4NamYu3H3oWzwTYvr4JKHdGb3DVHy8lyfBgM0CRcUh7ThflwU/ry66NB5bIi6zroCspPDr2AKQl4WMsYBZkojNtumMIptirN7QuaUwJeN5wiiumaUfAhzhYPyMPVAk16LYfQom8Kh7d3c9uc4fbVcQcmE46sn1ERbeKjeyLdV0na/gp6ThTaW+wZCD3hy7FaWttvq+e1E9FXB5W3Z/JY4goHtkWgvmIyrhffwM4v58hHW1NsiYt3vh3llfnJT1iGWoc4+cE2dXzyZ1VAYH+PLVi7Ml54tso9MgBUnMwBPsjY3yNsJp1+bNFN+QscXrvbnHjMRVGDKPnNq9K/y63XzLMDA5hsUEyixMlVua+9/y7W/p39wKCgDpaDEjiysft+UXqzPmRBBHtBZONVMa6aPzZnM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(18002099003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gVDnGO2J31qEzYlOwJdU14ukVvk9CiIfoCv45YDrFxgpNDiEGwqKtMLwjYWyH71UHZ8n/Ha4lRVIkwqcgEUzTfDomi7noUF3MqqVDIXNF2V/OHB4QBtCLgibJpzaQ15XvI8iQGhbX3b2PsenJUsOuKP9jD3sgfG7oiYexGwW1F/KaU4bQv5tU46RMuB5KQXox+dI7xguVPTQb+lV+YMx5z4Min1mOThQGH096T9X9drYnFgljq3nP0Dvfbv8JG1flpMgY1O+UCZiEueDV2c4aRy6TmpRRvjrYvz3J5hU3HEey5GnY1CNE3wOYoYPXyyM1V1z8CYrvjzov6vZQe7RB1SmshK5vunWVPLjnsZ3npdvnyoyl7Pi1WztY3USSnPqQDYt/ycYX/bKiDYZdjCmP3v1Y9BIAHU79MXUKz0JPsVeF4HnbS5/wz/aIXc4rvgY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:45:48.5696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3de61b-e9ad-4749-1dad-08dec0835837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=FangSheng.Huang@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This series adds a TYPE_MEMORY_DEVICE subclass `spm-memory` for
boot-time SOFT_RESERVED guest memory, following the direction from
the v7 thread [1] and the v8 review [2].

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
kernel's general allocator does not hand HBM pages to unrelated
workloads). The SOFT_RESERVED memory type in E820 plus a matching
SRAT memory-affinity entry is the mechanism that delivers both: a
firmware-produced topology that the CPU memory subsystem honors and
the accelerator's driver consumes for its own range.

Approach
--------

The series introduces a new TYPE_MEMORY_DEVICE subclass
`spm-memory`. Each instance binds one host memory backend to a
single NUMA proximity domain and is boot-time only; placement,
mapped-state enforcement, and QMP introspection come from the
existing memory-device framework.

The series is split into four patches:

  1/4  spm-memory device (boilerplate + QAPI)
  2/4  acpi-build.c SRAT umbrella partition for SPM
  3/4  pc machine plug-handler integration + E820 entry
  4/4  MAINTAINERS coverage

Testing
-------

Verified end-to-end on q35 + KVM, with both SeaBIOS and OVMF, for:

- single spm-memory instance
- two spm-memory instances on different NUMA nodes

Guest observations: /proc/iomem shows one SOFT_RESERVED entry per
spm-memory device, dmesg SRAT parsing reports the matching
memory_affinity entries with correct PXM, and the umbrella
HOTPLUGGABLE entry covers the remaining hotplug-memory window
without overlapping the SPM ranges.

Changes since v8
----------------

  - Split the single v8 patch into four bisect-safe patches.
  - Drop the per-machine QLIST and the spm_addresses reservation
    array; the SRAT partition iterates the device tree directly
    via object_child_foreach_recursive().
  - Drop spm_memory_check_node_exclusive(); the existing
    memory-device framework already enforces the relevant
    placement invariants.
  - Slim spm_memory_realize() to a hostmem-set check; move the
    is_mapped check to pc_spm_memory_pre_plug().
  - Split the pc-side hookup into pre_plug and plug callbacks
    dispatched from pc_machine_device_{pre_,}plug_cb, matching
    the pc-dimm pattern.
  - Add hw/mem/spm-memory.c and include/hw/mem/spm-memory.h to
    the Memory devices entry in MAINTAINERS.

Previous versions
-----------------

  v1: https://lore.kernel.org/qemu-devel/20250924103324.2074819-1-FangSheng.Huang@amd.com/
  v2: https://lore.kernel.org/qemu-devel/20251020090701.4036748-1-FangSheng.Huang@amd.com/
  v3: https://lore.kernel.org/qemu-devel/20251208105137.2058928-1-FangSheng.Huang@amd.com/
  v4: https://lore.kernel.org/qemu-devel/20251209093841.2250527-1-FangSheng.Huang@amd.com/
  v5: https://lore.kernel.org/qemu-devel/20260123024312.1601732-1-FangSheng.Huang@amd.com/
  v6: https://lore.kernel.org/qemu-devel/20260226105023.256568-1-FangSheng.Huang@amd.com/
  v7: https://lore.kernel.org/qemu-devel/20260306082735.1106690-1-FangSheng.Huang@amd.com/
  v8: https://lore.kernel.org/qemu-devel/20260527071907.4193280-1-FangSheng.Huang@amd.com/

  [1] v7 thread closeout:
      https://lore.kernel.org/qemu-devel/666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com/
  [2] v8 review (Igor Mammedov):
      https://lore.kernel.org/qemu-devel/20260601105057.2d764e55@imammedo/

fanhuang (4):
  hw/mem: add spm-memory device for Specific Purpose Memory
  i386/acpi-build: partition device_memory SRAT umbrella for SPM
  hw/i386: integrate spm-memory into the pc machine plug path
  MAINTAINERS: cover spm-memory under Memory devices

 MAINTAINERS                  |   2 +
 hw/i386/Kconfig              |   2 +
 hw/i386/acpi-build.c         |  98 ++++++++++++++++++++++++--
 hw/i386/e820_memory_layout.h |  11 +--
 hw/i386/pc.c                 |  35 +++++++++
 hw/mem/Kconfig               |   4 ++
 hw/mem/meson.build           |   1 +
 hw/mem/spm-memory.c          | 133 +++++++++++++++++++++++++++++++++++
 include/hw/mem/spm-memory.h  |  42 +++++++++++
 qapi/machine.json            |  43 ++++++++++-
 10 files changed, 358 insertions(+), 13 deletions(-)
 create mode 100644 hw/mem/spm-memory.c
 create mode 100644 include/hw/mem/spm-memory.h


base-commit: 5611a9268dae7b7ff99d478ed134052a9fc7e9f7
--
2.34.1


