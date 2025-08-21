Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5111ECA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4xs-0001Gp-Hw; Thu, 21 Aug 2025 09:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4xn-0001GO-Mk; Thu, 21 Aug 2025 09:04:20 -0400
Received: from mail-dm6nam10on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:2413::60a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4xj-0002s8-Io; Thu, 21 Aug 2025 09:04:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypO+ZQeXM+TCt6KkvDwkk4uuw7baCtD5oSaU4ZKRXW0vPuEl87jLzeMpdPCmwPxJgQyNEg6wvsPbCWlZwLRuGxnTM/v04SByHMgoHrK60GOQo+XatHI5SYa7hiDt+J2QtHE4ijBb+0/U1iSeR4TF3eSwC/XQbdZK2zXI6T8vRZooFFDIujSe0lHwkUhcEmLAiYgogFjVMxwOYN/l8/iOPfc6BbxIbQnVK5WN4KVZ51L+dS1IVLqLZ1ogdRqr807QiMaV2ija+sstmVpvPJ1tqmy3U4bM/aIjXDSoMkPfMfdC2nEpBwPWX2aQFkE5/n37JHMOY41IzySNBq7V7f10+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sUTAo2FB4NP35+iULBJk4MHwSEJnKmWlpTdulyS0fE=;
 b=ETikC4kVxhLB9tjRoUEAU7v5bIfacg1eSWNQvpo47lIX2av7ZlWr04hxrv1mgQiofbvaphvlAfZityuC5OLRljqscpwQ+6FKf1JGvEJgQJvOH0jZB0VFCcPCHVz+dhfr8P95g2/PcrLxPo8tP5tN42g+uxLqOyVUvysG+0O0LoPOa8EvWodhD+rtnE2sEcUi7jdj9F6StnFJ0/JNts3oFPEB5L2DAsOQ4bKUZqATptkUCiTJX0y/oRkhCHsi0mlK4Dm4diT/RUTbH/yshthwKOKmNRDe5QJkV3xBCsj0fyE+Y/ktzll5/nngS7K6LMoN6OOBbwnjcCauMwjWMp851w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sUTAo2FB4NP35+iULBJk4MHwSEJnKmWlpTdulyS0fE=;
 b=EjMdynINj31bA8CIKfa82J/XAfefM2SEkHMb7DSFDdQsZysd4pVtB4I/p3xRpmCbThVtoqJ43QrtX8t/kIR7Ul+mxxrb4OCguOuNPHZ9Z+g0GOF6mxNxK2gSXd1L76w+NpXZKS4XcDQUKGtFpza7mylqdCiO1+QExhpsaxstZ0k=
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:04:08 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1b) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Thu,
 21 Aug 2025 13:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:04:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:02 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:01 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 00/47] AMD Versal Gen 2 support
