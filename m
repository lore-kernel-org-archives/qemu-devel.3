Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0565FC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25aZ-0005lO-1G; Thu, 03 Sep 2026 07:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aX-0005kA-93; Thu, 03 Sep 2026 07:26:37 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aV-0006k3-Kw; Thu, 03 Sep 2026 07:26:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFw0etWZ/aAh/B1SBv29XGzGv6/XRsHfPQajb+n3DsTHUqlUPasm+SZ6UFn1rlNi7UkKx83DqdjSl8TmKZYEiItni4Eu55bs7wZ/fXp+ePzy7j4Bx1e4wwP8OO7O7TLnNnrHRiF0TeCbhHm86O+ZKd1CbtZS9ljYjkdwX6nbCFf/y5M3vy70OXqfh5BJMu5zByNFb72EC+D9BItBVQ/6zOgLHBV98tT3qrCb/K9VQHHme2yg0KBn0RZBuWRmV7DHoMxwafJAcV8ZRCwlXhQttmXyhhJAMr18kFQYvqiGRDzVom3jFIWysObf48fQJeQz9TmqmihqsYBBHFjYv7cq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAdeO6cyG+fZluVgD6dq74RzbIpYaW0QwEnXFwHeM2I=;
 b=zBDdlfVBJR7tSzTL60O074eyONWYEcO896PEPZUnjUBOS8hUdqkjOSbM6H+XePw+3Vm3Y/i5VK8aDo1l/i0CdlM6/UIfKjLu+wIleNJt0QaclTmEWrs/Af2cERR/vY1gsnRXc9JWlmvgzGWVmgLLoJptg34z66LoxNCkawVmFzZ4XqLmnjF2B0RGDtUOXVzIQAdTXw/T8ohhWCaL8lFz5pnGRFDHD+GGuIFVLZ/MvR/+Wuyr1rQKnr9Oh4LveaotPm4oGtMyrLK9o0Uqocs+bYe6IGSPhgXULE6vzSfWPKYFH35kT0t3rCAYdTyYyJRcaZ0PkxiKGwQhp5DmZkCh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAdeO6cyG+fZluVgD6dq74RzbIpYaW0QwEnXFwHeM2I=;
 b=X2qbQq/1+qI7+witujTbslyPmhZsXVvF7Lguzk1ZKBtNonzBaQqMvwSPcL41S+iMICNVaygET4rw+LSJpX9DGNrczp3tuATfh9/L9fzh6GS1JPniFr/ezId7jGoHZigF1gArKBFhP9sMzl3WLGV/yf8u4g3TzmKjoDEDhv/mBhnoiUGcUrPpvWJ69EsgJ/LWigmPpk+6VDvJtWQRIV+iNt7Jj2Az4rsVfQrpCWvh8/of9cxVZ4c9ioe03TMWB1MNkHS0kcwixY95hu6sndNRpQRuhTjy3ejpV0rJx8M1xFOuzEmLhI9igwdbL1ddFDbe7I63FGChjsPkswgsC5Vpzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSNPR02MB8962.apcprd02.prod.outlook.com (2603:1096:604:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:24 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:24 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 17/33] hw/arm: phytium: Add Phytium E2000 control region
 placeholders
