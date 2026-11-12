Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC85606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yw07+dhe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTLN-0008Cm-3S; Thu, 12 Nov 2026 06:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRTLK-0007yC-37
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRTLH-00048N-UG
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794484307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4e33aWqJaBp24m0+msLwEGz+DgeayWNXszC2a84DpE4=;
 b=Yw07+dhe0c3AoX9P+vBFxq4nEPieaAW3HTK9Gw5GjTMvn6O7KrBxeTKSNHHflk1jopRAM2
 PLL/yLeDcwmPyXM/eAhoSaYb1L6IcL/c9FS2CCmqoXJ6MpU51BAJme9VTIUYgARFLOkqf1
 ReLAOgsZgsh1JFKqRh/ye1Y/m3ISeJE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-1F9389Y1PYeSkIHGdaVVMg-1; Thu,
 12 Nov 2026 06:51:46 -0500
X-MC-Unique: 1F9389Y1PYeSkIHGdaVVMg-1
X-Mimecast-MFC-AGG-ID: 1F9389Y1PYeSkIHGdaVVMg_1794484305
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2949B18A322E; Thu, 12 Nov 2026 11:51:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D0E630000D3; Thu, 12 Nov 2026 11:51:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 42CC921E6A04; Thu, 12 Nov 2026 12:51:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	david@kernel.org,
	imammedo@redhat.com
Subject: [PATCH] backends/hostmem: Factor out "property still settable" check
Date: Thu, 12 Nov 2026 12:51:42 +0100
Message-ID: <20261112115142.973035-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We check whether a property can still be set like this:

    if (host_memory_backend_mr_inited(backend)) {
        error_setg(errp, ...);
        return;
    }

The actual error messages vary a bit.  Most are like

    cannot change property 'PROP-NAME' of TYPE-NAME

but we also have

    cannot change property value

Factor out into host_memory_backend_settable() so we can instead use:

    if (!host_memory_backend_settable(backend, name, errp)) {
        return;
    }

The error message is now always

    cannot change property 'PROP-NAME' of 'TYPE-NAME'

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/system/hostmem.h |  2 ++
 backends/hostmem-file.c  | 24 ++++++------------------
 backends/hostmem-memfd.c |  3 +--
 backends/hostmem.c       | 21 ++++++++++++++-------
 4 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index dcbf81aeaea..47ccc732bcb 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -86,6 +86,8 @@ struct HostMemoryBackend {
 };
 
 bool host_memory_backend_mr_inited(HostMemoryBackend *backend);
+bool host_memory_backend_settable(HostMemoryBackend *backend,
+                                  const char *prop_name, Error **errp);
 MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend);
 
 void host_memory_backend_set_mapped(HostMemoryBackend *backend, bool mapped);
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 6ad9cad0320..b5485f12bea 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -107,9 +107,7 @@ static void set_mem_path(Object *o, const char *str, Error **errp)
     HostMemoryBackend *backend = MEMORY_BACKEND(o);
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
 
-    if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property 'mem-path' of %s",
-                   object_get_typename(o));
+    if (!host_memory_backend_settable(backend, "mem-path", errp)) {
         return;
     }
     g_free(fb->mem_path);
@@ -145,9 +143,7 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
     uint64_t val;
 
-    if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property '%s' of %s", name,
-                   object_get_typename(o));
+    if (!host_memory_backend_settable(backend, name, errp)) {
         return;
     }
 
@@ -175,9 +171,7 @@ static void file_memory_backend_set_offset(Object *o, Visitor *v,
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
     uint64_t val;
 
-    if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property '%s' of %s", name,
-                   object_get_typename(o));
+    if (!host_memory_backend_settable(backend, name, errp)) {
         return;
     }
 
@@ -198,9 +192,7 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
     HostMemoryBackend *backend = MEMORY_BACKEND(o);
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
 
-    if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property 'pmem' of %s.",
-                   object_get_typename(o));
+    if (!host_memory_backend_settable(backend, "pmem", errp)) {
         return;
     }
 
@@ -221,9 +213,7 @@ static void file_memory_backend_set_readonly(Object *obj, bool value,
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
 
-    if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property 'readonly' of %s.",
-                   object_get_typename(obj));
+    if (!host_memory_backend_settable(backend, "readonly", errp)) {
         return;
     }
 
@@ -241,9 +231,7 @@ static void file_memory_backend_set_rom(Object *obj, int value, Error **errp)
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
 
-    if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property 'rom' of %s.",
-                   object_get_typename(obj));
+    if (!host_memory_backend_settable(backend, "rom", errp)) {
         return;
     }
 
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 46489212a23..e56f26cd24c 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -134,8 +134,7 @@ memfd_backend_set_hugetlbsize(Object *obj, Visitor *v, const char *name,
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(obj);
     uint64_t value;
 
-    if (host_memory_backend_mr_inited(MEMORY_BACKEND(obj))) {
-        error_setg(errp, "cannot change property value");
+    if (!host_memory_backend_settable(MEMORY_BACKEND(m), name, errp)) {
         return;
     }
 
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 173d042be35..f8fadeb28c1 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -66,9 +66,7 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     uint64_t value;
 
-    if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property %s of %s ", name,
-                   object_get_typename(obj));
+    if (!host_memory_backend_settable(backend, name, errp)) {
         return;
     }
 
@@ -310,6 +308,17 @@ bool host_memory_backend_mr_inited(HostMemoryBackend *backend)
     return memory_region_size(&backend->mr) != 0;
 }
 
+bool host_memory_backend_settable(HostMemoryBackend *backend,
+                                  const char *prop_name, Error **errp)
+{
+    if (host_memory_backend_mr_inited(backend)) {
+        error_setg(errp, "cannot change property '%s' of '%s'",
+                   prop_name, object_get_typename(OBJECT(backend)));
+        return false;
+    }
+    return true;
+}
+
 MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend)
 {
     return host_memory_backend_mr_inited(backend) ? &backend->mr : NULL;
@@ -458,8 +467,7 @@ static void host_memory_backend_set_share(Object *o, bool value, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(o);
 
-    if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property value");
+    if (!host_memory_backend_settable(backend, "share", errp)) {
         return;
     }
     backend->share = value;
@@ -477,8 +485,7 @@ static void host_memory_backend_set_reserve(Object *o, bool value, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(o);
 
-    if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property value");
+    if (!host_memory_backend_settable(backend, "reserve", errp)) {
         return;
     }
     if (backend->prealloc && !value) {
-- 
2.55.0


