Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF87CA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeBo-0000xe-3n; Wed, 20 Aug 2025 04:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAc-0007PO-3a; Wed, 20 Aug 2025 04:27:46 -0400
Received: from mail-dm6nam10on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2413::626]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAZ-0001AQ-Ic; Wed, 20 Aug 2025 04:27:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2Ql6B9ZmjvKKG1AnaeHoxhWBwLZkiNrWYn1Pyunhe38JtVC+1HZScmX0tDfCvUiQSGDTQthmWZYoLsWXSDvQ1VVPwiWoSd5SmU6Q2AEpzHWRiC/N3i2WuyVpRxJfY9/DnwKRSPYFDhIEkl2tm8m5gEJu/88F3XQWs65W8lwWg5BQsOwuRoAe0Q9V96jj5Tr3+6c5kWDiEr9/H0F4z6kq3zlpG7Sn/zB7TyXgD18YBpOIekSqgr/0SjvTlb7lbgrLN9CJVNcdSB5MLCMkPzSuohuxIftfxtAQSEJYmaXzR/tE52AORpKQjzS+Bn7mfv6UplhwxmS+oolGpVjv4RShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/LE4HdhmfZXzyWKS/YZSlEw4Ov9sOTRx7x6dj1mD1U=;
 b=rufCzE5Q9dkAjOjSIq+5SrvY5UteR8tnzGgK/1WjKy8OLCDKZTQjqTZt64sAA/yUL7n8sxWdCBr/Qd/17v2QVyMTrOLjc8AeqEE3LR2pgYfRgERptf5B4sEajWa3lCgBCIBLn7TkGvs5L+a6G2fQEed4KlDxd38vJ3DagbD3GO3O1c9R+EvpRz27oRbS4pLK8yjC6ukyaxz2IbGCGMXgJfObOUgZ10eHLglLtmpHJa8Iu7tCbk3se0LZFbHW1WgSrU8Pv7NTKeFanpfwusUiGl69ENr4eeCAvd+6j6DNJqLMvP1nYC6ieinEWRsN/OJv7beTDF9zDDNi7tr5XLQuEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/LE4HdhmfZXzyWKS/YZSlEw4Ov9sOTRx7x6dj1mD1U=;
 b=pWcNypSSg7foXJTWNqQpPccWoPbT5X+tz5sVB73F7LcBT/E/V2NRXlFDf+zl3XlEA5exx2I7McnzTZPRRoun9jwTwRIQ21sOXWHoHANyrhr9YB+FlZdWRDDIW+ILdbuC2n2xKp05QfzQOXTIjFgNyCoPpLleTobVW9QJXVDv5Ck=
Received: from SJ0PR05CA0160.namprd05.prod.outlook.com (2603:10b6:a03:339::15)
 by BN7PPFED9549B84.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Wed, 20 Aug
 2025 08:27:36 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::ff) by SJ0PR05CA0160.outlook.office365.com
 (2603:10b6:a03:339::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 08:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:27:34 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:33 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 44/47] docs/system/arm/xlnx-versal-virt: update supported
 devices
