Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554DBC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyrE-00016p-FH; Wed, 16 Jul 2025 05:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyr6-0000sE-5X; Wed, 16 Jul 2025 05:55:17 -0400
Received: from mail-mw2nam12on20618.outbound.protection.outlook.com
 ([2a01:111:f403:200a::618]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyqy-0006J9-6W; Wed, 16 Jul 2025 05:55:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3iNckBDC5IKlOUlb4DNNqyBM1xXfwQUB12UurnT/2qve/Bz3I/998sxwX+2PVSvq7ij7gwx+sNLx5zuhMM0v5bwPzNfMeL+DKUn7M5lO8wNYenJXTN1tTvdeTRwHxJONkw1aHNA4LUCjCTkwwhRTcCZDV0jrl1EruOvTEeW7jclCeMAsiw67mPVFGzawYW22fwaQQpGZtEElELBMG7ewuA3bfZ2QYJXpXg0orM+ycKlvNwsoROBIeBSIlAHIjitG7VxuFfU5TIxuJ7QWE2tULXpyIpp3ePLgdSy5rI9rpHOA6gm1UZA0KhY4klcbCoxkfdN9j+s/WliOeCSgs3yHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zPWr80FaA2B+xWbyc8xHikR52qwIDegv5gnxQtZkmA=;
 b=EFl9v9aSFrZs7ueCFlYBYhDZP1LYqZAfuaR6MV89p3HgC/vI39Z8ZeAVCC1DLnno9sJxwx/ey6HG2MuZfUgAy/k45gs5BlG9Pa0IzSEN7dudrN8EvOCKsdE3Vk/OY+bvgxflr2db2GjW5sfQafzj2r9bm3SCzIWmD3LI5F5qoiKxX1EL6MmJXJL4ay50oK6pNWRCKPRFGIUQa7WxBbm6sVaXpOygmysH7fPV4zl7anv5QWR1hl8leXLJ5NH9KOD9NSRHG8MWXcbvbZTO33x1zPtG/i5j9q/NPUJP3ps6zJIslwAoTUP5Fy820tgNyqrsx0XPL2E/zCmO2Lbqk8HyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zPWr80FaA2B+xWbyc8xHikR52qwIDegv5gnxQtZkmA=;
 b=W4nJIkUPTmsfedmL6jnXgvgk9jFIT6PvlsaAG8Y2Endc4zNOcQ3o0G6nCvLw0fJYdC4AgK1/uU+WMJpPwBBXwd6lfuXSPVmZxXOmteM8u/QXdaGC+aYVBqm27C9woNNXJV+xuC+Gvo51QXHbujdbMlLfBQFTmz64eSGGY84cc78=
Received: from CH2PR10CA0017.namprd10.prod.outlook.com (2603:10b6:610:4c::27)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 16 Jul
 2025 09:54:57 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::a1) by CH2PR10CA0017.outlook.office365.com
 (2603:10b6:610:4c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 09:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 09:54:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:54:56 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:54:55 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 00/48] AMD Versal Gen 2 support
