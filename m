Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478BDD1BDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t817S-0001pB-G1; Mon, 04 Nov 2024 12:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1t817L-0001nW-Dm; Mon, 04 Nov 2024 12:43:55 -0500
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1t817F-00023y-Fb; Mon, 04 Nov 2024 12:43:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9t+1DoviSBDM8YuRbFrb6zfpyx6ul5uaIDCYQZsTA7Zd5u4gcTFkDkJuO42rsU6o0DQyQxJS1//tkHwXKQjoEkFAXNEbZzo2HwSq1M94wGCrb6I0s0NKlCkJv01dwS1ihGZ0IPQ4rnGOKK1fYM8uY6p4Xz1RecV0DU8ph4ol2+6bjDKVdigdHG05KY7/SsulniRCmaIZThHVH/AVTl2F7c1Tuc3oSG+TXm2ykDM8leIyqSF14G4t8IZuTrtKI+bRhf98OKn2Oh+AvK7+6MeKyr5RQagzeb2zwt5jdQ2SM6IVT8VBJ5o0s5dnCw0Ft/M6i0vIE0laCaHkzPorls2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A5+Lixj9i7SFrER35DhdXytg2mNt4Wj/UytJydJyVI=;
 b=CaABpUAlgFoslK8TtIidhHbPI1gQKlZf9SNwqnFJcmLEGo2IGsf8J1wTLb/rSyjvIeBomraG9jfmF0L9bd2b0MiMl49YJVMUSIhlKw+Q68nMv6/+KmRsnHPt03tMqLYeMge8MEErQ+s6d5nTnlYR3U5RRLK2IkaYtP32ab7Dc6dOCAKGB61OT4Iao5pRUG7UXRIr0JR3ZZhTJTwHvbwqcAJxw/Ugf/btjfn6hpuECHLUB+oFG0PYpJKAdp97ffwdVdF+uj11EX00rQxQT2s9V/GgxolPqrXvl+ZxGyLe70h3yNazl0XvMYUvgeHOPjJu3iT/Fbli634COwGADUNGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A5+Lixj9i7SFrER35DhdXytg2mNt4Wj/UytJydJyVI=;
 b=g4Dfs/31oST+8LsFyhVADPb43kZqvKxCzNkewd4qq9MdRHoj3fuLIf879A1GgSmJwgx7E17cfW3mHrQSs9E7ClBUnxFjGhwjJgVuegRxfbCdyMEm4j7OE4p+XMzYzQg57sgMlWWfMCZXTYpvCNVpwv/E82QtyJTGKVkI4O+js+s=
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Mon, 4 Nov 2024 17:43:39 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::25) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:43:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:43:37 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:43:37 -0600
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Mon, 4 Nov 2024 11:43:33 -0600
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, "Daniel
 Henrique Barboza" <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Michal Simek <michal.simek@amd.com>,
 <sai.pavan.boddu@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair23@gmail.com>, "Francisco
 Iglesias" <francisco.iglesias@amd.com>
