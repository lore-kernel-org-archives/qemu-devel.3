Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA06C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vzj-0005ke-Gh; Tue, 08 Sep 2026 09:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vzh-0005el-KF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:36:13 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vzb-0006bp-BF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:36:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BST/LfFSZwVyLKRQshU0IbuLt+6dUZzHnPCZ1jyhB4q0U8aJX1/BCFz3YIQm9Lx5ROTCk6JoPvp0d0PBhuwVtkRkf5nUWPV3n+I2srp8JdSEDnHh9Z6AO8pNQftyMncVTz98RrMflVSrefQRHcpP0wbO6LcjmjTkLamFCXVlILtlL507Fs6Da8iynWBOK3pl7WKhxfs3RcR5SND4DiunDQL+wOYYyAMpWreCrqLWwQ2lRd6kTA/2/INE8AY7JGDHinu7H0as7P3Z1BlucQKlB5XaJQ2omR5YXwsUMp87Ya5BgVeA7vtMYfhC3nDTYn78/dYKfJ1Cuwq2q8h340yO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cT2sb30k8nndeAiDaPM3+URxGm/8cRpvIUaM5Cz6IWo=;
 b=Mngu/RCRWBRVTLtrAUqi7/XeLgapxI3SvoaieHQk5d5arcRWJ4ayn0GuXU5w18i4AQyCsClx5UzIsGB9uZ76DHZcSt2eMBuLCLfVoWjCojckZYhBJk1uI9NJVVPMNVUkGMB5YcFQGftkfPGaNisuzybOQaU/tL4vAiTtohhg4pNZERAIuLMTABmfCvq/H3CNLmzjLkEqQG4HLiE3WRA+vN22bpJ8iSS2rS7YYAg3fuHvoob8ta++t+9J4fGA6m91zvGVHsHYVlCVTa9vVUc2vCJLidthGJnF99kp579ZBD/M20WfbWHaDCXqNY/1u6sTVV1cvXQvZgZ9w1Dc30vEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cT2sb30k8nndeAiDaPM3+URxGm/8cRpvIUaM5Cz6IWo=;
 b=ESPaJK/yoh+NG/0ib9GyXgUkE+BRz3ZEAqzI0slbiN4RE4jMhV4w2ztTCV+4Z64i7GyxQTgGWtTf/w1vv9tbrYGroG6KdLlaKvn8sMQ7qF+lS9tS2uArWnXCRKly8yY22lmkj9C5oc1TB52/ghqqQb8ndDmXYaBe7JeWEsu9fFw=
Received: from CH2PR15CA0007.namprd15.prod.outlook.com (2603:10b6:610:51::17)
 by CH8PR12MB999204.namprd12.prod.outlook.com (2603:10b6:610:35a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 8 Sep
 2026 13:35:58 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::5c) by CH2PR15CA0007.outlook.office365.com
 (2603:10b6:610:51::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 13:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:35:58 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:35:54 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>
Subject: [PATCH v5 06/12] memory: Rename memory_region_has_guest_memfd() to
 *_private()
Date: Tue, 8 Sep 2026 08:30:56 -0500
Message-ID: <20260908133151.836685-7-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|CH8PR12MB999204:EE_
X-MS-Office365-Filtering-Correlation-Id: 036d5060-3a5e-434c-834c-08df0dae1def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: f6s/vFDRr7Jiwwt7Ks51G2ZUac31tjoNJmXYgKqV/e4KrCAtkQsC8yxrftQ+4zwTQscEMGixot3FLEFB07eYtZTmqBx35U+Y/lyD9DAgwlXCRV1dWG3+nvoHIm3Wy8V8EU3C/eNNvg4LMft0d5TSru4bk6bw+rg5B21zKPjGHoZ+tsL0+7d01Brkqr33E9UacqIyIl1ajfxvAwlS1BlWFPt8VrYkerYE+xo+wTXLO7R5i8FXwWkUvIMIzT58bwkUfZO3hxGxDMEhk5/9mEoBKpeTO0Y3LqczFm/IYvzHOefVsDW9hBUIFatCoq5c+qSebCCSWiAoT614pHcarcUl0KevlbbVz6InYML02EsSdoZB0Y3nnoC4/nUotvTERXaD7VXca9CkupnytgrphngLfl/jKKdtdskDnYs3A5zrFCWri1mfbyqhVSOKEUXvfw9ysaHTPcBKYLcp4c5SiUkFiJzvk8Pz4Wn/QKUHS6xbAZ7OuYd1l3Mx0HwqA3HlFd81tJG/jwn0b7OxpX1apPlsYHGRtPaTSfMLCIEeDm8g+8xjIyXgMTymba7mHK/BGV9fbctgkG0Q6XvEeltjnWMWHd8T9F+KVFPeNa8yOkRsYaLqw0UKFCpPR8VUUXH6aNsnSfGfBlpUzBD9BDaUiBYhlxxmNoD9vlr9nRmi7PCaFT8cxFOOLg9TJZ+Fv2YWpUXf0my184yeMKCEZfYrM+hZXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oux+kjJtwYVcOP873I6khtUxTq4ATLRyWJnreYKitmT3NBkHF2aTJkeGB9H9Aw61OIcVaLG5Sh63/N5tR3IHiM/LmTmOxKMR9mfu/Np2kz45f3JFCs/tL21qh1BmJ9EbTOu2QIpjg1fGtk1+UFV19YuPDX9dBVPvgVcAdimPTvg8co1jnPSRjQO4Kv94zc1KMPvM9GlnGmRTz+1hUHS04bB6/K61Gfj5wecZ93UbjN+kzlgIUq89teb5VROBrOq3rm0GpuOswsHiFqsZR1VRCEPJoA54IbZbH8Os+eejloUgDQg9vxerNQC8tqXNdZbTkzSJ/sLFmR5p75aqMbH7bcGKBs2GjGarNoywubYKj5i84ZwZMKZtXJDLMOdSpwchAzz7cLD8kCUZQzfy0pjlgbTM1lPrcCg2yLUXd4TqZ0VbTdzcLFgWHw3kPIqOwHN/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:35:58.7163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 036d5060-3a5e-434c-834c-08df0dae1def
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999204
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
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c     | 6 +++---
 include/system/memory.h | 4 ++--
 system/memory.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 6f3f619b8c..70605a8d10 100644
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
index e2f0bd6928..b520cca1a0 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1803,7 +1803,7 @@ void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
     mr->ram_device_skip_iommu_map = skip;
 }
 
-bool memory_region_has_guest_memfd(const MemoryRegion *mr)
+bool memory_region_has_guest_memfd_private(const MemoryRegion *mr)
 {
     return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
-- 
2.43.0


