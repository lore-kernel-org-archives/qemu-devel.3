Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ED1E6FE41
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdW4-0001QS-Ne; Fri, 06 Sep 2024 14:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smdW0-0001Al-IA
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:17:00 -0400
Received: from mail-dm6nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::607]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smdVy-00064i-Nb
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:17:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqAzvUY0utHuxJcsPMGwLIG1wRxzAIaOLHo982rO59I9rWyfYhYHp5gLoxNK2ZTTnUTtJ22BYL90Qfbj9hbOozgU1AG1jvnf7TDkQRgP/nNerPXDU/NPulPLwgKAR2qVpLYzg++3vpa8EqZxXqg9/sz6pqyC8o43G6hPc7Z+EqcUebtG5P7ofGW5mB1sYj338dR5gRQ5woTItuo1un64ThQ6nuptA2YuioJhsrzjKHmjTlwxCDVKNF1g8p20w2rWnNiXfAdBsm48ZSeC/Wq/y3ojGV/Gf/fcgFHel9Wpo64cufqU1ZlonZwzB3T7mU1SuiwKHF60G+Kj/IhbLLA2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxVr73titAOllEbeSIAF3ZkR+WF6Ys9iP1mfDNrotCM=;
 b=dlg20AFzJCnhdLoFBkoLCA4RHiz6OBSWwvGVkNrh7KHI8F0BYtox7bW/AiCLML+faFAhn0b7VMf/g+xqMy8nKH26jGzg3wso/jVZSa/lhdsgwIRQjOSn6Dl+LgjBldDVhuGrlO7hwdEMjkTS8XJQRLfVfMzB2ZXnXKy+kDYSsGqbwLHa2Jh4e7cYGqlybMZ122psUtWAH3eAaLOMGYtmlYAMNgcRcQSV74n/8Vvp7Ndia8Ypm4LIPIKIF6upPP9202ubsNkJx1TLWVMaF+raVjYREyVlf9mASB1nnKiJXARw853QnSXWdWX0fZJM9LcKysidb2OY8P6qpiiPrN6eqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxVr73titAOllEbeSIAF3ZkR+WF6Ys9iP1mfDNrotCM=;
 b=2GG94meySE3iwxRwq++j9mSdFwC5KlzSzZyaqNzRi8JC9JUZykh98MfrFM+s31yPcLRElT/uVlinBhbxdneKwjeSH6UuMghywMwxvuqqRWkboNN9i5LM5WUvRfZxl92SmVbnirKz5Nfl/aw3lTH/GLV4VIKolwGbVPk2jglkuOk=
