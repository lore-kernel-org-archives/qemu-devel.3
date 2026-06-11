Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDE4CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXcJc-0001go-3U; Thu, 11 Jun 2026 06:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXcJa-0001gW-45
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:07:10 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXcJX-0006yU-5a
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:07:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thN14xZRZ0mkaXbbyPIej2xcyUQ4FpmocBYLKG6AV1vfPImjurFeKJFnjSrof8ktPRcUanU7jJn9dMb+8a1edkhWNTj8HJ37COkVx9HhSXhABA+o1B/uKS6yIVVXw8dEnOcnLb9koWT2eqEzZfKa4Bij/QT/cXukuKuCt0uMQm+CiNYbj82j0JxUeIzf+ROroLd1FMHqWnyyTyW8t26u7s2C6s7RyN1suRFnh80y63vKY62CWkR7XTFlNt9JnInKQKzWzunaePHJjxaT3VLSJBbpYzzkbNIc/AXCiC2vuq5fu7YUnzIojkRRBY4Bu9IeXlJUtbx4j7kMwgl43hMvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDNthiw5trlRIdvRYQrwU5v90i61Tr7CJBijqEbXibQ=;
 b=FoRmlY2hq7xxO3Ngbk/HB3Y61sVk6frU8ou5IqB8nadDCykbG0CNvEjDfx2aQ4ZYvH159QRBn/zwjLXa2/8V4XRqS4rzBXNWw2Z49dxWYcQMw58GGqsHuL8QXEgsjC0JcUhnb5RXJeTCvodkgIDZS57hfUnugMDsHGIjApoGbL6zP79Y8dxc6uNJBD4X7W5ZVu6uolIhEjX+3f2kl1I4sMnflIHt30hzw6jBdgTQBuj1M4cPPFUXmbA6fVRLvTxy+e8kPLdqs9ltXdszPK8oXtBIeqfjwfE5gkCG99GRbBeb0bPqfhHgFCHQMyErabdmpKTtyr73Os2JB6v0CSGjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDNthiw5trlRIdvRYQrwU5v90i61Tr7CJBijqEbXibQ=;
 b=WE1bJADJ2caNjoeXItpdOzXpAFCl6+QvaelSB1CjEOMMpW8yF1BYBS1U59MvRIuhvxqudSIotZMwLTL2VIawsKk5tHiTCUVU9hfG9xRFZYihd2kfW5+dzfcrLjDraOhrdEUHdhgHZGjuRW0mRTC6NivbnXYpOczHd9jomPeV0X8=
Received: from BN9PR03CA0697.namprd03.prod.outlook.com (2603:10b6:408:ef::12)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Thu, 11 Jun 2026
 10:06:58 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::10) by BN9PR03CA0697.outlook.office365.com
 (2603:10b6:408:ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 10:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 10:06:57 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 05:06:55 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v11 0/4] hw/mem: add sp-mem device for Specific Purpose Memory
Date: Thu, 11 Jun 2026 18:06:33 +0800
Message-ID: <20260611100637.2460507-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb0c338-0f55-4d7a-d984-08dec7a12c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|18002099003|56012099006|13003099007|43062017;
X-Microsoft-Antispam-Message-Info: pWPaQW82Rbj1yPqwIzqt/e5uzlilVbDyejAMmIV6V1CtoZ8c71rDrzW+om1aFV8CDjEmHMlomJz8c4lhKHmYWlc7i1ERaCGydfUZIc0s3PBEDJGVCWsPRg2VoTFLaPmJjvr3FHrezaqhipJYbjLBec2LSb6rPpDVPFVc5Fpr6KdQp/+cm//iuycDVAC40qGink6iivbO2wLIWXRjXuqf4dwS03eFy9ULPkerdR8Vrh8OUBFE+nIdt8SYQS301cXDtlUft14Zsj1V3xGx67atzcW9a4Y9tV7vl04jH08Ca/l8SJrmjlFo0L3FpUzSuot30IqKRsy2VpdE/l2C0Co1YUXiomL+r9dhbRy7Ov+meGFl/xJl3ngT67YHWpS5AdHP7cCiV42Yq5aLV/qmXpBU942k6S/E8XpqzBUDS8Q+TWUFgGw0Wxl+gwPFt/bfUF6aHIjJ2Irqmqm6soZpt6t2PEqShKNDsMxHyzbTCbk0qMn9EgM3L649I8gwx3Db4kMj+WUQMzTw4nujX5iDdVFYt3w3PwwVyysh8d7akivdAZIXh7hC83ZGpXGAbSfRtXS+Rde7Kb5ZVM09hFRmFIn0BKYSRifN/jRj+ELlTDhcQJpVznHztK4GJxhTvL5KJHvFV3v2+e3o1nDsdDuLsj2K2Y0JU03aF2YTHxLCHMzkJnaPgXoCvm8t62gXkcsTCVp1be34gQDV4vMuJNB4ScpIoqdgCmK5r7JmhPs7sZDUC4JkZdLZ7RAO2JCDTZDI5uj3hQaJwCQebVejc4WyRS1In9k2dVQKVnDwtPjmlTzmTow=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(18002099003)(56012099006)(13003099007)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dXNOb8WinIeGlFbsDt0kLBAMQ6MW0GpYHSNNP7LQOuWPlLvJcTGbvqtUjuuF3VMTp9nkqjDiE9qTfzCkxEvH0mkaVa1wGYYcAwna0u97Yb1bPAgAdXTxiaPz4+HtOtvRMjNWbCuYJvrzOkzVfqlq7eHrNxf5VTy/DjgTp6xmCPpTSuhhZ+g3P+ToOVJ/eUwUswc0FddBXgIEd3EqJ1UInJRx72e4NrFdVJ9FNYuC6mQfxQWxsXqFdCWaBI27Zr5FdgEEt4QOzKieTWCIVTTBK2CHPCdywTRbJtC+9yV30D4evgCWy0Tk0ywAfPkx6q4DFRvH+rIGfHduxtE0ZruECf3/QZqt9dBGVSUF2BF9UOXTKwRqcR5+j1rl+Tl5IxFR/xLdjqa3XXX2uZAyccJSe324McLl9ZVzbcB2armXja4+/RwAWvsGKhPI65s/Fy3G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:06:57.7564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb0c338-0f55-4d7a-d984-08dec7a12c2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
thread [1] and the v8 / v9 / v10 reviews [2][3][4].

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

