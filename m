Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EE8C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 20:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnMGr-0004RA-Bc; Fri, 24 Jul 2026 16:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1wnMGp-0004Qg-IB
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 16:13:23 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1wnMGn-0007j1-Ma
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 16:13:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx1ENXLSJcJ3s3c3osIFNSJxoEdq1BAZIl4fGlGKeczx7iwt/gmsDdfeu7AjmqRWhusSrBUE23aJSf6rc4ixZ2GVvHRxg/KGbOMmx8ZvNLLtOjR16dTj+HgV4E1x0WaWrU5GJM9kp3fmTllEkpNqZed79rb6/hQC03MOpweSAzBwEkSAoOuUudPFGK7r/Smy0GLMzkI2ORbpRxJYBWvl2Llh4XeE+ZENyr5HbjaPRdp4iUm7lwR0mh+H+ijLu64qsAj4I/IBa/OGn+sJGodkOUcwJtYC1zrTs7S3z1sX+8pq+npqeJKfXpvVWGX2mn8zZeHryGUlEczgk9wG+DNThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltAtG+kIPpJyr+pC50fsSx4NKfpPC0CWvc8R93Av2VM=;
 b=lTyxGSTZvVcoe3YZ8ipIsn9k9UhHy6o+0UC/rxj/hppi1jcJ8KT+SrvDEV5Qwv+K7lLa4j5+bNnJBxbC7kgqHbCi/cxB/d5kYwypDriOVfNgxJphywnLK0FKeKSgmkCq4N0FOBiFLreWqxe0pC8WVTTRhUpx0ydZbqHu4ETXISnNs69uw1z+cpnu48j5KlMu3glHfv1v05dp7TnFqMMyYImTb2lHBiBZ3U2O7tQ7jQSn7s02PX6waSxNr1K/I0Ym1XwnLC1yithVrP9q130/t+rusY/fbMLWoPLaUNJr04BGi8ldUxekdJ1NUPus+aaLOO54iwTxUeA9GfDsblRasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltAtG+kIPpJyr+pC50fsSx4NKfpPC0CWvc8R93Av2VM=;
 b=J233jayc+eOvx0NQ3EXpu31K7bkpQ2Jn5Vuqucc8Ytc/9JmJ83LtM7g8e4BgDS7NGgFF/XykKhbc5xVoPebYhrQdbzJgL7u+5zyC4PgjxngezMbTRoM0rG257//1XWhNylGhpZzbYoewJP4mtuIMyMok4bFpVxmcJcIFydjBuk4=
Received: from PH3PEPF0000409E.namprd05.prod.outlook.com (2603:10b6:518:1::4e)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 20:13:09 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::2) by PH3PEPF0000409E.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.7 via Frontend Transport; Fri, 24
 Jul 2026 20:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 20:13:08 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 15:13:04 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <pbonzini@redhat.com>, <mtosatti@redhat.com>
CC: <zhao1.liu@intel.com>, <seanjc@google.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <yosry@kernel.org>, <thomas.lendacky@amd.com>,
 <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>, <santosh.shukla@amd.com>,
 <shivansh.dhiman@amd.com>
