Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFB7C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFWG-0004LL-5K; Wed, 12 Aug 2026 16:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFWE-0004Hk-EK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:25:46 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFWC-0007n2-G4
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:25:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA2r7L9stGj8SePdsyPxxFHxcRry6lXiHvUaf/UZaOSTSquR4ZGN8sUDoIYvGu3Orz+WQaEe4o9Cixfpy8jNJITCOKc6a/dqMkY9XaR2kc36HXKvhhfpp2q1g8r3r+ljq/vTvgIKnluCFuldqLm1wph5azmz20q0BPJ8H1juCiGUvsOr9q8ObZIF5M0zjvwv844zkgCytus2LMgm2Kd9kHvFJA4vN3avWXJqAJG0Q9HfasJtjDH5xzC2ZDRvlRh0PSy0+dlD/p/0RtgT971VxGQ1ouhntorBxUsHZ5nsYZi9/iFNOzmmVXOLtC2Z4h2SGoFTAcofn3Yy0vF3cx2ZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qVCjv+lnmyiERYIO4/Bun2hvzYLueGlBb5V0mvUxwk=;
 b=Ty7wki46BC/EDBf0ylyq1CGSK6Acc5Z4d0lHpo6FgnNRdOawFs1gu1bmFADIzWW5fJ8jnRdNPgLsztur0gf7lzLvH6ZTFcPMVz64dVIBIWAn4UQG+sOLq4RyDi7ktV8FLCk4J4DS9S59RpWDbDgtEHBk5pPul1WmXGk+6ESpp3Erfh/xZvsFRKatJz/PKgK30cUCqu1dPqgeM/eywOpz3jZcJi5mAlcE2FOOK1b5j5LWTsyEaH/nYnNMD1XRAp4MZy/2kxEcGmX4TgHjN2uDxTag7FhwZruPUVMT5w27RgU/ENQciOiRSC70C51Np8Nu3EfYztcVIdPON6ExCsYwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qVCjv+lnmyiERYIO4/Bun2hvzYLueGlBb5V0mvUxwk=;
 b=swfP3yJNtb4tGtARUeIVnp0p1SO7mC6+JoVBF02AP7YhMLYiU4UKlkx+v/sHbEmiQPyBrj+oxiTr5enzRF585sEoYvoVIjvIRF884SI+V9gA4fetB0u317uO9BQ6oHN8flCnnVi5qrKwi6Zij22M1K3U3pKTYNMo9eW7VZWQ43w=
Received: from DS7P220CA0081.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::6) by
 DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Wed, 12 Aug 2026 20:25:35 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:259:cafe::55) by DS7P220CA0081.outlook.office365.com
 (2603:10b6:8:259::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 20:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:25:34 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:25:34 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 08/12] hostmem: Support fully shared guest memfd to back a
 VM
Date: Wed, 12 Aug 2026 15:16:46 -0500
Message-ID: <20260812201938.198915-9-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: e081929e-26e3-439b-8677-08def8afdd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: JHhCeZ2OvJ9DpI6c8vjHpz4SFP+I8xPgkS1roVTf3a1pDe8xlH7y3ZMv2sxgeJCNaiuxBVJMbx2DPQ5cHAAmVk+8k2Anr/z4qbwYMdIZMKBSR6wYUt5KUZ7mJUbrTC/ROATlo5lRI3l7oewo4d+lQs9jRxNM5hI1IejpyjOD51CR1U6jdm8Tdru//jiIsZNgcboF66R4NJXQ7eMH+KTcvANH7G2PPvMU6cDar+N/5kL6x5qJ/ojTzHf1kA8QJ6zYUYaVWBTJEGN68SPioBgDv9K2Xq1t+ZSXTh6N5G4NBCwtmR9refZtukpKRC6LVBi8bdf9b8FbaMQNJZMsKUQ1DhuEM3ohincfu6BeqFPJVYNZXzSL4zeS84h5+Mh77oCvkgCUvLg5ZcLkHQ+MNB9/EVamoUW1zDZkf26bPeGJFmHOpqmmYrzMG6vygK7glb3m4NV5C/Rj+Da6yXl6CS0PXlfDLAkt3Zal+SdFv69n4EV3SYWWBdQo6akRjLf/Zos3stqDXWsJxX26n4zGu6Cx/b+XR7YY7k3YPJY0ZRMvx9y6UMr+seupwk4SqBzQ0tCi+XodY4+D+8nGYFqDAMpAqT9xmL+NWJRnHQiaD+i+wjXyA/vFQgJe+sD/rsqFFU5qpErxTGS0O6+WrEoYUtvYmEdHmmxQiAv+27JvnqXJ4iIZrK9Qcn1jmUk4sXNjyz6u//E8RIMVuO4iz/SZqkolhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 63gdNEpF5Un7erMR+9nFB7o4Z1/yYSlsMS2y9MyZ/ROdIXr8xhbJyQ0kpDBmHLUQbnG8LeQXGDGiuSjmQdzVBRbiys70ukawNtJZWo+ncUCJkphXek4SI/fO4gmmDtfZIxN4WEI8Wt5XG9/4aaBFqyU0d01Gd9VlV+2Mauq89E2AWLcwf0TfeA70Vk4WJkySMdKlzsT+PIqlJXtVu8fO+15B3LwFSKZPfpRjQopWw9s2QHogZIAxtQUqUi0SqvlPXFAZsqvVlKwYAG/08wy5Tk1RE2X0Bu1SZO8pIjDi2s5m3y72lyILcO2Bh2qUiiVIzbS4cBmJRkQQ1I490i7m6//Hjyrr4kVkYaKyH99uORro9fV6D9xQGoi9OFOsgYlJN0SCmuXHsTHnf/J3UIq9xVpBrsmm3Bt4bpzTY8qsNsEw3vNF9fFo/+8DYEIt1BE7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:25:34.8869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e081929e-26e3-439b-8677-08def8afdd57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
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

