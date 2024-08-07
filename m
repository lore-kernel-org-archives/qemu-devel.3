Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9B3C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 22:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbox6-0002FV-Tz; Wed, 07 Aug 2024 18:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sbox3-0002Ct-I4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 18:16:14 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sbowx-0004X0-MS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 18:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0j2tHiDvINEiohPhutPgb86Uyeiug1QDC03QdARRwHe2mb6NVwyeSI3oj2NDZnNqA2cRwPU4uCI6edU4suZ1ETseeMLIlctMygSlXbshq4pz/6AU00FtGFCSWvKEQueNinkPnE6dAmGC/NEV/L07AWAg9CvmhvYBlHdQM7AqO863t9s5pY0MxzDUd4aixfbNPfxka/uHB7YiQUWzTbXDXT1rLlfnDfaN8dvwyshV5+SGaFFWy07Q0RLmIcmZm5iv2mZu+t3Z5v7UKG3ma5frYBURSd6P8cQD46bDg/jWV0v8nmtsuBsou/lGkyU52/7Lc0y2AB4igaKOAPy0J+qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CofFptYar05/0RJpMgT1JgL9kX2pQSgZbcGMFlvVhWo=;
 b=vp8sN1zFkUDLJsStu7h+P0dcb798uu2DUC3M2rvvyKPNNBCiGZx8dN1sIps+zTl8W3pRA/UoYlwbNHi2Z0MH2HEJZMddHeH65UMXjaIcp33BGk1HIJcJ/loIvjc9eRY8Jlgv9e3/056HXdFRQWYjHdJdBqOg7P7lcN05ZB1JFfcOZEZcJGADE/JTDQbEJ38w8pf5SvEIU4GHzf7p6EtJzd8mxXyxTazb+13p0Myfjn2lw6KzUWTuydBAL9TTYUP6KygVH4gym8Mcq0IofHj23B5lVTr54Z+cm99E/N/UocWNgSXcEFmlS0s8YlErCBcln797300CkDj6Tzw2BQ4Ohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CofFptYar05/0RJpMgT1JgL9kX2pQSgZbcGMFlvVhWo=;
 b=K6ImRLwZ0WU3NNa3ZakdGokBuZoUQWm8Qib/otE9v5Nmekd9QVG+Ba8P/eqEOtKo8D49+RqAARwo5xypge8hS+zAhlpHSbSb+rY1vWGaGhFpU3MEiJThaKqrCEx6CDceXzdA1hr0SCP6A2X/oTu8wjkB/KYfv3p7uZhOkANsbjA=
Received: from CH0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:610:e7::25)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 22:15:59 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::91) by CH0PR03CA0230.outlook.office365.com
 (2603:10b6:610:e7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 22:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 22:15:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 17:15:58 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <babu.moger@amd.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 1/4] i386/cpu: Add RAS feature bits on EPYC CPU models
