Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386F6CA0FE8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXW-0001Fc-Vu; Fri, 22 Aug 2025 11:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTX5-000099-5s; Fri, 22 Aug 2025 11:18:26 -0400
Received: from mail-dm6nam10on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2413::60f]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWq-0007IB-W3; Fri, 22 Aug 2025 11:18:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEtr7Kwmuj9Q3R452N6z24MBWwLB2Gz+3w1iD0tIHvGj9vGEisMediaB0VZeGYVQELwOeHtOJeAGrQRzGRfAlfHRIEGJWrzWN2xjMdJlboU8JjJlsyBNhyt2Q5ZEYs/YdOzf4F5FR6eagc8ZOz46LqiBQb3JgyYjAdoHX7kMRTTV4yjL6sbowX/lnE37JZrS+T8l8HRqGYVvBsyG4AtBTv/jfIHTt3FCNj1hgpgoeVdpyR8uB0z5P5vp4XJHPr8iC+ITUmqLK0JvlWXzvaTM4xTJByvi5TVO1OtIqk/cW56zZBpMVbUVC+gcwGOYoJdEWVmvlQC/jyzk9znh4Ek6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/LE4HdhmfZXzyWKS/YZSlEw4Ov9sOTRx7x6dj1mD1U=;
 b=X/nTahE6p0EKBiQYFMC3QJnCwO3N6IsJzaHUP4hyBBlDwPVOeGH/vKIFB+MiJ3wrVilEqu1Ryzl3snr4ktCavzMAIR3KvpGx7I0EeEs1qXyR+wZWYIx5HDFcRlyoGHf9XbXVFN1u3QkXBTbmIAMjRSp4WGnBNa6M4GfOrOIekAkWCe/deURGkYBh+f9a0B1srstUe3DPbZua4p/zRicRjWGkejbTDiER4P7aZj9oSP6HlPeP1HeScbw5dEaxsBcjtlxhfPE8/cpMNK5VWr12mF/ds532sB5AnDmD4XsZXayxdzxt/I7wc4w4Bb1FGhNbkYA0L4+g1jWhhSGCVYM1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/LE4HdhmfZXzyWKS/YZSlEw4Ov9sOTRx7x6dj1mD1U=;
 b=CF+10RODogH1yAIHSz/T8k8vNwuEA3t4oQa0kx/M/a3NxKyQhpDnkS1hEooti3fX4fESrDxL14SHHQPBtXKG9ZJUYtwDEXVdMyx9zYowxLJXru5/lnY2aaYD4dg1BL56HSEi6qfQa/cVmV8POwOFJ1cWL3sHCvMyf/MKr46rUMQ=
Received: from CH5PR05CA0015.namprd05.prod.outlook.com (2603:10b6:610:1f0::20)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Fri, 22 Aug 2025 15:17:57 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::29) by CH5PR05CA0015.outlook.office365.com
 (2603:10b6:610:1f0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.10 via Frontend Transport; Fri,
 22 Aug 2025 15:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:53 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:52 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 44/47] docs/system/arm/xlnx-versal-virt: update supported
 devices
