Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885F6E87839
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHnt-0003f7-T7; Tue, 03 Feb 2026 09:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnHnt-0003eq-2u
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:54:57 -0500
Received: from mail-eastusazon11011033.outbound.protection.outlook.com
 ([52.101.52.33] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnHnr-0007AY-JI
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:54:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd8OKmK4UK6kh9aBHeT9kXhUVniTBr3lo9lKe5I+eyWOY3DcLNxU8X+ZoE/l80bvBi4avaa+LAP619idHKPVEC7s79GfjW9GpshRhVviL8nLN+nWlQU1hh441sddaH9M62vUleKKx0+LP1wvOBgFJmt9qLmLqKXrazzN9heryRHeoZX+yN1b0KE0/GiuTp/fKfRz5H5++7PgC58jRjPlBr3JkZNlY8jsa+aqSH3i9Ec9DzHOM3Vg0y9afJWFLc8i4TzlA8PdXW0SfAwuu0/clRu288EZa6QdUhjuBreUJRnB0ebjyi3+6Lm32rSOqX3PLSkiooS1mytgml7KhXLSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr7t/9mUYeWLzuPcJHtskvDYhmxovhzttW2XKWYvvJc=;
 b=wCWTwQlcVqOJqgtkcYm2LHVTgoxfTpSS07FY/w4FimAOL2MBIA/4tzBcAwxxSA5wDoVlSOCshYH2PseDspeFFkyXxGqQdB/ltCxBmFV+n0eGVaHrEKvi34lVbdWC46z/SPTim+CyJS94OU1vdTKJP8TB43/0azRrPG8cnTOAHTNMhpFwKt9xoTrdeEK+LbxCec+nzxkKuwujF8jtC/EY64NZsQ98s9r+X32SFPdiciqiSpluNXTXKON/gQ9MpqBqiI3qNyQbDleb/MtjwWRikC6qQDGR6gmRFxgcVKgbW2D94rMKDFq1pqjVwHSqTq+hWxDm4ZlqZx26Wl52mryz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr7t/9mUYeWLzuPcJHtskvDYhmxovhzttW2XKWYvvJc=;
 b=byReHJMZyNeO3f7USKc3JRvzT2R3Mp2iYim2ZWBN7TM7oVxbFHewglrVW1c44hhcPNEWKxREtgkCez5/9dYCvBWdkS0XSc3IBJi5uf3/hiVd2I5hX85QyzCXUVzEwaXhohBXaHnqOTsnEpW3H/4wduFhpQo6jgRjeXtuNrT1xkM=
Received: from SJ0PR05CA0112.namprd05.prod.outlook.com (2603:10b6:a03:334::27)
 by DS0PR12MB9423.namprd12.prod.outlook.com (2603:10b6:8:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:49:46 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::9f) by SJ0PR05CA0112.outlook.office365.com
 (2603:10b6:a03:334::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 14:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 14:49:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 08:49:42 -0600
Received: from RSBMPEKOVIC01.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 08:49:41 -0600
From: Manojlo Pekovic <manojlo.pekovic@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <Nikola.Prica@amd.com>,
 <Dejan.Andjelkovic@amd.com>
Subject: [PATCH 0/2] vfio/pci: Add multifunction atomic ops support
Date: Tue, 3 Feb 2026 15:49:37 +0100
Message-ID: <20260203144939.49-1-manojlo.pekovic@amd.com>
X-Mailer: git-send-email 2.51.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|DS0PR12MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: a05d3992-58dc-49ca-ee66-08de633378c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hyYZOhax/zOEpOwZnFMeqK0RRBdTSSswo9+4addc3EZOIDKnH7ANyS4c+QFT?=
 =?us-ascii?Q?rBzV5bWeTIk+yQDIhiusSdLKCWEmbDsY1vMB/2KoMZWIUd8ApwkA92PiEyGi?=
 =?us-ascii?Q?XGyze6vF73/9FB+zfpfVyH7xpwmWN09Pb6SC4Z/O/DFMmnm32MnRlJCcB8nX?=
 =?us-ascii?Q?Aht5u72HtFNdbDHmD6bOhwoI/dl3JwbA/OIzjaNyDVlqLAhARji0pqm0fv+2?=
 =?us-ascii?Q?P6USzmWzCDeKE1iBF6RXOYYsYfdC1Fcf8bhTnqSPzaRySjVmHZk/IRUKTUUN?=
 =?us-ascii?Q?tMiWgmYdUqm+RbhzGebTnOPESL+8LSUB0uIY9pjt4cE1HRog9tSg7oxUcbKd?=
 =?us-ascii?Q?2ds6HDgGQ2bRpMuNa/C+ht+wHUful1LOP2mEpsq/TfNHljF+R6VuJvbBt+8s?=
 =?us-ascii?Q?vYgUQ02hD08ri25tljs9kRoExDgDXqQAdxf4NJxj9bGmgUdwM3yjUHpRhWEo?=
 =?us-ascii?Q?lpGBKFjorMEjxpBzweZukOCtK9laiNM1BD8/EJZy012gaAXJhElco4jHiWLu?=
 =?us-ascii?Q?FDZeduV6lWOqoEp3R1FZHJg7CJWOBo9CdRr/hfKjeCfVRNmPz8vxcpC7mXgs?=
 =?us-ascii?Q?xLPoC436R0DJcBAgjjmReFndXzrjMmCi910kFlBOv6WrxeRaL9oUz3qOA0sc?=
 =?us-ascii?Q?0jEo3qEOCbX5wLZE0AFPSsE7CZoreLtKLhjg6kf7/avsv4UcxQBDPmBK8JmT?=
 =?us-ascii?Q?JZRiWZ9u9gN11zyHADbeY2/rpN4BFsKwKjMwYmDfKw+aTTs2BH2ptLB0+n3l?=
 =?us-ascii?Q?heBMwEfOP0p9gm8gLS007A5JhKuS5Hl3f4yllo6J7aEGggySV8qjdPHkbRd+?=
 =?us-ascii?Q?9gfaUnLVawxaEJBWuPI03/9YTF7NZEOz3BdO9TzYTcwUzRSez37pqRNI4KFT?=
 =?us-ascii?Q?bg4/mv42t9u9gV20bExYrk5NSIli/ZNG9O8Duh5/UoAgeTlSu8P3lqIXTt3H?=
 =?us-ascii?Q?N8feKBYpZp5vghcoaCo5jn4eVaycE/snovikAjlUzuh3Hbr16VBgGYDAqd8V?=
 =?us-ascii?Q?5M9w8src1VMQhJusOVDpgfefhn6zZFuHbMoYlFBUFO7HVh3wlPM+dHrNVBWj?=
 =?us-ascii?Q?PVO0f5ihguEnDbJ35REwdj3Ld3ny7DTpYc+YNRWV3N59ACVUsO2TG8JjdUBg?=
 =?us-ascii?Q?bHAichHRVcg8a7YNvBsXbe1f+WrMcnh+qIvoWcmhEDHJxtMWTFEmuN9OIN7V?=
 =?us-ascii?Q?8urUVx2rMYGLtn6oTmBFwDm8Ga/B0GB9fl3LnXPpQT51aj6X2rSrYBpIziif?=
 =?us-ascii?Q?TcBChnsZz+nPGbBfib0km+1nbXGQJ4wDzpapR98leusN1gEsnSqzNceiJaQx?=
 =?us-ascii?Q?W9KWb3fWClodVYNIjn55PC+r3G9RHcpQE4yct/inMbCwds0wjjwTL8v28qQY?=
 =?us-ascii?Q?90f1gfyLrGqfc3KoTGVZizIIRWjydinoPGioD1ANxQGQEla2j+mYeczrL8uh?=
 =?us-ascii?Q?hoApfkXhT2zb0+18k+WRcBR+It3CjvXivVwidr25ZB2Bko/oGfXPD4a5ZGCS?=
 =?us-ascii?Q?M9fkrAukkGquFBcSokIZxsGRahOPIUUISPmMMmfMcfmkaIKZt45aeLvWmRgn?=
 =?us-ascii?Q?mIIjb3hsXu3WwZvugk56W7bOtvhqh1A9Npicy4bOQ3DJdH55dlsZ++I/Hsbi?=
 =?us-ascii?Q?ycW7FLFIZc2a6Mbu8AR46LWxviBEZCiextRK/hA0vmAnW6EUOkzwWL9IynsT?=
 =?us-ascii?Q?YIae8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qxkVDdVbfoH1szipz9vpLRcIBZTM9MZi7kr1dG/e/aKg9I2aKVD2/TBuxisASN6Z79De7/zeIo7YUSSghEauFhBu/rE+kiYh0Qquo+1kksk7HBiG2wr3AwGTqV1GrEIGQK3IdlzonnWs2oz0KZW/8K+QcylJCXqS5/J1UUpL+ERvND3UTMcT9P7dhCVnUr7T2dMB+QWdG+ob01ROX300pE5ygeI51lHzNXl+YofRrGMxWxvpAI5ynprvG86awnN5RnHj5TudbWbid1fuEI6SE8GmFF5+AEhzQto0zALVBDfc8hG4/aOnqH/2/wK5EL3TvRPZfHu78QbyyD433sNDVvEcHvwGXYyXHkEK4qokUNQ0tZQ7eQ+JzBHXtNLVJYoiXwmdh6oG8k3qroLtCSsec/1Hf7cpLd2FH7ke35y7FXMCA36ITOJq01HF8BYS9Zi4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:49:45.1854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a05d3992-58dc-49ca-ee66-08de633378c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9423
Received-SPF: permerror client-ip=52.101.52.33;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series extends PCIe Atomic Ops completer support to multifunction
vfio-pci devices. 
It is an update on previously discussed issues

Patch 1 refactors the existing atomic capability checking logic into
a reusable helper function.

Patch 2 extends the support to multifunction devices by calculating
the intersection of atomic capabilities across all functions, deferring
configuration to machine_done time when all functions are realized.

This extends commit c00aac6f14.

Manojlo Pekovic (2):
  vfio/pci: Refactor atomic capability checking
  vfio/pci: Support multifunction atomic ops capability

 hw/vfio/pci.c | 191 +++++++++++++++++++++++++++++++++++++++++++-------
 hw/vfio/pci.h |   1 +
 2 files changed, 170 insertions(+), 22 deletions(-)

