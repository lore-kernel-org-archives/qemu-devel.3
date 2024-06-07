Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484E4C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:56:57 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFeWj-0001Ja-IA; Fri, 07 Jun 2024 14:41:25 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sFeWh-0001If-UU
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 14:41:23 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com
 ([40.107.243.56] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sFeWf-0004zF-Pj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 14:41:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WArR8IeaHq+2S7PaViXwSVA0QUOUz7F7Hcbh2jfi2tpHAB5Jt20nj5TxBgCFFsSvViSpoK54rE8MPAG2/MTZdscNkGseFO+UL0+YW79s1jllz7GzTqbtMl3iHL9n56PyFLove6iUTbstvYbf5o9kI5UpCvwjUpPJBPBpnmaL28O8FoxN4j+2KRG9LIBKZSBTIISv0oUgFhVSYgN2TNYiLdCLwOF4o9//2j9YXge8APEy5Iz6gDyWgHK1jZJDPnSBXBXabwc4D3F7S+oC7eoRQ+ouJNrnRGbHfitOeGqsWGqjqm9zryn6SEEqttwXR+IHZl71DmfiKJtZjciB2okTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jm9FRw2mXdlD1Bb+kA4qIskbljslgjmNw93RU7OrX8g=;
 b=MDpmRNh0hHBTeQdhie5rWEFy5XI3nWzdshPgYqETPn67Ca/c7eKIi1/6bolvm4FUBzxQGzjY9QC3zXMP7oEpVo3gh6dNCMawDEQtFuRwuJLHT7j/RxHOnXOwUrH0QpIzd9NWAjwlpEAsPhBsS9E54MqxbQqaL7aYbntfjps4YXCFpesTPa8ToMJF+i0C0y2WVtm9BSXojvUkqdPF1tw2Z5RZlpiwmo1WEaJ2fcOgur6r7qELjaxlelPiFAIbcAVP44ORLogwnpmQw0poWKx5Qygx3fGKqcfr2lYEZcmYDNTqwaPI/knC5e2GoCfFQlUp2JvzAuYWKjHnW4zYLe+c8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm9FRw2mXdlD1Bb+kA4qIskbljslgjmNw93RU7OrX8g=;
 b=G5zHRk+ZkWLDn7HNQsY1Gdzk+HuVgGpvkHPLGtcMCX8gUtNlEe+C+d7ySK4Dh6QhXIyIxbeRnNA0Pt6hfnOi8KyejMlX/EzxL2BXqf5oEvY7zFEuZ+EPkmo6+8kNyRn6kbuKxqfMY+vE3uPztp+yjjSPuzXLI8vv9QCzS1n6XH0=
Received: from MW2PR2101CA0014.namprd21.prod.outlook.com (2603:10b6:302:1::27)
 by LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 18:36:13 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::6d) by MW2PR2101CA0014.outlook.office365.com
 (2603:10b6:302:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.9 via Frontend
 Transport; Fri, 7 Jun 2024 18:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Fri, 7 Jun 2024 18:36:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 13:36:11 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Jun 2024 13:36:11 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
 <peter.maydell@linaro.org>, <pankaj.gupta@amd.com>
Subject: [PATCH 0/3] snp: fix coverity reported issues 
Date: Fri, 7 Jun 2024 13:36:08 -0500
Message-ID: <20240607183611.1111100-1-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pankaj.gupta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 899f4afe-2a99-43b4-66b0-08dc8720b523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ru0qU5zuSpfdSGAk5/9awtVfERm9qQhpwlYYgpT9WyOnqI/pweKipy2OzvN?=
 =?us-ascii?Q?6mEYiXsPYZ+jcUzXEuXP8W4RlTp5jNDnx2N797vx1pan43X09c16PLsth64/?=
 =?us-ascii?Q?WwoITmMXfloYEzu3zU1llO1xckN2BxH7Cvtf+36WwDI6stVZLaiWvsUQEXO9?=
 =?us-ascii?Q?CDxIE55+PXvCOf+PDLZPtsoJPEWsXeT1UIPmzPOCe/+sQqkHHhbqCjE9BavE?=
 =?us-ascii?Q?z65NvY9YCYaCP6TauqWjt6HYSZ+kwNcejPg+KSABAnnQqnGVzPQh+KY1lCE+?=
 =?us-ascii?Q?dlfYvoBG0SQnMIRPLeTzR2mGJ8MwWCnF2rNIdr1pZfUoMpC/v2ws4be7Utah?=
 =?us-ascii?Q?tl6ONE8We+A676k15bYSV4lwtpCBsvwmPKHQP4D+PKdql940Gk8Yg0PRokY+?=
 =?us-ascii?Q?gieKzC3dOJ281R9XHQGrXNtnUxyT6Du7HsFpgVcxYY+tYqgexvuL1aybTqfm?=
 =?us-ascii?Q?Lvq3wRh7dHh6PX3SFtPt/+o9P/n775bTMmNf9oeOrGNWLZSOPi9bBhfVpcrC?=
 =?us-ascii?Q?gvuNA1lHQGiPnKO3IEIlA0ibfdYFyR/vy+7RLb9VIQbM8vwiTJKm7DS+bkFp?=
 =?us-ascii?Q?6YurFMbv8/3X2Nr6KaPtxhigiIAdrMrimHG8LU2NHggP9sBhXi07UNg5i5MS?=
 =?us-ascii?Q?gJaMf81A80lazV0WmtOzB5jAH7yPktSmIYulsJ4Nbz0Aim14GBH9+c3+FNg1?=
 =?us-ascii?Q?eD1yB4uzg1CZUvMf2u2Ks7IEDkFq3Yr6pQ6DJAK1iRxM8UMg4kCEUj1DCtky?=
 =?us-ascii?Q?wdVgkYSbtk5Ahiax4Dt7TaIhvebisfO7RVHghAh4WtW1Kbel5CYpoxvdSJzc?=
 =?us-ascii?Q?gphok8F7MFRKCwtgwV7F8Iv1pll2dkMxp1IgILNpk9PPgai0lSzT3Lh4URkI?=
 =?us-ascii?Q?YU4e34oS2agXghdA4yshhClXPFEKZjAgQrBSeLRBclvYwSBt9nL4KUE35v4r?=
 =?us-ascii?Q?oavHIb463We2BeG8CJdBceVbDIlSqHVfmVqkay508hNCHHSfpMxXYqO1ogoK?=
 =?us-ascii?Q?DfNyh48aiCEyeB9swjBj4O5MgZZsv9TQeCe3C9ia+OrcETXf0xg6mwa5i+gB?=
 =?us-ascii?Q?tMlhYK1PQdeCs4L1PrupnpdlxhAb0GIOnc4osgA6TiL9A+4t9RWbgOHV/glQ?=
 =?us-ascii?Q?phnLZHjFjGMSrAV+jWaAoiYFr6azJdMtHGbk6GiugRQ2q18VJeVXxtNHwGhz?=
 =?us-ascii?Q?iVSxvo960KPNhQ/Izps8astz3SKprEmC77o7+AZgNGgFPOu1VRsb8FI7F2lR?=
 =?us-ascii?Q?jutSDB5A8Gl+NqNCNBtlDnAHcwmXhAjpR/ARJ04clqlvYVcQa6qQVw5MAXmo?=
 =?us-ascii?Q?6YQ2TodvkJfVGtX+HdYBoOiZP+Twj/EgPTCMwbe6NUvwvfdjqh+HqWN4fPCo?=
 =?us-ascii?Q?tjQCmNjmqGK2qDCcKuXR27ZqewMxERZIilOh9xIoAa8/5YpwJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:36:12.4498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 899f4afe-2a99-43b4-66b0-08dc8720b523
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356
Received-SPF: permerror client-ip=40.107.243.56;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Pankaj Gupta (3):
  i386/sev: fix unreachable code coverity issue
  i386/sev: Move SEV_COMMON null check before dereferencing
  i386/sev: Return when sev_common is null

 target/i386/sev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.34.1


