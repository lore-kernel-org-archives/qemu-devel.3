Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F14C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg7Z5-0004Ex-3B; Thu, 06 Feb 2025 14:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tg7Z2-0004Du-Bu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:29:28 -0500
Received: from mail-bn7nam10on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2009::612]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tg7Z0-00024g-5Z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:29:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AV7hft2Yj7SNXAvOuM8fop5yq8WZD1f0wGvzlCGbV+gFCMzT2OQ9ITl3oVP/ORpwhZBZkNdyHvyu0DDEmZ74FR9VwM49MUDoS1mTvOwwBHJICn5f74ml60OQ6rksdNsSEpqOIXyAkTKD94+S9Z8pYRHavQj6pSGMBiBJIYcwtXOizWOEWXmG5ktCzOy9MoVue112GH6FLOYn6ZVtFD2B8s35s+2vlIB8HiOM/mRRqOLYXMbp4uXDJNTUgzK8lXOqd3quwlNP3PRkvYGpBT2fQcbe1t7F1q97qu1X6jvOdFhjQe+rtG7h9Dxhz2oMnGsPWaVeZEH7klA+auatpf3L5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KyAjcc0jPA2MnMLy55U84dFEJkIsfPVL+ezeWXXnjE=;
 b=o4jEKGlWGMqTK9uiQ1yvyk/bImAey9REQucz3LdQ+9trcX5LTC2vM2uKWGF9QNMCDLqAW1Vc0+5TLH9AEqYvJZhFctQGnw0BEgDZRGse6dBjc4qNYr7HDHt0ewd33ggX1GP9SPd50j3qttHmePftEBtNohEmBl2TuMYIZGEjaiimLOhfy+gg0/NKiulAd3Sb0RMSFkG20VYK7SoDndufSrWNCXAJHCy2tFhFjIcnTYwd2OT/7IAiuFOQ3mvRP9xfoEy5V+ugr7ReRx20zvrdRMFWMn7D5BTsKVZeJUoUg/qF8hrEJS7r535i9bA4MREIOYBstyg78s+9Z9tc4bsiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KyAjcc0jPA2MnMLy55U84dFEJkIsfPVL+ezeWXXnjE=;
 b=E1ethhCve3AFv0JUTHwdip0JxTi79AMdzp92K7NVlv8K7dZ84WhQn7rZLEXOR3tYHsHXDhQG9gWJhMgFoO2fs6tquaespIMYh3fkwHYt4nPHaFQfmXbR8t1kDY0CCombZwryJU0a78bETYW+pQ0gm910nbG21A8l/zMGvRUJTV4=
