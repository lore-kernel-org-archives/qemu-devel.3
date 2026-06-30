Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAC8C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaZc-00039N-2z; Tue, 30 Jun 2026 11:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1weaSz-0002Ba-HF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:33:42 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1weaSx-0007mF-GB
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:33:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaGBkJZ40SnAWBwcfLzWNqAMhF6WxyZWlUtgk5o+ce3JznhWHK3HvieGiEFh6DWPrXepVzBWiLTnWI47dyVHxxZVtD9KkX+QcUvEjvRNkIRTkVkSTTwGq4RT5FNXd07lD3AdcBn/1udH5+4Mvll+EBEGVLxryDZw6pvlkSNsa0+m3jl1w5gnAXpRgqUWR43HTWu/BZQRdA5b1N8KTR2x1YAwyO4S1dz41g3Acszs06y24YAjudzVtwsh4WEXlvwPcZjsw9hARbQIKkVktEUsqd13MX3gMEtfWeodIuV94shwTPg0BMvnTi61F9WB106YRHHVZFt85yG0v8iY7AhwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTGfuWPFITMY7lF3W+KrTnkN7zLM00gwItOWKnE76fc=;
 b=jV0N8Yv0mEwJct5lVqVnJVvwCcRGXwRSm6Jg6I8j7vb2aTz8kFHg6mZdT7lFFd0dWF3OgUNJ6FeCgW4Tvzy9+EaEYD+uTxRcQBu6hNlD4+BYxgCpYqhTlHoAFTK2jBX1ihBHOlCGepyoJ4YNUgVo0ui46xb3ycIEU5gbf1EE/LktsM+nNvax4iB7yTZgU7evedxQ9FOeuRUl7vyYB3gxxGuzPMllUqMH5OG/CGKOwskix95EkQMYzXizn9RBSAgUkXr1DCxDnc5MhnfGc4JsU7lX4xGVs1LfSvxHbjnsSsELDYmsajHcYh21IkfpRuPu6gcMHMPrPXSNckWqbYCWsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTGfuWPFITMY7lF3W+KrTnkN7zLM00gwItOWKnE76fc=;
 b=JJ5SmABi6Zgp72eMfDAjdElX3CbjwseYmFeODneUZhoJRmhci6e0YBvbQyzqPIwhRnC1k5pW5Y7fP0qeooscHTiG/7nZVyqAzQg2+JRsuzdoLPnkeW28NCMVpBE2gW7tQxK9ktGnMbtvcCee+E9gFKZnhOss/cCbcWpqin2U6jg=
Received: from CH2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:610:51::28)
 by SJ5PPF816B88375.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:33:33 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::ad) by CH2PR15CA0018.outlook.office365.com
 (2603:10b6:610:51::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 15:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 15:33:33 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 10:33:32 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <qemu-devel@nongnu.org>
CC: <babu.moger@amd.com>, Amit Shah <amit.shah@amd.com>, Ben Cheatham
 <Benjamin.Cheatham@amd.com>
Subject: [PATCH 3/4] target/i386: Add getting RAPSIZE for ERAPS enabled guests
Date: Tue, 30 Jun 2026 10:33:14 -0500
Message-ID: <20260630153315.1585-4-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ5PPF816B88375:EE_
X-MS-Office365-Filtering-Correlation-Id: e0325205-0ddc-424b-59d7-08ded6bcf1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yxXA6FkkCk1yQsP3ymKByXyODrYyOCMqWNzqNvTuxEXM1UsiN3TUhIrOLWW6Y2sXGz0H/byokCL5vnnz7oVSQ8wOnHTjyHxZl1pE0Q7/CDyLNgBQDEpmc1V5mr6LIGHD+KyZsLvBaGTwLNClNMjGvZM7az/ykSsjpE2UsxPHSvn/62ihAxtVmec1GTyZ+uJkoENVbNthUKS+7Qh7fbvPyiLTCqN4Eb//xnfOuwfCPNWLgekw/OIl0YeLHLOABOUX0FHPfWFmJ1vg0W4yAEeiphCQvWGwpKSV+WtV4bYSqsgvxGdOk3MIWTohQAhHw3yKawCwhCl21BZ2rf7vBThZ+FhMn+fdUrtOqz0/AuQz+zqmLsY/Pc8eYXMuzfWoU+UTke/laas61zlFIG1gP4tUlpTEGHopfzHL20VOAOjUzc9OF2U7jMpeval8+KDFz2e6aBh2QUtAGDGxfz290DvLq72DDeNr91DD4ylMiGfHbLkyVn1Z0njZZdgMM29oNq/30DtW2lybwC10OYmCqL3H21I0md9v/iHh1eu6GVV9AkyiQd2w6hEEOJbrZXRzWSyJ0gvqcRXzFD7MfilLle626mLzO6kxYZOu1B0ZhixD7uUaXQcAAwcnzYFj4fIp684OFLOohsooOhsHcGMRAYBzJOKc3tyack0lwXrnAUmAAPgVRLBTOzhi9aeu3Di1SJnYk8BUrWiqnjdTVgwbpn4Z/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C2iBwkLEFY9YkJbakb6VOLQe/VltafDSpvb1HLOT0ieJOUHkyxQ2grdDlzI13oFO/HjWmCu8HFgmKNsZj8o6AMSqWLpDLwsTYztFFSn1h7Fo1+C2jWZeo3I+io/OJvPLtbcJ5RxovsOHpWBV2v8HcUXz/H2jmKsiJ0cm9/v+DIz1h7RwW2Dw1oeOHCXSqqhPu3TLx2UCUMobr/hP4FoRj76t2YkG1L87TrRzYYZLXYUPh+Mjio/kQHF4LyPbD2wn2/UsAyKh1dJmEO3HuztJzrZsIypZTJZ2Bv9Swkdva0lUdPqSUJgVCATyk9DzsMxxaZYD/ssxO4Ek0C99QjC5dHg8Vb5gNR7B0O6S6/n7Ed0NMZHFm7Rb4ULbo14WCkgyR9kklHtAQOTQS38ClrATKke+DcwlIQslv9ndfRxCbzAU6vtcq+O/cN1iBmRvLLaq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:33:33.0286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0325205-0ddc-424b-59d7-08ded6bcf1b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF816B88375
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

From: Amit Shah <amit.shah@amd.com>

Newer AMD CPUs have the ERAPS (Enhanced Return Address Predictor
Security) cpuid bit. When this bit is available, the size of the RSB is
indicated in EBX bits 16:23 of the same function. Allow the guest to use
these features when kvm is enabled and are available on the host.

NOTE: The commit description is from a patch made by Amit while the
actual changes are a subset of that patch, hence my Co-developed-by.
Amit, let me know if the attribution looks good to you.

Signed-off-by: Amit Shah <amit.shah@amd.com>
Co-developed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a85cc67700fa..9342cc3ca4c6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9292,7 +9292,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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


