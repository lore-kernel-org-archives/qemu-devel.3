Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCDAC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEDUQ-00043E-3H; Mon, 03 Jun 2024 15:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sEDUO-000435-L9
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:37:04 -0400
Received: from mail-dm3nam02on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2405::600]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sEDUM-0003Ge-Ll
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:37:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZCQY92CxH8rHcdjksmid3/tvlKzBZop6PabvHbgaVPdkp1p/26mwCqEEkmX3vU6oVkhO8yuCUbFSrlA67qLrN5maYjtvz6Ct71hwHdhx2oIWJrSUv+frntVz9IWSeNokHE7O/m9lj7fMRqbd/PHZ8eD59IfjZEWG6t60/dLCRo3ZLOG45wGMw6DrWkMAd+EIzNXvFiy4TPgCxiA/uXSibby3/xfqcp5pDthDJlB47nCU4GBNijm7oe1qThoI1YzH2LzKluoYZQg+02lvJ/bd5pjdsKTq3DS+fl6droelquw9woAu/8YOYKGetMJnxULSh9NQxlT4U91fgdJFlY+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4Hbi3YIubbuokjUvp7e7NkkTWrJLvoNA8UYFbv/640=;
 b=L1DJpBfhSktV/KUnrNW6YTosuWJ91XRjjonEF89kAEdA37HDWrfrH3le56IVzR1HIyu9CQOBE4t5wrvgbKVPWsusr4sXY5im0qe/6fjekW6m39fgY8RnuLi7NWz8IzYY7NlRSILJP/cWW//oPlHiLOGAIgPaH9+gwF9+eXkjJJnjzOkrCcqpSYME9sFpzaFymjXMVQOa9mLX+oZ2CHti8xyallZMymWqLEPSDeY9YJPUEpi6dII7YugDa2pQftSRYLuBoieei/SvJRBiATlNxLSPPqRfNqR3gxfMk05TtX4ZMdKhGLxyEpq3Q4lI40Uwo3lF2UxM+jrqXKSm61pWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4Hbi3YIubbuokjUvp7e7NkkTWrJLvoNA8UYFbv/640=;
 b=JKn+lnbFMNs9bTmY6JRIeRqYmvCC6pyKaC+0d4QmBPdet+3OQND4V5juCNgNVlL1bG3hNdu/H+q9R9ZG+7ACCSogmxSVGuW1onnHR8TIXt2vsBDbiX59ZZSG17lizpSnMIIEp20iNN761nAQmCAVkcRc2cv5k4QMIHTKmjJPgvU=
