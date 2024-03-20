Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2F9C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrgI-0007IS-36; Wed, 20 Mar 2024 04:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrg6-0007Fq-Ls
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:52:06 -0400
Received: from mail-dm6nam10on2061c.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::61c]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrg2-0001Jj-Oi
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:52:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPZu3Fe4bEIzI33a0mU7dj0SbRu4G01OFcQqa4oeAJcWiLVi5JtAR0xkxGA9OhFMG84NTz56OJevcyIdPYAjFh+KelxepLzbL0vN18nXEH+Q3YaVD+ASl5aBDgrZMwn07gn4dgvMNSHggFp/5njPjjRrDE1oCqjwyyqSg6PnenliIb9531VSbs2i7PqKFFpAmgUxB6R3DFWVPc7JdmzXqkrRtRFe4pKLbLDv1dcvS2CDUo0cCQj2tDZhWqPaVlzHQiARQrcbXYiX1opMCtv/UnAN59oViAKl0sV817Sgg37uPtDam4ZNO54LFyrHRx2IC9CQBo8wAQFa5wDAS7JWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1Dq6f+bQHiqY13Q5dpJjiVh6IW9hb+DlnRG/UECoRs=;
 b=gA5OhHLMs/XNVdrK6JX6Wo34IsaLhVfKN04iAnsc42N3FSOFndqlCSuT8GodjpTIaysGwSyA7KEGTPmgNlSFBt75gb6sVqASGMq7kRqGJ+/jez+Fprf1UjC6oIVdNt5Bdyt9xs41LuwZJJ1jSNolnf07m7o4LPltOlYdkJfqtbOqk9WTFl8szv2CSETiHPROI1tPT6e4LQFcxe7SjWLbI8yg7S9RhFlTzVaBuXVamxGFTWkDruPmo5AbeMBB7W821i+EWWL5hBI6Wf2uLa4WGlDJxZ17rGKvX5MmHOfKVJmXkSWZ7MY/1uh3ZJ/a38uzod+i81TS7a4BzmiE6U1waQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1Dq6f+bQHiqY13Q5dpJjiVh6IW9hb+DlnRG/UECoRs=;
 b=HtpnWqCRsAznmiw1ARkzQaKYsQqVdNj3G0BG1xKfYjvMYeR3tKMaHrfCEC1tW1Hdk8FVV7vrHte9iPGa6twDkDzGlGOzEujYaCp6y9Mz9wWIIXFMJbzbVERMbLqbJa4pRfwcn4NbbeWXs/0oWgm8Mk0D4K//wj7BAxpXF9Y8+r0=
Received: from BN8PR12CA0023.namprd12.prod.outlook.com (2603:10b6:408:60::36)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 08:51:59 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:60:cafe::dc) by BN8PR12CA0023.outlook.office365.com
 (2603:10b6:408:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 08:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:51:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:51:58 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v3 37/49] i386/sev: Add the SNP launch start context
Date: Wed, 20 Mar 2024 03:39:33 -0500
Message-ID: <20240320083945.991426-38-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: dd92cd76-dea4-493e-f058-08dc48bb00b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3D6aqgqhTU7+Uaqc+IUDWoiA4zZ/AlEmz+Kzg+Ps+d8qzDWS1YrW1k0gt0nmq/MOM6xESm6HxUdi4ONkx0QPqi8pa7FL0uZk/YF6haHV61B2yQTeA7qM6NgcBkmfQu9s3LfNn0kIu6dABNPTCKp2xkW7vJT5TrykIY5UfpvRvkXUU23Ih4tUTtj3vnzjq3v6YduTA7o/lgoXWOs6tNTaGuXKcHUEP+5GbRDnVdH2VCgNHxnkSuuFHr6GTeJ/T600FptP4FEHAW1O9lgyvbbpkiEMW/brc+30IhKOUQ0nuYcVVRRy/Kg55eenw/1MW740CPHqnWu7nAaF9DkepWkNxO32QvU/kW7CFrR9/bN/xn3jcVquyWl9cUhCx0fkCYYit3D/lho193LhYe/enyuqyK0HlO26S4I1telnRnVCSxDN8KsnUYab0w+As6g6tPulQEp4OBBR2GSa8glNk/VTgCZCeBeZhCBJkgUOcoJkOVpw13cxx6lIbUXweuOumW08ntnOWYzYg/gPr+hUDeRC0hiPrRXKB8E/UCrFKkUNtkkepbPwyOip/n+Yv5lED9eK0o8sWVfqnvxG2V7LFYMuPJwh1ZWQCKMin1b6MKo1n2zgLv8HHGQEcYVNm7v8yzwt4NCRYzG1SH5AwWvOoU5ahtF8GY+I52p190fvi3GOcW6A7bhsckkT5/++cloirTDzQRADR0734H2BRQbV/S9CaV9fzbD9eQc8dqxhD8Kz+m3mK4GSxPjKUxLyhTuU7rN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:51:58.7568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd92cd76-dea4-493e-f058-08dc48bb00b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
Received-SPF: permerror client-ip=2a01:111:f400:7e88::61c;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
---
 target/i386/sev.c        | 42 +++++++++++++++++++++++++++++++++++++++-
 target/i386/trace-events |  1 +
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 3b4dbc63b1..9f63a41f08 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -39,6 +39,7 @@
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
 #include "exec/address-spaces.h"
+#include "qemu/queue.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(SevCommonState, SEV_COMMON)
 OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
@@ -106,6 +107,16 @@ struct SevSnpGuestState {
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
@@ -668,6 +679,30 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
     return 0;
 }
 
+static int
+sev_snp_launch_start(SevSnpGuestState *sev_snp_guest)
+{
+    int fw_error, rc;
+    SevCommonState *sev_common = SEV_COMMON(sev_snp_guest);
+    struct kvm_sev_snp_launch_start *start = &sev_snp_guest->kvm_start_conf;
+
+    trace_kvm_sev_snp_launch_start(start->policy, sev_snp_guest->guest_visible_workarounds);
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
 sev_launch_start(SevGuestState *sev_guest)
 {
@@ -1007,7 +1042,12 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         goto err;
     }
 
-    ret = sev_launch_start(SEV_GUEST(sev_common));
+    if (sev_snp_enabled()) {
+        ret = sev_snp_launch_start(SEV_SNP_GUEST(sev_common));
+    } else {
+        ret = sev_launch_start(SEV_GUEST(sev_common));
+    }
+
     if (ret) {
         error_setg(errp, "%s: failed to create encryption context", __func__);
         goto err;
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
2.25.1


