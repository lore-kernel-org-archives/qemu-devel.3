Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD8BC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42tE-0006OD-FK; Tue, 08 Sep 2026 16:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42tC-0006MQ-SB
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:57:58 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42tA-0007l4-Qe
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:57:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAa/mY+DmlkoNvRFgDht/8w63xKTpHT2MY/ES3aunXa1kWKrN3JDDqn9AIfkJ6iR9nv23knn6ZhZ8NHnzawSsuWvkTnZr2Bv09VeEqX3skQfjFpNtXzB5sgJpel+Xh/qieyhPhOgoAMeAQQrSYyidY9FROqyiIw65+RXcB9zSCUsE0Fx27fesr+zjUvTOmBnDgYiqBXJxGaMOEqGdPz7kh0SYpGJMIXLY5jDoNcJkVXkhkVMxv2OqyaleCyQOO6TRrakuslGZKLkjgta/RpOEiG6efzjzoZm6Q3INj6M3Gvwf7a87QWshcAn4fbfSQeYwpQQtBLlE3VlwQmxmQUctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVyvj5CYGGAhHAWbxRBjys+8jM+9akL1Gxx/jyPVoss=;
 b=zWc1w05lmhFfF75kBtJ/FXlEcx+k0xZN/Zu5TG2wtF7BXoxflflM1JdBo2/MYDOFSB0HT+6z5OloiR0FOSVX1dkK08WJlFZVPqcuEbSg/HMxdF8ZLV3kvJYrITbAVkRLVLdBe47xuGAQx3GcZcg/eCVZDm57NDh3C6B+MlBQqO7GqY1XPVfAUO+0okxvowEpvCd2SksE8SNG1empuzHwajwHmQcN1qy96JAYJ+mwYgkNWFh9Nh15ByU3SM5xwbcRTlmn+CYPttPAeRhWyAEbNVXwCP2MqSE+OlunKvHT4SHtA3x7oYENcGPt+DtPZUdYkcpGDJRWWdl6lLQH2d/cVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVyvj5CYGGAhHAWbxRBjys+8jM+9akL1Gxx/jyPVoss=;
 b=YHnupUflfu2ISReEu7KfknTWEXcubD59cPgAs4+u65vZNiJK+6y8UVcL7kGjUKzeVXy2jdZ82SdaBMR2aLq7W2ug4aRFa60q2t14//Z3Z22GFQw+Ir/Hh0Wg59RVebUkg6MoQrqN8AC4N7RXkWllcsyjUlhkCkE8GPb1d8NlRx4=
Received: from DS7P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::17) by
 BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.6; Tue, 8 Sep 2026 20:57:51 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:8:25c:cafe::39) by DS7P221CA0025.outlook.office365.com
 (2603:10b6:8:25c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 20:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:57:49 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:57:48 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 02/19] accel/kvm: Fix kvm_convert_memory() calls crossing
 memory regions
Date: Tue, 8 Sep 2026 15:48:22 -0500
Message-ID: <20260908205236.838281-3-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8e5447-e934-4bac-5eb8-08df0debd7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gy1c6pwo7Oo1UeeLVz2wVQ9NXwhEHdbnMBZy6Roqcr8SHEK75GWQQiGV6BDoukqv+7zYZoyHy2xbuZ4rs6TaLX4M9iRmgKr58ecW/Vw9OM8gPa8k7GLCQWK7VdudnTIsXfAAHiiytdzV3KfGdH7Q1S6GC3TG8zq/lWBCVmyapRllTK5yM6nH7YXc/9O4KU5YQApmDiN+icp4UmIhTi2BHLiBaWbuzGGH+quV2VyCKz7LYGx44nJWHGSgC0nDYiV37CeZzDGyTO1CFOMce16Cwac1wNEHn7UWIKMVDEDwhavORv8v5zwHtTGV7VFvVZXsaXZykU4P13Rb1QHxWy5gbUbrE1ggHp4wR2IupofQO14UZe7H5ojkvSZj9QCFR+QrKLsJl6a3jjds4HksK2uP5vGwo6kyIA6cQVdSC5PBCMFSfUPoOID8dhVMlp3/W7VamaEtOsDNGbWae06kSigC1vZErF+acgGf8B9NNIkFrt4V1NZmQOc3tQhnHSV6MRRPi+Z0roMDANGPmoLJbssb3/OfLmQ2kBqKsR1txA7ALxgTjlz2nJFhmB01ky9LK+2xaYPhvLdL2mLfIg/CbvyESY0hTRmACIFx/dpMbk1ggqYR5KSlHfYovqmN5LC9oSsXBhoCgUfmXQVXmhwvL+e3CpQIm/o8jfIy+8SlUoFZS42ARlu1TfKoJBRHTyJXLenL6gHpKOdPhka+RyeixfEA9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NZHKhuSp/yl+a22epYeJfALy8msgjPxEeuemRT0o3hzGXxYmNLluJuS7s8BhTe1HdihIibQT8Aifj5qA/y8lkDSKKUBu2+1LCwgdvwh2zUuVymeURwX9EWU8ojuQhDGwzYXSVpIWOB7kZ/crZLYxnxiKaivvPOUBFYUeFMJYPFH2BbYvjaEc+vvaqCu/ZzlAHk0dH/7jU634tnHxaRZhfG/BtWhJTfF/BK9E6EEMDwX0AEV95Apx/TjFkD6hnOxEiStjOBS2076vsxESkMZd8cOB2ZZnnuFh7dctiKhLHSeOdsFgi+PQDiIVlnU9a3DatC1G0DAvn1KRnQxG8OZmxegnjzqJMDvGRnPzwye3UfJjNJarcxxJ9kEVq1Gv2tle+8zcKQIWjabX2YSm1nUvMraAZDjApXAZWmkWMpUP8w+kkFLbwIqJ30U9Bgm8SRJW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:57:49.5382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8e5447-e934-4bac-5eb8-08df0debd7a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Michael.Roth@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

