Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43CCC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsDsr-0004Lh-2f; Fri, 07 Aug 2026 02:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDsd-0004JC-Sb
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:16:32 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDsa-0001jA-Lq
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:16:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EM645L19hWxbdiSedAL75Xrm/BZg80pM26m9IYW+T2pJ4hZU88HPeF1Fb9Id6dCkE0GGXAnfH1hFYNvZkoF1ybFAHKPnePcG4oDxPbWSmEhJavg0rbFvTtSMKb40PSibfa8UTYpYJLCzU5iGsXYYFC1hMZGgDKm36tLty+VZSxtQiZtS9Raya3kK34Uxs7FEqFqysV9vVK3qH7Er9GnwZr2k03f8xysiusB1pYaSFx1nvyadwsDqthP2e9cH+MDB1LZVPuxOocLspVNb5y9uUPinQr2N7CBNgMdF3Hr1WQuNReVdEuIT+qr1E1vVnaYYy8EHn8xYMA7le7jiGHwVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptvZ+4CrL99xywAajeciGhTl+P6Y2wEdpxlB6DtH0pg=;
 b=y4+Mtnhv0EpMBxvuUbgwQBRiQjJ1CX9oQuY95RKl9jYWXl7/+nXjTj0SfoYKJmazFPUL14qRFs+IdpB6ryu+qTyvx8Pd8hELirjxZrmS7bCyKOGy9+ZaRdCVwzbluuASJetweOkSITfUtiCY9Tfc0vf0j7AP/5aukArgG4ffuaSpejOWM8m9CvHzzCb8efrzuTYYkH5CxIuolQ5L2wmjKShLz5ibWjKLfnCrfRIT4wGC961FFBypH+uETsI+IIKKItOO+6IoxzJg2ZNinjqS5k1lAMbildLn0HGqMtCCCKf+jXgVJ4SB8U3CCtYg8z47rKVeNYJQ02W/V9PyCwdTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptvZ+4CrL99xywAajeciGhTl+P6Y2wEdpxlB6DtH0pg=;
 b=jgAjKbsH0pGHb+BUhePZRj0gaSAPyjI9zQYSD7JwoFtHv0Bj6uTTtSwpn4kDyzkCUXk1tBB/Mpwwu2Y/VaV14Fatogx0AFNjFaaT417sENxiKSA6YxuhZMrSDK/ivs3z0UTC/vWQcTotcBEHuAY6eIjH5h7a1TvIg8xfv7/YX1I=
Received: from SJ0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:a03:33e::8)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 06:16:22 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::6a) by SJ0PR03CA0033.outlook.office365.com
 (2603:10b6:a03:33e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Fri, 7
 Aug 2026 06:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 06:16:21 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 01:16:18 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 1/7] amd_iommu: Return empty efr for stub call
Date: Fri, 7 Aug 2026 11:42:44 +0530
Message-ID: <20260807061250.27739-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807061250.27739-1-sarunkod@amd.com>
References: <20260807061250.27739-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: acc1a0e9-c659-4230-f6e1-08def44b66ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: t5u8RISCClrR7EGgfPJUEGpmzRHKC5N9l/aZy/Kh+6xWebZUb0foDU36EM1j0zlpEiFdBo/jyFdR2kDDalCOfFJie68yZlze+1Ij3EFTt53v3RFd/t9QUOiKO64YtYdmP2y/JxBanHoy3I3gTl4ufhrzHZ/cS/RDwGegDsagj3qYJfAvD551rogBahx9qqsHqlf5Wsj5xB/ew08d7CWf7g4zEzoOwGGJMXlx5WKE+Tp0fu8jfd2rNOHNdicKugcZgYUon4m7TQLymy+fvk66m8Nwz3Epd+exWaSxHokzApsLDrGBpmGRFlaBz2+U8YBBmUxCewAaq8puBofQD8RmGb9GB5Z6YbO0ljjr3D75ARLeL1qiQZh5L76hKwGfa1EUS5mrK7/W5s9wkdVJWLR736UI666/gHzSrd+eS3HjTwkAeCPLaHWmSDoWF4oEpsd0Dl1CUfBubvG1jStTq4JniRx/XgxHL9+bgCUGH/LGLn7nHQg4IeTBBk49TbZVx3YpyTM2ghjfHucuVnrmkh+e3l8nWu8W7O9H8EXCQhq5KuFP8lcZxG5i6pyDlrPCpUVWUid5De6cIXJsjHMIt/SLHJwWBTROCX5X/ABYWQ9HAmPcbb62wHQlciiULW95UY7yFHAqctjhfyjQsg4JOon6qC7krx7d2yU4QMITctt1axmX2RKr6lIWZ+XS1zABfFjWoRXPX4pZofuzkTYNEgw/xA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ANaHglmuiNmV1sTByxpRPO07jbPBgU+DlatJVK4jG5eCXAXfy7VIlIeJUiyrfVDCAetZWzEpGxy2d6yM5UQHf85mXaspvCMSUlWi4VuqtQNknyt0NmNC3kk/dJpG7af1wKoZzwMVfvru6N42pMIN+t8mlX/tY7B/Pn7LkCgdTmnjuqvz8a0w1az9y8dO/yo7EU0xyiagG6cOh+dU5lgvlSDbcYI0PcfGGx6x9mnPtJImW8jdUHTZQV6SWAFmNGpF4bllQFVofi3/a6BIqn+FcpW30vMxN2pPejpQ5xRSqNC0EMRmUYCHYL6qikyd+zpvPTMWW7rVA/YItGORvK/CwbjpN/NFWSxhR0UOpd+cTOJOJ6aKWWGlmSVGW78jnqk7f1e4UVIqAGJTwwt0kUKf+7n+lL4KzukKEONsUIdBL2f12fxxlrLzSX239lyFl26b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:16:21.5765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc1a0e9-c659-4230-f6e1-08def44b66ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Sairaj.K@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The stub call should not return normal EFR as it is used as place holder
when actual AMD IOMMU calls are not available. Hence return 0.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu-stub.c b/hw/i386/amd_iommu-stub.c
index d62a3732e60f..fb36dee903ee 100644
--- a/hw/i386/amd_iommu-stub.c
+++ b/hw/i386/amd_iommu-stub.c
@@ -22,5 +22,5 @@
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
-    return AMDVI_DEFAULT_EXT_FEATURES;
+    return 0;
 }
-- 
2.34.1


