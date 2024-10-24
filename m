Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85D7D1038D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 22:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t46As-0006gh-Mi; Thu, 24 Oct 2024 18:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1t46Ar-0006gY-Ha
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 18:19:21 -0400
Received: from mail-bn7nam10on2060c.outbound.protection.outlook.com
 ([2a01:111:f403:2009::60c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1t46Ap-0002UR-DH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 18:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzOatl492V4XkD8iGuZ92KB8WeVsee+2QIBFQNR1k5nyRc6xBgvnLqQcQ7MsDVBnWP+Kv0EETjG71QPWDDDVlfaraOILuE+PXgJJ8dNKfKsETpJYLVRyOsun0ahlh3Uk2Nf/vN+gDcWtVg/Gt3upNe5taAn9uG9HEeT2UiJbeoTHYg4fH+zluvqAX41SHRqukWSW/tsvWelT+rJbBsG/HeUnNMnKGp/Ug7/NrpirRvtyNed66qiwVxicMmdXgtVomsz0TG76DFdmZPsESEt8cD86TPp4es6XMtGSwQjEY2j2vSzfT+CY/4cCyJrG+pf5YPElDT3aw9Bs71Zl8fRvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCtaudonhvnjj+ZqomWaSi6u2gOh67ZRtPud0h26T8s=;
 b=CIX6er+MvnnsWhWRzr9SQ6/SdJCAHtXgQ1U+c193Qvr4JgQpJlBeZFzy8cc4c2LTjoUHfNHvn1tYhj55kOJ8A0eOrHOOjwA7xv1JKuKC6dE6RghfTIyNDZs/og939dS40o1BTHmieqxDpH/St/mJXUMGI9PyBESvyp3/ocIIAFfH0MggI01t0v9JhxaRugdiwj5xUcQXkWF4x/Ympm+Bt7wJWddliQQ9zvFHFXap2crMpmSxK1dnI4XGJAhVH4wWMe8dYSxHJ5pH3G4jq3twpcJfC6PTQ7h5YYqpE3kVbPx0tw4A627nGb3zByPkHA8IrH4u9SPaRoiqKaxXEi0N8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCtaudonhvnjj+ZqomWaSi6u2gOh67ZRtPud0h26T8s=;
 b=PIPQRrbynTLSNz9VpCpOozDAKWcoXNnuNJb+3e5PXcU4EwV3+N0sYOIxFNeE0mTTRTR3O2HXTCEFjIX0PKpSZSGf0tDSX4fsNEf9J5jOwWKKn/8sGiePJy8d2t4xBEwnE24sZPNtir+lYK108PvnVe0DYHsVTQxVa+9OKLkcr3M=
Received: from BN7PR06CA0068.namprd06.prod.outlook.com (2603:10b6:408:34::45)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 22:19:13 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:34:cafe::e5) by BN7PR06CA0068.outlook.office365.com
 (2603:10b6:408:34::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Thu, 24 Oct 2024 22:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.2 via Frontend Transport; Thu, 24 Oct 2024 22:19:13 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 17:19:12 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
Subject: [PATCH v3 6/7] target/i386: Expose new feature bits in CPUID
 8000_0021_EAX/EBX
Date: Thu, 24 Oct 2024 17:18:24 -0500
Message-ID: <7c62371fe60af1e9bbd853f5f8e949bf2d908bd0.1729807947.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729807947.git.babu.moger@amd.com>
References: <cover.1729807947.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a62675-9755-4cea-de49-08dcf479e3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h3LRgkSr7zD5STx9801KLjjms8N9LPytD9WRYn4RR5NnOvdd8vOeUXqrFRBP?=
 =?us-ascii?Q?ZHE1XDj7/h96LtsLXI/O0WPuBDdRttoBP5zkU5pnxijjDR7qtMDm0Qk7jYC0?=
 =?us-ascii?Q?GcSXMgzF0PmgxwEctI0k+b1Pur0MU1YgJyIiP0JR6tRwGg1Xi+E0UYdD6POV?=
 =?us-ascii?Q?g3pHNoeP+EUv0sR8I98huJ8Ppyw4trZjcmnPi+n4zJXNY2W508bGBGmkhuS/?=
 =?us-ascii?Q?sbWGw/5sw02yJ/yv61xE/K0EH9vuL7JhCgNYSYRFmKNRDKddfhNNUyXYLRMi?=
 =?us-ascii?Q?6iywC7IBfxDT7PW1ZWI0U1QPaV8MRPL+KHZYrvWI67hcLRs79+NDdxNmYA75?=
 =?us-ascii?Q?HF4XVV6yKQooU6A3o+JkcMZGFfqkA3sIyaqUXMXsE1mDgncNGC8iDrzNfZr6?=
 =?us-ascii?Q?vtH2td47xbuU8FxtAr/cBaOhBQjNfqTGiwoF6UKVl2uEnhR06mM+U4WM6qaH?=
 =?us-ascii?Q?7Xq4HUshRpzQPYWnOheHIYwUeGYQn03K9yxHVhv4kqj+OF3qL2IEo6nMNw+4?=
 =?us-ascii?Q?4qfaDpJtGdCDUhwkOeblCjSAJOeHCXTfQ12gZ/tsYzo0jwIecm0x0jxuHbtF?=
 =?us-ascii?Q?AtPxFF/vQLwwY5uDR4R2znDAddLWIv7C4ZwWuSN/lmytK0Ee1RsWOC7TJV7C?=
 =?us-ascii?Q?gokcIUHPuQlDN1KRLHebRIuTlIDdln0fYQd7zWXZ78VhbwXBeyw9qgnjJFst?=
 =?us-ascii?Q?8xqplNuBDswUzxr256jr2GcrpiDL09RrIjkkaySgWIPtvE2XSr4ZunxeqZ9/?=
 =?us-ascii?Q?Nx82gnjrDEpcEcIQB4SF2WJC9/V8nkUDQ0FaJ2k7/Ryqc2gAo8yeW80Zg69o?=
 =?us-ascii?Q?m2t3sXVCVAn4XIeBs1QO0ipnUmUAj8Hre9PCXdACxydVNRYabOCLbvzDIWnp?=
 =?us-ascii?Q?jLgDfXT/v1fTUjHVF6WFBrZsZ9KQep5RmHM+WvOdBzAyQc7M+sohDdyLEFlx?=
 =?us-ascii?Q?pJQh75lzZGCsTQAwU6U7IZex6pENznGw7dxJS2nhxiTA+XmHuEhljNcEcayy?=
 =?us-ascii?Q?iU3D7iND4ioZWGE1oE7GhqbfH5DtaEmtuwGDeVLGTPMMG2T353GK26SxdWYU?=
 =?us-ascii?Q?2Sx5DJpTfEC9L6k8hzKQnZUv29mx8ARvspJ5+cyZp245b3VwhDV4j0MNYmsD?=
 =?us-ascii?Q?lVA5rmNtSj787U2darYzBbWSKl4TgBPt6qIoqUfEn4tun5Byl1e0UkzvA36l?=
 =?us-ascii?Q?M+2j3irD9kTcSigq0yArZzytJS/QXvUi7jY2z5j5pnEY1BR32hPtIETUJygk?=
 =?us-ascii?Q?EGLeS7St7eIXqxfaJoXqL3tlNlrn+4EItRt6Hu2+I9RkfqHr/nRu4/ONWLo+?=
 =?us-ascii?Q?As8VBoKki3njd4e4u8v9qDDaIj0lB68pOYOCcLGEJGqh/D//nuwkG1uVx2jk?=
 =?us-ascii?Q?l4pEsu7JejS9RmiNMZWdTjZ/LIBDVvK/vEPvyBW5OIC4n9faPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 22:19:13.1183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a62675-9755-4cea-de49-08dcf479e3ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
Received-SPF: permerror client-ip=2a01:111:f403:2009::60c;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

Newer AMD CPUs support ERAPS (Enhanced Return Address Prediction Security)
feature that enables the auto-clear of RSB entries on a TLB flush, context
switches and VMEXITs. The number of default RSP entries is reflected in
RapSize.

Add the feature bit and feature word to support these features.

CPUID_Fn80000021_EAX
Bits   Feature Description
24     ERAPS:
       Indicates support for enhanced return address predictor security.

CPUID_Fn80000021_EBX
Bits   Feature Description
31-24  Reserved
23:16  RapSize:
       Return Address Predictor size. RapSize x 8 is the minimum number
       of CALL instructions software needs to execute to flush the RAP.
15-00  MicrocodePatchSize. Read-only.
       Reports the size of the Microcode patch in 16-byte multiples.
       If 0, the size of the patch is at most 5568 (15C0h) bytes.

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: New patch
---
 target/i386/cpu.c | 11 +++++++++--
 target/i386/cpu.h |  9 +++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 642e71b636..5bfa07adbf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1220,13 +1220,19 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, "sbpb",
+            "eraps", NULL, NULL, "sbpb",
             "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
         },
         .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
         .tcg_features = 0,
         .unmigratable_flags = 0,
     },
