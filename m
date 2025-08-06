Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C79C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 19:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujjNt-0003f8-Iy; Wed, 06 Aug 2025 15:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ujjNr-0003bF-3E
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 15:01:07 -0400
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com
 ([40.107.236.46] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ujjNm-0004S3-DD
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 15:01:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+O/y3jrcloDgTLOOFOYvF5YwC2p8y7qEYQFUaJGHtaqdetrDrLMlHtUBNDdy/7ItUoafqiFQXvNr1uh154GOSt569Fkb5MCpwQV/LkfQR6Q05dOiTYvi4lGFhKubFszeQojaF/v6t7567DzYgz2Ea1PkGcBVemhMM1teSbS00eT1AsSTGsjG1shdnrseQzWe4Dma3Dq8mCVSnsBTiej++gj4QRYenn9KHKM/Z99EZpoTKs/vb8DMFn2jE9rQhZfURLpngVr/V5u69n3Hl7c/Qs+Jtkjephf69uKCHl36Ms4Us0Mvbd1/3aGNM8I+nq3s4rO48amn3/vfwajlT22Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG4+NbmeyFBgUmfHBLRk574kCuEW/R2uaDSUGXMs7Gg=;
 b=c0Lq2Cg5FzcJmQrIvdh/vMH9MivfbytNQ0+AYaEktgMiP3tyH5GlwChtFPidh34uyn/uKR9X8mnyZeWtENZFfnCEh5ofo/ktekQGKNU26X55t2yIFvgRZPevCPr1zVlD5FeBDNlT/FV7rBVHF193gXrR+nEsXSGl3JbY2CaZ4THbYoPNkUIQoa3y6f80urRO5iVaaHtJMXTFmJvG6IWp91qJe3zmUdJVn1+ciwz5rtG+13jGCe/66bgdjL4w5m2AwUGzJrs5+h2eC/9MLpKp8K4Utqy4QaM6mR7pWKzmq6pVoojf/M+MWZ75FneBc1RH0oW7sveGEvWVZNmVSF0Irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG4+NbmeyFBgUmfHBLRk574kCuEW/R2uaDSUGXMs7Gg=;
 b=GXTclfwG9/VokyOXZhvAu5/jC8dZiKPgeoHPUZu9HwODog2UmKVv7QasKrIyPeT6Ln+gVHmAb/iouTdQD+e+zZYKPJCkzJVNyaPJaxg602Ru0YSSC7/ZVRAWSRH2Rh0aF/StJ16JmN3QFJLdlbxsIVBq4Be4PhSK5XWsbAyFi0A=
Received: from MN0P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::16)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 6 Aug
 2025 18:55:58 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::18) by MN0P223CA0010.outlook.office365.com
 (2603:10b6:208:52b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Wed,
 6 Aug 2025 18:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 18:55:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 13:55:57 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.1.0-rc2 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 6 Aug 2025 13:55:42 -0500
Message-ID: <175450654259.3451560.4194015848240509115@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e1c337-943b-40de-a56d-08ddd51ae109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWdPM2dWYW9XNUJzdStJaTdNVCtvQ25PWFNYbllSOUhXTzlBYzJuVnlXeXJl?=
 =?utf-8?B?N2xJRmtXSUJYUXlFd1IyaVZub2NXYVVveExHUk1sWUtkY1N6S0dtWXFIZGRs?=
 =?utf-8?B?cDNPWXhJRUVIVVQ4Uis5S2J6ekxaVVpLMVpnYXE3VGIrb0JkZGVYVTZSZ0hs?=
 =?utf-8?B?ZzBFd0grenJoQkhrL2NIMncrM1J6RGh4QW8yUmZ3Q0FoRTAzTkFIWlRuUjJ6?=
 =?utf-8?B?bHFJN2xnR09wditmVCtFQTdtRVNEcjBoN0RtcSs3UXpYK1JzYWt5WEJha01K?=
 =?utf-8?B?dEpmdnd0SmN3dGthMDYvVFZxMG9KK29zSFg4aHlub2owa1lZOEdKVytYSklZ?=
 =?utf-8?B?dGhOc3VaTVZHUW1HSEhZaHp2MDdTczBzbk5VSS84SmFOZnd4Umh2Y21NVEpi?=
 =?utf-8?B?U3dtZ2NTUWNwQkcyODZTOWpTWUN6UUU1aUwwOU5sTzBydFpPQU1mSVNEdUQ0?=
 =?utf-8?B?dERjaG1NelJLa2NqSVNmVWNDUjRkdGV6d2pkeVRKakdWeHhYVVlEMFcwOWxM?=
 =?utf-8?B?Y0pxRnRybzFBVjlXK29UeUIweW43VzI2YitEZ3l6d2NUdDRKVmlWdGtOd29F?=
 =?utf-8?B?bzZrYklqRnBWVUNLZkN2WkwwRHV3bnZOTnUzMkpib3I5RUo0U3Q3aW5kRmFX?=
 =?utf-8?B?ZUwzTVhuSVlHVUVJaFhIM2VGN2l0M1RjK3Zldm9lazBSWEFKUThiVS9lQTRx?=
 =?utf-8?B?eXNaNEJ6NFdlWHNOQjFyenJCMzh3bGIvVFNNMWk2TXhDSmZtQTdua01BS3Mw?=
 =?utf-8?B?UGUxVlRlRDdpeG9PeG01N2lRNE1nU0dQY3RUc3FFd0N3S0N2V20rOWVWWUF2?=
 =?utf-8?B?VXNZWWxUT25oTmJqS3NiRHRrcFZxR3FCYVZIeHgzU0NkTm5ETWNidG9zNG9i?=
 =?utf-8?B?N0JDbzBxVlRCQ0RYcE5vcTBpK2pFT3hnOEE2c2FHMUJzSHNUUFJUSitjVDJF?=
 =?utf-8?B?VFh5Ukg2S09kTjFlVFZ1R1NkZUNHd1g5MGd4M3V4TnQzTkxUcmVNS2VpUVA4?=
 =?utf-8?B?RmhlcnJ6ZlF5Y0wzWHd6TVprdmJNTGxSc0tKai81QUZMNkJDNEdiRzZ2WURl?=
 =?utf-8?B?QWJobnJ1cmR5RTdyMG5qRUcwb2c5OThzUEZaM2wrbXptamFkVU55T0FmczBz?=
 =?utf-8?B?OGhOM3BvZzR1MW1rTnEyWFZZK0NiQXNvOWJxWHNVUEtXVUgwSlFJa2JQejlL?=
 =?utf-8?B?dkVsdEFqck1Eczk2Qk55OVNjSTRGYzZCdUdPVGI3aG1nYTZpMjFvOGNzRnZF?=
 =?utf-8?B?Qkk4ZnNzUzBiWUU5bjg2aVg5UDB3QW54ajBnVW9jQlNkanpjbGJ6akEwZ0J4?=
 =?utf-8?B?MjMvMXlBbDF5Q0FvOU5CSE5mTWxZK2QvRUNrQzU2V3owcm9vVmkvWmdPU3pY?=
 =?utf-8?B?S3FSYWdpQUtvcU1TTE5WeTk1Rjh1cUN3SG9RZGxTU3F1bGpmVStzdGZRVHBQ?=
 =?utf-8?B?V3gwUjRDbmFlb1JFTnRxYXZCamxLL3JCbHcvTDUxS1RHWERZam5MVGVoUGFL?=
 =?utf-8?B?a2JYbDN5RForTUc0TlB1MXFBTkQyYWhqa05yZFVuOS8xUXQ4N3VtdDIxKyt0?=
 =?utf-8?B?eGtKenBaUG9kcDRxdy8yZmkvOGlHenJlbEY5S096VkFFeVdVdUtjVW5tSFNK?=
 =?utf-8?B?Uk1TL0N6OEdGVmw1U1FyWFVWMTk5dVNna2RUQXZPbXhQbHVEeWpCRXlwSE1U?=
 =?utf-8?B?VUdxMytsRUNTWlNYYnlBZmN2N216R25hWFUyd1RXTHA4L2thR1pzaGVOZzRh?=
 =?utf-8?B?YitPeVV1WlJNTHZ1a0w5Nlp0K05MY2pjUjVkN3dOdDFDQXZrQTlPSEk4TTVi?=
 =?utf-8?B?ZzJoa2RCUUNjeHpOWVZ3N2crenBLb25NUlhYRW5VUnkvcmRQdHlPNE9mMndJ?=
 =?utf-8?B?Vkl0MDVmV0hCdk1nSWExRjdtOXh2RWo4RGQ3eGRwcFVKanZvUWVsTWVudmxa?=
 =?utf-8?B?YXQvckpRaHk0TmF0ZUxzUGkrS1d1b3Fub3QxOGpTbkwwVVpnQkk0QXZnQ1R0?=
 =?utf-8?B?KzFOc0dqUkR3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 18:55:57.7420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e1c337-943b-40de-a56d-08ddd51ae109
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
Received-SPF: permerror client-ip=40.107.236.46;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On behalf of the QEMU Team, I'd like to announce the availability of the
third release candidate for the QEMU 10.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.1.0-rc2.tar.xz
  http://download.qemu.org/qemu-10.1.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 10.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/16

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.1

Please add entries to the ChangeLog for the 10.1 release below:

  http://wiki.qemu.org/ChangeLog/10.1

Thank you to everyone involved!

Changes since rc1:

e0006a8661: Update version for the v10.1.0-rc2 release (Stefan Hajnoczi)
afeb002e0a: tests/qemu-iotests/tests/mirror-sparse: skip if O_DIRECT is not=
 supported (Michael Tokarev)
b217d987a3: qga: correctly write to /sys/power/state on linux (Michael Toka=
rev)
eb013cd6a1: hw/i386/microvm: Explicitly select ACPI_PCI (Eric Auger)
4e5d58969e: target/i386/cpu: Move addressable ID encoding out of compat pro=
perty in CPUID[0x1] (Zhao Liu)
90fd159131: tests/functional: Test SD cards in SPI mode (using sifive_u mac=
hine) (Philippe Mathieu-Daud=C3=A9)
40b242884e: hw/sd/sdcard: Remove SDState::mode field (Philippe Mathieu-Daud=
=C3=A9)
823d9b0045: hw/sd/sdcard: Disable checking STBY mode in SPI SEND_CSD/CID (P=
hilippe Mathieu-Daud=C3=A9)
7574baef43: hw/sd/sdcard: Factor spi_cmd_SEND_CxD() out (Philippe Mathieu-D=
aud=C3=A9)
3c7bde41a3: hw/sd/sdcard: Allow using SWITCH_FUNCTION in more SPI states (P=
hilippe Mathieu-Daud=C3=A9)
3241a61a13: hw/sd/sdcard: Use complete SEND_OP_COND implementation in SPI m=
ode (Philippe Mathieu-Daud=C3=A9)
0f2ff99479: hw/sd/sdcard: Implement SPI R2 return value (Philippe Mathieu-D=
aud=C3=A9)
1585ab9f1b: hw/sd/sdcard: Fill SPI response bits in card code (Philippe Mat=
hieu-Daud=C3=A9)
b82e7a2a1d: hw/sd/sdbus: Provide buffer size to sdbus_do_command() (Philipp=
e Mathieu-Daud=C3=A9)
3025ea65bd: hw/sd/sdcard: Factor sd_response_size() out (Philippe Mathieu-D=
aud=C3=A9)
0a9a27305d: hw/sd/sdcard: Do not ignore errors in sd_cmd_to_sendingdata() (=
Philippe Mathieu-Daud=C3=A9)
61432e805e: tests/docker: fix debian-all-test-cross (Alex Benn=C3=A9e)
0311a6edb9: scripts/make-release: Go back to cloning all the EDK2 submodule=
s (Peter Maydell)
41ae2640c4: docs/devel/submitting-a-patch.rst: add b4 section (Manos Pitsid=
ianakis)
13ed972b4c: hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register read on AST1=
030 (Jamin Lin)
d63961f957: pc-bios: Update vbootrom image to commit 183c9ff8056b (C=C3=A9d=
ric Le Goater)
5ff7ad61c0: roms/Makefile: build ast27x0_bootrom (Michael Tokarev)
7bf9ae8cc2: roms/vbootrom: update to 7b1eb5f7fe6a (Michael Tokarev)
676ab6a211: tests/tcg: Fix run for tests with specific plugin (Gustavo Rome=
ro)
97b3d732af: target/arm: Fix handling of setting SVE registers from gdb (Vac=
ha Bhavsar)
35cca0f95f: target/arm: Fix big-endian handling of NEON gdb remote debuggin=
g (Vacha Bhavsar)
4f2b82f604: target/arm: Reinstate bogus AArch32 DBGDTRTX register for migra=
tion compat (Peter Maydell)
e7b77e681f: hw/display/framebuffer: Add cast to force 64x64 multiply (Peter=
 Maydell)
b10bd4bd17: hw/intc/arm_gicv3_kvm: Write all 1's to clear enable/active (Ze=
nghui Yu)
a0555e36fc: hw/intc/arm_gicv3_kvm: Remove writes to ICPENDR registers (Zeng=
hui Yu)
4caf74916d: net/vdpa: fix potential fd leak in net_init_vhost_vdpa() (Stefa=
no Garzarella)
4164adc476: MAINTAINERS: add net/vhost* files under `vhost` (Stefano Garzar=
ella)
e8145dcd31: intel_iommu: Allow both Status Write and Interrupt Flag in QI w=
ait (David Woodhouse)
cd16f08ad4: tests/acpi: virt: update HEST file with its current data (Mauro=
 Carvalho Chehab)