Subject: [PATCH v3] hw/riscv: Add Microblaze V generic board
Date: Mon, 4 Nov 2024 23:13:28 +0530
Message-ID: <20241104174328.383212-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 910ab598-80cb-4124-244e-08dcfcf8370a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFNIbW1mcE5hNFFtbmE0SE5SY2dHZ1JMWHhrcE1ycUdJQXdzb21MeHpGeVJU?=
 =?utf-8?B?dUJyYzNRL1pIUWI4YnhHeVY4QXM2NEhjRlg1MkdJTDdlaUVVTzF5RjY0YWZ6?=
 =?utf-8?B?RCtXaU05ODdDSFB0aFFNcHA4TDN0V1JONmw3bUhaUUExWDJiaE1HYkt3SVc2?=
 =?utf-8?B?d1lGa1lTOWMxam9nMU1WUnJUbTRTNjhhUFQyT1FONFQ0VFN4MHNrUXVDNmVr?=
 =?utf-8?B?YzJha01md3FacUJBenhEakYzU0dwM1lZTytWdjlGd2RZbkZUbEdMYStibTQ5?=
 =?utf-8?B?a2lnZmVVcHVlL0t3TjV2WDJYNGZkeEMzVVhIVHdaczh0SmFDcmVwa1AxOElL?=
 =?utf-8?B?VEVJc0IrVy9IclNBc1dzZzdvUmJYL3lLNENkZzA4Yk5KY2NydUU5UUw4ZVZQ?=
 =?utf-8?B?dnhlZWN4TW5oZFhaUmlFZG9tQ1JEdHFOTHFZZi9HV2ZnVUw1ZG1XendHbVdu?=
 =?utf-8?B?bTF2a0hQYVlBWnRSbHc2OUloM3lMNUt0T1V4RmFTa0RTektsbkcyUEM4dEpZ?=
 =?utf-8?B?QzBUalJHY01hci96NlVhOHZYY0xsYVl4NmtXaFlIcW5aNzZRMnRGTHpaTmZ5?=
 =?utf-8?B?eXE1WjRVbTRxb1hUaHAzSTJaY1huRXR1aE53UkJ3UjQyUnpxdENrY2tFNTJj?=
 =?utf-8?B?a0V4M1BqaWFjU0h6eHFqcDE4UUZiUjdrT2JUS3RYWTZGWE9LU09lRE1hNXVw?=
 =?utf-8?B?TUh5RDRsUTZwQ011eTQ3eHRnVStrVE5YQXk5bldSOWUrSC9xS0tsREVvakxT?=
 =?utf-8?B?cGJ2bW5EK0I1S2NrZDRZdy9YN3J1UjNJWGlVanpoZWE2TUR5QXQ4U2lEWmlD?=
 =?utf-8?B?a0tQaFVGdVVFbkNFdU5mN0k4QXdJUDdtVkFaaTBJWlNGbERCWXJZWkFKYXZj?=
 =?utf-8?B?dnRYOFlEdUpZS1NST1F2bm40T1FiVnFQWDFJbUxYbURycm5kMG9wQ0ZZTEVv?=
 =?utf-8?B?NXNtUnJhc01XNXJtOU1ycGd1aVdKZGJKZTNsSGZadzBPV1A5ZGFYV1hwUnRX?=
 =?utf-8?B?NURNVm1lR2pXSEZxaEEvWkRIbVNWbU9zSzVON21lc3ZLTVY0YTRlekVVaUZa?=
 =?utf-8?B?dVorUFJVdkNWOVVnZmRudUxaU0RHd2RWNVVPSjZwdCszMGcyQm5DQkQ1S25F?=
 =?utf-8?B?Sm1IbUhOakorRzZjdGp3QTNQc0xCTlR3UWMwMk5EZXE0YU83STVBdysya2Iv?=
 =?utf-8?B?Wjk5M3dJc3pkeTZwZEtyWkVxVDN3V3M4SUlEVDZJQlVPMlp5cnBYdHdNOC9H?=
 =?utf-8?B?dzF3K2ZWZ2JrcEhhRE9pTnVkQmYyUkRFTlhuLzdiSnpxVHRaSkZoVExzKytt?=
 =?utf-8?B?NlNoOUVtb2VmbnpaOFRRNi82TDkwVzErTlZHNTJzNU1SZ3VVN1VidGJNRk9I?=
 =?utf-8?B?RWNvaGJxamVLOFNrekNSZm5MV21sM1ZwUDduYTl3ckNVVWF6cmIwbXU2L3px?=
 =?utf-8?B?WnlrNmNOa3RRUXFEUlRtbHZOZGU3Qk4waE9wNUZLREJoYUFHY0VZRkM5OUQx?=
 =?utf-8?B?bEVDand2U1pKY2tQMFdYYkVDMjk4eEIxeFkrajFkYnZETjdtQXhRVk5WeEZV?=
 =?utf-8?B?NDVWVXZOWVJxajNrRHhSOWdNQ2RhaTVDbFhpY0I2Z09saEo1TGJQT3hoT0lI?=
 =?utf-8?B?dlNsYVRxdmY1VVI1aXhhdndEalhacm1NcFlPQmxOY1VUMUNQZWpSMWZhWGFx?=
 =?utf-8?B?dzVyNXdqc0JYTmJuYlQzZkNUbGcvV21zd2FOL0NiNk1ScjJZVXFLUTdueTQ2?=
 =?utf-8?B?NGNKWU9Qc0JQL3RmZERvOERLaEhUS2QwN0ZVd1htNXg3Qm8rNGtXL1BuRjQr?=
 =?utf-8?B?dktNdCtWK1ozNkZlZmJZQjVzTXRnQmtENVVCbUh2aGozWkdnTlVuQXZ5WGd1?=
 =?utf-8?B?b094OWliL2lLRWh2R0o4SjNyTm9EeUhBRU5Zd2Jkdm1yeHc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:43:38.4329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 910ab598-80cb-4124-244e-08dcfcf8370a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