+    [FEAT_8000_0021_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = { .eax = 0x80000021, .reg = R_EBX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
     [FEAT_8000_0022_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -7114,8 +7120,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     case 0x80000021:
+        *eax = *ebx = *ecx = *edx = 0;
         *eax = env->features[FEAT_8000_0021_EAX];
-        *ebx = *ecx = *edx = 0;
+        *ebx = env->features[FEAT_8000_0021_EBX];
         break;
     default:
         /* reserved values: zero */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 792518b62d..e2e10f55b2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -634,6 +634,7 @@ typedef enum FeatureWord {
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
+    FEAT_8000_0021_EBX, /* CPUID[8000_0021].EBX */
     FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
@@ -1022,6 +1023,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
 /* Automatic IBRS */
 #define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
+/* Enhanced Return Address Predictor Scurity */
+#define CPUID_8000_0021_EAX_ERAPS                        (1U << 24)
 /* Selective Branch Predictor Barrier */
 #define CPUID_8000_0021_EAX_SBPB                         (1U << 27)
 /* IBPB includes branch type prediction flushing */
@@ -1031,6 +1034,12 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Not vulnerable to SRSO at the user-kernel boundary */
 #define CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO          (1U << 30)
 
+/*
+ * Return Address Predictor size. RapSize x 8 is the minimum number of
+ * CALL instructions software needs to execute to flush the RAP.
+ */
+#define CPUID_8000_0021_EBX_RAPSIZE    (8U << 16)
+
 /* Performance Monitoring Version 2 */
 #define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
 
-- 
2.34.1


