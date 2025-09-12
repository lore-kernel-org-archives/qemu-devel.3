Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326B7CAC594
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eV-0001h4-Dn; Fri, 12 Sep 2025 06:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0d3-0007X3-NN; Fri, 12 Sep 2025 06:03:50 -0400
Received: from mail-bn7nam10on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2009::606]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cl-0001Oa-Uc; Fri, 12 Sep 2025 06:03:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyaOc60Xowdw1gwFpNd+lve//vX/bIDb21vQOIYuaUztDA8C+bQSXdScsY3766BiWzY5Xht7AI374v85RBZCaS3I4CtaroGYVpi/67doPUtNubX91JD1vjFHTgg5mXn+JcAB1z3B8JcWmKDf8+d1bnvBKOTLXAJvRK0Aj23Un1+17KdadsuZ5eLqVzz5ahl3yvymNT+gTq2L2McC6Gn7IHOMiEUDD9D/1wQ2gxwf+kB1Nrh+ODZI7NljGjj5lpNYx+ubhJ3vdZZlUItOx6/cbiDXWqaHcgOwplD/lm2mOE6bkGEZ8z7VL0FXetBvXTkvcRl2W3pVvpitg0sS/73zMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SktfDzWhS3IuywAHmp5M8whZBLPzShSekk06HCXZaz8=;
 b=yuI953yHlY/CpstILxUOC46zNR+SmVSUoO+OIJr5QTVTaBOvugohH0/Qma8Pis4fm4FAxslTOGqqXHkJn9GX6TgVhXZh8es5biw6pGz26RPVGwme61ALzkImsew/+jFNsPUnnWr1eFVEy3P3f57T4dFz+V7PzUimVv/jIzzk3x/vtEX1R/xYwDVtunH5N/AT68cYjR5SclryiWyEz743dCV9VMAu/V6FC7jNzUvKnDVaK76BPa8502lDFtnN31uPQ0n7BdzspTDxK54sAoTc9EXENx3mHxpFQHs/MiLzPycsIXv5Q71dWmngVTThqxjRylJaUGqZ2JLiIl3tonXtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SktfDzWhS3IuywAHmp5M8whZBLPzShSekk06HCXZaz8=;
 b=IHWGi4uJoK6GNWiwUgg3l35ZOFBpDYvrj/OiksyOxskpLWXeWEjn58YgfU54jaokOn9GyDG0sbgvQhSNmapxNzt8bR3k9vQUiT2GizruTjnbNuCuc2OiukWwKDOpyQi1U/mD4OU/4GhYkdvCmq/Acc6c/WADDxsB7xtX/t/Ulyw=
Received: from CH0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::21)
 by DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:17 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::21) by CH0P220CA0027.outlook.office365.com
 (2603:10b6:610:ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:34 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:34 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:32 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 41/47] hw/arm/xlnx-versal-virt: rename the machine to
 amd-versal-virt
