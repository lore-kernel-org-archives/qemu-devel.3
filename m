Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E926CD6E74
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVS4X-00022u-JB; Fri, 05 Jun 2026 06:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS4V-0001vz-Eh
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:46:39 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS4S-0004TX-W3
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:46:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgxPG92U9ZC69jzBBMfbEDO3BRujIObjoMAVYarUL0BkNfz1j8Jd2dXZ9ONNp5+Pj1JPm2vUhnhnZYVbQcJQmhCuGgn2F5Zj8w3cY0oFzmj0CLM6w18in8PSyhMHNELuTh7FI3hWNawexuMGUtgoMrbw9L94Rfh76KXt1lHjXpX7GDGF8dCcb1q1/mwk2eAtIZ4NAxGHixx9STh1HpCYqr+RRZZm40EECgsO4ZFRk71dntDny9b0MeLe3ObiEIAk6o4TaSvKt+yp6I7SXfALD9UPzQfvgsTKivGv6BD802BK5Mi2cvf58ztsiKoLCVLYKWkW/lhaL547ZnmQdbTQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNAMnzrGqNyc0U9kSBX40yrNN6wMdypK9YqnVIq5zsc=;
 b=hx04KTzPmoB3xg24+xdNN2pZ3vgE9KjIOqL4th9xpHnhno8t20JEcrM8f1Nj6wrvSIq67BJ76I6/WeE0kSCyX1I8yWO7czK9oudCX/uWjxKx8vIYhFV1Qd9hQMD2UAZICApztCFZrpgyCLs37831DWEkNvbPg7CjMzq7ESSkMG2GUOKE2HrJ6TWWicvgOOypvXgUNZ/mTvG/C1MPGlOjyhSfURGpWzIapBDP/wYqdJ6ul2nU5WbL11N0o6hYaPTb/IGdX86AF4GJNbAJmb90P2WTzSknd0M3nl5OA5Hi1ofoRL/K4kIQZVfMHUV4Baf0OHfyccundgAs3Q+ZQxF4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNAMnzrGqNyc0U9kSBX40yrNN6wMdypK9YqnVIq5zsc=;
 b=OaxSFGo5khMXQZaeb3UonqQJr4f+gYWHx0FWAXYz0aXs3IVv6exU4vEZEG5C62FRhB3O3Gou0CKatNggEJ+OHbNEbf1tYkU/aK6zBo032JkBNmAvHO7k68+ZMCly4D04dO2UPb2aAnkSp2v3MRkdJNqHT1mGx4R6ERSOnrO+RKk=
Received: from BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::15)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 10:46:30 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::3b) by BY1P220CA0019.outlook.office365.com
 (2603:10b6:a03:5c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Fri, 5
 Jun 2026 10:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:46:29 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:46:26 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v10 0/4] hw/mem: add sp-mem device for Specific Purpose Memory
