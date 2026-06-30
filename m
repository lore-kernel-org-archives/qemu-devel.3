Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324D8C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaZc-00039d-G5; Tue, 30 Jun 2026 11:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1weaSz-0002BZ-Da
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:33:42 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1weaSw-0007m5-NY
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:33:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feDv0H1KkIo3e6nzLWFh8RenwYo+TPHwP9l8hXBiIZVTxQTbYkfetTgOlIZmOmyjTW2lM+sIFsFjiROWuOCI0+VpMfnYa+3678l8Z8vOnPRlUSHtRWkeTDcg36i+7vUvyVrNPaZD/QXSD+68Ncr1RpvAA2gFNN5iaG4+65uT2tDX5Ssse7b2osBY3iUTvggEofRkpwWK+p2rn2g4iGOnA7d/k5xrtmE1a+GBmTYsoyM0nGAjjAIobGKr34R4aL9dxNayTgVAyvs/80l6/mI25oKNYt+OlCjyIVhTKY1+NiWbD6Btl/wIk9kHxeGoyTtW1k68huzj+VyNbljYgIG0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpTbX+qtxh62rs9ogjld5+AtEGlDZGsx/R9Zl4Z1JbU=;
 b=p98fl0yiK2SHMkHG1OGYigzWyOcCYbE2XrQXNYyL4glLZ1Sd9n0OufNsgUzt+8qSD6m/jvnKYaSuFEABKxmc7HhFkd+tD00oNC73r9nA77Q18TTn+TClft3yyDuGeAOo4lD2SH+frNWCL6Jfr8cwO7G+i0hfQ8KJAjMBpImKMRbvT3bOMPKqItkrc5G3hJj8cHRC97fw3udXdx8l2T/aRbIg7nBaRamQfNxp3P/AGg2SrYyMjhqY3vS16xJR9f21an6M040BMLVMWjc0wwhFHySfGN4HAx6jCmFiqB60IaIwy8XNY+fdZjLo/PZeViy7ctTuPE1uVS9Sw6DyCWFVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpTbX+qtxh62rs9ogjld5+AtEGlDZGsx/R9Zl4Z1JbU=;
 b=ZpbtF3CgZiyIKz4t39m/+47JmNB1rLqohARa/DtYEAFGFYkETD5PF3Qyu0Ik8otizMFXqN8yDHh6u65IeD5SPHy+5l9h6tHgwxTINYBusU0CvqyrrgYzLf0UKjjwYnXQMObokQQhKNlVEdPkFkKzMTuxClBhsaZSH7lHbF4C73U=
Received: from CH2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:610:51::19)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:33:32 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::1e) by CH2PR15CA0009.outlook.office365.com
 (2603:10b6:610:51::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 15:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 15:33:31 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 10:33:30 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <qemu-devel@nongnu.org>
CC: <babu.moger@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Ben Cheatham
 <Benjamin.Cheatham@amd.com>
Subject: [PATCH 1/4] target/i386: Add AVX512 Bit Matrix Multiply (BMM) support
Date: Tue, 30 Jun 2026 10:33:12 -0500
Message-ID: <20260630153315.1585-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630153315.1585-1-Benjamin.Cheatham@amd.com>
References: <20260630153315.1585-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a516b3-ecf4-4e3f-5dc6-08ded6bcf0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|11063799006|3023799007|6133799003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: g9SNgg/Gp96ABlT31i+HI6yt7bqXQakw2ebjYv4FuI+qoARYUSgu2oarL2Je8Bjiu1O/QdXfZkQJiZESsklLGU1sc0d0KISoFVHRR3p3C/yA6S+sFP3zYGNRngxaS9Mu+NcwtRDBcQaJaEDlGss8uK47HrnD4PyLToXmDvUaWXRi5SEkOx7FF889bVCuaufhV57aFD2TmfyxYTiWs5TdI1Kvfgxz7/K5RytwZHzPhPRvidWwCv2/gRbH8ukBEjI6cRO6CH8gaW6HVW+2WcJDCDVnvc2sWDnavWhPVN5AZVo8PmHP1O195k/m5mqk9vE+M9MKyg1rPnp6tki6EjINW/29nK3JfYYD6KJKYoafSXtUbdpK4GpnzS/86qrjn3+hI9FKpUFsmek6gjKCg7MmLu0AWWy41427NKtIsA/MgUZSyy425tChVcUWYMppHRwKfkREZT0FeHscN7JIefxK6few6vVopmI3smrV6+ixbPn3AyKmvjUdUDEuftXW03G8ItpGxDzJyPww5IcSaCqSi9zRDuywhJ6n53cCe1KJAwkdE780hENj8f/flkd/xRXNCGzl3VPxj07n3+VQPKBEmER9oRB1U9eBdy5TlhnSvQV4CsLoRPmlyxhLdeqZOHSuhZIuzfJTBTrmX+IO3HVH/9L6+XIBdGo/pQXaeoHIgJJCAePqNWHl/YmZMP0fa1/0/LveI0zzpZEj3QjGSfFmaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(11063799006)(3023799007)(6133799003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dVUHKWPmkNFMt/tj0urMz+enPr3TRgtcQdLSEYoBZ5+JdTkenVjhxf5kWFQ6SPrZQiTjZwnpolKNxBB/WvlRdVdtrQq9zUZj1vlkCKsdxZ+Xk8fL123Q3cO2fBsfHmg07drTtPQQHJnejeUcvEMw0Rrt68UU1e/jLxhYRLv53QC88ThueYrfMdVZgW0FZfZdA8C4sARzsZhXskEg5EtKnTiX8Dli9XYpRm54XBmd3woAvzxdc0Gkk7upEujrbbrc7VfwJvmK+/3QZbdxsIOu9Ec8Gp6iRA2R0cvq6+61zWs3uZ05z6RwNqrovPMoEC23RrGKzxajmvIAfw9KhBbhj4DzBkO2wfT9AvCIfErKOt/1g76BZAJtfhb99oB/iUUD83WNz78rqjQXniDpt+wi+EBSSDvUJfj+koHCkt1jcSV22Vc8WAtPskbPChJDsBM1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:33:31.6593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a516b3-ecf4-4e3f-5dc6-08ded6bcf0e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:40:28 -0400
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

From: Nikunj A Dadhania <nikunj@amd.com>

Add the AVX512 Bit Matrix Multiply feature flag at CPUID leaf
0x80000021_EAX[23], enabling guests to detect and use BMM instructions
for accelerated bit matrix multiply operations. Add the "avx512-bmm"
feature name to allow QEMU to expose this capability when available on
the host.

avx512-bmm: AVX512 Bit Matrix Multiply instruction

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8929a75c7c92..a85cc67700fa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1434,7 +1434,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "auto-ibrs", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "prefetchi", NULL, NULL, NULL,
+            "prefetchi", NULL, NULL, "avx512-bmm",
             "eraps", NULL, NULL, "sbpb",
             "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
         },
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 67e2ecf32517..e66333cd9c24 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1200,6 +1200,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
 /* Indicates support for IC prefetch */
 #define CPUID_8000_0021_EAX_PREFETCHI                    (1U << 20)
+/* AVX512 Bit Matrix Multiply (BMM) instruction support */
+#define CPUID_8000_0021_EAX_AVX512_BMM                   (1U << 23)
 /* Enhanced Return Address Predictor Scurity */
 #define CPUID_8000_0021_EAX_ERAPS                        (1U << 24)
 /* Selective Branch Predictor Barrier */
-- 
2.53.0


