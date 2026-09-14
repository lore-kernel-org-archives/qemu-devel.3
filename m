Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991D3C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CBl-0004uf-IC; Mon, 14 Sep 2026 15:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PratikRajesh.Sampat@amd.com>)
 id 1x69Su-0003Zp-3H
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:23:37 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PratikRajesh.Sampat@amd.com>)
 id 1x69Ss-0000VA-6q
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:23:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgiEwepYod3WftD1T3OcfPUffwgp4kIWdDosoNS2EcYdgODNl1z59jbbKMyWpkj7yBXcM+jBMwnk2BWeFsl38k6ejEEiFwaIJGcd5Yhe4UR0iK6xCwsKeWwBhyGnxqk8wlcP9IOcNsBKOmXhz/MjO0QFuJeZZmzob+iJDjPNp1v1uL5+av+fo6Hkh8sPbcd1cKvVL2QJSPvRIEiIx/KP0WMy2oq/iStFK4RLVcvxuf0T3ZUOvHFLzBpU2AFzxX0NSBvthl2uj+4fib6s/Ktby+HvZlnZpeGZnLzd5rquCdqMoB9TT0rXT1v4Q8lKuQOWRbZarkjSQyWS7mtujmpjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2iAafxZy7At3JkbI0+LFEr/Pb38QiZwOI3lBaiFKGE=;
 b=Ikz3EmnRHLTOAkdz0MyRBXYh6NBMdgrFWa3yRRdMB2eiqbuADkEcFIpt0n4+5NJODYAYqUcdJ0wEIxXkdM1DSYLXge1LZsvex16akI5LGEe2ws2MSyYOr7SGNsORWE5uITzRyFgtzfbqnxPg1+H2xbn007garl/KqHhhMQ4b44tQFfGHYOETZT4rAPJ+Y7ie2TowX57u/eVezPArWi2+wk7djyeDqLyTnayOi7UXrTwIFcLhNcELTr/ft1oZCpEm2E5bc3kP0W7fw79WXCbFFmJwMCb5pmChlIBLxYYD4QAy6ApHWG8/DFz97ByQAzDRLCSSSFx8/g8rxLJFtvJwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2iAafxZy7At3JkbI0+LFEr/Pb38QiZwOI3lBaiFKGE=;
 b=cfYYf9j94oNjWzimpNbX25Am6/CZt6f8Tru+HJbLasldjThAXkNf1hMoBjPPZVxd/XCU3s84GuOGWWcLohTZ1za3DCdeNe65t5SSs0bxI6NEXyasy5U2rtgq5mCyMP6h1/wQhlwiqRdYHiksdAOiyUOMLbClv1Ezpx7ta0J3d/A=
