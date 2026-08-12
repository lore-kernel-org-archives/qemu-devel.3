Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A1FC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFUD-00023z-2N; Wed, 12 Aug 2026 16:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFUA-00023D-SF
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:23:38 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFU9-0007OL-17
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:23:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1qAovWd2nDRVOSl/nmTBKj/Ms6PmeH53vzLbFO8eUKlnwofeSoO7JOUIOAiwI90LLHIaQPXEWf0Tr76pkNeja727KobMxiC5szBpXceA8EmZpCu22g9E2qYbNdL9Vvk17Zrxe0b+btHJ/EyvUwxd587vbJ+j50toEQ91wImKkhGmFhDikYyhMXNO3X6h0brFgcFOd3T3ZiSxi06H+Z50IIxr1zFLI/1nytbGhsFM2UATzc/tt6Ch8nHQiAgz7J5TMLJYKBe3nzlOp/UF4KSWsXTmD/QUuK7WePmfDdboQg2X0byVXFmCcvuiFz18rp1Sn9bgL4NVMOraGuW7SK8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRj3zg+9itdYyS6z7QNXQBDIItCdYPar+DU2LFF/qUc=;
 b=EuSe/++7vvvjQQA7jnOl9OQ/9ra+UVdCuMhPBlPocyh0bkZvPF7hdGfY0Cj4PKUisVlLCkE2OUpeltbC1rXquwQ46niclVljeT3Ixg7+vbY1PwQW21CNAVAPLprxiSsYTegjDKkWAdp9wAwX1Ix7bHHPhrNzc4RUWGBMl079jMXBQyfJTMQ7WT8khQO3oBEANWUxLv8qC1iiki2mTaY2NgjKXXT/PTTiO68f98LeZN3SqGzvx35rvVICknkUPlESYH9vZfxUZX3Ta9+A9p1J1GZV7LGyoPEhWLmreUlgdbDJ+sCSm/MeNSpadXotDWwwpWE+rhaQnJH9kJ8FA/kr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRj3zg+9itdYyS6z7QNXQBDIItCdYPar+DU2LFF/qUc=;
 b=rMLZnOewM9avw+dwQ0nwYzd6CGbsAxY5WBTK5boOlmvLw0Osk/zv6xgFxZmRS7mXv8JF/7U5F1b9FJePmoV4+rmTJGQNh0EkVz9Zx78jW4hRy62vyt/xtlyeN9zB5EFRWDNcmgl1+TVMbqed/FaMNIBExaGszjvjLclYrVwHe6g=
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 20:23:27 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::73) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 20:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:23:26 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:23:24 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 02/12] kvm: Detect guest-memfd flags supported
Date: Wed, 12 Aug 2026 15:16:40 -0500
Message-ID: <20260812201938.198915-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812201938.198915-1-michael.roth@amd.com>
References: <20260812201938.198915-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b850d2-8cb1-449e-15b0-08def8af9101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 0NQjlrhNTZfh2I4VfjR9UvehSU2zDlcpJRoD2d20hieE+ZsZlEppTvk97C9+7jlNKaT3pWrjuLoUmMB2qhrU8+H4jIR+31PeWr9rA5uQTybbwY9mfeF047wnOvjqrH+BwZzDzt4T1pQrHHfxAH17cXF8vbri3JuSC59/rhibIsh2raBdsx5KiRbPNFPIumAVy+TCgyRp0gTPIzBEWn8jSO8XDlRNu/mZ36DmI2y6QKxw8HZ4ajsmbPQFmZ+GF5d5kok0m48yXD5uvH/MFbSOq4z9gooKtCQAL55bQ6l/AneHgT/+4Lh+8n60msllGn3daV4z6xjQHMO0tSS1RyclJ0ScW9WsTiaWAxGzzrY8wc+w44kg7jn/tn7li0xPT238T9vixSzop8EipzVIivrmQj3zx4suhSwShOtSFm7gidmv2VHyuS/NYIUqk6QIK9Z2eMOP4Mzs2j230WWni9Jm5t3/VCeCP64R0gSVPCxCsTYzpXxDgV2jUK7TpA0ZAWg5GxuJmjLVhcmbDwHJ1ppx/bPvSK3VOnmvnn4IYSKPWbULFWGt8S1LymFSHfV+ZVzv6pN7YWjHeAtUwntV3CDTU3n2VBGzTEfB1V/mdHf702QjvHhm5QtEEJE7yiPOw9pAP+ShAD6FHkM0ARPWNlPq53//ItMWtweq1v62WITSHYrlZtGbrvhHr5kZNsFnfF6MX/FMVbqEptumWeZSiOYAmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dUDdKCmcPE4zShSed526q00gv02sqRNU9Mx6Tc73aZseG803e42XcaGc2Wsp1Ep9ED0Qbykncm+uuEtLKPC2CVw92F16/CttwQG8NtP2sU6hw4YJZcNtwnTv9o6Tb4f4o2Pfs3FDwSuFC4H4nOwBG1nRttDr0n8yW172E6jiBFVrkwBXxiyaKRuPYhWRYEYGDh/A3tVzrkNVi2MTpuwA/UgCRZHJtA+cbMQtZcbu5wtlyCeRTRQen7MI1VDFcD5qwAlr+IOy23LC7GO49NSTEexIwKd3jQdC7ir9lvcbVb2GSgeL0EpQspKmLr1QVsn7D/P2/7ewYtUzNQfmixiOMk3iI8w0MFNibYqrMKgvRoLeCGpaIZbAhOiPs7GPvVw8vg4XoCjZCSpr+KgjXEYohgm7r/JHaSGGZgvzLx0/ppMcsgHMpmakIwWyX85joSxF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:23:26.8208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b850d2-8cb1-449e-15b0-08def8af9101
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Michael.Roth@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

From: Peter Xu <peterx@redhat.com>

Detect supported guest-memfd flags by the current kernel, and reject
creations of guest-memfd using invalid flags.  When the cap isn't
available, then no flag is supported.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index cdc7554082..120cab1e22 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -107,6 +107,7 @@ bool kvm_pre_fault_memory_supported;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
+static uint64_t kvm_guest_memfd_flags_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilities[] = {
@@ -3065,6 +3066,8 @@ static int kvm_init(AccelState *as, MachineState *ms)
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
         kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
+    kvm_guest_memfd_flags_supported =
+        kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
@@ -4760,6 +4763,13 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         return -1;
     }
 
+    if (flags & ~kvm_guest_memfd_flags_supported) {
+        error_setg(errp, "Current KVM instance does not support "
+                   "guest-memfd flag: 0x%"PRIx64,
+                   flags & ~kvm_guest_memfd_flags_supported);
+        return -1;
+    }
+
     fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
     if (fd < 0) {
         error_setg_errno(errp, errno, "Error creating KVM guest_memfd");
-- 
2.43.0


