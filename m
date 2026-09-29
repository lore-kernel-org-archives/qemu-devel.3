Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A98FCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhgt-0000w6-LV; Tue, 29 Sep 2026 19:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhgr-0000ro-I0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:56:53 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhgp-00088u-Rn
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:56:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTcBcLQ0SMCBKJPiUxmpC/N8Gu8hcPYCUZQ6B7fkxhmBC/ISGo/Qe/+nFTufI+g6BvsXD/jSUrNwZQ6zcxEMkWqIceDWPUDeuibZzdKfEQ8goOEwmN2SYrvIfx/NC9Rz/fJ5xWRPx0wPNFd4t1KID1Un+/t6yiiaXBD7stnOPnZ+T1KUb/Q8/15pbWppTzWTFzwvd7gRgnrRIDMc206e0xnNMHqQ9IUQQYgyePq+IMpvE9L4KxTDpLRcBGI4FPD9ieRNW6yU/V55/alqYJqLKlN44JGgmM6I9nnNcFkjvbTWU+J4Xdwf5pIhcox3cWMStTmgsxIRld3AaDlg/lPBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96HlfxzT8m4X5ZW4wYZd5NhRo3u1dSz/B/UcNjv/zT8=;
 b=iHYN3IjLAYqDLmrQ7bFbBTEqOztDz/I6sdrXSO5sVx5wR1RqoHpS7pwm2txm4o9vGuVdjbSpZCYp4+yAbr3YQLFSRGANKGbteMudDZlD9Gh6ubmFL84jzWpkRYGkOIRbfQPPZCBxTTVmdH9vTnfNLcYQb7Iqjzs2np6/PYUh3RZHX4GxLlGCX2KW/ovPKL4NsbhnVnco2NUvQoB+SawstAKxFJsbxSCToexXhqGksFmwvug/k1KrQVQ6BaHmLIg3w/roVUZamRFqT0uJuN0zyYxTGQy8Swog85jQRRLkPcDpo+dRGv9UaUAVLBaLMxzE94UwDDr5hyUZjQlLGXljdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96HlfxzT8m4X5ZW4wYZd5NhRo3u1dSz/B/UcNjv/zT8=;
 b=KSxqQnCUqaEVTB0+67T2ui7SEjvSKM96wxHqnaxdeHxMIhi7CVJ/MWNTE4AGAl5J9Ha+ySsUOGjIrXuj3N1XKTqlEQKdCxSQTxD7hOD4r+RLKXArV3iiGdT2OxtfE/InsTGgGYTMDVgqEe+m6GxPHE19bi6ihALU8G3CfDe0r5w=
Received: from BN1PR12CA0019.namprd12.prod.outlook.com (2603:10b6:408:e1::24)
 by DS2PR12MB432622.namprd12.prod.outlook.com (2603:10b6:8:70b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 23:56:45 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::83) by BN1PR12CA0019.outlook.office365.com
 (2603:10b6:408:e1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 23:56:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:56:45 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:56:44 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v7 06/12] memory: Rename memory_region_has_guest_memfd() to
 *_private()
Date: Tue, 29 Sep 2026 18:50:12 -0500
Message-ID: <20260929235109.1398509-7-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|DS2PR12MB432622:EE_
X-MS-Office365-Filtering-Correlation-Id: e5841868-adc5-4ba9-585d-08df1e855178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aP7Rwq/x59+bXSZSdbKEBlkyKNVByALuYLYHVp8Qdzha1XfkV0ScqBCRGuhdUrewBCeGmxCYKlnES/fzmcjfFIMkzrWMhFq2VJ36fd+lCaIcMCOaR6JoFhkfsKBdV8G8CHyIjFAr+7e7SZoySJ7o0TQPnIPyMw26/u7rbBwa6FGVILvLsdIfbsYKauTU07pkOJDZtBzDswYuyZJ/M7NmW2fzylSVle0rJmChl2Ozf2KQlCFgPSQmQEO1j55D3Syy8CilQ5sGE1ZjAmQ6AF3+Kq0d++epR074xYyVlkxHiSw7M3MiQknqDv/2Q/KVVI3hJbOJddAQj8uu8HeHFu0Pa78KEpRREE5e1Yq3IlzVT+PgmqjZORtgUIBlh8oa/2IPH2bo8u12b9zAC3pXfjbUgMvXa9CFcxowYXEHW7hx1iVWFYQYb6qkbu/B5Yjf0quMpMMtID4VsVwS42+HmylAQfjfrBeZAji8immk8A+TxGc5yPtaR5vSGJV5SfaLcuxoidLZLBk+GYVjV/eqkgaQnOJ/o9Jv7jaieBK1jWGl1rq6/gZXZ4SPHWe81QrV3LS+T7J3Jpinlsp7BRzISweUV45TV0WHYcZ9UcmJ4e1Vpm+CDdxIzNfDB0cjitdnM+nKOHHHEoZtf8I7yj5hM9TwEWkGA1PqE3uQjtXIhbRGupj7S9qKARFNe0hYEdg0gN0v6YO0YoqhkyilqecIG/Ahpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9LYy2tgh7DoGAsoIOWnSBMxnNOaANyEHGG99yY+5rfcCtQsjI6KtWnzgiitLebDj9Au5mS64OoJzLiIed9+OZ0CPWPXG4KnALBExA4k+1k3Y9L0oWGFE1uV0ZxFer06E5ZFL/c2NFsu7ya9TRfxBlmmhw31NZltGXfJ7d88I6g60q76JpnXzxHnfQcwkeUsuocCntZqKSEIQd0oaVZ7dOvYsvGSz8IECvvdWhlpl2XX3pAY+HvsQQaUXWWsLBvdsazXj22MCuC5wVgv6qyrUgDNmnehim9lpsO4hMyI6YIqato3cwmzL5AYBtWdfgLjhJ1qe/LFRUoRlpvl8hcGIVHoRF9U4fGAhSxwfKhcd/wgNmgpcnPiT/1P40LocsTtCx1nelr4KpUZ8bqvdK+bXiOUbDKmyOgJUBWBInJflWzpEPdnNj+fLYI9R3GFo5Qs0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:56:45.5778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5841868-adc5-4ba9-585d-08df1e855178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB432622
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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


