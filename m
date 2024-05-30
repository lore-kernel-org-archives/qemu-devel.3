Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E760C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmM-0005zi-PQ; Thu, 30 May 2024 07:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmK-0005x1-1z
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:04 -0400
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2418::601]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmE-0001RQ-GU
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw2MEcyd4tkzi/uE6wZdTAVpEV3MWG+1q+DGZqqgc2aQqSFUzkiqn/mYGwmJ1aGemg/pLb1U67Xrj3V3VAgH9NYdnHBrVHH/bwcJsFLBNrxeZXPx1psesOMOyS3VVQwF4fX4tJ1V8R6kmMkgfS2lnAAXc7HSXtOShkBNF6Bn9h/GyGEf8DFl4pKNiLI7uHeMjZRDjL7K4d7Zj1ro2m7MLJKdEu8iFr234Zl8Th6ZUhJ52InuhnzpJU1gngQshxROtUybpHb+HLB6UqPR/HrhkrCSlVbiFFZvFUtSj6OQfAFN0LKPp6Ho19bAjj+Mc9HUGPVddlCHg2EEk2Re/Nfs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXMi2HZ51EUuGAKWb49pPkYT3Iu7vj1cYr6e8/3li3U=;
 b=AJJYOf/WxYUlbVzBbotN/474DRP5P1MryNC3oT2O9NhYt9oywqhlSdjr5S4gFiLF8bzHJMsa3gZpl8GLJqFLpo1PeF6RID/XzpuS4ahJGq/1g9D170AQgMOqEcMo3SM4wp3kzz5pePF2subZ351vHXW1RLrPiChWM0eHlbsokEyOVtvxjhfDUrq/RcXUfGDcMp2qjYnLRX2XU+GyyVVTpT9SxME65qaLZ92EkS2LbMj+Iqs/CZc0BrX/62E5fddeJDbUcQ4LD58tylmakhtEyve7a4JKPY+zIr/y0vwFPWYY65D79M5Q+vq0OuISWx2Bb+u+GiMjQm/bdPo9sgy73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXMi2HZ51EUuGAKWb49pPkYT3Iu7vj1cYr6e8/3li3U=;
 b=RrS8FJ8yqJJ1CaAcgHWZA+wQbGLt1CYlHD3FpcRsOH7gMzqFPjx2yXTUNhAggfigUCHIW2coIr6wH/6HtMXvq4k0k4cLwPY/Lo0gD5CUgaKKPEroRpG4UM5JL5TpUG7TNgQN+YLeItIPUGEffZ9jUtEj/AgmgQS4TXlU5GLuKss=
Received: from BN1PR14CA0008.namprd14.prod.outlook.com (2603:10b6:408:e3::13)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 11:16:55 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::c7) by BN1PR14CA0008.outlook.office365.com
 (2603:10b6:408:e3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 11:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:16:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:53 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:16:53 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 15/31] i386/sev: Add the SNP launch start context
Date: Thu, 30 May 2024 06:16:27 -0500
Message-ID: <20240530111643.1091816-16-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pankaj.gupta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 354c525c-14b9-4ec8-39fb-08dc809a0338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VgxN8dArDmAVuy8rBb+Y43XcPUdDXzm29SOGpWx4NYB7vPusxi+LjZ6AtORP?=
 =?us-ascii?Q?+bo9oWkpHWsv8yyUkSDy2I3dtPxwcKgh0ZuAN/g6SJ1d/0UXMYQgpBTFpOLY?=
 =?us-ascii?Q?6OBROuKKOedG5snsglOxFRrtFE1zevWeIDnSR1xc3Vp9qeXM3tTf3OiYbS2s?=
 =?us-ascii?Q?taiM0fn58sRfUG+4al2OCcKB2PS6wyPM1YodMDrjevZdj5V9dF+fe0bcGmuj?=
 =?us-ascii?Q?RUUwtQF0KMOey5q53s8yV0u75DxD7XSAxD1A9YIN4XKbyFM7pmkM9AuIXJbu?=
 =?us-ascii?Q?FRP4hhDoWw4KlJMQQU60ux9MkL5yunhiaDcVSgR0hlMEoceHCJB2gRTIbuJb?=
 =?us-ascii?Q?13/WNNrM2UD4MilMhV3n2NmRp7DND20BZ1Ob+1bxYPLBTLQYuuCrjeKOcU0R?=
 =?us-ascii?Q?EBmO03WUK5wlaizj3dCPgFmDWjGUsnRJro6lqqPWSNmnrAkb6IGFNEpmNYaR?=
 =?us-ascii?Q?NRQ3HPiBLm5X9Y2NQrir/TtOTh0Ww8kWds8K4bfW4HkcMlPIO4wpKe5eewfa?=
 =?us-ascii?Q?/npMkCr6p0z/dR5jAkpN4PKfodbGG4azSZs/Fd7pJzxLeuxAeD1i3ANLnUIh?=
 =?us-ascii?Q?C2AGoX3Z3FJG2KC6fDobdeUGFAfhn+9m/1k55Ghx8Q7iBa47CXMnlRr5azdx?=
 =?us-ascii?Q?k0yvebIep8ZBuE24P7BJuAYHVFksb0qsjNKyL9xVqTm9zfY4d8ur2kT0a6oN?=
 =?us-ascii?Q?CXjfJbxMBOayijVwGlhJdbfqwcliIMLXT+IS/tU9Zw0d0ioVU4wYqjbZ/DMm?=
 =?us-ascii?Q?ucaCmOwgpQIMJdo4kRKGBK39jmA+lbqK17BBATd5iW3gdwu9nGLLwRnAaEPM?=
 =?us-ascii?Q?XDRNk/CcxFcNqnIN3H3tJu8MfvGpmCggcoztUGhIfCE+nfilyujV0joMjucp?=
 =?us-ascii?Q?kqlajfj4yu6E1PYBmNi6qASvxHOVJvFhnQxnSuadCnKwteoEH8EqX2BYyMbO?=
 =?us-ascii?Q?xKGiLcgXhCh9s1lUzgd8ZYNOVG2UBMt3DoujfQPdSMcLCq2tQFc+OSaTTmPu?=
 =?us-ascii?Q?xtGTY44yXStniIhqdpFqtqe618oXay/f15w/y1UudoBnKUsq0ZSrQJgFl/3/?=
 =?us-ascii?Q?UfCpZzt6gmp7KffMM7EGJ0n+bOIn7mdQiByT9TGzQoCZvE/1Jkm53R+v2iBw?=
 =?us-ascii?Q?V1RloXoN4g6/KWieqRM2iOuSHI+LxPvfH1coqFBV97IUFms3HWDSz7hrPPjI?=
 =?us-ascii?Q?MlZfyDUAjpwkjWNrpfg/EiDOlhqYmc51Cmh0eQNLyHgn7wV7fMOYIt+T7Suc?=
 =?us-ascii?Q?zovhfkDa9SZ9rS+Lw3rE5b/1AFbZ+x0KTtd7XEWr1pRlw1GPtTawu7DGN9TV?=
 =?us-ascii?Q?XAwLveoSknuiZYMRhIvWqHgOuc03U03uNQuf3UEecqFLwy4EmlAF0Rogebgm?=
 =?us-ascii?Q?r3X8ulQFGXEkiK1OP3iMuFZqHkQp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:16:54.6634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354c525c-14b9-4ec8-39fb-08dc809a0338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959
