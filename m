Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0B0C2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 09:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJrR6-000495-6p; Wed, 19 Jun 2024 05:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sJrR3-000478-8i; Wed, 19 Jun 2024 05:16:57 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sJrR0-0003r4-Gt; Wed, 19 Jun 2024 05:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxl/4MqG6Jw2HHan7JD2D5dyE9z2xH72JqShWlmFziY9Henc3eVZl8Yyw3g5ixq4mPn0KIBa34bnxP/HhU/JZD+E3MjewOQs0LSqGtUhLK3lvaH1CNdr/HW8/1jwLrtUdV2lBtQy9cf8vcOMC4PB2cJ67f4aF3UOAoPJ9Mb52iLA6PfUXUJ3+aQqYaTL9VNNplfODeGeOGazQlvOXdYr5uLBv22/xSPC7UdF6i4OFmcHWVgSus5uJzk0GQ/k7aThSJyhEoTk0guObSsB8v7K9BfTppPZ/x/U+rcATHfpLTbH1HJ0zaG2zXqlrMjEWp4e51IdyMXVB76/O01gBv174Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU0HEv8omp6sCuwx/TP4FtCHrlDYh3B470Ef5AfU2JE=;
 b=igExGU+KQPBr0NGKVU8i301KyLTz+HcnSvHDYe/l7dDAJ+xq/XW7SAFr0ESL1WyLAHIJXuuetKuXm63PYplcjcohQq12ngJkM8SFNVYsfNLaQ2b9v2bc5hif3zUTeahRFWmOrHxsCv9XgPJVOja7cY+6lItYsFj/sLiH62Ud3xANJwOCN/mpThqAi/zWBvfpO8ugFu+3hsc6VseQGnkC8LYpx8f+HIQTr/H00SIHFdbCwi4LepvQUksvvymWJlmsHJThYzPJs19Luv/BVo6PjPUoWgudtkW2Yb/Xwb9ShIsQcNTym9s/qobedQeDIPnKK/xnfqUUPqBqmfSjdSbOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU0HEv8omp6sCuwx/TP4FtCHrlDYh3B470Ef5AfU2JE=;
 b=U9SP+rtMJdn3v2heXgZc9o7+czTcJF+Qqu+7lPr8F2RGFlI2ALf6mDaGHAknPPkbd+tXu7bi2R2dLYunPTvJ8S2TpMIK5FOmkx1YvRFGbpJFKA4ISyugbmCHMliM9nR12x6heDFx1ZX2phkiTMvSaVKrnDpaJVxFLBFdfZ1LEu0=
