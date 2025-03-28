Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFFFC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGQk-0001SB-3C; Fri, 28 Mar 2025 16:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1tyGQh-0001Rq-V0
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:35:52 -0400
Received: from mail-dm6nam11on2078.outbound.protection.outlook.com
 ([40.107.223.78] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1tyGQe-0003wV-8y
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:35:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOUI/Gnz8n2J9vNh9oW3UTrcMpmmf6tYpJSxGDpA/A9dtFdYQ2PhRnudhJG8TdvCTH3wlKoWRaLOdmplnM1LlEp8y3ajWPOGp4ww39JBDHX/EThiMwhBE2wXpXcrge0dzCTpzNIAHF1taRroFIcw+tf7MPMwM+/iykTWXqmyP4UlaTq4oYTblz6HJNE+COE4z1FQprzPpc60wGDPtihM/sTTUVrt97B2qNfhMFjNXeQFrfyDvgzg6AqPxpKBiRZFo1/u9xNImg8rUhNVWLm0HyRyECst54InxIuZA5uAil5GKyhMVKEJJZztRY8xyHOdJVmIJemGs1P/mDBUy2lMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6c4vrdcUl6OB478viD1C+bFcJJfOLl/5+YYSOUHV14=;
 b=OmZQNqmO4YfjiDuBnR1ecjq9Z7XKSQHjNd4PgU6QQlykytGSoifkuYtTnXhp4lB9QcpBR4OqzUHd3OH3Q0jvFMD4EtywJ9jEuoVyMeN2ojZlnt68bwjUnsiLJ0ZVPLSInb06vF34fFNhv5ArHn1tQBceabEtrpwzbBLqk9S3zkm0nfMQz4NFZOzvKC6noHjMaFys2ni44pgn4utvJ9gjGmE2EGIuoaNj3Nx9Qc+pL/aDrqlH6K5ThEyL3AR3QPxPIAyaC6j9WudHWp5YeK9sR7ccOao5XDI/NcWTa/zwx6CaMLTqRXT5q0Bs+IuHM1wMzA3pe9ZI2Z/2uhBVhpwvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6c4vrdcUl6OB478viD1C+bFcJJfOLl/5+YYSOUHV14=;
 b=dUZQ49kqsSrLZ8/HMLs4MFNvnA/nKvcz7L3b8byAJ1FEmcl5p7+K4qSjJ/bqDRK0BBRuum05W0eUs3wEI+opk+HxlfJvMnMznbIVoIT6xMiUbzb8gZ7GaQD45E3li1zv4R82A1l7PpU9J82GZSQTEPZVs+U975tbTTagnU9JlXE=
Received: from SJ0PR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:332::23)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 20:30:39 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::78) by SJ0PR05CA0078.outlook.office365.com
 (2603:10b6:a03:332::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Fri,
 28 Mar 2025 20:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 20:30:39 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 15:30:38 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH] i386/kvm: Prefault memory on page state change
