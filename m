Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7532CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22dZ-0002ss-9n; Fri, 26 Sep 2025 03:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22b1-0007Mm-7v; Fri, 26 Sep 2025 03:10:24 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ad-0006mq-Kb; Fri, 26 Sep 2025 03:10:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBfQwx7zFZALT6Ss6c8bXm2Wj7aV8iLrFVMstHU9Uy7q+JPN11z0XQeGRkkffjYXo7ASCIFe8ysNvrDrJVXwoxotIzpsHAo9VmO/6dcoqCvUKlBPw6J3jvTC6sYIOtSYevM7nwYQ8y/imcKVR0CqCygKmLj063sQbjQIhxBbDvaDcVpJv94Dc3JvH6smfba5p/vSAH7CfanTLNh33v8wM4RoBgeOYI7+WrPnM45nNq6vxsaPbB/AiTD2SmcknwKXi53bJL7I58YXwdQRqKdBu8qRKBw0TI0QnjVzFfBlgEMN9nMAAYslogDcf0HfjHGKRgfTrHMt1B6zutPMezy0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiuYzcoojkatiwBqDcFFnB5MMxOvv5CR0v5LbHLvfUk=;
 b=yx6VUUkyaSU36cxTkyH0G2X7ZzzSNliYTnTrpVLMwudONtJlUp1tpYdq13P/dkuLWgq98bLgD+enIIyIV94zt9XCKBv+FwVmecpsIhKE4Icaid5/5yrUgeSHpxXJk0cl+VvAoMyTh9q48XxJaFYDq52f6aGUL1Um/GqGfva9hAbZqQLDYoGK4uX2CiMUIM/uSpHvHpEiLM1LE//o+ceIm3Fl+IftNw6YGpCdcQsfDZQRJE7W8YaYWJFXFqpmC/3/1rMTvpMcROTi0mwIYcCTrsUghS1qSD9WkSnHxyS7KOCgE/42RSUAMq1/tNvpoGjjL9BXmgQtXG5QNKg1mmOIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiuYzcoojkatiwBqDcFFnB5MMxOvv5CR0v5LbHLvfUk=;
 b=0ZEUBeL6ZySbJXP1Cm/qCo1ML12gBZxuS3lEwF6BwBTwYuSMRqrZxXT2p8HkxEkAr7xHwm+iUs3d6ZWycaKktE1PSOhqq7COXChRLtzWodB2zWfJBGWe1CLPG8ZLW7vx4/F6NqsbSh/dpbyt04Km+O8KppFp4nHtygq2/UQkZos=
Received: from DM6PR18CA0029.namprd18.prod.outlook.com (2603:10b6:5:15b::42)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:09:46 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::33) by DM6PR18CA0029.outlook.office365.com
 (2603:10b6:5:15b::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Fri,
 26 Sep 2025 07:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:31 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:09:31 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:29 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 44/47] docs/system/arm/xlnx-versal-virt: update supported
 devices
