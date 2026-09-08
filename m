Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47C4C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42os-0001Uv-9a; Tue, 08 Sep 2026 16:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42oq-0001Ua-I9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:53:28 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42oo-0006ob-3Y
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:53:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+PU7momG7snc95Khmc3mRm5ACwVUBEBYCCuwfx5PeWIqQL/HeBGdjuGMx9taejn2A/CZmApoazSY7y4wAzZOLXDJSFF+IRuRu+N5Pp6/eKiMx/Pmi3fHwFdRhiUk4h9Wz99MYe49z9kES/wzyFc/Pq/5hFyx4l2nloO//E1xi48DT3YGS4WzjzJFPdCNGAU1gbNTZ7oq4VFzSTsUPdY9JJZHQXkNbtmvtA+EgKiWQowZaK1tEDNKHlLdYOJJi7MhCAPa1au79cydo2IPnjCPEETesGGFhdyAZqBRPI0/rog6rXG2uKQxai/dyfcLcdQcuPZ4+eq09FR1bErFmQSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/ATI8xHG3sBP9BTnBAUw0vNEqEn3qhd+nR+cz98RWY=;
 b=y6nAmPG1zmYE7T5b+2cAAg+gbkdCsqfkd61kZSO2VaEjntEAuG25l2SPvYwRU4igGlGI+DcxKAU7KtKNmk5jQDLtc9w9WjdgJqi/TbNLFoTzqbdpNVaGA6gozKBfR8C71px/UAgJavIdK26t42yWIqaEvlHE/mpD1s//QcgMxcHjGHwnHf0M+T4mDIIs1MbNFRga2ikGo90vVK4PoLwM6KPULpqWNw5Efrmv/KK1Ec7JgOz+jKQqML4ksKcOthjFGegfGcv4It3QnU2VoBXT59UQcqww+cd0Ad7XQzjVW5pufJIaIF/ahvh3ja0y2ep7Ii5dYlJoqtMsRc1U4+BvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/ATI8xHG3sBP9BTnBAUw0vNEqEn3qhd+nR+cz98RWY=;
 b=DjHF3zjNHkZj6si3fkDeLBhcWSkyFYFO4UEtm6JLV2V3p5mVkcg0RfIFLFoUIgxS0ftJjpdmidvZCiX9B+UC8sm23+KVZceMDyau8cDmbwYTJjFN+tPYGrM3qT8IX3wJnwC14YkqBKzCw3A+DC+fkquqZLbCxT1zUWybd6S0tc4=
Received: from CH0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:610:cc::29)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:53:17 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::83) by CH0PR03CA0084.outlook.office365.com
 (2603:10b6:610:cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:53:15 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:53:14 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 09/19] accel/kvm: Handle guest_memfd flags internally when
 creating instances
Date: Tue, 8 Sep 2026 15:48:29 -0500
Message-ID: <20260908205236.838281-10-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: e64631d7-7d51-40ac-aedc-08df0deb3440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: J0UTI24mlm/DMvFaqZ0zkcx5dAjuVY/MwqXGLRySoYgPokH82ijcAkYCLBYhtMuLEhBGbxHTuH68PE4n29+/h+n4UtsvNjydDKceZ9OD9AmI9v089FTc3rweI/p0/J7BjhjNhIxVV2uwiETPzKrsc1mGCxIqCDr58SlSHy5//ErAnWIObBq3iBIEsaVB2ZcUBod+6TIW+vE3PWyZRJCBUkohqRmIF5p3n+YUCRuOizwpmx2hqT3BymejEFL3o54FGywNamcGNmy7DroHkCkgl+i2wwy0O7dIiA2fyPrOGbuhkEjHmIGte7574rQbbdQy2xozIGYCUsOM7bDn6uWkQVs0u4MkSvgXH7aE1CBF0bQIunbXO9//Ux94Lvlf+Ne168codGyfd2FwpAmuNqOZ2jk3JSDua5UGS2kAQkyP0ZjRTm1AMTLj6XtnaPK+bBrHuKFoHqHZS6WLmSZjT9jQJoqdJPcIX9flVTChzIg/vUrbKeSzBRn5MVdA0OfidS8NJogfojrxTNU/z+lt0hUIg3l8TyhZBJkQAhfXyw4EIQPAep15+jZCOUcMqITx71wUFmkM2S0xb/sH8PhU3IvEYtRmFPGrWtDv53z3/6ZqDdoU+sCk6h86N++qT0pQr+I8IigxQ67niezAD2hNxXzNR1JpkWmPqU8KsPHwY0/oeFJDziGOiplo7yPYOArE9G6pP1dhGUKQBr0P1U6d930Fpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yg4/pcXchC85dSz0g4K6IRksu6bVEiZyyad8Ml2PDPO5FnO553rdwsBBZx/B7wziYmpUBFEx9dYsbSgkjJjtRKi91fL0EwEZOESuIwRURV28w/W6qrpuBVqUk2a2UT4XtLnyNyvn1cqqFyWwK+1jRHrdtD1fMrLktCDCKOhKZ1oI0RVkA20fN0JkPXZLbpMdtxnzR1/Sm1kccqnu+Bwnu5xz51jQ2dzHyJrykArBeiuVTvUTeSf2BT2MNQpO7Cpf8gySU+IZC/AamhWGZ9+AOIfJESJ3RSHi91ugggi+KUZIxCs0eDK+zvnpYdhqlWKa8hGRlAS4pqAc8oGV8qusEFGCvB4XMzvfbF2y9QLr0f9zKAmf8KReZ5fVlppGXP/F8MG5vnF5+QwOeZEZqsyQ+dBFgz75vmkg3irMfXLc4je9/7m8N1LscV2nCc9R8X2L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:53:15.4486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64631d7-7d51-40ac-aedc-08df0deb3440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Current hostmem code (which is callable even outside of KVM) specifies
guest_memfd flags directly, which requires pulling in kernel headers.
Additionally, it will eventually require additional knowledge that is
more suitable for KVM-aware code (e.g. whether or not to default to
private memory for confidential VMs).

