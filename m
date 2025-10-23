Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19997CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0XB-0006ad-LD; Thu, 23 Oct 2025 14:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0X9-0006ZW-Oc
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0X7-0003EN-Gx
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761245972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+mpVlWrgRBpecPbzFIQUbJyLDt7bDmktG7fUEU0KxA=;
 b=eweVEquhuypUKmETjLiXV1fxvEafmtLf9iuJkZuhYrKAZFrXq180mLV/r2KYT7iT3IAJbi
 2jipm8aP3O7eqCSqSSubjE06gRlct6QHN66MQpO4hAiRL9jGwDbY7HyuFOPNhkzv7XHGlr
 Bkemgpno+3SVJf64vwCYqOXduSKAIoI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-DPLhGyLsPNmHAjBVEas3KQ-1; Thu, 23 Oct 2025 14:59:31 -0400
X-MC-Unique: DPLhGyLsPNmHAjBVEas3KQ-1
X-Mimecast-MFC-AGG-ID: DPLhGyLsPNmHAjBVEas3KQ_1761245971
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4e88947a773so55467631cf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761245970; x=1761850770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+mpVlWrgRBpecPbzFIQUbJyLDt7bDmktG7fUEU0KxA=;
 b=mtBT3XgPPCz6MvWt0M8T73/2F4zW2utxc8J8pl1fVQIYRO9y3qlyQUwixzxyFuAZ09
 ZCqs+3HoKK6ewpiJhWhTVRv9feIOJw3H+DmInOzUMcugK7aNZPFzOEOl+UY0pwDrIOcp
 q713AXlqUjywQFUcSrXHUi036gAKo2pjWRPPW8RViPs4wqC0zjSJvjGRBQxTl/O7xLAM
 ChnUEko2+JQfgy3cxFsNXizEn/3wu6m77d5Bmbh82Yz7Tcn0NomxfzPojFL1eFPYxohJ
 Eg2bJqiKkfNw+nn7Wf9RxfgvTNvXNBPqwet4/LmXqrl1trZ9Le9YYqOT12qb8EKZgxCp
 tZaw==
X-Gm-Message-State: AOJu0YxwVobw/va+mt5jDOOHXFF1lwzt+6MT5Mzhm+C81bHxAkFAyrwA
 QUqQkIJ+JpLqEUo/QNbq9CDDQJ+W+pbCsIMCv30nBr5qY6Nf3xlun0LPSTR7RXM22yX3qmCC9mc
 leRJa3FRVvlZsvQkjjvyD9qPrAsvOToraOC519J3zyagOoDi02YyMfdml8fnY0T9pAgi1xO1Agz
 CY9dyd2AlEnXSwFBkChWXrA+j/DiVZYIgk0/NFgw==
X-Gm-Gg: ASbGncsZO4K01n1D7M0gUu/oVQRNAwgcAMYpqqG2n/L05Uc8LT+T9cGxhJGYNtIr8eQ
 CTcj36dir6qaIDNkyBbG0h1oHVAFgIc0p/46I4dDrDJbzzcWc3kLhIkToydMj0i0wQUt+voZXAF
 EXwg+ik+4NSosP9d5E30gQQG1du7gPHZ4MxWNRlW8NgQsqOmdvHItWDAO7NKCEpsoiEftVJo2Qc
 32G083V5c8FmvRksUOomUN9hBeUyg+Q3dpx9ncfJdPd8SVs4VCaD//hxQoDAaaTKWdvwTvNd9E4
 Nh1t4+hQfKMa66+ZpjFMJpWejmlvGOk1l6rHoKY65CyroUmzhBhZ4dM8J42x8Yhx
X-Received: by 2002:a05:622a:650:b0:4e8:aa22:def3 with SMTP id
 d75a77b69052e-4e8aa22e558mr281838921cf.19.1761245970122; 
 Thu, 23 Oct 2025 11:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmmnB/tCoG176yVHb77uscDJtQGtynoLcszG/HybtMkf0gbPzCuCZnyL3Y0+CbppV1GJj1Yw==
X-Received: by 2002:a05:622a:650:b0:4e8:aa22:def3 with SMTP id
 d75a77b69052e-4e8aa22e558mr281838381cf.19.1761245969190; 
 Thu, 23 Oct 2025 11:59:29 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0ec61770sm213940585a.26.2025.10.23.11.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 11:59:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 8/8] hostmem: Support in-place guest memfd to back a VM
Date: Thu, 23 Oct 2025 14:59:13 -0400
Message-ID: <20251023185913.2923322-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251023185913.2923322-1-peterx@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 830cb2ffe7..6b090fe9a0 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -764,13 +764,17 @@
 # @seal: if true, create a sealed-file, which will block further
 #     resizing of the memory (default: true)
 #
+# @guest-memfd: if true, use guest-memfd to back the memory region.
+#     (default: false, since: 10.2)
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


