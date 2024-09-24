Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7752ACF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 11:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st3gA-00082L-SM; Tue, 24 Sep 2024 07:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1st3g8-00081l-Ef
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 07:26:00 -0400
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com
 ([40.107.93.87] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1st3g6-000592-5l
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 07:26:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO6ruu8yO4LWyZcAUprpdDtOZRqglXIo6sQR1Gdsbt2LdFcCXv43JonAQ/OyQEIj7dabSdDSIdgJH4U6ziAbyCfeKVvILMCAW7HzC18wtE1knQkzX3OCUXD+dvqFNaNFqlsylWSpx78EjsHFuQk7Iw5qAhZQ4/VNTdNEDS2mW521Gd3kf6AHjizQY0lwux1eogv4EJKpghg9Rii5xH+m6NYd65Vw/2NWC20K5uuWwALfFmr54evj/WrQzXO625lOebK3+fgqtDrnuBkhpHqlz8eM4f3j6SLvkj0iGKaLm19ncAkP0NGANw8Z+eCdZbsxUM+Okly6upYVhZONvBkqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp34u6J0OmgCowXF4yMeXBMEsfgrvk3hl1LwES3ojDs=;
 b=YBc3QoPMfIXXI17EyDDSyf12cNRw4D24ChnVBXC4BTIrbPayXVtmU5bStAn44Dc1wcQSwFZgr/Uz6EAUnUSeEr3Fc8WnEn/TngQLBF5zETdGxA062/4LOKHALpsbsrfvV8MpoRz6nmm0hNnif+LS4De+tDG/vIHkpt6Kez6SOXXCGE9Y1vrOfWseAX+EmsWO/751VwDBgilFmZZCuiHc7dgTC5Ius/P6CVBDF5EglDaaJe1UKaQqEKiT2PRBSgYq/ylgowFUhz+JvkjeKSMTQkCPNNh5gRjnC+Q/8L4iaLF8z+E6qqiZYrlt8iB2wF0FWGZBqQw/hvVa1aN0ADTxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp34u6J0OmgCowXF4yMeXBMEsfgrvk3hl1LwES3ojDs=;
 b=ADGaylnohenh/rKCM+BXmMpCpvV/1w2HIAA2AyADa5jwtvaEIDQwmh5KNrOUvnnyLk7nlHbBYTKC9wOnvDiPNbmBYoJk5h5ozxbCIvKDoCYf7m64zyK0wnkXSecN4AfWM4hqb0uHa4Zaa3rRurIAnnzDjFGduOwy8vYUCy5OPI4=
Received: from BN8PR15CA0043.namprd15.prod.outlook.com (2603:10b6:408:80::20)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Tue, 24 Sep
 2024 11:20:51 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:80:cafe::f9) by BN8PR15CA0043.outlook.office365.com
 (2603:10b6:408:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Tue, 24 Sep 2024 11:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Tue, 24 Sep 2024 11:20:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 06:20:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 06:20:48 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 24 Sep 2024 06:20:47 -0500
From: Shiva sagar Myana <Shivasagar.Myana@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alistair@alistair23.me>, <francisco.iglesias@amd.Com>,
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 1/1] hw/ssi/xilinx_spips: Fix flash earse assert in dual
 parallel configuration
