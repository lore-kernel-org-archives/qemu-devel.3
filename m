Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AA7C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrgS-0007Z7-V2; Wed, 20 Mar 2024 04:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrgR-0007Vz-Gw
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:52:27 -0400
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrgP-0001O1-K9
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:52:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EW3HBslc4j2E5z/fx3D23W8Ijr0qSVx3tysjAXFHDtfip8E/eqmE1OzAjZtIhbbRoIbR9I+JBU/X9MwXCRjpbEFxo5zwcER8TdsPydsiJTXz4oUuAHen1BYppYq26Anq1Ql5DIAX14P6Sx/8kBi+QrbqUeo9g+zDdAfLslmOF7gZdWHmY0Dl2VT5BAJOLuBvHgP1Nv3wPYWGW5tbMvEtr4sCPLlgJTuGBppdyqhjrmI6Z1i260YbOWNVdhU0+0izMo06SWLGX7q92TmQurUDbZbqBJ8pic64A2xBp2JHnnvcFYb1f53DvOY1+SBr/5gThtguZwetoCNXuRSexFT2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwBNLpC10iIZqso/FBBl09k+neRt1a0bI6jyVG9sOFY=;
 b=H+6v5hQEPuWOx35h0sUqwdq3hXY+EVYgiyPaOhhTAtAOd4MEHHgB3LmEwiWOMoTfZA1PPPu5REabBD4RNuBjS7E9G8cg6GAGt9SvbLhfEwsAWeDrM+e9DXvTcMsZ4WMBcQ43izTugKPQARJSJXt6MRaazRvh06ThEw5z+ftUFPsfvZraTrX4MCQ0HiA6OSBLtTVFhX8pTPHT/xNOfPcMb0kK4Ggy5i6xHTNwj5zkt2fEGxNwQqmVpc+h4SdULHV/aSx7NTqSozLpd84bmNdwaPsBFKjzY1G8uaFQoaGqJFTbZDQETp5DzYo4UqIdpWVIc4jMIxicooCwz7285KkhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwBNLpC10iIZqso/FBBl09k+neRt1a0bI6jyVG9sOFY=;
 b=ndiMq817gP+e4iqHxH2GQYB/cAOWJH6e/2Hdy7WMIqh/ME/se/h2b+MPDREzESDnkBgFEMLnmSAiCTQabkcqsTPB4s61Vt5emjGS6GoFAM5DMDvEFONH8mJ3EVEYFYzGaH9lIGKbDU8hjiTtNZx9iI5zub4v9VmnCW8sePYA1Ns=
Received: from BN9PR03CA0189.namprd03.prod.outlook.com (2603:10b6:408:f9::14)
 by DS0PR12MB9345.namprd12.prod.outlook.com (2603:10b6:8:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 08:52:21 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::3a) by BN9PR03CA0189.outlook.office365.com
 (2603:10b6:408:f9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 08:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:52:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:52:19 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v3 38/49] i386/sev: Add handling to encrypt/finalize guest
 launch data
Date: Wed, 20 Mar 2024 03:39:34 -0500
Message-ID: <20240320083945.991426-39-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS0PR12MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3325e0-033c-4bae-3b26-08dc48bb0dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6rnSrFlFGECxaqRDDAor1cHZfp5kNmmqarh9IciAVtW8MZ2YHzje+Ro3aPlcuiSqH0hklBRSLrlPFLrQzcYNMKveTVVJHnOUZymnIcRQlio721FDNJwZa9IDVOWsSpD32o4EGLKk4U/Zg0sZPVWvNDWFGaIkBvjEi/5p+OmWCHW8nOLELy4db0j84vephEbTe9f1+MLmDHRQbadClWV3oOYb36imElv0btYxXvHdP2wX8U/eKHlgBkuyZRoD2b++IYz29mDiLWNyPKaVQCLCpP4bOOMh16iou6FN9dvdaRaiD23yZgDtipdPtn+pnOIWY1J9wjR9lg0zlqNwOoc/4kWxNVO8YJBQ082Po/FIGWJHN13lQDHD8twch0Zj74EDWQEsw013v4Te853Oqh9h85EB3oYzwOA0f28ODzpJwod1wOYco51DRImvKe6hVRgkXZ25uyluZ9aDMUQN57L8JVs4drJsyuCmJr5hmVPMy/v1HpwEEfy+DmxI7yZ94Pb1yDxcOxPgIs+I8YWWE89nd247HuOmirtv1vqDDfooTSd9zsTy47emfYmf3/ezPrCSPld0Foq8M6eGNzZShrI8FYODeH5ajHFl07VPOr15NoeV0MmghKW7KRQbkbFDxUoRQLuRNCZPrDbBdlqi31D7t7ULboB6yoYGb16AddfZbFmRmMT3NMs3qHiem1ajJf3NPPwe8sQ2GRZ8IjkPgRAb6leQz00gYjeMevN17uW7PJ9b4UKqPkYgRQDMvhpmSkv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:52:20.7355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3325e0-033c-4bae-3b26-08dc48bb0dd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9345
Received-SPF: permerror client-ip=2a01:111:f403:2412::601;
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

From: Brijesh Singh <brijesh.singh@amd.com>

Process any queued up launch data and encrypt/measure it into the SNP
guest instance prior to initial guest launch.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-authored-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c        | 101 ++++++++++++++++++++++++++++++++++++++-
 target/i386/trace-events |   2 +
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9f63a41f08..4155342e72 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -749,6 +749,61 @@ out:
     return ret;
 }
 