Date: Wed, 16 Jul 2025 11:53:42 +0200
Message-ID: <20250716095432.81923-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 412b99e3-f7ed-4e6f-2dc4-08ddc44ed27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p3xLz3qQUe+XMxJJP8gPE6uz4w8V6xgPr8rZnts7MTQ96TGAo+iNVQb3M661?=
 =?us-ascii?Q?KZuNz8/kKOrR8OGvE0CDPUVBmUD5H9s3LCiF9TpZ/VY2YKDppNKgOxxceiot?=
 =?us-ascii?Q?Z1+vzxNO1UEBK/StOzQduAzxbSQk5LORGoel8F3Jk0uka/IDY4FbKLTXvtzK?=
 =?us-ascii?Q?M/HktEoRb+F4W83UpGtGPgNjINAXqUhhWYTb5dZMoNBMwJUjSdvTxQ2+JtRb?=
 =?us-ascii?Q?sod8Z0jitj/df8GLrgSR15M0YECXJyOo4/95btxq2NgWSB8moKwMyaAHfiiA?=
 =?us-ascii?Q?/r8Wf4K6QexLTvaBM+XAeppugUGzearUwDD7FBXsm8rcVrKTsnHlaRPvXbQ+?=
 =?us-ascii?Q?QlHaUn5py3arCBKauY7T179Bfg0x4AM+GBOc7uKpMPcZBTEl6m69QCWBKXZ9?=
 =?us-ascii?Q?WQeO/Rsm1dt1Mkik6rbbkM57mAsPVnM9BYC1qQB8mjlvaTFB+PfafuHz59s6?=
 =?us-ascii?Q?dZypH5K7rwJhJt9e9USJpqLxSKN2j2tr/3AvOkS49mHlYJR1z+osNGNXIQ1d?=
 =?us-ascii?Q?5y2hfEk/EDuxkY+S/eFlOscDU65pnF5w7gsfCIZPn+Zu9I1qPLIma09NFwix?=
 =?us-ascii?Q?xVemwubLStsf/CyiicOxQa5z6v/A8JH7gO3N5xe3uWO1QdOUsjA3Qwgdjcdk?=
 =?us-ascii?Q?Jkz8HeVi9XnrKe1dFI6YwZcd8OnsyfsBrC974L3hOYeBkV2rfbdBInGBCa4f?=
 =?us-ascii?Q?TqsJ7b+Sw8q1D8PI7DohqT6ZaeEcNYhSQgMqrrL3vHC1Z5iiUbdq648PS6li?=
 =?us-ascii?Q?KckZdrkYBdlkgADyX+1gccYhJC7JR0TEu+QOvQJN8njfhuWTUVsIOy55pzS8?=
 =?us-ascii?Q?FiFw6YdB6s9ssNkexNmlR641t+JUQW8Z6WYQa0HYJyvVdVK13LDJZ9NiQ5v6?=
 =?us-ascii?Q?CN/sIqgJSo4bZfm1IgF3xBprs5xEIG8fIG+rG0LSf1GH5cg9Mf6Ql4dGlhCy?=
 =?us-ascii?Q?tgy8/vKY1p11EPXE1HgL2jm2rnEbu2Da6nC94T706PaTzQOT62faamSiXzBy?=
 =?us-ascii?Q?hwhxY5Y1Lw7WwdJ21rtreyXXyT8Z7o7uX1aysLFr3Nm9SeShKee+/WbkVORM?=
 =?us-ascii?Q?nS5tYnbtgu4SmfiuL1qIjw7fXU2hbXfnXmTK1UofgiyuHZuY1e9Y6637kJQV?=
 =?us-ascii?Q?u93OD8p+Ml2DkVdE7VKh4+wRxqJZeVoo/eOgleWUeCLCVdqwbrHq9uMb6f/f?=
 =?us-ascii?Q?X5YeAfQxOKRpNlQnH/dXNe9NapRSNMcZghmm8AEyHrqIl5RbRoS6+Zt4dy5y?=
 =?us-ascii?Q?2+fQX9mhbFSVbNnmipfoV5n/8Dk9zkSEmSjNr2EWcutvqBKHyP+sKhFHIsAr?=
 =?us-ascii?Q?QHZO07ANyy4JLrv/TnLQ3R0821UfrcbDgK3AgQ8BOnM+n8twhFe/qHAseQCk?=
 =?us-ascii?Q?eqHN82Ym5Y1sh/8j0GsoI+p5KSqRjzxmPp2dwpY8yXdTcghEQNhTwH/ZEdMS?=
 =?us-ascii?Q?rUVzQUvN/xEfYUWD+4o0UE2PiZsmwufsyYPRs4gRtlVEcsqne7FuN6AhP51s?=
 =?us-ascii?Q?LQxikuOnZ8U7Aa5j3S68nc9i/uYaPXKiq21z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:54:57.3479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412b99e3-f7ed-4e6f-2dc4-08ddc44ed27b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
Received-SPF: permerror client-ip=2a01:111:f403:200a::618;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

This series brings support for the AMD Versal Gen 2 (versal2) SoC in
QEMU. This SoC is the next iteration of the existing Versal SoC.

It is organized as follows:
  - The first patch is a fix in the Cadence GEM model. Some registers
    were badly initialized when the device was built with a number of
    priority queues greater than 2. This was confusing the Linux driver.

  - The next and biggest part of the series performs refactoring of the
    existing versal SoC implementation. This consists in:
       - splitting existing device types into base/concrete classes,
       - moving from an in-place to dynamic device creation approach in
         the SoC code for flexibility,
       - describing the SoC using a new structure called VersalMap,
       - moving the DTB creation logic in the SoC code itself alongside
         device creation.
    Patches are split such that each device is individually converted to
    use this new approach. Behaviour changes are minimal and are
    emphasised in the commit messages. This gets the SoC code ready for
    versal2 addition and leverage the fact that Versal family SoCs are
    quite similar in term of architecture.

  - versal2 SoC support is then added by adding the corresponding
    VersalMap description. This allows to reuse the existing code
    without duplication and almost no special case.

  - The amd-versal2-virt machine is finally added, following the same
    idea as amd-versal-virt. The documentation and tests are updated
    accordingly.

