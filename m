Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1DACA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up50L-0003pw-1v; Thu, 21 Aug 2025 09:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4zC-0002XK-SS; Thu, 21 Aug 2025 09:05:46 -0400
Received: from mail-dm6nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2413::601]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z0-0003FA-Mo; Thu, 21 Aug 2025 09:05:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7yoyS35HjfqgG+KdahoByEaMm1Cu0CRuTiXly2/Fr1rQOycp3/XLok37Vdkttj/0YdDKuUwAdsW/Q9jtpVT7QCjV2dqmHMvwd/hyFH5LwXbWOEBkNT5x5SpLL510EsnxZ1kp/q8VeZ0MTD3kIpy77N8EhTKsmEs0d0H80ObKupE2/IAPDE+KFbF0vE01tc067Jks0YyezNfajyFKh/VyEi2N36yL3te0VmsulBsQkCnbSzaGcTF7SzBNL3UVXMk24gb6zwqaXGsv1bsnNvO1IZgXj1jraLi5ZVpPtsHY66YVua84eANVH7V9t39Fru9J5tHJbo2H9ehqOz2cEJfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LzqfNSwHpewpDtrWbQLAwBB2/ddDGiv4DslcBlmIPM=;
 b=q1Zc5HOMCifIaSIQOd/OkdUTLr5/norrhdeW7ckhyq6eifWhjx6D8fqeNPwoqCeMpASZL6fLExv5Glr+TcvKvq5uOtbXQzkjzKvnsNU61QJate/c68KpK4ZYPiA74f2FK1PgZYN58clWcdfjL0RSN+5ZXzFa2zPlPNkQFDk3ZD6JM7FE34y6pwHD13lDTxE2Q2GTLXpQkhlvcS6iL1fxjvOWIeKFJytcxq1UfGwSUoOadO8TRTp1OHTZT7cmuuO/J2cV3ruQDLdNCCOQolVX0WzLMpVsFhuN8MqXikCR0Ht0o90WAY5ojBpezKkTfmI/BnPW1MYUhjN6PP9E1WKPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LzqfNSwHpewpDtrWbQLAwBB2/ddDGiv4DslcBlmIPM=;
 b=Hbpfz99rdoCkIh0JmaLjedonyWYw7mcyy11Lu87+cRHkUKPCZvd5AePh137kEJuRGK7rOj7F6ndSZRPjWn3c4hGumLcnUmLBUYi8LOQwDfbcFv6H34seZ0L0/4drXxJBPX0U+mOOD+hz7wRR1IJc2xFyfHLhQtH5gkpE2mAqJro=
Received: from SN7PR04CA0071.namprd04.prod.outlook.com (2603:10b6:806:121::16)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:05:25 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::18) by SN7PR04CA0071.outlook.office365.com
 (2603:10b6:806:121::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 13:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:05:21 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:19 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 41/47] hw/arm/xlnx-versal-virt: rename the machine to
 amd-versal-virt