Date: Fri, 12 Sep 2025 12:00:50 +0200
Message-ID: <20250912100059.103997-42-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM4PR12MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ce6917-4a7e-4c11-99fb-08ddf1e3988a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTFReUFTK0VkQ09wejNRODZmblVhbzdLUERaSlh0QjFkdWNtVm92SHBVcmp2?=
 =?utf-8?B?SWZrZmVUTnRpczNiV1dNeDZsbythd3JiWTN2eGdOczVyNmZHZUtScDJhZGxy?=
 =?utf-8?B?bUduMDhuT0owamhVcXhPaUM2U29rbHlFSEFMZ2toOGY1Q0FTSDVzc0dwM3lW?=
 =?utf-8?B?VE9YQlB1YXBKUGljYk9JRzRUUmsrc28zWUpKekVCUENXQzNUOEJoanFXblZP?=
 =?utf-8?B?Rm8xTVBYVVRrQ3BlZzZzZGpLZUE3OWp4MlBIWGZXSUxhL3Y4RjRpejNOeUpi?=
 =?utf-8?B?SjMzdDYxTkRCR2wvRkRHU3lGUE44enRZZEtEWDZ2eVRWL1l6NDlzRUVwUUgv?=
 =?utf-8?B?dE1vbmpGSmpmMzFZbUpPbHpkRnNoTkNTQXlkVnhtMm42cnI3a2pQQ05raHRx?=
 =?utf-8?B?UWRsZU55eVA1eGlSNnNVcUhyNXlIZ0NhMC84dnJ1WWVPcHBjaU01VHYrY1l5?=
 =?utf-8?B?RlJzVHUzV2plVmJwclBpcm9NUnZzeTdBUU9KMlAyMGxNNVd0VVJkUWJlRzB1?=
 =?utf-8?B?NFBLazNYTlZpV0VmWFFoV1FIbG1KMEoyVnFnaGVKa3daSzg3SVB3WEVxN3Nv?=
 =?utf-8?B?b0h5N2prbXR5Y0hPNndtZDg5eU1jSXdMYkRWK1hUc2hVUCtIcGdhYXp2N3dl?=
 =?utf-8?B?ZjhFZVRXc2FUdFkzVEY5VVJLbDA2c0dLb0ZicjhqdndHZ3ZjWmw0QTF3ZVdD?=
 =?utf-8?B?dm1WSHVkbE5GRFdSc3k5RkVLMDhLb0tXeHF4WHliUWRZWjdaUUVXYkxtZ1lD?=
 =?utf-8?B?eXBlRjF0WkNsbzB3bUpvcHVKdUZ0eWZ4Y2xWZy9pWjMzUzNjQ3k5SStObm9j?=
 =?utf-8?B?NkcvT3FjZCtmZUFqY3BPZlQ4RFRJY3FsbE9janVEdUpaTnR2VDkzU3B0VTJq?=
 =?utf-8?B?MXlROXl6M09sMDBJUTVBWi93M0VVK1gzbnRYb29rcVYyVE8rdHJiUUV3Nmxv?=
 =?utf-8?B?Sy84MmZTZEk1NDNZUFJsTWZSYWd3bEtCSVZDVk5nTHlmTWRJUnJyWmxvZHJ4?=
 =?utf-8?B?UnZCc20yZi9wRDJIaWYyZUh5UWhCdXhIK2NvbnhwQnZpbUpZMXptcFdiZDhI?=
 =?utf-8?B?KytyaE54djV0VHFCRmlPQVA4RjdQVGhQeWQ3Y2xTS3lyZXVrMmREeE81elcv?=
 =?utf-8?B?NGFVTHRNcE5seGNhZ1lqc29hNWd1UEEyQXdpZW1xUElocDhoQTNPeStPU1VC?=
 =?utf-8?B?MDhoV0w2S1htRXpZR3JqTXlYb3hOUXNFbWdvUE5ObE0zeENTODBiMjNyUTdB?=
 =?utf-8?B?Y0JhMlJ0ckhwMVEwc3hmdHRvNUhYZlNJTFR5a0loYUgvQkt3bnNFVDAwa2tK?=
 =?utf-8?B?Q0NYbUVnQ0I2SGlwa0tLVU9OeitYWXcram9HRmdDQThkdURRRjJIQlZHbU5Y?=
 =?utf-8?B?dEpYSUd3b1NrL0F4aVlJTm5NbHhNclVTRWJrN3VHQ0V2eDdqRzR5eFlOTTFv?=
 =?utf-8?B?U2FUSUhENnhYN1N2RVlKcDAxREVuSlZ1ZzdvOUFqWi81V1pPUEJBQ0ZlSHFR?=
 =?utf-8?B?SXVYK053TDJBdnl1aTZFZjlEWURLQXlqM1ljM29KVVFDbkg2MzlNdi9QL2F3?=
 =?utf-8?B?cnJESGpGeUNYd3pldnl2V0t2NUIzRDJFZC9zUTh3aDZBNzdNOUZkMGRMUk5C?=
 =?utf-8?B?VjVER2pSSmcrZWNxYUIxYW9FYTNHVzQ4SzAwRm1qMDRyMzF3bktDb0NvZU81?=
 =?utf-8?B?eGdSSmRMWStQRUQrbGs1WCs0L3Yxbk91bjYvaU1BY3doRFJRVGl1eno0bmZP?=
 =?utf-8?B?Wk13emhlbGZ3U29tSEI1M2xUTnd4QlhpclI5Y2JFWVlBU1huTDdqeHUvL1d2?=
 =?utf-8?B?a0JlRWZTZC93VVAxdFhGSHVWYnZVeThpZjVRcVVvZDNrMnZQWlo4anB4Szg3?=
 =?utf-8?B?ZDhtMTIxTnBxOVhDK0UrME5lU1lZZ1VFdkxrb21oYUs5Y2JjcUVRR3FYWWkz?=
 =?utf-8?B?MjRiNXVBMGdlemhJcWV0MVFieHNwTExmVktVWHhwbXNPb0FqSmV6MkJBUk5T?=
 =?utf-8?Q?c0VY9pGZne17I9eoMXQ2xdrrwQGOaw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:17.4660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ce6917-4a7e-4c11-99fb-08ddf1e3988a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9736
Received-SPF: permerror client-ip=2a01:111:f403:2009::606;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