Date: Thu,  3 Sep 2026 19:24:57 +0800
Message-ID: <20260903112532.3276678-18-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|OSNPR02MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: a18db33f-ebf6-46af-f94f-08df09ae2fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: bhIzFu2ETmVgT9sk1HKNaIkpPSKrMD9aPuOvI9pvIVOHvAlVxhhHKplUBvnG/iBgXyCmnN2jewOxO1vyRWbjjmhediR4DzJPEapQ//XqTyuts6VwOIKFuXaJ2WVeftWmMq2/aE4XKsc6CcNo5g3N+Xky8gbDz5ma/ykwGREYAcHiVW1g4bY/PXjacP833cF3s8uFYV8vBR7iXciHrFeG6b/SUqR2F/jfLLwBgrqSze3qerPkuUb1aMrp+A2o5Unyo8CIB86FBl874zWYzeqWdPp6k44liaRyuGmmfbCf0vV2gqMO5ICMQ54Nr7K/H0CYR3fVSCvrXYafBU8iO1WdB09bezGAOjjsVlIKUHQHjc0d5LDOFXGYsvjWLoGcpLw1+XAuqrqwf5iCIETTiPjREzw7fWf3hGasoBXD2YiRfK25I2XdqUKhMT27bC5VEMZRYnzAJ4j1483nfYhNy9nW4dYVot6ERSKkYoq7jJQJseaaQwl0K1stg0HLYwRYlpEa4jJEMh3pMBWKvPnhNdcBgwYvSUWhca0tGIQhw2ZRUhZ9BZCl2mUZV13ulJkvq07IV/aETYW/Tc6nfT2u5KzmWavBLwfMpmaCQJQ7If+3YvSY3HV62Cdh44oOLNmvOgrw+CISN0ZKxNChX3dkQ15JiFLLk/ZE3kXdkC6b2wjhAK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yi1Q2NbDdTRgOp1ZybhQZUNKz3SwgANG2j0nPBkvdqaisW7rO6DbuhgCbdi1?=
 =?us-ascii?Q?n2/yS7Mecc6t/b0/8sJr2ieVaxKLlTsZNPY3HXxzPfi1SKiZCRwPJWDpO3jI?=
 =?us-ascii?Q?qD2d4ObrVn1yIeLDxkfRNovCIC3/Zdq5h8N8fpOMq/2t+GOH+fhB6Kt5EI+T?=
 =?us-ascii?Q?1CDcRNhvjhUERChtWhJIBbQep7hqSD7mNUAOSW915goToo/y0/+UTgbsIp+E?=
 =?us-ascii?Q?XB54HFN26GHKODJNYhH6naHu40+nHqMLIBK0QQdqVT5Kc31LLhaggcjmZ5D7?=
 =?us-ascii?Q?lPFomsjhy9Xf7UB1hmBs4mX+1SfLeavzoDqqHVMhLY/NqljQDAwrhfuIwMsR?=
 =?us-ascii?Q?b5x5gyN4Fck7DHVHzLONvD34WZS+aUNrlxcHcYFkDM0OPbqCAT4Tb/or8mNw?=
 =?us-ascii?Q?SgVB3dmGBqFRv2iOtGUxDTnoJCJcaF0vlcUtVrcNf8oAOedvgW3FLroEjRkC?=
 =?us-ascii?Q?9PWVBpKxEpStyUe05C6QMW0I5Vjt1CwvQB+Hn6cD6lxlGK+lXdIey2IQEVka?=
 =?us-ascii?Q?LGZd96Xw6y0NAgP6IkfqGHUf+e08aJKjQWroeyusB8KqjrwnATTC3ObaKDzx?=
 =?us-ascii?Q?/3dfcpWgG3qqVP5QhjUS+CWue7XS5uq4PLT+XnN23PHk1cDCVdnL0my+KL0J?=
 =?us-ascii?Q?GeZ2NBXZFoTMlfiieETh7AvvtwSMy+xN+FcHETXmz42Ir24xWRDJ/Z1VLhmW?=
 =?us-ascii?Q?Fm/WSpefICAUZ1RzTGfiHhPNGndDbei6td4Y/qgR70CQj+4Bpz2vvcQFNXJp?=
 =?us-ascii?Q?bKjU1GY7pJkLyIjLRszMh3l7cg/huaKm2eVvWRBVUDJuosoILm8dfI7tcBL1?=
 =?us-ascii?Q?Vxyb9ueusNS2EfKRCUptV1PsBJG5RK5pvwo5QKhnn6KdhKy7etkowJvBKQvm?=
 =?us-ascii?Q?X/Gc3TfVx3Q8l2aXaxlOI+t2wtqRqmJGxQTAG84YEECbpiGts5o0kd/VeQXm?=
 =?us-ascii?Q?+75fw6Y8eVyt1ZB2LW9wSOuzujbmBt+N6i/15a1B8tDUf1Sl1BJChYEWNHFb?=
 =?us-ascii?Q?YMZFxKNkLYM5UPbD0HC7UhX85pvcpbk7Y0GMrY1Ogttq0BQ33dIJRGNeqfhZ?=
 =?us-ascii?Q?9PVNRrM3urK6pvejryf+rpsK/baICObNMImOh05zYbWJSeQRXO+429t2sNvP?=
 =?us-ascii?Q?gP67K6uS7FmgMnJDsKip8CsRw8fNgE3Edd4bn9BcvYVyWQgc6xJnL6wmUP4q?=
 =?us-ascii?Q?KpafRKtVcq6a9zZEf1KlhzwYJfvro7dV+5g9crCImI3cLwdfbLmpBq5e34jT?=
 =?us-ascii?Q?vIOJPoQBC6pKRso3RcbOYAF4D7wpg8S/61J1Wqs1PDqKR1oJmmVIjboYj0AG?=
 =?us-ascii?Q?Gk/0v1zFlWFaXt4oEZOw1L1ahJrlG3kSGAliXikg0PdYFgfSvsimDRW27ig2?=
 =?us-ascii?Q?GR1LTXz39acEYaUh7docsztjvCHvD6oPpGLxErhY9uMDrg8wp2BOEDqzbhJE?=
 =?us-ascii?Q?aOM8Kpr7EBYDpNrzQGmS8KFBWRUqf1qb/6UbYi26Se9Qc3u/ZYg+tR8+lwpj?=
 =?us-ascii?Q?id8mF/Ga2C4p+Ll85pdnAQ6dPFnfzSS/KkC9jC+Vl9Ck7DXm26+MrlULUY2O?=
 =?us-ascii?Q?3OH9fsfF6lOdKi3AxmaVS1LuW2c7yLcaFlhChsJzbV5m2uoxikfzJw8HX3r8?=
 =?us-ascii?Q?klMhdu2zs/QxOkWJ4flhrQCnyauwnrZcYk9RzrBIE86MQ/LhGVduQ0bqjWs1?=
 =?us-ascii?Q?vpoU+/KU6TkZomRYo1W5rtrFfwtj9/ySz3Vm/J9VliqfEepxQY2N/46IbP5d?=
 =?us-ascii?Q?tVzjXeYXx5HAWAkADhhaxyOR3DboeA0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18db33f-ebf6-46af-f94f-08df09ae2fd0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:24.2423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FYrxZL4HrIRnuOMJW8EESCCBxseQlH/oBIkRBnmc2eVgqgEXvhy6960aG4niDXPp7vO9AfWMymGGVVfE7OR7S4CeDssynchmCrPay7W6NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8962
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The vendor PBF accesses clock, reset, platform, security, and chip
control windows while bringing up the SoC.

