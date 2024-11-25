Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F00D58D4B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 13:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZRh-0005xG-BR; Mon, 25 Nov 2024 08:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1tFZRd-0005vb-1F; Mon, 25 Nov 2024 08:48:05 -0500
Received: from mail-bn8nam11on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60a]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1tFZRZ-0003FL-56; Mon, 25 Nov 2024 08:48:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/rZxlgAtLSeLK0fjCvbcxQAcM231mYgvT9AMe+pWdJMJPnEpHmEJ7QY0E0U/iwMcxAM22jHjf00MWqtwh5VAP3E6aHDQSz9r0VZCfrv/6tJ2dqwZW1W+SgvvgGxLmkH59+tqKyWlSn+AgbOaa1m6lCJrj2U7O59MR6Je7MKgT5uUD/VU12Gldwj6ei6A5318Ue/BQMxOaKHEOQZMih+5RuoiAVGwboSYRa0RJwYgg+1ynrVAddJTcQ1+akibB2a08bQMyToRHygbDrXBftavx7DxFSMhGl45wa7ZBhM6Pj2ZKD7w3Oe4ViwH+dOjjgO6rbtoja70JH4JdrIDCITxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPRNGY5PzH4k3v9hwf/VFfLULY/k7x+3Hxl4lf8OUIw=;
 b=fRqEZ4Imccy7KaonqW7quEDyCj5HaSePTjQITDEtXwaRRNWPMg/JVCH9dDuEPnKa/DiBntTlwSEJVBp74hLrPbi0nNI5t3Ea/XEJEm8zXD9KTzGQttfKs01a6RSN8mEzIMCa3X+xl3oOxxGxebI0KidycnDzHPi4ZnGoqw7oKNdDVxl7eiRKUVDKvPRhVhOHjWRZMqrhMjqPGzAJmM/+5DxIh2pBThvwweOnqR1ms+BWAIMhYY+dGNZNVzmJ31V4FahK8715dyjl9egGFJqsanqEri/Hz1fEhBi2YgWOU6cBnQdyRG3XeFzpzCACPQyNCaKZu0f6VrtXORmOSYp1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPRNGY5PzH4k3v9hwf/VFfLULY/k7x+3Hxl4lf8OUIw=;
 b=Is9M4Uj3iya+dpkZebG2vnXoDh9cmGjzd3sEsj2SpvVodWqfrL/vwiSm+9dBsl2OAIDR95e1zNiMhc1jfVi6098tXzdzJbIeK4FeKXrkIhKACvUNbYb7mbW3v7wFOLoamItCR5q2rEdNjXGC3nIAP09cWJhdZpd+J/RSyHph1Ko=
