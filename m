Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866BDC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzTv-0003Ta-Ps; Tue, 28 May 2024 12:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sBzTu-0003St-Mh
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sBzTt-0001ir-5U
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716912920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bOdMPqUA+lkNbcV85HXskFJU4DMfBPjohOMFYIhyoQ=;
 b=PHq/RjAjrXLDuM9zvZ27BhNGegdj9mTA00c5UJ6Bau6of+iWvdC/8vspS7lTs3dd3fkHEf
 0vo1WIPhV6r2i6e9o7UUlvaOpp5Q8ndAdbm2w+veK4o+juERyFZN4BLUmZ30rJNuwY6lvM
 r8XsO9ymlwRbEONPu1n84+mn/otYhU0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-6eNjhpCPOwCxwV3KYzG0Tw-1; Tue,
 28 May 2024 12:15:17 -0400
X-MC-Unique: 6eNjhpCPOwCxwV3KYzG0Tw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CEA51C0512D
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 16:15:17 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B1A7C15BB9;
 Tue, 28 May 2024 16:15:16 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com,
	imammedo@redhat.com
Subject: [PATCH 2/3] backends/hostmem: Warn on qemu_madvise() failures
Date: Tue, 28 May 2024 18:15:08 +0200
Message-ID: <b51b2a1cda33115b3370a8b3a4a4e6e9c10566d2.1716912651.git.mprivozn@redhat.com>
In-Reply-To: <cover.1716912651.git.mprivozn@redhat.com>
References: <cover.1716912651.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If user sets .merge or .dump attributes qemu_madvise() is called
with corresponding advice. But it is never checked for failure
which may mislead users into thinking the attribute is set
correctly.I believe at this point it's too late to report errors
in that case but let's report a warning at least.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 backends/hostmem.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index eb9682b4a8..1a6fd1c714 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -14,6 +14,7 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
@@ -178,8 +179,11 @@ static void host_memory_backend_set_merge(Object *obj, bool value, Error **errp)
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
-        qemu_madvise(ptr, sz,
-                     value ? QEMU_MADV_MERGEABLE : QEMU_MADV_UNMERGEABLE);
+        if (qemu_madvise(ptr, sz,
+                         value ? QEMU_MADV_MERGEABLE : QEMU_MADV_UNMERGEABLE)) {
+            warn_report("Couldn't change property 'merge' on '%s': %s",
+                        object_get_typename(obj), strerror(errno));
+        }
         backend->merge = value;
     }
 }
@@ -204,8 +208,11 @@ static void host_memory_backend_set_dump(Object *obj, bool value, Error **errp)
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
-        qemu_madvise(ptr, sz,
-                     value ? QEMU_MADV_DODUMP : QEMU_MADV_DONTDUMP);
+        if (qemu_madvise(ptr, sz,
+                         value ? QEMU_MADV_DODUMP : QEMU_MADV_DONTDUMP)) {
+            warn_report("Couldn't change property 'dump' on '%s': %s",
+                        object_get_typename(obj), strerror(errno));
+        }
         backend->dump = value;
     }
 }
@@ -337,11 +344,15 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     ptr = memory_region_get_ram_ptr(&backend->mr);
     sz = memory_region_size(&backend->mr);
 
-    if (backend->merge) {
-        qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
+    if (backend->merge &&
+        qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE)) {
+        warn_report("Couldn't set property 'merge' on '%s': %s",
+                    object_get_typename(OBJECT(uc)), strerror(errno));
     }
-    if (!backend->dump) {
-        qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
+    if (!backend->dump &&
+        qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP)) {
+        warn_report("Couldn't set property 'dump' on '%s': %s",
+                    object_get_typename(OBJECT(uc)), strerror(errno));
     }
 #ifdef CONFIG_NUMA
     unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
-- 
2.44.1


