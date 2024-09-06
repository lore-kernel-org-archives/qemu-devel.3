Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A66E6FE3D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdW1-0001FC-Ri; Fri, 06 Sep 2024 14:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smdVy-00012Q-GW
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:16:58 -0400
Received: from mail-dm6nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2415::629]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smdVw-00064a-GX
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:16:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aB7Fbxik2f/iuj9+m2+IJfzE0o3aj4/fw7fVUhqGww9TH9oQd/4TzZm25NS7EhSYVx2z80VU33RgnsQcDI/HEgGwnlmS8wo/FlfcXD0QlJ2f60gXU1klr1IrkR8othLgY0dKJzkW9iKkPZ3owq7op30QZXrxMzjxjE7W3UkKTBc7bTj+tpfY15XsKqnMtlsQAQzew1HNBjfiJEsfP4h7dn5fKMTnNcEy3IElFSliPxpzYQV0aGAQuf17UhUAch57E2qUSxd+CicsepCX4W+ZHQPa9ryCtC/oXUzwG+FWzlOJiSssl46d8vq7/Duot9jI/aZ41IYC7VgeKk9chjnVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2yfYDD/PvXd3jwbAkeU48dr/Ao21OQQENEUdj6cI20=;
 b=hw+mRjU4+CXABciRWmsOXjgbES5s7evJE6Zr714E9dMAOZ3VXmtyZiKPL2Sa3M5V2/KNnnt7a7/yp/yBPX38bqtlb4tLBOE9OfmjdMf9xU5ydCwxQUUl0jxQXCWtAcA1NInHGn/ALYB+qyi2tccwHuocrmoupOMOcwpmx0e+6AMaYDYrHH21aa+VJPkQAW58YXyVw0+jzpsUo/av0i9sgJYGiR58VVb/9uPE0yvAp1X0EWrtX6HcdExe5MJU1c2YVBfsKhv708xNnu/kUjVIxQyl+lBHG8LVC1h290UogjHEu+pz42xC0X2u9qr4LZ5BZJ8/vcgMWcuvm49eVJO4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2yfYDD/PvXd3jwbAkeU48dr/Ao21OQQENEUdj6cI20=;
 b=W9VAMwaQ0/cYXR32+JPuGmBQ+IU+Kk4G+78hhSY2gAPu4ONMdbBQAIn70EVvs5k0r8aTibTIg3DnQBGlXRQZq1S6tI3ljxo89jRgbSkgHrP/aJsoTt3xrG/4xaRB52g1ruKp1h8cTTAcYJRWdcvtGyreKyPnKqY+EffeVrC0j7Y=
