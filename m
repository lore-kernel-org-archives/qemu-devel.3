Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B8FC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vxt-00037C-Lc; Tue, 08 Sep 2026 09:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vxr-00035x-Nz
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:34:19 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vxp-0005j2-Ih
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:34:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFmwAR3Smp7FDIti8r1+ekimhhG2vAX9kYieRQLoGc+g1G1Nsww8MMRB3RmHADQsI/lrmZp+/YN3HDr5Fr7kczpl2lbyGSLTBofMWBhV2oKX+3dXSHWNoBJVvWrOhDFTx0ln8ARk/6APHt695kDY775M4tZ4+Um5Rs1LMxnvSnHkF2QNMGmqr6Tmyfld63hjZ/qyMRco+ZscDvWQN3B4OPGoObXByQw1hw0LRIj7A6dq3mikMSgwznR/gWzcRaYf0Pm1+j/Us9f3I+2EacN1tHhoem7NUl9N4TUFwMRPrrEl0DaXakmvNX4+WZZuLbTI9RTAcqJM49StBIdEY7MSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u74XA2uHVMWS+OZne+YqRMNotkkfrNGj+KtQ0r1e74w=;
 b=VlAfHFFkYn1Uq44xETS0liI3O49crpsnpcB/Nv3288UedFwWb8kX9cN7aloxDqsL2HoKLRTgu7RqJ8ztvgvK8QA4HtZWy/NlBwro6beE56N1YbnNA0fLilblj2Jxj7+mqYvIprMCM7rgFLtr7GBaeb0FcV8RZ3pU929wLPxjLmRWz/DWDizZRE13aBMaT82zga1sQpgIuJyb3DgEmvhm0xwlFW8QOm75hkt/GHju4WxqTHIJyn0ChH1TIVqK7B+Hss4hBX/B4088PCSLpGLlfhk9xfK+BmYLu5Z1xHY/NERCp4fcXqYQbiZF8vSQwJmQrL3Z3tPhGkz4ve3NS9kIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u74XA2uHVMWS+OZne+YqRMNotkkfrNGj+KtQ0r1e74w=;
 b=vw3lJ0F9B8Xnmm1XX3bWqAkK1hLkIqjiRWyqMwheIqcPISoAzuO/8ChcEDQKNOGZTwQcJk4Qj4DsNimJaOtqm1A/Jq24VvG1cXBC5fa12+pZw1e1729QaS4ZReqdT5PnIScdJKcXEFyff5vcQ0HYUGby9ZBEXNRw0fEpIV5DXkA=