Date: Wed, 20 Aug 2025 10:25:43 +0200
Message-ID: <20250820082549.69724-45-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bc646e-de37-4a90-65aa-08dddfc36add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?erOjWxzm4ltgxmblClo6k3xQAdM3dNQYKpO5d3kp9hqt6BqvxZ7d9UibL3gR?=
 =?us-ascii?Q?dX6hbO1Mt70MpF1I2fzlsJH7RnsGRFhfhaUSZJo0zu28FflOsLhvwj+W/DVq?=
 =?us-ascii?Q?wOk13gEw0+BMvMchyr9HSoe21h1cBqq/YYsrt3zTmKs07Z0lZ8gnmFGCSGL9?=
 =?us-ascii?Q?a4bo8l2rV0H6PRuPXQUi+KlNTcnVpM6r5V5l0GnVxnGR/DOxYZ6QIy5Tqn2T?=
 =?us-ascii?Q?rPWaODHJvyuCFE7FkvLOfKCoyQmWL8MUQJKlzs9VTwJqG2s8Nkc98ntw4aYh?=
 =?us-ascii?Q?V9m/Zk8Z4U+5OGeqXAdXBNVrQZ0oV0ZbaCDvwiOqmdy2M5vkp2EZbsFScWpR?=
 =?us-ascii?Q?C+BmqVN9iknjfe4N95/DLoIbLyY58H9SNZcL0ZV0L67RFsmpuyGB0vfcfoO0?=
 =?us-ascii?Q?V9FvrX9w6LI1NHS7+qX/wD+tcSXLEGRbsbO42N5nVOQXCw3zJZVNHi/rUxMr?=
 =?us-ascii?Q?G1GwoG3IRyP79oQHiN2IJF0bCsAWsyEa2adatJGQYjUwE66r7D1FdkhaAKwE?=
 =?us-ascii?Q?B382A7w6QagAp+JLJFtpYQrH/i+Avc+g9pFgomLXtMxD5Ly8yGkZFawA4FcF?=
 =?us-ascii?Q?5dpakGQx53rWPYcDZz4LqMTpC0rbqevLTbBHD3nxzH+uCQVHgxpp5u0cKHs3?=
 =?us-ascii?Q?5QlP4LYDA0NBJpYwjQHRWvOidhnxO+zqXsz8qnHGoDnlbeub5/p4tHViSKni?=
 =?us-ascii?Q?qzWkJuYxAK0wQwc/YsUyVSBN8PqE86u2X/CLiN8dme6n+hQLNMS01hwg7Bcj?=
 =?us-ascii?Q?boHHwcpu9D+dtka68iLWLpRTM5Gk7hyPYdp4kI+Gd5LmlOEY7NN5uRKRU7LM?=
 =?us-ascii?Q?QsiLePYMdIMMTcPL4FEyJCKYogkt92GxkrWMMpxwDIf9fa82l0XLdICJpjvy?=
 =?us-ascii?Q?YQCFpjSr6SYtS+FFRUnD+650htOYIiV0BsBY8NcPZYNIA4pzBLKfGTSns6zA?=
 =?us-ascii?Q?f/sAro5yHW+xr4e7W7c2chmrPzZJTTXFYAWX9tkqW20bxhltIeNT9Y0JBLut?=
 =?us-ascii?Q?qZJUF/IjgVIKc7pDEvcb6lv/SSnuzvHbVIznLKAgGgBl27nRg40syE8plYQ5?=
 =?us-ascii?Q?r4Nbjxvdr4rIPJ7k5l+/T5GEbnJwDcL8N2pudaoXA9c3Cm9kLQqXxQxclb4V?=
 =?us-ascii?Q?i7+xamp6CY6Cg5QiXQAQWDVyogxxpty6v9TKYZF7CBabuUB4sdR89su+qdQJ?=
 =?us-ascii?Q?XpLh3yt4ifaTRIihz3cMQZ/RNWTUWKxILBiusNoQ0BQJtj4+jo4opZ0qGrrW?=
 =?us-ascii?Q?On/naETtVzrWUJttbZTTbuFABknsWPG/pdmsVP0MGxfQHgxT6316MyztHyET?=
 =?us-ascii?Q?NpiuoR91bENuVhL+n+WTmcHRymqMmRWhQD7mR12A6QKlMwIOMxG/0IWh+27q?=
 =?us-ascii?Q?GSnJNRrobld7u+IlnN8Hf4f945rR1w7UKtf1ZFFKsv35R2dt1JdVvxJ+QFRG?=
 =?us-ascii?Q?gWG385C51Vg63fehXKQ4wLtI5COv74OKeGHBmAQYwpGIgVwHX9EfUp9bgRlp?=
 =?us-ascii?Q?gjwSItOMad9xaM4ENt6tNdaKRO+Aw+VsQDlu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:35.9643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bc646e-de37-4a90-65aa-08dddfc36add
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
Received-SPF: permerror client-ip=2a01:111:f403:2413::626;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update the list of supported devices in the Versal SoCs.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 docs/system/arm/xlnx-versal-virt.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 2c63fbf519f..94c8bacf61a 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -21,15 +21,15 @@ The AMD Versal Virt board in QEMU is a model of a virtual board
 (does not exist in reality) with a virtual Versal SoC without I/O
 limitations. Currently, we support the following cores and devices:
 
 Implemented CPU cores:
 
-- 2 ACPUs (ARM Cortex-A72)
+- 2 ACPUs (ARM Cortex-A72) with their GICv3 and ITS
+- 2 RCPUs (ARM Cortex-R5F) with their GICv2
 
 Implemented devices:
 
-- Interrupt controller (ARM GICv3)
 - 2 UARTs (ARM PL011)
 - An RTC (Versal built-in)
 - 2 GEMs (Cadence MACB Ethernet MACs)
 - 8 ADMA (Xilinx zDMA) channels
 - 2 SD Controllers
@@ -37,10 +37,13 @@ Implemented devices:
 - XRAM (4MB of on chip Accelerator RAM)
 - DDR memory
 - BBRAM (36 bytes of Battery-backed RAM)
 - eFUSE (3072 bytes of one-time field-programmable bit array)
 - 2 CANFDs
+- USB controller
+- OSPI controller
+- TRNG controller
 
 QEMU does not yet model any other devices, including the PL and the AI Engine.
 
 Other differences between the hardware and the QEMU model:
 
-- 
2.50.1


