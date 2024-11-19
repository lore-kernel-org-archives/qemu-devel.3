Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473CAD44162
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDPYg-0003Ke-2H; Tue, 19 Nov 2024 09:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1tDPYT-0003Gx-O7; Tue, 19 Nov 2024 09:50:16 -0500
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2414::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1tDPYQ-00013Y-Ra; Tue, 19 Nov 2024 09:50:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1DvIhAAhhePujY7+3faZrJXgmnmz+0r4mr0lrjSqIpMtHiW9zlNm4c76z9S6TB4L7uvRz+AkeP6Ffo5aUH4GSKbJVdPAH5y1jE6szMMUyPBrzlN7SF0RCQ8f2sNH2oRKn9cCshdWLkI1ZxXGxsGNOliXbuprAJ/RfNh9nvrF80/zNdUVSupP6CbKzkdxhELlJktzVc/JC/8/CBi/eMltpb+Rn+n//T8ov+voWZzPTHBciQPQd0GelO8VYooYNR9JSZAQcnu+gDvsQVYH6axYPMD0YKrK9OkJxf8Kz08T1BvL6y3I4CCVWKhFWzL7wuzR/axVBGRo/Ip9fonYwM1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTkUhh0alvd4dKkso9h73JYy2yFHslc9tgD5lQK381g=;
 b=cufd8btvzUj1Kj1tlWG8FJQhXEhQ+heVbjbbVjIYw3uJI2QvCqUX5napxpUewzQEfYONJtv5ToaOcWqpJ0AyDzSinWW6zgA4h0Od7Jg1ajlU6g4c9gCtZ2Vw9fn8TbAd5SdFnddNX4WkdZ6yiZ1ZvAVBUYsfXXxbOx2FloQf67LBu0fJkx6kDA7oHpZHFhn78gViucrE1zOCEUtTPR5f4GZNFWZzgWdbOr1YtB8YTsiWanhyMoITtwMNTXHZYEIxoPcuzki7stPw+CWLN6VNsBmCMtTvCf7URpNKsEkos+H4I95GjHGW5w4iT46QEp3WRRQP1GpnamAg3wGsgYzVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTkUhh0alvd4dKkso9h73JYy2yFHslc9tgD5lQK381g=;
 b=uBREh8d/HAMU2uYqcYDHTZvVePlkdTgdwHLbnL49Ifw+B2ofSwxBfco2OnLAioLULqA8a5VDT571me4EYHABv6tL291Y4QoyQOjXwzAwDX/4BTzKZaWOKKDtTA63lmEZOAZ+w2/vjp+8XS8MjJLxtpdnJsHxdxroOABtFtv53IE=
