Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E860CF397E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 17:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLlzz-00034r-Ia; Wed, 19 Nov 2025 12:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzn-00031R-OI
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzk-0004PR-HT
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763573367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WZk9+lCKlczElZt5LYeArbAXZ8shM2UJ0/dTfEE7/g=;
 b=HZiyw44rvUcFi6EoRui+bvHF/B+n5McKLdcetf1N4Ms2/QKuGDYYtCYFoi1y1pAtbee7Gc
 dBmfPwSDBsmO/DdCS5DJCgImcFdY8TvXrJKMfaD1c1pkNb4QMmOHbKg+si2gSuJM1zWbKw
 WAJsIxS9zra5HBXVK8+uwa5d12jcyfI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-_fmf5LbXMOeyxNIRfFexWA-1; Wed, 19 Nov 2025 12:29:26 -0500
X-MC-Unique: _fmf5LbXMOeyxNIRfFexWA-1
X-Mimecast-MFC-AGG-ID: _fmf5LbXMOeyxNIRfFexWA_1763573366
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8a5b03118f4so349456885a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 09:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763573365; x=1764178165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WZk9+lCKlczElZt5LYeArbAXZ8shM2UJ0/dTfEE7/g=;
 b=Bg5LdQmw94dIh2wk4JBRv1QOO6jsXCiBhdhi1JZMR3rGtls9uTfIrybQdVnqfRJAgl
 45MRwybwvQz3hXOKOeXZ1S38lTIrskoBcIEyC9prtJOzik2+Mo9dgio2k3kRz06CimgA
 psTk2Eg21EDz9ysMTqXi95ap3DhJsRegD2Dboc/dh7H0VJV/CZDlf6OzmtaSsYllsCA/
 lJhSejKquT1yBdc3sYyws5n+pXapeguGrw+PJwaM8GJBRKaUfu10SLgPBpxMs9eT3W0d
 B3tZSKFFnQ1HshE9xl3pt9AXE+ECxZvp6Fsw6PA5dIPt/oagXFRsL5+9nL2lGuwrWst/
 zi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573365; x=1764178165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1WZk9+lCKlczElZt5LYeArbAXZ8shM2UJ0/dTfEE7/g=;
 b=sNJ1RjhUxx93Gs/i+Vmt3RKKfWwW6o8olsvzZtaaQo9HDhJvEifjgKZfRn23FiReY2
 vwV+5ZyGdlVKYHFM3QkCLBG2aO2TLdiSprdqMUGV3i42LirFylLUkZsYWFqRttcE4eZP
 FYNn61WiKai7NASYijNagcDXDNuAAdo4TdD/f/NcYRxphHfVc/vH64/2Gif7Hd65N5eE
 2609RoJVwh1dvAzkbJSaFaogrcVH66cOb6hpiYMw/UI+4HOyjNcxHcT/rkD2rdjF04sK
 AFhoJRsV95k3oFVt3AHUo6tPKGfU8GHwnbcDG3p3WcpQlXfeJXdbxkOpPL4ow8GRfzxf
 2EPQ==
X-Gm-Message-State: AOJu0YzN+8g4XWKjNnNs+VPDmPvu6nDfvdV1nmqx4PpLQbblEU0APhpq
 wsEekWtDtEOVtPr7/iMJdwupiQegqO+R3Ohs//mfiZu6g8H+w9RYgmRc5jRzYNqGd65/gs16vhw
 ctRwt6/ZdlDmP0eYxGmfXpQQzBovt9HxaagVMUVhS6kYZeoCL/gceBaR8P7aaRX9HF2ou6fIkXg
 xzUszPAboiXfTlUA6Ul94nQs5cKCQsmdbPCjwdyw==