Date: Fri, 22 Aug 2025 17:16:09 +0200
Message-ID: <20250822151614.187856-45-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c54a30d-8960-4858-c975-08dde18f12e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tb/xC244NqKOIqeKKXPOmzIQtHF1czjYE5UbCaYbF+RwHQ7v64s456Hi9exr?=
 =?us-ascii?Q?kls6A41UgRdRQPrJI/uwjefdKWQ1Ieuhs5OWdXrCDGSpG2NgabFYhSXgcyVd?=
 =?us-ascii?Q?wCK04Asrn/0izrRVcDEEUeXi342kOxtBIhGkVDFwQuW/dG+RA1sojYBUOcsq?=
 =?us-ascii?Q?868LJgEBQka7O2hXM+ke7yF7ajnr/n4pY71X431nwqlkD9L3R+meBZT2QEaZ?=
 =?us-ascii?Q?VsO95az6xZHZQmz3eHtD0dkyKzEny2uq/Fb6aRHY5vuKo16PWFjvyHzyX5fO?=
 =?us-ascii?Q?FQBIldfEEU7j2hxqZEmRhIOJ3Ow2v+bo6U+B+58BNbAKiILPvk4VcEIHoOvR?=
 =?us-ascii?Q?/ZY2LBRnySQdbiCULEVsucxcR0EvwIKYKm/Xh1yREgegbf49yA3zTcVOTTK5?=
 =?us-ascii?Q?wUI2P+gFIdJNZgifbBrwJsSO2cFgTMi4xdBFSEmNCYvqxvo5TgKShXONDR8m?=
 =?us-ascii?Q?hiFIyP1N3OizqXzisOV4Bf7iCAM1Kkz1sDTfC2ipRHiG9r7fsduvc09UpGoC?=
 =?us-ascii?Q?bmmByiohE7EG64zI8+740vyffF8wGsyfF16rdKWTRpDgUBWvsBlZzAy37+xN?=
 =?us-ascii?Q?8BDKwQRbyQXFJzJs5zRuPRAHFjeTZ9N8BpERlfvlV1rwGtzhSGDSZ4A7ppC/?=
 =?us-ascii?Q?RgMKehV5N+a5by/2KWjvSZsc1FWWd8PoaiMz8PMzINV5RhPw4R15QRjCiXDQ?=
 =?us-ascii?Q?r3IcFyzaFrldxdiHff0vdnOIEJhGUzFNPRct89FVXcwAJvLli3/srlPi+pdN?=
 =?us-ascii?Q?qmLx3NXCOCrDYcLGKA93EhiaaA1gsbMTZhfm8aO1gaaALxl9Vo8jZgmDo0eC?=
 =?us-ascii?Q?fm08K8fultGwNf9MR4u5nSLOFskXbxX38FD6fLk7gDQVtmS/xvfgCCKIhsoi?=
 =?us-ascii?Q?UXWPtGlz8DezcK1PAZmL3ldliyDwFt4W+1uh5Zv23ecuMiDeMtqz6DbuOTwX?=
 =?us-ascii?Q?JlxdoljazWch+sJA13iEf62f/bGV43oX0sZvIuneG3CFiRTgFqW80IytI+ZV?=
 =?us-ascii?Q?ECDbO0HwXJgiTgVovlv9NVwp1AqdRQunpdaGOgQulUJo5OP69/xU+oaRSsFa?=
 =?us-ascii?Q?0PlW9Lz6m5MLulOx0S41sUReaxAE6R10SJIGjmwoz8mPnucmVqeU0KHu8C4Q?=
 =?us-ascii?Q?rnL5Co0+Vx516sPRo9P9CX5vblqMuKkXcmUTiiFfQX0NiHBHrklXMHWwbaqP?=
 =?us-ascii?Q?RRhtIAqSxYGexfa9U+gWVMHxEPBRhpoXXSDWRO4lYgzwAH+lCFD2qsEzXEew?=
 =?us-ascii?Q?1C5R7dWgyE0WQGfMuTPOFIeV0bxBuv2/ozzbIyd71LjVjNN8YsgzWep9Qtcj?=
 =?us-ascii?Q?q+tRI0A9dHoJR7v05xsuAvIHww2zcLvf+UwjpoWDTUkT84rhtj8E+baCKeHa?=
 =?us-ascii?Q?RcWihTY55qUB4Z17waW5FJKagI5m6fUKH/xblPQ+jI5ysggFE0Z1zrIXPiyJ?=
 =?us-ascii?Q?dBKDpI27QAoeEjvy3oIa98XFIUoHL8X4VJ+VCbio0SLZBufsazbGhBDA0P7E?=
 =?us-ascii?Q?8QCvqjn+sGmuVKjxN6HNpJURDkTMYdJNr+sJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:56.9531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c54a30d-8960-4858-c975-08dde18f12e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
Received-SPF: permerror client-ip=2a01:111:f403:2413::60f;
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