Received-SPF: permerror client-ip=2a01:111:f403:2418::601;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

From: Brijesh Singh <brijesh.singh@amd.com>

The SNP_LAUNCH_START is called first to create a cryptographic launch
context within the firmware.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Co-developed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c        | 39 +++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  1 +
 2 files changed, 40 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 101661bf71..acbb22ff15 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -39,6 +39,7 @@
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
 #include "exec/address-spaces.h"
+#include "qemu/queue.h"
 
 OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
 OBJECT_DECLARE_TYPE(SevGuestState, SevGuestStateClass, SEV_GUEST)
@@ -129,6 +130,16 @@ struct SevSnpGuestStateClass {
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 #define DEFAULT_SEV_SNP_POLICY  0x30000
 
+typedef struct SevLaunchUpdateData {
+    QTAILQ_ENTRY(SevLaunchUpdateData) next;
+    hwaddr gpa;
+    void *hva;
+    uint64_t len;
+    int type;
+} SevLaunchUpdateData;
+
+static QTAILQ_HEAD(, SevLaunchUpdateData) launch_update;
+
 #define SEV_INFO_BLOCK_GUID     "00f771de-1a7e-4fcb-890e-68c77e2fb44e"
 typedef struct __attribute__((__packed__)) SevInfoBlock {
     /* SEV-ES Reset Vector Address */
@@ -688,6 +699,31 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
     return 0;
 }
 
+static int
+sev_snp_launch_start(SevCommonState *sev_common)
+{
+    int fw_error, rc;
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
+    struct kvm_sev_snp_launch_start *start = &sev_snp_guest->kvm_start_conf;
+
+    trace_kvm_sev_snp_launch_start(start->policy,
+                                   sev_snp_guest->guest_visible_workarounds);
+
+    rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_START,
+                   start, &fw_error);
+    if (rc < 0) {
+        error_report("%s: SNP_LAUNCH_START ret=%d fw_error=%d '%s'",
+                __func__, rc, fw_error, fw_error_to_str(fw_error));
+        return 1;
+    }
+
+    QTAILQ_INIT(&launch_update);
+
+    sev_set_guest_state(sev_common, SEV_STATE_LAUNCH_UPDATE);
+
+    return 0;
+}
+
 static int
 sev_launch_start(SevCommonState *sev_common)
 {
@@ -1017,6 +1053,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     }
 
     ret = klass->launch_start(sev_common);
+
     if (ret) {
         error_setg(errp, "%s: failed to create encryption context", __func__);
         return -1;
@@ -1811,9 +1848,11 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
+    klass->launch_start = sev_snp_launch_start;
     klass->kvm_init = sev_snp_kvm_init;
     x86_klass->kvm_type = sev_snp_kvm_type;
 
+
     object_class_property_add(oc, "policy", "uint64",
                               sev_snp_guest_get_policy,
                               sev_snp_guest_set_policy, NULL, NULL);
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 2cd8726eeb..cb26d8a925 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -11,3 +11,4 @@ kvm_sev_launch_measurement(const char *value) "data %s"
 kvm_sev_launch_finish(void) ""
 kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret, int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"
 kvm_sev_attestation_report(const char *mnonce, const char *data) "mnonce %s data %s"
+kvm_sev_snp_launch_start(uint64_t policy, char *gosvw) "policy 0x%" PRIx64 " gosvw %s"
-- 
2.34.1