Note that the xlnx-versal-virt machine is renamed amd-versal-virt to
follow current branding guidelines and stay coherent with the new
amd-versal2-virt machine. The xlnx-versal-virt name is kept as an alias
to amd-versal-virt for command line backward compatibility.

Thanks

Luc


Francisco Iglesias (1):
  hw/intc/arm_gicv3: Introduce a 'first-cpu-index' property

Luc Michel (47):
  hw/net/cadence_gem: fix register mask initialization
  hw/arm/xlnx-versal: split the xlnx-versal type
  hw/arm/xlnx-versal: prepare for FDT creation
  hw/arm/xlnx-versal: uart: refactor creation
  hw/arm/xlnx-versal: canfd: refactor creation
  hw/arm/xlnx-versal: sdhci: refactor creation
  hw/arm/xlnx-versal: gem: refactor creation
  hw/arm/xlnx-versal: adma: refactor creation
  hw/arm/xlnx-versal: xram: refactor creation
  hw/arm/xlnx-versal: usb: refactor creation
  hw/arm/xlnx-versal: efuse: refactor creation
  hw/arm/xlnx-versal: ospi: refactor creation
  hw/arm/xlnx-versal: VersalMap: add support for OR'ed IRQs
  hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
  hw/arm/xlnx-versal: bbram: refactor creation
  hw/arm/xlnx-versal: trng: refactor creation
  hw/arm/xlnx-versal: rtc: refactor creation
  hw/arm/xlnx-versal: cfu: refactor creation
  hw/arm/xlnx-versal: crl: refactor creation
  hw/arm/xlnx-versal-virt: virtio: refactor creation
  hw/arm/xlnx-versal: refactor CPU cluster creation
  hw/arm/xlnx-versal: add the mp_affinity property to the CPU mapping
  hw/arm/xlnx-versal: instantiate the GIC ITS in the APU
  hw/arm/xlnx-versal: add support for multiple GICs
  hw/arm/xlnx-versal: add support for GICv2
  hw/arm/xlnx-versal: rpu: refactor creation
  hw/arm/xlnx-versal: ocm: refactor creation
  hw/arm/xlnx-versal: ddr: refactor creation
  hw/arm/xlnx-versal: add the versal_get_num_cpu accessor
  hw/misc/xlnx-versal-crl: remove unnecessary include directives
  hw/misc/xlnx-versal-crl: split into base/concrete classes
  hw/misc/xlnx-versal-crl: refactor device reset logic
  hw/arm/xlnx-versal: reconnect the CRL to the other devices
  hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ indices
  hw/arm/xlnx-versal: tidy up
  hw/misc/xlnx-versal-crl: add the versal2 version
  hw/arm/xlnx-versal: add a per_cluster_gic switch to
    VersalCpuClusterMap
  hw/arm/xlnx-versal: add the target field in IRQ descriptor
  target/arm/tcg/cpu64: add the cortex-a78ae CPU
  hw/arm/xlnx-versal: add versal2 SoC
  hw/arm/xlnx-versal-virt: rename the machine to amd-versal-virt
  hw/arm/xlnx-versal-virt: split into base/concrete classes
  hw/arm/xlnx-versal-virt: tidy up
  docs/system/arm/xlnx-versal-virt: update supported devices
  docs/system/arm/xlnx-versal-virt: add a note about dumpdtb
  hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt machine
  tests/functional/test_aarch64_xlnx_versal: test the versal2 machine

 docs/system/arm/xlnx-versal-virt.rst         |   80 +-
 include/hw/arm/xlnx-versal-version.h         |   16 +
 include/hw/arm/xlnx-versal.h                 |  341 +--
 include/hw/intc/arm_gicv3_common.h           |    1 +
 include/hw/misc/xlnx-versal-crl.h            |  378 ++-
 hw/arm/xlnx-versal-virt.c                    |  742 ++----
 hw/arm/xlnx-versal.c                         | 2460 +++++++++++++-----
 hw/intc/arm_gicv3_common.c                   |    3 +-
 hw/intc/arm_gicv3_cpuif.c                    |    2 +-
 hw/misc/xlnx-versal-crl.c                    |  602 ++++-
 hw/net/cadence_gem.c                         |    2 +-
 target/arm/tcg/cpu64.c                       |   75 +
 tests/functional/test_aarch64_xlnx_versal.py |   10 +-
 13 files changed, 3051 insertions(+), 1661 deletions(-)
 create mode 100644 include/hw/arm/xlnx-versal-version.h

-- 
2.50.0


