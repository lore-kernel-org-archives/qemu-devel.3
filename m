Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0AECA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhdS-0005F0-Ay; Tue, 29 Sep 2026 19:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhdR-0005Ed-2T
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:53:21 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhdO-0007fj-5Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:53:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpOF7zHoMvpEQ3ztH3101q4sZT4MKEUt1LzDoKvaYLYuQQrz4ziRq8tch/OF/XCWY2xKEIOugwV0dNmeS9V0neXMm1MXs89ZEQeuG6javsNKVLCrnkr5UXS0JT0ByQAW0VsBAjlW6yLI77i9jLXyAU2yH+toEnEjXcyzWDswt9vvirKuCSkZpLIyyOYgFLXwvcvWbydVoZnhYxI/kviZjRgGYK0hL4KZCMyXCC7KsN+x593cIcS0rARQ+KWZa6woaCtgi/RUKsDIe0cJ9V55CxafU+61ZhPjcV+oMsqBB+mh34g0Tk5Hd+o/6WCisomnowd1GrnGI5kkHz+GEnI5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4kdaKObGew8ua62Lt38EVBF5GfExmZn+AzbPJ6q/WA=;
 b=PXdDYZ2fjTYB7Vb9sNTlZxFp28iIRQoD9jkiYL5nygvzbEOxCecamvAyIsiaf9MNk494EcZ5aCLqLSkqIdd3/w/vBKN4qCycZWaIChmrrhN1mlleCOghiDP+Zt2Ifr+WRyFAR6n0euZNkqtnl5EbecewlvrmZ4ATY49+mivpSMfB1VOzGXwUDONS09uaYDoIrv0HsZjLUJYp7i08qvlwBZpe5EWPT8VBCN6Hu/ckBqCtpYl8xfws6w6jnz9ol9C+RYrWAsK3AbKy18IS+MmVp87n0i8t8ZxZCgPCNxzKk/V9vufjEPtQVSniTLRbJpNrrEBb3YCMvhITdr9HWhz1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4kdaKObGew8ua62Lt38EVBF5GfExmZn+AzbPJ6q/WA=;
 b=cXstdoiYqv4/qDpCug/reTl/Ps9qQWhTCYyvL2rK9PBGjVnLeAU2rAmb6CP19+1wv+w7dT7971mNSdyUnoleRUpRaMKxOakty2v4xzToD3YUXoqsXNQf0JSo0YlNsovFlvDifrx1ic28zQqSbDiyGqQwcoYFFRAvMts4WN6R/lw=