Date: Fri, 5 Jun 2026 18:46:05 +0800
Message-ID: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e2d6a7-9280-4517-8771-08dec2efb38d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|18002099003|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: bbuwa/RzRZC9rkf5ZgGC2j+7Nun5bnfAdVXrxxsd7KYUITryryv/CDUc5Jam37kybKnPldaZbmfrTIoByV1JZMcqJnqteQUS5UwF0s51MmbsiwnnaaDL/7VfpHXbwFG0/A/I3LFLWt0VmInTL6xBwGt2lBQ+8FKzFoqgZUh14c9snGdzz0urSMVIlAYQClUg6CxZ8rjSf4WZn+idbFDhVbmU/c80T0c5L0YZnn82ZnZ1YQWSJa8oF+Bllp+LwnMjN3Cd4a9CD6pVw599xM8qPq/AkBLNiGyJwhfy7IOJWI4zNzm5lm5joqY5bf0rPPs4zYR77xxovpzrfkc2S2v0e3zbSSCOQ2mdHtqVo8UAhdIj8No46Nu96fL3/BgidbCAjuqiCBiS/kEqiOJTaNtMKvz7mcFny+hiBel2BgkIg3u05gGfWeUqfqvqX/RENo26IdO+PkSOeaBcz5y842AEZ1Pj+rgkcDv3zaNrt61CrHeSOOA95/t6to7/fbrOmGFz1qPs31o8VRyrMk7Ts8VBsjgBd4oNJXnc3KcUK25LhWzOS9vt4OOzpkclkm8Y5vKfD6PEAyxtzQa3sXv0AcHJcww6n0a3lwbxCQzq3g9CAz54WSkHFkuDj7YqDMgqF/uIPv05v4H83VqUOa9jDChIgak97NsYrFkLH0z4EJWRVHpwnxRmFkpfLoM3yc036ntFMDaR6Tku3QwUJH2pRw8P9uNM/quaTs6zWn0xgMsvL1QDToDCOkn/AO2t4Sk1quBsnYVXhnxTrxxIZXVIbZ7OVxAi5xclf9wiskd0RXcJ6Hk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(18002099003)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ld3lcTUAjoSp7pi2dg8h4w8WontOb9P3SN4R9Yxo/yhM/0XDNc4neNgvxK0GJ53Ib5IDGHfzKlquk7tLbl1gkcwfgzSUbwTBOfLMi/87L/uPj36q0uy4sXla4clsHDQKriQdnPEta64Z6rkMJCM/7rmtJuV6v5R+c/9BlV9W8lMwIAdeDwq0zTP8tjAmqrOJmHMp1y7hKvutwSQnQb975S5RJnJ4QPzNSngzz8qNvQEGapErlaAVbZdNkeiJC34naUDlnLshPVUdKf0XOd2QgSkXTKS4M4sUikUb/PZbIigCa1j39x7pqrjcQ87W2OMvxAZZKYL1+uOz24d9qFfhaHhNdIzwfFYy15GXYUmLb/KkyaRjWyonedcc00rVXtAYpbRkf4vTojPLzBWZH/SiBARscU4MFHhfjEcy6Fy4lMYSOJmQP7vkpoqSep5f+yo+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:46:29.7205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e2d6a7-9280-4517-8771-08dec2efb38d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

This series adds a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
SOFT_RESERVED guest memory, following the direction from the v7
thread [1] and the v8 / v9 reviews [2][3].

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

Changes since v9
----------------

  - Rename `spm-memory` to `sp-mem` throughout (cmdline, file,
    TYPE_, QAPI enum, Kconfig, struct).
  - Drop the redundant `_md_` infix from local memory-device
    methods.
  - Drop the empty `SpmDeviceClass` struct and switch to
    `OBJECT_DECLARE_SIMPLE_TYPE`.
  - Drop the `/*< private >*/` / `/*< public >*/` markers in the
    header.
  - Use `DEFINE_TYPES()` instead of `type_register_static`.
  - Comment why `.unmigratable = 1`.
  - Validate the `node` property in pc_sp_mem_pre_plug().
  - Move the `select SP_MEM` Kconfig hunks for i440fx and Q35 from
    patch 1/4 into patch 3/4.
  - MAINTAINERS: add an `R:` line for myself under Memory devices.
    Keep MAINTAINERS as a separate patch.

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

  [1] v7 thread closeout:
      https://lore.kernel.org/qemu-devel/666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com/
  [2] v8 review:
      https://lore.kernel.org/qemu-devel/20260601105057.2d764e55@imammedo/
  [3] v9 review:
      https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/T/

fanhuang (4):
  hw/mem: add sp-mem device for Specific Purpose Memory
  i386/acpi-build: partition device_memory SRAT umbrella for sp-mem
  hw/i386: hook sp-mem into the pc machine plug path
  MAINTAINERS: cover sp-mem under Memory devices, add R: tag

 MAINTAINERS                  |   3 +
 qapi/machine.json            |  43 +++++++++++-
 hw/i386/e820_memory_layout.h |  11 +--
 include/hw/mem/sp-mem.h      |  35 ++++++++++
 hw/i386/acpi-build.c         |  98 ++++++++++++++++++++++++--
 hw/i386/pc.c                 |  42 +++++++++++
 hw/mem/sp-mem.c              | 130 +++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig              |   2 +
 hw/mem/Kconfig               |   4 ++
 hw/mem/meson.build           |   1 +
 10 files changed, 356 insertions(+), 13 deletions(-)
 create mode 100644 include/hw/mem/sp-mem.h
 create mode 100644 hw/mem/sp-mem.c


base-commit: 405c32d2b18a683ba36301351af75125d9afda08
--
2.34.1


