Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84D9D5B868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYO-0006J9-KK; Mon, 15 Dec 2025 15:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYN-0006GE-AM
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYL-0005nN-JO
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgZrEo4/DY4n0337ei0aQoLyE7/lInlTug5w3FqBW0I=;
 b=F2eXU03i59s9dBkfgRSb/DZKPlpd3SAzVJnOA6Rw575R4XNceRdPcSCw2JA6MymBgsLZXx
 KI31CjeE3AkQkoOCJq8+hQEXigwIxgUocjrrWVlNJ7HJGQ5QlJbjHH7+sNjlQ+7dq83bf2
 h9UKG1wMA2g5p7e259Lsw2KiuiJuRws=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-Xa0uwzi3NL6kH-wCPpophQ-1; Mon, 15 Dec 2025 15:52:19 -0500
X-MC-Unique: Xa0uwzi3NL6kH-wCPpophQ-1
X-Mimecast-MFC-AGG-ID: Xa0uwzi3NL6kH-wCPpophQ_1765831939
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8804b991976so90829216d6.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831939; x=1766436739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgZrEo4/DY4n0337ei0aQoLyE7/lInlTug5w3FqBW0I=;
 b=lxpBAfOgWheQbfboNL2S5f127AkyggSiYDF/jbH/gPr5Go19ggjJsg7aSnK3K2UTMy
 N/7UOw9vxqEfSe1YtbCNNNJMN0yg43nq3jr6iYZuMmykGFOXn3Jz8+hk/3JgqXq5Jxds
 2xkPXdyVTLf58VGcRPdCUl3Qwf4zvG15lFmEXJUWPg7HRFMOniANwok6nV5YQpMCtWge
 fqEx88afOoXVxnKKUCjfEoeU+OU/pQPJEK4eM3zoWJL1j3xkyJNklD/cnQ+QvWGbs3j6
 CzLb54YAbjTJ+4t5Hsri8mrMeWoI6J74NEpFewskVp6ef+iWL1q372qq4lqOasKhkPzg
 muUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831939; x=1766436739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pgZrEo4/DY4n0337ei0aQoLyE7/lInlTug5w3FqBW0I=;
 b=NwBFOycNGdAbfSG4fzfuiQF9rLa6TmqAIwH1Klhy3cDEFX5Byjkav8vaTiWU2AvVlm
 Hhln9nRz9y8CIG0AR2tK7vTUNKmtkBqrWHxOT5Cwl0di4w0RDBCwYFc+JBzLLGk+xLJU
 un8l9Grz2vj31Ec1JWfkCbdqDQUZxL3K/0jDhRw1mCUvYlLa+teWJDxDdYJLbwb+PRZa
 x+TMDYQp8tR80fcA7OQvwAVdTo7ZRkRghHlc04b7WeqvHRx0F6lNez5aKg1PIZlxl6P3
 uE3IXzATQwqR2fDASm+EWbCtRD4nPkvuC36bPPKzMwYRTV/MT5tSU+2/ShlnhTGLVYat
 oUCg==
X-Gm-Message-State: AOJu0YxYrPfLX0R+Jii+WEguc2n7MoTrvg0b4cxWBsNp4LWZbkKpj/Wi
 o2pySACrFEGGj9oRbFory0F2mzvPnK4hJ/jHmyKN23YaH2vLo+6pYwVvr4OX8GSfg3KeBWZkgFr
 CRsidFIfE+lcChvhYsFB2adWo84fspA5RhptmOsQSElrOvPumtnQceQwTq3Llgd2iZuiQ4Jze4e
 iFhY6TMSC8fptmKPxALATDgE2/ZU+UN4cZpyVzpg==
X-Gm-Gg: AY/fxX70suwIOLC4lkEZ5/4pSkSFfYe/5MzZX9YM25gmGro5S2JVASvV3dYaMKn5aRO
 Gu77a+hSJCsdsQOMT8ETuwf8d/r0wiBAL5FkPiuWv6TfC4UcgPrZyQxnw/xhs8iZ+4PnTnqgtS1
 +Vf/WkUNqHMHWgHC0lmzbbKipg3QL2r1TSvAcIH7afTBvR7GlQ/bqu33tREXCetpHz0Uj7GoEkw
 UXZwFl3SA1SZ5psYx6gUQvUNTtizpJwUpg8MziUbCJDPzuVGoAQAbduppJVTufEm7FePbigRbUp
 xyMyVCcZHxRiaKbMKaCzbJpD7SIA2/B+MfNYjazyRsII/xIvv8xao8zcv/3OA9ep1E5IlnGEB03
 f
X-Received: by 2002:a05:6214:3203:b0:880:1f14:e086 with SMTP id
 6a1803df08f44-8887e191605mr184204176d6.64.1765831938615; 
 Mon, 15 Dec 2025 12:52:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoWT7Liw+FSuMicaSV6vJRL/U+RxelNOAeH+dUvt0vjndwRP2wr7owEmhrCCI0JCtcigKmNg==
X-Received: by 2002:a05:6214:3203:b0:880:1f14:e086 with SMTP id
 6a1803df08f44-8887e191605mr184203726d6.64.1765831938119; 
 Mon, 15 Dec 2025 12:52:18 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:17 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 08/12] hostmem: Support fully shared guest memfd to back a
 VM
Date: Mon, 15 Dec 2025 15:51:59 -0500
Message-ID: <20251215205203.1185099-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
---
 qapi/qom.json            |  6 ++++-
 backends/hostmem-memfd.c | 53 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 53 insertions(+), 6 deletions(-)

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
index ea93f034e4..9299cd7675 100644
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
@@ -47,11 +56,26 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         goto have_fd;
     }
 
-    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
-                           m->hugetlb, m->hugetlbsize, m->seal ?
-                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
-                           errp);
-    if (fd == -1) {
+    if (m->guest_memfd) {
+        /* User choose to use fully shared guest-memfd to back the VM.. */
+        if (!backend->share) {
+            error_setg(errp, "Guest-memfd=on must be used with share=on");
+            return false;
+        }
+
+        /* TODO: add huge page support */
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
@@ -65,6 +89,18 @@ have_fd:
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
@@ -152,6 +188,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
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


