Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CA7C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrVg-0002e1-OV; Wed, 20 Mar 2024 04:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrVf-0002dj-AD
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:41:19 -0400
Received: from mail-dm3nam02on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2405::600]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrVc-0007PD-KN
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7dBKi3CbtRM711N57e4pHOkdwH6UL1JQisLWZNyg8AYP+smlkPfajueElirGKaJs7AzznmAQJ/INFSy+1W8sy4AcVS5T39JU/ADArfPEetH2eE3pKm78sQELvX4n335sBgiVZygQhpmnSiHRDcIEntmHy3nFowf6r3/IuFmGFle1BdlKyprro3dFce7jkBcm1i2Fy/ILanPqws6/LV6QWZPP7d8EP/b+Pkq71YQrdprEAyU7XQpii971n9TYbRAHD+Vq5lrsHP2UhtRrotAogkC2IQ1uFYzA+p1rr/dSMKNQ2mlwR3ZVL4iS1nVlAJ60mELBsn9C7yG8GMv1XJE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCoeIDeRPyiwXA+J+KvIQp99uEJ+gmdpzx7A7PhKWWI=;
 b=Co0Ig1c7kqQqYyknFtLhiK+i2KHo0+1Q2IVYFMQgGjJhbQsFq4tgqs1VlDgbsAGnY71Ru9RNfIZRm2a9aQ1YEndbn8UIYdFhDIyxH+KWm6boagNrMkW3hnR+7lGh682+DIWcWuKgA1fwn3NZ2YlEPKHWC0fuOHtdYE6geEDbrXxObh7hIuPJ2nYifflGk8fNQwvrzHzGUryv7x5vEcP+H9D4PXNEyhaRJL2OmX1D1DMy3Uxq24XGE0hf+aPVjkRO+cGxEVoQ0VvDW9FouC8gGXSqsvuHMfMHlmI1q3NGu7KT1c3PvvKf5vaA0hOXv0lGKfKemBQwOVQ6NuHRgHHWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCoeIDeRPyiwXA+J+KvIQp99uEJ+gmdpzx7A7PhKWWI=;
 b=Is9h6fj3M9gr9SB0hufmu67GOWvJhE5VseFJgUkcIoHpmkho9BFF3gRiSzMVl7wLzG1IJNMnCXG9/memQmZxHssBUmY5RjRnMIFZ0Umy3n3hQV+xrG0fsEw5n1mMYo4AnPk/2eVu4beTpR3+jBa3BijxtZrKqQHMeNXKpgLY/70=