Received: from CH2PR19CA0019.namprd19.prod.outlook.com (2603:10b6:610:4d::29)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 14:50:03 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::fd) by CH2PR19CA0019.outlook.office365.com
 (2603:10b6:610:4d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 14:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 14:50:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 08:50:02 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 08:50:01 -0600
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 19 Nov 2024 08:49:58 -0600
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: <alistair23@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 'Simek Michal '
 <michal.simek@amd.com>, =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=20=27?=
 <philmd@linaro.org>, 'Iglesias Francisco ' <francisco.iglesias@amd.com>,
 <sai.pavan.boddu@amd.com>
Subject: [PATCH v4] hw/riscv: Add Microblaze V generic board
Date: Tue, 19 Nov 2024 20:19:56 +0530
Message-ID: <20241119144956.728384-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ed6a11-e0eb-48cc-e264-08dd08a9730f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUxySk9RdUc4VzhraWxwUmxONTZ5WFIwMWlRdzNBV2hUNkVvK0ZRbHVpbmY1?=
 =?utf-8?B?L0ZLcENWTWxSai8wVzRBTlZpZ3IzdFFpL3gwZ1Q4N09lN3puSTkwK1YwZkpM?=
 =?utf-8?B?Tkk1aDFETmJXcERWcGI4eE1QcTI5Rkk5Wlp2aWt0ZVJJU29ZdDYrOWxSSC92?=
 =?utf-8?B?bzFkd2p0NldnZ3RvcGNmZmcxLzFiQ0xkbnZnRm41MnhhZDdjNVUreTBaSGNS?=
 =?utf-8?B?TGdBeklrNjRWSWI5M0tndWJJelFMcHY0Z2Juclo4MDdIRlZOeEdjOCtCNGoy?=
 =?utf-8?B?elpCOEZ2S1o4ZjVPZEd2YXh6aWp6bUJxT2NOVUpJalVMUERXcXYyVDNOcDU0?=
 =?utf-8?B?VzBlRGczSmp2cE1XOWJYcWdZcWk1a09UYnVwS3I4OGVXMVpjaThFSmd2NERN?=
 =?utf-8?B?VnQrZTJHdnBIV3Z1cWNJM1F1QTYwL0QzdnkwNXN1bkNvbWRWM1JQRjM3Z1Fn?=
 =?utf-8?B?djF5M2dHQU5kWkhkY2VUQjdCNTVLQU93Q2tyWGdJT3NyNUc5eEh6S2ZQL1d0?=
 =?utf-8?B?eXJJZXMyWlpvVUErMEtZYXF6b01QODg2SW1OR0JFanY0bUdYS3R2TGpOcytE?=
 =?utf-8?B?L1FtK3AxNmtabUlkRlpKZ1lZTnorSVJBNjlkZ0YzVXlnNVdSSUVJZEhwWUcv?=
 =?utf-8?B?bFF1UzUydVhaVDJabk9zeFd2ZnJJOThZelFDTlNBcUUyOVZvOUpSRGFLaUFm?=
 =?utf-8?B?eHRneVg2eVV4SW42MVhSNjdBWGpidm1ySmhnMWlnMU94OVlieHpjaG9lY1Vi?=
 =?utf-8?B?cHcxeXFvSU5KY1dxTlBiTDVEWlk0eVEzeHVFcmRWU3FIQjJqYWZNSDAyK3py?=
 =?utf-8?B?YmM4RWxZalM1SzhVa3ZxdS93cng5UXVENUw4anB3ZXFCc1p2MzYva1hXWEZm?=
 =?utf-8?B?a3NvUlZZU2FGUlVqSDBmVGUyWTdFQTVvU05adWRQNy9NMTBVLzdkSEgvUHNE?=
 =?utf-8?B?VkNtOHpub2FpY0VKS050ZU43aWxoNDllZ2F5cDlnQW5ES2U5T3k3ZzRFZXFm?=
 =?utf-8?B?VXV6SzE0OVFIL3RZNDFUNlJDKzNYOHBPNHN3SzFvZWRYSHVFZFFSOWJiT255?=
 =?utf-8?B?NVlOM2swdGdYd1E4VEo1bHRPNkhGRDlWbkRoQlg0cklzMjNlNDlLRlpLUENr?=
 =?utf-8?B?c3hKb2hYRWhHdVJVc0lranBSd1BHd28xQTJKYmVCSFE0Z0VUeUR2QjYyclJw?=
 =?utf-8?B?OUR5d3ZnUmY0eDZ5MFNHeXFJOStNdC92bHZJMWlxTGtCRWpVWUVoTkhBS3JH?=
 =?utf-8?B?cEtDcEwydlZxbHZrN0hXREhGSEgxQlpLdjJNK0paRDFHYVNKZzZidDdrN3dO?=
 =?utf-8?B?YkZFOWMxNU1sYlBGcjhYU3pnTCtnVHJzZ281Q0orWUFqK2pjNlFEczVuQkll?=
 =?utf-8?B?QUlTOXpObmZ3WkRzSlJCUlllbXBtb3ZMTitISnR4K1cwYUhoLzFxbUM1djZB?=
 =?utf-8?B?SEc3VnNQQXpySTZPQmNETkhlSWc0VWZwRHdUNTN2TDNCMUhlb3Z6UGowNmJz?=
 =?utf-8?B?Z2VLc2J0a2NTRzUzQzNTeVFEUUdtSHZrb0JGdnpSSE5wN3J5QndiSXpETk00?=
 =?utf-8?B?QndDaW9XdEJWbDNPRHlpbjFjbjIyWndzSmIyeTRaa1o1SjZmUlRQOEFzWjVE?=
 =?utf-8?B?RDVLQkxDcnVsOWpMV0ppVG8zSkljLzhENlhuSDNHY2JWTDZlUFc4UGlsMHBF?=
 =?utf-8?B?Sm5FSHRQRVQzdlNseGNUN3YyVEVweVRxeGtTbVdLQmRxc2pCMkprK0FWeFF6?=
 =?utf-8?B?dmxEakZrcUpZdjFQSUtIa29mL2x6bTBnT3hUSFJnQXhJeEszd0tQSmkrOCtW?=
 =?utf-8?B?cU9DbGs3N3pENGZnOXdTaHN4bXJmY256YmhTMkNOc2ViOXNlNHhFYlgzWnl0?=
 =?utf-8?B?MDNkVUMxdnpQSUFINHJRK3JUbEtTc2xGTDQwRTRPdXNzaGc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 14:50:02.8456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ed6a11-e0eb-48cc-e264-08dd08a9730f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
Received-SPF: permerror client-ip=2a01:111:f403:2414::601;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) AC_FROM_MANY_DOTS=2.499, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.14, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
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
Changes for V4:
    Improved the doc based on comments
    Disabled support for Double-Precision and Hypervisor extensions
    Updated Maintainers file at riscv machine space.

 MAINTAINERS                                |   6 +
 docs/system/riscv/microblaze-v-generic.rst |  42 +++++
 docs/system/target-riscv.rst               |   1 +
 hw/riscv/microblaze-v-generic.c            | 184 +++++++++++++++++++++
 hw/riscv/Kconfig                           |   8 +
 hw/riscv/meson.build                       |   1 +
 6 files changed, 242 insertions(+)
 create mode 100644 docs/system/riscv/microblaze-v-generic.rst
 create mode 100644 hw/riscv/microblaze-v-generic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index acc7405aed2..100a138d8f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1619,6 +1619,12 @@ F: docs/system/riscv/sifive_u.rst
 F: hw/*/*sifive*.c
 F: include/hw/*/*sifive*.h
 