Date: Fri, 28 Mar 2025 15:30:24 -0500
Message-ID: <f5411c42340bd2f5c14972551edb4e959995e42b.1743193824.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dc4762-d35a-4257-e2fc-08dd6e37677a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|34020700016|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fujIVgKifcK/hYpirgO9r5Qx8jCY542/EABFns/R2gELiKkFfVBGTIu6ZtLN?=
 =?us-ascii?Q?QpwoHf8a43SdAEaIxgKG6bBOKOnR/1kqXmmW3gX+5kTBvGK5uiIIH7Dj5dhL?=
 =?us-ascii?Q?6FYx30efK75llMwYHNwh2gX/vzF6KQfXWcmEh0l4cFdt6tIA8i7fy+ie+Jrn?=
 =?us-ascii?Q?7izg0BSHTlPL957pBtWMb0V9w++GnbtIlh2ad0mYzLZV0Ca60g8bKiskPHhi?=
 =?us-ascii?Q?87B6x1OoZmf/Km387Au3BnxTcgZJE1opeUiaVaduDCtIhimUjcmk1cVAmvKN?=
 =?us-ascii?Q?6kQgcVou5/SGi32RYhDBlT7NwAog55FwS5yXQYPJIh4oLhXx3lBlbrDubQ3+?=
 =?us-ascii?Q?FVXfjgNOIa6/S+Bd1Fo85p0b6XRHNDccSTSXukUVKtGoVYfKTxvd+xB00KNr?=
 =?us-ascii?Q?mqp1sPi4kBHdMeUWMjOtRdjYV848AsmUOC0y3WNaPdwsYbx2qZaOkZDvDpmJ?=
 =?us-ascii?Q?GY2mrqolCj81dezu1+LLgdIdTlogTxFUCC1pku1xxE51fkN/CDNTzM+U3uwy?=
 =?us-ascii?Q?A/oRYGInuV8DjGzZ51IzFSuo5zb6T5Lt2+1QIRAjfy+tmk42NhU35THMxvfo?=
 =?us-ascii?Q?60oX3z1SFseJ5oj84GNzY5GjRkYyP1pAaTi27v7BpE0pxRpoDwRtHi6++8KY?=
 =?us-ascii?Q?l73bmIg1LLH3RcX0qdbNRNn6cGdc4goFj/ZIyhOey+jrF9rYPkIIN5XWDs9r?=
 =?us-ascii?Q?2aYRWPtvagQsBWx74BmdzTUSYMXR4jhXnLIbg+YJsvR/cYSCaze86yBXqKJz?=
 =?us-ascii?Q?CQWIfBIwFE9neYxy2w8gNFkmcOsdw2mERJSvwOOpAh52NAOTPj/BUM3ajTTL?=
 =?us-ascii?Q?SD0FsDlM0624LgAeydq9a3fGKRugFA46F7hziLmuthSMEy7E6Scnr7RFF1PG?=
 =?us-ascii?Q?n8tLmq6GNLOTabq+mMpbEFrwTuoyw4xWIWO7rmCZ/wVBbscf2n4YgeA9gb7R?=
 =?us-ascii?Q?2VeAt+m5SJiJA7RZwhYPdcJI6vaYDxy9qwY9XiXFFF5VDOyZSuYDwpTIGfRS?=
 =?us-ascii?Q?oCDlcWKUMtv7viHOiASqqGob7FPZEi1jtBuPTnwHc9PbEv2P+3cv00ZhkjC7?=
 =?us-ascii?Q?XCc+zpoJmauJl3NR4IRWfxISNPfmrr3k5CFMbwCLyXkc/Qq6TfrpbZ+U+IcI?=
 =?us-ascii?Q?SwmyPyD0NJTlqYGJSnt7AU5w6ufxCLtEHeURAJvU/AzhcdGgMhlpKskECQuQ?=
 =?us-ascii?Q?5+SNqCYKzD8TA/+Mp7cNhG29NmglPZLMiTqxccqdduTocfSVbyB3MlMT47/E?=
 =?us-ascii?Q?oWogZXA133Aj7tmm6g/kXx45MIb7sEvdyBEFV0UBWrNDsDE7T01MFHKAVDZ9?=
 =?us-ascii?Q?bO5eKSkJ+8/BHjov6Zkk4ECZM1O/VyjxM6OYAg2ZMew1ILm4Y7DwSMWmx00n?=
 =?us-ascii?Q?am0RQ82W7wRpDDL9IfJmMXTK93eoVyA+ez/sy3Ovc/qqLXKtVX8wkwYDquzV?=
 =?us-ascii?Q?HtMTjXhNwO+r6XDHYFBdVxOwfzE6ax1HeY0ht94wDYxOwNNVXPfcUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(34020700016)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 20:30:39.3435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dc4762-d35a-4257-e2fc-08dd6e37677a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281
