Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172CAC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wytyt-0002HE-Jj; Tue, 25 Aug 2026 12:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wytys-0002Gf-4P
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:26:34 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wytyq-00012q-GJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kocI4NDBWA5167eOnbAxvcsaW6ZFbMWMaBZxRmVAd0YcMr9m3gsuy7wDzaTUndUtTt9O4jI/dLoGLpYgAuhYAHO7iFpTutf85mszDSkmvAqEtC7AA4ZqMUAUqec+HPVB5wbxMdmUoKbMphqwp6ndtQn2GkHWuGcDrU/BgEDTjONdHM+hCkZU4ZeOvB7u41RMrKG4n1nwjwoDO4uk5rM5tQfgIP6LQPHZ4KPHi/hbxc5FGn78qgMagorxCBxYbTQcGYybXTMlb6MPNc/9oR4VgGz5im4kmzkr7QhXWeWKURTFyjGG72tA0lQJxFowH6vMlN9ngDtH8tvC/RWn63EMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5xj0NVBhLxiTITZukf3KLn9tojtM7PK8pW0XZtqlTg=;
 b=LbkIxAy5Prc2YYtELHyWXh8LRHQCXQgZ0+MLfrhcvws36JRMAASCu+zgK3OAVphv58S3BPUOG+9zLeE0jBgFLwsj48kUOq+CZDPixy0ngwC4z/AJ4Kga8ZFU3ybHoMzAT126HlVCUoUZjcahR8ECWTAp6tUqJGAKzAJgGIvPX337nJrIfixbCbvcQNt3YS050gzCHfj648HevdLNZ2EvZfPuYIVimhyuDl3bReSROfuRjD8ZypkpbAqa8004Bsx+B4Qy7fhluJUyWeAXUgEkjUTab6pDpu5r4x1jwMWOIUIMBMg96Jxz68d2zaZliSrXeSE8bfswKTVUbjawUOte1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5xj0NVBhLxiTITZukf3KLn9tojtM7PK8pW0XZtqlTg=;
 b=BqtQ6cf99uMULVgnSAD3rI2v1/LfLyUqweNGK/DrybniuFdufBGTxxCR/tZJX1sot0Yx32sPXxn7wp1t4vJjM9UuB9JbqANG8FcDtfUtpPizLdIFFGYgR8skgd6SkebsLaPh2FhTYFYzX9Eg93npD4RtRlV76lzOTcEcTmiiHzk=
Received: from BY3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:254::21)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Tue, 25 Aug
 2026 16:26:23 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::70) by BY3PR05CA0016.outlook.office365.com
 (2603:10b6:a03:254::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 16:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 16:26:20 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:26:19 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <babu.moger@amd.com>, "Amit
 Shah" <amit.shah@amd.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH v2 3/4] target/i386: Add getting RAPSIZE for ERAPS enabled
 guests
Date: Tue, 25 Aug 2026 11:25:43 -0500
Message-ID: <20260825162544.18633-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825162544.18633-1-Benjamin.Cheatham@amd.com>
References: <20260825162544.18633-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: ced1f055-5030-45c6-bacd-08df02c598c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4ce2TWSrYOH9gXeSbo8oYk1C2OhXlp57H7Lf2qo3+2bfspL9ISCrdwFKcrL5H9nVemGgj0w2RKaIm4PZjonUX07cafJjU4WEIwrTljyb6iC6LBEPZkWUoyfw76F0qORwt60+dfbhvJuq2gGzx1kR9AW/9JlkGG3HFbDVupQfjrRMMcZylNqjuhg5zG0BoDz4F1Jje0wJjiM+tsedWXxRhB7szQL+R9z4xhWnxplyWr1ckVA79C0CPKe7kAL9APKWefPB3NicMkT6Vq1tqIksoB1QtH33fvwTt2Mp8F2931wDA7OASzTlTjvQdF3zahjBnUnHmgs9CvAiCrwsxS9YzdFW4UQb40P32kw2jfjA9X4meKhEyr9NESxiac4W7FFQV4eT1HbEk8SrIWoCYUb4jlo/TDVR3VOo+LCWq6Ngh3pPsK3KDTKFC1TPAGQ5YWN0Ny9NDw8zNLn8enGHbEjIj4A4wnn68cG/aM4dJV73VVwJOtOXolMIQzon9s8uegdUiAN1j7oUjzqaXykn6Reib0bYX1yNqCD3hK7ShIgZChBqoLI4KHz7k2/P71TLueii/q32PGRVjjLcZsXrKr1a2sdes7dcFqqasrOTG7Eo7j8JzqKyX1PnVyrmB98gncWmnO4YwLBByVkpaChFAcnjRmD+8FSsiQ3vyTLut9EyCqUIDhCpL5OAzOQgq9nnkUaD2ht4wxtfCmYHmTVQLhnX2A==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w8XwPWQ2HkdFBJ2C7MXIM+uxIozPtHr1ryYGzLbHUYIcegDUETmtw9jFarZ85en3zd2afxiS99OhFpcJyO8c9xT8vNCz5Wa7BjgNPqyyj2faH+4umjHVUZbcy0ideNt+Gl9eZKgonkZiqp9xL6yUYklHtV/abqXu7w2a3wip3o9v56eDcT+d0GkxPfahy9nYF+uRmyUdKllsYliCjsj4lsuUjThIjuy+8Dy/WYMCV43ZR8l+KrV8g/rJiJfsLYNl7e/4SjyLoLHfXIj6mhelBkOzZBXSr0XJbF55E15+c/uCPXvXiCJg3XaDqhdgUwr9oAhOMv3rHXLjjd0IDxHEOivsckmq99IXdXMJ4uMkfha6FkhebM7E3+KRkRALLiRK61KWkKuD8p8e70YahjilEMkAghShEC7uzbpDKERYZgCm2xtu/Atw9xJPcfXSjDkF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:26:20.4243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ced1f055-5030-45c6-bacd-08df02c598c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Amit Shah <amit.shah@amd.com>

Newer AMD CPUs have the ERAPS (Enhanced Return Address Predictor
Security) cpuid bit. When this bit is available, the size of the RSB is
indicated in EBX bits 16:23 of the same function. Allow the guest to use
these features when kvm is enabled and are available on the host.

Signed-off-by: Amit Shah <amit.shah@amd.com>
Co-developed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ece2e8b279f..8805657f01de 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9300,7 +9300,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 0x80000021:
         *eax = *ebx = *ecx = *edx = 0;
         *eax = env->features[FEAT_8000_0021_EAX];
-        *ebx = env->features[FEAT_8000_0021_EBX];
+
+        if (kvm_enabled() && (*eax & CPUID_8000_0021_EAX_ERAPS)) {
+            *ebx |=
+              kvm_arch_get_supported_cpuid(cs->kvm_state, index, count, R_EBX) &
+              CPUID_8000_0021_EBX_RAPSIZE;
+        }
+
         *ecx = env->features[FEAT_8000_0021_ECX];
         break;
     case 0x80000022:
-- 
2.53.0


