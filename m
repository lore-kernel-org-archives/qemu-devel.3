Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A04C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vCR-0004WX-29; Thu, 24 Sep 2026 21:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vCN-0004RY-Hi
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:58:03 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vCJ-0006Lj-Te
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:58:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUUMP4fdoQNhIWbrE8xVOJtKXALNcQtVRUiLdVrtHLBEy9AzCsijgj97VkfRZ13lZmvBJf8IvMGcEe+at5hTY2dqmAoXaNhyjIpko73prea5g8Mp9Zz2EWIeoatR6hbXanAXPmxIPxmwXlax+/VlC9lF8Q8coNDamJa+a8+jbpD9UIJmQOe8wVYyFsbOQKzFyzDWDFtJlpxL2VHBpivvA5bu4O6/Bo5ZvpBlHmuoB/W3UxzSJMQdr7zfRmvZTAfMZ3Bjpt76I4gPBOfpSWm5UMCf5quqSwgzNjbU9gcQ1N1bqpN/OSuJ8vXKEVpK0EGgvplhkdibLnc6rLAbniQwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxsrZcmZDsQTiSmN44Erkta9rx/Yp2yW8Xpaom/wmOM=;
 b=mLkdGxlfzRAbIyAU+BuA18ga+OirxB+vY23pTkkQG3yKp+SOVkseqe8noG75iSKcEvGP85DTQZHpdjWth+StA/0PUyK6pKyrFd1vPJ1qVOtqp/w1UTw+CnIL+9o2ik4neVfzei4lXZXINH3I5W22b1gZ5akMZBiXk1bOenGgFCCGI2nVWodcf4tu4XQfQAWd+HIUFrXDMTnWuFhGZt0O5o61i6Z5QdGFmX9dvj2EvCn03B+jzWVnZDQu0K/uzuMmeVulJA6BBoBrT5PHi3nvASfW7zY5smr19qh2aHqcviUQMFaR0tVzKJVE+Y3hlOcTdyq3PIYJOG/XghQMKMcLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxsrZcmZDsQTiSmN44Erkta9rx/Yp2yW8Xpaom/wmOM=;
 b=w0QL+Y6wO4SB9WqQhU6Tr1Xz7nUYkWktwq7kiBjrne9LoRTRW/BgL6eA7UFfwef3prF8eh+MFHkeDQv5qp11QwLZzxUquZLBTi2myM6yNs9lAa+R8ikUieobRmxuOPQtNflsxakkwJwBsFeegm1hkxbMrMsMYxRWOQxszoN21KU=
