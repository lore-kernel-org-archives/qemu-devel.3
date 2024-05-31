Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5D0C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCwhY-0004RI-2o; Fri, 31 May 2024 03:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sCwhX-0004Op-13
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sCwhT-0003Yt-AJ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717140558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ssjbgjftWORE46CGyb0kf54rN64kFgfRw/M+bJ1Y4t4=;
 b=ako2l+BXHXjSnG8i7eUZMQwpNR9H+DH66dFa7z4101KymTAYsrfQOmKGy7ujKiz58xaISz
 sLyfRg2FkUlILO87HCqk/7fJO+jlfy9/7y5Z/av5tsp8Hq9iNmsdOQRTzQLt2iezfptQj9
 J2Db8zDj57gY9OCFkSlbkdL8fW7W7Zc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-BNZo7X3qO9maNk1TmmoGXw-1; Fri,
 31 May 2024 03:29:12 -0400
X-MC-Unique: BNZo7X3qO9maNk1TmmoGXw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4320A1C05138
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 07:29:12 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 777D6491034;
 Fri, 31 May 2024 07:29:11 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com,
	imammedo@redhat.com
Subject: [PATCH v2 4/4] backends/hostmem: Report error when memory size is
 unaligned
Date: Fri, 31 May 2024 09:29:00 +0200
Message-ID: <58295d1f6c995c0c444e375348436e799689126c.1717140354.git.mprivozn@redhat.com>
In-Reply-To: <cover.1717140354.git.mprivozn@redhat.com>
References: <cover.1717140354.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
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

If memory-backend-{file,ram} has a size that's not aligned to
underlying page size it is not only wasteful, but also may lead
to hard to debug behaviour. For instance, in case
memory-backend-file and hugepages, madvise() and mbind() fail.
Rightfully so, page is the smallest unit they can work with. And
even though an error is reported, the root cause it not very
clear:

  qemu-system-x86_64: Couldn't set property 'dump' on 'memory-backend-file': Invalid argument

After this commit:

  qemu-system-x86_64: backend memory size must be multiple of 0x200000

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 backends/hostmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 012a8c190f..5f9c9ea8f5 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -337,6 +337,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
     void *ptr;
     uint64_t sz;
+    size_t pagesize;
     bool async = !phase_check(PHASE_LATE_BACKENDS_CREATED);
 
     if (!bc->alloc) {
@@ -348,6 +349,13 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
 
     ptr = memory_region_get_ram_ptr(&backend->mr);
     sz = memory_region_size(&backend->mr);
+    pagesize = qemu_ram_pagesize(backend->mr.ram_block);
+
+    if (!QEMU_IS_ALIGNED(sz, pagesize)) {
+        error_setg(errp, "backend memory size must be multiple of 0x%"
+                   PRIx64, pagesize);
+        return;
+    }
 
     if (backend->merge &&
         qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE)) {
-- 
2.44.1