Received: from SN4PR0501CA0118.namprd05.prod.outlook.com
 (2603:10b6:803:42::35) by DM4PR12MB5748.namprd12.prod.outlook.com
 (2603:10b6:8:5f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 08:41:08 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::5a) by SN4PR0501CA0118.outlook.office365.com
 (2603:10b6:803:42::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 08:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:41:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:41:07 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>
Subject: [PATCH v3 09/49] kvm: Enable KVM_SET_USER_MEMORY_REGION2 for memslot
Date: Wed, 20 Mar 2024 03:39:05 -0500
Message-ID: <20240320083945.991426-10-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aea8d22-b182-4d35-52dd-08dc48b97cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUw4nXhYM/Xg6ew5jJg+ZgtGgLKieRBxVPv5nHaAXLqTkXo/AKWeif5WABC7k869UT45bxmqXeNLiu1f4cy79yjKc4T8kcEjrIWlrE7o1RES2zUGywwlF64+c5RSsOXy7FePv7vfXU7twUjjwD5+paVWnsMLAcMW+6lFjrEkiFhXY6xqDh5bVV0BDML9i3dcP70aZynSM6ST/Olr3d2+8G1Z/Snjs0sh/XU2TQxzvYVbrD5iVhqX24CSGji/p13RcAnhtpPs04pw/dL2YA/K/KFNMU/dHSlnuCTeNSHFR9h256pADR3+yqgH9zzhlbLtxQs8MAQSZUDrOQDW+/eX20fA/rATIqsPluTXnysP1ftRBSiKpGTtU93immpBx/zRa8W0T0G2zqkKAxuSAbITcQ+/BC5C/AlQn2/fRil9ggzkfdarbH2QqdpZxRzqDktukfVfvmVuIuR1ttw44ppWPajJOfgRmH4Q6L2P4zCRafKz5Hv6d4fMzJBzTYs/2qjpH6M4jYwPcIZdL3bwLV0MtGY6PHVzxJ88TaJ+/r9RkOP2C+sACIMOQHYEjmdLpaxFp9VUsZfve8v9ecyjfeWTXsxYgXrsVV+f6QxsGuY9mVYE1mI6AId7jm6AyUSH9Y8cfojTGj0aU+S9dR3uGY23xGtn/23eyMHvZ4B44oYzUm55yz2M2xNykpfS6+cyMn2fRzkjcuNAATck6t1S/y4gE7lmkr6bSoiuUB6OLyvEJ/lGj+ut9wXvyOezPEZXnVhg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:41:08.2203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aea8d22-b182-4d35-52dd-08dc48b97cfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
Received-SPF: permerror client-ip=2a01:111:f403:2405::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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

From: Chao Peng <chao.p.peng@linux.intel.com>

Switch to KVM_SET_USER_MEMORY_REGION2 when supported by KVM.

With KVM_SET_USER_MEMORY_REGION2, QEMU can set up memory region that
backend'ed both by hva-based shared memory and guest memfd based private
memory.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v4:
- update KVM_MEM_PRIVATE to KVM_MEM_GUEST_MEMFD; (Isaku)
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c      | 56 ++++++++++++++++++++++++++++++++++------
 accel/kvm/trace-events   |  2 +-
 include/sysemu/kvm_int.h |  2 ++
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d2856dd736..e83429b31e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -283,35 +283,69 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
 static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
 {
     KVMState *s = kvm_state;
-    struct kvm_userspace_memory_region mem;
+    struct kvm_userspace_memory_region2 mem;
+    static int cap_user_memory2 = -1;
     int ret;
 
+    if (cap_user_memory2 == -1) {
+        cap_user_memory2 = kvm_check_extension(s, KVM_CAP_USER_MEMORY2);
+    }
+
+    if (!cap_user_memory2 && slot->guest_memfd >= 0) {
+        error_report("%s, KVM doesn't support KVM_CAP_USER_MEMORY2,"
+                     " which is required by guest memfd!", __func__);
+        exit(1);
+    }
+
     mem.slot = slot->slot | (kml->as_id << 16);
     mem.guest_phys_addr = slot->start_addr;
     mem.userspace_addr = (unsigned long)slot->ram;
     mem.flags = slot->flags;
+    mem.guest_memfd = slot->guest_memfd;
+    mem.guest_memfd_offset = slot->guest_memfd_offset;
 
     if (slot->memory_size && !new && (mem.flags ^ slot->old_flags) & KVM_MEM_READONLY) {
         /* Set the slot size to 0 before setting the slot to the desired
          * value. This is needed based on KVM commit 75d61fbc. */
         mem.memory_size = 0;
-        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+
+        if (cap_user_memory2) {
+            ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
+        } else {
+            ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+        }
         if (ret < 0) {
             goto err;
         }
     }
     mem.memory_size = slot->memory_size;
-    ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+    if (cap_user_memory2) {
+        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
+    } else {
+        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+    }
     slot->old_flags = mem.flags;
 err:
     trace_kvm_set_user_memory(mem.slot >> 16, (uint16_t)mem.slot, mem.flags,
                               mem.guest_phys_addr, mem.memory_size,
-                              mem.userspace_addr, ret);
+                              mem.userspace_addr, mem.guest_memfd,
+                              mem.guest_memfd_offset, ret);
     if (ret < 0) {
-        error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
-                     " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
-                     __func__, mem.slot, slot->start_addr,
-                     (uint64_t)mem.memory_size, strerror(errno));
+        if (cap_user_memory2) {
+                error_report("%s: KVM_SET_USER_MEMORY_REGION2 failed, slot=%d,"
+                        " start=0x%" PRIx64 ", size=0x%" PRIx64 ","
+                        " flags=0x%" PRIx32 ", guest_memfd=%" PRId32 ","
+                        " guest_memfd_offset=0x%" PRIx64 ": %s",
+                        __func__, mem.slot, slot->start_addr,
+                        (uint64_t)mem.memory_size, mem.flags,
+                        mem.guest_memfd, (uint64_t)mem.guest_memfd_offset,
+                        strerror(errno));
+        } else {
+                error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
+                            " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
+                            __func__, mem.slot, slot->start_addr,
+                            (uint64_t)mem.memory_size, strerror(errno));
+        }
     }
     return ret;
 }
@@ -466,6 +500,9 @@ static int kvm_mem_flags(MemoryRegion *mr)
     if (readonly && kvm_readonly_mem_allowed) {
         flags |= KVM_MEM_READONLY;
     }
+    if (memory_region_has_guest_memfd(mr)) {
+        flags |= KVM_MEM_GUEST_MEMFD;
+    }
     return flags;
 }
 
@@ -1363,6 +1400,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram_start_offset = ram_start_offset;
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
+        mem->guest_memfd = mr->ram_block->guest_memfd;
+        mem->guest_memfd_offset = (uint8_t*)ram - mr->ram_block->host;
+
         kvm_slot_init_dirty_bitmap(mem);
         err = kvm_set_user_memory_region(kml, mem, true);
         if (err) {
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 9f599abc17..e8c52cb9e7 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -15,7 +15,7 @@ kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 kvm_irqchip_release_virq(int virq) "virq %d"
 kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%" PRIx64 " val=0x%x assign: %d size: %d match: %d"
 kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%x val=0x%x assign: %d size: %d match: %d"
-kvm_set_user_memory(uint16_t as, uint16_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "AddrSpace#%d Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
+kvm_set_user_memory(uint16_t as, uint16_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, uint32_t fd, uint64_t fd_offset, int ret) "AddrSpace#%d Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " guest_memfd=%d" " guest_memfd_offset=0x%" PRIx64 " ret=%d"
 kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#%"PRId32" start 0x%"PRIx64" size 0x%"PRIx32
 kvm_resample_fd_notify(int gsi) "gsi %d"
 kvm_dirty_ring_full(int id) "vcpu %d"
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 3496be7997..a5a3fee411 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -30,6 +30,8 @@ typedef struct KVMSlot
     int as_id;
     /* Cache of the offset in ram address space */
     ram_addr_t ram_start_offset;
+    int guest_memfd;
+    hwaddr guest_memfd_offset;
 } KVMSlot;
 
 typedef struct KVMMemoryUpdate {
-- 
2.25.1


