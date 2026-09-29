Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBABBCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhf9-0006u1-BV; Tue, 29 Sep 2026 19:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhf6-0006r4-Rn
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:55:05 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhf4-0007lD-TU
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:55:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YenykbT/WD18ijmNp3cyBNrJKrYSMYLZZuYGUGdaXMFV0V88gpLzgac+SOt9jxYsDiUmwU4sNhrmXoHmKShvxjkpHtIG41qUHV/yShD4uJeekUZystM29vj3NRMx1sjtZRBE6M5kWiJz5A9wBR4JC4YkNurIvkMK7fEzXreVHSDZJnU3pLpY/eAhyHnBo6biKYHxudvF1SZCNFJnf+NUx4cCO7NxRHUMqgMas01khllsF1In9BzkL0VKwhqjrOeC1pgBSSZoR+zAXauxwYdgC3hdtCvHCZrn+tnZIX0t0qWU/PAxfovrLdl/DrqaJtMNNaf7s8pPMugPRdCb4Wqy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiW2Gcdvbz4xxi4IG4aivzAZoLzzbo8XeKClAc2yeiw=;
 b=SAAq3ZrzE//QCVHwLVj27r0xvYOkAbvt8ZLDtZ46JQHXidQVaPfsNtMKLbvrL/YjmGiEIGDGdN/b4FMFYcbjZJs3DMNuqXgGdCaplzfitHTYM2r3l7sPhC4w+Hpb7BZZJxWS3lsDYR3cZ+x6TYfWKZxlO1/dxs+ziJFTKbVj5+d0JoehGCrRSbJC5abP7oUSeEVowZj9CUx74uNPsDsioCnJm5Gu11d1841fB6g+CMwPOAYJGFBROCNaRTGSXWMQdghXOBT/gKdascyML5SIcdobDDgbk4S9zGjF7Z+WxCqUzO8vnr3YBDZrWM6nDBLM0C/4YTESCqDse26oc4kypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiW2Gcdvbz4xxi4IG4aivzAZoLzzbo8XeKClAc2yeiw=;
 b=l0qDwn7mqObWAu4wadnjerR10FLLZrU7iPThC/mcaGJASxEq39Y2DCu/MQIp3ScoL63cTX5eGSfDUACrc3A8E4T10S9rk2w3wivAwMTlIXS+qvXqdW3XGSQQMCIafmtX5vRDQAh73n8TpLs6fS9NIa99xrkMTRE3pc3FbGtL9HQ=
Received: from BN9PR03CA0953.namprd03.prod.outlook.com (2603:10b6:408:108::28)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 23:54:52 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::94) by BN9PR03CA0953.outlook.office365.com
 (2603:10b6:408:108::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 23:54:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:54:52 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:54:51 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: [PATCH v7 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
Date: Tue, 29 Sep 2026 18:50:07 -0500
Message-ID: <20260929235109.1398509-2-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 098228b7-fb25-4e5a-d3d4-08df1e850dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: a8eOOD6WSGETozjBX4iK+QaiDKPdc7MDnYq3gZGT3E2Vh4vdQ8O3L/bLmrmIufESMClvITTT+WhENMkPuhFHegM17mcwvNF6I1sM+wzuE3BTZrquF3ibH4SDUAOToDeSs36waSsgmM6SObZQ/6C1IzxFK4zMxPaPaUDQXjumZMGV71PHyFrniGMgsU8L7DL4dG0kKJxMQIh3yNwRWKAcPKVLVG/oLAOHDkZpKEq+NrWQfXybxhl5eOcUw4qbRdakufoWF/5ly6GsfCJ76+4wXjs4Ys/yZSr83IgmNwEKQvZU4QaVx5j7e0ciA6o1dfp8a1WBVu3v7vs/vXGw+S8C1TeoVvSeeicWXkZqW0sl/u/3YL6yI+DNup5GapNk5fUlMDWbtRB7a1DLV2lld+Ouqkcp+mZmMU9m1A9hCZCTZxTnseNEE1T0Hrh3OyBaXOuIbrMmq/1Au39TsH2Eu7miSCcl/b1wAFwAcD5QG71qJkCheyL6Z4+KVqd9os45/i3Hhlz8MUm6ecsYNIuadP50nbvcInQs3Y4U/uqtLtl4KSl8JnLbQiRBQNp7uRi9Rxwb0AQvjIyjvy8Putc8OAhhGHRmcWAylKoElV07mfYFYsoQKhtTtnq6NgYIAEeiA3HtsVQ/qyCLoGwcTIygVGtrR1gTsK3RaNi1NQ8SCHPEb9ktVxjYhDLbLcyRJHr9EsOnP0xy3x38tKpmwOQJ69Rykw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YhS85HiTUPTT8O7BIuo0K3kUZEJ3zJm8KrAycKfH65WpnaFA3g/e2GH+ZlOpXYb9aWn1eKC2fO/IobxfuJIFxp6f6YYh4bKgQhGjal48LeUcsF5KsHLtHcVPP6j46MDVTOE6jDhtCcmxZiVB5ftESKIzoLYjI+BdYjZ5LvEvd6FKHysaxhOWNXUT/dBz1C2GDNaF+dnZVi9waqGkJIjF0VRNDBPbSwT4jWyiKfU3gAVFSreBpZAjBCuElymp7OODGe9pGwvlXHQpCVhFGdt1KRyiMPSiyTxxoy1QQ8geMRlTvkFPNwZADMHxchkEnOvAx2lh413HwjLVcv75xjQyChC/++Tg/xiLuZL9EUlejpihMH1oSFXGZYxJReQtxq+A0Jds5sUU3oagYcPKT3ChaDyie3sOj/wYbhnydsj4r9xIUjqfoGh9bYy7Et3sapsv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:54:52.2450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 098228b7-fb25-4e5a-d3d4-08df1e850dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Michael.Roth@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 8 ++++++--
 accel/stubs/kvm-stub.c | 5 +++++
 include/system/kvm.h   | 1 +
 system/physmem.c       | 9 +++++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

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
index bd5f41cb02..1b3f327ed5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2192,6 +2192,15 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                        object_get_typename(OBJECT(current_machine->cgs)));
             goto out_free;
         }
+
+        if (!kvm_private_memory_attribute_supported()) {
+            error_setg(errp, "cannot set up private guest memory for %s: "
+                       "KVM does not support private memory attribute",
+                       object_get_typename(OBJECT(current_machine->cgs)));
+            qemu_mutex_unlock_ramlist();
+            goto out_free;
+        }
+
         assert(new_block->guest_memfd < 0);
 
         ret = ram_block_coordinated_discard_require(true);
-- 
2.43.0


