Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C07CC27C50
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEDUL-00042b-J3; Mon, 03 Jun 2024 15:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sEDUJ-00041P-EJ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:36:59 -0400
Received: from mail-dm6nam10on20625.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::625]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sEDUH-0003DZ-Aj
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:36:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa1/umJq/AE4LlAaL53c6u+HM9CfE/TACYcVwglnoblNd/K3LyKn9PROOQkoWBr/YG09fLGhWjSR+3vDnKwekQBH1GUVsqNWIQBhauOcffpONd6w6aS3/3GM9rgdDdMpXZJmhWalCEryTZxohJlEEU5sD7JVFBnduw6sN6iLHj9HgrONyIvDEdM2PyCqCAwQ4cDA+IkUVpGDhEDjrk+qk/HZOwZitY1rfVRHrovDgzCf/LcocJriAPQLHlsAnfFzJhTjtA7Zgju37cnXKQoMSUpN5RDisA9a9GmV9eDkwbhxnAMqwDu+xgqCaeix8NTYKZeAd2GerSH361e27MICXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDl5FQ5dDCW6omHl6rK6uwqC+sTDf9tQz33JkuJ40Sk=;
 b=iLTw8qkabqDsc7rJvYdgioWPJ3eJUGuEuVS7PjCxeGBpQ2l739tCBEnVAS0ygW6lswlZA/kk6odmeNWQPBBtnwyDBkYG7SyPHuVoMrBp1+QGC7ZMAFn7mlevwSi/SLU+8BzXeJqro3l+V0JZyhpv8egDMJjfJhj9VxZlHPZshT4+vgeNYGgjvUMyQPCChWJT8A+4e3daw0th3ljn+cCVYXofj1dFjYuXWLjNIhbHZu1aWfzEYzVHcWNBYIJSdx8pxGNy7Yu3WIGlRiGGmncNNO8RhwTcgVhU5PoItej1ros796Ts/+jknhYjXpLsWA2JKtL92LAXpCml/jl4gHmmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDl5FQ5dDCW6omHl6rK6uwqC+sTDf9tQz33JkuJ40Sk=;
 b=i+K6606jOwnXoxyo4JJJ/gPcNPmhOWvBmKOdYKvCiCIH3HTAC1lreTBdIkATi08m+p7GNmDGMp88+gWfF8h3vOGq2r3OGgs0hgsgSCVpuYe7w1lJ/JB1U8YOVskQyjnLHSpFdPeJUYubuBrXMzYjfUIIkm5Y1Z7xhaBVxSHP/pU=
