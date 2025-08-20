Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532C3CA0EFC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeBq-0001A0-6D; Wed, 20 Aug 2025 04:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAY-0007Ah-A3; Wed, 20 Aug 2025 04:27:42 -0400
Received: from mail-mw2nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:200a::60b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAV-00018g-0E; Wed, 20 Aug 2025 04:27:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVQ7IlgIFSMVNyST5UvvnReqU/0XWtvJDwynOVNFneXTFd9TsDISic0xrb1RnD+RI7Y/McYQH9CPhb56DiEtWPCi8TL4jqMA4gqU5loeRfHAHjHqIRzZiBGewr2tm38hEZd2dh7ZKpSuKjSmP6CnSJePqtLN3DgWUqmfvr/ymSAUbdU1ZUtq+rUKiPsXd/jEeQYbbo+gb77F2Kp+RrCEM/bWKshXoo4MOKWdGZVPmIFR7AdTWxvbHZFIXtOiXI7mG36xoBiN0fhDkZnxPj+y3nJz9+N+Lf0ABQNtopWed26oDmHZMRCWFX7iyZ4D8PqBU/Jb15wz5BFUsQG3x40hCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jESfvBAOraAJt2LRceG2C04RN42EGPtAsUdh+TC2PJY=;
 b=QaYHqhxQAEscmpplR92wWlQbjDhaytm6NZzR1Wv+7ZTmSPgu7wv44j8U552NS/dQAS3CQc6Q1BGEU3pduOOMfxvysTd8r/yqwYEqK1IWeafGPOVmDWjAPfsaHpxtJYZzvasMiB4/zyrav60xv5zOVlX/xCGF+EwL7KF27T1OnDSYSlUaA+EnlG/Y32Uxtdc/f1oGKJLP5zdhVs4/P6bQi/oxASpAvEQwPKR1XT/r6iTIAofe02KKoTIXnE2vpJk+jyxXHCYnxceh4pLXAOMcqFQckEgsY2m/b4f07qY7JqhwojsfD2o+lDK862sSfgClwPhR00IhXM4kOzKkw3OH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jESfvBAOraAJt2LRceG2C04RN42EGPtAsUdh+TC2PJY=;
 b=WtCVIwAcDZGw7W8jXe8E6f99nP7xMuYgSZzSacl7cYJe5MHR5O4FA5rH2qC9Qzo4YFnxK9fQtEA0IQAGiYcBVh249qWr2CwES9dd5b+ZwuRC1nE2eDv5psGZwH1FsVDO5oQdD3qxjdf+2Y1J4ivU0BlpmyHkAEIg4tcoMJbLz1Y=
Received: from MW4PR03CA0111.namprd03.prod.outlook.com (2603:10b6:303:b7::26)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 08:27:30 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::b8) by MW4PR03CA0111.outlook.office365.com
 (2603:10b6:303:b7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:29 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:27 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 41/47] hw/arm/xlnx-versal-virt: rename the machine to
 amd-versal-virt
