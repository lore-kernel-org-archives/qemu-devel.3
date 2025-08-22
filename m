Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4200CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXu-0001tr-7H; Fri, 22 Aug 2025 11:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTXE-0000Pn-26; Fri, 22 Aug 2025 11:18:32 -0400
Received: from mail-bn7nam10on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2009::622]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWr-0007HS-0A; Fri, 22 Aug 2025 11:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmt2TRi7AG1JxUYI+R1oIXoJiZIScB7bQMhBTO6nxCb7avd5XhQHl/rIjIUltiNmE3xIOCfjMmpbPUnbs+/cm6sOuiysmUdB6toQfbnlRDADwl+CVLQPCAH+Py9RdAufWYo4OOQCasCIOYltlVWEaf+nlGkijELR0iEtXmucXYEueJ8tJdXx94yOm+VYcAzGptkpo7EIv2jFTObf1GKl0f2uoGTmXB/aRVX/PxYrHkoiNmd4CTwiGLNb3iklT0/HQahylljgSoq+XMqQuoJqJZO26TCKO4/kzRnjC0s1uPM+xkeOsi0GFynEisTRLojJQzHuqMySDZLNFby0XhIpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOLv+5Be9QToQYHLOcqBDzpK7oF2zVatmACTCeiNzM4=;
 b=fREply3okkbyAh5QmUuBYfwdYh4Z5BZiy6NBGqls3VhPDvSavEaffmZFbJ0dAprxgo4rqRK2GdHdHcJiDIAXHKciyaUtTs4JgUTc77/99f9SmozX6OxXW1cU7H4hvYJxPmjPR5ofIP6gcC3r7zBaq1M0gE6sIv1xvocS+q024IFnH/Iqhpj0j+skFuO/czDWxM4GSManEa5HQ6/SCCQekbsSQ9xoMuKXcyb2rrmOWvNoYr8J/4XIRSdpt72ZvnEjxL/02H5VVoYsZ+v96zyu2qXPncOPpPQl+jVtSchfhbI8gleozP9pkRuVrogFL0Yf0QMQVKKaa5wBzKtb+lMrpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOLv+5Be9QToQYHLOcqBDzpK7oF2zVatmACTCeiNzM4=;
 b=mQcuKAlMf85Kfxfmzm+dhP3kM83wKKXq0Jf6o2moQl04exJi8kBypfVdy+F9Sz5K4Xh2DNmuCJ7PDEPDgLpp3kxNEnrpQyLmW64fXC9Et1s6xsgsZ5CoprSQgM9OR0dagG4TDk/s8hnPm69ppnPOwOqm4v+FBeWneATsTikgjZM=
Received: from SJ0PR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:334::17)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:17:49 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::4d) by SJ0PR05CA0102.outlook.office365.com
 (2603:10b6:a03:334::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.5 via Frontend Transport; Fri,
 22 Aug 2025 15:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:47 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:46 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 41/47] hw/arm/xlnx-versal-virt: rename the machine to
 amd-versal-virt
