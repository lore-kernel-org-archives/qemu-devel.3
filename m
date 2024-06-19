Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F50C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 09:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJrR7-00049w-Mt; Wed, 19 Jun 2024 05:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sJrR5-00048W-Ms; Wed, 19 Jun 2024 05:16:59 -0400
Received: from mail-bn8nam11on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2414::610]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sJrR3-0003rZ-LK; Wed, 19 Jun 2024 05:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfD+YYlYqII6HTKO9mziEvAfg35gliuZhxpSVopqebECBZS3QbcPyxUvY01tiek+u9Ps60BBWdO4uIG5ZdohcS53lC+hCfaDhjFnCjSO6gNXZYIX2gkYks19sLqPxeTmhI4kLtvlcXEjHmmLTQ+HuqZTDm2Gukzgf4Rvv6plQ33cSrw5C1bnpAMA8VQCYNnGh0B6hm5MMQgFp72xd4D01FP1+ZMLazTXxh4MaspJkWIoKQnh9bNYmpxV3WZdE3TSS/rKtax69mKENzhdUKAp9LHIcYVZGaX6lYbmeCfKT1ELnSBm4uRBOIqpfGOUlPINJyAJwDyufkzB8FNUEb+bRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Q2XwiHhQDPY6HBUB/s6+x8qVqjvUZ3B/o+F4Yxi36Q=;
 b=TLJ1VfgXIIrLj/BhsCRMc7bZDzxL9aUsLxRpm6PtWOuZDvGNHZ2yu0lj4EJ4x/H+TGRg73NCYbQaEiDAbJ9WO5sPhMoh9hDdZysXQAfIxz0yumpIZo1K+ixhQADnJuv8Hpm0cJvCl05AZq7DXalk6HbCBH4TQ+yGjqAyiKsBfYLkO9fXeNC4jL9dgANh9bnMyk/znXJcfqmcFqiGlcJXPchUrHSMveoaUWue/fXFr+HrrIR8mpWKUJx0p0I0GQjYyFhcapSSao53zC4q4CENAXPoIyycDJ1uQM7190J3jcFGZlhTlXoJ7gyz+JVvMUHlJvE5Q/pkhZW5TPkvVG26GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q2XwiHhQDPY6HBUB/s6+x8qVqjvUZ3B/o+F4Yxi36Q=;
 b=t27byTVeYlPnH27Gg9zka7cOpgwLSYT4WhMO5tvQJrf4jKjhYTSGY/qwlTD1ZoiewpCsmAdH+K/5y+NUE/LLOLomrTr+FmNZe9N/9a8yVY7BJLD4J2hmHHAcrAuoZCw3cYHYLt5h3tBKxIbXZfnVRQRAPlqEAgsNU7Lx/tu5z/g=
