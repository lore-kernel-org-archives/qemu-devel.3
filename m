Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70478C98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vFX-0003S6-WA; Thu, 24 Sep 2026 22:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vFU-0003Ii-2c
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:01:16 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vFS-0006jR-AA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:01:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHBSRLCeyHfX1GqHs/ctL3aVIZEsWB/xyIB+AmphZDsYAcCXq/OWtB8ncBzE35f2rSbLhyf071kw1I2+kjDsZYEf1riwBd4a91QhMIQgBlDyLnPPXmceqlwKy86iCWNk/73ELyMqG2G/aMT9HYYt6nvlfns0Qpp2xUcyyMhrzMXMmyhUYI3gyvB5oxxVb4/5Kvn/Prj40araAwq4UdvUQIHvDbAvG9xNtOhykl68ljBFJoUjZUOvhtPB1LwIe44/dwQY0lm5mUdzWxbcntVmh8zOyhZq5B+sM2nSbB99k4CNhQULgTZ7ffLgSNqLbQDhIndTmRgT3qit5riWQMGn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96HlfxzT8m4X5ZW4wYZd5NhRo3u1dSz/B/UcNjv/zT8=;
 b=sZM2RA4F311xL46FkNk4PakWNdIWC8FjoK92+F9XQ1k3iPA0+uk21hocQ2kAgcVJmobCVaCiZCyKHo3saBWb80GQBQkxaEr+Ew4GZQIM2mIvQ3IBxratqXcqFFaUdF8G75wyj1WlpxwAlI2YwWflJSBLdVrvf2lHeiROmWaQ5Bd+tOQDp9Aqn9EmHwQFk/hnP20P3lZnvC2Jv8Gnt1JA4UjbEk6wogY67ofZrFIdUIhY1kcAWuHTxzMa+S8cLOL1nwl5Q3hffJgGW++nQRlQqkMNQAGFBYTM2PsZGlm3OPvoKN6yJVFW8hpZ1d/RlKboBGntntBBYYpY+zHUTICjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96HlfxzT8m4X5ZW4wYZd5NhRo3u1dSz/B/UcNjv/zT8=;
 b=FInqFTdbguFmgc7r2BR30rvHroGFsQsHk/wL9ZGPOmf2KUlcKmC3TJwJuHnW2mGUridxooEOWAPp/UXycxX97ELiMj1VKfl3xDwbxjFdSJ+zG3ALik1oEgWxTveT+0w20PB2BMi/s4FLfnZjvVI3osp+5Xi/cTBMX0Jk4tbcBN8=
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by DSVPR12MB999150.namprd12.prod.outlook.com (2603:10b6:8:388::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 02:01:11 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::16) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.15 via Frontend Transport; Fri,
 25 Sep 2026 02:01:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 02:01:10 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 21:01:09 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <david@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>
Subject: [PATCH v6 06/12] memory: Rename memory_region_has_guest_memfd() to
 *_private()