Received: from MN0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::18)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:34:12 +0000
Received: from BN3PEPF00022BC7.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::a3) by MN0P220CA0024.outlook.office365.com
 (2603:10b6:208:52e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 13:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC7.mail.protection.outlook.com (10.167.248.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:34:11 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:34:10 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
Date: Tue, 8 Sep 2026 08:30:51 -0500
Message-ID: <20260908133151.836685-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908133151.836685-1-michael.roth@amd.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC7:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d6643f-3e08-49c8-a3d0-08df0dadddcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|10067099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: HWVfdo0XOeJ6VIxcfMNgtNI+IEgOeY6zQ2i3ifY/bZmRPF4Ul16yxI+PDLvyJFWm6y9aR+M1p+/8vluncwmXQ9qP0cA4TrtRxCGHwxjhIKoFH9/e5r1g18X0hEZMD1ibV0wxDiMuyUY4V11qTm41FteF4kP0DWYrcEHfm7Tn6gDt/AJLhnjTcNmfpPFsnQiMa/lttqWOzF+ls0d98SjLN9w72NMC4n9EK0/Xx4R+/mDBQItI3lywDIOMjMMgCBdzIVyovm9r7owBaUxXPaJZzMc4VlQkrZfwqcFyoaBRstj0kS6vvoKyae1oPeVVF5OVo6hgCFhChty+pbRf3JYI5wmJcld++ghe8OA1eJ41IOvda7uYHKByjoHmnCVZU5ypKKMEBkm12g+ucuKS1R7o2cX6br7QqbNpy932l2hdtK5yiEhD0Jvq0fL3ZfqLCEOLanhp8MT8vx9gi1y5eX3jK0+j0nXMpHLmYhPAsgQ3iTOR5OHMpWCZ78mBL5h1FO9vbyObMzhVygjZWi0JrjDTl6yCA7Cpg8NV95hia1SWTMO0tYJRrUyEvNYNsx22m7r9GF3pKupsuBeMvIncsxDwV5egVAQ5tmKvjTAGD9kKrfzW9pm2PoYqEb8LSdnUbKv/nWCcymAgJh+IJZihyLUk5OsSSlL1U7/zOlbouQLTLjqIVsrLEFUTGRVI64wRerpeS7/EGvlay3DgpVYs3YplUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cbW4qLo/LHgAL5VSt0Nrz290Q8ChJ9JsdH8ZwkQcNGXOR9JL12FdPRxJFHmiqVZRNYFAiQG+Wrni5g53Bp/A/oV44l1sezxLIwLpmac97qHEPyM6yVaNAKz/yMShdA7IeXe74Sr89VuNr2aZjFuC+bRbdsaD+CR1FzB2uz/TSnUMXHspNtPBKBvuL+RWtcZkpi6R3LK/NghzVPQPHN0/oKMBmaJAu5JWmgaqsUFM9mgVjN33q1IppNGzYXPHY8c8pPxyRYRmQenUOlKM5XHIWXgHIW7ulb+x7tGcm6bYgxwao6QgEcIVPlTFR///5HYj5FI69B4J3UECpXl6GzU1JHp4hoo68rLb7Joe6wISeMoiAgPMUhFHwnI9rGT6KYcNoGLA8gCBZMBhz8LBGX7A4GjNYQwCjBB2ifQ01VJPqBLxeW5BF4lISCqd4QDjC3KX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:34:11.1314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d6643f-3e08-49c8-a3d0-08df0dadddcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Michael.Roth@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

With the mmap support of guest memfd, KVM allows userspace to create
guest memfd serving as normal non-private memory for X86 DEFAULT VM.
However, KVM doesn't support private memory attribute for X86 DEFAULT
VM.

Make kvm_guest_memfd_supported not rely on KVM_MEMORY_ATTRIBUTE_PRIVATE
and check KVM_MEMORY_ATTRIBUTE_PRIVATE separately when the machine
requires guest_memfd to serve as private memory.

This allows QEMU to create guest memfd with mmap to serve as the memory
backend for X86 DEFAULT VM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 8 ++++++--
 accel/stubs/kvm-stub.c | 5 +++++
 include/system/kvm.h   | 1 +
 system/physmem.c       | 8 ++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a8..cdc7554082 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1627,6 +1627,11 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
     return kvm_set_memory_attributes(start, size, 0);
 }
 
+bool kvm_private_memory_attribute_supported(void)
+{
+    return !!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
 /* Called with KVMMemoryListener.slots_lock held */
 static void kvm_set_phys_mem(KVMMemoryListener *kml,
                              MemoryRegionSection *section, bool add)
@@ -3058,8 +3063,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_guest_memfd_supported =
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
-        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
-        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 32b4b07403..3d34e3b99d 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -143,3 +143,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
     return -ENOSYS;
 }
+
+bool kvm_private_memory_attribute_supported(void)
+{
+    return false;
+}
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 714b8c7b01..d29624034c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -551,6 +551,7 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
 int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
+bool kvm_private_memory_attribute_supported(void);
 
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 
diff --git a/system/physmem.c b/system/physmem.c
index a4a6a4710c..b665cd3c33 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2190,6 +2190,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                        object_get_typename(OBJECT(current_machine->cgs)));
             goto out_free;
         }
+
+        if (!kvm_private_memory_attribute_supported()) {
+            error_setg(errp, "cannot set up private guest memory for %s: "
+                       "KVM does not support private memory attribute",
+                       object_get_typename(OBJECT(current_machine->cgs)));
+            goto out_free;
+        }
+
         assert(new_block->guest_memfd < 0);
 
         ret = ram_block_coordinated_discard_require(true);
-- 
2.43.0