Date: Thu, 21 Aug 2025 15:02:59 +0200
Message-ID: <20250821130354.125971-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: fc244d47-1507-47bd-cf5d-08dde0b336c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VklDUzY0QVlxVUNkWStEeE9nUW83S0tpNFlPUXlhSnhXRlR5REVSeFBQS1JH?=
 =?utf-8?B?ZUI4WGN4Zlp0bW1RRWw0cFpvS1lRQjN0MDMwZnh5cW01eCtMRDE3Sllubjh6?=
 =?utf-8?B?WlVIdmh4OGt1WWtHM29NTGxwTFRtai96VzNFc1F3SDUxTVo0QjJadndieXhy?=
 =?utf-8?B?enVvMkpNS3lZdWI4b0VVTExqekJTRWF0bXhrZFBmdndIakNOUEMyZnVlNm04?=
 =?utf-8?B?aCtlcG4zemZLZjdXK3I5ZE4xOUl2bEFTeWR2c0J1eUFLVEZZeG5tWnBveldt?=
 =?utf-8?B?Y3hpMGdnb2Y0MWJ4ZDRKeEptZTRTaFdjZ092UUZhcHdnMTlEVFpGRmYyclli?=
 =?utf-8?B?TFl2OXpkZXN6Nks3Y1RnbXV5bUs2STZLRUVDMytOYUpkUFVTbVk2c3IrM1Fn?=
 =?utf-8?B?OFRtMEFDc09tVmxrWmZjWE1BZ20xUmtRWVQ5WG1Mb2YwbFJzR2ZYZjdmdUdw?=
 =?utf-8?B?TXozTjFMK0JQME90a3A1aGxaL0lSWHk0b0hhV2xLY1RmK1FkVXlHb05rZGZt?=
 =?utf-8?B?ZWtVSllOcE4xemsvaDR2aFdYMUgzSysvKzk1bmUwZ1YyaGllbmx5YWtYWUVs?=
 =?utf-8?B?K1ZuMEUzekFSZVhPU20xMVk5RW44Q0w4dE9nTE9oemhOR05aYzdtT3lHejJS?=
 =?utf-8?B?WkRRT1RURWFIcVh6RUgyWVB0cklLeUpNcXRLT3RxcnphNFFnNU1QZmljU2pM?=
 =?utf-8?B?WkxRdGRpV1hadnM4NVhYUnZXckc0S0hyNk1wWHJnK0NrNktFZndMRS9hcVUz?=
 =?utf-8?B?VTh5Ukc0VktUbUVFemc5TFBKcFJkY1hTMXFWZ0gzb3BMS2pWTXZxQnhXR05X?=
 =?utf-8?B?ajBMaUl5YVcrdmEvOWNmTnNBZEhCRFJOYjJzMVJBY25nMEtZOUpSQVY0STE2?=
 =?utf-8?B?NUczNllwakQyRW5KTUcwcWpyNUluenlyNTZVWjhkckpXMEVhMm4zU21ha0Qw?=
 =?utf-8?B?aVVIeGtQQ2I5ZVROcHpyVnRzUDhzZUNUbmZiSDNCd09ZdUU4U3NDN0hyeDRJ?=
 =?utf-8?B?Qjl1ckhMb2lrdVllTmFBdDFvS1RUM1FXajBCSnczcHN2SFRhM0NIeEowRjcr?=
 =?utf-8?B?bWhTSWlnNGROQmkvRjR2WTM3NVJUT1RQZlk1RG9qaE9tejhoU0JhRmozU0FP?=
 =?utf-8?B?a002RWorbENTZCtZNGJXRlJhSlptUVJPTzZhRVA2RW1aL1NHWjRlR0NSNzFO?=
 =?utf-8?B?VEhiVTlRdDNya3FVbFYraU9DNXhNZ1d0M2o3SmlXd1VrV09ZWXllT1FRbUM3?=
 =?utf-8?B?eXFZRnJCT1dCVXJKVEZ0SmM3Yk53WXhhWlgwT25zK2RETlUyczFET1YxUU5Q?=
 =?utf-8?B?OTZCdTFLS2h0RFgyUHhXWnpNalJNbG9NYVA2Y2RQMWltTnpwL1JaNUlFbTBQ?=
 =?utf-8?B?azQzUUhHWlhRaU9CUkNuUFMrajF4Q2t1Nndnb0ZnMHRaZmxwR0lyaWk3OUd0?=
 =?utf-8?B?Z2Z5WkRLQ1I5QVVwYVRReFJOWTcvdGRSSElITWl1anY0U3RMbVgxSXBUZXlq?=
 =?utf-8?B?bkEvWG12NlRWZmhYdDdoT3dORlEzUWZHV3ZhMnA0UzEyTDRpd3FKb3NTTjho?=
 =?utf-8?B?QVBHdUVFQVd2dUZQNTFERUxUSElZZmxHSUFqeDBwcFVUVm8rSnRwU01JRU5E?=
 =?utf-8?B?TnJVZFQ5d3A5RTVGWGFyTE1ucFhNM20rQW1kYXNvamcxYVoxb0t0WmJ6cE1O?=
 =?utf-8?B?c2FIOXBlKzQ3alVzbHR6RitlSHkwUU93YmVDQ1hWaDV6YnBLK1VaOUQ2d0pJ?=
 =?utf-8?B?dUQxQlV6c2pFWmhIY2lEUUhscjBWTjZ6VjVvbnY3dkVmU2YrVnZYK2N1eitq?=
 =?utf-8?B?elVzR2VKeHE5WUZ0clZSbFlySkpEMWVYdGhMa0R0RHQ5NGxaK2ZZNWhrZzIz?=
 =?utf-8?B?bjBYVTg1c2pFSmNlYUZTeEsxdEp5SnZrY3BMcUxiMGpXWHA4a20zd0ZSbnJJ?=
 =?utf-8?B?TXZCYlVGYWhpa2IybGtrTDV4RUR0UHQ0QzRXUEg1aXdJdUFWNUh5bFQ4MkFH?=
 =?utf-8?B?bWJkWnBGWW5EMVVHalBLSVQ1UjFETDlQNVUvOWFTZHRZbXJjRG1FRlhXTHJB?=
 =?utf-8?Q?LUwV//?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:07.7644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc244d47-1507-47bd-cf5d-08dde0b336c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092
Received-SPF: permerror client-ip=2a01:111:f403:2413::60a;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

v3:
  - Dropped qemu_get_cpu() usage in the machine code. Added an getter on
    the SoC interface to retrieve the boot CPU instead. [Phil]
  - Cleaned the mp_affinity logic. Drop the mask attribute and assume
    it's always 0xff (the Affx fields in MPIDR are 8 bits long). Use the
    ARM_AFFx_SHIFT constant instead of hardcoded values in .mp_affinity
    description. [Phil]
  - Avocado test renaming in patch 41 instead of 47. [Phil]
  - Documentation tweak. [Phil]

v2:
  - Addressed formatting/typo issues [Francisco]
  - Patch 23: GICv3 first-cpu-idx: addressed the KVM case by bailing
    out if not 0 at realize. I chose this path as I don't have a clear
    view of what it means to implement that for KVM. It seems to make
    sense anyway as this property is meant to be used for modeling of
    non-SMP systems. [Peter]
  - Patch 39: added a comment to clarify cortex-a78ae != cortex-a78 [Peter]

Hello,

This series brings support for the AMD Versal Gen 2 (versal2) SoC in
QEMU. This SoC is the next iteration of the existing Versal SoC.

It is organized as follows:
  - The first and biggest part of the series performs refactoring of the
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

Luc Michel (46):
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
 include/hw/arm/xlnx-versal.h                 |  342 +--
 include/hw/intc/arm_gicv3_common.h           |    1 +
 include/hw/misc/xlnx-versal-crl.h            |  378 ++-
 hw/arm/xlnx-versal-virt.c                    |  742 ++----
 hw/arm/xlnx-versal.c                         | 2455 +++++++++++++-----
 hw/intc/arm_gicv3_common.c                   |    3 +-
 hw/intc/arm_gicv3_cpuif.c                    |    2 +-
 hw/intc/arm_gicv3_kvm.c                      |    6 +
 hw/misc/xlnx-versal-crl.c                    |  602 ++++-
 target/arm/tcg/cpu64.c                       |   79 +
 tests/functional/test_aarch64_xlnx_versal.py |   12 +-
 13 files changed, 3057 insertions(+), 1661 deletions(-)
 create mode 100644 include/hw/arm/xlnx-versal-version.h

-- 
2.50.1