Expose these windows as low-priority unimplemented regions. This
keeps the firmware-visible address map observable and allows later
device models to overlap individual windows without inventing
register semantics.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/phytium_e2000.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index e74a0328fe..1c337bf36e 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -74,6 +74,8 @@ enum {
     PHYTIUM_E2000_UART4,
     PHYTIUM_E2000_UART5,
     PHYTIUM_E2000_UART6,
+    PHYTIUM_E2000_CLK_CTRL,
+    PHYTIUM_E2000_SYSTEM_CTRL,
     PHYTIUM_E2000_GIC_DIST,
     PHYTIUM_E2000_GIC_ITS,
     PHYTIUM_E2000_GIC_REDIST,
@@ -85,6 +87,9 @@ enum {
     PHYTIUM_E2000_GEM1,
     PHYTIUM_E2000_GEM2,
     PHYTIUM_E2000_GEM3,
+    PHYTIUM_E2000_PLATFORM_CTRL,
+    PHYTIUM_E2000_SECURITY_CTRL,
+    PHYTIUM_E2000_CHIP_CTRL,
     PHYTIUM_E2000_BOOT_IACC,
     PHYTIUM_E2000_PCIE_ECAM,
     PHYTIUM_E2000_PCIE_PIO,
@@ -126,6 +131,8 @@ static const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_UART4] =          { 0x28014000, 0x00001000 },
     [PHYTIUM_E2000_UART5] =          { 0x2802a000, 0x00001000 },
     [PHYTIUM_E2000_UART6] =          { 0x28032000, 0x00001000 },
+    [PHYTIUM_E2000_CLK_CTRL] =       { 0x28100000, 0x00001000 },
+    [PHYTIUM_E2000_SYSTEM_CTRL] =    { 0x30000000, 0x00001000 },
     [PHYTIUM_E2000_GIC_DIST] =       { 0x30800000, 0x00020000 },
     [PHYTIUM_E2000_GIC_ITS] =        { 0x30820000, 0x00020000 },
     [PHYTIUM_E2000_GIC_REDIST] =     { 0x30880000, 0x00080000 },
@@ -137,6 +144,9 @@ static const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_GEM1] =           { 0x3200e000, 0x00002000 },
     [PHYTIUM_E2000_GEM2] =           { 0x32010000, 0x00002000 },
     [PHYTIUM_E2000_GEM3] =           { 0x32012000, 0x00002000 },