Host backends supports guest-memfd now by detecting whether it's a
confidential VM.  There's no way to choose it yet from the memory level to
use it fully shared.  If we use guest-memfd, it so far always implies we
need two layers of memory backends, while the guest-memfd only provides the
private set of pages.

This patch introduces a way so that QEMU can consume guest memfd as the
only source of memory to back the object (aka, fully shared).

To use the fully shared guest-memfd, one can add a memfd object with:

  -object memory-backend-memfd,guest-memfd=on,share=on

Note that share=on is required with fully shared guest_memfd.

PS: there's a trivial touch-up on fd<0 check, because the stub to create
guest-memfd may return negative but not -1.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/hostmem-memfd.c | 56 ++++++++++++++++++++++++++++++++++++----
 qapi/qom.json            |  6 ++++-
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index ea93f034e4..fbe65b00be 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -18,6 +18,8 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "migration/cpr.h"
+#include "system/kvm.h"
+#include <linux/kvm.h>
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
@@ -28,6 +30,13 @@ struct HostMemoryBackendMemfd {
     bool hugetlb;
     uint64_t hugetlbsize;
     bool seal;
+    /*
+     * NOTE: this differs from HostMemoryBackend's guest_memfd_private,
+     * which represents an internally private guest-memfd that only backs
+     * private pages.  Instead, this flag marks the memory backend will
+     * 100% use the guest-memfd pages in-place.
+     */
+    bool guest_memfd;
 };
 
 static bool
@@ -47,11 +56,29 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         goto have_fd;
     }
 
-    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
-                           m->hugetlb, m->hugetlbsize, m->seal ?
-                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
-                           errp);
-    if (fd == -1) {
+    if (m->guest_memfd) {
+        if (!backend->share) {
+            error_setg(errp, "guest-memfd=on must be used with share=on");
+            return false;
+        } else if (m->seal) {
+            error_setg(errp, "guest-memfd=on must be used with seal=off");
+            return false;
+        } else if (m->hugetlb) {
+            error_setg(errp, "guest-memfd=on must be used with hugetlb=off");
+        }
+
+        fd = kvm_create_guest_memfd(backend->size,
+                                    GUEST_MEMFD_FLAG_MMAP |
+                                    GUEST_MEMFD_FLAG_INIT_SHARED,
+                                    errp);
+    } else {
+        fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
+                               m->hugetlb, m->hugetlbsize, m->seal ?
+                               F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
+                               errp);
+    }
+
+    if (fd < 0) {
         return false;
     }
     cpr_save_fd(name, 0, fd);
@@ -65,6 +92,18 @@ have_fd:
                                           backend->size, ram_flags, fd, 0, errp);
 }
 
+static bool
+memfd_backend_get_guest_memfd(Object *o, Error **errp)
+{
+    return MEMORY_BACKEND_MEMFD(o)->guest_memfd;
+}
+
+static void
+memfd_backend_set_guest_memfd(Object *o, bool value, Error **errp)
+{
+    MEMORY_BACKEND_MEMFD(o)->guest_memfd = value;
+}
+
 static bool
 memfd_backend_get_hugetlb(Object *o, Error **errp)
 {
@@ -152,6 +191,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
         object_class_property_set_description(oc, "hugetlbsize",
                                               "Huge pages size (ex: 2M, 1G)");
     }
+
+    object_class_property_add_bool(oc, "guest-memfd",
+                                   memfd_backend_get_guest_memfd,
+                                   memfd_backend_set_guest_memfd);
+    object_class_property_set_description(oc, "guest-memfd",
+                                          "Use guest memfd");
+
     object_class_property_add_bool(oc, "seal",
                                    memfd_backend_get_seal,
                                    memfd_backend_set_seal);
diff --git a/qapi/qom.json b/qapi/qom.json
index c55776af7d..ee981fc44c 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -771,13 +771,17 @@
 # @seal: if true, create a sealed-file, which will block further
 #     resizing of the memory (default: true)
 #
+# @guest-memfd: if true, use guest-memfd to back the memory region.
+#     (default: false, since: 11.2)
+#
 # Since: 2.12
 ##
 { 'struct': 'MemoryBackendMemfdProperties',
   'base': 'MemoryBackendProperties',
   'data': { '*hugetlb': 'bool',
             '*hugetlbsize': 'size',
-            '*seal': 'bool' },
+            '*seal': 'bool',
+            '*guest-memfd': 'bool' },
   'if': 'CONFIG_LINUX' }
 
 ##
-- 
2.43.0