Received-SPF: permerror client-ip=2a01:111:f403:2414::600;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) AC_FROM_MANY_DOTS=2.499, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.34, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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

Add a basic board with interrupt controller (intc), timer, serial
(uartlite), small memory called LMB@0 (128kB) and DDR@0x80000000
(configured via command line eg. -m 2g).
This is basic configuration which matches HW generated out of AMD Vivado
(design tools). But initial configuration is going beyond what it is
configured by default because validation should be done on other
configurations too. That's why wire also additional uart16500, axi
ethernet(with axi dma).
GPIOs, i2c and qspi is also listed for completeness.

IRQ map is: (addr)
0 - timer (0x41c00000)
1 - uartlite (0x40600000)
2 - i2c (0x40800000)
3 - qspi (0x44a00000)
4 - uart16550 (0x44a10000)
5 - emaclite (0x40e00000)
6 - timer2 (0x41c10000)
7 - axi emac (0x40c00000)
8 - axi dma (0x41e00000)
9 - axi dma
10 - gpio (0x40000000)
11 - gpio2 (0x40010000)
12 - gpio3 (0x40020000)

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
Changes for V2:
    Make changes to support -cpu switch
    Remove setting of default board
    Include doc to toctree
    Remove setting of 'imac' extensions as they are available by
    default.
Chages for V3:
    Replace virt with generic
    Update doc with supported riscv extensions
    Change base CPU to TYPE_RISCV_CPU_BASE


 MAINTAINERS                                |   6 +
 docs/system/riscv/microblaze-v-generic.rst |  45 +++++
 docs/system/target-riscv.rst               |   1 +
 hw/riscv/microblaze-v-generic.c            | 182 +++++++++++++++++++++
 hw/riscv/Kconfig                           |   8 +
 hw/riscv/meson.build                       |   1 +
 6 files changed, 243 insertions(+)
 create mode 100644 docs/system/riscv/microblaze-v-generic.rst
 create mode 100644 hw/riscv/microblaze-v-generic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 03741d41e58..9830a46d819 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1290,6 +1290,12 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: hw/microblaze/petalogix_ml605_mmu.c
 
+AMD Microblaze-V Generic Board
+M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
+S: Maintained
+F: hw/riscv/microblaze-v-generic.c
+F: docs/system/riscv/microblaze-v-generic.rst
+
 MIPS Machines
 -------------
 Overall MIPS Machines
diff --git a/docs/system/riscv/microblaze-v-generic.rst b/docs/system/riscv/microblaze-v-generic.rst
new file mode 100644
index 00000000000..71e9e655f66
--- /dev/null
+++ b/docs/system/riscv/microblaze-v-generic.rst
@@ -0,0 +1,45 @@
+Microblaze-V generic board (``amd-microblaze-v-generic``)
+=========================================================
+The AMD MicroBlaze™ V processor is a soft-core RISC-V processor IP for AMD adaptive SoCs and FPGAs.
+The MicroBlaze V processor is based on a 32-bit / 64-bit RISC-V instruction set architecture (ISA)
+and its fully hardware compatible with the classic MicroBlaze processor.
+
+More details here:
+https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide/MicroBlaze-V-Architecture
+
+The microblaze-v generic board in QEMU has following supported devices
+
+Implemented CPU cores:
+
+1 RISCV core
+    * RV32I base integer instruction set
+    * "Zicsr" Control and Status register instructions
+    * "Zifencei" instruction-fetch
+    * Configurable features:
+      - RV64I Base Integer Instruction Set
+      - Extensions supported: M, A, C, F, Zba, Zbb, Zbc, Zbs
+
+Implemented devices:
+
+    - timer
+    - uartlite
+    - uart16550
+    - emaclite
+    - timer2
+    - axi emac
+    - axi dma
+
+Running
+"""""""
+Running U-boot
+
+.. code-block:: bash
+
+
+   $ qemu-system-riscv32 -M amd-microblaze-v-generic \
+     -display none \
+     -device loader,addr=0x80000000,file=u-boot-spl.bin,cpu-num=0 \
+     -device loader,addr=0x80200000,file=u-boot.img \
+     -serial mon:stdio \
+     -device loader,addr=0x83000000,file=system.dtb \
+     -m 2g
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index ba195f1518a..95457af130b 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
 .. toctree::
    :maxdepth: 1
 
