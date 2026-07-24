Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FD6C531FC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 20:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnMGY-0004Jb-6I; Fri, 24 Jul 2026 16:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1wnMGV-0004GW-71
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 16:13:03 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1wnMGS-0007Tm-J0
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 16:13:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mI/xeQHnglRjlCvblv3MYP/ZJBOhsSERXb8MdB8tHEgLUWlWwemO1JqFNzwujRd+C1Jq+ynOPp3Vz7Av2wAIfhwkNjCz2oK1SoF+Vz369HJ1P6eZGwJ+y3hvqLrArEG7PGx0zy4UpFchZ4aj+pXTxRM8NeFAryxPxYS8Q4/o7YtV4RUC6O2lNxM1OS7X4OzoHye9nzaLVHUIBZk2WY6IYBOluw3IQsspXWW1ksenjXvG8plYFxX+joWvBqahiIBbXLfZOMXNWze5zmU0zJt+a8O3QbfAS6tGAg2tuuF98MwFgibWft5D3DCO8zyPAdSTjPY/JFK1gg57g/uNvbuAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8A0H0k1RPQG5U9jdaS7rbZeu+b4IH4ZA0GID29tXDY=;
 b=xYJmRLyWGTTgcGUmBfRkddy2RAuYgfYL0Ag0UQQYXgeujah9iDPq59OPovWJEHT/M/XlGezMxUuguE1a630EL1SFvdNsgd0++suksIwtnjIdHCI9G8eJo/cbCP3YyO2BNyodYdLWl/OlZsn+HWSgyKQOKrGUlA338jXxpJ2dOSx+pa7ilFB0A31FWrAkoHNHC3G1nJaw+ivKSBm4u+wXe8QOT7alo7zTmBduLnXjaAT2rl/iEJMo66zR9Y4YpPlv+raFVZixoMsEhz/DONkrl/T2K/xppvqJ8JjSWvYaYI8rs27RlB1BR71N087eGykFu6H0s7x1wkbBLtZRi39BbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8A0H0k1RPQG5U9jdaS7rbZeu+b4IH4ZA0GID29tXDY=;
 b=DzAKLxyC9aHd2XJihXbMEMCz6INMJArgn1xUumQgh+lW1gEYunfRgf0MvFSxZMTwlXP5i4SFWmkLYMW5KtCxX2n2VkWZYFSqWTKKIgQsIhcJM/A/ovH85Tc6oUzdrZsf2ARCpumhNo+iC1Lmut4S7Yet32N+4Y4AnHRbooHZBPs=
