Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB38C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHTP0-0005Rz-SD; Wed, 12 Jun 2024 15:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sHTOy-0005Rf-Nk
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:12:56 -0400
Received: from mail-mw2nam12on20625.outbound.protection.outlook.com
 ([2a01:111:f403:200a::625]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sHTOw-00036G-PM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaRJ+aUJJbbcOlZkG7m+xTU8O1fUtLYzS8reCGnJ96J46lO20OVgz3zmX2CW4L0VHBq4w+wCm+yHz1anC7gIEvSWdOVutubIkrhImtjrzp/kPiSHHkv/bD1rm6dXLVFqC2aKLZCGw6oBLBI8aCCrsGPdZx4uyIlqky8Y9LnhfbtrnVqItSfD+FRm8HVWgUOvIc53s2csnV+QvJHw4tr1v8UAhNCXvbDmSi5jbztqc9bq1U/8//7XUIoHrYOVHkRdqEf4Gw8nooYyrJkkd6fE0Re9OQx9n4ZnV1w8Nx0C1BF1BD11JtFr5TIHn+LCjwC5LPpyCAqbu/hFCdUeT95agQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykuErh925Bawa9JzeJNSiMPO045peBhyieAwIUdC7Nc=;
 b=KYNrLUHYBvNTLpa8dVHhyKoB/CASWdmHvPZJd7tieim6UVjcq91vvjzFhrEpqt5gmCueDTgCjdUgsi3JJZZTqxoCQhJIWC1K7cfDYqJheu7j6vHc3J4td+T1ZzU6VCFwbo+H16mgQqVM5tjeJeYvxl1rehmM+TCnPfuASxy9yaoQml+Dq0YPy7JLXoynC1a3yTqDbaDg7fEMtA8QaQKJVzC9h9oNq7OPtLnluMHrIjtgOG3v5Ro5ECjF0cKa1jcnVt//N9TtLRQ9fV3rejbXCyGvMgxKdppS6tvbbSKJS7rQffDTR8DpIEYIex+rOoOS5HGQFtf7Mi7WDD4Uyacq5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykuErh925Bawa9JzeJNSiMPO045peBhyieAwIUdC7Nc=;
 b=3TGHPA6f8Cv4162tRDdN5zyaSlvZkxWlICHNjDXGnL94wd36Yk3BrWQOhhgrhMgil9UFzqpWfveAGe1bs/qKmtsF+Sz5kg8uet1fVH45bhZJT0VnDpmkSz3rsHCfCT84jEGPsoghF4Yeohn/zrEee+B3g1RhYJ6No8sgVsv3RC4=
Received: from MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22) by
 MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 19:12:48 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::20) by MW2PR16CA0009.outlook.office365.com
 (2603:10b6:907::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 19:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 19:12:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 14:12:46 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, <babu.moger@amd.com>, <kvm@vger.kernel.org>
Subject: [PATCH 3/4] i386/cpu: Enable perfmon-v2 and RAS feature bits on
 EPYC-Genoa
Date: Wed, 12 Jun 2024 14:12:19 -0500
Message-ID: <1dc29da3f04b4639a3f0b36d0e97d391da9802a0.1718218999.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718218999.git.babu.moger@amd.com>
References: <cover.1718218999.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2f0d76-0f96-4b07-29e1-08dc8b13a5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|36860700007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DydfD9/YMEwV5DQvmXw+yi2ViOy9KdbKopBz2oGzVni3cjmzDiKnmJomBsFx?=
 =?us-ascii?Q?cQSUS6XvglyU23Rb3ZfM8gUjsEnpoRCBRKD+BU5F0Ixz8bpvIOCOyYzZE2BF?=
 =?us-ascii?Q?1oYJECpRfuTj7tP078klkmzVhhPnpR26+jtilYfADXVx8W7vlsBMYltKUE9w?=
 =?us-ascii?Q?ppSMp1cT7wexE9a6hASPfzhs+QRfcbP9VGSWMRBlA0hvGD927qBLNyOXiyFf?=
 =?us-ascii?Q?h/Xqz/GT6BkDGdN0wsEAXgisv/ikbmOHCTQ/9eYxUOr3+qWY5OHWjk3ka8Az?=
 =?us-ascii?Q?DZYj/I0uQxQo7VRjAavdrHL4Y4Sx9I5oagBX6MMv7knmsRMXFnocKbq+HHmr?=
 =?us-ascii?Q?GrwzKT2jfP7WpdXDZq7ljlRVNLpE84bZisjpG4AE9Vj/uEXB+wdEExW5HfMU?=
 =?us-ascii?Q?+IV5WjuFJKTYBmxbboNMNoCJyisNDy45Y2hc4TdPaorcP725mim+Arieu6ET?=
 =?us-ascii?Q?3It5Yn/AaalkJjW0WoW15xmAHjqyqKUofSegT+savOeC+emwuljN32Gpqiwh?=
 =?us-ascii?Q?yJMy8tTBsUNsMj5rDJYJxmZE3sQriP2jpEU8v5SwsYrpumEwtU32BiSNiiaE?=
 =?us-ascii?Q?/Vq6/KzDe+Kvwf7zRlwjnPb/lZOmYQcNm6SpuAceIcLXJpNeIEPM73gRrfqX?=
 =?us-ascii?Q?mAC4cGC6cXpsvztK7Ts0/dDl6DwKBOjwd/5VkdEfoDMplrL2lwc5SHQll0Dh?=
 =?us-ascii?Q?NP/M0G4ZDDfOWOFnQELbxMhq0tmu1GMUqQYcKRzWadAseGTtTB16BDjQITuy?=
 =?us-ascii?Q?Yc3z2arE4qkkT4V9wQoxPOIApZMAL3z1380NUdma5Tfv7v1G7mr/27cP35wC?=
 =?us-ascii?Q?vLy7I0mBWwgCPvC+mHGzDWc9xdDe64NWtEZC2oJCHPx6v38jIBOWYaVtq2xK?=
 =?us-ascii?Q?kWM21n34GDH2ddf7ReEPHDYYFno8/JdzPorHY0WVuyntGdKdoJ/qiLvqtkH/?=
 =?us-ascii?Q?BhChceLXNOpt5+uokoRTVFwTz0TKreaqORecZNU7ENwp0eAZ6BXh8f3PwoZ+?=
 =?us-ascii?Q?S0hWm/xPU4eGxXYfeX1g4S1FVQFAjJ6fZ/MJXDO612yXV3ZIHD9L+abdGJwb?=
 =?us-ascii?Q?P1WQ9E4j4mIrt2nnAFo+XWYvUyo0njzBtosyyeuKz4XtzL7ui/G7cYck1G9/?=
 =?us-ascii?Q?2jUBjZurJ1USYDDs2z9S9oqNIfSsm3BUfC0yCvVielOQEH2bhXD+xCSLaHUv?=
 =?us-ascii?Q?PnbJJr715L1R/iaHT9WRVko5fnde8xmW85wG6jtdADWRYVItUVYF++TeOuDa?=
 =?us-ascii?Q?qjdRw4DftQNM2wPqjhYCBPnCgwMCdLfcE96aUzoDR0N2Tzgr4MouP+0aN3/u?=
 =?us-ascii?Q?TYUw1UzXTuh7U5kPKh6fxgyU/xHXu48Nlfh4qFSGQiFIq07+D6kRyDza1pI3?=
 =?us-ascii?Q?lpiM//A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 19:12:48.1080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2f0d76-0f96-4b07-29e1-08dc8b13a5f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
Received-SPF: permerror client-ip=2a01:111:f403:200a::625;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

Following feature bits are added on EPYC-Genoa-v2 model.

perfmon-v2: Allows guests to make use of the PerfMonV2 features.

SUCCOR: Software uncorrectable error containment and recovery capability.
            The processor supports software containment of uncorrectable errors
            through context synchronizing data poisoning and deferred error
            interrupts.

McaOverflowRecov: MCA overflow recovery support.

The feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
 target/i386/cpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7f1837cdc9..64e6dc62e2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5272,6 +5272,21 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000022,
         .model_id = "AMD EPYC-Genoa Processor",
         .cache_info = &epyc_genoa_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "overflow-recov", "on" },
+                    { "succor", "on" },
+                    { "perfmon-v2", "on" },
+                    { "model-id",
+                      "AMD EPYC-Genoa-v2 Processor" },
+                    { /* end of list */ }
+                },
+            },
+            { /* end of list */ }
+        }
     },
 };
 
-- 
2.34.1


