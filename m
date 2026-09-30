Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0405BCA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0W-0002YN-Ni; Wed, 30 Sep 2026 11:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0T-0002Ue-Il
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0R-0000jZ-BF
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAkMCzIG6pkTbKrpmXD51Qfgv+c+dPd+iK7uwg/2tGk=;
 b=J72iep1SZ5YzNTkpTQCGvONHecaCPnZmwpgK+u00krvAcC2LD6PIPxAzt50dZdqOAaGuZA
 j39o3Nt0O5e7iToGufTBdPEAE3Gf4ZU/KAlSDBV0K2W/+/z4ulGCVUjZWT70qOBMxPxEnY
 KacCSebMFASzvaOYnbm76Tpa8KhmzGw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-74tbDB3LMQiXHI4X-j35xg-1; Wed, 30 Sep 2026 11:14:01 -0400
X-MC-Unique: 74tbDB3LMQiXHI4X-j35xg-1
X-Mimecast-MFC-AGG-ID: 74tbDB3LMQiXHI4X-j35xg_1790781240
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8a9977a4261so72038467b3.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781240; x=1791386040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OAkMCzIG6pkTbKrpmXD51Qfgv+c+dPd+iK7uwg/2tGk=;
 b=Hqjv0S+p2Jl5dXJGn6LEXMeYF0hZr5huSKSofUVjkD9qZc7YtYhrCQeEMoLoiERNvC
 KXbzpuPtcOd6IsLTJFqUhdHTxInM8A1XkjdkgrHG+R+lTwt3Ex5kix6lzmH8Y+mzlD70
 mzqWTgnS67IV1xGBRJ4YvARUescNyht+kd2AMXsU1zfrQ/9UoPZG123L35gsoejCL3SJ
 WS3bsRTCoXqZmk4gVwtkmXwjBEJ3xoK01jAB/iQpBIqYsiVXujVXmrNXGZz9wW28tsCW
 2FMQjiiyTcRcTakuCs2XcKngLl6sMu3ngBWUjpsErUnXCMp6YCMnyTA0kV99oWnz7EML
 IYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781240; x=1791386040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OAkMCzIG6pkTbKrpmXD51Qfgv+c+dPd+iK7uwg/2tGk=;
 b=A1SYkJeN/qeHsbVpr9dMcimXjO68BUywr5yYYvIg+E9I+8Rf9zIVczmvsOKh5EaQPN
 pMboXawoAaCJa+bIwnQ44JNyzKaqoJIksSWllPacmJ4GIhXfqftsQHB307Q2pZf8YSrb
 wukJ+NohS/9bHdzP0yEPf74RVHfjOGd7Gv6DOsGEcdM/pvzCaOj8VpVB3i7YG1U+6F2G
 UIYiT1/iP30hbS5PJIQjlCf8m83SAlh17D8C2ny1615XPgGVeHao1kx+5Tnukf5Wn0R7
 IYIbA0pv7+m0XzQPXLNln9TA1FDRQeHPVNUrKG/lG6SoHy0vZLKhWwV2lCh7PEIq8Uj8
 DO6A==
X-Gm-Message-State: AFq9FYIg4rga2gsd2dIeHPTbFFcdMG0BqzSd6LkL3FPL3CcK1aDSCbid
 pxWci9CeI0XrxtO0GBDKzF+vZ9IAbqHaO2Bc0uLaaRSrc3DzMaIzeu1PvgaeYQNSDhN1k+k4ef1
 /p8H34R6LTZrqr93oafVyhQSPjAGhenP8aHzhvR394qhY+vSu5QsgihG+C9heee086y9rgvnLot
 A/ScKIPN9XhpxwyyHq6IBTMZ2t5OqqKgaUigOxDXG5
X-Gm-Gg: AYBFou3+cHbidGkcY0A1ggzgsKLQuJXHLy0dzt7ZNyvwtr6gFvswMmUswvVt54yrpT/
 jFq0ssjnO0eE501puJbw43tR7Ge2YWJ5YTVTamvb82KM1AEKslry39wOssOyuRYA0zx2Mcme4Zf
 eqlRLYygF08Y+jurtKhy8DbQrU52YvxqLHLiRvJX7qCQdfFHsOhiJNJbXqHxSRyJwocgErQkPbp
 Z8Q8YwjNzVfiEBr4Nt1k+VLzkRYQ8gVQYc4U1mLC1I8PyiHLB9W7oMu1qvT6TjL98p31307XHFZ
 GQbWY2+19j/MlA4rr5VOhbDkMZ/t1Krt+nM8rWzkxmz5gjmrRd7vM0GvhnuEJ3CTiGJxRdk=
X-Received: by 2002:a05:690c:4f12:b0:8a8:4931:6190 with SMTP id
 00721157ae682-8ac93c01368mr6331777b3.59.1790781240142; 
 Wed, 30 Sep 2026 08:14:00 -0700 (PDT)
X-Received: by 2002:a05:690c:4f12:b0:8a8:4931:6190 with SMTP id
 00721157ae682-8ac93c01368mr6331407b3.59.1790781239488; 
 Wed, 30 Sep 2026 08:13:59 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917a8991572sm1701236d6.8.2026.09.30.08.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:13:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 10/12] hostmem: Support fully shared guest memfd to back a VM
Date: Wed, 30 Sep 2026 11:13:38 -0400
Message-ID: <20260930151340.2817042-11-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-11-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/system/confidential-guest-support.rst |  2 +
 docs/system/guest-memfd.rst                | 60 +++++++++++++++++++
 docs/system/index.rst                      |  1 +
 qapi/qom.json                              | 15 ++++-
 backends/hostmem-memfd.c                   | 67 ++++++++++++++++++++--
 5 files changed, 139 insertions(+), 6 deletions(-)
 create mode 100644 docs/system/guest-memfd.rst

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
-- 
2.55.0