+AMD Microblaze-V Generic Board
+M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
+S: Maintained
+F: hw/riscv/microblaze-v-generic.c
+F: docs/system/riscv/microblaze-v-generic.rst
+
 RX Machines
 -----------
 rx-gdbsim
diff --git a/docs/system/riscv/microblaze-v-generic.rst b/docs/system/riscv/microblaze-v-generic.rst
new file mode 100644
index 00000000000..5606f88d570
--- /dev/null
+++ b/docs/system/riscv/microblaze-v-generic.rst
@@ -0,0 +1,42 @@
+Microblaze-V generic board (``amd-microblaze-v-generic``)
+=========================================================
+The AMD MicroBlaze™ V processor is a soft-core RISC-V processor IP for AMD
+adaptive SoCs and FPGAs. The MicroBlaze™ V processor is based on the 32-bit (or
+64-bit) RISC-V instruction set architecture (ISA) and contains interfaces
+compatible with the classic MicroBlaze™ V processor (i.e it is a drop in
+replacement for the classic MicroBlaze™ processor in existing RTL designs).
+More information can be found in below document.
+
+https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide/MicroBlaze-V-Architecture
+
+The MicroBlaze™ V generic board in QEMU has following supported devices:
+
+    - timer
+    - uartlite
+    - uart16550
+    - emaclite
+    - timer2
+    - axi emac
+    - axi dma
+
+The MicroBlaze™ V core in QEMU has the following configuration:
+
+    - RV32I base integer instruction set
+    - "Zicsr" Control and Status register instructions
+    - "Zifencei" instruction-fetch
+    - Extensions: m, a, f, c
+
+Running
+"""""""
+Below is an example command line for launching mainline U-boot
+(xilinx_mbv32_defconfig) on the Microblaze-V generic board.
+
+.. code-block:: bash
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
index 00000000000..427e3baca7b
--- /dev/null
+++ b/hw/riscv/microblaze-v-generic.c
@@ -0,0 +1,184 @@
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
+    object_property_set_bool(OBJECT(cpu), "h", false, NULL);
+    object_property_set_bool(OBJECT(cpu), "d", false, NULL);
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