Received-SPF: permerror client-ip=40.107.223.78;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A page state change is typically followed by an access of the page(s) and
results in another VMEXIT in order to map the page into the nested page
table. Depending on the size of page state change request, this can
generate a number of additional VMEXITs. For example, under SNP, when
Linux is utilizing lazy memory acceptance, memory is typically accepted in
4M chunks. A page state change request is submitted to mark the pages as
private, followed by validation of the memory. Since the guest_memfd
currently only supports 4K pages, each page validation will result in
VMEXIT to map the page, resulting in 1024 additional exits.

When performing a page state change, invoke KVM_PRE_FAULT_MEMORY for the
size of the page state change in order to pre-map the pages and avoid the
additional VMEXITs. This helps speed up boot times.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 accel/kvm/kvm-all.c   |  2 ++
 include/system/kvm.h  |  1 +
 target/i386/kvm/kvm.c | 31 ++++++++++++++++++++++++++-----
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f89568bfa3..0cd487cea7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -93,6 +93,7 @@ bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
+bool kvm_pre_fault_memory_supported;
 static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
@@ -2732,6 +2733,7 @@ static int kvm_init(MachineState *ms)
         kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
         kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
         (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+    kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
diff --git a/include/system/kvm.h b/include/system/kvm.h
index ab17c09a55..492ea8a383 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -42,6 +42,7 @@ extern bool kvm_gsi_routing_allowed;
 extern bool kvm_gsi_direct_mapping;
 extern bool kvm_readonly_mem_allowed;
 extern bool kvm_msi_use_devid;
+extern bool kvm_pre_fault_memory_supported;
 
 #define kvm_enabled()           (kvm_allowed)
 /**
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c749d4ee8..7c39d30c5f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5999,9 +5999,11 @@ static bool host_supports_vmx(void)
  * because private/shared page tracking is already provided through other
  * means, these 2 use-cases should be treated as being mutually-exclusive.
  */
-static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
+static int kvm_handle_hc_map_gpa_range(X86CPU *cpu, struct kvm_run *run)
 {
+    struct kvm_pre_fault_memory mem;
     uint64_t gpa, size, attributes;
+    int ret;
 
     if (!machine_require_guest_memfd(current_machine))
         return -EINVAL;
@@ -6012,13 +6014,32 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
 
     trace_kvm_hc_map_gpa_range(gpa, size, attributes, run->hypercall.flags);
 
-    return kvm_convert_memory(gpa, size, attributes & KVM_MAP_GPA_RANGE_ENCRYPTED);
+    ret = kvm_convert_memory(gpa, size, attributes & KVM_MAP_GPA_RANGE_ENCRYPTED);
+    if (ret || !kvm_pre_fault_memory_supported) {
+        return ret;
+    }
+
+    /*
+     * Opportunistically pre-fault memory in. Failures are ignored so that any
+     * errors in faulting in the memory will get captured in KVM page fault
+     * path when the guest first accesses the page.
+     */
+    memset(&mem, 0, sizeof(mem));
+    mem.gpa = gpa;
+    mem.size = size;
+    while (mem.size) {
+        if (kvm_vcpu_ioctl(CPU(cpu), KVM_PRE_FAULT_MEMORY, &mem)) {
+            break;
+        }
+    }
+
+    return 0;
 }
 
-static int kvm_handle_hypercall(struct kvm_run *run)
+static int kvm_handle_hypercall(X86CPU *cpu, struct kvm_run *run)
 {
     if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
-        return kvm_handle_hc_map_gpa_range(run);
+        return kvm_handle_hc_map_gpa_range(cpu, run);
 
     return -EINVAL;
 }
@@ -6118,7 +6139,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         break;
 #endif
     case KVM_EXIT_HYPERCALL:
-        ret = kvm_handle_hypercall(run);
+        ret = kvm_handle_hypercall(cpu, run);
         break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);

base-commit: 0f15892acaf3f50ecc20c6dad4b3ebdd701aa93e
-- 
2.46.2


