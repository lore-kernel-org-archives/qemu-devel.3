Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C730C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3Gn-00086F-5e; Fri, 14 Jun 2024 05:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sI3Gj-00083X-R2; Fri, 14 Jun 2024 05:30:49 -0400
Received: from mail-mw2nam10on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2412::626]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sI3Gi-0006xN-4G; Fri, 14 Jun 2024 05:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDnjiKbqr3+sBj3NjNiPLLaZfy1toAs6AoNEafHP0IXpJsH2TfC4mMSivFe2XOY1vfmYJVRRgrqenVHeVU/xTFL6Ck0ksGalnAn7yk6yG11wcun+PVso+aGAVRxnObgu3NizFJwp2ykUqESFBXy6FIwNWersipclynWjWnjXXN39FV9o5/4oNn/VZoHYOG57jdYUD0tgIjHDErAAel7thUTJiN1DNMDLhLlUzXr6TWeV+RkgzqVyO06AGMfDhoKHUTojNffK8iK42LuoG7rv8/kzIykLYztTg+BDfz35TVcw+Y/b7VeQpjoTBAVY531xrKoEJ1sTlX5KsrHWmhWkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyNBX4L1WkbunR5hjsblvsULo3b072zs80fc/CU/47o=;
 b=guX3VntTak8MFcgmUicPEGekZJvVPXoo1UBWey7RedGD5yEBbZircaRsEOEtByzSLn9UsutxfaPbjUFOwhbY1WVWHvdf+h0MPWGlzfC74GW4AdFDTKdeWd+UTFuJHNPIZyn94nKfLBPqtze8yXHwDRhu2s63L/WU8jSjgZgZEGgd7Qr3o5ZPJgVh3IMKy9UronsmHgV5mCNTFFO2kNcjNEVe4ElZXurWzO2xOdgdEQliWc6ScM+gHwN5kWGgH6a8gQ3HXvmDP0wOsSu5T3cLpl1JB6UrmgxK99ZB1cyNdRDds4aD7gh/emlcVwTvc1O9V2BvCOvmp5aY8WjWEqJjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyNBX4L1WkbunR5hjsblvsULo3b072zs80fc/CU/47o=;
 b=FdwIu92q4Nu5THIGSPTaw2vjQg0sY6NIcCGED6Dgi1W8YOOJmWz6CiM1Ew3dEMRQs50p0D+0qPyILknd4LPvWQudoPMgMINlI+1uVsXm0mAdSI5Kvl6n56eH42G67efti0Fzi/ULJD1R//z5R0GnYaex+cEMbdmsBh137c9zJuo=