Received: from BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::27)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:16:47 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::a8) by BL1P221CA0026.outlook.office365.com
 (2603:10b6:208:2c5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 09:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:16:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 04:16:46 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 19 Jun 2024 04:16:45 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>
Subject: [PATCH v2 0/3] Add boot-mode property for zynq
Date: Wed, 19 Jun 2024 14:46:29 +0530
Message-ID: <20240619091632.2825550-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: d56808c3-0bbb-4404-8cac-08dc90408ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|82310400023|376011|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eGsb+bImHxk8Ch/eyAeB7XU49IC1G0uwKJ8sK9PT2pY4pKzZeoZKuzzoAZVX?=
 =?us-ascii?Q?1ZctUO7yclRTaagg24V6NyZruvOHGNEXtSFnLGtpzYQCriYGbD/vjqXEhCs+?=
 =?us-ascii?Q?DxHH8ne5ttwLocg7w4kAGT8xTvHZ8PBqo6SFPV4oc+bZnC3boTFcI4Ga6s/W?=
 =?us-ascii?Q?x7UfEt1A2/RkwFq/Ide1DSQZkE3aYXwSdPziO7KKom+EBT9vfnrUeu8jpN0x?=
 =?us-ascii?Q?4o185Mhqw14QRrAlN4uq+3THscjxlSAK6JG2FKRGrK6133fccjdVE7RFvczs?=
 =?us-ascii?Q?EWTftZDWD3PhQYPpW2BbuOLKyVTSUHBe8iFRjtwnyPhLYi2U1imbQxjyDAeX?=
 =?us-ascii?Q?fyXBteHa7AvwIyU4MNLvaa+m0bRcBMQ7JzVCtJmSH4b6HLJFCP/eWM/OVTNk?=
 =?us-ascii?Q?deSpfXbSmPGAOL9cQKtbXWKDrHWG3h1rW/sn5h8rC1j/+vCX+cQCqVc42iT9?=
 =?us-ascii?Q?ZyN3ppVv9wLwzT0irjJfB1GFzNaL1Pc8a3zo9NNgqKhg4GCO2tUczFpvVT7p?=
 =?us-ascii?Q?I7d7BCBEGFBEfWyzqzPkuCkUdgXc8RloSXesrTnCxMwSOuJEp8XM+USlTc6I?=
 =?us-ascii?Q?ENsbids/HTOYUTayoU3qKDcuB0IFp2pzSP2TN5uvbjPZKXUIf4BXeICl4DbV?=
 =?us-ascii?Q?5MdZd5lS1yMfRNRHnKNBRBncVE9hFlkmElVCaQFCIe898OLVk/gHFDJ86Ha5?=
 =?us-ascii?Q?CbNDVqoi2MZBtxeS74YMULrq4SdJiHYqZezTL/K9spk2pBaHFcwrWv4a9SOZ?=
 =?us-ascii?Q?wQs/cjnVVazVRe9uMUcwCljcLhOIJBdXwu1FERxVDuAurtP8QNDQCVt4i3LM?=
 =?us-ascii?Q?56nkx1bvlAPfYXy4+CInyxXYp+TVvxkM2EVpQAtwFbMZGvEjyACx4oqPBQrl?=
 =?us-ascii?Q?q/2i6NM3OccGTPm3+rEALc79kfUw6GfynBHOvmsHcDHfQnwjZFu7GWdzTgEp?=
 =?us-ascii?Q?Ep2VTU/vGhPsZkblZXMwBPpdPv3eTuyjHJNkxz8l22zyR3fRcMTu0J3OhuRG?=
 =?us-ascii?Q?l/CXZJRbO9btbIPMPclLClmFo9K8ZouzaxC7tQUw7huqeBIjN9HTR4kL/BuZ?=
 =?us-ascii?Q?w0YPNiEAWjmw1ou5BIF4NgUGO7GSiQHdrGCcWqUN3IAOxQX5Abhogr9cLR+J?=
 =?us-ascii?Q?H/D4wDK/yFEVpSYJhhEDE7cChLwy5j+upTX1GS7OuMTOlrJiB5ZDD9hllopa?=
 =?us-ascii?Q?AAsIULCfbrHVn6fYgzswuUZKBdf5GKfVN2uEWvBXx/4+834pBY5BcG7/Zfia?=
 =?us-ascii?Q?BnL0fJ4Qvb+1QGF8ZyKo5fr2JaoaecclIQPfcr3CkGIU83ut/DMiKJN1PIgm?=
 =?us-ascii?Q?MIL7UEYc+RgioiPhm3+siLBEk/NnmAsRKDASLGYJPLucubvgrVcioixNkLc/?=
 =?us-ascii?Q?n0mhs1lXqkok89cHEUUkCpMlv09ShxWccV7s1vp17uw0TxUNZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:16:47.4397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d56808c3-0bbb-4404-8cac-08dc90408ba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) AC_FROM_MANY_DOTS=0.001, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.148, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
    Make boot-mode property work with string
    Fixed few code style issues
    Added zynq board doc.

Sai Pavan Boddu (3):
  hw/misc/zynq_slcr: Add BootMode property
  hw/arm/xilinx_zynq: Add boot-mode property
  docs/system/arm: Add a doc for zynq board

 docs/system/arm/xlnx-zynq.rst | 47 +++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst    |  1 +
 hw/arm/xilinx_zynq.c          | 31 +++++++++++++++++++++++
 hw/misc/zynq_slcr.c           | 22 +++++++++++++++-
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/arm/xlnx-zynq.rst

-- 
2.34.1