Received: from DM6PR06CA0064.namprd06.prod.outlook.com (2603:10b6:5:54::41) by
 DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Thu, 6 Feb 2025 19:29:16 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:5:54:cafe::55) by DM6PR06CA0064.outlook.office365.com
 (2603:10b6:5:54::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 6 Feb 2025 19:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.2 via Frontend Transport; Thu, 6 Feb 2025 19:29:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 13:29:15 -0600
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <zhao1.liu@intel.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 <davydov-max@yandex-team.ru>
Subject: [PATCH v5 4/6] target/i386: Add feature that indicates WRMSR to BASE
 reg is non-serializing
Date: Thu, 6 Feb 2025 13:28:37 -0600
Message-ID: <ad5bf4dde8ab637e9c5c24d7391ad36c7aafd8b7.1738869208.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1738869208.git.babu.moger@amd.com>
References: <cover.1738869208.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c93e9da-6cab-4275-3670-08dd46e48ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J2ICcBm8NnudvTFKqAXEzw1kjt7blzkL2OD9tfMAnqyNUEGQK3M2maOHfdJr?=
 =?us-ascii?Q?Ow+e4aSZs2ja1ZV16jx6eYOnVIsfQme++OTQhCpm3OvvHSpZHJF3mJue54GE?=
 =?us-ascii?Q?WrvDVIztgZq6AwYEGRwyTfJrAPRpbC2o1zAXKZgSCBlhR14062aJpQLGjDEx?=
 =?us-ascii?Q?o0GTs2Fn1u6p+8GyiCc0e4TLCERwwl4mXQn8WnL08lEinpnynvBX19Yu7e6L?=
 =?us-ascii?Q?NVCmXz3l+ksrf9NJ8Q8eKuOhh0fb+v2veDkPwmhCXojn0Q5P9qc/emlhNNEF?=
 =?us-ascii?Q?54n7Csah6MoHIqR8y4mq/fjWOa327qEBOCPWaWTRDh/mMmrGm9txg5Hldpw7?=
 =?us-ascii?Q?EqXDu9vnG8ypyHEiUqmQwYkP+ooJPLy/NEvYLGSuvIPakF0F/TmvsP/adMkQ?=
 =?us-ascii?Q?V2TmLYBEB0voB1kCaqH0FSdIlDeAe88iGJWLDGRU/Py7lrXV2yxEI9e8FyF0?=
 =?us-ascii?Q?2s1GvgkLhvWUVLjkvrUDmjmoL7UZKZ8fmsNj9DQvQ13zlK6tRQGc8/Yv5wYD?=
 =?us-ascii?Q?Ecc7TWQWT7sRHQn7yQmlVyL+ny9qrYnj8nyttdj/TPXi69IlL99E/THs3N7p?=
 =?us-ascii?Q?HlxfG5cS4xbJxRL0JnOduH2mC2tFVXfct3DRvxJQLP9l5L28LBC6iwpnOqXj?=
 =?us-ascii?Q?B9jRr9BHyS5LIZmUtayQuLEuawVzoLJFNJYkqBMlCfdn+rIUwx2xl1Ft6DSs?=
 =?us-ascii?Q?hOfLdyWNPsaVi96FNEV+GnHMiKKbO6ZVptSp/BgQ258h8Z0hOM5I6Xdbjxzu?=
 =?us-ascii?Q?YoHXHjU3+6vY8YV/i2+vBy55lWVyK8s+UudLRmjnXKQybP06JPvwjjNVSBoH?=
 =?us-ascii?Q?kdWAklGESySenFrbk50ppnmI2w62sgIf9MSSBEdAHZkty4C26A7zxPeMV0Xo?=
 =?us-ascii?Q?9+w5djObXMFewQaX3s70SiqFTBAdZd0v+1SGFSC3+tGA/vRndu6eOV230HTo?=
 =?us-ascii?Q?yxRG856GhbZ8O302soCTrI59f2vhfW3O8wFSllqTlHBxs+IUGMyjxuHnp9AW?=
 =?us-ascii?Q?wg+QV67m9oh/JUp1s7eK7XA++fVO3E0V6MCDBo7sPjYSD19kFOq6LRSw515H?=
 =?us-ascii?Q?tmSbC2mSGTI9L0tnRDN38SDxAkDejthxE+NnRrrPsPa/dw+ZhdFdhTxFvS1B?=
 =?us-ascii?Q?gsGEKLzrK1rcM+CD0jK3qIyhPDDQCDVoYUb5fm8XTD734d1Fol0womiPjGnD?=
 =?us-ascii?Q?JvuWl8w1XvPqjkjiXgubUgztqDMzQkjKJUSTxjAp2njGYii0paSYIJqfa3Kc?=
 =?us-ascii?Q?hjzJ0PK6iLy80DgPzrOoDQalzGVtfIE8sNc8ZssGp2leoVwnInEZBHtM7ANH?=
 =?us-ascii?Q?Xriv77xk1U1l1ZKW7R31t9lS9SFa9ARnPnLu2YiYEx+G3s4iZOfX6MhpzGWF?=
 =?us-ascii?Q?5eEwfVMENNigTo2Y7bT9Sa9gplDubRQcFeLawYmxl3j4JggAKFI2CIv6UjPQ?=
 =?us-ascii?Q?zNMnLraiigWExOPWYCFjGvU4ax+j3RMF6rGzAslGo/uFVB2s6X35v7u2vn1z?=
 =?us-ascii?Q?jhk2M7qGm3JCr/A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 19:29:16.5176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c93e9da-6cab-4275-3670-08dd46e48ba7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527
Received-SPF: permerror client-ip=2a01:111:f403:2009::612;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add the CPUID bit indicates that a WRMSR to MSR_FS_BASE, MSR_GS_BASE, or
MSR_KERNEL_GS_BASE is non-serializing.

CPUID_Fn80000021_EAX
Bit    Feature description
1      FsGsKernelGsBaseNonSerializing.
       WRMSR to FS_BASE, GS_BASE and KernelGSbase are non-serializing.

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7d18557877..710b862eec 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1234,7 +1234,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0021_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "no-nested-data-bp", NULL, "lfence-always-serializing", NULL,
+            "no-nested-data-bp", "fs-gs-base-ns", "lfence-always-serializing", NULL,
             NULL, NULL, "null-sel-clr-base", NULL,
             "auto-ibrs", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c67b42d34f..968b4fd99b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1074,6 +1074,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 
 /* Processor ignores nested data breakpoints */
 #define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP            (1U << 0)
+/* WRMSR to FS_BASE, GS_BASE, or KERNEL_GS_BASE is non-serializing */
+#define CPUID_8000_0021_EAX_FS_GS_BASE_NS                (1U << 1)
 /* LFENCE is always serializing */
 #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
 /* Null Selector Clears Base */
-- 
2.34.1