+    [PHYTIUM_E2000_PLATFORM_CTRL] =  { 0x32e40000, 0x00010000 },
+    [PHYTIUM_E2000_SECURITY_CTRL] =  { 0x32f00000, 0x00001000 },
+    [PHYTIUM_E2000_CHIP_CTRL] =      { 0x33000000, 0x00010000 },
     [PHYTIUM_E2000_BOOT_IACC] =      { 0x38000000, 0x08000000 },
     [PHYTIUM_E2000_PCIE_ECAM] =      { 0x40000000, 0x10000000 },
     [PHYTIUM_E2000_PCIE_PIO] =       { 0x50000000, 0x00f00000 },
@@ -590,6 +600,19 @@ static void phytium_e2000_create_unimplemented(void)
         "phytium-e2000.low-peripheral",
         phytium_e2000_memmap[PHYTIUM_E2000_LOW_PERIPH].base,
         phytium_e2000_memmap[PHYTIUM_E2000_LOW_PERIPH].size);
+    /*
+     * PBF writes clock and reset controls as part of physical SoC bring-up.
+     * QEMU derives virtual clocks and reset state elsewhere, so retaining
+     * placeholder visibility is sufficient for these write-only setup paths.
+     */
+    create_unimplemented_device(
+        "phytium-e2000.clock-control",
+        phytium_e2000_memmap[PHYTIUM_E2000_CLK_CTRL].base,
+        phytium_e2000_memmap[PHYTIUM_E2000_CLK_CTRL].size);
+    create_unimplemented_device(
+        "phytium-e2000.system-control",
+        phytium_e2000_memmap[PHYTIUM_E2000_SYSTEM_CTRL].base,
+        phytium_e2000_memmap[PHYTIUM_E2000_SYSTEM_CTRL].size);
     /*
      * PBF programs SoC-specific PCIe PHY and port controls before U-Boot
      * enumerates ECAM. Their values do not affect the generic host bridge, so
@@ -607,6 +630,18 @@ static void phytium_e2000_create_unimplemented(void)
         "phytium-e2000.board-control",
         phytium_e2000_memmap[PHYTIUM_E2000_BOARD_CTRL].base,
         phytium_e2000_memmap[PHYTIUM_E2000_BOARD_CTRL].size);
+    create_unimplemented_device(
+        "phytium-e2000.platform-control",
+        phytium_e2000_memmap[PHYTIUM_E2000_PLATFORM_CTRL].base,
+        phytium_e2000_memmap[PHYTIUM_E2000_PLATFORM_CTRL].size);
+    create_unimplemented_device(
+        "phytium-e2000.security-control",
+        phytium_e2000_memmap[PHYTIUM_E2000_SECURITY_CTRL].base,
+        phytium_e2000_memmap[PHYTIUM_E2000_SECURITY_CTRL].size);
+    create_unimplemented_device(
+        "phytium-e2000.chip-control",
+        phytium_e2000_memmap[PHYTIUM_E2000_CHIP_CTRL].base,
+        phytium_e2000_memmap[PHYTIUM_E2000_CHIP_CTRL].size);
 }
 
 static void phytium_e2000_create_ram(PhytiumE2000State *s)
-- 
2.53.0


