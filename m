Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92343C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrb5-0004NV-EK; Wed, 20 Mar 2024 04:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrb2-0004Mh-GL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:46:52 -0400
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2409::600]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrb0-0000Gj-34
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCZwU/RW8vndEkAiRmYkYBv9DGAztR7DEfn+kIZAgPkaqRJ8TmxPsVHA9u1/qONs95hQH9AN6akJaozxYgBcqsvf7q8fzT1agSbj4rstA/OXxpArvb19Vx+wopHssakbpittWuTGFdbjfENXIHAHIVOVSqvBCzXTCPlXwB3p0h4EXhy/ZW1HL9YTTV9ZNzPIJLWt1WUjwMeWqZB/jm0ohpU91eB50T0os00MhxbwxOOLvS/4Yu3b09Z/wLu4Pn25Ac6DDqcmDknlm/OEF+3TNlcg21jeXNnlInwDNN0ELexuKQR37mQ30E7dM4y85GmnAhB3wgXkeaY3ORQqwSR66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QZjs6d4O5agYP3i9hqBVC8aeLTM4t8g8XLSghIdta8=;
 b=Zrc6bzJ9y8XgH3JTNZYDjnFanOPCXBU1W25pNajhm18/EwqjWi990F6t++xALGcNy3paXi8rsevoAUDrcpxjV/mM8skHRuiCgMRsP8U5jyv1Jb3zyvZgez/0kxKyKn9sdZkEGHarHyZFO6sEw5tODloIa6OqNI/PfnSEgG/Fll/pkkYOX0nSFfxcg19z6VP9+kvpjwazx/hyTwZofgagwumSXM7IiZHDmX6vCGFzEBsqKAXJdjYOdtqdhFwXSM1OtiqsCXzKTc8bCIeYgjm6AE7S4Zighe3jkuOCqbglkZaIzU4+S7AEVQtqS1MkkkLrNDYeowaT88OfKWxUy7NCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QZjs6d4O5agYP3i9hqBVC8aeLTM4t8g8XLSghIdta8=;
 b=Eiu/d2tQ6/KRd0daDZYOsrtR5cZ0ptNDHxzj3BEl61NKxNyr12nYoUG04pG49MsmuhUFgoIrLYBLzSyMOaWHckZ5FNiLNu34imc0QMboHeagvHLh4cqkjHHrXOhsX1iqggmLPfucjGO7JbnRE/o7/P7SYgFPl7HdtAQAyMbuAsM=
Received: from BYAPR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:c0::32)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 08:46:44 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:c0:cafe::3b) by BYAPR05CA0019.outlook.office365.com
 (2603:10b6:a03:c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 08:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:46:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:46:43 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 23/49] i386/sev: Add a sev_snp_enabled() helper
Date: Wed, 20 Mar 2024 03:39:19 -0500
Message-ID: <20240320083945.991426-24-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: ae25f0f3-f6cf-45e0-1bc1-08dc48ba455c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STKm4Qdd3lR2sfLvorcL6K1sV4EjME7VqyQGKxsJlUSe0MWuApgLfeY/kLezOn/14quUhK4y50Bfc6g1L9MGyjZ3iU+1BpKG8QOFrooUcv9s6Y/pCeiJvo4iYCQoF4AHxHxPr9NoCYx3FoN2tu/PSkLXhb5clzcQdjfwFvlGqo3c+CKTP6iD0NMUVGe2xtDs5F+drj7t4b5T48cO2iKW4mV7rQi40ODdk3CQFPjhnByK50Z0KRvmaYfHzF9xYenCsgTrXxA4l/4BiKP//fhTn9dy9kcRKwT0VhpioznSgPztBy/gwCaQFWBE5C1k+VtW7IVlpn9aod96xYjpqQg4IeJ3LQ23MlAL4YYiF+T7Ml9vyOigCBx2AlHqS+ycvlXjzKogWBx5v7/aEutYic+MJeSeqDS7HJDZw0Zo0nxda50I54DXIPSOyObDg/pL/fuVVm9NiRJw5KaGlkGlaFHJJjPU5C+p3nFWF61lJHL738FhbOJH7SNVgsOV4v0P/nMymqeDcz3E1dO0afPovaHtbc4kCxx1FAWqvxxsSZJVMTyjQkasMXgj0R9VfUB60DAcbJAe1IOotMBAvdhg2KtIAgV4HOIhhnGkPNcoNbHc0zM52vaOQZknrEk0mnLqLJwizo8WAmr+pNUHk0bzNePc8Nq4QmAnuqrOglauMlpwCgf1taZq+EyauBnDnCow2G/IvGnodznJkaQjbt45weFGM36M+sbf4fZH9YVIrSsE0FSMiqfeiqLr832Ex9f24BAE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:46:44.3142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae25f0f3-f6cf-45e0-1bc1-08dc48ba455c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
Received-SPF: permerror client-ip=2a01:111:f403:2409::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

Add a simple helper to check if the current guest type is SNP. Also have
SNP-enabled imply that SEV-ES is enabled as well, and fix up any places
where the sev_es_enabled() check is expecting a pure/non-SNP guest.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 13 ++++++++++++-
 target/i386/sev.h |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 7e6dab642a..2eb13ba639 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -316,12 +316,21 @@ sev_enabled(void)
     return !!object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON);
 }
 
+bool
+sev_snp_enabled(void)
+{
+    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
+
+    return !!object_dynamic_cast(OBJECT(cgs), TYPE_SEV_SNP_GUEST);
+}
+
 bool
 sev_es_enabled(void)
 {
     ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
 
-    return sev_enabled() && (SEV_GUEST(cgs)->policy & SEV_POLICY_ES);
+    return sev_snp_enabled() ||
+            (sev_enabled() && SEV_GUEST(cgs)->policy & SEV_POLICY_ES);
 }
 
 uint32_t
@@ -933,7 +942,9 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
                          __func__);
             goto err;
         }
+    }
 
+    if (sev_es_enabled() && !sev_snp_enabled()) {
         if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
             error_report("%s: guest policy requires SEV-ES, but "
                          "host SEV-ES support unavailable",
diff --git a/target/i386/sev.h b/target/i386/sev.h
index bedc667eeb..94295ee74f 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -45,9 +45,11 @@ typedef struct SevKernelLoaderContext {
 #ifdef CONFIG_SEV
 bool sev_enabled(void);
 bool sev_es_enabled(void);
+bool sev_snp_enabled(void);
 #else
 #define sev_enabled() 0
 #define sev_es_enabled() 0
+#define sev_snp_enabled() 0
 #endif
 
 uint32_t sev_get_cbit_position(void);
-- 
2.25.1


