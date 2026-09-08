Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFB6C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42uH-0007OP-0P; Tue, 08 Sep 2026 16:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42uG-0007Nz-6t
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:59:04 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42uE-0007xd-Ad
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:59:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRjClAk+d9pgdtsOhxNpXHbBG19O0kFPIrZwTf72lXUYWZQWXUc3nh6oMgdKLnwuICTHelOSutllA7hMkOQ51Z6Y31yqmdErPwbS3VZUwzyyDBIYUSgwiJp8XtLPFyYFIQTR7P9te/FV9dHBPD/tpVBwL+Ll3YJT90Wg1Dmsy884f7ybZ/t9iqilMKdu9w4u4klsQx4wD6cxYYPlbZweedh7wEUYQKe3AbhNZ+UpMlfgR9lDcfrNoASs/Bp+C1sGbIDs0m/+no0kG1Yd4zFZ927ebddrKduCYhv4iXyB1IMCf00ROgqDD90qNUZ7qSYr3svTuTKDNhOq5XMxQmadBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+UcoeUtof3udrqlHQ+fX+tI8G3sgPFKfOVrQ8CXor8=;
 b=qlJ15iQ80+wBf0oYtcb38e11r4gh+6FZsx8zdhRB/G7ek70HTNXqhNn3lITBCtAcsXBE3VB/CrsT+gG9bm6luQwKFTaAsMJIki5eYqT4g8hX7CH+gRMjgTzXMdkRHuKle0BSCfrRJ6zk9k8x24mqcCpKCAMdx2IwcP7BSuLJJm097VnoVIrKNdLd7elOJrk0Qxz9ia0cl52GmxocAHmfSIp7qPkWiHKtlYIB1sa1CZisC1QOUH7IoeNzhMw/OZLVd9kuoEjgPPlSx2kCJNsBMq/gpTEd2FCOcyaUCdqCyJBADdy5m4zNPKaP/FKunl8jsUN+Aq7L6yE1LaJynskdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+UcoeUtof3udrqlHQ+fX+tI8G3sgPFKfOVrQ8CXor8=;
 b=ZL2yRKN9j5EtlFJfFMCRwqN8b1rfN4HuiFz5Qti0T/O786ecV6rgAceuADTaIThJSwR15gJ9lYxIS22VnCMPvaBRtH+lvvBgFbA93IdzK8LQYyaaggajZ6OUZMJYEJJqB90B3/mDrvSM5Qu8NuwhAg4dtpFZMzKHjo8V4nPjv9g=
Received: from DS7P220CA0093.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::17) by
 PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:58:52 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:25a:cafe::6d) by DS7P220CA0093.outlook.office365.com
 (2603:10b6:8:25a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 20:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:58:52 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:58:51 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 05/19] accel/kvm: Use dedicated helper for creating
 private-only gmem instances
Date: Tue, 8 Sep 2026 15:48:25 -0500
Message-ID: <20260908205236.838281-6-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c98da5-0dba-4ea9-0b8c-08df0debfce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Ir5dOKsrJYBimLT7m63uJPOTOGNK3rh3z6gUuJ5IFj5JbQJZYVt6cmVDMinD5uaO7wAuMSzFsaV3DxMyywE+kFwgAlm3Sr/w78Z+4KPCM7TYFD+jYWbh6zNrGgbwVYxzCyYuz4mCYrx3sN6UdmPWKE7rI4yhoFy1oUI3H1XY5T6RESee/aFs0xWZZT7FFIQ9gO36MSLA+q0WfTT0wbq4aY+963gasetADxMGudZL3W42hjVZZVsLxG1nVtKH8+jqodYN9HHrMar9OEBo0Lj3u4SV7rmm9YE/LDZ5USr8neXJvPngI7iW5Krh5cda5pr1eUEGOsdbFp4rWAXCrkXG+Uqvopn48VqhRmbsfqhdqAL740sBzUXdo02DdhVwLT0rJEXL79RWbfoE0EL6WIQdvLkD5K6wA3V9383mldcfNvSCjM02tFQkjgB4Qay85MsELkS/9eirwjuxbAxJwvnyVJcn/XBzU9fL+OX9jyTvrHudVC0WlAdyL+oBIJEEwfPqR2d/7MTtHplf9QMAC9tI89Rmd9N60rPFfN8/rEnPD06wLStiaKuuB8bMXuyTLGZnTDELdbhCxPllSrfnS/yqSX38+YtjnXYqiGvmuB5nsJei6CCocCt5b3mekhy9cG3tdml+nlicGFrnm9wJOO9LTI2MQxUlI/9ko5d4rwYKqpgJOSgNGpPL+qBle398ey5/pwOs64Dwp3Sxr4957XDXnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9wa4Ly6MciDQharb/at+UEXigqfEIruDapUMWbhT7+UJ0eaP2cqFKAmttDqq2jaDSrju2CJHVd6ZPysq7fRFtXcmx1E1HlCN0IgTbt9EaAhVjbDtE432RhFz9E1GiFai6Mfljlkk5/KyGvdm1NJLf1KGCEvrhT+jSTbj/uAD+++oBS6+JHMUZKrYfctS9Hvj0nPYhsxcxCtlDo34n0INj3klS4NcxwIPws+b8/r4pASbEX/dtrm2e6ndHFLnwHYk5ZFJKNOzH0BtG8UvLTn/BAKKideZReZS6SJglcOsNuhrQ2TO9JHgToaM7lc+pA14TZRbIMrrzlirX5DtsqCIUEiTlPWye6TsHhAQF4oURViKboPqVNQfyqEUARBf9Un5UIbW/CW/wRnIvvsnRpT8HoASaJYFeXH6uGSPXi6lCDqZn/yKhGOcmNmcUTNc53Xs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:58:52.0365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c98da5-0dba-4ea9-0b8c-08df0debfce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Michael.Roth@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

