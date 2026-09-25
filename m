Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC882C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vES-0007hg-9q; Thu, 24 Sep 2026 22:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vE2-0007UT-Mv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:59:47 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vE0-0006R9-SI
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:59:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWw14wvusIudRUcOeDDqJN2JyxekH+hnd0Ii54OWPVDBEDLMRoda9wCvMuWSarEJ8PQAHVCTO6uhgBTxEL+h9MhX9JxoNmIMA+fC9BsnLG4+XsH3WMc9iRUTnW2dTJGAZxQWa/OGkfwskWpND6jiygKisF/OtkC7YejdUAebI4F7nPrlZBbAQ17yiQ9sVlmS+2CUjQfoAqrfpGNna9gl1pLldqntDesaqXM/+mz3mtVhAZ8YAPWieM2CJpJQTwfNOd+72784W+J4pxc9UQlDIBBzcoGK8+lTEVwKCsndq06/I/rGyauf+u5gp8erVMQn4IusPXc1LnKEGfJ7WJZ/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRj3zg+9itdYyS6z7QNXQBDIItCdYPar+DU2LFF/qUc=;
 b=fm7crNVSKv111uxwhUo9ETfz4lJGTsXslQhEsTb+2rPneiVHBxxstlhh/RtQgv22dsR6jK7RumwoTvdiPr5o6T1WcoXDqj+X167n/fUQrXiJuCq7CfXjEJJ8g9pJuPbL4ri+GZ4eMf/RxCW3WaT8n+xG2T8yDRHR6YmyQBi09PrWmCZhqdj0+OWhdwq4qKGpAQ4Ah3U+z6/jtFULNDnGHC0mcXd5vpUuYyYX01FLb54JqFAa7zKeeu0xfJzrXEHE9L5dGUCswFrGfrEimJixNo5xKOMLuIJzQQqhlTBZ5HYKRJ3eYH2tj75nJXch95OA/lKdOIuazxP8cMpR8HeIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRj3zg+9itdYyS6z7QNXQBDIItCdYPar+DU2LFF/qUc=;
 b=M7GEPxVfGEhDCFO41hQCph6wJ/wOTHOlh3aOSk3sL+hK4+omuy8Gjnz8R4RyOPaRdcN0lNs//V5q39u2StyEXMDCWhl29UuhxKOiiGxx2/r/PLDxjFnpKa6PuSDptqYbJq54gIoSHhiqGqXcnLPEfKdO5tCW7fX7Axnfr+hlMT4=
Received: from SJ0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:a03:3a1::25)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 01:59:38 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::65) by SJ0PR03CA0380.outlook.office365.com
 (2603:10b6:a03:3a1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 01:59:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 01:59:37 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 20:59:36 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <david@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: [PATCH v6 02/12] kvm: Detect guest-memfd flags supported
Date: Thu, 24 Sep 2026 20:43:08 -0500
Message-ID: <20260925015700.1260501-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925015700.1260501-1-michael.roth@amd.com>
References: <20260925015700.1260501-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fafb3ec-901f-4be4-a4c7-08df1aa8a782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: U2kuLGQHGXEiAt171MZGMMbPWKQd6sPUIuhTir0PmvRned6kIDP0XxD3rt7Fn0AL9TDj+PdvrV1KphCDLGQURjrxoQVKw8amDGIkclN8mmF4k6nIDykHI5c/C5crBZvoPJr23T3L3z3Sm8T/yxH38+5xhduiqk3tHTZYmQDYCVXbizNr3Oij90jHslp14JSMgh6DX8fBSR5y9JrL0do24gp85+CFitSboA2gVg6MzWuBu4ABWeTvsdAjUI2ah48rznWfEqOMksWsfReRWb5hqLcbl0NY66RRT6PG+Dx6DqrX8KmU7q1xxJB9/qmdkrMLVdutOpEbDgboxlA/EWDQ8mBDCpNEZi2XogMg5AfmSViwBr4rroQ2qkaUtCWBtDWpgOpR2eFw87T+Kqhm7IpEsFNJi55kjHsFhpLlmaLW8t4KxjxITcH3jO8dehoidPq3LOWNz0j3brap0Rox/5tmpr1pDX7sLicy4ca6YzoKQwjMxWhZv/MimHDMbodpUVKrJikaNrvUI77Ys/jkGUYMkgohaZKF/RmKif/O4rjklNTniI27BpulPQil/WPh0M3VPIiQm1RzqoZoOfeAvKiijOjl9TFOeG+sJ3BPGUJiXVOCaXG9wT5burjaKCXsOT/uzQ4HZMqkaUQnx7x40UbJEE/Cgb1GXC2YMMxSeg6M1EdO9GZDqG7+0uIjpzWRZ3dOz+wkJl1W4NPwp0EMAZSfZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EB5obDVUYlcn4fgwFCfpSdqJIpcwIf48Bypl1fnbs/IaNAHGAh0boYa1sBZD1qOJgdt6O1+dm0rOdtwoMw4JVDs39zA4pnZ1g3PrgD2cpAORmSr6CN5UrmWowkg0HtP7OEbVtecTOAV8Bhs6ON+2GxTW8TOsL2wnYlWMUzWmqbf8BjyuXplQbzwqlxn+xIaU8gcoi5/I3CSu+n2wUsyn5q+ZejuZGmqYYS711QHoIxK2ExQsZBAuYbjzLH8pMxWD4TwXZOEgify0hsV49iiQBnQwyG6znd/Yk7YGHn5KsaRCAl+EQ/RWhPhlzUSTDANFzCKPOAn5pBVmfyTTTY2aHjcnLZ4hqCyjJMK9iDU/BUggQCwUxRmBwtHLRCFAR4jBu86SfppgllI0EZnPrhj/mWFIn6i8X/RlWu03wIX8OUQ6Tg5J7r66yhfDKBpj/BmH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 01:59:37.5736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fafb3ec-901f-4be4-a4c7-08df1aa8a782
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Michael.Roth@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