Received: from BY3PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:217::21)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 01:57:54 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::93) by BY3PR04CA0016.outlook.office365.com
 (2603:10b6:a03:217::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 01:57:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 01:57:53 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 20:57:52 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <david@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: [PATCH v6 10/12] hostmem: Support fully shared guest memfd to back a
 VM
Date: Thu, 24 Sep 2026 20:43:16 -0500
Message-ID: <20260925015700.1260501-11-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c36e74-baa6-4ff6-dbcd-08df1aa86980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zF/dFiet0pyGJI2NQEsqIDnvZkd3tedrXDOjzgVq+W+vDONieJnhZTRmQlM7MgrI7ApI62SjkFQTRsORmapDanRTBItu6ArfAwwqu9tPBlflmvwu6Z4QkeK0BGB9v9OmYyS+fYtCXCiF173UIC8MdT7vaqxsrrBL9aY4DN14MLN6uueNvJN97Idm76m/3DGcWchY2FnhVuEJJskl6X5iosuFYeeT1WPTI7XKn+r/lx/a5C2nvOkzMQF0Us81YreTr70Cy5s9HrllKoykwDaub3XawxmzTCpW6nhfORaXriT/LdFy577ejJR2bZWpuYeHZbQvn6+JGGrgQpoJBJSspFGkSoyPALe/wMnD31ELv7uLvFkwQU39O1+pjbDawvfveJ2uFKu06O7xtWRLWjvkHcBR58J8ApS+OdeI/Y1U/idvqTDO0mJj3XBE0y08pZHbmJqNeuscmPemb09CyUf6/S06FtfAcB7M2U2/aFv19bnCYrgi8kh2V9mrIKzsChtqDFfw0kMjgvIu36Hy/lM70JsOYm1odRG/vr66r+9fk30TT6Meb/FzG7bQRZSa/NhoAfkB+T+SgouzJkmm3zHrcLxdybzFmi5dc1wzdoxH40mF8sKnT1o2zdOvA8ssgnIgYqDNhnMQD7+ysxQm7lmuKgZNtbVoF0EPlAl0Qm6tT/e6lJTwgnMf0WI6xrvW2Ddunlwkvnm0Ya4i08HbXLMwaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zrTMdZ7tDGLOgz1+ERG94lzdCqMFVsDVrUdzmpgIcrSf8AtVfo1fCZrAVzm3+oOctRx61qNYeDtRGfDrRYnxNjv9KIxKnc03y1LWRCkIxUZlKYZUTn5R96DooIijUHTJAfwtmAo4wnyd5Zk1dmaaJxz6GEIvzxJ8w5rm9TR/WcvIWCP8t/r1+ZcVJFIvRYnjN1xpZhmVUzNzpVMnfahc7ca7lcGBdDYPpJcSImQrwiqMGFsewvpVeVN1iF82+tyfA57Vi8b/qH5dbhIJufCQGToxzNXcgbXkh0Sjh/BFboTuOWxdOmDHlozKVXMZB9Kv5x40g4iRCEb3f4LJ+IPGzvlq6Ae+nyltXo6MLCCzLl+0JEJKzDQu0OftBpDZa9DchZbVBwZxw8+27QypWIBW71GdnrQLfqwJ8VbDv2H+XgmZELGQFS9bklEoYeYTmmXj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 01:57:53.5535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c36e74-baa6-4ff6-dbcd-08df1aa86980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Michael.Roth@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

  -object memory-backend-memfd,x-guest-memfd=on,share=on

Note that share=on is required with fully shared guest_memfd.

Since guest-memfd is not yet a drop-in replacement for memfd (e.g. lack
of hugepage support), the option is tagged as experimental for now so
that it can be made available for early enablement/testing without
causing any surprises for other users.

PS: there's a trivial touch-up on fd<0 check, because the stub to create
guest-memfd may return negative but not -1.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
[mdr: add accompanying guest-memfd doc, mark as experimental]
Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/hostmem-memfd.c                   | 67 ++++++++++++++++++++--
 docs/system/confidential-guest-support.rst |  2 +
 docs/system/guest-memfd.rst                | 60 +++++++++++++++++++
 docs/system/index.rst                      |  1 +
 qapi/qom.json                              |  7 ++-
 5 files changed, 131 insertions(+), 6 deletions(-)
 create mode 100644 docs/system/guest-memfd.rst

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 7a7855aaab..a164bb659f 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -18,6 +18,9 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "migration/cpr.h"
+#include "system/kvm.h"
+#include <linux/kvm.h>
+#include "qapi/qapi-visit-common.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
@@ -28,6 +31,13 @@ struct HostMemoryBackendMemfd {
     bool hugetlb;
     uint64_t hugetlbsize;
     bool seal;
+    /*
+     * NOTE: this differs from HostMemoryBackend's guest_memfd_private,
+     * which represents an internally private guest-memfd that only backs
+     * private pages.  Instead, this flag marks the memory backend will
+     * 100% use the guest-memfd pages in-place.
+     */
+    OnOffAuto guest_memfd;
 };
 
 static bool
@@ -47,11 +57,31 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         goto have_fd;
     }
 
