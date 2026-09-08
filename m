Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF307C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tIl-0001hX-4j; Tue, 08 Sep 2026 06:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIj-0001Xy-EE; Tue, 08 Sep 2026 06:43:41 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIg-0006jE-7y; Tue, 08 Sep 2026 06:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szAg+UnFhYX8MmlFfx9i1BnaiS1tNhZD2evuKk9VuU5MCs9CgsrsUkekuDT6uLOWQr2nR+8jAangzlttoSC9PiA+JFf7UwP2106xWUE7HL9ZunHfNHUujR6c2pBcMBt+Me+nj2qRJhFGmYtHlzZQCheN/ztLsHu4XkvXBsSm/j/tPDhZ5TJxE9W8Y0FkFLBn/uzy6WKN2a9LxWtb83HjcxGoySqzpaRcgBPGdL2O0GK8e6PbGMpPI/HTc0GPOLa0Ucc9MepeZkxuImeQpToqzVk//2cEyUtGJ+9Q1PBvxl/ToztvLXoEWUaO6cVllPepAdSt6QJD0pGluSwRaRpgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UC8smkc2CsB6pl2D1eUENcEOnL2eCp1mvyn1XlZtE4=;
 b=PwR6kmunVA50bq2ZPxRX1VldZXBF5X4IA34pOK+uVZlH20LiIZaRUr2qdoZFIC98xVMO/8RNs6YIm4XWJxPa6QyVYGb41O9XLT9bf2kpDkUpvAhBDo3Vpf5CHpwvBi8BbhrvfUyWxjsmoKSPYEnw1n5P5p48E46VhBUFml1+lnCWTCnkmb7wfx0HgPaS092dZAWhtxoNqwjcJ1EYunfv13ee/EpJnQO/iLejq1Wz7nQjxe/k3v+Qg9ugniN/WUmSiXzKc4uqvrVdCYtR9Vgt4P/X0rB9H0w7ZT6ec8YuZPKiEEG05Bahnvp9VAR/7BX45Nq1yWJdnE9HrdvaS0ZYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UC8smkc2CsB6pl2D1eUENcEOnL2eCp1mvyn1XlZtE4=;
 b=ZAeURrHvH+w78UNDme1G0cuWWRfxfOpW1fdHo9/49B/BWVmxMWm1MMrUEr6nUlE4bLL2Q2pznnYzA+qe6UVXNVcFzxvJuq2XD5NyshEPelWFVisO/rTlqXarQHKNgxaY3KHa/ZavLWCA0qResTFlkv1t8WFWEZDbjzUwVS1tC+d7xWexauArOagWOwnfzevIPSG9EXshcmeLiLNM6JF84jgYncBLev0edGeNA832bylbt9GGclvGXuybAdze3hb37hA7byZvWBcmmnSz92hc1EOeNXv3tq4a2n5xZ9xLZXcxi3qaGO2MZTBSxtpdWD3xdWE5dTIbKFgdXJIdfgUTvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB6579.apcprd02.prod.outlook.com (2603:1096:101:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:43:33 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:43:33 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 30/32] docs/system/arm: Document Phytium E2000 machines