Date: Thu, 21 Aug 2025 15:03:40 +0200
Message-ID: <20250821130354.125971-42-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e54f89-b6eb-41d7-2463-08dde0b364ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHpwUGw1d1ZtcERuWFRDcVpZWm5uNmVTZ2NPeUdBSnM5Zk5jNUw1ZS91Qm5W?=
 =?utf-8?B?dG5ndTZOV0ljc09Dd001eVA3eWRSem1KVURXVHliaFJqcmNoRXBYNWJFK3dO?=
 =?utf-8?B?bWdYWXd2R2dPMUFlem9PTjB3bVhpZU5KcWxlVDNpYlRRVHN2RVhWcEd2ZlZm?=
 =?utf-8?B?UlhjbWdkZE1lYlJ0QVo2RVJKLzdET3gwL1FDT2JwVFdCYnYrUTR5MXpRaUpL?=
 =?utf-8?B?dmhvNDlNVEMvZGFKWkttRU0weHRoZktxNUVUMXVrQnBNSDkxZ1ZGTWdRK0Va?=
 =?utf-8?B?bXNqNmhoVW9USTl3RjNnVjB5TkZvNmE4RmhGSTlPVmtFMHFESVRqN25vb0Vu?=
 =?utf-8?B?dXYxRVFuRmIzSWFEalhQZElaZzhMOHc1VC82eEMrY1V5Z3VLcjJKOW1YeExI?=
 =?utf-8?B?MWxqQmVndEFVSEk1RFFvdUVtLzdXMkNmOTdmc0hXYUd5dTA5SW5EdDdNd1dD?=
 =?utf-8?B?MXVTN1dBMXpoRnIwY09DdDVoSWxMRnVZVEZac3dXYXZyRlJrS1BaKzFua0NJ?=
 =?utf-8?B?MWdZUzNDTU9DU2lZTEJGMHI3bnBMeHFqYUVQMmhacFZxaVJhZThCY1lCaXJX?=
 =?utf-8?B?bkF5cW1SZUJETWVqUE1nQTJkQnc3dFE2T1NqeXZsTzhSTDhPazZRRE9ncmlm?=
 =?utf-8?B?c1JnNklET3UvMnBaT0Y4RTIrNUhJb2puR0xUQ3lJWFJLZ3Mvd3NvL28zNExF?=
 =?utf-8?B?YWJBK1JwT3J5ZFQxanpxdDB2dnBHNnF5WndBd2ozaER3SFBRNzcreUNucjVr?=
 =?utf-8?B?VTU1SldKNElSMzlsZ21aQXpDYzlGTU5qdjFsb1p3azFRMlhTbG1wZTE4eGYr?=
 =?utf-8?B?VTkzOTFjYTJQL0RybS9TODRoQ0U1RFNNNTRzdld4bnM4NHE0Wm9FdnNwYWx5?=
 =?utf-8?B?UGJ5NjMrakV3TUk3OUFmaTZGQUVwcXRBaktFa0VQZ3JDRGtkTm95cmxBL1hF?=
 =?utf-8?B?NDUrdXJQRWFSTDBWNzZxbWxXSUIzNklxTGJrY25aYWZDczcxcEdGZ05UTGZ1?=
 =?utf-8?B?SWhpQStxLzJXaEt0bVN3ZHhLS0N4cWczS0MvNzZ0NEVDOEpaWkxmc0ljSWhQ?=
 =?utf-8?B?OENTVEZnWG14aGoxM1FURVg0bStCaXNrcjY5dVkxS08yRkEvbEE3WlRqQ2lY?=
 =?utf-8?B?YkVibDl0OVpWTmwrelpKTERjbnByQ2I5VjhFVTlIR1UzaHlyZ2ZCanZiUE02?=
 =?utf-8?B?UE5DV3p0QWh5ZUZnOWFSQXMvRjhaYmNycWlvOFBwRmljZDFRZ1psTG1jQis5?=
 =?utf-8?B?MGxMbGNadHQ4V3c0ZzhMeHlESjVMRGpkN2JVaTd5UUVYeDFqWFZIdDVvVklH?=
 =?utf-8?B?WkwxVTNxeHNVOWhlTEl6VDdNTDdMWld3WndEQ3VtR0sxUFBHYWcwS2c2R09n?=
 =?utf-8?B?dG9yZ0w5WDZ3TTBqa0UyMk9FNU92T3JIcmhWQ3dpbi81MmRWTERTckIveHcx?=
 =?utf-8?B?MlQ1THFFTEdXSVpNckpQQlc1STVpNHovSGsyMVZ6a0JEYUxFRkt0OHI2OU1H?=
 =?utf-8?B?WVN1eEFITGRxZVQwd1pGN0VkYU1VM0d0eUFYVFQ2b25uWnY2Tm9ZSkEzVXlk?=
 =?utf-8?B?U1puaU9Rcm13UWdBZU8wS0hzRzJ2ekFmRlAwRGpaNGZSUjU0N1lkTmE0VCtx?=
 =?utf-8?B?d2UwRHNSL1kyWDNlZXg0K3lacnlncUtXSVZWNUxSaStvS1VEeWZtb2hXWUg4?=
 =?utf-8?B?SDViZm9vVlpkY3RsaklJM1dlQ0Mxbk1yQjllSlhNVmZtTVdIcC9jVWNBRnoz?=
 =?utf-8?B?Mlk0QjdlTTlqeGNMOXN5NjRSZHgvL2wwLzA1WXJGU3hLVGN5TXJ1RFpNWFNo?=
 =?utf-8?B?Q0JhOFhoelBIQjVUdmNZakUySnFQL2lUOWk3eG8vRUN2Q0d6T1p1ZFhnMHhm?=
 =?utf-8?B?OEUxbXFQZExPMU8xRnJJQnJKVUEycVpRVEJZVGI3QzRCSnMxd2w1OXBxRUFh?=
 =?utf-8?B?RnFWUmV4bzNYTitnRk13WmVRYkZJbEhiN1QwTFBWOTRjZTM0TWk3dm9XNFlT?=
 =?utf-8?Q?Tom7148uWYMIf0kfBeyfcJvPgKtsg8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:25.2652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e54f89-b6eb-41d7-2463-08dde0b364ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
Received-SPF: permerror client-ip=2a01:111:f403:2413::601;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
 tests/functional/test_aarch64_xlnx_versal.py |  6 ++---
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
index 59bd93223af..53987db4cd1 100644
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
diff --git a/tests/functional/test_aarch64_xlnx_versal.py b/tests/functional/test_aarch64_xlnx_versal.py
index 4b9c49e5d64..95e5c44771f 100755
--- a/tests/functional/test_aarch64_xlnx_versal.py
+++ b/tests/functional/test_aarch64_xlnx_versal.py
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


