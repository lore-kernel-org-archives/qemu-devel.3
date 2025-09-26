Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78682CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22hV-0002ST-OP; Fri, 26 Sep 2025 03:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22hJ-0002Hq-4o; Fri, 26 Sep 2025 03:16:54 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22h9-0008Eu-1k; Fri, 26 Sep 2025 03:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZOHGblqRtCKjNdS11PjTvn8Mb/6HPv4WPwm9OtiI50Pcl3IRl8itzRCEyMVRPgSTBXLORTBFBmDH7hNi54orMdrPHxeBghsIj6jNQCuZI4Sw5yYFck2QeTHNtThS/DXzloaZCLOb8YoqYUSSD2fDuat+KPP+6UBF29ApGogD4sjhKaZrT6EWuC2HfMq7xlZ5XxlMk+81yB3gLvNkPAlK3SAP5LmE5IGFT3dM+2QAoOFHYJboAMOQutRfxo+K7oxkrAvhpgzKISY7RtuDvpv/NdOJ+39SXcQyyKVa3MH22m6wC07BX1rwNDGjVY6ILlDKb6PFATpf91WGB2wgoySIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43DAsyoDKqmcsPdXx8Vg8ixjmbvtf/DjIOp5XC1gZ+o=;
 b=nWH0mzmS1Wi+1bQKcxdAqpOjIOZ5J7Qjq6GLmcAN32yBo+pqjwNtwnCI8wE7ptpnm2tMJ08EJSQt0mCl56woBpkBpwuXFOwqGgJYx7uGcDZ4jAg2/+r1gZcpp0huJJ62SDcm5Yuho+xS+sUIzpzE1yeeA7dTng3PwG73FVevI15kqGbtZSXjhaGZUu/SE3XgpSgFp7L+8i5pQdKzXYuu/MWin8VGj3G+QAQ3THnauXM/tMJPeKMDvf9dxyH3vMe8FalYt6NIsTOYCKpRVt7rlVQ4ntcN9VDFYkr16bTx1eAUW3lIV5ASwPF3wpECwThlnCRpoNLLXyc+7H+O5hFRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43DAsyoDKqmcsPdXx8Vg8ixjmbvtf/DjIOp5XC1gZ+o=;
 b=YRz7D1tXZ8b8uovTINFwO4S+uGjC3bUdSiCZ9yvPz1baZ26dSO3BsBxy1CUNT7EpJYNT7iHO0r84uBF5FlD3gyYNcY5JCeFleztljdWeFC3DOQWDCskzZM9BbFPygZaKdoYwY+83qlNzTSFD6KAZUkCWah2D6WbUL+TV6XiLhvY=
Received: from DM6PR18CA0015.namprd18.prod.outlook.com (2603:10b6:5:15b::28)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:09:35 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::4e) by DM6PR18CA0015.outlook.office365.com
 (2603:10b6:5:15b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:26 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:25 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:24 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 41/47] hw/arm/xlnx-versal-virt: rename the machine to
 amd-versal-virt
