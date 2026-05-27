Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253CDCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMoz-0007Pp-Cq; Wed, 27 May 2026 18:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSMox-0007OX-4k
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:33:51 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSMov-0000By-36
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:33:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxjiVqNB3Fq074lMehk35FguJFosWbWanCH405YbkVvSwnw3JGQDj7XWmeXd/eYBybqPyb8+zKhCpDt1nAzjk10kUjjOVL8MNpKl5WOWZkMnCFlKehl7x4NZVdVDiolFmzL2P9qg82xYUKAeskx7oQh1dPFNGBlaYQAf/gfgCscpSygrC7+uDkYJSotyWek5ojf/8NpCtO91qIHAl3tJTOTCwE/yU301NkR6CQYxaTtd6+SYDx7Myv10vGvpyzW8x44uSFX9EHIbr4gQRv1zi10ycLE42Ss+qV+LTaRxrxtsu9P/7xwSi4N57nY0s0ay+u3Uo16kraLMH0msWFS8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPDQcaDDcFtgLoG0zoHjVcSmbXW9MRa9/4MFQJObqbA=;
 b=hqX2LmQ94MNp/oBgnwBHkbyFABIvzsMKdouEamnKsbUQUidGJkOLQKsSe9XZRm2u+XKp2Nhwa0mDD4TsFXk1keZ/KFjbEVVY0gPE6PWhaAP2Q6nCb2mNZqtY/EWFk4GfqTWHKw1Nj2s2Qv/A8sSHtqqhaQRiQmF0jA43CzTICyWRD9bJs2g1zLEr5EmdPWjsrV2h6lCvgyMS3C+XphRXoRKizmGc384Tv2hG4gU0EBr2JtVRKj5tig7Sh9cPYpQDuqaJ69xyvEY0RaPDmiwvN0dlqFv4oBHHE4o0gd4IIzy1ZqQ9Vl66D3HEddtlqJkfOUVr1lUPCMNFKOPTf4Q+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPDQcaDDcFtgLoG0zoHjVcSmbXW9MRa9/4MFQJObqbA=;
 b=e9N2GVFK6RHEdcmh662wqpCpAQt3z1OaG/jlxqTEa1GgcwqWovIe5rGDboq8M/4j0baXBRz6iFF9givTqzxZmnw8LTpOOhhuTfy1qvOEjnba+XIB7UDco/F1gwKzxlT1t398Hl2O5U0PUVX/O5BkzIk5bVfDLh0x1a5pi0ZJYJ4=
Received: from BY3PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:217::16)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:33:42 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::87) by BY3PR04CA0011.outlook.office365.com
 (2603:10b6:a03:217::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 22:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 22:33:41 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 17:33:41 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>
Subject: [PATCH v1 2/4] accel/kvm: Fix kvm_convert_memory() calls crossing
 memory regions
Date: Wed, 27 May 2026 17:28:25 -0500
Message-ID: <20260527223036.4614-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527223036.4614-1-michael.roth@amd.com>
References: <20260527223036.4614-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: e85a7ee2-f5e5-4412-f9fc-08debc400149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZpqEQ0kT4EIcCfLSSCpzcvl36kCnrETxpUnEgeXml9GR289hpZ1cX+XGZpEuE1s5+bQVoLq7xyeOJoEALnO6XlRE8M93XHD+gvLnYI0T58SkNTUxr4fl4wH4mpmFF4cRZOZY/CRYxU5SiF1ofk7aBNvBI/F0w3qonmcRgnXa2OQn/rCJsoKJLfPx/oZ9NXfDFVL4Y+u3ArkgC0iOUqjk+m4kzfCn1lJIxybf1FEUrdKMjGIpIvfmd0kn41SaTxyONfSV3efUsmqAWaMW4830T/vC6EQc/MVxOiT7/n2n5d6nS5zBCJrX+A6qk2+yqAVaAVyTkiAl7XXKawZ+HW9KLMqk3D7Z0rgUX0KnAd3aqyKkU8Bxb7aMFSdIW446fkXo/GGGI8B0UIqm2AajweWLNYY0iA6uUyAxOlUJwJPnuFxNtX7p7RzcX/3H2s7PjncUVmiDtDn2XdZ0Tjwo8ohPHMy8tEha5gyOL22Uw9hBfiwmCBoinHm+z0G1mXJcyleyg+t4P3vj5nHbhrIMPgfbIqFSyKNbpMPkyPp8jcDW61Wir5xg9rAYd/C/7x7ib/kJ8nZ6dzTN+gtiYM+oNaQC+pkvDN3aCJnBqtSwFs/56IE/2FCyRqHa9FRETPTYOIyH8ApXwX8F+M21Io26PaTiRxJ5MGP5JASWez/W0jFRIkRWVfx+0yLy6Z4yFdAvQ+B7xdcYiaZLOkqxLY+iybXfWvSPa1miOb6XjdyP7TWgB1w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iDGts0vaYRwkSj25evIJsIDYeAvUB1PJnP/snveHGhNru24vObMfKrEhyw0vI0Z/vXW8TRMWgbKWzq6Fh8DOk9NF0GFQta06rbh53zdJ2QayT4QSB7vccpz5VJeef692eIiFh6fLlcp1k7eH6BdGGocW4zrekm3ccC0MaxqeAAFW+9V4fjrzaENRmjtfIGSTsXCF4fCgiC7w2opidhXCeYAp3KL1xfo+qF+SfjSYXKJZNSHJfvEgOLBgNJ1OUaJG9VNSFFcgj5v10NcnR8JGU/fey5XEWAJUQeVIynsYW+SMBDPxnt5udKQxRgzAy20gk+yU3pYg94RI4BvA/QsFZaPqf2ZSvfLciz+ntC3bUsYiEfRQo1x6XfzNUcy3ovKm0NfbpbdIXDvkMo7/7aFV8mR+grgm6cP1EStFqhIM8mKwzQiUizTIFBaPSx+Sk7Ea
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:33:41.7472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85a7ee2-f5e5-4412-f9fc-08debc400149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
index 24117b4634..21e8404e61 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3400,54 +3400,35 @@ static int handle_memory_hole(MemoryRegionSection *section, bool to_private,
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
@@ -3456,15 +3437,66 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
              * shared memory is backed by hugetlb, which is supposed to be
              * pre-allocated and doesn't need to be discarded
              */
-            goto out_unref;
+            return 0;
         }
         ret = ram_block_discard_range(rb, offset, size);
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