Subject: [PATCH 2/2] target/i386: Add support for AMD LBR/PMC freeze
Date: Fri, 24 Jul 2026 20:12:03 +0000
Message-ID: <20260724201203.633799-3-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b9bb8b-6359-44cb-1d37-08dee9bffa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1AODY5NMZWuJDHY3An+8nHl/Zpkaz+eR+0p9i7pCCxbwDhBbr6lqXKEYIf05N8dCBCcYem5xlP5XugqB7CsWv4b1himouBPuo55JvF1jBN5QLTPgWkBl7tfO1Xe4Cx4Z2BJ5vcROSacRXfH2id/VTAAKSB106tAJNgsuBbzdFfjfI9Db5THLO6okOZIp2fdQv/i67rdDg8U6stGvOgFG9C5ku6Pg+kC563ZFhHRUnsNxtndAfKO40y2LuVFuL5tVwB5brNqDC477ph/d3WSTLC1W003pi9PW69JfTyLGBXeeHFbdrP4fgt+AqKtEryiUNUoPDiGO5BTEfzTiEBYSQcykGUVdSyUojtbENfGUE8RCTpPiZU+NXqBN9iPFX6NBSBPajDnA3rmXyxU2V77ELleO0L8udI9CRKxQWWlfRcj+ZjlyRJKpS4Vj1uPUm3UHl7LIAxnQQi4N+FwYiVFw7SO7dW8Vsi5kCZVt00ijSxWf9p9wY67B8GHRwP3IkpP7R0kRG95Z2JEbG8LGFh9X924Z2jy4L7mO6E0kLs80XT3ywOuAgSPJgthxg1ATeBmXNP7TBW1cBqfonkB0MI2f89nMRkHprHHlveUbRPVWEX0b5P/e42yygeenabI1/zxVt3n0Q2Nx9MGqML3BXVbr9JJW1/4CI6shsShGFPffx4JF4P3LiSPDkSNafgAGrEdyxSRpDdwP/Aq9oK+zcTd5SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SZadiJD+SpCcmRx76a3FImpsIn4LLeAoUzmyAi90odwijjIGxWmqFGDxpPYJcW7RxqJZ0KzvuwbpeBlJJo8Bcf5M1nqcmDi+TIx9ZY0aalOsIdSHBOY5VaJDzO9EY/9yi87W7tgecRQapPj2AfdNCxaY0mpq5CDftB9L57RM65iavKnqWb/yh2pwiUgaIdvH6VfmSxX+gJacMFnbDoVV7/NdysAEIseMBpe8Q1ZgINQQB/ZzyzQAwmMeV6oHeLPHB65GCf/T4MED86PqNXz7wHCBiTb2ilowxHkkuTVBQw4h0wF5RqvD20Sa4162FaKCgbYs5IYmYXGbHrcuwDvGyNvTcEneyMw1hFk07B+2UHvDu8PWB0rYk0Pa/K6BEXaS3td1Qr2zvnH5r0mgo3u9kkqRRYQkX8hPTUyYtekHXqDV2TB81AQvt3WsVtVQl+Nk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 20:13:08.3876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b9bb8b-6359-44cb-1d37-08dee9bffa87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Shivansh.Dhiman@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the "lbr-pmc-freeze" CPU feature (CPUID 0x80000022.EAX[2]), which lets
a guest freeze the LBR stack and performance counters on a PMI. As it
operates on the LBR v2 stack, make it depend on lbrext-v2.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 target/i386/cpu.c | 10 +++++++++-
 target/i386/cpu.h |  5 +++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 678863de68d5..b22a2a9314ac 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1464,7 +1464,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0022_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "perfmon-v2", "lbrext-v2", NULL, NULL,
+            "perfmon-v2", "lbrext-v2", "lbr-pmc-freeze", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -2048,6 +2048,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_8000_0022_EAX,       CPUID_8000_0022_EAX_PERFMON_V2 },
         .to = { FEAT_8000_0022_EAX,         CPUID_8000_0022_EAX_LBREXT_V2 },
     },
+    {
+        .from = { FEAT_8000_0022_EAX,       CPUID_8000_0022_EAX_LBREXT_V2 },
+        .to = { FEAT_8000_0022_EAX,         CPUID_8000_0022_EAX_LBR_PMC_FREEZE },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -9156,6 +9160,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
                                                  R_EBX) & 0x3f0; /* EBX[9:4] */
         }
+        /* Dependency LBREXT_V2 => LBRPMC_FREEZE enforced via feature_dependencies[] */
+        if (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_LBR_PMC_FREEZE) {
+            *eax |= CPUID_8000_0022_EAX_LBR_PMC_FREEZE;
+        }
         break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 64e40a654260..c8f51531ba85 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1220,8 +1220,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_ECX_TSA_L1_NO  (1U << 2)
 
 /* Performance Monitoring Version 2 */
-#define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
-#define CPUID_8000_0022_EAX_LBREXT_V2   (1U << 1)
+#define CPUID_8000_0022_EAX_PERFMON_V2      (1U << 0)
+#define CPUID_8000_0022_EAX_LBREXT_V2       (1U << 1)
+#define CPUID_8000_0022_EAX_LBR_PMC_FREEZE  (1U << 2)
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
-- 
2.43.0