-    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
-                           m->hugetlb, m->hugetlbsize, m->seal ?
-                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
-                           errp);
-    if (fd == -1) {
+    if (m->guest_memfd == ON_OFF_AUTO_ON) {
+        /*
+         * NOTE: x-guest-memfd ignores seal=on/off because it always
+         * implicitly seals the FD by definition.
+         */
+        if (!backend->share) {
+            error_setg(errp, "x-guest-memfd=on must be used with share=on");
+            return false;
+        } else if (m->hugetlb) {
+            error_setg(errp, "x-guest-memfd=on doesn't support hugetlb=on");
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
@@ -65,6 +95,26 @@ have_fd:
                                           backend->size, ram_flags, fd, 0, errp);
 }
 
+static void
+memfd_backend_get_guest_memfd(Object *o, Visitor *v,
+                              const char *value, void *opaque,
+                              Error **errp)
+{
+    HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(o);
+
+    visit_type_OnOffAuto(v, value, &m->guest_memfd, errp);
+}
+
+static void
+memfd_backend_set_guest_memfd(Object *o, Visitor *v,
+                              const char *value, void *opaque,
+                              Error **errp)
+{
+    HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(o);
+
+    visit_type_OnOffAuto(v, value, &m->guest_memfd, errp);
+}
+
 static bool
 memfd_backend_get_hugetlb(Object *o, Error **errp)
 {
@@ -152,6 +202,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
         object_class_property_set_description(oc, "hugetlbsize",
                                               "Huge pages size (ex: 2M, 1G)");
     }
+
+    object_class_property_add(oc, "x-guest-memfd", "OnOffAuto",
+                              memfd_backend_get_guest_memfd,
+                              memfd_backend_set_guest_memfd, NULL, NULL);
+    object_class_property_set_description(oc, "x-guest-memfd",
+                                          "Use guest memfd");
+
     object_class_property_add_bool(oc, "seal",
                                    memfd_backend_get_seal,
                                    memfd_backend_set_seal);
diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 562a7c3c28..58732d658f 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -1,3 +1,5 @@
+.. _confidential-guest-support:
+
 Confidential Guest Support
 ==========================
 
diff --git a/docs/system/guest-memfd.rst b/docs/system/guest-memfd.rst
new file mode 100644
index 0000000000..f7cef19283
--- /dev/null
+++ b/docs/system/guest-memfd.rst
@@ -0,0 +1,60 @@
+.. _guest-memfd:
+
+guest-memfd support
+===================
+
+Recent kernels allow for the creation of a guest-memfd file
+descriptor, which can be used to back VMs in a similar manner as a
+memfd file descriptor, but is intended specifically for this purpose
+and allows for closer coordination between KVM and the management of
+this memory to enable more advanced/VM-specific use-cases.
+
+Initially this additional functionality centered around providing a
+common/centralized place for managing kernel-side memory handing
+requirements for various Confidential Guest architectures. (For more
+on Confidential Guests, see :ref:`confidential-guest-support`).
+
+guest_memfd has since evolved to become a more general-purpose way to
+allocate/manage guest memory and potentially allow for things like
+providing additional memory isolation within the kernel[1] and support
+for persisting a guest's state across kexec to allow for live-updating
+the host kernel with minimal guest downtime[2].
+
+Usage
+-----
+
+For Confidential Guests, guest-memfd is currently utilized internally
+by QEMU to handle private guest memory, independently of whatever
+memory backend the user has configured for normal/non-private/shared
+guest memory. To avoid doubling memory, QEMU discards memory in
+response to the guest converting GPA ranges between shared/private.
+(e.g. if GPA X is converted from private to shared, the guest-memfd FD
+offset corresponding to GPA x will be truncated since the memory will
+be provided by the memory backend the user configured for shared
+memory, and vice-versa). This is handled automatically/internally for
+Confidential Guests that rely on this handling and is not directly
+exposed by QEMU command-line options.
+
+For non-Confidential guests, guest-memfd can be used in a manner that
+is somewhat interchangeable with a normal memfd. Currently, this is
+handled by using the same memory-backend implementation as memfd, but
+with an additional 'x-guest-memfd=on' option. E.g.::
+
+    qemu ... \
+      -object memory-backend-memfd,id=ID,size=SIZE,share=on,x-guest-memfd=on
+
+Note that the share=on option is required for guest-memfd, since it
+does not support anonymous memory allocations or COW-like semantics.
+
+Also note that there are a couple of limitations in using guest_memfd
+in this way compared to a normal memfd, which is why the option is
+exposed as an experimental for the time being:
+
+ * guest_memfd does not currently support the hugetlb=on option
+ * guest_memfd does not currently support Transparent Huge Pages
+
+References
+----------
+
+- `[1] directmap removal <https://lore.kernel.org/kvm/20260317141031.514-1-kalyazin@amazon.com/>`__
+- `[2] LUO <https://lore.kernel.org/kvm/20260728121138.1103610-1-tarunsahu@google.com/>`__
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 4509630fa4..060850a739 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -44,3 +44,4 @@ or Hypervisor.Framework.
    vm-templating
    sriov
    qemu-colo
+   guest-memfd
diff --git a/qapi/qom.json b/qapi/qom.json
index 5895c97750..602b17ad83 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -780,13 +780,18 @@
 # @seal: if true, create a sealed-file, which will block further
 #     resizing of the memory (default: true)
 #
+# @x-guest-memfd: if 'on', use guest-memfd to back the memory region.
+#     See the "guest-memfd" QEMU documentation for more details.
+#     (default: auto, since: 11.2)
+#
 # Since: 2.12
 ##
 { 'struct': 'MemoryBackendMemfdProperties',
   'base': 'MemoryBackendProperties',
   'data': { '*hugetlb': 'bool',
             '*hugetlbsize': 'size',
-            '*seal': 'bool' },
+            '*seal': 'bool',
+            '*x-guest-memfd': 'OnOffAuto' },
   'if': 'CONFIG_LINUX' }
 
 ##
-- 
2.43.0


