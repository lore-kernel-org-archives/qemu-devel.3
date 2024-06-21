Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3099C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdrY-00012U-M6; Fri, 21 Jun 2024 08:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKdrW-00010l-Fr; Fri, 21 Jun 2024 08:59:30 -0400
Received: from mail-bn7nam10on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2009::60d] helo=outbound.mail.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKdrS-00011C-RB; Fri, 21 Jun 2024 08:59:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTDryLaKGLnxND3vLgBvWEacS9xsq8qVZxjVxNjUb8TzTy8jAuNdHJg0SO4h+FETvURsuY60hxbdXA+TybKNIb3336H9ArNnOpXqfDc5Vqskqq9JxPJS/bVouJjb/b6ev3k2LI08RaPiFqYUC8RvLyY5U13pIyeJo01vhQiKTxMXH9KfqK5QUMUzHYugHPRbjDa60ahtYOK0kh4uo6/YsBWvYFSgoBmnOoduvdIraW00QmTT/MP+4HpqticiIK8q2WorY7QtfgDvmpHZCIg0TYUZreDSrmdsEoFYgIq2CzEuh/WX3nW6s8S/lqVusATNgmrBArBNeI6hiNoLzMY62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W0eBB2admDx5I+eZSAmoS7l1ByXBREdjB/4M0MzeN8=;
 b=cCQHEB/2iNChlgyxklglvojLwRLF+RjlaKqVVJEnSfAV/ZvdWmbpD3Gxq400D+KbXJy5N2OeoetVMFNPxleN06ODVTmzzo1ZImbgbnlYI5keKIyhHEcyiGZKF492islcK9wa0gkexB/Xiiksldib/ZlSyu6cqj7kA6chujOgxglFnIUPLZSTP3KvUfbTO/yUqA/dEvjU6K3Xz8zNAqt+9qDozAYlC6+ja9WZjfgfgE5trn1m31HicA8XziMqfeEbJ5b80tVhn9Tvir91ZrxWsupHmxHsbkA7qCx+e3/U7rSTzYCwgTsV9TK208qWges3TvM2LY+z2u86w1hXZ3LHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W0eBB2admDx5I+eZSAmoS7l1ByXBREdjB/4M0MzeN8=;
 b=t40Q3JBi5Tmyx26huNf5MskvIBkHYsNKUBnZDahOpzzLqqnX/hKy2DDowEVrzfB5Vk4jkDzgCtpNinS56Y8HTKRYW2POlSFZtV7Mp7sD3/2/k5AgmW4qrowWdiwIhBF0ifHkOLGoBPLm31iZycXrxMPBCLnGouKxFYVh9Q07drY=
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.24; Fri, 21 Jun
 2024 12:59:19 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::4e) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Fri, 21 Jun 2024 12:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 12:59:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 07:59:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 07:59:17 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 21 Jun 2024 07:59:15 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>,
 <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 0/3] Add boot-mode property for zynq
