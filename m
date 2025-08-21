Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA4ACA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up50S-0004CY-8O; Thu, 21 Aug 2025 09:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4zF-0002bG-Q9; Thu, 21 Aug 2025 09:05:49 -0400
Received: from mail-dm6nam11on2062b.outbound.protection.outlook.com
 ([2a01:111:f403:2415::62b]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z4-0003FU-GV; Thu, 21 Aug 2025 09:05:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKr3taxo1sA9gVdv29cf3clSeAptHDX1kevqp2WQestSWlMqBnDiNS7QSTxK8tkJbz9Ry/CQuCjyvUSlOA4MaKLbgCw3/sN2A4boSF/3PG7nMocoXdWVGYQEHMEi4on5o6opqTi2N4ke2yOkJ0Zne2EutF0+WmL7gp1hDpATJroRSnea0wEV2hQofVw1ujOP1WoKangJGGJa8NVGwj92O0syonMuD76ZUjFgTXY9Ctpt2vWutr7I/BPdwrRRkCrOp5wZ10I6FXcYj2sW9NjhxCbtzCZZLdO1RdOqqeuD71lK7t9ssq8gUbaI/xcd7jENPs+x/nsEhOx1YbKZXZcTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/LE4HdhmfZXzyWKS/YZSlEw4Ov9sOTRx7x6dj1mD1U=;
 b=SAeUX2NNziE1kIqbSWwegDvWOq/4Q37r1nTclU5NU+rDJsvMHCVAQHPwOFVsXPoH09HcnPvJ1uh/4Sd+WCIPlY6smrIx2aY4y6FTaBn/NykJ1hXaA3v1hrMvwtwg0ZQGQERXXA4Bu/V6Pv/oUYcpbr/XjCRZxaPqnI5iEBRY09KbNvQOUZFob3Fp+nIVBHqifi4zWyP2olungR6h9AN9a11IaN2qFH/mNikUgj/FlT/sIAjeNXnT1fIUs0e56VvoxsAjhQ3j0VxT523o+8kvIknDQIcHrYAOMbXOt97sgCtI8CBLl9fc5zgsK8yaH2hqmTJVvrmaqWxBRKVg75/msg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/LE4HdhmfZXzyWKS/YZSlEw4Ov9sOTRx7x6dj1mD1U=;
 b=l/dWOZlQdnguJMnveEx1l8AaxMlOwZ9AZq/bXLS5gkbvFgDkAsifZuN0PIjhhViP7kU58XVwmwqk2ZV5wkLNn/oKy0EP3POynktqpb6zAb/H9WTA3fEPhv6G6/jKWIMqpkQVtSEMB2jdUZZ8dM0DSLtbkvG6bj/NNx8BpgSwOy8=
Received: from SN7PR04CA0071.namprd04.prod.outlook.com (2603:10b6:806:121::16)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 13:05:28 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::cd) by SN7PR04CA0071.outlook.office365.com
 (2603:10b6:806:121::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 13:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:05:26 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:25 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 44/47] docs/system/arm/xlnx-versal-virt: update supported
 devices