Date: Tue,  8 Sep 2026 18:41:39 +0800
Message-ID: <20260908104159.1621764-31-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|SEYPR02MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4ffe77-ebfd-42ce-22ec-08df0d95f5d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|13003099007|6133799003|3023799007|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jR+ZwfW15xys76gdBCmu3iCy95NGHdS0MMQdKtUGoS95dn5tbqaEk6eFbA5zhH0ew0aBUqr2XzMOe0Vs+IIsnQYTGdchlePuFMIEFCOQP5NQTSj7dkAL7IZwyem1lS7/30ireJSuyvgfuRuzAW62GIKwbgY+ugTKTWZn6DPSTNcHdZOAQV5lQzfoqiuECkFenRdR3V8xEgXawnLYoTp9g6LOWxrcdUS3VcnJ2S2+obOqubWDeR+K8wGFdg6Uu8bmg6QjYeMBQpCpUbYQWm9anNa3mSQJ7zuW3Mah88F8cG4TQubUNbv3t/SgtfdAdwc6P2FLjx3Ztuffzypazf6gJ1xtYpjYVlXcZB+SPxkeQJ5RC9/8b3lPDwF1QTRzDnw9XtR8iYWnz6hV9+RYWmYzPtoGirU8x3gAXXMyFBSk62DrnpVpvAtrhxXyO+OFRqFry6grsgeRABLuW37gkJSW7tIV9RduhspjQGbsXkDVyUXDRt/1qLiPhvornjKqAfgve6YVUFXTUWgEpSoQblH/QItQ7hRjxwT1XL1X8NeAbyXTx3SlOsKNDkq+Jgtak6Q2j3Bx2C7HdoP/Yw5KJyGGKci6R5Ddb7cTA9iLBOZUZmCDq+8T3wzy9iKjMx9iM3gQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(13003099007)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sV8NZVWYEPQiVhDBhR/ItLTxr3I5ER54a4AUrhcIx0HS43fM1vexi77qPqC6?=
 =?us-ascii?Q?oUB641OQiu7hg7bWQsdTKjZshIzYSg/O3KVrfbTL8JTup8efdBBZL6Fl4vaH?=
 =?us-ascii?Q?E9z6pCUOmsJBKSQYZJpwTxBMp0D/4mMBzifbpXzolKiz2W4I0JtCFcM6YAsp?=
 =?us-ascii?Q?h3tl/BW+Mz+WRJiptIt3+iA9iyEfJUsKPVTMUCdaIV/2UEq8qy/aSujQYX12?=
 =?us-ascii?Q?0Y3o3BrzpU3WO0B6lO8R/0RdjOd9HIC4ZiXrD7JBWe2lwN2JxobYw/rfVYjb?=
 =?us-ascii?Q?iupY7TVFNXVPAzt9LyfFIrWnO4eelkquFEcVnLfFp6JvbCSi8F1mwHqF4WLb?=
 =?us-ascii?Q?gPjSK/xHC5qV3lkk0sMPlUSqJ5VTQhL28eHqP2IPzlnkoAalWxqGGQZbr91n?=
 =?us-ascii?Q?feKwqgMK4DrnwDmsaZ9+Y1zlppEMx77qtZIuIJXfaoQuFgBvPTd9dlXIiw0F?=
 =?us-ascii?Q?F98wEhEi3XyYetstDbx+2Y+RXTGSRGBLnBEO7NQZoexiVVY7uiCfQnqWs0PD?=
 =?us-ascii?Q?1vzi0mKv/9ose97qniK756MWBqutw8XT5AwQtb1gfVaFVl4KffV+YHJ8SUIp?=
 =?us-ascii?Q?BxtCTER/HyRgo8HbGJ+9GjGFkQBDWlaGR7YcD6gVnsERlgMhoTJDVxXvxiNO?=
 =?us-ascii?Q?OYHBknJyxxV8fmnUbS/1VJCvnxuoqVDcrowHPetGMFLhmgKNcHBCLXdxnZPl?=
 =?us-ascii?Q?UpKgrMGq05lyvwnZVfXNSyvyWyt3ro9JSD8AIOg7GLT09JVVGT6hJQeP0Uwr?=
 =?us-ascii?Q?L9mz5LrvEy3PHl8IWmu7jTUnDV3mCS0Ed3TPEaT8AdHa9qooXu4HPelhuV3F?=
 =?us-ascii?Q?2V1x2EG1DpdindQtvRqCtmKVoVg7i8DGjJb+/8810hDQiO5Q/UKwI6Ygow7M?=
 =?us-ascii?Q?piOqUJxPH++VWFw7xGcyu741g/OBS1+l0p0Qc4dXyuyYXAx30GVUSDb67H8r?=
 =?us-ascii?Q?oSd+ADhSdHv0H6w5j2U0Fe/L8Qxt3c5itsNDjS5POs+gNRkK+50lHiYeYW+K?=
 =?us-ascii?Q?/L1apH1cPbNJ1u8X/T+ebjHJVyXTWciwd8jObsMvk1kHkWZBLAzh1/dKM1ak?=
 =?us-ascii?Q?xoDa4G478Kkf7wEW/grps88EwOqz5XtTravEpUgeJzqgGwkSXxjIQSquvAIq?=
 =?us-ascii?Q?sK8r4kBjU2UgBOZwYtiAyCCf5p5v7XH7l6WiiFsQs/OZLiSD1zRWaLldjkZx?=
 =?us-ascii?Q?2Qkb/U7ilDET410M/dOsLdRishVBVUvnHrgiIg7+rE3R1Cuudsfyh8TsIK7h?=
 =?us-ascii?Q?pCVchi7fxdY8BtiBmF0Omgi2RBXRLIXVbpngFkLO+yyhbyripNmIB+Kk2xKb?=
 =?us-ascii?Q?EJtbch9CAbAZ5QHheQ8gp9V0KYjVl7dc+7ONtaLws/i7oHkIK/lor3FZJJiz?=
 =?us-ascii?Q?7//kcQLTogD8Q4wvr/jsYgbWKWMEbOay+YrXZOtACHnEu04C4tWWYLIK3dbv?=
 =?us-ascii?Q?rXfLhyZ7y89RSd80AQvkSmYgzTAYZqRC8+47ztlBHhn1G1RpbreAnFvYf2WQ?=
 =?us-ascii?Q?cLczXCj0sNlcux896tCcKFKcy6DIWLt943Nl1lh4CPYgxJsxpgW/n4hzGk9H?=
 =?us-ascii?Q?FVgs5ktA8K7JT0r/7y3raSN5l2luoUD3sAVmGvkD5TpU7kAbqtsT1x0iYA4p?=
 =?us-ascii?Q?SCpR4K6spFrNRhjPihmK3hVYDozYZA+dh4pzwdaT9PLR6xgcmEbpEd3Q/chK?=
 =?us-ascii?Q?A7sKn4D80/dwYjwnFjb1ev1ZLtvXinUoPVrqqpZN4L5zZ/VXhEYiHv52Y/fo?=
 =?us-ascii?Q?HCp8FAEBLh8B2Q8eWcwBcznoDjtzNhw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4ffe77-ebfd-42ce-22ec-08df0d95f5d7
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:43:03.6831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQ9XDfAe0TGCtvOwGaKMurfTuhYzIOSx/G/gpSeCatlD8qZO99ozPymk4fPdNeKNyRVshd8lqBtaU2/OJ72k/vt7Z4fOpxo57ITlHkUmAZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6579
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Document the shared E2000Q SoC model and the Phytium Pi and COMe board
variants in one file. Keep common PBR, CPU, device, direct-boot, and
limitation details together while separating the SD0 and QSPI-to-SATA
workflows.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Describe the machine and SoC QOM split
- Describe the SoC-owned Cortex-A72 CPU configuration

 docs/system/arm/phytium_e2000.rst | 422 ++++++++++++++++++++++++++++++
 docs/system/target-arm.rst        |   1 +
 2 files changed, 423 insertions(+)
 create mode 100644 docs/system/arm/phytium_e2000.rst