Date: Wed, 20 Aug 2025 10:25:40 +0200
Message-ID: <20250820082549.69724-42-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e94577-30ee-4635-d19e-08dddfc36768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oVSpUNOxEzGFJY4CUfae74cexqEG/7sfrNnqzKlOvUCS8nBvpcpmkUl8McvQ?=
 =?us-ascii?Q?6wfKBFxuKoxfzAOshAygSBlG4koosMzjGQq5Of+5t53GwRASkcx4G8nTpgAK?=
 =?us-ascii?Q?PVT3shqOWuZAmPbyInsmNmaGckObKMs0OmOTDIWEmG8g4DTG9i0ihC7NP4KZ?=
 =?us-ascii?Q?DXYDzCOXP3VWlEyyzG28sGRCFGHyE4BsPtVv+mALD2PBZ7+c0A361AUerWyA?=
 =?us-ascii?Q?PyKRrVaSPW4+byuMwQsNE6iyeZfVYYbxMP8nJYNtDf/9YClCpncvJNWr+VvL?=
 =?us-ascii?Q?dXaZeIOK3yho6/52QHMS/IUYCDtfuMt0ykhozxHyF1t6GJE8xoCF7Mp0+zjl?=
 =?us-ascii?Q?14Rn/1gKsWN7y1SE3PjKauGbK0XFgSI+in4VUsVsH8D4JLxnod3xSmaYNDUq?=
 =?us-ascii?Q?Ah+iudwwLDDFL+cNjgAeaw9n3IZhvrG1n/PviXmT5OxdLI/AblbJgMQL3VN+?=
 =?us-ascii?Q?9GsGwii7HUo3tN9Ui8wBOJDyxK+/67tJkfn+WkYaCjZt7l9+/XKLsLwMCgO/?=
 =?us-ascii?Q?aU0jPNmEAN6BBKDMUuq0FVnD/z9MMXVdxyFPJFAEsoq+midQmiHe7WE/fqkF?=
 =?us-ascii?Q?W1QOX7sNobzZ5+L5afMSgtwYbftvLWkCzu3OGKCrddjsVx8ROPYgos09tbSn?=
 =?us-ascii?Q?O2pP7PWeDhOf6BpfiQIbDd2cwkdogAQ/rchnz92dtyOWnaIJrF8ET/ONJ9OE?=
 =?us-ascii?Q?V2ZPOK7DCyyoVxTqnMoYIj9lWEQaQFOpEWCESpVMEVAEimFo/CJr87NT4z1Y?=
 =?us-ascii?Q?PNP6Zk+bvpJ335hjcsgenS+/Y1n0Y0t8rTaWF4WNgoKalSRJQbk6zdjEjEMP?=
 =?us-ascii?Q?CS8JHxgTD9fj0X98J8E2kGHj1CBRsyjj/uBQEbIpcszmiEO6PU7ZcbZKakcZ?=
 =?us-ascii?Q?E0Nz9vWVc5OaQSEpPw3u6dAzSG16NUoNUSvDNftXeBwfP+3LfrCQwNadjb+w?=
 =?us-ascii?Q?EPKO/JAAOEck9P8nhhomO/IYDI3zvLq5Yoy18a0CNQNw7OH686iMa97cQFxQ?=
 =?us-ascii?Q?L4Suuuo+Li69jET3ELhECm8GNKngZix9RfEACVrd7LDaQEaBuiHk+g64NAxB?=
 =?us-ascii?Q?UB+QHo8UT3NYt7JendQn96+yZNeWZPfjG4xnXbXRiem04yWO1r1vrbtAhw0G?=
 =?us-ascii?Q?cOj4LvRGLUk4RnvRTJHh7y1EUB4V6/xMwg8p55vcnnR3VNNrMYOuBuQ6x+y7?=
 =?us-ascii?Q?l+GEPRNE/Huy6x+lZ7FxHU7mMm6gyBNrCyeCckB6HrKGlGHZkqq26QwdJY0Z?=
 =?us-ascii?Q?n3A5VN8bxRjoNTmOWLcAG1Q6DVLZ63WBGGB5bxAs7U6E+yLMbmechxlZ1Ckf?=
 =?us-ascii?Q?jDKiWpxciq1t+Srev8xtQ3ExdIbmZQW9E1wA9vgHsAMwYUuVxIEgWPt7Ernv?=
 =?us-ascii?Q?XOE+6zObhMwC/UY1Umewi2FRIxHmV/0U3qVDLrfKC0qAeMscBRe2HZSi3mWW?=
 =?us-ascii?Q?VNX8KrCSDVb0y5sBT+eDo21wxmPRhYe6veZ0EZjF25XDCbFNZ1B/OrfL+jqr?=
 =?us-ascii?Q?J5J0JGA5IzSN7P5pWZDWUyInOhdidUSC8V7Jdj7zju+8SmvPgw7bNexoAg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:30.1672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e94577-30ee-4635-d19e-08dddfc36768
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
Received-SPF: permerror client-ip=2a01:111:f403:200a::60b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
---
 docs/system/arm/xlnx-versal-virt.rst | 26 +++++++++++++++-----------
 hw/arm/xlnx-versal-virt.c            | 11 +++++++----
 2 files changed, 22 insertions(+), 15 deletions(-)

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
index 0f114ade652..4495b20ee1c 100644
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
-- 
2.50.1


