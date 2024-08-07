Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B812C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 22:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbox8-0002KK-AA; Wed, 07 Aug 2024 18:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sbox6-0002F7-7c
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 18:16:16 -0400
Received: from mail-bn8nam11on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2414::624]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sbox3-0004Xk-KY
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 18:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vosl6LaGuTADqC7UPmJKUj8G+RJlN9KgrV9W/0oZy1s6V0LcVGE72Y39VoxApoxsNwi0wPy6FRUOXAAEPaoU9Gyw0CywN80XvUy8Mq7o+soCn+xBG7tq+YCwURVv2TC+WhAml2XmfKw0YL9tASzPzqhVlhhY2nMgIJIxmSe7VuH+CNGSauLjfXPbV2Q4Mnfr53FILAllIFwnyhGbjW0Jtj7MUb6zJYG0T+il9dgGKQsHhmjA4fcDGgmqFYxdFCq3BBX1kVpnzSYS49xaGQgitJmu8uim/8PcD37F9pmsdfYRwKz6w3kiTzTs7lhL4hnkT1ZVk4vjwZUPDb1zb00GOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ePnhXCPGnJUi8223DO5frcKSnnRoAqEOp1j/CiZYRM=;
 b=kYIx80+yEEGvftToZCgZebhlWlMQhmAjQSNNR7os/pn+3H0eEP0gjXew3az2UADsMaHHLP06Qe3f1vDp5w4XZK1CA6lr1M5RhWHkE/0kHLk+vkaNPXCS7f3Xjvw94EL2d5ckR2yYteKI8dmlviXCNZ4DWKWO/8+otaUYZjuMBnDCsuON0N7ZUvpmQSS85G9vWImMaJ/WIzZELDCMORs5oisd1uU2vcgEwYSGfAIV6HMzq03a++kZeh9YYzdOqGkHj9zHYsiHzR+eGeyV50N9u7B40hBtb14LItVezlsA6HA0WCuOJKXCCyqPf9FSrwOPJrzW/9qVryQGBE9bXSYfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ePnhXCPGnJUi8223DO5frcKSnnRoAqEOp1j/CiZYRM=;
 b=sE3PIJuLWssir6CW+M0CzFgOACWLoPHVVMTgQz7PjWjTbJ/m34J5AHQvJsPdrNZWsv2aDFYbVS0Z2vPlFnJcv1MbB77O2j8tkn2Shtixkm+AqDwspcDJ6aiutPpy5AWf1pxz46FJZBkQno8ARPdJzeYtXNIl9urtdx5v/lWBcNw=
Received: from CH0PR03CA0374.namprd03.prod.outlook.com (2603:10b6:610:119::34)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 22:16:06 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::3d) by CH0PR03CA0374.outlook.office365.com
 (2603:10b6:610:119::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 22:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 22:16:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 17:16:05 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <babu.moger@amd.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 2/4] i386/cpu: Add PerfMonV2 feature bit