+static const char *
+snp_page_type_to_str(int type)
+{
+    switch (type) {
+    case KVM_SEV_SNP_PAGE_TYPE_NORMAL: return "Normal";
+    case KVM_SEV_SNP_PAGE_TYPE_ZERO: return "Zero";
+    case KVM_SEV_SNP_PAGE_TYPE_UNMEASURED: return "Unmeasured";
+    case KVM_SEV_SNP_PAGE_TYPE_SECRETS: return "Secrets";
+    case KVM_SEV_SNP_PAGE_TYPE_CPUID: return "Cpuid";
+    default: return "unknown";
+    }
+}
+
+static int
+sev_snp_launch_update(SevSnpGuestState *sev_snp_guest, SevLaunchUpdateData *data)
+{
+    int ret, fw_error;
+    struct kvm_sev_snp_launch_update update = {0};
+
+    if (!data->hva || !data->len) {
+        error_report("SNP_LAUNCH_UPDATE called with invalid address / length: %p / %lx",
+                     data->hva, data->len);
+        return 1;
+    }
+
+    update.uaddr = (__u64)(unsigned long)data->hva;
+    update.gfn_start = data->gpa >> TARGET_PAGE_BITS;
+    update.len = data->len;
+    update.type = data->type;
+
+    trace_kvm_sev_snp_launch_update(data->hva, data->gpa, data->len,
+                                    snp_page_type_to_str(data->type));
+
+    /*
+     * KVM_SEV_SNP_LAUNCH_UPDATE requires that GPA ranges have the private
+     * memory attribute set in advance.
+     */
+    ret = kvm_set_memory_attributes_private(data->gpa, data->len);
+    if (ret) {
+        error_report("SEV-SNP: failed to configure initial private guest memory");
+        goto out;
+    }
+
+    ret = sev_ioctl(SEV_COMMON(sev_snp_guest)->sev_fd,
+                    KVM_SEV_SNP_LAUNCH_UPDATE,
+                    &update, &fw_error);
+    if (ret) {
+        error_report("SNP_LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
+                     ret, fw_error, fw_error_to_str(fw_error));
+    }
+
+out:
+    return ret;
+}
+
 static int
 sev_launch_update_data(SevGuestState *sev_guest, uint8_t *addr, uint64_t len)
 {
@@ -894,6 +949,46 @@ sev_launch_finish(SevGuestState *sev_guest)
     migrate_add_blocker(&sev_mig_blocker, &error_fatal);
 }
 
+static void
+sev_snp_launch_finish(SevSnpGuestState *sev_snp)
+{
+    int ret, error;
+    Error *local_err = NULL;
+    OvmfSevMetadata *metadata;
+    SevLaunchUpdateData *data;
+    struct kvm_sev_snp_launch_finish *finish = &sev_snp->kvm_finish_conf;
+
+    QTAILQ_FOREACH(data, &launch_update, next) {
+        ret = sev_snp_launch_update(sev_snp, data);
+        if (ret) {
+            exit(1);
+        }
+    }
+
+    trace_kvm_sev_snp_launch_finish(sev_snp->id_block, sev_snp->id_auth,
+                                    sev_snp->host_data);
+    ret = sev_ioctl(SEV_COMMON(sev_snp)->sev_fd, KVM_SEV_SNP_LAUNCH_FINISH,
+                    finish, &error);
+    if (ret) {
+        error_report("SNP_LAUNCH_FINISH ret=%d fw_error=%d '%s'",
+                     ret, error, fw_error_to_str(error));
+        exit(1);
+    }
+
+    sev_set_guest_state(SEV_COMMON(sev_snp), SEV_STATE_RUNNING);
+
+    /* add migration blocker */
+    error_setg(&sev_mig_blocker,
+               "SEV-SNP: Migration is not implemented");
+    ret = migrate_add_blocker(&sev_mig_blocker, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        error_free(sev_mig_blocker);
+        exit(1);
+    }
+}
+
+
 static void
 sev_vm_state_change(void *opaque, bool running, RunState state)
 {
@@ -901,7 +996,11 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
 
     if (running) {
         if (!sev_check_state(sev_common, SEV_STATE_RUNNING)) {
-            sev_launch_finish(SEV_GUEST(sev_common));
+            if (sev_snp_enabled()) {
+                sev_snp_launch_finish(SEV_SNP_GUEST(sev_common));
+            } else {
+                sev_launch_finish(SEV_GUEST(sev_common));
+            }
         }
     }
 }
diff --git a/target/i386/trace-events b/target/i386/trace-events
index cb26d8a925..873a7e424e 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -12,3 +12,5 @@ kvm_sev_launch_finish(void) ""
 kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret, int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"
 kvm_sev_attestation_report(const char *mnonce, const char *data) "mnonce %s data %s"
 kvm_sev_snp_launch_start(uint64_t policy, char *gosvw) "policy 0x%" PRIx64 " gosvw %s"
+kvm_sev_snp_launch_update(void *addr, uint32_t gpa, uint64_t len, const char *type) "addr %p gpa 0x%x len 0x%" PRIx64 " (%s page)"
+kvm_sev_snp_launch_finish(char *id_block, char *id_auth, char *host_data) "id_block %s id_auth %s host_data %s"
-- 
2.25.1


