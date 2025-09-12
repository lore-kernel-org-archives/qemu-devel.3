Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7686ECAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eM-0001Xe-3r; Fri, 12 Sep 2025 06:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0d4-0007XN-LT; Fri, 12 Sep 2025 06:03:52 -0400
Received: from mail-mw2nam12on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61c]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0co-0001P5-Lf; Fri, 12 Sep 2025 06:03:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha7Iy5Y7TNQ+webktMy4JR3OHRBvTRZNfucTsVQiMA6REjnr7/uhlynMLy+iyYQaUvuWi26jSIV3Kcl+HVg1nU7yDCOtLbgMef4i2LlqNNk0otgZ1wziXo9cINkMgLsn+PUlBd7XE4nxO7jG4NHqPCt9NgJC9sa3bdXaVJgI28PbV8LK/rQEsCf3kgLeeVPROjYgqHODKbX3uaZYRK57R+AaLO9l//Gv0aOjzqGYNuC+5bM6dPpxeLH5Gg6oamBp5fVnKOzjSYcXp3kPy6iWDERUyT6X1/l4TWTdK/07LEOa8xWbbNCr1HfmSE1o+7ldG3DfyjFSjIU62afdLRNE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/LE4HdhmfZXzyWKS/YZSlEw4Ov9sOTRx7x6dj1mD1U=;
 b=G2nQNyfHgjYwvM7SU5Lchk5mtkPS9q9WWX75ycffUkAvL1483Zq6k+e3Qr2Q1DuYTGugXih+zVUfW5x+6E7hT8Zz8sgfpvSwAaVdWLt5+tLW3CQlM4+r28DjdtctMM8FQemtGMu3UJqquj5WTUPSxw9MqoKNF2clAH+ypHXeLKKrZ+mfTG2+mr6PZE6U2ie9nJB2wRbbJoeidxz5gzxSLJrv8+9wUnh+HQKeiRNTMDKePMmAwpcjqAGoTWFN+pAGEAfdpf/aiShd8IbRX6Kq7PfQluwc7jiXAty58rd+Lrdr38/X9lFp35RLRvGq4pUJL5fdwsDm15IST15hxnwPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/LE4HdhmfZXzyWKS/YZSlEw4Ov9sOTRx7x6dj1mD1U=;
 b=3aFVFBbsv5GPhh+YkCsCWO00xPBFaD/PtVlYp+1D+OVyU2mavLQqY5HfWUGWFh8Ih3dVPPV5/lDOsegGSny3m5qjBzuFki8ZAdzvTz1e/sn8Q4lIROq0s/984B8FZ2Sj6m+bZ5BMANpBj1kfJqn/GLnoBhU9Q3+X5GC8OnsN8LY=
Received: from CH0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::24)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:19 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::c4) by CH0P220CA0022.outlook.office365.com
 (2603:10b6:610:ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:39 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:39 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:38 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 44/47] docs/system/arm/xlnx-versal-virt: update supported
 devices