From: Ashish Kalra <ashish.kalra@amd.com>

Page conversion calls can span multiple memory regions, potentially
resulting in a conversion failure if the memory range being converted
extends beyond the boundaries of the referenced memory region.

Handle the case of page conversion calls straddling across memory
regions by looping through the subregions and handling conversions and
related work section by section.

Fixes: c15e5684071d ("kvm: handle KVM_EXIT_MEMORY_FAULT")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 94 ++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 31 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0b59ba0d3c..62565a544d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3395,54 +3395,35 @@ static int handle_memory_hole(MemoryRegionSection *section, bool to_private,
     return 0;
 }
 
-int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
 {
-    MemoryRegionSection section;
+    hwaddr start = section->offset_within_address_space;
+    hwaddr size = int128_get64(section->size);
+    MemoryRegion *mr = section->mr;
     ram_addr_t offset;
-    MemoryRegion *mr;
     RAMBlock *rb;
     void *addr;
-    bool skip;
     int ret = -EINVAL;
 
-    trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
-
-    if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
-        !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
-        return ret;
-    }
-
-    if (!size) {
-        return ret;
-    }
-
-    section = memory_region_find(get_system_memory(), start, size);
-    mr = section.mr;
-
-    ret = handle_memory_hole(&section, to_private, &skip);
-    if (ret || skip) {
-        goto out_unref;
-    }
-
     if (to_private) {
         ret = kvm_set_memory_attributes_private(start, size);
     } else {
         ret = kvm_set_memory_attributes_shared(start, size);
     }
     if (ret) {
-        goto out_unref;
+        return ret;
     }
 
-    addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
+    addr = memory_region_get_ram_ptr(mr) + section->offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
     ret = ram_block_attributes_state_change(rb->attributes,
                                             offset, size, to_private);
     if (ret) {
         error_report("Failed to notify the listener the state change of "
-                     "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
-                     start, size, to_private ? "private" : "shared");
-        goto out_unref;
+                     "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s, ret %d",
+                     start, size, to_private ? "private" : "shared", ret);
+        return ret;
     }
 
     if (to_private) {
@@ -3451,15 +3432,66 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
              * shared memory is backed by hugetlb, which is supposed to be
              * pre-allocated and doesn't need to be discarded
              */
-            goto out_unref;
+            return 0;
         }
         ret = ram_block_discard_shared_range(rb, offset, size);
     } else {
         ret = ram_block_discard_guest_memfd_range(rb, offset, size);
     }
 
-out_unref:
-    memory_region_unref(mr);
+    return ret;
+}
+
+int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+{
+    int ret = -EINVAL;
+
+    trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
+
+    if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
+        !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
+        return ret;
+    }
+
+    /*
+     * Page conversions can span multiple memory regions, for example, if two
+     * memory backends are added to support two different NUMA nodes/policies.
+     * Handle the covered sections accordingly.
+     */
+    while (size) {
+        MemoryRegionSection section = memory_region_find(get_system_memory(),
+                                                         start, size);
+        hwaddr section_end;
+        bool skip;
+
+        /*
+         * If there's no region present, then the current hole "section"
+         * consumes the entire remaining range. In that case, update the
+         * relevant indices to terminate the loop after this iteration.
+         */
+        section_end = section.mr
+            ? section.offset_within_address_space + int128_get64(section.size)
+            : start + size;
+        assert(section_end > start);
+        assert(section_end - start <= size);
+
+        ret = handle_memory_hole(&section, to_private, &skip);
+        if (ret || skip) {
+            memory_region_unref(section.mr);
+            break;
+        }
+
+        ret = kvm_convert_section(&section, to_private);
+        memory_region_unref(section.mr);
+
+        if (ret) {
+            break;
+        }
+
+        size -= section_end - start;
+        start = section_end;
+    }
+
     return ret;
 }
 
-- 
2.43.0


