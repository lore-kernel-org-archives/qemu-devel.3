Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3A0C27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCwhS-0004Mr-Fs; Fri, 31 May 2024 03:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sCwhP-0004Lk-Lw
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sCwhO-0003YE-50
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717140553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNVcWm9NVa4DYrJoN630zbwQ/tvhuAhNDFHXI3Nttls=;
 b=h7c7TS+A1MLENWsB6mYl6VlLSOsGIZAah66KsA5uHhB+Tu5vd8VTQZtVACRWxV0ULWHrBy
 fSQt5GTagFJXm8KZS1LxqvlYugOZ11BG+3IhP39d4IY3416nqe53DciWNWQG1Z4n7MdsMX
 SReVbqUBCgHs1HnYcEsu8sgCZlJcEqY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-6aI3VdApOZSi2_cwAa7Q3w-1; Fri, 31 May 2024 03:29:11 -0400
X-MC-Unique: 6aI3VdApOZSi2_cwAa7Q3w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44422800169
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 07:29:11 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78151491032;
 Fri, 31 May 2024 07:29:10 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com,
	imammedo@redhat.com
Subject: [PATCH v2 3/4] backends/hostmem: Report error on qemu_madvise()
 failures
Date: Fri, 31 May 2024 09:28:59 +0200
Message-ID: <3341689328d280183062a8fcde006468346ecf1d.1717140354.git.mprivozn@redhat.com>
In-Reply-To: <cover.1717140354.git.mprivozn@redhat.com>
References: <cover.1717140354.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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
correctly. Report an appropriate error.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 backends/hostmem.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index eb9682b4a8..012a8c190f 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -178,8 +178,14 @@ static void host_memory_backend_set_merge(Object *obj, bool value, Error **errp)
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
-        qemu_madvise(ptr, sz,
-                     value ? QEMU_MADV_MERGEABLE : QEMU_MADV_UNMERGEABLE);
+        if (qemu_madvise(ptr, sz,
+                         value ? QEMU_MADV_MERGEABLE : QEMU_MADV_UNMERGEABLE)) {
+            error_setg_errno(errp, errno,
+                             "Couldn't change property 'merge' on '%s'",
+                             object_get_typename(obj));
+            return;
+        }
+
         backend->merge = value;
     }
 }
@@ -204,8 +210,14 @@ static void host_memory_backend_set_dump(Object *obj, bool value, Error **errp)
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
-        qemu_madvise(ptr, sz,
-                     value ? QEMU_MADV_DODUMP : QEMU_MADV_DONTDUMP);
+        if (qemu_madvise(ptr, sz,
+                     value ? QEMU_MADV_DODUMP : QEMU_MADV_DONTDUMP)) {
+            error_setg_errno(errp, errno,
+                             "Couldn't change property 'dump' on '%s'",
+                             object_get_typename(obj));
+            return;
+        }
+
         backend->dump = value;
     }
 }
@@ -337,11 +349,19 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     ptr = memory_region_get_ram_ptr(&backend->mr);
     sz = memory_region_size(&backend->mr);
 
-    if (backend->merge) {
-        qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
+    if (backend->merge &&
+        qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE)) {
+        error_setg_errno(errp, errno,
+                         "Couldn't set property 'merge' on '%s'",
+                         object_get_typename(OBJECT(uc)));
+        return;
     }
-    if (!backend->dump) {
-        qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
+    if (!backend->dump &&
+        qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP)) {
+        error_setg_errno(errp, errno,
+                         "Couldn't set property 'dump' on '%s'",
+                         object_get_typename(OBJECT(uc)));
+        return;
     }
 #ifdef CONFIG_NUMA
     unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
-- 
2.44.1


