Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4F2D216A3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hmF-0005xu-98; Tue, 15 Oct 2024 09:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1t0hm7-0005w3-Tp; Tue, 15 Oct 2024 09:39:48 -0400
Received: from mail-mw2nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f403:200a::631]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1t0hm4-0003wr-AE; Tue, 15 Oct 2024 09:39:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAQQ2WN/XwKlImmMb4BeGVhRWmKZfcS4JlC8r3MoHBR113jCNw5gacMSvVE+bhEqRS72GC8YHShrcVHIBo0SVsVfgtmv4hjFmJ70MRpNmiHQZBNZIsQkTtbNqEI7ehDzmM/2OUlI50hsbCCsiArxRQPb9bERO2hb9vOCLSRxp652wzdlgPIhzAasmeyu4EquuwKvgOkHk6XVL21I4VeN+AubjTMZj+AU5bWQao6ADxmwqrgW5geQxkbKIHIH4S5KJD7evYbpfWpvRW4syPxC5+laVAS7fHnvwisvuKHv0kdHozVlu/A/20gd9pMeWBn1gZ3xorzrrq6EUrqmUXSDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuUHIsajy3UyMOh8zuIfjtktqaoask+O2gIpgL3gEq0=;
 b=XONMuNSXe+/5lRPH+48eXFdqDs+K4TJqXJoO0MvHtmrhOxeuH4ErsLt/Bi5wlQqHnc5dq3QR7qNKOP+KUoczzu7q8WUPxj85yoRRYiMWnh95QbCoEcVXX3H5goJSWp5kFqyOj79hm2v0a+thJ7ghxdlyQwN2XqHt663h0khQcOba1ZTNz85AW5EUWfIFL6wsK5VHXdS5ItL2PYntwcSpVcBCr/mqVmM5xcD8jGNFNUUBd9X538fEoXUcmDDjzYW3Nc5jna/OND6U1HsFI97bc5FXlIMne5jw+Ub4ZW1WixW1wcjhlMlggdCFvqdt9NW4hecIzNqQuRxdquaKFjTx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuUHIsajy3UyMOh8zuIfjtktqaoask+O2gIpgL3gEq0=;
 b=A+MS+KA/axsanzKg+SHwfp4KGIUrVR1kmW8k4qz9UMv428iumgnXymzIFYN6zxUk6uNlEqobjYhiMrCRr39koFOeslqlEyfY2pzbSTVKpFrnOBB3HsIB3PxBsk0+TblTNQPPsAsGonvRanuTw85RqV3MT5178A+CdlRR3840Snw=
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:39:32 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:dd:cafe::5a) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Tue, 15 Oct 2024 13:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 13:39:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 08:39:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 08:39:30 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 15 Oct 2024 08:39:27 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michal Simek <michal.simek@amd.com>, <sai.pavan.boddu@amd.com>
Subject: [PATCH] hw/riscv: Add Microblaze V 32bit virt board
Date: Tue, 15 Oct 2024 19:09:21 +0530
Message-ID: <20241015133921.3470901-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6afb03-8412-4ac8-bf2d-08dced1eccad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzBFZlFzR1VYNy9NSlFrVitmekpNUEdxK3pjQXd1WTMxYVNXVVhMZEs3ZXJJ?=
 =?utf-8?B?aHlHVzM1SXQzajc1MmdOUEZiMjAxaEZVSVRtTTBxbjRRaFh1amtXNzB1YlVs?=
 =?utf-8?B?UGQwcENJZlhLM1huTm9DQzQ5M2x4T090RGp4VG52SGIwUFdVaFVZYWwwWWVK?=
 =?utf-8?B?V21oY0JWRXpvRDdjL1RDTndnUm9hYXF3b05US01nS1VxSTQzVGVXYXpDRTZJ?=
 =?utf-8?B?ci8rSkt4dEsvQUQvUXZrcUpiS2lra2kvWjdRbzBMV1ZiVHRlODNFWnFOU2E1?=
 =?utf-8?B?VWs2OGNaUUFZTWlmeUFOUUZ0NmRoSEZxR05GU25RVjlXczVnS3BQV0huYThp?=
 =?utf-8?B?YlFXMWd2VnFYOTRVVUltd2hBcnBNNGFqVkFvSktsN2d0cUpyQjJObWFRcHhp?=
 =?utf-8?B?bVZFdUVqSWdmQVF6alUzRnFHVkhOZEJ5RVZNTnNucThHQzNrZWMxd05jOHpw?=
 =?utf-8?B?cGhia1FGcEYydVpXNjRNdDRsT0NSZWNZSkVKUlE5ekZLVlMyZU5MRVliTDJt?=
 =?utf-8?B?TFhyYS9FcHdONFNZUUczMTIyT2hsV0IyeWxHdUJyR2JhWkk5a0RPYjR6aXc1?=
 =?utf-8?B?VndMWVRjRkE3a2tEdXJ3ZFd0SmFua2VEZEJ2QUcwb3dEaXJOZ1RVTUUyQ2t0?=
 =?utf-8?B?UjNlZVhSeHBXZVE3clRDSmhsSkNrdmlCWXZFb2VDMmZwVHl4VjBOK1oyTTZS?=
 =?utf-8?B?bHpkS29UR3dPTlFibmdFZTQ2ZHI3b3UycWlvUjJHZDlrejlTNTdLaXU1N1E5?=
 =?utf-8?B?S1gyWUFFd210bE9xUmdVblpUR095Y3FJaDBZQ0tXTkdtL3YzVTNCVVVlOGVo?=
 =?utf-8?B?SlRUdndMT2x2WnlDbHg0TXJpZytRVjNRWW5ObWNXeTJ3a1dBU2xGQWJPSE5y?=
 =?utf-8?B?RVZOeVZOUGE3bmUyaVdWdlZkZVRxSjhlWnV4YldVYUVLV2Y3NjQwdXpUVTdq?=
 =?utf-8?B?YUxrV281cktFMEVOOVFjc1FHeGdndXV2RkQybWdFN3JYc3VtcnRvMWJLU0wr?=
 =?utf-8?B?OXJwNmo5NThMc21MaGdlV2lqQUk1dEJmeHp0K2xYSnZrYkUxTktvaWNDeXdz?=
 =?utf-8?B?NWgycjlsUUVJSTA0M3BYZkRNVjh3RVBndCtSYmtxcnpDejk0d0M0WDhDaWY4?=
 =?utf-8?B?UmIya1UyV1poMzhnQ0svS0d2SFJneVUzUHlWdkVick1TUWhGL3VwaHZwa3ls?=
 =?utf-8?B?YWhVd25CUEFIOXZDZEpZcEQxZXRIdTc4ZHpMMW5ja09hTTFIdDhtemNRcnB3?=
 =?utf-8?B?Y01YQ3E5UzZ5WmtoSll1SFMreGM1SWpBVnhOSTNENWdFaWFsQU5ra1JzL2JB?=
 =?utf-8?B?QnllQzRPYTJlV0hHQ2VZZm9DeDI1alFFU2dEK1NwRGRnM3dJemFlY1Bma08v?=
 =?utf-8?B?YnkwN2xrQk1xeGwrSWVmVzdxR0xYaDB0VlJDMExrY0FQWEVPTW0vQzVPQ0RP?=
 =?utf-8?B?cjJjN2JFc3FiQy9DNDZIcTJHSzVEWkR5OTU1aEZPVnFldk9pWVp1WTJ1UG05?=
 =?utf-8?B?RUwzNWx5VlpMQUtmVmIvMHIrZWkvd1QxcXRQY3lIZlhUbTlNU1l3clNaMHJI?=
 =?utf-8?B?V0pvbjhGeGh1NjVHR3N3WUVJK1lBSEZ5NmtRdzhhaG5kbzB5dDNZNEQzbHFY?=
 =?utf-8?B?d3hvY1lscUY5MjhEc2R5b0V4T0JPREs1aFE5TDBIZWlLbnV5RDlIMHdBMlFE?=
 =?utf-8?B?djVldDk3QmxZdGlFMDJndUkranNNYVVuVTNLcmQ3MHlEenQ5eml1U2oxbDNE?=
 =?utf-8?B?bHBDbDV5aXRVeHBINlRJQXljY0dvUkpJbmtFa1U3Z3E1cWNQczRkRG45V2pY?=
 =?utf-8?B?UkxxRm1HME5WTWkzNWVUNVVrTU1uMjlHakltSkpBT09leWJHTjZvUnhiSUxs?=
 =?utf-8?Q?Gl+R14j5l/DSS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:39:31.6633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6afb03-8412-4ac8-bf2d-08dced1eccad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