X-Gm-Gg: ASbGncuZckjsFHSOhRYd/WwQyicXmnFT2e1e9eTPYT98+ZnwJY26t5Sf49IJkIes7mM
 gSg2tmGN8cmzqGvcXoyvg6fBS5fcxLFI6bqd0iwFuiAFwqMVxGdfOxUQbBob8LopZlxhjqgmzu3
 ks7EUhNCLrcPUMgXaXVhsMTIKjI1CmlyZHHhuoQkDp9OWXzV6FZGi+uqCrDCXjyZLMnpTPhXinJ
 5b+ogajE9TlwRxidxdCeBHt9+AUmGOcjqzt1XX6uPPSE3LpjXrgv/SmDk1jY8c4CK0gmFSDEUw7
 bB/kjTd32tGyx6QgbHbaTyA19sq0WyY9AOZms3UmFU4sUA5bD87QD+bKZ/XplyJRlnFGJPLbc91
 F
X-Received: by 2002:a05:620a:191b:b0:8a3:90cb:9224 with SMTP id
 af79cd13be357-8b317d92f5bmr498145585a.2.1763573365199; 
 Wed, 19 Nov 2025 09:29:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhgk3d+3020lnhD16jZy7knIrKKKoIFUZQH/w4oWA3KyBu8LLlvimHnmJYkz12Xk2sR+meYw==
X-Received: by 2002:a05:620a:191b:b0:8a3:90cb:9224 with SMTP id
 af79cd13be357-8b317d92f5bmr498138385a.2.1763573364547; 
 Wed, 19 Nov 2025 09:29:24 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af042c9csm1444759485a.46.2025.11.19.09.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:29:23 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, peterx@redhat.com,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 7/9] hostmem: Support in-place guest memfd to back a VM
Date: Wed, 19 Nov 2025 12:29:11 -0500
Message-ID: <20251119172913.577392-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119172913.577392-1-peterx@redhat.com>
References: <20251119172913.577392-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
use it in-place.  If we use guest-memfd, it so far always implies we need
two layers of memory backends, while the guest-memfd only provides the
private set of pages.

This patch introduces a way so that QEMU can consume guest memfd as the
only source of memory to back the object (aka, in place), rather than
having another backend supporting the pages converted to shared.

To use the in-place guest-memfd, one can add a memfd object with:

  -object memory-backend-memfd,guest-memfd=on,share=on

Note that share=on is required with in-place guest_memfd.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/qom.json            |  6 +++-
 backends/hostmem-memfd.c | 66 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 6f5c9de0f0..9ebf17bfc7 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -763,13 +763,17 @@
 # @seal: if true, create a sealed-file, which will block further
 #     resizing of the memory (default: true)
 #
+# @guest-memfd: if true, use guest-memfd to back the memory region.
+#     (default: false, since: 11.0)
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
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index ea93f034e4..1fa16c1e1d 100644
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
+     * which represents a internally private guest-memfd that only backs
+     * private pages.  Instead, this flag marks the memory backend will
+     * 100% use the guest-memfd pages in-place.
+     */
+    bool guest_memfd;
 };
 
 static bool
@@ -47,10 +56,40 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         goto have_fd;
     }
 
-    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
-                           m->hugetlb, m->hugetlbsize, m->seal ?
-                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
-                           errp);
+    if (m->guest_memfd) {
+        /* User choose to use in-place guest-memfd to back the VM.. */
+        if (!backend->share) {
+            error_setg(errp, "In-place guest-memfd must be used with share=on");
+            return false;
+        }
+
+        /*
+         * This is the request to have a guest-memfd to back private pages.
+         * In-place guest-memfd doesn't work like that.  Disable it for now
+         * to make it simple, so that each memory backend can only have
+         * guest-memfd either as private, or fully shared.
+         */
+        if (backend->guest_memfd_private) {
+            error_setg(errp, "In-place guest-memfd cannot be used with another "
+                       "private guest-memfd");
+            return false;
+        }
+
+        /* TODO: add huge page support */
+        fd = kvm_create_guest_memfd(backend->size,
+                                    GUEST_MEMFD_FLAG_MMAP |
+                                    GUEST_MEMFD_FLAG_INIT_SHARED,
+                                    errp);
+        if (fd < 0) {
+            return false;
+        }
+    } else {
+        fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
+                               m->hugetlb, m->hugetlbsize, m->seal ?
+                               F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
+                               errp);
+    }
+
     if (fd == -1) {
         return false;
     }
@@ -65,6 +104,18 @@ have_fd:
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
@@ -152,6 +203,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
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
-- 
2.50.1


