Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C29C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrdU-0000xq-QQ; Wed, 20 Mar 2024 04:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrdT-0000xh-Np
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:49:23 -0400
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrdS-0000bd-Bc
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgdgrGdmxHlC58XtUZZn91tIBW8ukDEOVhOihBRLopFhvVBcUQs5jhTcS7eyVUsQf4pG0Ze6gxDcBw4ES1GYXKRY+y7qazmKjSby1xiyF+3C8XES4QVgqdf1rsiOYKFQIhG+QJefRZUBw3nEn36ebPmnJTSu0YNZKlygw5QGUfNbD4kQobRbLCxKTAX1yJpwuVYiiZVYl2e4KTvGUP97qzukMaY3MRDatVr3ryJ8A2AujVFt9ij8pqNnECxjl/p9CvPkVVUxf6O3W6TFxcEiG1D/TnklghO7WIZx7S1Xi1QC6adc11svpAthwixFTCjwoB5m5ZOoREe2lFdcg/Isfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnMw7Oea0EMkYL0wE15+n1cEbuW+y1dR9qORsyxIdj4=;
 b=AfARDZZRHCW38+mCrLO5zz3zv3Z52KjYogtc5V7TKRFbGvqAR6MjbbSU2a2dSVJV5VrwjSOxfqW7Day1RcovKbyTtY+6TscQ3H9VrlCw8KkzkX51MFYG6/P3OLlh81wh50J1rWc+7W7+xlF4X265KSSC1yiCr4/x184qLENVYrS/eX3U1kQ+Lwp4uGdX8OhlFzFWfsSQdKSG34UgbGTL3Th8XYCVNkdO3gUvN+9ya9szUJy02SX5kFzHCbf25ncKDX/kTOtrC0EkWWlmwKCE0GCGbQvZsKQpYcZx8XuRlIm0kqQ+SOUTF3wdSIi1HlZLvZyM2EzYfNK+vptteDKAOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnMw7Oea0EMkYL0wE15+n1cEbuW+y1dR9qORsyxIdj4=;
 b=vq8luqD9zvjJggzzZIGor+JuZ9VbptosnMDQGEVHZid09pvLtyiXi0UX6+s8ZXdtmb/DotIE2ssJlU1QPuEZYjQdJLvAfR2e048xxceSpf2EzPrr9N5+H8OCIOTzGppHb4VH83qUhEMnjwMrl9yzh3cXC8X4Nq+mTDM78Fc20dg=
Received: from BYAPR05CA0018.namprd05.prod.outlook.com (2603:10b6:a03:c0::31)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 08:49:19 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:c0:cafe::b1) by BYAPR05CA0018.outlook.office365.com
 (2603:10b6:a03:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Wed, 20 Mar 2024 08:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:49:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:49:10 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 30/49] i386/cpu: Set SEV-SNP CPUID bit when SNP enabled
Date: Wed, 20 Mar 2024 03:39:26 -0500
Message-ID: <20240320083945.991426-31-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2a77f3-3efe-402f-c50e-08dc48baa14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0utBL8zQm24tCwVnwi73En871KgeNK/pivl0pocp1TZHRFHyZgibzGcyTsGfICeYRtWTIZ689vyGh9EHOdbxZyfU7R2zc6piJcpiQSmOjXi3BY+3Gzu4qFeoHljPsdJ8YRZ/qslES1DnPvo/faZ8l1ZLlFq5NJIqA2QNPPCXldGGjyfXwL14Xub1+0eU92lSQ6I4bKlMjor1jEW8vFicU3XGCMatXO4IY9BdsEsMiSlu/G5kQnaqFL1j3/z7vna2scKTzJAO31C21ZpssHrcpzeqyKPUscka/iweeK/ZwcsyP+MP8tx5wRUIp0D42Os2CduxxBW6/DC3xjw25EclDakHRHOLKtLcvTluWsIsxhuTfXE29bG+xswIer1aK4EaniZ6lrOufFn4qQyMGNtDRsegU7dsUhEjmN0dAIRW2vp1zkZ5aPYQoVps77GXRw+Vn/+Nd9Bba7PkB8HUE1vk3BhLzRu2EpKTZtUfP2vuwwYA8E9BmivpaHdjQb9l1o6NgD5XxrBoaLZPUex5f3UA/ztm8HEj9Wwd0bGEdb9ffiTyPWk9fwKrN5uf5vPJ6gqJlEpzFt3Z8d47I7bFWQUpYVdYRz3k9eC+lJMgwXrsnrpJpcbBFJoOhEIsvAqgRYJWKfQhg/k6MJ2Ck7PC4YxgTiut/M/lMI/yCuSZNfK/9812JzDHDrwQoj/tIN8277CZf+zvaNBDCCftEXliVUhU/6cn/1yTy3MYOtPiipFi11OzegOT/rC/VDPdcnQD+tG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:49:18.5328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2a77f3-3efe-402f-c50e-08dc48baa14c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073
Received-SPF: permerror client-ip=2a01:111:f403:2412::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

SNP guests will rely on this bit to determine certain feature support.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 33760a2ee1..3fdaac3472 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6664,6 +6664,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (sev_enabled()) {
             *eax = 0x2;
             *eax |= sev_es_enabled() ? 0x8 : 0;
+            *eax |= sev_snp_enabled() ? 0x10 : 0;
             *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
             *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
         }
-- 
2.25.1


