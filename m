Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAECC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3w0x-00088W-52; Tue, 08 Sep 2026 09:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3w0t-000882-I6
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:37:28 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3w0G-0006zV-5I
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:37:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vC8xdCWPFS6QtV1c00GmnsILfWQJ8FfbGP5+txbiS5V4WB8nDWslIiWQ51WjD2rXrxvzTWBqTAtIITaJyTHZHJfc6Qb8Suqcnum8x5mWCuKbmhEKEPnEpbEbVlhvbZCEpRublP+mncgagPN63gD6d/tL3CvhkwrJrrTfd5WuU0QsoQ4X4xKsp6GXhf6LUEYLNocXQn8HeVW4dm+OH1RRfSbNnvN3kwPMdw7qC8Qz2uyIjIs85xeqkiRBJpad2bhUZBS0nw1hEEj9YDUVVxW1V02Ong09BU4OiJBQmDXHHgq1kpAiPpqv83zms4htHEy1u0e8ic1ujqSZUqJ1zsw94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi1R2U0EC9eQn6Bpw2M9hrIFFv8JWZpTwXDx2Je+Jc0=;
 b=Fit+6HqSz4P5Nzf71I2ai3shmjprYVFaxE3Be3VF15Iv5oFcvFR2zBit68zTRxdHJIcbCeMzAj2hhTIentEVu7Z4BN+abBemxjzowR504JWLrgGyoq208JU7YBMvgxvywNpu5j4rz/X7UJebUic88maVP6nzgUuOg8KMa4O9Rg/O4dQIR0lxwH//doq3oI9QU+JpmA4IX/ecfkMtXQrVYgFyG1Xyq4MgUOfeKf9XK85tkBmNfykHFBBGElFbYBxxh6/1IF8Pip8jTIruLHUWs+/TRpLxKyPYYcbyJfnC/awub97Xo6ea3+TXmLgKs2CY5IHMR1V6TWfj7iPzF9MjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi1R2U0EC9eQn6Bpw2M9hrIFFv8JWZpTwXDx2Je+Jc0=;
 b=1GF0/Lxtzyr1Cnt7GEZvLtYyAcEsWpYWba4BDO11lNzV9FE4NWebh2c4uUEUMhX4/Wl2cp4J0045SWVi7XpUSA/A8Wcb2V5TzmtrSbyDH7DKDYBeYROEtG9lNPLMyRhG0crbBSaJJQ/D7a0f0eAk8hRfBwFokeko8oNFg6Cnme4=
Received: from CH0PR04CA0001.namprd04.prod.outlook.com (2603:10b6:610:76::6)
 by CH9PR12MB952423.namprd12.prod.outlook.com (2603:10b6:610:353::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 13:36:36 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::21) by CH0PR04CA0001.outlook.office365.com
 (2603:10b6:610:76::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 13:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:36:35 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:36:35 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 08/12] hostmem: Support fully shared guest memfd to back a
 VM
Date: Tue, 8 Sep 2026 08:30:58 -0500
Message-ID: <20260908133151.836685-9-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|CH9PR12MB952423:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7f7756-e9e4-4232-2ce3-08df0dae340a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|7416014|36860700016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +mZWDDHW70gOKrtGiNk++A63sd7BV1iMFF5kZhw95RFn86hy1j5FMjMChG1t7eABN11S5l5evOyJo6KdwWAHqsONd19M6oZy7JQ4/J7Lx5aQ+r6axfH6piAVFlKsLP8zLumRNrao0pIk4+46MjBUelcl5C8/0Dfff1oA3LnXFCKG+FM/p6NAu0oq8VcylEITsYQjVlpJbrVK3taM2jhIu95pu59AOhcsCW4AtVckAlmvQA2u4X2U381oV6QppLUwyRqBRqKubyMu1ZQfUdT8jKsL4HvWTmCnVoynh2rRlhnA8NwCtnIF9w7m1NmHtxuKeXThoHaoqsP7FXY1P/cSKOglhl0l3eRm4sJ1o70h+J6b9k4nmV9R5tBKCtBIy6fO+NvQhM/LpFKE4CaXYh1FhTVoOsZPgL0izKkv3IXGrf4q2/Cy2/e9S9THWOwMaxEIMIC1tV7juJSRR4dlpZtd/KfZ7WmXJI3Xd7+9tqFBHaJ99ciOwsCcK4RxXdSDGXP3eLCwho0iTm4/T0HFvsMYZbeiZigedyjm63tE8DDdynVuPh56rtbJDSTZCgclYN1jtbgC9jQHZs8r3KfdXA/y+pmFeRYYkR/qedPTGxi2idCH7A0rZyDoYX2gfBOIcEV/QY0J1hOijcoK4Omhpd33/4lmsSbKRGM+YQ42C1cbS/AovL/2ZqCahq6GHz8usdlMYvYBpoAMGGB4WM7yJXy4CQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Tg6wUwko7fmh56oIkuq3cZS03C0bwic7pqouQkDh2nF68l+DG7pZ/TIcqHGca/l6XP4r0aEq+KMuWEDqGV61JgPvaVr+Z/KOhs1H2/9D0NkZPwYN0k6iwWGFQcqUCVAH1lGaA63wf0vT1i+FFIGJfphoPJGp/SEcmX6ahi/+p88nixL42CvVTFCVRaZqPmhcihiEiVePxpKkWgPGxPnRwbAdpgR1zllWgW6YcR/4Wu/HiBQGU0U/4ej32VLWAI/gxKda48UufuJgk4TwzBiBD/XL0lhcGKnaBVAooXxQ8GlfReWQ8EB8pGXbLcnP76ydxHA/CqNJLO01FTwy/nCqop9xDKELhyYHzG7BX+eq26inlUyShKeaEXgwCv+iN5Dz1zebRknXqi2PgHnE4qrrkuTpEeQO8xlMPz1aZENxmK5tetu7DCsHJs/a7feYpqm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:36:35.7968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7f7756-e9e4-4232-2ce3-08df0dae340a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB952423
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=Michael.Roth@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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
 backends/hostmem-memfd.c | 58 ++++++++++++++++++++++++++++++++++++----
 qapi/qom.json            |  6 ++++-
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index ea93f034e4..6576331441 100644
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
@@ -47,11 +56,31 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         goto have_fd;
     }
 
-    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
-                           m->hugetlb, m->hugetlbsize, m->seal ?
-                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
-                           errp);
-    if (fd == -1) {
+    if (m->guest_memfd) {
+        /*
+         * NOTE: guest-memfd ignores seal=on/off because it always
+         * implicitly seals the FD by definition.
+         */
+        if (!backend->share) {
+            error_setg(errp, "guest-memfd=on must be used with share=on");
+            return false;
+        } else if (m->hugetlb) {
+            error_setg(errp, "guest-memfd=on doesn't support hugetlb=on yet");
+            return false;
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
@@ -65,6 +94,18 @@ have_fd:
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
@@ -152,6 +193,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
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
index 4a9b7f9088..909add4299 100644
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


