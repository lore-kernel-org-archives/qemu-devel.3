Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50BFD1038D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 22:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t46As-0006gg-4j; Thu, 24 Oct 2024 18:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1t46Ap-0006gK-CS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 18:19:19 -0400
Received: from mail-mw2nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:200a::62d]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1t46Aj-0002U2-PX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 18:19:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPs/U86DJJql0fzI1d+INPp2SfBTncscBqcM3KjPE+4/f4KWsCFXChtwISFEM8TsXNFEuBqCO0+WUsvmLN5PQJsYHY+lsxDKU49Vvv8WtJ4e3kuJIM1mgaCk4fTGBkWSPhPLu1vCe9zvfAm8pDy7+I1AVN8aUGb0CETK//XprObvtcDCM/ac+1WTrWp72eyFO8n8gVoSDQBhqpqat6HAefHohUNcjpO3imvNW+d/FAAXTffXr6y87gwBY3OOgPZFyTP5dmmNkFUb0VbxMy88ZxEbQqbeEYCcT16FF8tUnE+AQYea6fbEveujFESkRgsO8z3nmHB5F221eI1VnnTDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1SjjznzIat6MsEagbZ6ZzslzfwCBDSQfWxfUc2bkhg=;
 b=Dif2LFb3eYwkRbR3rIXV73yo/KCDdnLaowwU8wuiDDvIMFheETEh762doHCL3BfcDsmjYY8o5zXsDg5NxZ9BZPQWh2Ftpqh1GWEtNAje7xNxIfvNRGRd8nd9Nn4t/VMCOmViDNp8uTKYqLgAKzvGm+nn8XY02xmriZXZzWXTyKh1qwzSsv1UsC2iVG1Alc6pk99EaAjItDoqRwrkihfgmb65NUB6o/6eqY9QK8IbpCse5qnhf3BpxqZGh0JnyaUEAb+M4oWzF2oaJk3QW9cXlayc+7xolpexMlmIp1Xl9uzOG5o6mJQ0GIyOqfWqTxHaSIqtIeKPFLSOdQ5ATFTElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1SjjznzIat6MsEagbZ6ZzslzfwCBDSQfWxfUc2bkhg=;
 b=zwwBxaa0j/eZw+0gMQK0bTRaQU7cZwZnWDhUt/TTBaVykAoKhVdJFF8ZryIqOiECh6MklTBEcs4u2Z6MdGWfEifFf0spvsZW+OaWDC/hANYy7JbL61lEnSSdiQpU+izOxmNL5MBtnJ4NcuC5HCh5di+9TKJAOwUoMD0FVIuwufo=
