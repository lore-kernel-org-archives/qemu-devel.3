Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BDBC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubytf-0008NL-R7; Wed, 16 Jul 2025 05:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysQ-0002Kw-VJ; Wed, 16 Jul 2025 05:56:39 -0400
Received: from mail-bn8nam12on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2418::627]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysO-0006oZ-VY; Wed, 16 Jul 2025 05:56:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWpS3MsVEuVzt6hLws2FX0vU01I/zXjhnzcA2AjkBt+hddfVl4sVoWipncpPDFulccUkgvu4/gkFhMm5/rYZcKltk6DB6gsg34Kq3rlAxDBm302G2PaTiXBDs21UdUDROuPv5PgWQlEBLrmJx3VX8OQwr98GR2WJjDxsqolCwBaASky0tJxeq53ipJ6a1H6r8gwQdReBcOxi9u1cDHN8IuspeUqNuezCkP2vp9FOhaIDi6X1vJy6ut8bc7+8FNe4B/lzztQe+jZHAJHhjBDepqi73z1heqARO+ENHMV8kXVtNdD4pGcUgcLvxoVM36Dmn67YpBKy9Xa2eKSVZwXExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT6eBGQOS2A0zrO/kp4GPCyk0ClmRNk9AP2itKJ5KXs=;
 b=smISxQ7YLf5Y6vziStP/Pnp+6KWl8pztii38ScUX9XaAzQhudfWRry/r5TEzaYwm/XVZVHNWAnJur3CU/Mh8Bcz3uYMgt8IfM73aa5PIjooYjHcwVKAfbyaVX8YnjCwIQLE6z1Ggk9PZGrr6B/8VL6vAvY0Zh6hS2jSWg4QQC+mJeha4pj4boawRKZYrSsvp2w+FYDU0GBnUAdLkCQq5drSrF8en7dCRzlDw+sIO2ZFR8K0FiFUIrxZjW0BfjZYETRkF9RA1Af2xnMv4SHPH3P982PjJ6TSnxVuZvOb9PJWYhLw5bqyIP1degL+MVXDZ3KYVX7CgSXLf3rs/j48E3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mT6eBGQOS2A0zrO/kp4GPCyk0ClmRNk9AP2itKJ5KXs=;
 b=3y4TLO28DBFdm42AiPOFddNqbeZauuqsN8GH8CdyaVtOMJJ5XHM/9e6jJ721LzF/sJMiQ4GHETcnTGzWmJGjMOLGFEuGRJVzfTkqM+8uNn6Jo57kJoMMXP0wHl4HVMTwJYr8/RBnMJ3b63QHAdOB1qA/cbtcGRmAL4LhH20lQxc=
Received: from SJ0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:a03:2c2::21)
 by DS5PPF23E22D637.namprd12.prod.outlook.com (2603:10b6:f:fc00::647)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 16 Jul
 2025 09:56:31 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::dd) by SJ0PR13CA0046.outlook.office365.com
 (2603:10b6:a03:2c2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Wed,
 16 Jul 2025 09:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:29 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:28 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 45/48] docs/system/arm/xlnx-versal-virt: update supported
 devices