diff --git a/docs/system/arm/phytium_e2000.rst b/docs/system/arm/phytium_e2000.rst
new file mode 100644
index 0000000000..7253a4f60b
--- /dev/null
+++ b/docs/system/arm/phytium_e2000.rst
@@ -0,0 +1,422 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Phytium E2000Q machines (``phytium-pi``, ``phytium-e2000-come``)
+================================================================
+
+Overview
+--------
+
+QEMU models two boards built around the heterogeneous Phytium E2000Q SoC:
+
+.. list-table:: E2000Q machine variants
+   :header-rows: 1
+   :widths: 20 20 20 20 20
+
+   * - Machine
+     - Firmware medium
+     - Linux storage
+     - SDK DTB
+     - Direct kernel
+   * - ``phytium-pi``
+     - SD0
+     - SD0
+     - ``phytiumpi_firefly.dtb``
+     - ``Image.gz``
+   * - ``phytium-e2000-come``
+     - QSPI0
+     - AHCI1 SATA
+     - ``e2000q-come-board.dtb``
+     - ``Image``
+
+Each board machine embeds a ``phytium-e2000-soc`` QOM child. The SoC owns the
+CPUs, interrupt controller, and integrated peripheral controllers. The machine
+owns RAM and the boot configuration, and attaches the board-level SD card,
+QSPI flash, and SATA disk to buses exported by the SoC.
+
+Both machines are intended for Linux and firmware images produced by the
+Phytium Buildroot SDK. Phytium Pi has no board-attached SATA boot disk. The
+COMe board attaches a GD25Q128 SPI NOR flash to QSPI0 and a SATA disk to
+AHCI1.
+
+The Phytium firmware stack has three conceptual layers. The on-chip Phytium
+Boot ROM (PBR) establishes the root of trust and prepares the early handoff,
+Processor Base Firmware (PBF) initializes the processor, and System Firmware
+(SFW) provides later firmware services and the bootloader. QEMU does not
+execute the internal ROM. It recreates the PBR handoff state, reads a
+``fip-all.bin`` image from byte zero of the board's selected firmware medium,
+starts the PBF payload at EL3, and lets PBF hand off through the SFW stages to
+U-Boot in the same image.
+
+The SFW flow loads BL31, whose resident EL3 runtime services handle the
+Phytium private SMCs issued by U-Boot and Linux. QEMU does not intercept these
+calls on the firmware boot path.
+
+The boot strap is fixed board wiring. Phytium Pi reports SD0 through the PBR
+handoff while COMe reports QSPI0. Firmware may persist its environment or DDR
+training data to the selected backend, so use a writable image or ``-snapshot``.
+
+The machines do not generate a device tree. Direct Linux boot with ``-kernel``
+requires the corresponding SDK DTB listed above through ``-dtb``. A later
+Linux boot performed by firmware likewise requires the matching board DTB in
+the guest-visible boot environment.
+
+PBR device ownership
+--------------------
+
+Firmware boot is implemented by the ``phytium-e2000-pbr`` device. The board
+machine selects the boot strap and backend when configuring its E2000 SoC
+child. The SoC creates the QSPI and MCI controllers, maps the PBR status
+window, boot SRAM, and IACC, and connects the PBR to its CPU topology. Neither
+the machine nor the SoC parses or stages the firmware itself. ``boot-mode``
+belongs to the PBR device and is not exposed as a user-settable machine
+property.
+
+The PBR device reads only the selected board medium. It validates the outer
+image extent, the embedded TF-A FIP, the primary MPIDR, and the
+platform-parameter records. It then stages the complete computed image extent
+at IACC ``0x38000000``, relocates PBF/BL1 to ``0xf8c40000``, constructs the
+boot SRAM handoff, and releases the primary CPU named by the image.
+
+The public PBF interface defines a common 16-byte header containing magic,
+version, size, and a reserved word for PLL, PCIe, DDR, and COMMON service
+parameters. The E2000 firmware profile supplies their private container and
+handoff placement:
+
+* PLL: FIP offset ``0xf5000`` to SCP SRAM ``0x32a10c00``, magic
+  ``0x54460020``
+* DDR/MCU (Memory Controller Unit): FIP offset ``0xf5300`` to SCP SRAM
+  ``0x32a10d00``, magic ``0x54460024``
+* PCIe: FIP offset ``0xf5100`` to SCP SRAM ``0x32a10e00``, magic
+  ``0x54460021``
+* COMMON: FIP offset ``0xf5200`` to SCP SRAM ``0x32a10f00``, magic
+  ``0x54460013``
+
+In this PBF terminology, MCU means Memory Controller Unit. The record supplies
+DDR controller configuration, DIMM/SPD data, and training parameters.
+
+The PBR device validates each exact E2000 magic, declared size, source bounds,
+and the ``0x100``-byte destination-slot bound. It copies the declared record
+without interpreting its service-specific payload and clears the remainder
+of the destination slot. Parameter versions belong to their individual PBF
+services and do not select a PBR handoff or TF-A object layout. In particular,
+QEMU does not generate DDR/SPD data, rewrite the DDR/MCU record version, or
+force DDR training controls.
+
+PBF embeds TF-A v2.3 FIP and memmap I/O drivers plus its platform I/O policy
+table. The PBR device locates these from their TF-A data-structure
+relationships and constructs the boot-SRAM state that registration and
+``dev_open`` would have produced. This permits different PBF builds,
+including two builds carrying version 4 DDR/MCU parameter records, to relocate
+their I/O objects independently of the record version.
+
+Some remaining handoff details are private to the vendor PBR/PBF contract
+rather than a published TF-A or hardware ABI. In particular, the fixed
+boot-SRAM parameter graph and the placement of the FIP driver's runtime state
+were reconstructed from the early PBF accesses and callback disassembly in
+the 2 GiB and 4 GiB Phytium Pi SDK firmware samples and the COMe SDK firmware
+sample. The implementation documents these evidence boundaries next to the
+relevant code and rejects firmware whose surrounding TF-A structures do not
+match.
+
+The device also owns reset, migration, and cleanup for this state. Its status
+registers and firmware/primary-CPU state have explicit VMState, while the
+device-owned boot SRAM and IACC RAM regions are migrated as RAMBlocks. A reset
+restages the immutable input image and restores the handoff and primary entry.
+This is a behavioral model of the ROM contract, not an Arm instruction-level
+implementation of the on-chip PBR.
+
+CPU topology
+------------
+
+The E2000Q is heterogeneous. QEMU models the three non-uniform CPU clusters
+described by the SDK Linux device tree:
+
+* cluster 0 contains one FTC664 core at MPIDR affinity ``0x0``
+* cluster 1 contains one FTC664 core at MPIDR affinity ``0x100``
+* cluster 2 contains two FTC310 cores at MPIDR affinities ``0x200`` and
+  ``0x201``
+
+The corresponding QEMU CPU slot order is ``0x0``, ``0x100``, ``0x200``,
+``0x201``. Firmware images that select primary affinity ``0x200`` therefore
+release QEMU CPU index 2.
+
+All four slots instantiate SoC-owned Cortex-A72 TCG CPU objects. Before
+realizing each object, the SoC applies its FTC310 or FTC664 identity and the
+E2000 system registers used by firmware. The ``-cpu`` option therefore accepts
+only the Cortex-A72 execution base and cannot replace the heterogeneous slot
+assignments.
+
+The Phytium MIDR values, architectural instruction-feature fields, AArch32
+floating-point feature fields, and VIPT/PIPT I-cache policy match the values
+observed on the physical E2000Q board. This is an architectural compatibility
+model, not a performance or cache-capacity model.
+
+Supported devices
+-----------------
+
+Both machines currently support:
+
+* two FTC664 and two FTC310 AArch64 CPU slots in three clusters
+* RAM starting at ``0x80000000``, with 2 GiB by default and up to 8 GiB
+* PBR-owned boot SRAM and IACC RAM used by the vendor firmware stack
+* a GICv3 interrupt controller with ITS
+* seven PL011 UARTs
+* the DesignWare-compatible I2C controller
+* the E2000 hardware random number generator
+* two USB 3.0 xHCI host controllers
+* two one-port sysbus AHCI controllers
+* two SD/MMC controllers
+* a GPEX PCIe host bridge with MSI support through the ITS and stage-1 DMA
+  translation through an Arm SMMUv3; PCIe endpoints such as network devices
+  must be added explicitly with ``-device``
+* a QSPI0 controller with a direct-mapped read window
+* PBR, DDR, and MHU/SCMI compatibility behavior needed by the vendor
+  firmware, plus the SCMI Base protocol used by Linux
+
+Board wiring differs as follows:
+
+* Phytium Pi uses SD0 for firmware and its root filesystem and has no attached
+  QSPI flash or SATA boot disk
+* COMe uses the GD25Q128 on QSPI0 for firmware and the AHCI1 SATA disk for
+  Linux
+
+Firmware boot
+-------------
+
+Passing firmware through ``-bios`` or a pflash drive is not supported. Use
+the board's fixed SD0 or QSPI0 medium as described below.
+
+Phytium Pi SD boot
+~~~~~~~~~~~~~~~~~~
+
+Build the complete SD image from the Phytium-maintained Buildroot release. No
+separate ``make phytium_defconfig`` step is needed because
+``merge_config.sh`` consumes the base defconfig directly:
+
+.. code-block:: shell
+
+   $ git clone https://gitee.com/phytium_embedded/phytium-linux-buildroot.git
+   $ cd phytium-linux-buildroot
+   $ git checkout phytium-linux-buildroot_v2.4
+
+   $ ./support/kconfig/merge_config.sh \
+       configs/phytium_defconfig \
+       configs/phytiumpi_sdcard.config
+   $ make
+
+The resulting complete image is ``output/images/sdcard.img``. The SD-card
+fragment selects the vendor 4 GiB firmware, builds ``fitImage`` from the
+Buildroot kernel and Phytium Pi DTB, and packages those files together with
+``rootfs.ext2``. Use this image directly rather than assembling its components
+by hand.
+
+The vendor-generated SD layout reserves the first 64 MiB outside the root
+filesystem:
+
+.. list-table:: Phytium Pi SD image layout
+   :header-rows: 1
+   :widths: 25 20 55
+
+   * - Start
+     - Reserved size
+     - Content
+   * - ``0x00000000``
+     - 4 MiB
+     - ``fip-all.bin`` firmware region
+   * - ``0x00400000``
+     - 60 MiB
+     - U-Boot FIT image
+   * - ``0x04000000``
+     - remaining image
+     - first partition, containing the ext4 root filesystem
+
+The default Phytium Pi SDK U-Boot environment reads the FIT from SD block
+``0x2000`` (byte offset 4 MiB) and boots with ``root=/dev/mmcblk0p1``. The
+first partition must therefore start at byte offset 64 MiB. A DOS partition
+table may replace FIP sector zero, matching the vendor image recipe; the PBR
+data used by the model begins at later fixed offsets in the firmware region.
+
+The SDK v2.4 image recipe declares the root partition as 16 GiB even when the
+generated ``sdcard.img`` is shorter. Linux consequently reports that
+``mmcblk0p1`` extends beyond the end of the device and truncates the reported
+partition size. This warning is expected and does not prevent the contained
+ext4 filesystem from mounting.
+
+UART1 carries the U-Boot and Linux console. The following command boots a
+complete raw SD image without injecting U-Boot commands. ``-snapshot`` keeps
+the source image unchanged when firmware writes its environment or DDR
+training data:
+
+The following examples use images generated by Buildroot::
+
+  IMAGES=/path/to/buildroot/output/images
+
+.. code-block:: shell
+
+   $ qemu-system-aarch64 \
+       -machine phytium-pi \
+       -smp 4 -m 4G \
+       -display none -monitor none \
+       -serial file:pbr-uart0.log \
+       -serial stdio \
+       -nic user \
+       -snapshot \
+       -drive file="$IMAGES/sdcard.img",if=sd,index=0,format=raw
+
+The explicit 4 GiB RAM size matches the firmware selected by
+``phytiumpi_sdcard.config``. The verified flow with a version 4 DDR/MCU
+parameter record completes PBF and DDR initialization, enters OP-TEE and
+U-Boot, reads the FIT from SD, starts Linux on all four modeled CPUs, detects
+SD0 as ``mmcblk0``, mounts partition 1, and reaches the login prompt without
+serial or monitor input.
+The SDK root filesystem uses a normal ``getty`` rather than an automatic
+login, so entering a shell requires an interactive UART1 chardev.
+
+COMe QSPI-to-SATA boot
+~~~~~~~~~~~~~~~~~~~~~~
+
+This is the preferred COMe boot flow when a matching E2000Q
+``fip-all.bin`` is available. The FIP container must begin at byte zero of a
+raw QSPI image.
+
+Build the standard SATA disk image from the Phytium-maintained Buildroot
+release:
+
+.. code-block:: shell
+
+   $ git clone https://gitee.com/phytium_embedded/phytium-linux-buildroot.git
+   $ cd phytium-linux-buildroot
+   $ git checkout phytium-linux-buildroot_v2.4
+
+   $ make phytium_defconfig
+   $ make
+
+The resulting ``$SDK/disk.img`` has a GPT partition table. Its first partition
+is a 400 MiB FAT filesystem containing ``Image``, the DTBs, and GRUB. Its
+second partition contains the ext4 root filesystem. Attach this image directly
+to AHCI1; no host-side repartitioning or file copying is required.
+
+Create a disposable 16 MiB GD25Q128 image in the erased state and copy the
+FIP to byte zero:
+
+.. code-block:: shell
+
+   $ export FIP=/path/to/sdk/fip-all.bin
+   $ export QSPI=/path/to/e2000q-gd25q128.bin
+
+   $ dd if=/dev/zero bs=1M count=16 | tr '\000' '\377' > "$QSPI"
+   $ dd if="$FIP" of="$QSPI" conv=notrunc
+
+UART1 carries the interactive U-Boot console. UART0 is written to a separate
+log so that early firmware output remains available. ``-snapshot`` keeps the
+input images unchanged when firmware writes training data, its environment,
+or the root filesystem:
+
+.. code-block:: shell
+
+   $ qemu-system-aarch64 \
+       -machine phytium-e2000-come \
+       -smp 4 -m 2G \
+       -display none -monitor none \
+       -serial file:pbr-uart0.log \
+       -serial stdio \
+       -nic user \
+       -snapshot \
+       -drive file="$QSPI",if=mtd,index=0,format=raw \
+       -drive file="$IMAGES/disk.img",if=ide,index=0,format=raw
+
+With the SDK firmware, the verified flow preserves the version 5 DDR/MCU
+parameter record, identifies 2 GiB DDR4/X16, completes software training, data
+BIST, and address BIST, detects the GD25Q128, reports ``boot media is qspi!``,
+and enumerates the SATA disk as ``scsi 0`` through AHCI1.
+
+The U-Boot default environment may not match the layout of the Buildroot
+``disk.img``. Press any key during the autoboot countdown to reach the
+``E2000#`` prompt, then enter the following commands to load the raw arm64
+kernel and COMe DTB from the FAT partition and boot without an initrd:
+
+.. code-block:: shell
+
+   setenv bootargs 'console=ttyAMA1,115200 root=/dev/sda2 rootwait rw cma=256M'
+   fatload scsi 0:1 0x90100000 Image
+   fatload scsi 0:1 0x90000000 e2000q-come-board.dtb
+   booti 0x90100000 - 0x90000000
+
+The verified flow starts Linux on all four modeled CPUs, mounts ``sda2``, and
+reaches the Buildroot login prompt on UART1.
+
+Direct Linux boot fallback
+--------------------------
+
+Use QEMU's direct ``-kernel`` interface only as a fallback when the Buildroot
+SDK does not provide matching EDK2 or U-Boot source code and no usable vendor
+FIP flow is available. This path bypasses PBR, PBF, SFW, and U-Boot. It
+requires the board-specific SDK kernel and matching DTB listed in the overview;
+omitting ``-dtb`` is an error.
+
+Starting the vendor U-Boot binary directly with ``-kernel`` is not supported.
+That would bypass BL31 and leave the bootloader without the Phytium private
+SMC services normally provided by the resident EL3 firmware.
+
+The following commands boot the SDK kernel with its initramfs and do not
+require a disk image.
+
+Phytium Pi direct boot
+~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: shell
+
+   $ qemu-system-aarch64 \
+       -machine phytium-pi \
+       -smp 4 \
+       -display none -monitor none \
+       -serial null \
+       -serial stdio \
+       -nic user \
+       -kernel "$IMAGES/Image.gz" \
+       -dtb "$IMAGES/phytiumpi_firefly.dtb" \
+       -initrd "$IMAGES/rootfs.cpio.gz" \
+       -append 'console=ttyAMA1,115200 earlycon=pl011,mmio32,0x2800d000 rdinit=/init'
+
+COMe direct boot
+~~~~~~~~~~~~~~~~
+
+.. code-block:: shell
+
+   $ qemu-system-aarch64 \
+       -machine phytium-e2000-come \
+       -smp 4 \
+       -display none -monitor none \
+       -serial null \
+       -serial stdio \
+       -nic user \
+       -kernel "$IMAGES/Image" \
+       -dtb "$IMAGES/e2000q-come-board.dtb" \
+       -initrd "$IMAGES/rootfs.cpio.gz" \
+       -append 'console=ttyAMA1,115200 earlycon=pl011,mmio32,0x2800d000 rdinit=/init'
+
+QEMU applies the normal Arm direct-boot fixups to the supplied SDK DTB, but
+does not synthesize a replacement hardware description.
+
+Known limitations
+-----------------
+
+The machines are functional models for the tested firmware and direct Linux
+boot paths, not complete models of the physical development boards.
+
+* QEMU models the PBR handoff behavior needed by the tested ``fip-all.bin``
+  image, not ROM instruction execution, authentication, or the complete
+  on-chip root of trust.
+* The boot SRAM object graph and SFW callback addresses are limited to the
+  inspected firmware samples. Those samples carry version 4 or version 5
+  DDR/MCU parameter records.
+* FTC310 and FTC664 cache capacities and microarchitectural performance are
+  not modeled. Only the evidenced architected identities and I-cache policy
+  differ between the configured core variants.
+* Standalone vendor U-Boot with ``-kernel`` is not supported; use a matching
+  ``fip-all.bin`` so BL31 provides the platform SMC services.
+* Non-boot-critical peripherals remain unimplemented, so guest probe failures
+  are expected. The Phytium Pi ES8336 audio codec is not modeled.
+* The Linux SCMI transport implements the Base protocol only. Performance and
+  Sensor protocols are not modeled, so SCMI CPU-frequency and temperature
+  interfaces are unavailable.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 260cd7e4d6..77c18b5f2e 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -95,6 +95,7 @@ Board-specific documentation
    arm/mcimx7d-sabre
    arm/imx8m
    arm/orangepi
+   arm/phytium_e2000
    arm/raspi
    arm/collie
    arm/sx1
-- 
2.53.0


