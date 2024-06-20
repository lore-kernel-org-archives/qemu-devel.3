Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDC9C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 10:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKFEz-0002X8-Pg; Thu, 20 Jun 2024 06:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKFEs-0002SU-Ks; Thu, 20 Jun 2024 06:41:58 -0400
Received: from mail-mw2nam12on20625.outbound.protection.outlook.com
 ([2a01:111:f403:200a::625]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKFEp-0005Vg-M6; Thu, 20 Jun 2024 06:41:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzXz0WT78vHa6Oa86qIcNhQTMyhTP4/fMowMuB7kART3jsXqYjKKTEhnrwKfgK9K8mbqBv+U8/PJYKkMFg2TyaaTcyyutuyx5Tys1AobLMfowwDS3+rWOGmCb6/+oWqRvWwSERDJTDzThOmuaTDChem77kfiVA4SU6CyNprZS9CMeVC5488VA3J5tmSCF8vYo4pTv1JQmV5rIXV9os3NLn8D5cb9GWLCUf36IR7B4wZ8aVQ245WdwZOXlIEZ5k9bymXg69MR/P0fJSmOBjIsGafo1Tfxm6IG233MIuw+6ga7LSjMxqAsvghzM6OM2j8EJ5CD/n95JtE6vXS2KDjv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWe8eKjxxxlCQGMNxbtVdRYzlX5/N/MRpgWLO52d+RA=;
 b=Q7VqyNRwdkUOHdqr2/oVqWbcvgXHNnepjOTp/1tXYWCDn0Yd2BZcuTSY0DlwiCIy81Mp58B3SgedCDnRJX5zqbDVc8aXD3Me0SaGihc3PSdnNHGibmNRe7fR5PrEHDufhXZOsAZEXzRvfaO2IQeFh4DEylb2fW9gUmmf1OGJzORH8DVtQWNwrRxDiDmiAg2kY4uZ7JFqDI/2wCT/RkZNTR5KByhLaNaA1KggMUoBPSEH0aVUhemdOmq4oX1C1RlApe5iDadiojbUEDdOybq7nuwHUbFafvRrnBRJ8Zt53KBpUKLM5Led5LDJp9rF2nhyQhsQC1DkWLB0/kvJUUF6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWe8eKjxxxlCQGMNxbtVdRYzlX5/N/MRpgWLO52d+RA=;
 b=LK254N4wmwx5oVASENGW2zwGLtQ4zzY5N2bJ3eFkndXMmKnN5vJlMZ1xnWCq+y+qJ+6L1nbkIpHEgG7EXXA4cP1YQruA0j3a29wogcDKCmJhFbRlT06mK8XqUMq2PizF9z4ImQQe1jGwkANA8epg9ScIlidTdCjou7xFd7ROFrQ=
Received: from MN2PR20CA0044.namprd20.prod.outlook.com (2603:10b6:208:235::13)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Thu, 20 Jun
 2024 10:41:47 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::d6) by MN2PR20CA0044.outlook.office365.com
 (2603:10b6:208:235::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 10:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 10:41:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 05:41:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 05:41:46 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 20 Jun 2024 05:41:44 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>
Subject: [PATCH v3 0/3] Add boot-mode property for zynq
Date: Thu, 20 Jun 2024 16:11:36 +0530
Message-ID: <20240620104139.217908-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5274c5-de57-48c0-abf4-08dc911595f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+KN5WyUpwxrtYEEhOt1jzG4ovoQs/Syf83RzTqkb9upO/2lFhn7LQos3xrTC?=
 =?us-ascii?Q?cUs/5qc6sW9cRrBNoJUjz8F5dgYK3vl236LfmqhWBozTBtwMXMl+TeSbokxU?=
 =?us-ascii?Q?//7IiCv/PTT6p/7tgcNunI6/ZAevKA34xiSVXB5p6IPr5CIonylT0YdCEZvz?=
 =?us-ascii?Q?GHbD6OwrKfpzn7/OF3bKGyj4fwpmmERvZ60w1ZdeXviY1NEZvUUWb6W7JOW4?=
 =?us-ascii?Q?oDbAd0Dc0BVka6SARg2G5PKNwdhf9GNsgzauVhNX8j5nPzg/Z4Crqi2jV0fh?=
 =?us-ascii?Q?reXpJRfkBSHgrQ85CXUHi+OagPFlPVNAYc0i8WlHsk56O/mSkwllAH6c8v5j?=
 =?us-ascii?Q?/vS6TiDfba0v/Wy9+W8N4sY1u2L38NFkkQnhLQ8hPa/xguA+ptIFjZbkunMn?=
 =?us-ascii?Q?A7dwmqSyVVG8ZS3Qc3mOSlHaW9wqqPU5KIe6nXTEdqAG2eWH5o2R/zTo3Vgn?=
 =?us-ascii?Q?lZgz8LK6gdUEsgwm2daZxfKyj/jNwfMTcIUEy0z0aepD1EhjPmlQKmheETj6?=
 =?us-ascii?Q?8m+dWN8/EvkbIYfo0WFbWePUGcZp13BEzLEQTKHNWME7Gz4e/Flg2Uhv7krH?=
 =?us-ascii?Q?lxc47J9olh4EurLhm2/IFFM/XmXzA2rZiX7/E1cmkXdNyFZT5nsCmypBkMfw?=
 =?us-ascii?Q?C8s74B0VRIxUNdfnPDclC5Qrbv7AmVf7uo4jFZOSOCVtTZKEv3G2qikgJBhD?=
 =?us-ascii?Q?lE1uo/mPziRBHvD9AGD++1C1K+Bh9pHROoSGVGRcrPQAFYnQrgkvrBFstIHS?=
 =?us-ascii?Q?nch1EXtHJgbt2gfc/9CIpUWQSYvnwlw+Le0enITCGyhwIEyaRxIsUuDqRhIn?=
 =?us-ascii?Q?ieYiFgbhwO5GfOVPLnUUgEGGyNH4QCKrHWZnUrQDYETMDbqNOO3zjr4M8Ddw?=
 =?us-ascii?Q?MKKI3/jlNYtg/LZeX04nNJxxRWygdW272+X+rNhfw3DtkJBZHYs/lxYcLkeo?=
 =?us-ascii?Q?aNs2UHxys1dUHCqM94ZEEm1hqgWohWA+/Ogbok1gYo7dAC3p57jwOH1hQccb?=
 =?us-ascii?Q?hCVtmmRzcsXD5M5lOuVJ0hbRklhQRVh6ounIwH24ZNhfes+WIXkBcahWJ5f6?=
 =?us-ascii?Q?UJgMMhbZOOQ9E/SVOXZLTTsP/Tv+uj4fgxmhbeGCx+SBVst/Lo6bWaoikuvE?=
 =?us-ascii?Q?oAtRMB3TsPa7QxHJQcze9KKGUao45Ws45CoayqyFv8Hh8IScGwsPDoDVXPu5?=
 =?us-ascii?Q?iVnkWks4IyG1WK9gWMdaS2vwNlQEDLPx0bSt2gG0JDdXmbHjbstINjP64Uhh?=
 =?us-ascii?Q?oy+bk13DYCptlD54SMg9DSYcWOzJPk0wq2d5U6xJvL/Jl7TIxum69UN6fwHa?=
 =?us-ascii?Q?2oFP8aUu8OmjvUFe6EazINP13OhEEAmA7aoMLC76sLlcI/MLNwc3BobROlKq?=
 =?us-ascii?Q?tw+3ormWAZfr1kJT+f8gzjcTwDvsC5aebKRFVWiEuHIfcpgb3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 10:41:47.5257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5274c5-de57-48c0-abf4-08dc911595f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
Received-SPF: permerror client-ip=2a01:111:f403:200a::625;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) AC_FROM_MANY_DOTS=0.001, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.144, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
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
Changes for V3:
    Mentioned about zynq doc in MAINTAINERS file
    Stick to small case for mentioning boot modes in doc
    fixed commit message to mention right property name.


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