Date: Fri, 26 Sep 2025 09:07:59 +0200
Message-ID: <20250926070806.292065-42-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0225d08c-c708-49f3-8aaf-08ddfccba5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ek1tRHFacCtCS0Y0Vm9ZNFBwN04yMGJCOEpoMW1VckJLUFlLTjBVb3pDTHJY?=
 =?utf-8?B?MGdrWGhZOE5SOFd5MVR5Yit0VWtuSlJTSFpwei95cVQ1VHJXbkZWYnhHUUNx?=
 =?utf-8?B?SWdYbFFWVEtOZ01MRk5jblhXc2l6SWN6Zm41NWcycktDOVdJblNOTHhNY1NB?=
 =?utf-8?B?RmlBVEJzTENYMyt5ZzBOcndNNjZlbmRDenBoODEvMGNGRkoxUmhpQUY5elhG?=
 =?utf-8?B?b1JyTnlqL0hBb2tOT0ZkSUZoV0ZNRlNDY2RTaFZzRFJ3K3pNQ1BWc1BFYkRS?=
 =?utf-8?B?UGlnOXA5MlU4UVBBSmxOeWNPMW92VlFMQlYvZTBtaTZ1dUp5Ri9TUnE0K2VB?=
 =?utf-8?B?SDF1NFZqZk91TThlak5HcVpHelVDdkNzNXl1SVNSaGRaU0FkWUpTTk9aNW9K?=
 =?utf-8?B?NmFKcjV5cjJmUnBYVGpTV0pLNURLR1JERjJPSnZDNmdpSWY2TmdjdVJOakIv?=
 =?utf-8?B?SWJVUi9acys5UUNBWXhhbTgxaExsVldKTUxtSXljRVB5SVlQME44Rnl1ZXRG?=
 =?utf-8?B?ZGcvczU5bll1R2xxb0hJK042YnFFUmw5TTBrK0lJWkpvVEs4c3FlZm5YOTdj?=
 =?utf-8?B?bldwK2h2NnlOUElMNkt6b2ZBQ0tyc2pFeWNHNkl4bWNoMktrWWdMUkxZdUcx?=
 =?utf-8?B?dHFhS2kyWUV2V3AydWowWnhSclRnL3FLU3BDN3pNRkJCUjVucnhPMCt1dWhw?=
 =?utf-8?B?aTlYbFFrN3lJVWlUK3VPVmVKUjUyL1hZeVVLdWNFbUI4eE4zajhUQ25CbmVy?=
 =?utf-8?B?NmtsUStsc3MwWDBnYXpTZ25WY2FsODdEL0hDS3VwaURhdnRzSmhwd0NvalEr?=
 =?utf-8?B?eHYxaytSZ2wxV1ZSc1YvY2lMME9Qeld3YXFzMHkrV3B4REluT0pwWm1FVXdQ?=
 =?utf-8?B?eFFpQXhPdlhFVXo1S1c0bDZwL1lvbWlmcU50NzgzVS8yNldEUW01MTB5NzFU?=
 =?utf-8?B?cU9XT3F6b25LSWlBM25VMDY4a1lpenkzekpjd0Fzd3M2d3RQdWNBRlNUVmRU?=
 =?utf-8?B?UlVuaUtGTURDcC9lZStnU0thbThjWDQreGFtV0YvQjNTV2NlZTN6azZlYVUx?=
 =?utf-8?B?bkdqUlBqUDNOSkhKRzMyNVh6amVwNUpNVjhWSFh0RmNVNC85bVNXWXNqU2d0?=
 =?utf-8?B?bmxKUS9YVDhMeFRzakdabmJIbFJZL01pQk5nZkk1bGFPU2puWHd4dXIwZVVw?=
 =?utf-8?B?bDJDYUdGOW8vb3Vxb2dwbGJQTms5ank0T2tMbDJpRHY1SVRXcng3eGVmTXh1?=
 =?utf-8?B?WS9oV0RsUGthYTY4SHJPNk9JOENOaThZODQ0YThWalkzeDNCUExlOWpGQ0pZ?=
 =?utf-8?B?OUVkUDVIUEtxTy9RY0ZtNjJVNkN5SXRqU2tVM3RFYTFRQVhtWmN5U09xeisz?=
 =?utf-8?B?MTdKNm53bnp0T3FqZ0g0MUduZEdyYlE5MzZyd0ozUWR0WndFL0dpR1kzeE13?=
 =?utf-8?B?STNQek94akxmdlF0TWkrazJjZmpGdmlMYXlHZ2RKeFF0N2tmcWxqK2JDdGhy?=
 =?utf-8?B?RThsTlNma3Y2ajk4SENBMlh0bXVoa3NIWWRwNS9Ydnkyek5JMkN4Znl5cEUv?=
 =?utf-8?B?THpPTWdiWnc0NnhseUtLMkhtNUlNUUtGbmllNXc5QVdIREdId2MzUUFnYUhM?=
 =?utf-8?B?WXptOWl4TUZOQzhUZWNMdVQ2b2ZDMjk1bUxEc2FiTmlPZnFaQUZyMnBPV2ZD?=
 =?utf-8?B?SjJ4R3lKZm5BamFCVHRLQVpSQXRONnJjb1RkOUY3WVc3SWRrcUlsbmNHbFk2?=
 =?utf-8?B?SkZ4U0JaRHNKMStPVC9paXdWcTVZelAxNC9WRzcvZGhCYTBHZzliZmlwekEw?=
 =?utf-8?B?T1BtemNYeXhPWHdxYlJrV2dKNS9Dd1NvUVNkZWVNaXFCV1RsOXVUWHVzV0Ey?=
 =?utf-8?B?NnFVUVg3VnQ2SXFKUjJaRFh6OXlrQk9tcUhZaEZJQ2VhM2Qyd3JJVDk1bHgy?=
 =?utf-8?B?bGN4U0lKUUNCRWJvblZSbTBvcjVxZmpWRkNkampCVUdVNHVuaGtpL0FXSXVT?=
 =?utf-8?Q?gD9JZuyxUr7aRXFEWX6b0T7zV6vvZ4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:34.9229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0225d08c-c708-49f3-8aaf-08ddfccba5ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
2.51.0