+   riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
    riscv/shakti-c
    riscv/sifive_u
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
new file mode 100644
index 00000000000..93d648f902b
--- /dev/null
+++ b/hw/riscv/microblaze-v-generic.c
@@ -0,0 +1,182 @@
+/*
+ * QEMU model of Microblaze V generic board.
+ *
+ * based on hw/microblaze/petalogix_ml605_mmu.c
+ *
+ * Copyright (c) 2011 Michal Simek <monstr@monstr.eu>
+ * Copyright (c) 2011 PetaLogix
+ * Copyright (c) 2009 Edgar E. Iglesias.
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Written by Sai Pavan Boddu <sai.pavan.boddu@amd.com
+ *     and by Michal Simek <michal.simek@amd.com>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "hw/sysbus.h"
+#include "sysemu/sysemu.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "hw/char/serial-mm.h"
+#include "exec/address-spaces.h"
+#include "hw/char/xilinx_uartlite.h"
+#include "hw/misc/unimp.h"
+
+#define LMB_BRAM_SIZE (128 * KiB)
+#define MEMORY_BASEADDR 0x80000000
+#define INTC_BASEADDR 0x41200000
+#define TIMER_BASEADDR 0x41c00000
+#define TIMER_BASEADDR2 0x41c10000
+#define UARTLITE_BASEADDR 0x40600000
+#define ETHLITE_BASEADDR 0x40e00000
+#define UART16550_BASEADDR 0x44a10000
+#define AXIENET_BASEADDR 0x40c00000
+#define AXIDMA_BASEADDR 0x41e00000
+#define GPIO_BASEADDR 0x40000000
+#define GPIO_BASEADDR2 0x40010000
+#define GPIO_BASEADDR3 0x40020000
+#define I2C_BASEADDR 0x40800000
+#define QSPI_BASEADDR 0x44a00000
+
+#define TIMER_IRQ           0
+#define UARTLITE_IRQ        1
+#define UART16550_IRQ       4
+#define ETHLITE_IRQ         5
+#define TIMER_IRQ2          6
+#define AXIENET_IRQ         7
+#define AXIDMA_IRQ1         8
+#define AXIDMA_IRQ0         9
+
+static void mb_v_generic_init(MachineState *machine)
+{
+    ram_addr_t ram_size = machine->ram_size;
+    DeviceState *dev, *dma, *eth0;
+    Object *ds, *cs;
+    int i;
+    RISCVCPU *cpu;
+    hwaddr ddr_base = MEMORY_BASEADDR;
+    MemoryRegion *phys_lmb_bram = g_new(MemoryRegion, 1);
+    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
+    qemu_irq irq[32];
+    MemoryRegion *sysmem = get_system_memory();
+
+    cpu = RISCV_CPU(object_new(machine->cpu_type));
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
+    /* Attach emulated BRAM through the LMB.  */
+    memory_region_init_ram(phys_lmb_bram, NULL,
+                           "mb_v.lmb_bram", LMB_BRAM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(sysmem, 0x00000000, phys_lmb_bram);
+
+    memory_region_init_ram(phys_ram, NULL, "mb_v.ram",
+                           ram_size, &error_fatal);
+    memory_region_add_subregion(sysmem, ddr_base, phys_ram);
+
+    dev = qdev_new("xlnx.xps-intc");
+    qdev_prop_set_uint32(dev, "kind-of-intr",
+                         1 << UARTLITE_IRQ);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(DEVICE(cpu), 11));
+    for (i = 0; i < 32; i++) {
+        irq[i] = qdev_get_gpio_in(dev, i);
+    }
+
+    /* Uartlite */
+    dev = qdev_new(TYPE_XILINX_UARTLITE);
+    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[UARTLITE_IRQ]);
+
+    /* Full uart */
+    serial_mm_init(sysmem, UART16550_BASEADDR + 0x1000, 2,
+                   irq[UART16550_IRQ], 115200, serial_hd(1),
+                   DEVICE_LITTLE_ENDIAN);
+
+    /* 2 timers at irq 0 @ 100 Mhz.  */
+    dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_uint32(dev, "one-timer-only", 0);
+    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
+
+    /* 2 timers at irq 3 @ 100 Mhz.  */
+    dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_uint32(dev, "one-timer-only", 0);
+    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR2);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ2]);
+
+    /* Emaclite */
+    dev = qdev_new("xlnx.xps-ethernetlite");
+    qemu_configure_nic_device(dev, true, NULL);
+    qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
+    qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
+
+    /* axi ethernet and dma initialization. */
+    eth0 = qdev_new("xlnx.axi-ethernet");
+    dma = qdev_new("xlnx.axi-dma");
+
+    /* FIXME: attach to the sysbus instead */
+    object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(eth0));
+    object_property_add_child(qdev_get_machine(), "xilinx-dma", OBJECT(dma));
+
+    ds = object_property_get_link(OBJECT(dma),
+                                  "axistream-connected-target", NULL);
+    cs = object_property_get_link(OBJECT(dma),
+                                  "axistream-control-connected-target", NULL);
+    qemu_configure_nic_device(eth0, true, NULL);
+    qdev_prop_set_uint32(eth0, "rxmem", 0x1000);
+    qdev_prop_set_uint32(eth0, "txmem", 0x1000);
+    object_property_set_link(OBJECT(eth0), "axistream-connected", ds,
+                             &error_abort);
+    object_property_set_link(OBJECT(eth0), "axistream-control-connected", cs,
+                             &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(eth0), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(eth0), 0, irq[AXIENET_IRQ]);
+
+    ds = object_property_get_link(OBJECT(eth0),
+                                  "axistream-connected-target", NULL);
+    cs = object_property_get_link(OBJECT(eth0),
+                                  "axistream-control-connected-target", NULL);
+    qdev_prop_set_uint32(dma, "freqhz", 100000000);
+    object_property_set_link(OBJECT(dma), "axistream-connected", ds,
+                             &error_abort);
+    object_property_set_link(OBJECT(dma), "axistream-control-connected", cs,
+                             &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, AXIDMA_BASEADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dma), 0, irq[AXIDMA_IRQ0]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dma), 1, irq[AXIDMA_IRQ1]);
+
+    /* unimplemented devices */
+    create_unimplemented_device("gpio", GPIO_BASEADDR, 0x10000);
+    create_unimplemented_device("gpio2", GPIO_BASEADDR2, 0x10000);
+    create_unimplemented_device("gpio3", GPIO_BASEADDR3, 0x10000);
+    create_unimplemented_device("i2c", I2C_BASEADDR, 0x10000);
+    create_unimplemented_device("qspi", QSPI_BASEADDR, 0x10000);
+}
+
+static void mb_v_generic_machine_init(MachineClass *mc)
+{
+    mc->desc = "AMD Microblaze-V generic platform";
+    mc->init = mb_v_generic_init;
+    mc->min_cpus = 1;
+    mc->max_cpus = 1;
+    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpus = 1;
+}
+
+DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 2e88467c4ab..e6a0ac1fa1d 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -25,6 +25,14 @@ config MICROCHIP_PFSOC
     select SIFIVE_PLIC
     select UNIMP
 
+config MICROBLAZE_V
+    bool
+    default y
+    depends on RISCV32 || RISCV64
+    select XILINX
+    select XILINX_AXI
+    select XILINX_ETHLITE
+
 config OPENTITAN
     bool
     default y
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index adbef8a9b2d..140bcb55d64 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -11,5 +11,6 @@ riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c'))
+riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 
 hw_arch += {'riscv': riscv_ss}
-- 
2.34.1