Received: from BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::16)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:16:53 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::8) by BLAP220CA0011.outlook.office365.com
 (2603:10b6:208:32c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 09:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:16:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 04:16:52 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 19 Jun 2024 04:16:51 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>
Subject: [PATCH v2 3/3] docs/system/arm: Add a doc for zynq board
Date: Wed, 19 Jun 2024 14:46:32 +0530
Message-ID: <20240619091632.2825550-4-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619091632.2825550-1-sai.pavan.boddu@amd.com>
References: <20240619091632.2825550-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ffbd67-bcda-443d-fdc8-08dc90408f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|36860700010|82310400023|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T99EIB38X+XJP2pXqCuIrO4bDKAOlyCihrj4H9w/hMpwf3ltmk6wXR/kfrZs?=
 =?us-ascii?Q?W9Eo3NFfC3P9Fy6WDECdrS9KvVsR28zcN5x32M01Dd8SzjmLSxPuNfR4Nfbu?=
 =?us-ascii?Q?pCmysY5A11ar2j/PZD/AE1uPNfOCnFAlf9eFFwB5A9/KW2//IanLJV8svpY8?=
 =?us-ascii?Q?hLo+ahzN11Y9hInv6o05holhdAIT516H00pt+G8fBDS6lcrNdEinifG7FcZE?=
 =?us-ascii?Q?FlIg5liJuuRi7OTSEBRXZZAUNreC9zv+EKfFu+57a/QWunqgmCBY42MbT1/Y?=
 =?us-ascii?Q?iwSN4XHR5L0apOLeEi+QMk7n1NePwQS2cTfn0swV5zKjbjJlgHfQraEDC75u?=
 =?us-ascii?Q?+aWk9kb1HKwYDLIt22fq1Poa6Nj7JoIf1zYVhtucSi23fFtmF28xXFRpFotK?=
 =?us-ascii?Q?mTRUSQH938p6jrX8BTp0HzMGc2elE1MGdSbM6MEK3DQl0PSph5318k7oi/NQ?=
 =?us-ascii?Q?LFRS/Njyu7gr8PUGZdYMq+jrlOTFTTLEnzOSuc1qQ+Qvey97Of0KooayS8Gb?=
 =?us-ascii?Q?2IXOW1ZEGYg8Kviezq7byKLqTbXwuDlY83oNJunRoDgm7HQ0+VOLVVSB9+d4?=
 =?us-ascii?Q?+XA9MO9AwOxZtuc1Ky2vu6ntkk7WtOpwRrFdSIjSKDS5MSjY4h8JDeLnpWCY?=
 =?us-ascii?Q?dzkfJWf9y/BetCZYmU/phrSAXS907YP0EsaYoMF9U0XTXzdjC6IVStXCW8Tp?=
 =?us-ascii?Q?6M1ldcypt1F80WX7dXTFb8w9N2Oaa2QIy4x2NIbaxE4UI2X8KOxnmMrkZQB3?=
 =?us-ascii?Q?+TkuNswhHCqTrfFN9H2EVZpgzNGdt9L2NyQxeysO8jVZDVRaca7fGErynppW?=
 =?us-ascii?Q?ymfvt78MlxRAU84y7HexNqYYOiri+K0lpAbbj/xL91wnV8O9+8P9zGQzRSyU?=
 =?us-ascii?Q?vUGBTwGQHYla07zX4ZUtXI8CkVeZlLZp0RJuODjBDHsD+TTBbl7E9zNpROgx?=
 =?us-ascii?Q?+fZMSaqdYsR/+AFBMzWoJYHF9LRiFIGo0w3dlfSYNw3NzYHZsE71W8674sn+?=
 =?us-ascii?Q?4sUFLwtJHy4+iXXkFYj/J7WZU2omFw1VPYyvUvcV+ZpBQCrDDDdyvnfDLoEu?=
 =?us-ascii?Q?dmaelcuIhMlFCVb+EJwP2nA3MmZbOxiws8jjUAUMUFQEC8tyvbfNuMHbNrIR?=
 =?us-ascii?Q?0pj24XiqPXZbC+0F/mWsIjnOIpKXkEJy4DB/+u1J8j1OkNSC8Vop/bdKFn6D?=
 =?us-ascii?Q?e2pQWx3s2XZRW8U46HZaOmiaOSRmBNCExWgOsDMfispxyDOrWVc+O8sXBHF5?=
 =?us-ascii?Q?oJeYMFFSChjmp7LGUIyqdFKAjJaNyjzBeTjRboVBe+8ZNaiHuNhScLRnL5Kc?=
 =?us-ascii?Q?ZOqddnKl9Ql7dipnCz07SjT3xWPtCqHDNwf27gIE8fFUsnqC7amaat/3psZm?=
 =?us-ascii?Q?UF+zJqQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(36860700010)(82310400023)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:16:53.4825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ffbd67-bcda-443d-fdc8-08dc90408f42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
Received-SPF: permerror client-ip=2a01:111:f403:2414::610;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Added the supported device list and an example command.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
---
 docs/system/arm/xlnx-zynq.rst | 47 +++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst    |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 docs/system/arm/xlnx-zynq.rst

diff --git a/docs/system/arm/xlnx-zynq.rst b/docs/system/arm/xlnx-zynq.rst
new file mode 100644
index 00000000000..419cc1aec8b
--- /dev/null
+++ b/docs/system/arm/xlnx-zynq.rst
@@ -0,0 +1,47 @@
+Xilinx Zynq board (``xilinx-zynq-a9``)
+======================================
+The Zynq 7000 family is based on the AMD SoC architecture. These products
+integrate a feature-rich dual or single-core Arm Cortex-A9 MPCore based
+processing system (PS) and AMD programmable logic (PL) in a single device.
+
+More details here:
+https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Zynq-7000-SoC-Technical-Reference-Manual
+
+QEMU xilinx-zynq-a9 board supports following devices:
+    - A9 MPCORE
+        - cortex-a9
+        - GIC v1
+        - Generic timer
+        - wdt
+    - OCM 256KB
+    - SMC SRAM@0xe2000000 64MB
+    - Zynq SLCR
+    - SPI x2
+    - QSPI
+    - UART
+    - TTC x2
+    - Gigabit Ethernet Controller x2
+    - SD Controller x2
+    - XADC
+    - Arm PrimeCell DMA Controller
+    - DDR Memory
+    - USB 2.0 x2
+
+Running
+"""""""
+Direct Linux boot of a generic ARM upstream Linux kernel:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M xilinx-zynq-a9 \
+        -dtb zynq-zc702.dtb  -serial null -serial mon:stdio \
+        -display none  -m 1024 \
+        -initrd rootfs.cpio.gz -kernel zImage
+
+For configuring the boot-mode provide the following on the command line:
+
+.. code-block:: bash
+
+   -machine boot-mode=qspi
+
+Supported values are JTAG, SD, QSPI, NOR.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 870d30e3502..7b992722846 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -109,6 +109,7 @@ undocumented; you can get a complete list by running
    arm/virt
    arm/xenpvh
    arm/xlnx-versal-virt
+   arm/xlnx-zynq
 
 Emulated CPU architecture support
 =================================
-- 
2.34.1