Received: from SJ0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:a03:2ef::29)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 23:53:09 +0000
Received: from SJ1PEPF000037A1.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::52) by SJ0PR03CA0204.outlook.office365.com
 (2603:10b6:a03:2ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 23:53:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A1.mail.protection.outlook.com (10.167.244.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:53:09 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:53:08 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: [PATCH v7 10/12] hostmem: Support fully shared guest memfd to back a
 VM
Date: Tue, 29 Sep 2026 18:50:16 -0500
Message-ID: <20260929235109.1398509-11-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A1:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3d3e9e-f68e-42a5-c380-08df1e84d08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|260925021311599003|260925021911599003|260925022911599003|11063799006;
X-Microsoft-Antispam-Message-Info: pD0c5hjRZgIrOg1WGNa+8Yhekq1yG/a1T8DTd/eZBpvKOOovZPl366xhI/o845DPHA8FPKpAPEuybqqff8iScUQnesx7N6h6SCn4ujBd6vaHY9eZ4pb152RfVMqrD8p91XCzidhDx67ePTbtZiwslT9XJGsh6nH104g8x7AqXVQuOoSe7r/oegaXMU3ZjtG8UzkzLwpEzzJaLlrfBejEkwtckDfEJ4Fk7WOFfCSk6HydOjbfmJ/yMIq1ojI6WkpIzJekhD4wM4QgFhxT2EVEKPN0X0581kU8wamJWSQg6kD6D6m7trPECgwFt/7/XlbQe62oWRzWFxyCnOCkHE6iplzhCQPKrTMTlqt/A9q114WZEuB8IKCxpYJ2OnGT9NPC0wKwY71G6g2Oy2/z5BO2N0AZIWj70qP3+CJzLoS99g+6OfZZIpDI6Jq2Nbmn1M8t8PHUlJdnZCUKJUBv0IiuckQQfZ88S1vFpi75v8CP2gM4xST9PCJ1DXz8IeXbxTX8et4d2ArWa0b2jrdgX7CTZanFR9ix/P1Ly4cOgosqGIyAhgCIMGhJyMALoemjbukDYXNgwH1qKS2Nsvq+mPCr3bS58H5YEZ8WS5sSsg99lQFSv7SCbFjwAuGSXCI21ok9LL9iv7KGOaIjqkRqSTC9HCyVe1XBkBlV37djjePTTnnWa247gD03Yy6x3Sgq/R/9TbtQp+RvuQ8MOe3UJhh8jA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(260925021311599003)(260925021911599003)(260925022911599003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u8+y4bwSN5HpT9ddi9E8xWTM0SDbc30KnSrQUnKwSqJeGPBuB6BebV/GalWsx8cGZG2koU4iuF67GYmJesLWFXYsmqIp0HDzEQpL9TFeHCyFBTc+fbalawdRyVvPyVr11Z7//FFJ122hl+HDO7FpWkgXpd2LzaKYV+uajdV6zqsoqK0r3pQ1seWNE4TMr9TmUcxXY/NpN7yF/3c0K9dUHo2hH1Pug7rSNUj75tx5iKXziwyTwRFTsiKCzt/Rtuh5XiJvkBFJ3ByB0Zugy6qwBjtriwqadgt6uS8AudIgeVuontVkslsQfwMlotHP1BoGPq13uEM+ClF7GgB0rBlRMqQLzopeg9nT8ubzKSiRMDpo0dnrRPeQqvuhBFoyBCbfF34A7ceWMTCzoFiWCantXaCO28jm5U1qfrp9aoKdgASzMgakI0kEvgG8wRQ5h7JS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:53:09.1902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3d3e9e-f68e-42a5-c380-08df1e84d08a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Michael.Roth@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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
 qapi/qom.json                              | 15 ++++-
 5 files changed, 139 insertions(+), 6 deletions(-)
 create mode 100644 docs/system/guest-memfd.rst

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 7a7855aaab..666593ff6c 100644
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
+         * NOTE: guest-memfd ignores seal=on/off because it always
+         * implicitly seals the FD by definition.
+         */
+        if (!backend->share) {
+            error_setg(errp, "guest-memfd=on must be used with share=on");
+            return false;
+        } else if (m->hugetlb) {
+            error_setg(errp, "guest-memfd=on doesn't support hugetlb=on");
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
+    object_class_property_add(oc, "guest-memfd", "OnOffAuto",
+                              memfd_backend_get_guest_memfd,
+                              memfd_backend_set_guest_memfd, NULL, NULL);
+    object_class_property_set_description(oc, "guest-memfd",
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
index 0000000000..d62a214a91
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
+with an additional 'guest-memfd=on' option. E.g.::
+
+    qemu ... \
+      -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on
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
index 5895c97750..b61bfdf386 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -780,13 +780,26 @@
 # @seal: if true, create a sealed-file, which will block further
 #     resizing of the memory (default: true)
 #
+# @guest-memfd: if 'on', use guest-memfd to back the memory region.
+#     See the :doc:`/system/guest-memfd` documentation for more
+#     details.  If 'auto', the option will default to 'off'
+#     currently, but in the future it may result in the option being
+#     set to 'on' for QEMU configurations that explicitly require it.
+#     (default: auto, since: 11.2)
+#
+# Features:
+#
+# @unstable: Member @guest-memfd is experimental.
+#
 # Since: 2.12
 ##
 { 'struct': 'MemoryBackendMemfdProperties',
   'base': 'MemoryBackendProperties',
   'data': { '*hugetlb': 'bool',
             '*hugetlbsize': 'size',
-            '*seal': 'bool' },
+            '*seal': 'bool',
+            '*guest-memfd': { 'type': 'OnOffAuto',
+                              'features': [ 'unstable' ] } },
   'if': 'CONFIG_LINUX' }
 
 ##
-- 
2.43.0