Instead, push the determination for what flags are needed down into the
KVM/guest_memfd code so they can be handled internally based on VM
type/configuration and avoid further potential leakage of KVM-specific
code to general code.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c      | 26 ++++++++++++++++++++++++--
 accel/stubs/kvm-stub.c   |  2 +-
 backends/hostmem-memfd.c |  6 +-----
 include/system/kvm.h     |  2 +-
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2b838eb690..bf81a19423 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4857,7 +4857,8 @@ void kvm_mark_guest_state_protected(void)
     kvm_state->guest_state_protected = true;
 }
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+static int kvm_create_guest_memfd_flags(uint64_t size, uint64_t flags,
+                                        Error **errp)
 {
     int fd;
     struct kvm_create_guest_memfd guest_memfd = {
@@ -4898,6 +4899,27 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
     return fd;
 }
 
+int kvm_create_guest_memfd(uint64_t size, Error **errp)
+{
+    /*
+     * There isn't currently any use for non-mmap()'able gmem instances
+     * outside of kvm_create_guest_memfd_private(), so hardcode it here
+     * for general use.
+     *
+     * Additionally, *_INIT_SHARED is needed for non-confidential VMs, and
+     * confidential VMs will default to this as well to allow similar flows
+     * for initializing the VM's initial memory contents as with normal
+     * guests. In the future, the initial state may become a global policy
+     * decision based on the confidential VM configuration, in which case
+     * this would likely be the right place to decide whether or not to set
+     * the flag since it would likely be a globally-configured option.
+     */
+    return kvm_create_guest_memfd_flags(size,
+                                        GUEST_MEMFD_FLAG_MMAP |
+                                        GUEST_MEMFD_FLAG_INIT_SHARED,
+                                        errp);
+}
+
 int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
 {
     if (!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
@@ -4905,5 +4927,5 @@ int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
         return -1;
     }
 
-    return kvm_create_guest_memfd(size, 0, errp);
+    return kvm_create_guest_memfd_flags(size, 0, errp);
 }
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 9fe58efe91..26003b01a3 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -139,7 +139,7 @@ bool kvm_hwpoisoned_mem(void)
     return false;
 }
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+int kvm_create_guest_memfd(uint64_t size, Error **errp)
 {
     error_setg(errp, "KVM is not enabled");
     return -ENOSYS;
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index a9759e682b..de51cf738a 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -19,7 +19,6 @@
 #include "qom/object.h"
 #include "migration/cpr.h"
 #include "system/kvm.h"
-#include <linux/kvm.h>
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
@@ -69,10 +68,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
             return false;
         }
 
-        fd = kvm_create_guest_memfd(backend->size,
-                                    GUEST_MEMFD_FLAG_MMAP |
-                                    GUEST_MEMFD_FLAG_INIT_SHARED,
-                                    errp);
+        fd = kvm_create_guest_memfd(backend->size, errp);
     } else {
         fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
                                m->hugetlb, m->hugetlbsize, m->seal ?
diff --git a/include/system/kvm.h b/include/system/kvm.h
index b1e43ddc93..2a1501bba6 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -547,7 +547,7 @@ void kvm_mark_guest_state_protected(void);
  */
 bool kvm_hwpoisoned_mem(void);
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
+int kvm_create_guest_memfd(uint64_t size, Error **errp);
 int kvm_create_guest_memfd_private(uint64_t size, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
-- 
2.43.0


