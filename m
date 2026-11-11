Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB2606A32E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FyuqsjjN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7N4-000331-3E; Wed, 11 Nov 2026 07:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mn-0002zk-M9
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mk-0000ZT-CG
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794399829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0P+cPyOmWgZpP2DSvVKaKBOdBavTHl09lYIpmkqwzCE=;
 b=FyuqsjjNHwvqRMYZSnDtPffsknZ/+cUg9R5rpXgeUu6iF5svHpHe0ci+vYwfCHS5Wf6Ij8
 CrxeV1cuF/tzsr8eib1mUjU8VWz5p6i/R+hwg76G0mH4ORTMtMgwu8Twjex/+XcWa5b6TU
 haisrRydBgFHPpD7QnbFI6d5z09p0PQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-9Kd0SqXhP0m4s02iaT-bxQ-1; Wed,
 11 Nov 2026 07:23:46 -0500
X-MC-Unique: 9Kd0SqXhP0m4s02iaT-bxQ-1
X-Mimecast-MFC-AGG-ID: 9Kd0SqXhP0m4s02iaT-bxQ_1794399825
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF25C1955D88; Wed, 11 Nov 2026 12:23:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 975E91800542; Wed, 11 Nov 2026 12:23:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 391D721E692D; Wed, 11 Nov 2026 13:23:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 1/7] backends/hostmem: Drop redundant validation of property
 "size"
Date: Wed, 11 Nov 2026 13:23:36 +0100
Message-ID: <20261111122342.634370-2-armbru@redhat.com>
In-Reply-To: <20261111122342.634370-1-armbru@redhat.com>
References: <20261111122342.634370-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Property "size" is mandatory, and its setter
host_memory_backend_set_size() rejects value zero.  Delete the
redundant checks for zero in the .alloc() callbacks.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 backends/hostmem-epc.c   | 5 -----
 backends/hostmem-file.c  | 4 ----
 backends/hostmem-memfd.c | 5 -----
 backends/hostmem-ram.c   | 5 -----
 backends/hostmem-shm.c   | 5 -----
 5 files changed, 24 deletions(-)

diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
index ab20b182331..e1c784249ff 100644
--- a/backends/hostmem-epc.c
+++ b/backends/hostmem-epc.c
@@ -24,11 +24,6 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     uint32_t ram_flags;
     int fd;
 
-    if (!backend->size) {
-        error_setg(errp, "can't create backend with size 0");
-        return false;
-    }
-
     fd = qemu_open("/dev/sgx_vepc", O_RDWR, errp);
     if (fd < 0) {
         return false;
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 6ad9cad0320..08d0382d76f 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -48,10 +48,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     g_autofree gchar *name = NULL;
     uint32_t ram_flags;
 
-    if (!backend->size) {
-        error_setg(errp, "can't create backend with size 0");
-        return false;
-    }
     if (!fb->mem_path) {
         error_setg(errp, "mem-path property not set");
         return false;
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 46489212a23..11d456e3ebd 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -49,11 +49,6 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     int fd = cpr_find_fd(name, 0);
     uint32_t ram_flags;
 
-    if (!backend->size) {
-        error_setg(errp, "can't create backend with size 0");
-        return false;
-    }
-
     if (fd >= 0) {
         goto have_fd;
     }
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 6a507fad77c..0ae7b4ae759 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -22,11 +22,6 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     g_autofree char *name = NULL;
     uint32_t ram_flags;
 
-    if (!backend->size) {
-        error_setg(errp, "can't create backend with size 0");
-        return false;
-    }
-
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index adf60957c3c..0a01c760551 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -30,11 +30,6 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     uint32_t ram_flags;
     int fd = cpr_find_fd(backend_name, 0);
 
-    if (!backend->size) {
-        error_setg(errp, "can't create shm backend with size 0");
-        return false;
-    }
-
     if (!backend->share) {
         error_setg(errp, "can't create shm backend with `share=off`");
         return false;
-- 
2.55.0