Date: Thu, 21 Aug 2025 15:03:43 +0200
Message-ID: <20250821130354.125971-45-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 640730a1-8004-471d-3eca-08dde0b366ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TCpO0VXMXXMT54nXi4byFUv42iieNly2ewJAxjNgTKf0xX2fX17MVX0/jQ7b?=
 =?us-ascii?Q?AANGJ5zWtUHkQYAT/FEd24pwWTT3TK44QiROTjbgxwbimrKYC/3M0kQJHuEV?=
 =?us-ascii?Q?xSv/LcY/9mbFBjSgvCURfkGLh+vopTTEtS0qOTsBZhaUOfVbwZZOZybTl8OY?=
 =?us-ascii?Q?G70iLEmGduamBrsl08nCkAaztyqfTs2PnI1N+qIqjCLpCWJaT1VqvxWFfVVI?=
 =?us-ascii?Q?moyu7hd4+jUPoy36tAsrf0wOTcSK3inPAJEcXPplc7Vd4Yn+7cmiSsDhjFsh?=
 =?us-ascii?Q?uCBmS49Ho08tyXJInkdHAfEevgPIDikrEZQN9jbUEgIazQHTSrculRpcBLyx?=
 =?us-ascii?Q?iViTRk1Q6lFhBVdxPoVZU4LzebKjTSA4hykf5MzEFatE8zQSxmcHcSl3j2SZ?=
 =?us-ascii?Q?MDOvOOhYeRN1Q23p3W4AVGlIGVqaFwazRnB2OqVWbzSs20FYJAghrSNmrbfc?=
 =?us-ascii?Q?DT65AGAd0ItflWS5WCuz/xvZL9YAa6xklbIPI11BCZTMBMrqpUUAdXRP9Y1e?=
 =?us-ascii?Q?dAmW0pnKWJty0eKOiC2H9traRxvoEeGYQQrnnu+LkD+hj5etiTRSSpYLlJyG?=
 =?us-ascii?Q?GmhPYSTuEQukreEpFCzZWMQPrOtFEi4/Dqvmg+9MaicMda7x5omqwPPiqemi?=
 =?us-ascii?Q?+9H8QHI6VJeAbImlAriwLjsVoV4a7uG4iEqK/48zc9xuyTyNUL8tNRbLSFle?=
 =?us-ascii?Q?wsI9OLd7FK2tpU/D/xnqeARxYDEeZXdPsPdnDJQ0l8nTIvR1YikFH0yftKiE?=
 =?us-ascii?Q?fy37elhpL3o5Gx4KRb2uQ4Y/ylW93RzE4w83MJHZCLSQ4RtIYwJXbK2g/F5K?=
 =?us-ascii?Q?vDoc6JHS/2heekNMVXcFFsEnATIqACoyAkjh5jRhmy87Xw3YtTzUdP0p/wOY?=
 =?us-ascii?Q?6ONAFFIsBTuFEYvAKFbHFXRuuGVBzliN67n6c1En0ox4vU7VVc91dEUAvuTp?=
 =?us-ascii?Q?d+J9VtBiPvRPg5q4koZHtAKDzHDaxFNlT1ehTpATpCW0Qh99qTlaowWdMVdS?=
 =?us-ascii?Q?ZCV/iVZ9hTpCkMaUxQsL2Zk1uydFqphWIOLjixl5I2dmburp3yPlYxITOgtQ?=
 =?us-ascii?Q?FFCPqHEP8IsyK8lLutjZgONxvkoy5KgqomC07X8UR7Du//fca+56BnG8T2TS?=
 =?us-ascii?Q?QUCEj0Db2mbHzsdGhTdD30VS0fP+rgBUpAMEYw77gcRhnAE/Ogut0NFFZIPa?=
 =?us-ascii?Q?PtT8EUIBZkAv7ezBay8Q34htfpR5mNpijo5Tj71zQmLBTjNf/RGIsriRGNEB?=
 =?us-ascii?Q?/06s/GN9tbInN89vvPoMIPZEiojtZ/R5BRVfS8QJKZ0dhSU/cN0PcAkyLFKc?=
 =?us-ascii?Q?3HzaCMe6S4u2+30I0BoInZoA0NOiCSmqMqHX6bv1NnBIgMamnLUYdYEeK7qd?=
 =?us-ascii?Q?XLLmSVgBNSmHEkgncf24Q62kBQ3tM47hTsdPrPA9an3bdMouUJUajDGs1C2r?=
 =?us-ascii?Q?NILaBIxAKNQkfUQvMrXAs9HvJuzoUf/Xx6G8EjivD3ViLpi/HD45I1XnE1Qe?=
 =?us-ascii?Q?oxOJ8JeL5VlpHq4iQOqNc0OzVxcDSMm/2Mf/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:28.6549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640730a1-8004-471d-3eca-08dde0b366ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
Received-SPF: permerror client-ip=2a01:111:f403:2415::62b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