Received: from BN0PR04CA0202.namprd04.prod.outlook.com (2603:10b6:408:e9::27)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 13:47:49 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::c5) by BN0PR04CA0202.outlook.office365.com
 (2603:10b6:408:e9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend
 Transport; Mon, 25 Nov 2024 13:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 13:47:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 07:47:48 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 07:47:47 -0600
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Mon, 25 Nov 2024 07:47:44 -0600
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: <alistair23@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 'Simek Michal '
 <michal.simek@amd.com>, =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=20=27?=
 <philmd@linaro.org>, 'Iglesias Francisco ' <francisco.iglesias@amd.com>,
 <sai.pavan.boddu@amd.com>
Subject: [PATCH v5] hw/riscv: Add Microblaze V generic board
Date: Mon, 25 Nov 2024 19:17:39 +0530
Message-ID: <20241125134739.18189-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe29448-1ffe-450c-cfad-08dd0d57bff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aG9jUjROdmk0Q3JTNzZaRlNLN05WUXg3VW5XZ3pGVjdJalhLYStBL2lvb2FH?=
 =?utf-8?B?a1Y1eDdEQmNRb3BUcTU1KzIvZE9ZeXh0TDB3NE5rQmNXd00zSjJJaFNodlRX?=
 =?utf-8?B?dW1IUllzbk02bXIwOHJnSXN3bHFMQ1J0U2wvOTVydFExeHh5UlFZM1A1cEhL?=
 =?utf-8?B?VHNkaUpDOHpqUld0SW1RaVJ4QXkvbm1LckNhSUQzRENPOExlcUZMd2cwSjNT?=
 =?utf-8?B?SERzM1l0QUlOLzRSbm9tbmVEaDAvbi9OVjZwZ3Z2SllTM0hlcFFJdjZQd25U?=
 =?utf-8?B?RzRjSGhYK3dJMWZuMzNReCtVWE5ubGVnSWNQc25VVW44QXBkZkMzOHRBZVY5?=
 =?utf-8?B?dnM0YnU5TDh1TVJZdWNBaTJuemVYMkZtTlVsTkhLaDdUcW03Z05NWnNKakVo?=
 =?utf-8?B?aGVWYWUzZkxCaTRXRjRUU1lmd0lUY2s0YVBZdU9qZlpYd3JwTEtHZFI3R3pE?=
 =?utf-8?B?cGlVQlJocHo2b1htOUkwV2k2TVBYRHFRa3R0bmRzdDZuekZlMUd5KzNMVHps?=
 =?utf-8?B?UTREdjROT1lkbUpHUEo3Q1FSUkpFRDlHYzQ2YnQ3ZW9iTmtNbjBvUlIxT1R1?=
 =?utf-8?B?aHl0UmZyOEpINWFsTXp0djZxc3g2NzhROGtlMUh4cDVIT21aNmlaL3BLUDhZ?=
 =?utf-8?B?bHZMMEhGQXptaWJSNzhYUlVUZkFzUEc5ZGtOeEpvS0FCdFdMbkVUVDJISjJT?=
 =?utf-8?B?Z29pd2k0TE5oNnNYeCtuWG5WbXBIc3dYbWoxTjIvT1ZnUUJtYi9sM2NMell4?=
 =?utf-8?B?NUVweHNnRHpERys5L0hGZUpYRWNXR0VqTmk4WHJVNTVBMWhrZmlvcVFJTmEw?=
 =?utf-8?B?VysyV2h1dmtsUkhVbjVuOGRTRDY5SWg0OEZFWlpVUFJZeHlNZGN4NnZOYUFJ?=
 =?utf-8?B?cFZ3dS9LV1ExODhlN2hWWG45TlJKZ0h2c1dYa0hUV2Y5OFNPejN5dnRVZ0Rv?=
 =?utf-8?B?cXhWcVdqNExvYW94NXZQcHdBSm1MdGZ6ZlMzdGJGeEs4ak84TGlIZmdTSExR?=
 =?utf-8?B?RFNtckVEc2Zob0xJYW9WZXZPRlUzbnY2MGVudG5hL1F1VnhFRnA5bm5ZREpY?=
 =?utf-8?B?R2p3U2ZraWd4U0p6SmhHVWRQTUVURStKM2xaZCt4dzY4SG1sV3g4YjJnaEJI?=
 =?utf-8?B?Y29UNlRwbjVGVFdYdnVGOCtCUXE3alFyZEZFYmcwZ2lCNzBYai8vWXJkS0dN?=
 =?utf-8?B?UVYvNDV0YnJ4dkZoK3ArQ3paWVlTQnR5QVY1ZWpiTVBGWE9VSy9LZlZUY0Rw?=
 =?utf-8?B?a0N4Ry9zcmpuQmduU3pEMDkyTXloYm1PeVBhaUpsdnE3YWdFUHdYOHdxTHRN?=
 =?utf-8?B?SWI1ckxudHBoNUliUWp5THY3Kzg3UWxuSkJnWEJGUUYvY3N0VXgwbVU0eG5B?=
 =?utf-8?B?bFJrQmVyMVdtQ3VOa2dGV3M2OWtzSVQxVElqdW15V2xCcW5OSE40WWprUnVo?=
 =?utf-8?B?eU1TdGtZSllSUG8vZGVIZFplUG9YZGw2WEovWHlNQ21mOVdDSGVsMTN3ZDNi?=
 =?utf-8?B?TmNhckJ4WHhnNUwyTXRVN0ZOTVJhNXAwbmRtc25SODZEYlJhSjNmQ0FIR3JY?=
 =?utf-8?B?NEQ4UFRBNENULzZlcWN5SmR1M0g4Q2Z5cnlsWHNlOTE1N3F2aGx5cUNva1Vq?=
 =?utf-8?B?UEpSNUdWUUJlaGdMdlR1eFQ2bDRjMHY0aWdRWU11eUlYWFNmY0Z5RHd5bnFP?=
 =?utf-8?B?bWlYdkoybTM1N21GM2ZuUFMyVlc1QytVbFpKczMzUGV0VUdjWnVkZDhScEda?=
 =?utf-8?B?Yk85RUV3Y3h3RlptM1pyY09iQlJVWGdCMElYdHF2Y3pDUXpxMHIxZGdEdi9D?=
 =?utf-8?B?RTI4YjU4bzgxSStReEthWVVyRzRVSDVML2lWcHNZTS9BMVBGK0dOdnBmTGo5?=
 =?utf-8?B?RFY0SXBaRmxYUksvNnM2WElFcVFOL2l2NmVGTTcvVjVQVEE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 13:47:48.9530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe29448-1ffe-450c-cfad-08dd0d57bff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
Received-SPF: permerror client-ip=2a01:111:f403:2414::60a;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) AC_FROM_MANY_DOTS=2.497, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
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
Changes for V5:
    Rebase over riscv-to-apply.next branch.

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
index 3be13d77748..3c7e083aca1 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -11,5 +11,6 @@ riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c'))
+riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 
 hw_arch += {'riscv': riscv_ss}
-- 
2.34.1