Received: from BL1PR13CA0388.namprd13.prod.outlook.com (2603:10b6:208:2c0::33)
 by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 16:23:13 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::6c) by BL1PR13CA0388.outlook.office365.com
 (2603:10b6:208:2c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Mon, 14
 Sep 2026 16:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 16:23:11 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 11:23:11 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <michael.roth@amd.com>, <thomas.lendacky@amd.com>, 
 <ashish.kalra@amd.com>, <pbonzini@redhat.com>, <prsampat@amd.com>
Subject: [PATCH 2/2] i386/sev: Add core scheduling for ESMTP enabled guests
Date: Mon, 14 Sep 2026 16:22:44 +0000
Message-ID: <90672d57592d0f449c4611d48ac24e5855de6e69.1789399242.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789399242.git.prsampat@amd.com>
References: <cover.1789399242.git.prsampat@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca29999-f26f-4514-59cf-08df127c7895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|5023799004|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lw9V2zW77uLK+2h5wQLOIYfBQNiqYOw68XKdBSYva776gcnhgzvruRGABOGL4Q2EOV6xHs2L6dX/yIxU3co6cOdHbjQuIm5EfcxAsb/ALm81oPMs5GYLV0RomBIk4Sz5iXfHolo7LkLyS1g2O2OnvM6YZjEbBoAy7lKqGjW1TAH+OTMPSM5LhthN87q3XVZH07hGaJbZXVBscB/UyJHnGImJQZLGwciq6S1Qumk9hBrppzfxdHGbzxiCn4ZRM4nan5ggr0PeM4Lfs7a7AGDsM9Y1KqpGXH/6lYpTdi+huXHDqrw56igfLxXMLlILPjtsBikQxyCamHUJsLUj5W131X/23VsiMn91a6HdMZdNqcNIKDum4nA/upvvUgpLaKqCYCSqy7jhibLMDw3xUJ3BZF2WAOTtIubDul2568b8DKeUIT7lTf1UNNO9AbIHbJm4jKKaumjdlVTjUrbnCyKxPHYW78EiYM7gBHNTdvdlpn5CT3ol6gveTYWB5BXGp4b4rSjofgVq5IFUQo7gsEbi0AtvM7lGRYd77itMgepSFaMNIqN0PyX/yxExiYxSlKaoT8+zw+q9rxanB7Vt0GdMPmB6Gtt29SBBAn5jcBT536ZykbMAsw5dKTyTRcoMkekO29IQgsz7AT1EcfLeiWvw6cjf2Z9TXzhCrS4CU7c/OiMYquV779HmmJCQn1r8hLxgTv5Rd47HjnVvUnnN5gubxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7hS4uAEOo9a/8xuG/BXtP68qICue/Isv9CdJsJ57PkrINb9El3iIhusSnXlE0ceKQN0Y++57ml7Feh8J1X91tq3ieCY2SD7wzTUSdIXEOZ0mbl5GtkKpM2iJBk9aTndb98wqQKu48SSZg2u3XEKdri2nkOkxSJTn8ErohoGWDCmKLOnq6kQtpo8FOlBfHO+9KVNqEMmORp6Wc8EGCAEQpZ0P/SRDroNPmq9ijHV0RSFjLrLhLkq2GS5UDygq4pAiK8bRTzQYe0W6OsSQ9O/8PU+f6n1/ORCb6rwjWnvyVdp4ddPa9QZoa7Sa77s0C9wsAhAcTNMgw8osnieBf6x9YRCP9orjLl0eHs+A/O/nSD7KAKiV4PPC622FGLe6PsE4kF8gaitA4p3t6cd1I66VPTO/kp0EmmLtzGzfyphhqYcnZnka4wqqXlBIdMdGOWmr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:23:11.7815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca29999-f26f-4514-59cf-08df127c7895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7B9E98CB6
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=PratikRajesh.Sampat@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 14 Sep 2026 15:17:58 -0400
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

Group the vCPU threads for core scheduling such that trusted siblings
share cookies and can be co-scheduled on the same core.

The grouping cannot affect isolation. Hardware checks each pairing
against the mask in the VMSA, which only the guest writes, so nothing
chosen here can bring about a pairing hardware would have refused.

It does decide whether the guest makes progress. Co-scheduling two vCPUs
whose masks disagree makes every VMRUN exit with VMEXIT_ILLSIB, which
KVM can only answer by retrying, and that never converges.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 target/i386/sev.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 0b5767057175..34d9851d4e94 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -18,6 +18,7 @@
 #include <linux/psp-sev.h>
 
 #include <sys/ioctl.h>
+#include <sys/prctl.h>
 
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
@@ -2031,6 +2032,47 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     return 0;
 }
 
+/*
+ * Mint a cookie for the first vCPU and copy it to all the others, so that
+ * every vCPU thread of this guest ends up in one core-scheduling group.
+ */
+static void esmtp_core_sched_setup(CPUState *leader, run_on_cpu_data arg)
+{
+    CPUState *cpu;
+    int ret;
+
+    ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, leader->thread_id,
+                PR_SCHED_CORE_SCOPE_THREAD, 0);
+    if (ret < 0) {
+        error_report("vCPU %lu: failed to create core-sched cookie: %s",
+                     kvm_arch_vcpu_id(leader), strerror(errno));
+        return;
+    }
+
+    CPU_FOREACH(cpu) {
+        if (cpu == leader) {
+            continue;
+        }
+
+        ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, cpu->thread_id,
+                    PR_SCHED_CORE_SCOPE_THREAD, 0);
+        if (ret < 0) {
+            error_report("vCPU %lu: failed to share core-sched cookie: %s",
+                         kvm_arch_vcpu_id(cpu), strerror(errno));
+            return;
+        }
+    }
+}
+
+static void esmtp_core_sched_notify(Notifier *notifier, void *data)
+{
+    run_on_cpu(first_cpu, esmtp_core_sched_setup, RUN_ON_CPU_NULL);
+}
+
+static Notifier sev_snp_esmtp_notify = {
+    .notify = esmtp_core_sched_notify,
+};
+
 static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -2049,6 +2091,11 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     g_free(sev_snp_guest->kernel_hashes_data);
     sev_snp_guest->kernel_hashes_data = NULL;
 
+    /* Setup core scheduling cookies for esmtp after the vCPUS are all up */
+    if (is_sev_feature_set(sev_common, SVM_SEV_FEAT_ESMTP)) {
+        qemu_add_machine_init_done_notifier(&sev_snp_esmtp_notify);
+    }
+
     return 0;
 }
 
-- 
2.43.0


