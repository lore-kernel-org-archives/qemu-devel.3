Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4468DC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrbg-0004k2-6w; Wed, 20 Mar 2024 04:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrbO-0004ZN-Co
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:47:16 -0400
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrbM-0000Jc-0W
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:47:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoxHFZ3nWlrvM6qp3LK12Nhxu7chheLkLcrRzgxdNWkoNebnVynPoDYULars1XLus5C87ikUVXm5XjqdVMnVv9TInXzQbAT04Myk/gMVFSxPvc8XpDcebuUicXYg/xR70WvTD8CZ9hJPQ9+Ce2tczCaBJ3OqLgoA2seeAYOP3YL+G7nb8fwz/5KyMFaR4UQSSlvychNknV5U9ailBEK8Gwt3QnOxaE4nNJgXCL+t0yW425Br5+I5Z8pKGkUtcM0Y8B0TP82lmjonb6kVkiifte6Qoopb/nGdM6hrGb653ra2+OYW+6NCTjhFlDRK5NS7/06GuWbT1mLGAUO6DEEDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pesdI+jXJDEwkRLY4SLTNkhoIN76qXTPlwOt8rnWz40=;
 b=F8rqRUDbu6hE/bsDQSfKbqTs5RD9qcFpR/4UpE2rv/0a1c5lpXgf02HUfNQw1h7CvDtD+dyY88pNqIfa2l3/1yCA0dIaY7PC7f7NPduH/2gOMd2l/B90xv1MPDG9P7hY1eOt94ScrEvWVAedvVqaKh+HRaBRE5ZSme9YOl+gWGgRBUI0yDH+YF9SvsngLonuh9hCapUMVibMvFuS9PRFPXakOSz3wSEeRMZlIuCGb7F5fUGce8G7SI8LCddtDaqyyquVgJUCBMGSr6WjTDKkOeuZgYV0sdNRXhbJDD8BTLJtaTZd9L4n5dHxC8P5QZ58ng6tOyUm011+/3xDzB+bvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pesdI+jXJDEwkRLY4SLTNkhoIN76qXTPlwOt8rnWz40=;
 b=5MqXzkwUID11cP4zTv/h7yc5ijiPtzXLfjInUsf+LtTfHBWM0KaO7bK5FQtF2hlVz4yDE43QCmYPIR6sxUA6OmsK88BFY/SHbCTS0G61sR9EKmwNR+4z0KHG02TMkroZY97JmhCeMNCn5+mOJGM25uJ9QB7X+8izoIBPlaBhyk0=
Received: from MW4PR03CA0256.namprd03.prod.outlook.com (2603:10b6:303:b4::21)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 08:47:09 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:b4:cafe::af) by MW4PR03CA0256.outlook.office365.com
 (2603:10b6:303:b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Wed, 20 Mar 2024 08:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:47:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:47:04 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 24/49] target/i386: Add handling for KVM_X86_SNP_VM VM type
Date: Wed, 20 Mar 2024 03:39:20 -0500
Message-ID: <20240320083945.991426-25-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: b673c7bb-8344-41eb-8a7c-08dc48ba53d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1QUQp+1dU8LQkFpAGhXjMeOu6SmEFJNR52WPgMkDqPLR0KcdcAz4pL1xEaHi7hgXMIIq34ROEdRycBEXtRl8cU198tRsQXrdpE1E3Ixs0DRLvfBunBFeK06BZP3IHhxLqLwLF6VNhOLI7fIe+TVwYHeUeZtFkTjB2SIf3d6mz5Yvc1n3r/AOLsuBSLvM0ktrA3i3KO1RHVKEQU+RKIixLomKXbJO+J1D9BkHh7ZWflvLM2DNgvqjrFzRYnW4BZC9YZMbfhSfzXGKLpRGMF8f+f9mYaF5ZB/NU3aQwKYdM1Z02OHaRIYu8wYvthdIZQ0ZO2q+BoWa5I/yKzJ2hgXL9w7cjRLypLoaGP7vnxWwP2ZI9CX4gdy0+GG9TSWBUVXLwRGb0iOMLnOnZjZ/nZOlPrghR57A89jlCw+5iXRCLngWuQ62lj1/5eu3G0dIrvTRNcVmDvv9PKWaQmNfbt3Kg6O8ahnVcFICVrskpIZtE8xEr8d6i+20VdAekssBl/841z/tOxbM/Jlw8nOqo4GBmMLsUFz7F2PYCNxvEhLFz8XxsWCK387vB1B488DE2yQ4UdJQ9V6Aqsg6U9D5Xo5DdaJyEaRfKFMWJZLAWtks6d00rZKYTE0dJN7c+Sq4N71D+Wv+0Rn/LwFsg4L8y57RtG+s1TCGqcdUYmOX+BMoxRJ3GcmYufZaXleGypzVQsTwP2LsqiC/UTivO0dtX84zQPJNiwzQvhOaBSm7uzh78ddaGm0Rz+mkTlQZCFArtLi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:47:08.5654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b673c7bb-8344-41eb-8a7c-08dc48ba53d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476
Received-SPF: permerror client-ip=2a01:111:f403:2415::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

An SNP VM requires VM type KVM_X86_SNP_VM to be passed to
kvm_ioctl(KVM_CREATE_VM). Add it to the list of supported VM types, and
return it appropriately via X86ConfidentialGuestClass->kvm_type().

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/kvm/kvm.c |  1 +
 target/i386/sev.c     | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e109648f26..59e9048e61 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -164,6 +164,7 @@ static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
 
 static const char *vm_type_name[] = {
     [KVM_X86_DEFAULT_VM] = "default",
+    [KVM_X86_SNP_VM] = "snp"
 };
 
 bool kvm_is_vm_type_supported(int type)
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2eb13ba639..61af312a11 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -853,14 +853,20 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
 static int sev_kvm_type(X86ConfidentialGuest *cg)
 {
     SevCommonState *sev_common = SEV_COMMON(cg);
-    SevGuestState *sev_guest = SEV_GUEST(sev_common);
     int kvm_type;
 
     if (sev_common->kvm_type != -1) {
         goto out;
     }
 
-    kvm_type = (sev_guest->policy & SEV_POLICY_ES) ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
+    if (sev_snp_enabled()) {
+        kvm_type = KVM_X86_SNP_VM;
+    } else if (sev_es_enabled()) {
+        kvm_type = KVM_X86_SEV_ES_VM;
+    } else {
+        kvm_type = KVM_X86_SEV_VM;
+    }
+
     if (kvm_is_vm_type_supported(kvm_type)) {
         sev_common->kvm_type = kvm_type;
     } else {
-- 
2.25.1