Currently QEMU supports using guest_memfd internally (separately from
user-specified memory backends) to handle private memory for
confidential VMs. While KVM can switch between guest_memfd-backed
private memory and non-guest_memfd-backed shared memory via
KVM_SET_MEMORY_ATTRIBUTES, the memory in the guest_memfd inode can only
ever be private memory.

This is distinct from upcoming in-place conversion support, where
guest_memfd inodes can contain both private/shared memory and can
convert between the 2 in-place.

To help distinguish between these 2 uses of guest_memfd, add a dedicated
helper to handle the private-only uses of guest_memfd, and add some
additional sanity checks with that use-case in mind.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 15 +++++++++++++++
 accel/stubs/kvm-stub.c |  6 ++++++
 include/system/kvm.h   |  1 +
 system/physmem.c       |  6 +++---
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 518baa35b9..15f237de4e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -794,6 +794,11 @@ static int kvm_mem_flags(MemoryRegion *mr)
     }
     if (memory_region_has_guest_memfd_private(mr)) {
         assert(kvm_guest_memfd_supported);
+        /*
+         * memory_region_has_guest_memfd_private() is specifically pertaining to
+         * using guest_memfd to handle private memory use cases.
+         */
+        assert(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
         flags |= KVM_MEM_GUEST_MEMFD;
     }
     return flags;
@@ -4873,3 +4878,13 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 
     return fd;
 }
+
+int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
+{
+    if (!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+        error_setg(errp, "KVM does not support using guest_memfd for private memory");
+        return -1;
+    }
+
+    return kvm_create_guest_memfd(size, 0, errp);
+}
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index acbd0785e0..9fe58efe91 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -145,6 +145,12 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
     return -ENOSYS;
 }
 
+int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
+{
+    error_setg(errp, "KVM is not enabled");
+    return -ENOSYS;
+}
+
 bool kvm_private_memory_attribute_supported(void)
 {
     return false;
diff --git a/include/system/kvm.h b/include/system/kvm.h
index d29624034c..b1e43ddc93 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -548,6 +548,7 @@ void kvm_mark_guest_state_protected(void);
 bool kvm_hwpoisoned_mem(void);
 
 int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
+int kvm_create_guest_memfd_private(uint64_t size, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
 int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
diff --git a/system/physmem.c b/system/physmem.c
index f6dff18bbb..991f7bb815 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2209,7 +2209,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
 
         new_block->guest_memfd_private =
-            kvm_create_guest_memfd(new_block->max_length, 0, errp);
+            kvm_create_guest_memfd_private(new_block->max_length, errp);
         if (new_block->guest_memfd_private < 0) {
             qemu_mutex_unlock_ramlist();
             goto out_free;
@@ -2839,8 +2839,8 @@ int ram_block_rebind(Error **errp)
             if (block->guest_memfd_private >= 0) {
                 close(block->guest_memfd_private);
             }
-            block->guest_memfd_private = kvm_create_guest_memfd(
-                block->max_length, 0, errp);
+            block->guest_memfd_private =
+                kvm_create_guest_memfd_private(block->max_length, errp);
             if (block->guest_memfd_private < 0) {
                 qemu_mutex_unlock_ramlist();
                 return -1;
-- 
2.43.0