To align with current branding and ensure coherency with the upcoming
versal2 machine, rename the xlnx-versal-virt machine to amd-versal-virt.
Keep an alias of the old name to the new one for command-line backward
compatibility.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/arm/xlnx-versal-virt.rst         | 26 +++++++++++---------
 hw/arm/xlnx-versal-virt.c                    | 11 ++++++---
 tests/functional/aarch64/test_xlnx_versal.py |  6 ++---
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index c5f35f28e4f..2c63fbf519f 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -1,21 +1,25 @@
-Xilinx Versal Virt (``xlnx-versal-virt``)
-=========================================
+AMD Versal Virt (``amd-versal-virt``)
+=====================================
 
-Xilinx Versal is a family of heterogeneous multi-core SoCs
+AMD Versal is a family of heterogeneous multi-core SoCs
 (System on Chip) that combine traditional hardened CPUs and I/O
 peripherals in a Processing System (PS) with runtime programmable
 FPGA logic (PL) and an Artificial Intelligence Engine (AIE).
 
+QEMU implements the Versal Series variant of Versal SoCs, with the
+``amd-versal-virt`` machine. The alias ``xlnx-versal-virt`` is kept for
+backward compatibility.
+
 More details here:
-https://www.xilinx.com/products/silicon-devices/acap/versal.html
+https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
 
 The family of Versal SoCs share a single architecture but come in
 different parts with different speed grades, amounts of PL and
 other differences.
 
-The Xilinx Versal Virt board in QEMU is a model of a virtual board
+The AMD Versal Virt board in QEMU is a model of a virtual board
 (does not exist in reality) with a virtual Versal SoC without I/O
 limitations. Currently, we support the following cores and devices:
 
 Implemented CPU cores:
 
@@ -72,11 +76,11 @@ A few examples:
 
 Direct Linux boot of a generic ARM64 upstream Linux kernel:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M xlnx-versal-virt -m 2G \
+  $ qemu-system-aarch64 -M amd-versal-virt -m 2G \
       -serial mon:stdio -display none \
       -kernel arch/arm64/boot/Image \
       -nic user -nic user \
       -device virtio-rng-device,bus=virtio-mmio-bus.0 \
       -drive if=none,index=0,file=hd0.qcow2,id=hd0,snapshot \
@@ -85,11 +89,11 @@ Direct Linux boot of a generic ARM64 upstream Linux kernel:
 
 Direct Linux boot of PetaLinux 2019.2:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64  -M xlnx-versal-virt -m 2G \
+  $ qemu-system-aarch64  -M amd-versal-virt -m 2G \
       -serial mon:stdio -display none \
       -kernel petalinux-v2019.2/Image \
       -append "rdinit=/sbin/init console=ttyAMA0,115200n8 earlycon=pl011,mmio,0xFF000000,115200n8" \
       -net nic,model=cadence_gem,netdev=net0 -netdev user,id=net0 \
       -device virtio-rng-device,bus=virtio-mmio-bus.0,rng=rng0 \
