Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAEF606A33A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HXL3fAtz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7Ms-00030l-TM; Wed, 11 Nov 2026 07:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mn-0002zl-NB
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mk-0000ZQ-Ca
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794399829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYS0n+j2SskWhCisVLijNH4ZXdpdbSunH8tVqWIrrSo=;
 b=HXL3fAtzgrEj7p6FpdFumCyoMmeVoXBbMvGMbxaaEi+Hmw0GA4iMNzUGJKgR8Nz11xsuMr
 VpT7nRnpStSUKQn7uXxg9lOegYrCGgBnRKfwNyjdiHZjRkBZaeIwiiSsUMaSFHPDpQpT2J
 Jl9NWPiHRf4gGgO1oliPYX4lx/iB1yE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655--v-vlIPyMrmvMM3cob7dJQ-1; Wed,
 11 Nov 2026 07:23:45 -0500
X-MC-Unique: -v-vlIPyMrmvMM3cob7dJQ-1
X-Mimecast-MFC-AGG-ID: -v-vlIPyMrmvMM3cob7dJQ_1794399825
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0C52180288A; Wed, 11 Nov 2026 12:23:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97A3219634EF; Wed, 11 Nov 2026 12:23:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 41D5F21E6882; Wed, 11 Nov 2026 13:23:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 3/7] backends/hostmem: Improve error reporting when method
 alloc() fails
Date: Wed, 11 Nov 2026 13:23:38 +0100
Message-ID: <20261111122342.634370-4-armbru@redhat.com>
In-Reply-To: <20261111122342.634370-1-armbru@redhat.com>
References: <20261111122342.634370-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When HostMemoryBackend method alloc() fails, the error report isn't
always clear.  E.g. "-object memory-backend-shm,id=mem0,size=1E" fails
for me like this:

    qemu-system-x86_64: unable to map backing store for guest RAM: Cannot allocate memory

Leaves users guessing which part of the (often lengthy) command line
needs fixing.

Let's prepend a bit of context:

    qemu-system-x86_64: can't create memory-backend-shm: unable to map backing store for guest RAM: Cannot allocate memory

This makes an error message in shm_backend_memory_alloc() partly
redundant:

    qemu-system-x86_64: can't create memory-backend-shm: can't create shm backend with `share=off`

Change it to

    qemu-system-x86_64: can't create memory-backend-shm: backend requires 'share=on'

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 backends/hostmem-shm.c | 2 +-
 backends/hostmem.c     | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index 0a01c760551..d1cba22cbeb 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -31,7 +31,7 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     int fd = cpr_find_fd(backend_name, 0);
 
     if (!backend->share) {
-        error_setg(errp, "can't create shm backend with `share=off`");
+        error_setg(errp, "backend requires 'share=on'");
         return false;
     }
 
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 173d042be35..1c2a5d42fc5 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -335,6 +335,7 @@ size_t host_memory_backend_pagesize(HostMemoryBackend *memdev)
 static void
 host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
 {
+    ERRP_GUARD();
     HostMemoryBackend *backend = MEMORY_BACKEND(uc);
     HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
     void *ptr;
@@ -346,6 +347,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
         return;
     }
     if (!bc->alloc(backend, errp)) {
+        error_prepend(errp, "can't create '%s': ",
+                      object_get_typename(OBJECT(uc)));
         return;
     }
 
-- 
2.55.0