Date: Wed, 7 Aug 2024 17:15:43 -0500
Message-ID: <244f99ea203d026c5e41aea10614465e6daf5e87.1723068946.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723068946.git.babu.moger@amd.com>
References: <cover.1723068946.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 0452ad31-5bb9-45bd-cc63-08dcb72e8462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NyuHSVRHqL3Y5uBXB8GfWH1rZx7/klKq9QUQgj/zspsyLYPk37Z3rzoHYxDD?=
 =?us-ascii?Q?7Ua48CPj4avd02t8oa3LxgDRVam+HyQxThM2jzpFNakB/bj9t3cms3J50Xkp?=
 =?us-ascii?Q?9pFj7Z8SJaFwMBA2R46d87JsafCJPMZO0lNXcUtpJL6NP9DnTOgJSHIg16bm?=
 =?us-ascii?Q?nYAq+kQDi0OiC8jN0R8kr94/YGafI+LdoNydKlZr7oYXqYqp9kBPE5RyaIpG?=
 =?us-ascii?Q?7K2sFPx4F0fO4rjupKvXijQ0cYUSoFtxvSDb6o8TEQDV3Yncto1qOQnBbF71?=
 =?us-ascii?Q?VevrxoBWpz+RXvEEJ3uOED9IWzfG7Ub/8xMXlXOrc8aM/3z3cuwB2RUSfS00?=
 =?us-ascii?Q?dWS6tf4EmTO/98YMOygnRpDjNFVgsQAeYNLjbL6WoJrsVs1mbSnXcPq2GZ8S?=
 =?us-ascii?Q?mEVv4tVr5vIkl7rMO4RI1mRMh7ToabHd2tw5NGO8XCrTdiFbt+sJmk2FY/mb?=
 =?us-ascii?Q?+6AXZRMG+X21yV/jHxb6rzP/JytnAmJ1ZA8zTcEwRl0ZXBQpAbBGym/oUHvU?=
 =?us-ascii?Q?pINE+yJZ79dK14gkQbtaQQQxng55YPxTCzu1BMgzi0CdurVFprtAIEAXExVQ?=
 =?us-ascii?Q?2mEoj/MZA+UauMNOZt/6RjwZm31rWdi7kSkRq4zlQx2NoxvO3Y7uoMfR7w3p?=
 =?us-ascii?Q?i+zKsQhZQqbphX5SKm1MVSGVTaOYOjVS8hmUm64GEPD3WfAwdzHQWiwmbZyh?=
 =?us-ascii?Q?K9CU9TSDbvcXQ4AhjLxyRwktam7p79jcER7VKLxVntyWtJIMGDstZBJXpaHu?=
 =?us-ascii?Q?pK9T8OzyomMeTpgZSW+F8ZTBOwWM4HR9qSF/Nyv/EfnKc73CEatV1UGPN0E1?=
 =?us-ascii?Q?v3a5XAK2fzo9z93K48P0wDdkMPYn1Jp+/Q8c5wRi5BhO0NmQ0PzPpORL/Rj2?=
 =?us-ascii?Q?6A8keMT/r3hwq+pPvW548RUoa2bC07wHHx01bblfKUGj6jZoxkyk3eVenu7h?=
 =?us-ascii?Q?HLjsT19Let5du2fwWZA8qba9tX8v8wgTMaUeit28OCxJ4/Rx73qghfn/9dFT?=
 =?us-ascii?Q?+TLMKaK2iYE9FgOixomSxILn1sIGCZOhzySIZEkeBd6wDznvKVJc8E3ja0X3?=
 =?us-ascii?Q?ZR/YsgupSqkDZNCWktz4CHU9vsIvFjxXXQXP8plv3rpwIn9RpZb/lu5xqh7/?=
 =?us-ascii?Q?Zg662DTvEhbUJieJUcADo23b9obWQutMlex62kP+DpdeLNYoZPLBYrW682FK?=
 =?us-ascii?Q?IYFIiqx5j5dD7FQMlbLjqXSB9uam+A0q6lKeyKuImm1R3rOJ0LDvhY7+IzDE?=
 =?us-ascii?Q?7983BjQ9tH8qK0gjWoALuexnPUM97m0mvh0BLfhEtAyOVzWEC8ccTqv/XwUk?=
 =?us-ascii?Q?h3+t/u2wuXCu35uiT/FvrgMHbMe/78WPgR5xlO8jIu0JG1l/8B+g3H5yFQpT?=
 =?us-ascii?Q?P+oZ/rKgTkQR5t7RKXxPkTxcEwKpwzxQP35mhmnyVHslqi7XCRnCXeryfasM?=
 =?us-ascii?Q?1kL6DK6A08UaHID9nH4edgRU2IG6MVSm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 22:15:59.6432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0452ad31-5bb9-45bd-cc63-08dcb72e8462
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the support for following RAS features bits on AMD guests.

SUCCOR: Software uncorrectable error containment and recovery capability.
	The processor supports software containment of uncorrectable errors
	through context synchronizing data poisoning and deferred error
	interrupts.

McaOverflowRecov: MCA overflow recovery support.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
v2: Just added reviewed by from Zhao.
---
 target/i386/cpu.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c0..19ea14c1ff 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4968,6 +4968,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_v4_cache_info
             },
+            {
+                .version = 5,
+                .props = (PropValue[]) {
+                    { "overflow-recov", "on" },
+                    { "succor", "on" },
+                    { "model-id",
+                      "AMD EPYC-v5 Processor" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
@@ -5106,6 +5116,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
             },
+            {
+                .version = 5,
+                .props = (PropValue[]) {
+                    { "overflow-recov", "on" },
+                    { "succor", "on" },
+                    { "model-id",
+                      "AMD EPYC-Rome-v5 Processor" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
@@ -5181,6 +5201,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_milan_v2_cache_info
             },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "overflow-recov", "on" },
+                    { "succor", "on" },
+                    { "model-id",
+                      "AMD EPYC-Milan-v3 Processor" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
-- 
2.34.1