Date: Fri, 21 Jun 2024 18:29:03 +0530
Message-ID: <20240621125906.1300995-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 44fdf879-f574-4595-e18e-08dc91f1f62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LKgYvNZRYCzCOc+Qd8qKx6elqf7YQYj6w2hURFOIKHQhm4SPmWSXtVfr7QdL?=
 =?us-ascii?Q?aBivPFibj7y8vmQZ2AYAukH3sCECdJ9qhrSuaWmm7TPlMs9MrIPFNw0BWFMQ?=
 =?us-ascii?Q?tmWH5KMmY2dZupBK8S3FbymIDndM4Hv2LH8BUZSyygE5ynb09jyvrZ4N0u2D?=
 =?us-ascii?Q?f+OeD/SVA3bbBaRhyCMHvbFnAwPVKiIzCizl5LbZH2/Icq9af2NycJ5mPl9K?=
 =?us-ascii?Q?VrJZNZrkKoqVieQmqdVawxjSF9ByfLaLaGcvj3z9Ytgx6bgVbCPGxkILnwix?=
 =?us-ascii?Q?lIho9Lf5Ftt6//RMFD7zo+Xnp6Td9BB/AAh2rDeeriobAEwY/aSuLzwgd8fv?=
 =?us-ascii?Q?nHIyfnx7KmUJVeo8rj1CSK64/Dn0yWnTV6gnBDlX6mIUSSZhyLvh1eiGVxa4?=
 =?us-ascii?Q?cEjogv+dvqkjKMPbrBHGQcKi7In9c4da9aKMP27I3+sygU/wIIrRm4uwpPcl?=
 =?us-ascii?Q?kdHIpSzTr0x3mBO00cpOMbsquAyqgPyotukVMTzb0e+4MLq+/aNddIhcFMHF?=
 =?us-ascii?Q?EdglASiGSdny5iDp2A1lp6+khmbADFG6jRAQic4v8AkcYy7S3jj2awbXhIdR?=
 =?us-ascii?Q?Mi994zRbcS9cyfgVNyNNuow+nyNEN/eRzFnGTMl9ZEjdkFfEKD9YIewL9Ks8?=
 =?us-ascii?Q?uc8YgqRWWXGueZDmaAXVkM/OVc6OVMOXL1RDBd2hv4TMnsg32MmUal7ca/Tu?=
 =?us-ascii?Q?eECL37ra1Bdon5eAM8rthrFm9USjw8q/UULTfHUXwkJIvvbcLHdgXFKq1kiB?=
 =?us-ascii?Q?HtEWPGG9OTpxICWPOydozBJ7fG4H0SmhoI5dhkTMFCyY7+wuA6ld/m1LYf/5?=
 =?us-ascii?Q?4JE78nqFR6xr74QNkVT5ToXS4k5w3vAkvh7AIpiKNXqlRIdnoBcBTM9sgOJW?=
 =?us-ascii?Q?LqOQUmLdQ0NacBrDpe27B81haaXXWfM2BDcaFFELPKsRoHwwzqcpmRGJN3Bw?=
 =?us-ascii?Q?HJ8pzTxBQgtIeQI8BCq5Kgv8uLKN3+uvJRLNdZoUY7xoEqiy4aaYtvILiYL7?=
 =?us-ascii?Q?OSJF45I1U3TqeCUQ3IOUevr1gGoet0NGPvfd2QXOM/LFPVXZbO9x59a2ZjiR?=
 =?us-ascii?Q?ijm93xSBkw+r5/OhSIGqM5lq+Ox8GBcIve1B2uyaUpLRUxkYPu19Ta86YkoB?=
 =?us-ascii?Q?/MGjowYiCI13k6/8x2XX0O+nipuBb4ei5AFRpmnZustG/i1pmWveU41Cb6cQ?=
 =?us-ascii?Q?FfSAHgl3gKGdGNdZzdnSfq5LdmQAZMKwKEh16rFRIn59yqypTfAHXrOV61S6?=
 =?us-ascii?Q?4WqvBlJ7PQruo9vCA62jogCepdUHyjO8wGddMXsH6HB+yQbxBySj9iPMHERz?=
 =?us-ascii?Q?1zjq50cracLP+iwE6gLw9uczd/P1ll9KsnQIuM/xkblehPguaTM9yt+4bwog?=
 =?us-ascii?Q?zpuJ45N1sngc2J1SOjv52PyaBt20n3pSBst9cEk5sgy/EXhbyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:59:18.1840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fdf879-f574-4595-e18e-08dc91f1f62f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
Received-SPF: permerror client-ip=2a01:111:f403:2009::60d;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=outbound.mail.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) AC_FROM_MANY_DOTS=0.009, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.145, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add a way to update the boot-mode via machine properties.

Changes for V2:
    Make boot-mode property work with string,
    Fixed few code style issues,
    Added zynq board doc.
Changes for V3:
    Mentioned about zynq doc in MAINTAINERS file,
    Stick to small case for mentioning boot modes in doc,
    fixed commit message to mention right property name.
Changes for V4:
    Use strncasecmp,
    Fix boot mode names to use small case in few other places,
    Fix code indentation.

Sai Pavan Boddu (3):
  hw/misc/zynq_slcr: Add boot-mode property
  hw/arm/xilinx_zynq: Add boot-mode property
  docs/system/arm: Add a doc for zynq board

 MAINTAINERS                   |  1 +
 docs/system/arm/xlnx-zynq.rst | 47 +++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst    |  1 +
 hw/arm/xilinx_zynq.c          | 31 +++++++++++++++++++++++
 hw/misc/zynq_slcr.c           | 22 +++++++++++++++-
 5 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/arm/xlnx-zynq.rst

-- 
2.34.1