Received: from CH2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:610:4f::24)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 19:36:53 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::de) by CH2PR18CA0014.outlook.office365.com
 (2603:10b6:610:4f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 19:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 19:36:52 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 14:36:51 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <pankaj.gupta@amd.com>, <william.roche@oracle.com>,
 <joao.m.martins@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, John Allen
 <john.allen@amd.com>
Subject: [PATCH v5 2/3] i386: Add support for SUCCOR feature
Date: Mon, 3 Jun 2024 19:36:21 +0000
Message-ID: <20240603193622.47156-3-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603193622.47156-1-john.allen@amd.com>
References: <20240603193622.47156-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9efb95-f4bc-4106-e9bd-08dc840484f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AxsU78ggt+pR78A+D1AiOHh7+nwcTTfSWstVU+Z2iqfHrDF/w8v0TcIGpPbd?=
 =?us-ascii?Q?5o499BToJ537VtMDRv+bogKZcqTj80Gz8zzDDrO2iqedFv2NRZld3DzHBE7b?=
 =?us-ascii?Q?m85a+e4+6LwjiTeWmaTE47AsuV8ZDAxbJgrxr6SefljRtockx7DWEYWktZIn?=
 =?us-ascii?Q?IY235oFQeamRSrPfepx8gVVUKeviPSGfIaK/f18Bo/803Nag+0JEa1bhNf0x?=
 =?us-ascii?Q?aao30ZabebH4Ajpi2M7xq1sxOuTWyvQsgcGJltnZer+LnOpCPzWNqr2Yq4K4?=
 =?us-ascii?Q?Yq0E1AtxaijkZ616I4TMoZwlSxXDryjrQrQALFNVjrfiu3acgcv+cebCwGc+?=
 =?us-ascii?Q?dIAenFhzZWjehfbqe9AXjdXRkn5dGY0708u4xhh023uZ5gqehdoHq8KgviBA?=
 =?us-ascii?Q?k0/BX/CecxKJUxJmE9cuuBlEMecsVYChVi2uqf6sfLFoIWnKdyAo8PHlKJqT?=
 =?us-ascii?Q?SWzS4yHqBforVKi75Vn4O4dRT0zp1jKMId0bemE2MMOtYqc88Ka0qZncnUWz?=
 =?us-ascii?Q?+tFM2pAIr4dW/cdhlxXlEqaLStM0oA6CsQJDC5VyKWz5k4a5q58MvFdL/JfO?=
 =?us-ascii?Q?xr4MIwo+KsHktMTL4E7KYcgi5D9rlZ5v/aZahy2RGLrMZD84PdSryiHEmGYJ?=
 =?us-ascii?Q?CZp0ros8Gf7oJiIkWARZLOVYXj9lIjZgSlkFKj1ECdCl3r9AmDXE4VEiQ6I0?=
 =?us-ascii?Q?za8UDF+PJZxTVvSRPADlfnHrSRnq0WiOaC3W1rm+TBnS1T0uJ7so3k7LRwmP?=
 =?us-ascii?Q?QHuhsUER3TOWsVc8u6WUTkdGeRk1o+rm8oL0CmFSlxyKsFIavTIn/wqgbfZx?=
 =?us-ascii?Q?o6ehA6k0EDLdcG9rxAjBw+6we9g7HBcAyG+r8sKlOdc6S9MEG2teI91GqUK7?=
 =?us-ascii?Q?LoJkbWmPtMp7Eu5fAX00xVJht4L41qCdc3UhBooRHZQV+CVFeqGqj+uXs9pT?=
 =?us-ascii?Q?w7OThkuMPTBSkpCDT4zKuAPX+MAEaxCVNoCYfZJpcXInCnq1K0Vf9pXyIG3s?=
 =?us-ascii?Q?0j0fbSoMqXrTjpQsXrDzMiTE+zHu0vV4ydrbu+ycbzf1m8DsiKrsDpcJzZNz?=
 =?us-ascii?Q?P+DxPGx3G0LuJsmM/BXi2OtrokHkvwu5grRtsifGtXy0YbmfDeUSwG81QEVH?=
 =?us-ascii?Q?1iMpcRBf70HtI6jnDccTrrrE+2tEv1N3ZRGwxSmbBurHwjNlaFP9pNJURJFa?=
 =?us-ascii?Q?XJiyL3QC8oPZWIzd8ykKTXK0oyaejWRltAjZwhtt2TtLpa9VeqM0oYtphSaf?=
 =?us-ascii?Q?JQxPy/c2VdZWY3OFslga7trVTEfRYpKfPMIsYiiJ4tx59SXZ9OCkXXYger/e?=
 =?us-ascii?Q?ZDKmoEJ8MlAESSNttV341JCHlUDAb4iSVNsfknaxeddY7mGSP+qXyCDB989m?=
 =?us-ascii?Q?s6c2UY9BlENP+IV8XliMVXuGlqGH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 19:36:52.0524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9efb95-f4bc-4106-e9bd-08dc840484f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
Received-SPF: permerror client-ip=2a01:111:f400:7e88::625;
 envelope-from=John.Allen@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
be exposed to guests to allow them to handle machine check exceptions on AMD
hosts.

----
v2:
  - Add "succor" feature word.
  - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.

Reported-by: William Roche <william.roche@oracle.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/cpu.h     |  4 ++++
 target/i386/kvm/kvm.c |  2 ++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bca776e1fe..5fa2dde732 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1032,6 +1032,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .tcg_features = TCG_APM_FEATURES,
         .unmigratable_flags = CPUID_APM_INVTSC,
     },
+    [FEAT_8000_0007_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, "succor", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000007, .reg = R_EBX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
     [FEAT_8000_0008_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -6556,7 +6572,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x80000007:
         *eax = 0;
-        *ebx = 0;
+        *ebx = env->features[FEAT_8000_0007_EBX];
         *ecx = 0;
         *edx = env->features[FEAT_8000_0007_EDX];
         break;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ddf53937b4..5dd41e3d69 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -607,6 +607,7 @@ typedef enum FeatureWord {
     FEAT_7_1_EAX,       /* CPUID[EAX=7,ECX=1].EAX */
     FEAT_8000_0001_EDX, /* CPUID[8000_0001].EDX */
     FEAT_8000_0001_ECX, /* CPUID[8000_0001].ECX */
+    FEAT_8000_0007_EBX, /* CPUID[8000_0007].EBX */
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
@@ -953,6 +954,9 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
+/* RAS Features */
+#define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
+
 /* CLZERO instruction */
 #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
 /* Always save/restore FP error pointers */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 810f586a59..384b702fef 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -476,6 +476,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
          */
         cpuid_1_edx = kvm_arch_get_supported_cpuid(s, 1, 0, R_EDX);
         ret |= cpuid_1_edx & CPUID_EXT2_AMD_ALIASES;
+    } else if (function == 0x80000007 && reg == R_EBX) {
+        ret |= CPUID_8000_0007_EBX_SUCCOR;
     } else if (function == KVM_CPUID_FEATURES && reg == R_EAX) {
         /* kvm_pv_unhalt is reported by GET_SUPPORTED_CPUID, but it can't
          * be enabled without the in-kernel irqchip
-- 
2.43.0