Received: from DM6PR08CA0038.namprd08.prod.outlook.com (2603:10b6:5:1e0::12)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 18:16:53 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::3a) by DM6PR08CA0038.outlook.office365.com
 (2603:10b6:5:1e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 18:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 18:16:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 13:16:52 -0500
Received: from xse-figlesia-l2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 6 Sep 2024 13:16:50 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v1 3/3] MAINTAINERS: Add my-self as CAN maintainer
Date: Fri, 6 Sep 2024 20:16:45 +0200
Message-ID: <20240906181645.40359-4-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906181645.40359-1-francisco.iglesias@amd.com>
References: <20240906181645.40359-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: francisco.iglesias@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 834b7e27-dcbf-4310-efb0-08dccea015ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JjpPe4XNp6LkvL6a52nirqsz9881AUkYL7ufsGhZ52aeHfjGcHr7XqxvK3B9?=
 =?us-ascii?Q?EsaoGqfl3ED6SsoSG6JD/OCg5f4GLgX44n190nxjdeEnlT44EF1C8tNZ4stO?=
 =?us-ascii?Q?zxazRnBJB2CT0HbQlQJDxjLI4AcbxvvwHb1E6UsVQ4lPgkYXs+OC5H6fg7oV?=
 =?us-ascii?Q?QwEbdRnNYVAzG3Q3wtnalGsxpvcCuBidpKAUZVg3hEdnwC08Mq76vHgzOgXK?=
 =?us-ascii?Q?QlulPf3IM2PJnfctCVUHa4SyrF3Cd4Blgpcs6+FDK8GsP5ccpSIglKaCHitQ?=
 =?us-ascii?Q?eYl4Jvljo7rD7+5/2JWNr9ww4tIHhQwnICu6OtxpoDydfu5C981McoifxKE5?=
 =?us-ascii?Q?pmmOWqWN5r/28fVtEQe8WWXUf3yFL6dq6WuubxPJaWbDNwIBaCivPTirQOIE?=
 =?us-ascii?Q?lrEr/V0X27gjhnVcMc8ZzxSLSDMNFol/ksRE1HcD7E8BY9/+B4g1Hh/lLdVL?=
 =?us-ascii?Q?QnxukYj/x8t0B+rojlxSkg0Y0kCP9oFLSdJqZhxAsTvcB4zF2lUxpwZVQD2T?=
 =?us-ascii?Q?n/lBLlRhRwtm4IzBvm+V63g2Xl+N8EyndOwQ5OhNHWC3lg0G0E06d1yetx5B?=
 =?us-ascii?Q?TWJWnFL0DP30Q3GZ2Yzw+tbOuWNgrsPkkx//FxdPPjvzGElUzoHCY+IdwRIg?=
 =?us-ascii?Q?+yO6nboGWm3iY2NEqtNL1ArwvfrV0IOlbwvDGTBKjFiuMYSd9YfFiLRwxTZN?=
 =?us-ascii?Q?g1uIyDEa6UCOmt5QUNvWA+YaqYQVbuWfKXdyas+Tso2jv7ein/r+Sv23v760?=
 =?us-ascii?Q?lWXXJa+CI5P/Lgmb1jtHgDRB8rNgPuQqitUYU92CenxkDbSl6O6QnQoqniPV?=
 =?us-ascii?Q?OJFxkAmstx8ddWbNe3ysz2+ZCJWjlCpjinvAdIqIUbI0FzNQ4WQRTEZ23DQp?=
 =?us-ascii?Q?CIKbkKRudX364zkrkwwrdTq/u2HyKQLCpVIF9abesB3oOOD8PzXr95rvvcH3?=
 =?us-ascii?Q?VSjYDjgnemjO03Jts7SlHJ0CN4fThFrBzO90n3S5PbMTxoksdoBfcV2K6n4I?=
 =?us-ascii?Q?ZvQsOYVY/pRiyh3acRJ/9vEnP2R52/yzrdnzHb0UFVGyvR0f37BKiDeeIKFK?=
 =?us-ascii?Q?+Io0I5K7+1zBBvSup7bJinGFFEgso/EE/yV/XPMgkXz4Mgmv50vdE1mkt5tf?=
 =?us-ascii?Q?dt8SYZY2xSDgvsSYdfbjlGvRB2XaocvhNB0rh1kwyDc6T8St0CWiBOUG4N73?=
 =?us-ascii?Q?xOj/YF7a+EPCgJzaLV6qOjPY/7rK0VViixzLraoM46rdPtBpQKdQd17m2yyW?=
 =?us-ascii?Q?1KCphJpMWexbE7WIw7W/go2GGHi9Qag1HiQT+hFwKkyBVsVPSms8ZDvEXwZn?=
 =?us-ascii?Q?Oo5IcsFjqTNBH4Vnxh9KLbOQ4Tg3A9oePMfypjV4pULUJh9lIoB9voV9jFm6?=
 =?us-ascii?Q?7PcdLy2utvEPBtfxUC+tJd6WmqX3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 18:16:53.3915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 834b7e27-dcbf-4310-efb0-08dccea015ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
Received-SPF: permerror client-ip=2a01:111:f400:7e88::607;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b03952f43e..a320ce759c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2701,6 +2701,7 @@ F: include/hw/rx/
 
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
+M: Francisco Iglesias <francisco.iglesias@amd.com>
 S: Maintained
 W: https://canbus.pages.fel.cvut.cz/
 F: net/can/*
-- 
2.34.1


