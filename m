Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECB0CD5BC9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 00:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSOGJ-00040A-Pu; Wed, 27 May 2026 20:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSOGH-0003xr-7e
 for qemu-devel@nongnu.org; Wed, 27 May 2026 20:06:09 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSOGF-00044b-BP
 for qemu-devel@nongnu.org; Wed, 27 May 2026 20:06:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFC/h5GdcwoznXBJGPvxk4MQ+L7vdVgOYYqd1zubaekusjE3nmg6sDmEGhB2OSleiJQN+6jJBPA3vAe9qfiBF2y2Rph1vHod4wcZTAsuEfKrN3s262dcLixJUAfh//jcmqwNDI/Qm/WxH9MA29CdRHAlOWC1YwTR9287sP5aVpVoblSqHiO7hNIz08n+GZye8I8QgRaMW3rTHt9xgzo4AChlmqIqGkWTL5pdhDJqRPeLwETH3+25OIPQiaVzRNoVM4foc5bw88/dIJJCNgR773wdR4YY9j4kpJoU6IKh7hiyWAwPKh5VQR1bRzNy52xvL6dA7vYcLodUnlQIoT/i9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMwnal8j5WgNoN4ojSlokNd0nCMsv+Lp3ndNxBs+tM4=;
 b=As5+myzM5muHC5DKLv6yMFfnyyIQO3obmEzaeBT16uQiO626Tl/FyhP023OtXfkIKTWMdaIygd7P85QB7ZaOy3QwhDBQ9E7WcocQpxAR3uTGb+sQUIGxrCirY7e4Y+fTEEmLlTZRUo7edj/ji2OSS0rfMbtYNpI6+NvzVwW/MlWPZ4KZbwNfnrAJG32HRjxBgoJo806mBDjExZcwTATGAJrOgbuiQ2kM3a7YmhIH/9Nd0jtkImDFnzFMt6t5EPUfnUv/K+ZZw/5KFXkwLFWzkC4oLIRpJJ01T19vAM9G+Js9xXlpu072h9U3h4QozBhIoT665AQL1RE3FFXHJJpBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMwnal8j5WgNoN4ojSlokNd0nCMsv+Lp3ndNxBs+tM4=;
 b=CtOnltYtRs5dLqptBGSGptCTbnQ79Vw9bxHWmf4VwEcctvhFxNaRMtl2oFPzTc5X3fXqlps82QxmZL6HBJhCCGG3O7Xvadvsfkhli0pK/8QjQ+zNuqdE/y8e41VYWpJ2UTyBrfxtus9CGiXTD7HpNb1IgvRvJ9gcJ2FKCHswhQI=
Received: from SA1P222CA0116.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::20)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 00:05:59 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::e) by SA1P222CA0116.outlook.office365.com
 (2603:10b6:806:3c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 00:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:05:58 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:05:58 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 11/12] i386/sev: Update SNP_LAUNCH_UPDATE for in-place
 conversion
Date: Wed, 27 May 2026 19:03:36 -0500
Message-ID: <20260528000416.8161-12-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528000416.8161-1-michael.roth@amd.com>
References: <20260528000416.8161-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5555ba-98b9-40a7-9fa4-08debc4ce5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jutXno2WDDOSkeXC7AadzNL80MDLMausmj0/W+BEYt7byAiS4S2xWjiLR6y81pbYHTMekV1iJNfpbrgopzZUqrxz8NrxzPZ5W6Ln/MwLRRS87DKZiOiO1in6QkuqmeKB7lx14o4s39uXsDToIeiYOr/wweR8LYH+1Tt0NEN2FlgRsNxA4QGJEyo1OEC6yjqk2dAp0ouBT/DmjOo30s/LlUpfx7LqS62bpkskZOugINOuSQ/Xaw0CWFQimIADXHjuZO83v5i53cHejcTrZWxxe3nQyycN0KAkx9WUma17u1TEpoyNKOUL6VwPEPuhAueA6owCnTsl9cOpiLi5iRSwAXUqTxKFwRX6o6XEqJWUFfxjs/9WmGDyrcTdXFZrwdcaeq+7CeFPHvun7hMyUT+6HwoutHzQDqcVFyWyeWw7dul6OIWtMWzPC2rkz8GzDER6EBxxpzdlEzNC/djoY3Qij2xBS5dx/Ql1iLc7wWt1Bn3rlddaOfIyJNomSK3t5buGF6l5X7OQNn6ipVwsmkw3uJsAO1CfuD08AaNWnQF5hL/pYJACxM5ao1BS6MmCTStgnnAAA10X1riR6FMnMgdtB2tnQacmlw5LB+tXS1l7pVQTEJS/p9aMRcdhaY2nzAksEhOSiSgWaMHNWez1C2OAYb8/Z9KsuXQndhtA7lnkhB9raM+SI/27vkbiBQR+KGLsJIIF83Y/BBRxdf6CDBIsVyMoB1S6elYG51OgLpm2vlg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5NIHjffMl5VvP7WZzwPOGbAelRuVC8eIgn4hMrmMYaNjPnyCwfEb8QX92N62r8Ixl4CB4I03gMefffdw9bumc1ToYU3ZlipgpWacB6X2NyJKzOrNQDhf34xWhSjy5UkMpkIlRN6vTSc7ZGiCJuZgBnB7qg+thUixYKPwWYAjiH5iiY7GIam2MzezmQRtoS6GQHkrDSud6rJ00pIO3jHLCusr6VJWKAQ+cvQTArLpSjegkfX0PV2Z5DZ7ptCBC2XBEidnPOM9qSOUrk+Jj/lTzXdn54UrI/ZD4buLHjAHIpdz/HSTL4U15F2v/WLw4qD81xV1QFORAFeLHP/rad84hUqd/0GDW/t8jD0RsJK3gYv9Ok4JBBerDv1Ga9ib01yYaJd5V01NPhXtAZQMRS7/4shlEnviu4yKvSIyghT47rLBEp75vqaicmP6lq56rHCU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:05:58.8867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5555ba-98b9-40a7-9fa4-08debc4ce5a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Michael.Roth@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

For in-place conversion, the source pointer is expected to be NULL since
the data has already been written directly to guest memory and doesn't
need to be copied in prior to encrypting it in-place for initial guest
memory payload.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b44b5a1c2b..32a5e605bf 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1186,6 +1186,8 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
     int ret, fw_error;
     SnpCpuidInfo snp_cpuid_info;
     struct kvm_sev_snp_launch_update update = {0};
+    ConfidentialGuestSupport *cgs =
+        CONFIDENTIAL_GUEST_SUPPORT(OBJECT(sev_snp_guest));
 
     if (!data->hva || !data->len) {
         error_report("SNP_LAUNCH_UPDATE called with invalid address"
@@ -1199,7 +1201,14 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
         memcpy(&snp_cpuid_info, data->hva, sizeof(snp_cpuid_info));
     }
 
-    update.uaddr = (__u64)(unsigned long)data->hva;
+    /*
+     * For in-place conversion, the source pointer is expected to be NULL
+     * since the data has already been written directly to guest memory
+     * and only needs to be encrypted in-place for secure access.
+     */
+    if (!cgs->convert_in_place) {
+        update.uaddr = (__u64)(unsigned long)data->hva;
+    }
     update.gfn_start = data->gpa >> TARGET_PAGE_BITS;
     update.len = data->len;
     update.type = data->type;
-- 
2.43.0


