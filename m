Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E7BFEC0FC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58gJ-0000jD-Al; Tue, 24 Mar 2026 16:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1w58gH-0000iX-Le
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:48:53 -0400
Received: from mail-southcentralusazon11011002.outbound.protection.outlook.com
 ([40.93.194.2] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1w58gD-0004a4-AT
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:48:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYUQZPjGAH71d40DMnWDI3jA1OofJJzBehJ0hHc+isOrC3Ax7xMrrkHjioSc5keXOkXpbjE1z9WcJj1g+x1+YAqMviIjrqvQBjggwANJyaZoMdxbrlJYZSyMH6YJ/jtYBOa3S0QtIAioi4xEtp+58340c6tJKd36HuVVBH3xxExp7bss6Ss/9tWr3eH1dNe6IjS9BdOhZooow4ljcATMkCk7cp+vhBp0lDMrOkmJagJM5yvobR1zssUre+3oCQorFpwzbpxIquaJ5L4LA1cEGfQfamQIz8dcOLREp7MmUOWmMLMkbCf/Ltik2mor01gi/oskBq/nC/OmKE03TdwzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+6G7oP2bhkfS0Pgs/p8MjzSGJdkih9hok4//4tvh10=;
 b=nZ0tPzp7zLApuBRj4r8obwiPRBqLJjm8D3P8rE3D4d2FvR4KSb8XszCgSlvWhJ12pUO4GkOFL73G/UyUSbZEgnJYRl01Fp1eyFOCaD9xGaFRX/hlNG2Bp7wnJD48dCjKQL2MDtsXm0vhpwrZseQYu4axDwcVCnvnRjNlmZjsflg6ZB9UDUkYDinNjLJv57K2f+8yrh1FFMI7vB7sp2yr/nAsV7KHlASOh1m3OavzUte6FOB7GXBmzlueXTU1C74i4Di+IMrTEaZIZTdqP6DyUj+p4sthdY02Bg4fRtOEEAHH1d8FSPNE/0gcZBOxAvI5kKYtmcBWqhdxKgjISnilhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+6G7oP2bhkfS0Pgs/p8MjzSGJdkih9hok4//4tvh10=;
 b=gEy6Pjy17GnXbz3W2WHqGMvwi9EsS8AtcBtxiRmtu/MfL7fenZz+BVrZ5m5G1aafnum7M9DhmFJPfvUM2EIxLWVm2/S/+ASl9SiN660wqrMAOl+p+eFHhTnFuLg/5eynsczwqcWFN7hxXZKSAIb4AwCFuvV8qS2SDVG26yU2Z7s=
Received: from BL1PR13CA0220.namprd13.prod.outlook.com (2603:10b6:208:2bf::15)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 20:43:37 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::ef) by BL1PR13CA0220.outlook.office365.com
 (2603:10b6:208:2bf::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 20:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 20:43:36 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 15:43:36 -0500
Date: Tue, 24 Mar 2026 15:43:19 -0500
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Subject: [ANNOUNCE] QEMU 11.0.0-rc1 is now available
Message-ID: <ijk43fnzhbaxmlufnpnfpg2fevvwsskidtgqtta6lxh2wykrfv@4hy5mhglcfto>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b7404f-3cc0-4ee8-1dc9-08de89e60606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: J6vFy4UsinN//RIxQ37ZtbeuEDXj8hSfQWMk8fk/k6CvJoBk2wpexXbeHdnerewDMZdvwEMU3NEzGZmKBVlFVaIV3Zhu0L6E3I9plLLEjJvaveDpem+sHLmsMGxrAqEaewjsagX4odDbhmagLDOo9qF03vybrqXl1N3z0Z4fPyQMLCwsENTMxzzi9QDQ7tZ9ixF6jfP3RhJ55sAK2w5rGosm8yUphUNBNOUJAhi0wcTSf2yS6oK+w0Cm3h4t5tcmETkOVJOzL0EMKmCGgpbMLQIJC+oJSzkpD2WbH9NcxUWXIIUUhGRUFOOrFjjpWz92fzlja6kbOYDps3aC7phT1KHiP2u5eTfgXynYuCse2hGkqF3uinSYT/5WfVK8KkfK0Jf4GvMd4zfbiFYUVKpV3lSa+yhbuwwlsMBNUWoJ+HnWrKLYVDDM9VH+dIEsOv3/JpQK+d5cYWVeWS7+/0ry77mHpLHBRP6us6eKpbzUgVpBDeXNSzHKYqPSc9PkShswEr4mkP8bTILgBCWU6h7aTIaKHQF0YoR0XMrfsf8F5BYqBgdHmNrS07xLuXzNHLlYoJwOcpQ75NMxiJnKkh4OK82TzwMfD7Ba8RBwTsptvVBEFRcnf18CEAkvrRvU5w04zfGMqytYU5AeoirWUbuI/xoUX0ghRqCIF8xc/dKozc9mJUaYHwYDj0HXbv7Vj8dbivH3ciHurzjNm90Bu+USeJdoPhIsxj7Ma3grrFc4avs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BDVJbNm+pxmTUnNchj3o5Kaxm/SiiUD4OnvOlvGFYHdmpCps9Ayo+nos3kFW9HxMyTqvRFSP1VV8cxWABpifLMCpMcHPtJcVA1yOAwWpszyqC2t3XYDYaHGci33WY4xzuhgswb8D2GJrrs7Orbm35UYY75eSyKV5+7GP/SnUhFVBrxlCMnrWOErz6ibfuGa0bv6JIrfZhNBF+m5avoJmk7aDNuv8a5DgO01Fj2FtYMGtdos6yTZ5uVJfHjMwWrvh66docU1Kzt8wNwA33l+Ipz78mjaAPCSLJ8v7bLmVY7ffNgh4y6jIq92g0Mi8aRCMkFZWHJnYIIRWSHFyQtPO23cp6+/+i/OnLIsx75zvFBSvyq9PEVyBqLE3v4rQn4Bk3p91smheycbYOUsx+ditFjDoy8sQBpERtvZBGdxprBOSNxyUEOMlk7vIlmpR9ht6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 20:43:36.9373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b7404f-3cc0-4ee8-1dc9-08de89e60606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
Received-SPF: permerror client-ip=40.93.194.2;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Michael Roth <michael.roth@amd.com>
From:  Michael Roth via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
second release candidate for the QEMU 11.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-11.0.0-rc1.tar.xz
  http://download.qemu.org/qemu-11.0.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 11.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/18

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/11.0

Please add entries to the ChangeLog for the 11.0 release below:

  http://wiki.qemu.org/ChangeLog/11.0

Thank you to everyone involved!

Changes since rc0:

512b794b10: Update version for v11.0.0-rc1 release (Peter Maydell)
af35bc0c14: qemu-options.hx: Document arm-smmuv3 device's accel properties (Nathan Chen)
c2ff1305cc: hw/arm/smmuv3-accel: Change "oas" property type to OasMode (Nathan Chen)
d3d2de3d22: qdev: Add an OasMode property type (Nathan Chen)
ffded86bdd: hw/arm/smmuv3-accel: Change "ssidsize" property type to SsidSizeMode (Nathan Chen)
3a3dd64e63: qdev: Add a SsidSizeMode property type (Nathan Chen)
1a76cc3933: hw/arm/smmuv3-accel: Change "ril" property type to OnOffAuto (Nathan Chen)
9f8a8e0f2c: hw/arm/smmuv3-accel: Change "ats" property type to OnOffAuto (Nathan Chen)
dc86d45232: hw/arm/smmuv3-accel: Check ATS compatibility between host and guest (Nathan Chen)
5a2fa06b09: hw/dma/pl080: Fix transfer logic in PL080 (Tao Ding)
0376e9c2dd: linux-user/i386/signal.c: Correct definition of target_fpstate_32 (Peter Maydell)
32ebd6c09c: target/arm: fix s2prot not set for two-stage PMSA translations (Jose Martins)
8a74949354: mailmap: Update email for Nina Schoetterl-Glausch (Nina Schoetterl-Glausch)
8ee23f993d: MAINTAINERS: S390 CPU topology: Change maintainer (Gautam Gala)
5fca367b89: hw/i2c/aspeed_i2c: Remove assert (Cédric Le Goater)
80c5be9458: hw/ssi/aspeed_smc: Convert mem ops to read/write_with_attrs for error handling (Cédric Le Goater)
adbe612295: tests/functional/aarch64/test_aspeed: Disable kernel crypto self-tests in AST2700 boot tests (Jamin Lin)
24b5f58bee: MAINTAINERS: Add Kane Chen as reviewer for Aspeed machines (Jamin Lin)
7e82393ed0: hw/i2c/aspeed: fix lost interrupts on back-to-back commands (Jithu Joseph)
b7ae542de4: Fix several typos in documentation (found by codespell) (Stefan Weil)
bcf5e68cc9: docs: Update GitHub URL of libu2f-emu (Stefan Weil)
4ef8aca3d1: Fix include statement for u2f-emu.h (Stefan Weil)
070fc71025: hw/hyperv: add QEMU_PACKED to uapi structs (Magnus Kulke)
083072dba0: monitor: Correctly display virtual addresses while dumping memory (Philippe Mathieu-Daudé)
fa4a759fc1: hw/net/ftgmac100: Improve DMA error handling (Cédric Le Goater)
2f1fbe6ee9: ati-vga: Make sure hardware cursor data is within vram (BALATON Zoltan)
28df2e5469: ati-vga: Simplify pointer image handling (BALATON Zoltan)
c1315534f3: ati-vga: Add work around for fuloong2e (BALATON Zoltan)
b7c0d01719: ati-vga: Fix display updates in non-32 bit modes (BALATON Zoltan)
4588ef5176: ati-vga: Avoid warnings about sign extension (BALATON Zoltan)
eca8b4c99b: ati-vga: Do not add crtc offset to src and dst data address (BALATON Zoltan)
5c520d976a: ati-vga: Also switch mode on HW cursor enable bit change (BALATON Zoltan)
d0f1fdc37c: ati-vga: Fix colors when frame buffer endianness does not match host (BALATON Zoltan)
129922c2bc: hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop (Jenny Guanni Qu)
4f7a06ec25: hw/hyperv: Fix SynIC not initialized except on first vCPU (Sourav Poddar)
04249f0f94: hw/vfio/iommufd: report hint to user when vfio-dev/vfio*/dev is missing (Pierrick Bouvier)
45a0241365: backends/iommufd: report error when /dev/iommu is not available (Pierrick Bouvier)
20beec283b: hw/cxl: Exclude Discovery from Media Operation Discovery output (Davidlohr Bueso)
bc72b2996c: hw/cxl: Respect Media Operation max ops discovery semantics (Davidlohr Bueso)
6c21a067a7: hw/i386/hyperv: add stubs for synic enablement (Ani Sinha)
c78bac1e67: hw/i386/pc_sysfw: stub out x86_firmware_configure (Ani Sinha)
08324de90d: hw/pci/msix: fix error handling for msix_init callers (Trieu Huynh)
8953fd41e6: util/event_notifier: fix error handling for event_notifier_init callers (Trieu Huynh)
5e69353ff1: hw/core/loader: fix error handling for get_image_size callers (Trieu Huynh)
b06bb02721: hw/core/loader: fix error handling for load_image_targphys callers (Trieu Huynh)
56bd07a859: hw/i3c/dw-i3c: Fix uninitialized data use in short transfer (Jamin Lin)
34aad58901: hw/char/virtio-console: clear dangling GLib event source tag (Matthew Penney)
ea24be6cdd: hw/cxl: Use HPA in cxl_cfmws_find_device() rather than offset in window. (Alireza Sanaee)
cf430fa1f1: hw/riscv: Mark RISC-V specific peripherals as little-endian (Philippe Mathieu-Daudé)
643a171f56: tests: Replace ncat with socat in migration test and drop ncat from containers (Thomas Huth)
b68e5bc1ed: tests/docker: Update the opensuse-leap container file to version 16 (Thomas Huth)
5859803c77: tests/lcitool: Update openSUSE to version 16 (Thomas Huth)
31fb808acf: tests/lcitool: Remove python3-sqlite3 from the list of needed packages (Thomas Huth)
da10beeb8a: tests/functional: add VBSA linux tests (Alex Bennée)
6ba3255d29: tests/functional: allow tests to define decompression target (Alex Bennée)
e413f66f53: tests/tcg/multiarch/linux-test: use portable alternative for dirent64 (Matheus Tavares Bernardino)
fb37a16694: tests/tcg: allow filtering of TCG tests (Alex Bennée)
317268a354: tests: fix typo in char unit test comment (xieyi)
b38859be76: hw/isa/piix: Embed i8259 irq in device state instead of allocating (Peter Maydell)
8bee653122: configs/targets: Restrict the legacy ldst_phys() API on ARM / Aarch64 (Philippe Mathieu-Daudé)
045981037b: whpx: arm: fix ID_AA64MMFR3_EL1 host feature register index (Osama Abdelkader)
80cad8d0bd: target/arm: cpu: alter error message for host CPU type (Mohamed Mediouni)
dccf60b6ca: whpx: arm: remove comment bit that is no longer accurate (Mohamed Mediouni)
f3364a1b04: whpx: arm: enable more enlightenments (Mohamed Mediouni)
fc788ca5ed: whpx: arm: add EC_DATAABORT assert for WHvRunVpExitReasonGpaIntercept/UnmappedGpa (Mohamed Mediouni)
f4df1d60ac: whpx: arm: fix -cpu host (Mohamed Mediouni)
6d5023fdc1: configure: Remove unused variable default_cflags (Peter Maydell)
b64a5f5351: tests/qtest/arm-cpu-features: Fix thinko in g_strdup_printf() call (Peter Maydell)
b86eff44ba: tests/functional: remove heuristics for finding build dir (Daniel P. Berrangé)
dea076926b: tests/functional: fix log placement when run directly (Daniel P. Berrangé)
d319a3a899: hw/sparc64/sun4u_iommu: Fix crash when introspecting sun4u-iommu from the CLI (Thomas Huth)
ead7c5b06f: hw/sparc/sun4m_iommu: Fix crash when introspecting sun4m-iommu from the CLI (Thomas Huth)
4ea7024ff6: hw/display/cg3: Fix crash when introspecting cgthree from the CLI (Thomas Huth)
aee404fc7f: hw/pci-host/raven: Fix crash when introspecting raven-pcihost from the CLI (Thomas Huth)
1adf67b3c4: tests/tcg/hexagon: add test for predicated .new branch LSB evaluation (Brian Cain)
dfa4c8810f: target/hexagon: use TCG_COND_TSTEQ/TSTNE for predicate branches (Brian Cain)
e8743ca0ac: target/hexagon: fix J2_jumptnew/pt predicate check to use LSB (Brian Cain)
38937473da: target/riscv: Fix scountovf CSR behavior in VS-mode and M-mode (Jim Shu)
0e8ad6a846: target/riscv: rvv: Fix page probe issues in vext_ldff (Max Chou)
5568177738: target/riscv: rvv: Fix missing flags merge in probe_pages for cross-page accesses (Max Chou)
f9f430b701: hw/char: sifive_uart: Remove ip variable (Frank Chang)
558f14b26f: hw/char: sifive_uart: Update IRQ when rxctrl is written (Frank Chang)
7997b782f4: hw/char: sifive_uart: Sync txwm interrupt pending status after TX FIFO enqueue (Frank Chang)
e6051fa61b: hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen (Frank Chang)
fa2d5d84e0: target/hppa: Update SeaBIOS-hppa to version 23 (Helge Deller)
3835a61341: hw/hppa: Fix crash of 64-bit HP-UX 11 while flushing caches (Helge Deller)
90c6cf342c: hw/pci-host/astro: Use proper region names (Helge Deller)
0a3283513f: target/hppa: Always map 64-bit firmware at 0xfffffff0f0000000 (Helge Deller)
50bc19c0a5: hw/hppa: Adjust physical addresses of Astro and Elroy (Helge Deller)
cb991be5b1: hw/hppa: Fix description of the HP A400-44 server (Helge Deller)
2a13e31073: hw/display/tcx: Init memory regions in realize (BALATON Zoltan)
792cb90e84: memory: Set mr->ram before RAM Block allocation (Xiaoyao Li)
58cbdc780b: target/riscv: Support Smpmpmt extension (Jay Chang)
3d39fd35f6: hw/riscv/riscv-iommu: Free instance_init allocations in instance_finalize (Peter Maydell)
9d090fe440: fpu: Fix unexpected exception flags when converting infinity to OCP E4M3 (Max Chou)
053e913aad: fpu: Fix repacking issues in the uncanonical step for E4M3 overflow (Max Chou)
f2af8f0d5d: hw/riscv: Remove deprecated 'riscv, delegate' device-tree property (Philippe Mathieu-Daudé)
9251858a65: hw/dma: sifive_pdma: Set done bit upon completion (Jay Chang)
cdb4c06292: MAINTAINERS: Add myself as a reviewer for RISC-V TCG CPUs (Chao Liu)
c58ab7cf21: MAINTAINERS: update my email (Daniel Henrique Barboza)
519f0bdf4c: target/riscv: Fix null pointer dereference in cpu_set_exception_base (Djordje Todorovic)
6802b477e1: hw/riscv: Fix integer overflow in cm_base calculation (Djordje Todorovic)