Date: Fri, 22 Aug 2025 17:16:06 +0200
Message-ID: <20250822151614.187856-42-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8c2f28-1c13-4499-e708-08dde18f0e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UG4vNjk5REcwTStpMVU5RzFxVmM5SkpCcmtjb0JKbUFWR1p6TVprenNOcHBG?=
 =?utf-8?B?bEdWVWdpaTYwZUpuVG10eVN6dS9iczluTmp3SFlUUkNaNzhGTXNoakFrbTNE?=
 =?utf-8?B?aUtBMnZNYkcvK3FJS2xwNmRZdVFHbEozeXBIazF6V1FlZUVvRXZ4bnYybHhK?=
 =?utf-8?B?SnIyZWlJOE9vODRwa0MzZlFoYW80aEhPeVJQM054ZG1xaGNRTmlSbk5GY1Bw?=
 =?utf-8?B?Z3ZlckJCRXJtbnVuU3ByREpxQURzMXZHN2RkbzE2c1RES1crQ0xQWjk1d1BV?=
 =?utf-8?B?TkNTNklrY000K3RpNXFCdjY1Q21xd0hyZUc4WmVuRkVta2JRUVdmeXl1bGRx?=
 =?utf-8?B?WjQ2UFYxZHkyemJqN1pJUWM0RFAzUWd6cUI1VHY4SGNsQlRkNTBlNWsvSVNL?=
 =?utf-8?B?c3J6eG9heEdDZ2N3RC8wSUpzN0dScDFUYW13WE1qZGJwSFBtdmdtU05WNVBt?=
 =?utf-8?B?K1libk9ESlp2c01UTktjcU9RMmVodTU1WEIrcytYM3NKOFFud29rb3A5Nmhs?=
 =?utf-8?B?bDJJSUh1SUk4OVU3azExa1VJQ3NIQmYzanBrbnI4VldEeDFDRmcxVkpxL3Q4?=
 =?utf-8?B?TjVPaWR2U2RlMUNrOEhCMGM2ZDNhUENaYkJGbmdaK3NVR24vKzRJMGl5citx?=
 =?utf-8?B?YlFnZFNpdXVPdk9pUE9CNkFKbVNqWDVkanFNb0pKSFhSTVN2Z2NUSmVQMi9h?=
 =?utf-8?B?dTNQY2xSamxGT0RhRS9mekhibzE4cTlaTHY0TkhjbE1iQy94czNmQ3VEckUz?=
 =?utf-8?B?dVZFSHluODQ3UjBvWTZDWEYvSmNvLzUxUGI0MnNzT3JGNklzYS8waUF6SUxB?=
 =?utf-8?B?eHFzbmJ6ZElXeVF5a3lRODByOWtwcTdwMSs3c3l2bVg2U2NDcUJtYmpqMkNR?=
 =?utf-8?B?ZkxMcFJiQlUwMWQ3Y1hnMzlCN2dNaUxsWDZzcHd3YUFsQnBHcDUwQXJ6MHI1?=
 =?utf-8?B?bVNsMi9XbXdaeHdSdVJVelVsMG9jNXNnSXdYQWlQeGlqNUZvbkVOTk5IeWt1?=
 =?utf-8?B?ZnVpTC91TzZ2dDhiZFlReWwySDR0RE5udE5ZRG1tQXFFUGVScEpFNktLdzJV?=
 =?utf-8?B?alg2REp1U0ExeWdyMWc3K2NLUXFQZGxidFNHYzAvUXNUYWYrbzJjNlBROFBj?=
 =?utf-8?B?QU53MWJFY21MeWlGMUZzMUlyMFp5c3BGU25aZDQyaEZBemFNM2dhWU5EbEZE?=
 =?utf-8?B?MGtYRmJHSkpJVXBIZEo5VnlMQVN0NS96SHFqN3VHOXlZTk1FYnJvejBuOWVy?=
 =?utf-8?B?THhTRmVqM2NjUUdIOFd6N2NzMTBaR2dXa1lyazlBQml0bERFUlBGT1Bhd0N1?=
 =?utf-8?B?RUdsNFhyOURDODJsRVU2ajcrSXR1cmowNUZpRUpLK1pwcnFxQTRMblpKdTZW?=
 =?utf-8?B?YzRTSnRDc0c3azJaV0RhVkZTcXRjTVJnN2V3QXo3aEZrZzFPWmhJQUx0TUxo?=
 =?utf-8?B?WkdhdzJPL2tkN2o4SkxYRXJ6K2xNWGp0a3pSUGh2Uit1MHJ2OXdoMGJocGUr?=
 =?utf-8?B?ZmhDcW1WVXEwSWdRS1BSUFVsbnZ2UDFWMXE2VUorYmxQN0hHWlk1ZWhTUjl3?=
 =?utf-8?B?OE12YzdJaHREaEI2VDdtc21id1YvdE9jN2Zmcmd2YUh2ZU92YU0xRG9sMGZ2?=
 =?utf-8?B?dnpQOTZEMUZOdzQ5ZDd4RHNndDdNN3lWcDZIbkltTmlCUEwxL0pUYlZpRVpw?=
 =?utf-8?B?UVNBU3VkZFBkRDh5V3g4eG85eWRZeDRRbEVLMGpjTWs2ZTBMdktvcnpWUkRB?=
 =?utf-8?B?aEhsMHo3TENkWkJkQ3VRYVA1bm56ZW41NThCY2JKUFEyMld5QTdMY3QyQjIz?=
 =?utf-8?B?ckIwYlpPd3FMbmoxYlozSnpSc2lGaFJiVkc4LzZXZFlNa0hic1ZlVVdCa2dU?=
 =?utf-8?B?MWJ4aHg2eEk4bXVUMGEzUUpPTUQ3cUJ3OUZyakN5enA5UC8xTlBvN0pvUTJW?=
 =?utf-8?B?VDFNbHp4WWw1SWg3NGJQVVV0MXBiU0YyNGtrNDZqT1A0MWVydEIxeWZob0E2?=
 =?utf-8?Q?a2IC5p+ichJavPH2qnPzKfagnqtpMQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:48.6567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8c2f28-1c13-4499-e708-08dde18f0e00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
Received-SPF: permerror client-ip=2a01:111:f403:2009::622;
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