Date: Wed, 7 Aug 2024 17:15:44 -0500
Message-ID: <69905b486218f8287b9703d1a9001175d04c2f02.1723068946.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3cb444-3ad3-4b01-0ced-08dcb72e8887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AWfha3bqVm0P2h3z7UxjyZZUqaCLlQRuYhkNT4GQ3BK5YmWH70l66qYeNadt?=
 =?us-ascii?Q?P6w5zsGoCxnDz/+lBhsGwrFhfw7iijoydnmzkHk9N1Rbde78orNtR4K5MwMV?=
 =?us-ascii?Q?W1hduqp4mHTuGgNTqpRYAceGY9MTyk+Y5fOgshXAnJlc4Vs69NqpiRRfZkqb?=
 =?us-ascii?Q?Ere51GKHhqI1PVCscjOK00gbV3rjMqnozBsGkMOkEdLPh6Qv2RTnMRFA4wxm?=
 =?us-ascii?Q?KDaslISEO0F5eNPZBMyNzhTkHO4aYBiolQ9cOEbxphdLuW5wIIdd4b2BkdoL?=
 =?us-ascii?Q?S8c5TDuqzETLA0zAxmMPgwJCa7krrvBxR3DsroxnBZwUsl8UogY6elLRZ3fe?=
 =?us-ascii?Q?xoC9LFGXY19w1dZMcIGjbCoGfn+6aMhn1JFPFPn/VYlkPXVoQPzbUjPa8Kfv?=
 =?us-ascii?Q?0QXTnehQbdZcKrlYdIr93ZTAuDU9F9GKLJHmyw80FL9nsXp4yWc+Hpl53E8H?=
 =?us-ascii?Q?/zrhUMmct3yl5golpFAg2C/BA+pV5k0cTc4NvyYiXFFSwYOFTjJgx7QPWiZ3?=
 =?us-ascii?Q?yEBfHrZDOSj8EedNWEWVToF3iiMI93QxOivhWAA0gbBWD6N1SdhYAuf1iBXB?=
 =?us-ascii?Q?TgmGrvFDEwjI9YBYv5dzxB+2PRyoTm2KxV/nayNaeROJylBSrgF0iA6gIjzs?=
 =?us-ascii?Q?POm269sjFc+GfvPFeM1FlL/OTDfX9eLyT4lnB08mBcEeL6XiV/i10QlPCKqp?=
 =?us-ascii?Q?hVZLobPHO7AKIQofI7YLUisJ1ONwkZjEO+H99pMs1FOAT8EmpLZ/JbpTCZhj?=
 =?us-ascii?Q?4JAEcxHRz37smIwX+O8HhZPBRuS0sCSa13LKdlE8ldtrx8m4fsg63Jx0wMFf?=
 =?us-ascii?Q?hVvx76bHhO8RKXI+RS1nQKml5HfLAFGtEz/HCOc5h0x/FMdm5fdotXJAD8Fj?=
 =?us-ascii?Q?77+p2FGxHupckC6QDdOxRl2EHaFqpxpwzBO34Okh/UmFbFHMHUa+lbTIIAU4?=
 =?us-ascii?Q?15bbNrD1lNiP0TYlhIS7JxW86DA+MuTlyncRcBU/Xd2UOBSNxy1TGr4OxZ/r?=
 =?us-ascii?Q?QeofqAGCT8C3DE9MOCM1hS2dsHyxi+gErRdExH2Yhc9rY+vRaA7n2kbd5s24?=
 =?us-ascii?Q?PnFMLqMIfyA2ZApwPtIZCvDYaVz+7Vv/WicUwahTd2iNLqDwjZQ5lU+SVyP+?=
 =?us-ascii?Q?V6vYqWxbUQHluR+ttpmTr/cAh2D1yUN3NjZKIeiQzc9059a0L++93/Te7GNB?=
 =?us-ascii?Q?SCZrQOWL2vStx7eogJlSO9DmOqIzqyRI1yDgeJh9+pAqkitmjjiyhlSoEIqe?=
 =?us-ascii?Q?d3Zyeo0VQxwSywgPTsPAY5KlctpmXADlz9gNuffB1tZcYdtsXb4fRb3kLKSp?=
 =?us-ascii?Q?mo8HvUsASGW3iHqvNbqESbZK1dN4j1jIuv0LDM7NJSgPczorbB+OgfwtLmsP?=
 =?us-ascii?Q?LsKF/bf0CDKzvvgWoI9/VFsPI33JlZSEXdfzVAbbIBkqm1DBpCmJy6WcAvyr?=
 =?us-ascii?Q?jY+OR1ClAPmMFiaE1h9UoQo7fi5bC+lm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 22:16:06.4979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3cb444-3ad3-4b01-0ced-08dcb72e8887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080
Received-SPF: permerror client-ip=2a01:111:f403:2414::624;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

From: Sandipan Das <sandipan.das@amd.com>

CPUID leaf 0x80000022, i.e. ExtPerfMonAndDbg, advertises new performance
monitoring features for AMD processors. Bit 0 of EAX indicates support
for Performance Monitoring Version 2 (PerfMonV2) features. If found to
be set during PMU initialization, the EBX bits can be used to determine
the number of available counters for different PMUs. It also denotes the
availability of global control and status registers.

Add the required CPUID feature word and feature bit to allow guests to
make use of the PerfMonV2 features.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
v2: Used OR instead of overwrite for eax and ebx.
    Added Zhao's Reviewed-by.
---
 target/i386/cpu.c | 26 ++++++++++++++++++++++++++
 target/i386/cpu.h |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 19ea14c1ff..44cac5fdc9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1228,6 +1228,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .tcg_features = 0,
         .unmigratable_flags = 0,
     },
+    [FEAT_8000_0022_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "perfmon-v2", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000022, .reg = R_EAX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
     [FEAT_XSAVE] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -7038,6 +7054,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x80000022:
+        *eax = *ebx = *ecx = *edx = 0;
+        /* AMD Extended Performance Monitoring and Debug */
+        if (kvm_enabled() && cpu->enable_pmu &&
+            (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
+            *eax |= CPUID_8000_0022_EAX_PERFMON_V2;
+            *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
+                                                 R_EBX) & 0xf;
+        }
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c6cc035df3..549752575e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -638,6 +638,7 @@ typedef enum FeatureWord {
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
+    FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
     FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
@@ -1022,6 +1023,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Automatic IBRS */
 #define CPUID_8000_0021_EAX_AUTO_IBRS   (1U << 8)
 
+/* Performance Monitoring Version 2 */
+#define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
+
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
 #define CPUID_XSAVE_XGETBV1    (1U << 2)
-- 
2.34.1