Date: Wed, 16 Jul 2025 11:54:27 +0200
Message-ID: <20250716095432.81923-46-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DS5PPF23E22D637:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab5f930-6067-4391-740c-08ddc44f0a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3mgNdv2z+NlwibVEh2PBR389Q4w8R7k+IfinoOChboF2YdHF/cOVJ8VylPfx?=
 =?us-ascii?Q?tPRdat3x/Y4KrKFEDPK5oEb/gI242vp/loEOtfYx7NqudgFqL7EBoZ5mRNni?=
 =?us-ascii?Q?JinZLFgNfn4+Ye5a+/oiT/1GpfIYsPzQRFUVKBemp6zP+yEIVf9tF8ix+zhO?=
 =?us-ascii?Q?7hxRHKP66UpkLsa5FwnC/pdNcjEOCL6z+p+PJ63b4S0AYBGpjtrx/fAY6rEo?=
 =?us-ascii?Q?eefRx8XOKCc/05ERbuVfwpTUXWMwlHBZtLnWUnP2EKQdW4oeMUmPFesoa5fB?=
 =?us-ascii?Q?ZATT7CUmYU3OUIo30kyG2IenyuFZjbSTXywyoHkcjEl8WWpgdDHnO9IZ4g6Q?=
 =?us-ascii?Q?vpyvxLO17TcG85cPtVVe85u5z/VIiHjDIjApZwXFYsd1hH+tCJWAZzE2RjsN?=
 =?us-ascii?Q?M30dARNu/RPN+CGmDvJJP7/IYnoMjVSpgLqn9e0HU7FvVMnWepA8pCjogFSi?=
 =?us-ascii?Q?YOy/SsfnKwIwX39XADSnoHdvlWnqTbsJfoepcLEA9AaNni3GLpXchevjaoj1?=
 =?us-ascii?Q?QrPwoYVwBeABaRHRYQYmf0JTyJC/wmydOz0Egh4hw3bEua/zlaFDJdcm/Ez1?=
 =?us-ascii?Q?Py2mwUH9jbv15PRHKksgekXy8WkYW43lRfsh7kcn23AwFcy9KKoOyqTjNqql?=
 =?us-ascii?Q?m8+YNv+wgU6XKDX+V28CrYq7c5/M71Ez3oaL/YlOhnVo4detlkwow6Zep448?=
 =?us-ascii?Q?h7OEfIlKX2Mjb/LyC51Zp8x/GKbHZpjRWUPgo81MNORPjO8kIasD9kNARhlh?=
 =?us-ascii?Q?+j4qinHH9uZgRpsthxGS2Dz73cGiBimFsJ758exieEfe/EwWYGtEsSiDLvnH?=
 =?us-ascii?Q?iodchbqyWD9SUs0mCn/WLND7s4o1dYNVBo3EPFRSRjbCumBxX6CjQVvS/hZO?=
 =?us-ascii?Q?bR8yE/6lmHgRozf6GN81hdrgRb6akt4HekV5fBr2RBTARQL0AUUvLHxTdr6M?=
 =?us-ascii?Q?vGVDIO4ekyw43ddYr36acfdp0KT7t7MgkELAeJObgRImypprmgKKdgeMhJqG?=
 =?us-ascii?Q?vrhaofoBtgfNvdPHN/Iy9s7Soc0Q+uea/omAMt5RwjBDdCeAmFdZ47sBD5RE?=
 =?us-ascii?Q?UzTm879egcRTZsZoqwafS8GlZnzv9hd0HG38v+mr/N4LlozSTobUFuiP2kW9?=
 =?us-ascii?Q?LNnWfsF1OFb/5a58cpFOO84OiohmsizqXBAEqntplGvRmPohL+2QqX0lHe5R?=
 =?us-ascii?Q?6pj9nyAtrghvNnFNVs/E9WDp8mz2Gqm9VNpE6Ay2v4aQft9YX9ojUWaqkORp?=
 =?us-ascii?Q?ra5ZZ3m4s4J9XFjQHfMqXyJ5LFMzupNuRlyqu5RZAJqTK8Rg1/g17PKD/Ayz?=
 =?us-ascii?Q?KIxmXpve4gAhxAbwljrpZFJqIKiqzppR48t1AeLaTPMn6igsNXvcFEf18TVh?=
 =?us-ascii?Q?amGeaY00LC2IFhEOibZ+jGJOMng/WLoYuT85t4WkYoH4eUw5jDO6g4GgmHdg?=
 =?us-ascii?Q?0zWyRKA4dfxZfkq0m2UuXChlc9wS67Lgz5+KOZ1NJtFoNsBIkvEhW6yn7O5Y?=
 =?us-ascii?Q?OSGuzqw6gZmMIluk+haauW0G8XTXGBxotbp9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:30.7746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab5f930-6067-4391-740c-08ddc44f0a33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23E22D637
Received-SPF: permerror client-ip=2a01:111:f403:2418::627;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
2.50.0


