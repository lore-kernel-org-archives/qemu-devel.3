Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DC8C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 10:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEo8o-0008Mr-Ex; Wed, 05 Jun 2024 06:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sEo8m-0008M6-TQ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sEo8l-0007YM-Ap
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717584310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSZF4mwrkXG1tQ6t9AZWmM6HQVZkVRfqNp5gk3PHog4=;
 b=Cw9lyQ4+rLyf1AOcFbM7iQui6QRrtmfHUF7Rc89a3dynJStZ0/I0taqU9LdUCKIOv0eZ5E
 DPvRVRd5c0dnvZrtJgRKcmtunkz74Ulpt3wURyXSnHuodOKKjWi8xNQIWgbfhBpCBLHuOh
 2H/iRZOeYDKOUGedouBYVwEckCMxKPE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-k7hBehNFPT-Fes5FPwirfg-1; Wed,
 05 Jun 2024 06:45:08 -0400
X-MC-Unique: k7hBehNFPT-Fes5FPwirfg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F00431955D77
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 10:45:07 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 206E519560A2
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 10:45:06 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/5] backends/hostmem: Report error when memory size is
 unaligned
Date: Wed,  5 Jun 2024 12:44:58 +0200
Message-ID: <b5b9f9c6bba07879fb43f3c6f496c69867ae3716.1717584048.git.mprivozn@redhat.com>
In-Reply-To: <cover.1717584048.git.mprivozn@redhat.com>
References: <cover.1717584048.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

If memory-backend-{file,ram} has a size that's not aligned to
underlying page size it is not only wasteful, but also may lead
to hard to debug behaviour. For instance, in case
memory-backend-file and hugepages, madvise() and mbind() fail.
Rightfully so, page is the smallest unit they can work with. And
even though an error is reported, the root cause it not very
clear:

  qemu-system-x86_64: Couldn't set property 'dump' on 'memory-backend-file': Invalid argument

After this commit:

  qemu-system-x86_64: backend 'memory-backend-file' memory size must be multiple of 2 MiB

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mario Casquero <mcasquer@redhat.com>
---
 backends/hostmem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 012a8c190f..4d6c69fe4d 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -20,6 +20,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/madvise.h"
+#include "qemu/cutils.h"
 #include "hw/qdev-core.h"
 
 #ifdef CONFIG_NUMA
@@ -337,6 +338,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
     void *ptr;
     uint64_t sz;
+    size_t pagesize;
     bool async = !phase_check(PHASE_LATE_BACKENDS_CREATED);
 
     if (!bc->alloc) {
@@ -348,6 +350,14 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
 
     ptr = memory_region_get_ram_ptr(&backend->mr);
     sz = memory_region_size(&backend->mr);
+    pagesize = qemu_ram_pagesize(backend->mr.ram_block);
+
+    if (!QEMU_IS_ALIGNED(sz, pagesize)) {
+        g_autofree char *pagesize_str = size_to_str(pagesize);
+        error_setg(errp, "backend '%s' memory size must be multiple of %s",
+                   object_get_typename(OBJECT(uc)), pagesize_str);
+        return;
+    }
 
     if (backend->merge &&
         qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE)) {
-- 
2.44.1


