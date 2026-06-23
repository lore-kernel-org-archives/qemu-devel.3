Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4C7CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvzr-0002sY-FY; Tue, 23 Jun 2026 03:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvzq-0002sQ-OT
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:56:38 -0400
Received: from mail-westcentralusazon11013041.outbound.protection.outlook.com
 ([40.93.201.41] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvzo-0001mg-CE
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:56:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCSupvECfT+FTVVgc3b90f2FzDRUyTSOfUmI+ngWtrL7M/rhCpyVBHiu5vrzV94Xl3rbRZyk8aHkbf94p3kbAgu5VdbVH3C5Hw20QQN2T0i6E03PvVQxg56eEdkg+p/tbOUhmJujL8RcRqNbdKqNRRAoucQJVVkAaASxqu4K7B/kOUzr4JAUvwXoLJjVU56rHw7J7QRv98wUr8ihpA5KBDA7ukXoBLP9WTZadnoxb6WPQO8Mkg3UCSyh9ySrEtUrEmKvBLgvblezEeG23QitDE0rignXjA9Esaq4xiOQsSLniJ5T2sHOaTwuw8/HUqfMlEUte+6ZE5O7UeFf0s6Ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9KJ9LR7w3j0i4K6KUDjAghNjxAfByy3vq0rb14JEc8=;
 b=yFH1UVwTJqfT/OuAxeUSAj9Wq9U7rUIHe6DwdU+Jj1twEgGdvRUqW+TwZU8tfpzLK9AMqZoRVWzEc2kTwFLHYyj6QKgSCYnwEgg3jFjpK6wFtRat5dy/lwao6YzbAPco7sDt1X0+VvHcaTvph8iw9qOaJAKD5Yq42BKyiFpmDUknbercXDzYEACbCujltSHwm6v2v1db90y+8W0EjfQocLrMUP5PxzFAnTEPO3WGHjfAR9zCJGNioRTclTBCB0lVh6kGeO9xirYOyCZnQR9kYD7G4A6ToyECUwx2z3H6WtY2kNo4AdgcYc0o6Y59TMAIgj74l8dtbhoAYK3dT8XnBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9KJ9LR7w3j0i4K6KUDjAghNjxAfByy3vq0rb14JEc8=;
 b=Uryah150H5SUfBO+0yS864o7kiY31wOHBUU9ieYvZVq6detoykAEHZuV1N2hf9zjJhalTNipfgu56zCuctrM5y4Q95r9HBEccgyH4Yxyw6v/hqNnz5kuTEYkmlxJKtMJBjJXf72k4DNtua1LEZ5pDUdp+0tIz9iOwddLKgFe528=
Received: from SJ0PR05CA0171.namprd05.prod.outlook.com (2603:10b6:a03:339::26)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 07:51:27 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::ad) by SJ0PR05CA0171.outlook.office365.com
 (2603:10b6:a03:339::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Tue,
 23 Jun 2026 07:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:51:26 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 02:51:23 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>,
 <david@kernel.org>, <gourry@gourry.net>
CC: <philmd@mailo.com>, <berrange@redhat.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v14 00/10] hw/mem: add sp-mem device for Specific Purpose
 Memory
Date: Tue, 23 Jun 2026 15:50:41 +0800
Message-ID: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: dc612dd7-41f8-4eff-c3c4-08ded0fc3a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|13003099007|11063799006|56012099006|18002099003|43062017;
X-Microsoft-Antispam-Message-Info: IYBAGntlNUjol6mU8QfyaMcl+zaS9R1C3bMFiH+PzuyENEa0c0ExWD25BgtwQiAaWPpNS0N6gFIokF4MWQfKSSCoFHvi5SdLtix6zLKp+5vaT2eW/M5fTJ1dj6rHwB8ZW8ikrjGrP/GfJ374eBEPbTNfy5mABtuiFeG78RRUzLycj4fADYS5rIufzq8rYLsGrh59ZQtmjGRjt2TJmkcWKcLWRHHU8cPgH/eq9BVY+XxTj9TE1TTDRp2wT35miiI9lH1Dk7idODrGFK2pTZQ/CF46pWfs/pakirRY7rfF5dpiUouzUveoUoroDbXRVIxNyS70JTlruY7U3TCjLXQv1QGpO15koGoO762pp+3kFEO3dM3lMtywqUJQaN+PsV9T2Zaa2ZK13JlDULzpObjKv92UYh1l7RHpoXdxItow3CPxly9lR+vp0x7wdb3YrWnJHNtqAxL2Rxe9+WHWMGIiOctrnCvViEw0yHqAswbSmaBiOUWF66GTG2E7QtHoJ142FJolSOWQYsWMecf0EYaUk2NWtPwxwMAm/YB9S+gXuSkU/0TTlyrNgSeb20CfgC1XZILt6qCn33xT3NqqJCOgka2byQ/NDnwQLkyCLaJxGKWx4EAyz4eJMvdwdY+FGRB4DVkXu/jzNuGIuZUveRkuGY9djapdALw3Tp86pT8SjtnBqJma106BIxH1TpjUADsmgJ0OxTqiT6f6Ckquw9PwqH0gd5NOQelWfi+QRwiw1iydvTulyzmdcuXpP21rP9ob
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(13003099007)(11063799006)(56012099006)(18002099003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T+fv4qpT7oCOAGWcXLx+Z3BYQRKWK281jPB9VsAGKgve5+6cyDbH0rCR2E8nL1mZtEVhJXS8yQAegjDQ0dqzLSnSUjEPWRSQSJp264Rm6nr6QTMJT5Hwmx6NI+iX8FGCl+6OYphcajMjtmd/FIlek1G9NVF1GoECaD6MaEEY+vV+GOlWkJds1czy/Wt97eubLTseMjJP4UZXujkpRcbF9Ytz3Cq6YnUOmAA1f2uIpe1UKoW5r+aOblW1ArSlsZU0XF0vZCOfF1l4kviYT93WUb2i/wAESUALvAEsX4g9KMR1DzdeZ5C78h9g6Ox6YWoiAgemJ7fmhNjpuiOe+/ko2JXUZRKPoQDUczs3JfuYdWcVYutgUyzqRJQYzm9lmCl+fDLY/SfGDzXmpDlWt1XQzGoxe0gyCC/B+x3U6Y1Okb/loqT/Tl47HRr/6JcMkv7B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:51:26.3656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc612dd7-41f8-4eff-c3c4-08ded0fc3a7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795
Received-SPF: permerror client-ip=40.93.201.41;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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
thread [1] and the v8 / v9 / v10 / v11 / v12 / v13 reviews
[2][3][4][5][6][7].

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

Changes since v13
-----------------

  - qapi: note that SpMemDeviceInfo's @size is in bytes.
  - pc: fix the indentation of the pc_sp_mem_plug() continuation line.
  - Collected the Reviewed-by / Acked-by tags from the v13 review.

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
  v13: https://lore.kernel.org/qemu-devel/20260619111136.3481329-1-FangSheng.Huang@amd.com/

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
  [7] v13 review:
      https://lore.kernel.org/qemu-devel/20260619111136.3481329-1-FangSheng.Huang@amd.com/T/

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


base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
-- 
2.34.1