Date: Thu, 24 Sep 2026 20:43:12 -0500
Message-ID: <20260925015700.1260501-7-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DSVPR12MB999150:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d4e1f4-a134-455e-6576-08df1aa8debb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: vkMkYv2WcDv+QC330HE0rXu3BwJ37k32tOLJhc8GoLXruaFQ2KP7RKCxHKxqx5dRp62WTAzdRXoVAS/4FIIFXtfR9Pn952i3TZp7a/MQ+jaPTFy2LZYfTKlNN5w4ug0moVglZwg5REIp38t6bhodobNUL/V+hT3b3uNbF8pc64AEDIhoB+DLvBXuNh1ULCcPnL3p96Ge1giNJxGTxM0P3L4kWT51IyG/iiM+EXvtARno46jhTFGBTUnN/ywyeyWkTDnlXfzhMMX5yNI4iKNLy6z3jiLzfyIjex1N0wO91Zn9T1QyL/Me9f0YBdOSOSkJsYWNqxm/V3VDoI8dWet5VVWXxseC4BRumOJh5GPZy7ClYTyGlGlgkMbgXCe3Yn9rfnnbdAt3DEtDjSMnmDYQyzD3N/5ez/BBKk7cjo9TLBELDK187vJPMAqXo0heNt6KTqxYCVAEEcj3OeY095Ao1nXT79Uqo0hM7+fQ0oPv7fjoDO1K6jWNAKWtVUNzkdWGUtrXtxd4dkXdk44fT/4erTML4N+cwjtkFPxAxOk6hevYy9mNigGVh98rfbD+eosyOXpJqa25EcXiJuIFC/g7bD95TR2y9Wf2SSFh3+ad5j5iYPtm2WehLIL6HT3YgpWjuBQjFaSs+F4P5cS9B+eHNPU/W0LE+qmXRxjuxsfu/FNOC4rbnZ9s0803/49MS8x1xX6b9T67Cy5DQDFK3S7K3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1cRD785DOSPvJMpV6l6F5lbL7mnYwj8rc16NDyUua9lh+V9WnIDljjoziZYF6ygF63xDbbdwwzcAUoTUUFSIKw1W5aIwvcYcdQmgRjBocFqxym8JrnuOQ5yxYkMsCWwUONBkhVRterg8M/Z5TaObxP9zgiKkxbubTukxQZYTCtdY4JTo6vS72wn6atNoWnpzqaNiLcMvEa7hbTFHHhSFH1E3sSl6qcpTl/oZII1iKc9ZRlTp4lEu3WKvdpwJ0Q7GeM1BOaZSv4iqfrg1qOMix2lVPOq3AjUfpbeSevMUnuX+QtG5/8TJgXLR5dowSODC6itWwk7BqJyS/pEavciwApjfyp2B6gQeafNpacKVbeoPP3bXCRmk78KXtfm8WaBDq6AWdsp+igWVgxKJ5/S2ABbHDbxsWKLAeSsIOQtYj/krCZwrRbj0UljDQalmvRa+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 02:01:10.2823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d4e1f4-a134-455e-6576-08df1aa8debb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999150
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Michael.Roth@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Rename the function with "_private" suffix, to show that it returns true
only if it has an internal guest-memfd to back private pages (rather than
fully shared guest-memfd).

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c     | 6 +++---
 include/system/memory.h | 4 ++--
 system/memory.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a29b1d7a3c..db52bb9ffb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -792,7 +792,7 @@ static int kvm_mem_flags(MemoryRegion *mr)
     if (readonly && kvm_readonly_mem_allowed) {
         flags |= KVM_MEM_READONLY;
     }
-    if (memory_region_has_guest_memfd(mr)) {
+    if (memory_region_has_guest_memfd_private(mr)) {
         assert(kvm_guest_memfd_supported);
         flags |= KVM_MEM_GUEST_MEMFD;
     }
@@ -1741,7 +1741,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
 
-        if (memory_region_has_guest_memfd(mr)) {
+        if (memory_region_has_guest_memfd_private(mr)) {
             err = kvm_set_memory_attributes_private(start_addr, slot_size);
             if (err) {
                 error_report("%s: failed to set memory attribute private: %s",
@@ -3372,7 +3372,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         return ret;
     }
 
-    if (!memory_region_has_guest_memfd(mr)) {
+    if (!memory_region_has_guest_memfd_private(mr)) {
         /*
          * Because vMMIO region must be shared, guest TD may convert vMMIO
          * region to shared explicitly.  Don't complain such case.  See
diff --git a/include/system/memory.h b/include/system/memory.h
index 932072c631..96ab920e7d 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1507,7 +1507,7 @@ bool memory_region_skip_iommu_map(const MemoryRegion *mr);
 void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip);
 
 /**
- * memory_region_has_guest_memfd: check whether a memory region has
+ * memory_region_has_guest_memfd_private: check whether a memory region has
  *     guest_memfd_private associated
  *
  * Returns %true if a memory region's ram_block has valid guest_memfd_private
@@ -1515,7 +1515,7 @@ void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip);
  *
  * @mr: the memory region being queried
  */
-bool memory_region_has_guest_memfd(const MemoryRegion *mr);
+bool memory_region_has_guest_memfd_private(const MemoryRegion *mr);
 
 /**
  * memory_region_get_iommu: check whether a memory region is an iommu
diff --git a/system/memory.c b/system/memory.c
index 96e42beb2e..fa0a2cf563 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1778,7 +1778,7 @@ void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
     mr->ram_device_skip_iommu_map = skip;
 }
 
-bool memory_region_has_guest_memfd(const MemoryRegion *mr)
+bool memory_region_has_guest_memfd_private(const MemoryRegion *mr)
 {
     return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
-- 
2.43.0