Received: from BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43) by
 DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.20; Fri, 14 Jun 2024 09:30:41 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::45) by BYAPR01CA0030.outlook.office365.com
 (2603:10b6:a02:80::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Fri, 14 Jun 2024 09:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 09:30:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 04:30:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 04:30:39 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 14 Jun 2024 04:30:37 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>
Subject: [PATCH RFC 2/3] target/arm: Enable dcc console for a53 and R5
Date: Fri, 14 Jun 2024 15:00:25 +0530
Message-ID: <20240614093026.328271-3-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614093026.328271-1-sai.pavan.boddu@amd.com>
References: <20240614093026.328271-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: fc110b81-cb98-4c80-5f91-08dc8c54a869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230035|36860700008|1800799019|376009|82310400021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WW3fB9gYZCTs7tqD60KDHrPod2heGUeZlDKRyz2f7sSxrcXiElQ9jxSN86T+?=
 =?us-ascii?Q?rt+LIQ6ZReaZmPIVmUez5lh3d/Wsc9pTTLN6MjE+Rxi6m/BmV7HpUVyGoG1j?=
 =?us-ascii?Q?av1ANKuaeEnqzDZyXjfgtYNOzZVxaAE6Tg+WlJyG6ZaphTTVepE7XnRcTR61?=
 =?us-ascii?Q?H6BWyzfm8Q/zlC4FOZf/D96iHdSqToeNrCZ71bGBgoDMloiPW31qA2tcw2g2?=
 =?us-ascii?Q?vyulQTPe/GBRAFEjR+iF3qXCAuI31mQ3n2n6C3dWrB+8bcQdfc7H116+xY/2?=
 =?us-ascii?Q?+lFv302vYqTDLVe0JVA1/sdaTOQgDdWFNnESyx8oTyV/u3JJsUbwGxAkjj+i?=
 =?us-ascii?Q?u3Rn7MelDerpHavdKfBN/t4pDCZca5ivKkbY+HJ/zIE0kvB8S6Y7HCT234Ug?=
 =?us-ascii?Q?S8DBFzWa9Z1Kkwo/T8imHBJEadiUXWV3TWJrHZya5uiJtvROwrhgy9Tchp+R?=
 =?us-ascii?Q?KUjHnIkf81SlUCN3QjxJHG4GVHL2g3VevLwwFXjKzF/dzkSXeo/cET5m7Z15?=
 =?us-ascii?Q?joHQT3E5MSIR2HCWtuNfS+uFjbTmE3b8wZ08bP30nFFAXyL8dDerB4GI7k91?=
 =?us-ascii?Q?eGVu/ahBXS9mpBkZNhgSA0KSDhlTFb+9k0/O4Yj60UFEeWbnh60Kowxru5XV?=
 =?us-ascii?Q?pevg+vnu5Jd8oRtoxGKzZ8bhuuLE9xYOOg2447ly4XqVFwfIJ9K/aHBR0RIn?=
 =?us-ascii?Q?LDK+X3rzls3Oqg7dIflIwMSngQKERK0MdyXM8gWWlZEVxBS4J1SRfMxszY+0?=
 =?us-ascii?Q?C10555dyUh0TZ+IEcezVsrKeV6tX3z0IiueACAOUBfnwXFEASNuY07vsyHko?=
 =?us-ascii?Q?TebTlKnxQXUSR2Xe5vPcxqtygCG2Iz1nOOmuYFlRiCkAfc6efhRrCdIbRfSw?=
 =?us-ascii?Q?dem2XzxWMJP+PEr+CGoavy2hRclm0jUQLnAZuzzkM3FrceFF3fQypBFQMr8z?=
 =?us-ascii?Q?exNDvLrYh0qhR4nfa4UmtdCjHAvBOm+vCkFvVJH7YgqAkPSFbRxjJRXsSfIx?=
 =?us-ascii?Q?8EICSlChwSvO+OgkOOhsJuREqjCzD0pnsfVe2jwFvipS3shBMz3O192Jp7pO?=
 =?us-ascii?Q?PFDvvlhbUYN9v38Ob5VU9447SWhW/A4wL6E48duKRwHuYwJT2qEWFfLhXEI1?=
 =?us-ascii?Q?4x8dZAdFkDfZosemiwJAzTNP73TB6ivOEM8Jobc6WcISCUq4Ovo9N5I0mXlO?=
 =?us-ascii?Q?bt5pFcKBLTSQTIQxjYxdnpbjX8Iyv+AUHeLN+a14h+3Jvl32fZENVGjCrXVQ?=
 =?us-ascii?Q?C4wIWyDHkdADCyR9JerVAkdNk54rZb3wwIC2wog7Rxr51yJwlS7iBOfDxaP9?=
 =?us-ascii?Q?8eH43fzQZi7vjV1qckUF+jhYHTPO1As/HgwuSLCuEfZnHseE98r+2a/8v0iq?=
 =?us-ascii?Q?aMt1sZeqXKyT7h087nTp+MCn9lVfyrq4xDhBf1DXcTsgdsEPQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230035)(36860700008)(1800799019)(376009)(82310400021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:30:40.7106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc110b81-cb98-4c80-5f91-08dc8c54a869
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
Received-SPF: permerror client-ip=2a01:111:f403:2412::626;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

This enabled DCC support.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
---
 target/arm/cpu64.c     | 1 +
 target/arm/tcg/cpu32.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 262a1d6c0b..e39740303b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -667,6 +667,7 @@ static void aarch64_a53_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
+    set_feature(&cpu->env, ARM_FEATURE_DCC);
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A53;
     cpu->midr = 0x410fd034;
     cpu->revidr = 0x00000100;
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index bdd82d912a..b0ef51a9bf 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -562,6 +562,7 @@ static void cortex_r5_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7MP);
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
+    set_feature(&cpu->env, ARM_FEATURE_DCC);
     cpu->midr = 0x411fc153; /* r1p3 */
     cpu->isar.id_pfr0 = 0x0131;
     cpu->isar.id_pfr1 = 0x001;
-- 
2.34.1