Received-SPF: permerror client-ip=2a01:111:f403:200a::631;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) AC_FROM_MANY_DOTS=2.499, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.063, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
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
 MAINTAINERS                             |   6 +
 docs/system/riscv/microblaze-v-virt.rst |  39 +++++
 hw/riscv/microblaze-v-virt.c            | 182 ++++++++++++++++++++++++
 hw/riscv/Kconfig                        |   8 ++
 hw/riscv/meson.build                    |   1 +
 5 files changed, 236 insertions(+)
 create mode 100644 docs/system/riscv/microblaze-v-virt.rst
 create mode 100644 hw/riscv/microblaze-v-virt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d7a11fe6017..b104b6d0f7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1274,6 +1274,12 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: hw/microblaze/petalogix_ml605_mmu.c
 
+amd-microblaze-v-virt
+M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
+S: Maintained
+F: hw/riscv/microblaze-v-virt.c
+F: docs/system/riscv/microblaze-v-virt.rst
+
 MIPS Machines
 -------------
 Overall MIPS Machines
diff --git a/docs/system/riscv/microblaze-v-virt.rst b/docs/system/riscv/microblaze-v-virt.rst
new file mode 100644
index 00000000000..42cac9ac475
--- /dev/null
+++ b/docs/system/riscv/microblaze-v-virt.rst
@@ -0,0 +1,39 @@
+microblaze-v virt board (``amd-microblaze-v-virt``)
+===================================================
+The AMD MicroBlaze™ V processor is a soft-core RISC-V processor IP for AMD adaptive SoCs and FPGAs.
+The MicroBlaze V processor is based on a 32-bit RISC-V instruction set architecture (ISA).
+
+More details here:
+https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide/MicroBlaze-V-Architecture
+
+The microblaze-v virt board in QEMU is a virtual board with
+following supported devices
+
+Implemented CPU cores:
+
+1 RISCV32 core
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
+   $ qemu-system-riscv32 -M amd-microblaze-v-virt \
+     -display none \
+     -device loader,addr=0x80000000,file=u-boot-spl.bin,cpu-num=0 \
+     -device loader,addr=0x80200000,file=u-boot.img \
+     -serial mon:stdio \
+     -device loader,addr=0x83000000,file=system.dtb \
+     -m 2g
diff --git a/hw/riscv/microblaze-v-virt.c b/hw/riscv/microblaze-v-virt.c
new file mode 100644
index 00000000000..d9cdfe39857
--- /dev/null
+++ b/hw/riscv/microblaze-v-virt.c
@@ -0,0 +1,182 @@
+/*
+ * QEMU model of Microblaze V (32bit version)
+ *
+ * based on hw/microblaze/petalogix_ml605_mmu.c
+ *
+ * Copyright (c) 2011 Michal Simek <monstr@monstr.eu>
+ * Copyright (c) 2011 PetaLogix
+ * Copyright (c) 2009 Edgar E. Iglesias.
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Written by Sai Pavan Boddu <sai.pavan.boddu@amd.com>
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
+static void mb_v_virt_init(MachineState *machine)
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
+    cpu = RISCV_CPU(object_new(TYPE_RISCV_CPU_BASE32));
+    object_property_set_bool(OBJECT(cpu), "i", true, NULL);
+    object_property_set_bool(OBJECT(cpu), "m", true, NULL);
+    object_property_set_bool(OBJECT(cpu), "a", true, NULL);
+    object_property_set_bool(OBJECT(cpu), "c", true, NULL);
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
+static void mb_v_virt_machine_init(MachineClass *mc)
+{
+    mc->desc = "AMD Microblaze-V Virt platform";
+    mc->init = mb_v_virt_init;
+    mc->is_default = true;
+}
+
+DEFINE_MACHINE("amd-microblaze-v-virt", mb_v_virt_machine_init)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 44695ff9f2c..5424803a82e 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -22,6 +22,14 @@ config MICROCHIP_PFSOC
     select SIFIVE_PLIC
     select UNIMP
 
+config MICROBLAZE_V
+    bool
+    default y
+    depends on RISCV32
+    select XILINX
+    select XILINX_AXI
+    select XILINX_ETHLITE
+
 config OPENTITAN
     bool
     default y
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index f872674093a..8ea0412a376 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -10,5 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-virt.c'))
 
 hw_arch += {'riscv': riscv_ss}
-- 
2.34.1