Received: from CH2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:610:50::15)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 19:36:58 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::27) by CH2PR16CA0005.outlook.office365.com
 (2603:10b6:610:50::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 19:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 19:36:57 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 14:36:56 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <pankaj.gupta@amd.com>, <william.roche@oracle.com>,
 <joao.m.martins@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, John Allen
 <john.allen@amd.com>
Subject: [PATCH v5 3/3] i386: Add support for overflow recovery
Date: Mon, 3 Jun 2024 19:36:22 +0000
Message-ID: <20240603193622.47156-4-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c53cd8-0e19-4187-301d-08dc8404880c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WIayh/4YaeJBpIgyf+XbFVkpp2j+znunVDaK9k9gmCsDZKyYwfSKzyWROaG8?=
 =?us-ascii?Q?752ssc9qEYxQ0tQl2SXjpVc8nNCkNIQ0dofJltLKUCdBFBMQguMKH9C24dYM?=
 =?us-ascii?Q?YLjTB02m6Oc77ssRrMNdsukC4eLPTJvs1iYgZdT4DyhQ3oyIqCVIbMcUHEjh?=
 =?us-ascii?Q?8DXBcdKc0jqiv1xB9RqU1tid7jGfvDRM3bIwqoXY22tNxXn9QjgyktglhLwx?=
 =?us-ascii?Q?LE4V/kNR2Wt1cOaR1/K04aQOm51rYJL7fp59bil1lL6MPhc2+NdC5/XLNBI+?=
 =?us-ascii?Q?z7mKvQ7Ka0vAQEaydWOuY94F97B0f17POydW65dkM7Pm/EVmpniJHX4+yETc?=
 =?us-ascii?Q?u3rPDjZCQ6uCleoWfcPHL1rN59+bPKhxm3Vf3noAbk6KshUWXOISPFKEp+Bs?=
 =?us-ascii?Q?TxI9DMqenHhaR6Mo5ndWtUYEG7Vze82PQei9g+r9X5h/de3I9jTWxaIgM90B?=
 =?us-ascii?Q?JsUGsDg0DMUl9w9yHc4cVVjEW6mMdiwNRv9cqdcfVxn8Oz/XKBlwWSoMN4cG?=
 =?us-ascii?Q?7Tlf2M0WtIrFX1UaH9rsTKeFgD3WsHS3cxER5f5ekEIQKYc4GV0Qw7XpZqUz?=
 =?us-ascii?Q?fJn3JzXp4BTLkQIhbM4Ot5p7lamVAoBH5vqBXAG5ICY0ISJ6rcRjHedm1/IN?=
 =?us-ascii?Q?Qb8CdJ/G6q0VKQVCgETgEl7lIr6EBBPNmdSYoLVCLe1fUtJNcP/rtVKtLNYd?=
 =?us-ascii?Q?vvlLdAQOALE9jGSodZ+yjBHhi4AdRwCDoorBTEni7oGbj8fZQpIxYpWTKQ7v?=
 =?us-ascii?Q?fSKBVpdtY+ZANcj2nfPq8MzCVAVKGYE0F6o/+EmiI0tGqgIB869UGCrvukTY?=
 =?us-ascii?Q?+BVbfylIw9eOY1UxnclZNfiwAsIkUV4vGp75GnPijLXzgzCAjR83bhhcZPL9?=
 =?us-ascii?Q?Dp6Lpy2phutp3eFpnm87uZE5JiuKF1ZC+7n7MXwlMDC8eoRyT+78QSTShguz?=
 =?us-ascii?Q?4soI3ahLA05E8nw4TOxivgmhZ/mlkrCm6Tkm98u/KDOkCypxL9Yfid4e7/am?=
 =?us-ascii?Q?3CdORDwo6sA6wwnTY+cKoTv3u81q0rqIaxNTo6KErc38zE3qSMlVLe9ng1jg?=
 =?us-ascii?Q?jjVBKQG+OxOkLKqiA07kcQaMbzy6qVD3AmfrA6CDwlW9xAtkztumxeC3AhTg?=
 =?us-ascii?Q?ula3t1zuFw6/kmb4GpW9DNhCQAGEZFTQdIifGKiNeP6ucmq+7uo+14D5F2Js?=
 =?us-ascii?Q?qXArrqNSNagbFYa3SkjzdPwM8pEIV+It+0zWxYwI5R2P5BTxBLJlIEnj/+Gc?=
 =?us-ascii?Q?yhhfmX8xR0SJm1fQqknwJQqB54LU+LslFT+gnAUHtqzQUSqJFW0TvqZTt5N6?=
 =?us-ascii?Q?LfmCdx6HqNzcVg/v78Aq4619aeLVzJX6nY4Ymw5E+SHm/N9yNzQMBOk2YtCH?=
 =?us-ascii?Q?kHAbwychmsNqkjtbC7d2OPOZErhAMe3M0jRCL/GzOIm9wd7ynA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 19:36:57.6378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c53cd8-0e19-4187-301d-08dc8404880c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
Received-SPF: permerror client-ip=2a01:111:f403:2405::600;
 envelope-from=John.Allen@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add cpuid bit definition for overflow recovery. This is needed in the case
where a deferred error has been sent to the guest, a guest process accesses the
poisoned memory, but the machine_check_poll function has not yet handled the
original deferred error. If overflow recovery is not set in this case, when we
handle the uncorrected error from the poisoned memory access, the overflow bit
will be set and will result in the guest being shut down.

Signed-off-by: John Allen <john.allen@amd.com>
---
v5:
  - New in v5.
---
 target/i386/cpu.c     | 2 +-
 target/i386/cpu.h     | 1 +
 target/i386/kvm/kvm.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5fa2dde732..5385b26d4a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1035,7 +1035,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0007_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL, "succor", NULL, NULL,
+            "overflow-recov", "succor", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5dd41e3d69..d56cf631b5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -955,6 +955,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
 /* RAS Features */
+#define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
 #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
 
 /* CLZERO instruction */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 384b702fef..796d5e9e38 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -477,7 +477,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         cpuid_1_edx = kvm_arch_get_supported_cpuid(s, 1, 0, R_EDX);
         ret |= cpuid_1_edx & CPUID_EXT2_AMD_ALIASES;
     } else if (function == 0x80000007 && reg == R_EBX) {
-        ret |= CPUID_8000_0007_EBX_SUCCOR;
+        ret |= CPUID_8000_0007_EBX_OVERFLOW_RECOV | CPUID_8000_0007_EBX_SUCCOR;
     } else if (function == KVM_CPUID_FEATURES && reg == R_EAX) {
         /* kvm_pv_unhalt is reported by GET_SUPPORTED_CPUID, but it can't
          * be enabled without the in-kernel irqchip
-- 
2.43.0