@@ -98,11 +102,11 @@ Direct Linux boot of PetaLinux 2019.2:
 Boot PetaLinux 2019.2 via ARM Trusted Firmware (2018.3 because the 2019.2
 version of ATF tries to configure the CCI which we don't model) and U-boot:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M xlnx-versal-virt -m 2G \
+  $ qemu-system-aarch64 -M amd-versal-virt -m 2G \
       -serial stdio -display none \
       -device loader,file=petalinux-v2018.3/bl31.elf,cpu-num=0 \
       -device loader,file=petalinux-v2019.2/u-boot.elf \
       -device loader,addr=0x20000000,file=petalinux-v2019.2/Image \
       -nic user -nic user \
@@ -123,11 +127,11 @@ Run the following at the U-Boot prompt:
 
 Boot Linux as DOM0 on Xen via U-Boot:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M xlnx-versal-virt -m 4G \
+  $ qemu-system-aarch64 -M amd-versal-virt -m 4G \
       -serial stdio -display none \
       -device loader,file=petalinux-v2019.2/u-boot.elf,cpu-num=0 \
       -device loader,addr=0x30000000,file=linux/2018-04-24/xen \
       -device loader,addr=0x40000000,file=petalinux-v2019.2/Image \
       -nic user -nic user \
@@ -151,11 +155,11 @@ Run the following at the U-Boot prompt:
 
 Boot Linux as Dom0 on Xen via ARM Trusted Firmware and U-Boot:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M xlnx-versal-virt -m 4G \
+  $ qemu-system-aarch64 -M amd-versal-virt -m 4G \
       -serial stdio -display none \
       -device loader,file=petalinux-v2018.3/bl31.elf,cpu-num=0 \
       -device loader,file=petalinux-v2019.2/u-boot.elf \
       -device loader,addr=0x30000000,file=linux/2018-04-24/xen \
       -device loader,addr=0x40000000,file=petalinux-v2019.2/Image \
@@ -225,11 +229,11 @@ To use a different index value, N, from default of 1, add:
 
   Thus, a file backend should be used with caution, and 'format=luks'
   is highly recommended (albeit with usage complexity).
 
   Better yet, do not use actual product data when running guest image
-  on this Xilinx Versal Virt board.
+  on this AMD Versal Virt board.
 
 Using CANFDs for Versal Virt
 """"""""""""""""""""""""""""
 Versal CANFD controller is developed based on SocketCAN and QEMU CAN bus
 implementation. Bus connection and socketCAN connection for each CAN module
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 274a7ef9889..6ef56103a75 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -1,7 +1,7 @@
 /*
- * Xilinx Versal Virtual board.
+ * AMD/Xilinx Versal Virtual board.
  *
  * Copyright (c) 2018 Xilinx Inc.
  * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
@@ -24,11 +24,11 @@
 #include "hw/arm/boot.h"
 #include "target/arm/multiprocessing.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
 
-#define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
+#define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal-virt")
 OBJECT_DECLARE_SIMPLE_TYPE(VersalVirt, XLNX_VERSAL_VIRT_MACHINE)
 
 #define XLNX_VERSAL_NUM_OSPI_FLASH 4
 
 struct VersalVirt {
@@ -53,10 +53,11 @@ struct VersalVirt {
 };
 
 static void fdt_create(VersalVirt *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(s);
+    const char versal_compat[] = "amd-versal-virt\0xlnx-versal-virt";
 
     s->fdt = create_device_tree(&s->fdt_size);
     if (!s->fdt) {
         error_report("create_device_tree() failed");
         exit(1);
@@ -70,11 +71,12 @@ static void fdt_create(VersalVirt *s)
     qemu_fdt_add_subnode(s->fdt, "/chosen");
     qemu_fdt_add_subnode(s->fdt, "/aliases");
 
     /* Header */
     qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
-    qemu_fdt_setprop_string(s->fdt, "/", "compatible", "xlnx-versal-virt");
+    qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
+                     sizeof(versal_compat));
 }
 
 static void fdt_add_clk_node(VersalVirt *s, const char *name,
                              unsigned int freq_hz, uint32_t phandle)
 {
@@ -346,11 +348,12 @@ static void versal_virt_machine_finalize(Object *obj)
 static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     int num_cpu = versal_get_num_cpu(VERSAL_VER_VERSAL);
 
-    mc->desc = "Xilinx Versal Virtual development board";
+    mc->desc = "AMD Versal Virtual development board";
+    mc->alias = "xlnx-versal-virt";
     mc->init = versal_virt_init;
     mc->min_cpus = num_cpu;
     mc->max_cpus = num_cpu;
     mc->default_cpus = num_cpu;
     mc->no_cdrom = true;
diff --git a/tests/functional/aarch64/test_xlnx_versal.py b/tests/functional/aarch64/test_xlnx_versal.py
index 4b9c49e5d64..95e5c44771f 100755
--- a/tests/functional/aarch64/test_xlnx_versal.py
+++ b/tests/functional/aarch64/test_xlnx_versal.py
@@ -4,11 +4,11 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
 
-class XlnxVersalVirtMachine(LinuxKernelTest):
+class AmdVersalVirtMachine(LinuxKernelTest):
 
     ASSET_KERNEL = Asset(
         ('http://ports.ubuntu.com/ubuntu-ports/dists/bionic-updates/main/'
          'installer-arm64/20101020ubuntu543.19/images/netboot/'
          'ubuntu-installer/arm64/linux'),
@@ -18,12 +18,12 @@ class XlnxVersalVirtMachine(LinuxKernelTest):
         ('http://ports.ubuntu.com/ubuntu-ports/dists/bionic-updates/main/'
          'installer-arm64/20101020ubuntu543.19/images/netboot/'
          '/ubuntu-installer/arm64/initrd.gz'),
         'e7a5e716b6f516d8be315c06e7331aaf16994fe4222e0e7cfb34bc015698929e')
 
-    def test_aarch64_xlnx_versal_virt(self):
-        self.set_machine('xlnx-versal-virt')
+    def test_aarch64_amd_versal_virt(self):
+        self.set_machine('amd-versal-virt')
         kernel_path = self.ASSET_KERNEL.fetch()
         initrd_path = self.ASSET_INITRD.fetch()
 
         self.vm.set_console()
         self.vm.add_args('-m', '2G',
-- 
2.50.1