Received: from CH0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:610:32::35)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 18:16:49 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::9b) by CH0PR07CA0030.outlook.office365.com
 (2603:10b6:610:32::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 18:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 18:16:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 13:16:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 13:16:47 -0500
Received: from xse-figlesia-l2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 6 Sep 2024 13:16:46 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v1 0/3] CAN & Xilinx OSPI maintainer updates 
Date: Fri, 6 Sep 2024 20:16:42 +0200
Message-ID: <20240906181645.40359-1-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: francisco.iglesias@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 852a4616-71a4-4c2d-4a6a-08dccea012be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r0zPpjqu2sKMnXcu28bL37Oh0vWnzXvg7gcwYY46imvlHkd2+DrGfOTiwvcU?=
 =?us-ascii?Q?WVoDxJog2a0tSdJEyLujoAA7X9M7ia9QaLF204IAXeNsFbekIrKCHLPSoGb0?=
 =?us-ascii?Q?fXoa1gQyVsZcHxT0DwnP6iD4jBjjJe0ZM5BR8qCocaFcyp2aWd2KddfqpedN?=
 =?us-ascii?Q?2RZIUWGtRA7sqWZuSDFSNj4nRkq5sYtIy0H7tgsYJ3NNKi7WhhlZTpMh2iDn?=
 =?us-ascii?Q?E4LyAq+L128OP6ibGG8uoxokBo4paJp9qlfZlOMNFgemvuvhHLRoQSFqi76k?=
 =?us-ascii?Q?fwh/PBgzWPXnQyxdOcC2nYrRG2nO27rTNn4QF5ElRzpIQiZ1IjN7U5HVcvMk?=
 =?us-ascii?Q?ldVwgc0QqdvoL3pPlMPFqWjz3HJKOJbYrmGnlSzwWRu7xqdV9C6Nc5B2Y/Nt?=
 =?us-ascii?Q?gS7d/x2ZubZ6rDyrwziR3AT2wachifc5A3oGrthEdYbXEJUIlz0AvUXJ1jyW?=
 =?us-ascii?Q?0+E80OxfxZT/02raWwY91NEHCnw1Am4SX10EaeDJjW2QBGujtENvND/Ke7vC?=
 =?us-ascii?Q?5+BmidY6BwKkefScslxdpPPV5N2xjgXKwhVSQZ7FjCv2R83y5UzwEs0AVnag?=
 =?us-ascii?Q?7CdonCP6Q91xJHFtzh1C7aTmOTD0z4P6TYnNrPcJAJx20guK4fFobMPhBw3d?=
 =?us-ascii?Q?OsqZvqkQn7Dxc3PUCuVGC3j6lNab9G2eR397DJy1MKBiC6LSAtndaoP+/dAP?=
 =?us-ascii?Q?M9gi/xh8FmmbODzpH9H08FtA+X1jjbu7qf9gIqxGcMtbtro3wizws0mLX6J7?=
 =?us-ascii?Q?9+RWEeG4yGC1Xh64apXulEFwavyDvXP7eykjt2tkrXmXksfoEF0eYhRHrNeQ?=
 =?us-ascii?Q?1pHR7vLwCm8VZfUyV8bYkJh7/7sPLzcCUrPN5VSndW79po0HlnOkAdCYtpfm?=
 =?us-ascii?Q?a1GOQ322VVOEowQTnmGBaiekJ881Ns/Cf4Wp4anae08poi3sEU1YpVcsKILi?=
 =?us-ascii?Q?pgQwjohXV8GKVUgkGpRZxMREw88fhj5KilzUjSaiAianRQbqr9posrvezSga?=
 =?us-ascii?Q?HUhkGqhTOCxVs2jad/56JL1KiE4O7sm/il6TGuk6yoqnkXtGcpdAkDXrH+3X?=
 =?us-ascii?Q?6gMlFiijYkL8Gsq+pdtNimSxf/D7Tdwi0cfSEIh4sNDb7ZLCP+zUmL4x12nd?=
 =?us-ascii?Q?zq5ezuZu70YSHl5ZghwKbjOwJo9SgkKt/y1hTUhaa7ulUik6C3C6YJsJXl66?=
 =?us-ascii?Q?pj/J+H5h/MpMPVcfoLZUkEdiDvAwbhFrL+26Yn3O6xWBqwrCMbeRR+vNUMcb?=
 =?us-ascii?Q?kXXf1y8iAGi6/GxetYgu/WwTWhJCMRbkUYXgiwGdah9j2uOX+MOnQKyBzDcg?=
 =?us-ascii?Q?5wc/z6Bbe1HMqtBgnQAO/XC1FqfubnVLtfrgp65D+iHyci4gGsh6jnGJjNmI?=
 =?us-ascii?Q?yMvSXIuQmSoD0y79X6dGXj/NuDftCw0pOF6jAcQ//+JfV5IOjgM3AbZsocHe?=
 =?us-ascii?Q?ywPSaXzNbmhDZXON3SwKqHm25PcNtvBm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 18:16:48.2599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 852a4616-71a4-4c2d-4a6a-08dccea012be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797
Received-SPF: permerror client-ip=2a01:111:f403:2415::629;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi all,

I'm not in possesion of Vikram's new email address at his new job, because of
this the first patch in the series suggest's to remove Vikram as maintainer for
the Xilinx CAN models and also the CAN bus subsystem. The second patch in the
series updates my email address to the amd.com one on the Xilinx Versal
OSPI maintaintership section. In the third I volunteer to replace Vikram as
maintainer for the CAN bus subsystem. 

Best regards,
Francisco

Francisco Iglesias (3):
  MAINTAINERS: Remove Vikram Garhwal as maintainer
  MAINTAINERS: Update Xilinx Versal OSPI maintainer's email address
  MAINTAINERS: Add my-self as CAN maintainer

 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.34.1