Changes since v10
-----------------

  - QAPI: rename SpMemDeviceInfo's `memaddr` to `addr` (match
    PCDIMMDeviceInfo).
  - sp_mem_get_addr/set_addr go through object_property_get/set_uint
    instead of dereferencing the struct directly (match pc-dimm).
  - Drop the hostmem conditionals in fill_device_info (hostmem is set
    by the time the device is realized).
  - Use memory_device_get_region_size for get_plugged_size instead of
    a custom helper.
  - Add the sp-mem case to the HMP "info memory-devices" printer
    (hw/core/machine-hmp-cmds.c), which otherwise hit
    g_assert_not_reached() for the new device kind.
  - Rename collect_sp_mem_ranges_cb to sp_mem_collect_ranges_cb;
    rename the local cursor/end to region_start/region_end.
  - Drop the redundant numa_state guard and the duplicate
    device_memory guard inside build_srat_device_memory(); keep a
    single device_memory guard at the build_srat() call site.
  - Add an inline comment on the trailing placeholder range
    (HOTPLUGGABLE remainder of the device_memory window).
  - Move the is_mapped check and host_memory_backend_set_mapped() into
    sp_mem_realize()/sp_mem_unrealize(), matching pc-dimm; the pc plug
    handler keeps only the NUMA node-range check, which needs
    MachineState.

Patch 4 (MAINTAINERS) is unchanged and retains the v10 Acked-by.

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

  [1] v7 thread closeout:
      https://lore.kernel.org/qemu-devel/666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com/
  [2] v8 review:
      https://lore.kernel.org/qemu-devel/20260601105057.2d764e55@imammedo/
  [3] v9 review:
      https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/T/
  [4] v10 review:
      https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/T/

fanhuang (4):
  hw/mem: add sp-mem device for Specific Purpose Memory
  i386/acpi-build: partition device_memory SRAT umbrella for sp-mem
  hw/i386: hook sp-mem into the pc machine plug path
  MAINTAINERS: cover sp-mem under Memory devices, add R: tag

 MAINTAINERS                  |   3 +
 qapi/machine.json            |  43 ++++++++++-
 hw/i386/e820_memory_layout.h |  11 +--
 include/hw/mem/sp-mem.h      |  35 +++++++++
 hw/core/machine-hmp-cmds.c   |  11 +++
 hw/i386/acpi-build.c         |  96 +++++++++++++++++++++++--
 hw/i386/pc.c                 |  36 ++++++++++
 hw/mem/sp-mem.c              | 136 +++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig              |   2 +
 hw/mem/Kconfig               |   4 ++
 hw/mem/meson.build           |   1 +
 11 files changed, 367 insertions(+), 11 deletions(-)
 create mode 100644 include/hw/mem/sp-mem.h
 create mode 100644 hw/mem/sp-mem.c


base-commit: de5d8bfd6105d3dd3ae668df9762df244a6d1506
--
2.34.1


