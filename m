Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C55C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFVb-0003KV-J7; Wed, 12 Aug 2026 16:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFVV-0003CA-Gv
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:25:01 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFVT-0007WB-Hi
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:25:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIfW9fuNOL0sTHKVeWjsZ337DdzdBwtFc+QZyeimyk8jxqj5s1rMPI/k0HFHrjRggUKWDdxDehkjuf//qlL60yQlxKwGgEFJyqZoVYrnx5WQF3COl5eL8dSOOjZnmcIszeGS8k8OXGxD9LgCCH9NjAGg4NsgCCdcr5yCkHTqz9ywkCQKAx6xBccSkuJRPcTPBVLobw87jRxXW4ouU3g/OPMeRlPDm1kh4jIqkze/r71KjaRlKONtIR98nIyryi3eBJWoYJpuf3QHO5Qm3SIH5uwwOOxf5ipuNf+fR2uO65UqIK1+KXakFv8UcPGcmNsWSPwSe/dvkfi/LwdGoZ4MZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DG17AqRxESqyT0eS+8U8ePdeGlFNHKiXQpNcxKoNqY=;
 b=Obnj05hWDfs4mUo9ItMs5vymd8zz1may7rvPVqyiFIDoBg33fMlkAiumSFRtMDgXM5nPbfumJY5+gGbIMIRAepikRiYXeV74Z6fkqHhFTcEiFDI0tTnSIpaHwtM/7HVV01Ad3OrDlZ5firrcbM2M8984I+03SHmCD53WuuSOg5/5JelFrupbWNTRlpiEH3vzZLwYi5C+YxclRAwHBsGi+He8DUn+mohSvpm13gwesBk753GKDtikSQDnqsDEH7iRtBlkEcZEW9ZeiLThPFxoZL2nxaNyJYjaTSIoHtWiIpw7K8r2Y6SNLp9Q9v3iUUStXzPcT/6gMUSZRp4P4YlbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DG17AqRxESqyT0eS+8U8ePdeGlFNHKiXQpNcxKoNqY=;
 b=DmGgXaDRcXvg4ioVA3q5zVstuf4hEgpxS2MnHNhEshdYBUT0uPb6kvui/uixInkwLJIMejUSPNe85W21KVuA52xu3FcS6kaI3M9IMeJFytNp0GTB6tauO8LiYsqkaxaFebk0RYNWprXzVvzESUfj1VTZEPSYbS5hpKSIlu90q8I=
Received: from DS7PR03CA0149.namprd03.prod.outlook.com (2603:10b6:5:3b4::34)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 20:24:50 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::f) by DS7PR03CA0149.outlook.office365.com
 (2603:10b6:5:3b4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 20:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:24:50 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:24:47 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 06/12] memory: Rename memory_region_has_guest_memfd() to
 *_private()
Date: Wed, 12 Aug 2026 15:16:44 -0500
Message-ID: <20260812201938.198915-7-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e93684-09dc-4fe5-c61b-08def8afc2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 94HJIJyf/8YRjdI6Gn+3s1KEYv/YbW1GUX8iozEUJnNu/E4k1uYexs2JV6NzN4B16I7/QO8a1bpzMQZq2s+/kPi3yP+QxTicbW1J8TajYoHeDMB5oz5L/Fqh8uI5TYUgfDW0LWG6KHBPloNTjcISuVjnDZcMRLFCdLVMkxQwkY4ZAykbr0IdiL5JNu3wsoJDaeFSHlX++LYG3eVkHV2v7qaimgDGcYEaWen4EuXxIfM+wPZybq6xvQb7cNSoTOjAgnL+oe4tHTwQrAzKwXlk1gnycf+SeMKlQzV5sZfmxSoLPQWaZfFtjeBXzRHo082adm2RsmPCYfJlISWvyBlLgkSTC9XDqEujLteB+U0vk1EpSvP+Gsa2qsGZ7WJgQrvQvQiPwsITLDOHXLD5MhO++9vPFqY0PxMqwdPgzVJxnId400TAwgDNwC1uoqXao9AZw58iFBqH/ODbtjYDokMxataP9E3fUP3TIWo3BSjU7Do6HWvIXtJ+QGnG28b+LUH3H1Xn4crjRrzbqkdIkMcV3QpUvP6iwk7MvIfw294X7olVmc2pcLunFetWNsk5KrhCH7KDhoDQ8H/Zy0Nv9YeRLgZQsdmAtwlu49JNRkM7RIs20imnVB8u49NsZ7c3Et5VH/oXjn1a41EJWfFmZWfCseQVe2aXFzEC5fTOUA0/djDSjhCahD+bzmHp6kIV+fY+6dxSgYrlI03z4dNHkvxXIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B3s5NplI9/hXG7PzOFTC+Sc+OE4hjJQn50YOhXy0ltIqUGUMvfVDz1DecDnNDyEHXOiDlz1XL4FVdFlYtj60pR3JUQnM7Q0bn2lpG4pkI+dmh6ulU1g0XVMsKf6eBDv2VLXbXb5Qd9vAeSeH/UVVhcm6wK3l/wxZMouhbgOQ6OhyLa+L0gQnXzq+nsFO90u4o2stiVfoGBskHYScQaNeWaHAp/QmXYGRc0ZbXOCMGZlJ3g5bqYHrdGYUVSJa2bLUFlTRfYadAcUkSxDTzH/vChZo5cqJpxh5zRhiYJlzodSVNR1kuVzNyQOm3N0HwIvkpbsZdenG8BhqzQIKQJhMi+jjY8LKOUhN2IhwYRXCXQQSAzGZBR16eBkNHXf/0SC5gSZas/36Jo4wa8QKfOSyEe5cdpx//t4VesLBX0+MYuXqrW184/vQRnN97maNnju5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:24:50.5796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e93684-09dc-4fe5-c61b-08def8afc2ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Michael.Roth@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c     | 6 +++---
 include/system/memory.h | 4 ++--
 system/memory.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3afe491242..9e73c84f7c 100644
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
index e960738af5..e3096699ba 100644
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
index 84dcd9954e..db52cfe90e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1841,7 +1841,7 @@ void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
     mr->ram_device_skip_iommu_map = skip;
 }
 
-bool memory_region_has_guest_memfd(const MemoryRegion *mr)
+bool memory_region_has_guest_memfd_private(const MemoryRegion *mr)
 {
     return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
-- 
2.43.0