5088651138: tests/qtest/bios-tables-test: extend to also check HEST table (=
Mauro Carvalho Chehab)
8d5613d2ee: tests/acpi: virt: add an empty HEST file (Mauro Carvalho Chehab)
c0ef803a87: hw/i386/amd_iommu: Fix event log generation (Sairaj Kodilkar)
10690920b0: hw/i386/amd_iommu: Support MMIO writes to the status register (=
Sairaj Kodilkar)
47d3b32d6f: hw/i386/amd_iommu: Fix amdvi_write*() (Sairaj Kodilkar)
a7842d9406: hw/i386/amd_iommu: Move IOAPIC memory region initialization to =
the end (Sairaj Kodilkar)
47d50cc421: hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled fi=
eld (Sairaj Kodilkar)
96c75abc87: hw/i386/amd_iommu: Fix MMIO register write tracing (Sairaj Kodi=
lkar)
cad9aa6fbd: pcie_sriov: Fix configuration and state synchronization (Akihik=
o Odaki)
6071d13c6a: virtio-net: Fix VLAN filter table reset timing (Akihiko Odaki)
d63c388dad: vhost: Do not abort on log-stop error (Hanna Czenczek)
c1997099dc: vhost: Do not abort on log-start error (Hanna Czenczek)
6fcf5ebafa: virtio: fix off-by-one and invalid access in virtqueue_ordered_=
fill (Jonah Palmer)
cd9f752fee: target/arm: add support for 64-bit PMCCNTR in AArch32 mode (Ale=
x Richardson)
31995cc408: hw/intc/loongarch_ipi: Fix start fail with smp cpu < smp maxcpu=
s on KVM (Song Gao)
caab7ac835: target/loongarch: Fix valid virtual address checking (Bibo Mao)
86bc3a0abf: target/riscv: Restrict midelegh access to S-mode harts (Jay Cha=
ng)
e443ba0336: target/riscv: Restrict mideleg/medeleg/medelegh access to S-mod=
e harts (Jay Chang)
30ef718423: target/riscv: Fix exception type when VU accesses supervisor CS=
Rs (Xu Lu)
09ac27a9b5: riscv: Revert "Generate strided vector loads/stores with tcg no=
des." (Daniel Henrique Barboza)
16aa7771af: target/riscv: do not call GETPC() in check_ret_from_m_mode() (D=
aniel Henrique Barboza)
e111ffe48b: linux-user/strace.list: add riscv_hwprobe entry (Daniel Henriqu=
e Barboza)
b6f1244678: intc/riscv_aplic: Fix target register read when source is inact=
ive (Yang Jialong)
f3c8b7767f: tests/data/acpi/riscv64: Update expected FADT and MADT (Sunil V=
 L)
a3b95362ce: hw/riscv/virt-acpi-build.c: Update FADT and MADT versions (Suni=
l V L)
35d129399d: bios-tables-test-allowed-diff.h: Allow RISC-V FADT and MADT cha=
nges (Sunil V L)
77707bfdf8: target/riscv: Fix pmp range wraparound on zero (Vac Chen)