Date: Fri, 12 Sep 2025 12:00:53 +0200
Message-ID: <20250912100059.103997-45-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: c7edaf8d-e42d-4605-a5f0-08ddf1e3998a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TKgqlww6xhn7B6TZP1/vnGdxe8rsp5I6dbib3MZozOzES+YIjGGluooIZEkv?=
 =?us-ascii?Q?9FXwf7h/ilNiIxJCNaUmSTGxXPao33ljOv48T4kaMQ3eBfg/0ubzgeJsy6cB?=
 =?us-ascii?Q?p0WAY55kLLbeyC/82DrR/9OFVuTell/x2YccMfBadmTrfwRZWqvnz/anD4wn?=
 =?us-ascii?Q?JR+T4bzF/lsNj2j0sS+8lVzfLfKcFmAetg3Ubf1fUdRcPo4j7Kw5LWFszzYo?=
 =?us-ascii?Q?SZ2ltIJV5p8ysc3IjxguCZXbX0HFCaAkmMLtltw2MjT/+BtocHeYoS17o2G+?=
 =?us-ascii?Q?g2jNPmj0kFRltvWSBZEHVR9IPM4X8RN9vqts1kVMeOI97g6JpfeIf87+5OBY?=
 =?us-ascii?Q?QQ87nlpBrouG1uwW55OhccHCrPasXJqIXfx6sSfArINtPeil6p+u1FdQ+cih?=
 =?us-ascii?Q?lMMd96v1ZkVTreGAdEjnSXtK06b/xi6GwRw+03ppxYK+AWnuk1q9nPi8WK9N?=
 =?us-ascii?Q?5T5W5BtFlEDTN1/LsvXcLBVlnUdzVVgXzlHX0WN0CMa/cJgFh00vHmifh2G9?=
 =?us-ascii?Q?b4oe491EfJBlQM6JkOm+s1ESnjpemNrJ59ECCdkzgvfwbCeZ5StyoIsWZewU?=
 =?us-ascii?Q?eW/pSrrFvpWEK6QIoX1r+t/wHNevWaBqIU+bQE47IZP3nMCWUPZ+LG2tAxDb?=
 =?us-ascii?Q?5a2MHBI2e+tOvu1wuWVytii68l5DiYZGnx4VF/as5ZW4ViO1SV7QDBEW9oPf?=
 =?us-ascii?Q?8ijwiv/VEheSZ7rkwRK5F7uchsB9Yf8q2IrMv39wSoCXazxdJ1KvsYCxutkF?=
 =?us-ascii?Q?zzg58Fpwr107SlXxbLJD7Rl2OUxNjhkllvLOvXOncj2/9pNsExpES7LMQW/Y?=
 =?us-ascii?Q?YTMRBe++akJUjfJIdndkTYAH+BCaOaNeGL7qOzYY4KANEFV6gjHLnQYMS10a?=
 =?us-ascii?Q?NVoMf1wrF4nYpDgvdsUY93sxYUaM3NvP+Wg0g4LzAoaxu6g3yk1TL+ldPMsH?=
 =?us-ascii?Q?Qzvr/EQyWIyqmvDQWPxpEZ6u5wLzHw4dE5df0aP2KmeMig4Ey6x3onC5ck+T?=
 =?us-ascii?Q?eDXH0g0pbXjWJ/y1zTvLaxJ4i9MKDOck0ItePBJL4lGF/dnreRP38B38BtpP?=
 =?us-ascii?Q?nvQQe8CjrU4mRg+5LzmcMJZ7dGz58GCt000XdeWItiJRnbA2vnv4yUfx33WL?=
 =?us-ascii?Q?kaWem5Ny49DnaKZOIOT60SuTVRwH3fN9QDK3FUg/iYADR3HwSB/pcPG+oUqM?=
 =?us-ascii?Q?vzQZj8NBGIQM0gyDZdvknve0eSCFyYpYhzC0uH92dBLZSXNV7o9B/k+M5O0N?=
 =?us-ascii?Q?ui6/26YfWuw5FH7y5kt0AG68p5k2D01x7BCDfeclcEUiXvlKB2qjVlThC2eS?=
 =?us-ascii?Q?MlmlzDO2SQGN1dTHbjF3a0ubt2U8eBWv0mZhFln0+m9ZQLiQ5Osplt9O6KSi?=
 =?us-ascii?Q?eRu9Fe257y57kExbCukD1ypbptl2CD9LIC9AS/x7aBZnS1OrecLMbDXcRhDo?=
 =?us-ascii?Q?BGAYc5YmAKrLUrhQH8tA/HAfksIIB0vVjIEajI3W4CrK/8TsdWwunWt/IxSq?=
 =?us-ascii?Q?2hIkohFOLOi/Guuj7uAodJy+PhRXT28f6aJ1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:19.1545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7edaf8d-e42d-4605-a5f0-08ddf1e3998a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
Received-SPF: permerror client-ip=2a01:111:f403:200a::61c;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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


