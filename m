Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C459C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42rv-0004kY-9t; Tue, 08 Sep 2026 16:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42rt-0004kB-Tv
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:56:37 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42rr-0007Uc-UD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:56:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STj2AllL97wpd8Jp8IOrAKcSH5EyFVGPncDJPwXQT2Hsgpipf4j14fY9M11x+yOt+5KurJIHii4nKKtKL3sPZSXkivn3LitfG4WN540VWyXUjWEC64h+J/ytrrujOjZinOUqn4chGXetiPR4EFbLH6L6DIdDrdwxzXMRmvV7xt5riDHhT0HJnHa7LYdPLRdjA3D4rqfQTkFEHCG/iByHP3gyOwQAdZqMMHEX0mbD54kNE0t1IZC8d1J/nQ1Dkkcm+nciMeNnXV/odaI3eGhzvLiDon2L7bgwytjwhgngNhyWmyRf4I1ORkyfEFWn/JBm6aYvwhqfdX1QvJWJOucGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls0LNdgKzsb7+4arXWpyoz6xIE2Fdg9XQDtlINKrtAk=;
 b=w5bFCMi8wbZ2WJ5pF/xFU7JNJKKwpUF9zCYYcutXQ2kPZRpC9Sn3pkotCJJ7nyafND74vxN+gss4KED5ASjek7b+09VOqi5jUiZwyiaUA2vNQsa7hnJ/Mtygq08wmqb+fCExGirN3cYsaKbveNKc8/43qwc4IsmYE+tGCUkLqUT6VYGTtXESaT5eF9acvnWfXwkC4T7nDHV96miVekAYxAYofuA7NfEBFZcL1N7I8yX+r75INRZweB0uiZYJFjGzmdcYgUR8LK0UlEic4tzhTpZ1xL4EsIUaDzqpVnHWnoe0dI9nO+TnvCEWcqoPhifo1xnHxGsQ2A6VJifFJRX57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls0LNdgKzsb7+4arXWpyoz6xIE2Fdg9XQDtlINKrtAk=;
 b=ISzOs1JNchHbAFFAwFhzbOR5x1QnW8KGi2QOVGNJOlbAU9k3oWozF6B7zbgYs6zpnhuPbBD+/MqE4Q8Gw3E75ccrUbOwOEFV9t2AiCpLGbrtGAVyODr+YmXku58SesjZYa3RReg+bPiJu57LPI6YCpnWnKdOvjYYbOnt/3YPVy8=
Received: from CH5PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:1f4::13)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:56:27 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::e) by CH5PR04CA0013.outlook.office365.com
 (2603:10b6:610:1f4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:56:26 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:56:26 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 17/19] i386/sev: Update CPUID failure handling for in-place
 conversion
Date: Tue, 8 Sep 2026 15:48:37 -0500
Message-ID: <20260908205236.838281-18-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7f3a8b-9ab0-4d4a-ff51-08df0deba641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ga06Pd7ch2yfTLGyYPBVU3J2TBkUkJrjkoV51sMaWPuiGTwCY9HnH8PQu3bMygG19Wu9pZVRDgAI4BhtI3Vcs+0wMSve51GP/UJP7Adi4qdiXA1Fz5fOAGuIW4BYnHaEMpaiD5KlsapdckhW7SpE/2uCMjds3TS0PD6HaQBUszrVBE/MTS24H4xBf0ivhEJ/eqCcDA0BDT9BgAgYkTPILcGb/ZOk0gaAk3cZmyBn02Gi23TsQ08QHi6S5G8GY+LwwJuGM3oCXDNl8SwD17wJNc8w9py2oHhd+jaRZtiKylIj8/ZHRGuqiWofnMIB/gnpBvdAPEnP1ZP2+/8KFsAR14NdNF6yeEPPne2JM4ZrrPhIdKpob4lkG1vNYQt50vezxDxKWxAi8Ms2WQL5Yyk67jYLqpPn0qYpxwTMf+z1ZjtK3dxwSdCOU8UCLZkhY27a+MqRONZ74yyEv3Qe9uocvuV1KjYz3h0j+zAayawxXO8O0ksf/LqHPaNokrgDLhKVa2dJLy1IvN817ZQaiADDhPbfRDydapy+L/yeU4c8Sl3B6h3AExPRUFmF1SymTRp8Aj04tATCKTR8aOc8LrkfIjucxCeor+YGcJfiXKulsQ3/HM3JaW1K4j1xSrAedXfVKoNU8HnmYXikbzAzXTND2DMy1dr/Sx7Z8uHG31g5ol1UVHPMWsX4lJQp0pSpHz0GwRcXkKQjzUxwKqdnkFWgeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w3paSMkbF1fSbJ70vVCpBXwIm+39CxUt/ZSEYB4TXJxJlMeRFitmKnWuu7EjaiJBtuiigH+TqIY9Z7FakcGURSkBO9zT91ZJObXcx258i96klADHkNMRC/PDSzC/P9oFOMYU1W4njRNWX3IksUZBlL7KXNFoU6rmZtXnf9NotOJhcC6ruvD+2U9XujOq6A2l3YoSsqfe6749llIjSAK175eoMV/I7IYeX9TaJ0n90J3uR/byUqhgMOMc2eOVhCe80g9WeL0lq+67XPTogLqZGuSLTJlF16UQMyUBF9ny0x2qjomuXYxMpxruT1iY3KhQPGBIanK5qFXtsx+U+R542WgwmS4RBvZ1sLQ5dJwRHtc9oQhuwY/BMNh2Eaur3OU7EHcmnUJ/58W7HHmDzd/kSXxCnN70wj/583KGu9/N0IewyHFr/05/CtZkcsG+mJO6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:56:26.7188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7f3a8b-9ab0-4d4a-ff51-08df0deba641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Michael.Roth@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

When SNP_LAUNCH_UPDATE fails to update the CPUID page, the CPUID page
data passed in will be re-written with metadata about what CPUID fields
didn't match with what trusted firmware expected. In the case of
in-place conversion, this will have been the same page that was
initially passed to SNP_LAUNCH_UPDATE, and so it will have been put in
a private state prior to making the call.

Make sure to switch it back to shared before accessing it for
error-reporting, otherwise this path will generate a bus error.

While here, sneak in a typo fixup for the error message that gets
printed immediately afterward.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index dc9934d5f3..46ef3f7778 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1277,8 +1277,17 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
                          ret, fw_error, fw_error_to_str(fw_error));
 
             if (data->type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
+                if (machine_require_guest_memfd_convert_in_place(
+                        MACHINE(qdev_get_machine()))) {
+                    ret = kvm_set_memory_attributes_shared(data->gpa, data->len);
+                    if (ret) {
+                        error_report("SEV-SNP: unable to access CPUID page to "
+                                     "check failure reasons");
+                        goto out;
+                    }
+                }
                 sev_snp_cpuid_report_mismatches(&snp_cpuid_info, data->hva);
-                error_report("SEV-SNP: failed update CPUID page");
+                error_report("SEV-SNP: failed to update CPUID page");
             }
             break;
         }
-- 
2.43.0