Received: from SA9PR03CA0002.namprd03.prod.outlook.com (2603:10b6:806:20::7)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 20:12:52 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::a8) by SA9PR03CA0002.outlook.office365.com
 (2603:10b6:806:20::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 20:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 20:12:52 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 15:12:48 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <pbonzini@redhat.com>, <mtosatti@redhat.com>
CC: <zhao1.liu@intel.com>, <seanjc@google.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <yosry@kernel.org>, <thomas.lendacky@amd.com>,
 <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>, <santosh.shukla@amd.com>,
 <shivansh.dhiman@amd.com>
Subject: [PATCH 1/2] target/i386: Add support for AMD LbrExtV2
Date: Fri, 24 Jul 2026 20:12:02 +0000
Message-ID: <20260724201203.633799-2-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724201203.633799-1-shivansh.dhiman@amd.com>
References: <20260724201203.633799-1-shivansh.dhiman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 8759b72b-ef37-4c48-4093-08dee9bff0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SV7XEBttXvTTZpSJONxxpj6KKbIPEzCy4aXCsvRZpHKsARO5ASzVVHRCvJqsFs6A7ZJeVoBItt1vmPPtUYVYWhdSYPM+XWehpj11nKoLu2xz8yE7ynF+XSma1veXpbnWXEgPNtx2eb63HRPNglTtgGbxu8gDdvY1FSId3RtWma+o/SM7Qz4DyRr9dtjdg3MeV6zrzf7ERDAgtSlI1Fjq1JcLMz+KJ1RJJv53F0VzNQgCri6UK6aGv6n5cFlUp5YNDSWI6ugyxFIDu0lRhjTlNCgoQ1InBW21XSRRRD92553ZELYcW4HT5zhSAuyT+lejC9lOXmUCo3C5qO564+hVl1eBykGV7t7i5igIFxjSMco/6w24rgUO65KOLPNhzRLe7B8gVzv6/W49j0Cw2E/HgKQBqgDMJjVbsn9xz9RMX+ABTt7+cUkuPF0MFH4++nFpQABQFCUL1h3KqGVVHRXxUvbif6mgPhByPG3gHp9wieJVOk37FZgs40saQdortTGblYCzr7HtgtPNwzSSZy31QQzXWCamMaYpCIPNY/8EieL8mTiL6r9JQ+9SHYv6CdWnV2mnS/SxQjxBHwlfUsCxo3GkV+FlS2BeZuoZr+UJh1/WgB/AD9BnZGmlqpW11G67k9jou6V5Bj2ADtZdl0Gewb/YTJocZPZtpuCovvY4AM2bzrixlygWunEe3owTVTbqWeW7f4QxpfCbfdMs5Czhkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ltwMe6g6UpLJjL/u2or/X7yLz0CJAGl7I0WR4v53w4MAs3gjyS1hRXJNCiLKzve0BwX39g1Q8XjWM7ocIxTS5/5Mgy5kvRne0pQhzLrxdGyRELgb40Igo69Sj0N3u0eMJ0rcFUBFBeFhfLwclXdqYyUCz7Ri6UxPRvRILA6HKIwCSmwhapuaHOcXYFpSn5W8qfmhEzbjVhyhZS+fdT2sG3b0fO4RLPLqed4GVT6dnqSoUFNWq0IYuJht+ytHlmBPGz6gPb4gHb/rzGzg5fMSAvyRGux5eejE1OV/BRoKgler7f8Pt4M7bbFdisBBPUsGehYCLtFkY/ECZAyXNXpWE3pwUCy05arlMqqJJy8wxf8Gh6YgaQ37kCWSrhhyU5Cc42PjD1+cLHrruB2qUOKc8KK9hNfp4Nib7hQcsiLI3mB6r8hE/axXyd1HFZeNn1Fq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 20:12:52.2348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8759b72b-ef37-4c48-4093-08dee9bff0ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Shivansh.Dhiman@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

Add the "lbrext-v2" CPU feature (CPUID 0x80000022.EAX[1]) and report the
16-entry LBR stack size in EBX[9:4], allowing guests to use AMD's Last
Branch Record Extension v2 when KVM virtualizes it.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 target/i386/cpu.c | 18 +++++++++++++++---
 target/i386/cpu.h |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9d126600c057..678863de68d5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1464,7 +1464,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0022_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "perfmon-v2", NULL, NULL, NULL,
+            "perfmon-v2", "lbrext-v2", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -2044,6 +2044,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_FRED },
         .to = { FEAT_VMX_ENTRY_CTLS,        VMX_VM_ENTRY_LOAD_IA32_FRED },
     },
+    {
+        .from = { FEAT_8000_0022_EAX,       CPUID_8000_0022_EAX_PERFMON_V2 },
+        .to = { FEAT_8000_0022_EAX,         CPUID_8000_0022_EAX_LBREXT_V2 },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -9138,12 +9142,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 0x80000022:
         *eax = *ebx = *ecx = *edx = 0;
         /* AMD Extended Performance Monitoring and Debug */
-        if (kvm_enabled() && cpu->enable_pmu &&
-            (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
+        if (!kvm_enabled() || !cpu->enable_pmu) {
+            break;
+        }
+        if (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2) {
             *eax |= CPUID_8000_0022_EAX_PERFMON_V2;
             *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
                                                  R_EBX) & 0xf;
         }
+        /* Dependency PERFMON_V2 => LBREXT_V2 enforced via feature_dependencies[] */
+        if (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_LBREXT_V2) {
+            *eax |= CPUID_8000_0022_EAX_LBREXT_V2;
+            *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
+                                                 R_EBX) & 0x3f0; /* EBX[9:4] */
+        }
         break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0b539155c409..64e40a654260 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1221,6 +1221,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 
 /* Performance Monitoring Version 2 */
 #define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
+#define CPUID_8000_0022_EAX_LBREXT_V2   (1U << 1)
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
-- 
2.43.0