Received: from MN2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:208:d4::26)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 22:19:07 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:d4:cafe::5d) by MN2PR04CA0013.outlook.office365.com
 (2603:10b6:208:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Thu, 24 Oct 2024 22:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.2 via Frontend Transport; Thu, 24 Oct 2024 22:19:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 17:19:05 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
Subject: [PATCH v3 5/7] target/i386: Expose bits related to SRSO vulnerability
Date: Thu, 24 Oct 2024 17:18:23 -0500
Message-ID: <dadbd70c38f4e165418d193918a3747bd715c5f4.1729807947.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4f50f4-14d0-4e87-5055-08dcf479dfd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w9GxWcIsC+vWa7C+ulzX6hILDsGAMqKBqzUSW02W56x8DRLmqx7gzkVKrxLC?=
 =?us-ascii?Q?e0p3WvhufY9XbNLsTZHlyw64U1Cnkip/wchMMcRf0eaWyivvHYuzeknlsWaQ?=
 =?us-ascii?Q?/KeV8WOesVJg4i/Axu0b1Cwb9dn5uEInRLBxaDWPhcrlyGLmn2dAXCo9ibKT?=
 =?us-ascii?Q?TRA9s/9q9yVWzABd0IYkqf6l/xPXvSyMV6Svd0tIhPnLjzpSMAoDGQMz/H5U?=
 =?us-ascii?Q?6oh773zexh/i12TDhLMoT0RXpaDoZemzP7mBVEQA2Q0gYLc6OIqyKXQc8TVE?=
 =?us-ascii?Q?yYfbUT+TWx5aMA0wyePekz+WaifyqNeZAsy7sIGQPV7YOMaF2SnSelGCqgn6?=
 =?us-ascii?Q?FUoiVLmTZYJzRGjkoXJJVDUsvElLd5CLfZQuIdQmVB27LoGIElj7oJrEAuMb?=
 =?us-ascii?Q?T7sLrv8hOKT/3eOrY8ppfjzwNl8LIaBhe/5ruKhSSxpQcpFhwTg1KuyeRiEM?=
 =?us-ascii?Q?jKszuxLfDjqJ5q4LDwCRyegqbU7n6iaTAPv0mhwxBdPARUaoxkc7Ofv09jeJ?=
 =?us-ascii?Q?hK1pDl095IlgP9K7o83d6mKXdd9x9QJeiHfHU+9sEKhPv49nLVG/IM6pDYPX?=
 =?us-ascii?Q?Kb7qkQcjdFzBDTNLGvnLSCfhlMK2fOdFay3iAPs/yyeAuV8gTjYrlFATxMCc?=
 =?us-ascii?Q?bzhmZ7yYrLbENfiWLfK9L7uRfO6ZCYFGX8UdxCGP0uE4HSonfmMlIQ4iafWZ?=
 =?us-ascii?Q?R8jyK60hLCoLW/0Etr+0dPJ1TGjtEOJqR9aE1YDyaToIErOq3iQ6DRm1dFwG?=
 =?us-ascii?Q?QxgNbCiUamIIPq9q4DVw2vV9E2GrbP+kt4cpOYpljE7fwiQ2F4H5KJY7e7tb?=
 =?us-ascii?Q?6SnimH4zEtmDVD05HtP4y+6w+0FVfq/rehB9iLLKKgC3XxDS6U44UlIz6CCb?=
 =?us-ascii?Q?pzebM5lSvlN3z7SXdJBbZNSLRa8plxgT0hPA83TYuuxJAtFlLuP2MhLzRg4x?=
 =?us-ascii?Q?0eAJE8Wyx/TV4A7LSiRk3vkrtsM1ihwR1YqugxL7jyJEG8ZakObOs8SURKu9?=
 =?us-ascii?Q?l7jHheAuA1PMj5Rs6+d63VIJoSvkYSTZYonfTGlv0ngJ9rPX+QddtZs+rFfH?=
 =?us-ascii?Q?iE+Yfx5TSViGjaw0vmqpkBTYu4VPFB35a4Mz/4QmX1Ogzt53UvOQf2eF4w8D?=
 =?us-ascii?Q?7e64sTr3yrW5XhybKyKkV8rDYwe+1sHJbfazVObbYDULnlKq++ksNoisMdVY?=
 =?us-ascii?Q?iHjSC7iwqmfRoPkhssperz7UF7BfUuBI3QsGGCNP/r8R22r5gWzLyNxRhCNZ?=
 =?us-ascii?Q?vvW/LV7L70xUDZwLffg+IOjPJDXffxDjZbJwBt/yPqh7c7v7Q8cURBvhaKgG?=
 =?us-ascii?Q?WIpp8sLZlZc5dx9x//KwzpkGEFP3jneolYlhMfkUgODBj9xacbSS+083mXK2?=
 =?us-ascii?Q?KH+rZFVBvWqEMbHhQ5aCoSsl4035YKLd8QQP1B3j72yMttmScjEAofndxDbb?=
 =?us-ascii?Q?vNXE+i0n1f8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 22:19:06.2636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4f50f4-14d0-4e87-5055-08dcf479dfd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
Received-SPF: permerror client-ip=2a01:111:f403:200a::62d;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add following bits related Speculative Return Stack Overflow (SRSO).
Guests can make use of these bits if supported.

These bits are reported via CPUID Fn8000_0021_EAX.
===================================================================
Bit Feature Description
===================================================================
27  SBPB                Indicates support for the Selective Branch Predictor Barrier.
28  IBPB_BRTYPE         MSR_PRED_CMD[IBPB] flushes all branch type predictions.
29  SRSO_NO             Not vulnerable to SRSO.
30  SRSO_USER_KERNEL_NO Not vulnerable to SRSO at the user-kernel boundary.
===================================================================

Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: New patch
---
 target/i386/cpu.c |  2 +-
 target/i386/cpu.h | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 690efd4085..642e71b636 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1221,7 +1221,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, "sbpb",
-            "ibpb-brtype", NULL, NULL, NULL,
+            "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
         },
         .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
         .tcg_features = 0,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0dea1ba54..792518b62d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1015,13 +1015,21 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0008_EBX_AMD_PSFD    (1U << 28)
 
 /* Processor ignores nested data breakpoints */
-#define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP    (1U << 0)
+#define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP            (1U << 0)
 /* LFENCE is always serializing */
 #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
 /* Null Selector Clears Base */
-#define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE    (1U << 6)
+#define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
 /* Automatic IBRS */
-#define CPUID_8000_0021_EAX_AUTO_IBRS   (1U << 8)
+#define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
+/* Selective Branch Predictor Barrier */
+#define CPUID_8000_0021_EAX_SBPB                         (1U << 27)
+/* IBPB includes branch type prediction flushing */
+#define CPUID_8000_0021_EAX_IBPB_BRTYPE                  (1U << 28)
+/* Not vulnerable to Speculative Return Stack Overflow */
+#define CPUID_8000_0021_EAX_SRSO_NO                      (1U << 29)
+/* Not vulnerable to SRSO at the user-kernel boundary */
+#define CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO          (1U << 30)
 
 /* Performance Monitoring Version 2 */
 #define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
-- 
2.34.1