Date: Fri, 26 Sep 2025 09:08:02 +0200
Message-ID: <20250926070806.292065-45-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: a95c8e75-8315-47df-be3e-08ddfccbacb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oNVVgBvx8PMuY+sR4WUEqEAex3RulHsg3hEP4XiCa3/TTesLu/G0LiErHNXy?=
 =?us-ascii?Q?j1bM/fzO6ymHsKp5x18Ptu8kUArQH31l+Oy6xlIKHo5s2OTSafjCdOviX9zG?=
 =?us-ascii?Q?XcpGF5lOSWStSmKaARu5XYUUfrfMMk3hH/mTBiE/J7zXcap6jd2nRATQq8I1?=
 =?us-ascii?Q?r40f/8FE4cbNq6gIomx8MFNVRewwVtzsJwFsMdoRt5QKVASHTjbW2KfRH17u?=
 =?us-ascii?Q?+1FnhdPhofZmb1joRM4zcfqeTjtH9LI8ofsrfWORQ5JHyd3U9h4mCBjh4LiP?=
 =?us-ascii?Q?ocCzAaeYgMar1Q8+eFxprCbP/82mJfAj6lJJb0UwB2Ms3dTrzUZplzLmxpQj?=
 =?us-ascii?Q?CFetNxSG5DDcEkvUB0rmASuMEkI9fawj0gKjiYmTpns6Njmz0735H8BbgGqU?=
 =?us-ascii?Q?XxDNxTjTRqBuPuHqDqvUsDSi9dDzNsBFIjuSd104cBYw8xv+ta6gOa6DFK0s?=
 =?us-ascii?Q?h4LmGClQUTlqjzyu4KFWMKzeM3r3P/sv83lDZwZigphjLdSIpF9IsfzBRz8z?=
 =?us-ascii?Q?+fEhdQIu1cswO+XZNyGiuHpZ8xj3suUH73Do/xzLSywk/Yslpqgt4jpFKvas?=
 =?us-ascii?Q?/rsMOVDzPfJSEu2ENNUlEs1V1UnTujOTUrpCpUyDnlxb2LchE/V4yb9XidUA?=
 =?us-ascii?Q?/d4gFJ2A7lgK/uHf6SRdQyHAN/zJ2oGjrRQDdFuG9QTg5VFIJE44G5sH5GGq?=
 =?us-ascii?Q?1KActVv04Xa3oz1g8I8YjakBTq6LaNqg8vcZ+FnSKXKbNN/BrWEeYgZxMjqc?=
 =?us-ascii?Q?XZvkwWxdRwzHxg+KuLhTethiPoKEblvh4kOHF3oqasV/OvvZbYp/jZwn6FUy?=
 =?us-ascii?Q?sF/LXEFOc7nDVXHEu2pHudRtbe2xOOgi4LS4BlLqY5jEvf1Ifu6OXaVLd/ox?=
 =?us-ascii?Q?3cHxC/UJyl5WJR/aVSA3zYTuCDPi1BxP3tu53vJiv/r1Fxvd3KoHj5bFjxd6?=
 =?us-ascii?Q?raA5jJTU1HKSCb/KE2vkjgBu7v8Uv7917nwf3HxPPy3rQyUjFXR0NtNMGah6?=
 =?us-ascii?Q?OCRwaE6wHkRj0Z9ioPkelIf+zbXayBTacWwErUVTzoZ0aASJTX5RxQVG2ocH?=
 =?us-ascii?Q?4A26hksRsbUiasJsNSocDJ6IxQtSxinadLRz4LxF8aUrgUAgPJ/IuaZvQUwr?=
 =?us-ascii?Q?ITSg3p6EfZEgluhJiQ5RcmllAWRyKA0vmGMZWiXuKsv07il4uPFqx9o4BBLj?=
 =?us-ascii?Q?/yPltTzvw6z2+q/iCbifPZ6plhP4I77uaoW46RG4nVbKzFtX2izwXMq63hhO?=
 =?us-ascii?Q?79uYy35T2zqglLg+i0I1kcelx83TAvA/d0kLM+AVmq8w74NN4aUM6GZjJwfB?=
 =?us-ascii?Q?VhxcMcYMnNfDZywf3k0Q6tzV/SSPL6o7DEODJ7ECQpsKyZvsH2Zq7SeDkMlh?=
 =?us-ascii?Q?MUYa/c1ImTaOE3UVXgHayPOXlD88OuIh6JPVEsncq6D72iq8llFkVW1Wm5Yh?=
 =?us-ascii?Q?kd10l5p9a6eBG6zKo9XNpluTr6FZWMrVKSDegAdV/AxnxDCNFkF+QayG9All?=
 =?us-ascii?Q?7HDseeEJuHgfp47Wi3UwwtTuABIHp+C36J+/2AmTztzUedbeG5w+xPWc5XF7?=
 =?us-ascii?Q?MOrJz/XB635zRIzcgR8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:46.1505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95c8e75-8315-47df-be3e-08ddfccbacb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=Luc.Michel@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
2.51.0