Date: Tue, 24 Sep 2024 16:50:35 +0530
Message-ID: <20240924112035.1320865-1-Shivasagar.Myana@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Shivasagar.Myana@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: fff9120c-db8f-491e-125d-08dcdc8af1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QfCT8IwBLBvF5PxuXc4/S/UZGqJ9VX7XpJm4qmSrTABL4H1jIgbsmzJFtB9h?=
 =?us-ascii?Q?HUaNB2lZPRAZgh1ityU+9415Iwl8RsCZUeSqJkmNkiYNwuHQrQonSxw6wXSm?=
 =?us-ascii?Q?m6mC/HXD4mEVaG9oszjfiolzfDZX9TQ9OpD8nYWmfbMiS3/L67W+1pAhsIiQ?=
 =?us-ascii?Q?HRH8fq6SPpcnnk0hf/1hde9FRtJxGCFKkwa81E+Tc6vhgki7TqfXLZBebcNq?=
 =?us-ascii?Q?DY5OmKb6+v8ju92VljVPD7hElaGlUbxB9exNVNXZ8Re9Kj/5YVikuimKzsdF?=
 =?us-ascii?Q?uTJJokHxQvN4hXie3DnRcxUDwoIpqaAqMRgRIrSC+nXi5RTPXFC8sWvJjbZ2?=
 =?us-ascii?Q?73znXPAWxBeb5MyQgJnHsHmrmZ9G1Ren/BLf16n1SmURPRSQGLwn02rLu5Nt?=
 =?us-ascii?Q?5DEmAMKnJrkJauCF33xe6R4YcSU1zCa121EPIgHt/xmvYDZjE3qXAptf7Lp/?=
 =?us-ascii?Q?nAy239orTm+fCxZ0OorAYmDhEhrS4LRfm2qxN+RT9zduG6xAvozD4TEiMXuR?=
 =?us-ascii?Q?1bjU5Tkdus/Kadz7EvwF3taDm8fT7dD+JsRPYrb04CBxc3T6EIkANX+Hg6ke?=
 =?us-ascii?Q?T5QZrvbTgvSJrKNMVz34INGFTvz1os1rnkMszWqcjesWrsG7nR9MdNTzB56Y?=
 =?us-ascii?Q?jExSMatEovvIeQe6XTXI35/U1wnWKGaqNLP7ZpNWq7vd+JHUZKEWTtSzTAU7?=
 =?us-ascii?Q?VsxZgBOj92ofTY3cmH57ryiiMBvRylpt7WW89VlpnXY+kTyhdxZJf49xPxYc?=
 =?us-ascii?Q?JxvxQkirKAj7HiE576QM+djePyx3p61cb0j4CmiKFsexR45+QGUFFvicD8+H?=
 =?us-ascii?Q?f/cMGtojqPT+zWJsvwHn8xWYfGOwTV0cmACReugw6Wff2Ylu4qomKxguAjND?=
 =?us-ascii?Q?vK6NeJv/yqNMvhuAAx7YvSXB4pw94Y2az69GCVrY+l1qJNca7cNtnoCcajUE?=
 =?us-ascii?Q?7xfdWqdnebW5CTOfHAJhQn47vsGlC5FRR0EN190I0Y9ivpFXTsVgKn3Nq5+e?=
 =?us-ascii?Q?vk39ny+pflPQ7gAVfpxOQP4aOZfvg7qPWtktoe284TgmfSZXWJO2020vlikr?=
 =?us-ascii?Q?b1IB+igJFP9g3p9V+uINTixwKcmr8cKhotusPlXjoZ+g4D2fWRpWMC6iyt0T?=
 =?us-ascii?Q?j6A9MiM4mu1lv1pdTVUEv4+PADxXBrRZVIJlYlPr/K6qNNGH9wb+mndUfCS1?=
 =?us-ascii?Q?8kFNzEYaZxOOqz8rUSjVoW2xptCdRggBUm1NJYbCOTD8iXjgKvxVRXxyXQlm?=
 =?us-ascii?Q?SelUjP35bjYM6/9wYEePKqrQdQo1i3Jct7o9eFe0UACvhW3lsAvl4YQOWoIE?=
 =?us-ascii?Q?kTlRegGoMae3gkHG4ZqOwMi8QMehYpO0uUTYy8zfTgmlIsyuR690UyMv/FW6?=
 =?us-ascii?Q?S4bM7yIhJE2tOfNsBjIFAmxUm37sHHjK8PXZ0VoL2Mw5REMiW0RGCK0jccu5?=
 =?us-ascii?Q?M8gOCEQen8vvA2Y3/V6wpigrlIdqSB7B?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 11:20:49.8218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff9120c-db8f-491e-125d-08dcdc8af1bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
Received-SPF: permerror client-ip=40.107.93.87;
 envelope-from=Shivasagar.Myana@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.898, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ensure that the FIFO is checked for emptiness before popping data from it.
Previously, the code directly popped the data from FIFO without checking, which
could cause an assertion failure:
../util/fifo8.c:67: fifo8_pop: Assertion `fifo->num > 0

Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
---
 hw/ssi/xilinx_spips.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 71952a410d..adaf404f54 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -620,7 +620,9 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         } else if (s->snoop_state == SNOOP_STRIPING ||
                    s->snoop_state == SNOOP_NONE) {
             for (i = 0; i < num_effective_busses(s); ++i) {
-                tx_rx[i] = fifo8_pop(&s->tx_fifo);
+                if (!fifo8_is_empty(&s->tx_fifo)) {
+                    tx_rx[i] = fifo8_pop(&s->tx_fifo);
+                }
             }
             stripe8(tx_rx, num_effective_busses(s), false);
         } else if (s->snoop_state >= SNOOP_ADDR) {
-- 
2.34.1


