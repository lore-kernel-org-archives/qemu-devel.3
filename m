Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF687CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhfq-0007iF-63; Tue, 29 Sep 2026 19:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhfo-0007gx-5e
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:55:48 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhfm-00086G-KM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrtbiCjv+Ew+jDmSCIvBfrKBH6naYr/nq4oWOnYVYtiEYDNNC2+L6+xSqDm+HFl879LmkOOAqnY61W0gn7D7dTk4XvtFY1VZvJuBYCd3HP6/LqeaXO26FI9fA/PbPZdyFynmCobknVWJbMXLqMDmDMAaE6WMZPC+Ly19Ra6oZQdqV84T1GhWbl9l+j2IXRICF8FZwDc67yks3dJuUKZ7AQBpQanTa+PRdmXBVc0CWdC/zJTswcd2rn0N+qGjdPqOBbVHY7sX5Vzahb97kaZHmuLwV/eYWtQrk3vwBppwyRf2L/zpLrz2dA5tyqhGMbDewfNcu1yigCkhkbG1+p9Czw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqOCq80wst6hd+j3A8zmXak1oz3A5JChzBn/NUFNwoQ=;
 b=tbZyPof5Do7lZEiBoQXssmXBpRTP15BtFQMJFmiiy//dnuSx6OILJoKDhmiDsBmJi0mtc4q84usj6ItxfRwXhsG4yDSCY2ooPy3fH/Bg1YezVRjqdbG2oAqj5w5vG/vIItGEW53HWHB+TziYRdsphpbwqWFlRa87HWNEgWz436j+0uAJVMAnTWcGPD9K+yxUqq0W+WAolaxTOPkRcX9wGr8ek710eb3evooCfPw/gCTMtf5POmT2yG3r9BbnVulowayKmfx4v9UvSyXNziOW9UV2DrA3Y3NpAn6e9y0csXZYW17DT221RLoqZ7l6GSxR4VEpyOmmZqUPyHnZ/LxMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqOCq80wst6hd+j3A8zmXak1oz3A5JChzBn/NUFNwoQ=;
 b=1U+1OxgYjU6AZwS+PElmdgAveU/dq/+kk2mC6x5eu/sxbFiSgAs+kKMqfbDSx1ctILPzNmQJ4W4M5gHYKFjdaWsphKuWM+KEccSaj0nB+8b1wkqd6dncYHKp1CtHGlyldcwVOZI7v1opdltlltAehzU2G0qYATODdKSWTR7Xb8c=
Received: from BN8PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:d4::16)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 23:55:38 +0000
Received: from BN2PEPF0000A88E.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::3f) by BN8PR04CA0042.outlook.office365.com
 (2603:10b6:408:d4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.25 via Frontend Transport; Tue,
 29 Sep 2026 23:55:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88E.mail.protection.outlook.com (10.167.248.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:55:38 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:55:37 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: [PATCH v7 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
Date: Tue, 29 Sep 2026 18:50:09 -0500
Message-ID: <20260929235109.1398509-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929235109.1398509-1-michael.roth@amd.com>
References: <20260929235109.1398509-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88E:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 696d2d23-0f39-480c-d695-08df1e852989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|5023799004|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j6T5hju713yt8ZxtBl/xMG5ydLk2sorXHKoNXirhFdyYaz2fSPCYw6G8Qcj/idSrlir8FnlLT9s9AeM+4a157UaR98UPL9x/4PGyANThtX65IBpr8V9Woq3VGEZIaMvpbupMzOLve/0lyNSGjxLkoqKEHIXUWbX9Hftcs42Yjk1CznB/HkgJlQ2D889mng1+y/wBNsPe2dR2YEn4PMYPGcLih19NXjE0oVWCpcwau9WGEmUHrofVImfIzxaXub++v4sxfQ+31cg0yLd3EA0T/MbmbVMK2lDZMoLnm4n41jWtGYIIks17fzuyBT4wcmJkAMDxdq6Ve+jpqk3lKIJJ0oH/4LkKuF0lZYgsFEHOV+ifqcMrP2Aa+t18FqGDvn19IKDHJzyAsYG2i9QQ8etqE6c0xTCfs9InB3K3VHNo+l7o47zWBg7HHY8wdOjVRpxepBJyp2hd9Ka8tldo86qnf+BbBsckFBkE0Qy6b8NrmUnSDczCsfD9+eqzflqTe240r0bTm8Unfv2gRGDkbSda3vrNRCqajxvt1+gE86c5oZ3xpkY0dflsUsLw0uWDFkT1CZRbBiR0+Ry3YE6cEikTyZXs8lNxcB4seqQ/6TKVP0yToGnqdB/L1tW3gq+8Hb3GHvhtUFA0tASBCi4XmBaSV8IU/W9Cao1+8yachQ6QfOCy7YhDnOahN1lSCCpsFqtM559qbhBphju32T6YorNpWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CkQCzd0pf4DDVt2Cdr4XBomoHadEzxK0HB7IYzbmQxBCHvRcCcwiae/QKTsI2aFTkTT6vFx+JIJ1Lhq5ToWpAUSmfxzlQiqTWLMySC/7fd7yV9Jvp3F+f0IixKy+koeoQpa4ON+DKZesda+UmPLqmrYjnzGjvaGGWg+EKbqEDmB+ThakFpIKEI/BDiUVFgpcmMOYJsnYEtKtzYvzk3QY3HGROKto3P7XGpLIy/7LvDL1yH/X0d1xh7IT8c+CI/Rvf7TuVNUGo3qWgQYXSDd+osux6104M5Y1nDJQZBpW1Y8ADEoDsse1k/hA3rne2PxP+objomErl/nCS5umcSlDmb79NmeeezOUhWSeQTVAReEuzIpRNpw08bO2oP3SOxvbbt+YPjyXKKVp3NRpVz2klh9xzAJ6sqiR83theSqgh2v8WWTcqeWM696feqNqUhPP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:55:38.5859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696d2d23-0f39-480c-d695-08df1e852989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Michael.Roth@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: Peter Xu <peterx@redhat.com>

So that there will be a verbal string returned when kvm not enabled, or
kvm not compiled.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 11 +++++++++++
 accel/stubs/kvm-stub.c |  1 +
 2 files changed, 12 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 120cab1e22..0b1407e4ea 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4758,6 +4758,17 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         .flags = flags,
     };
 
+    /*
+     * kvm_create_guest_memfd() can be invoked from generic hostmem code
+     * where KVM might be compiled but not necessarily enabled. Because
+     * of this, check for KVM support explicitly before continuing with
+     * any KVM-specific checks.
+     */
+    if (!kvm_enabled()) {
+        error_setg(errp, "guest-memfd requires KVM accelerator");
+        return -1;
+    }
+
     if (!kvm_guest_memfd_supported) {
         error_setg(errp, "KVM does not support guest_memfd");
         return -1;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 3d34e3b99d..acbd0785e0 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -141,6 +141,7 @@ bool kvm_hwpoisoned_mem(void)
 
 int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
+    error_setg(errp, "KVM is not enabled");
     return -ENOSYS;
 }
 
-- 
2.43.0


