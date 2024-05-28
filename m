Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBA6C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzTw-0003Tp-Gj; Tue, 28 May 2024 12:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sBzTu-0003T2-NZ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sBzTt-0001iy-6a
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716912920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=daoFMEShlBnxsuXyynDFlX5cEjXfkBVlaBMEp7a2wDo=;
 b=GkRYAmbQJer3+Vo0UQcpTJcOmCZ0whaPHIBkqXl/UU93wmO8lgLY6lCs9TMKU4KRmiz/BM
 9ndPYXpVguXu51v+stx8w7btOFXCPZDMahHFx7zro3NlPjZkvCtR2wecJPAbYSdT68EhIb
 2Ljnu0h5DlnfdhAz2U1hOB+oCFb88Hw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Q6iOy824MzGkPufIyvQsyw-1; Tue, 28 May 2024 12:15:18 -0400
X-MC-Unique: Q6iOy824MzGkPufIyvQsyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 528BE185A780
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 16:15:18 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FD73C15BC3;
 Tue, 28 May 2024 16:15:17 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com,
	imammedo@redhat.com
Subject: [PATCH 3/3] backends/hostmem: Round up memory size for qemu_madvise()
 and mbind()
Date: Tue, 28 May 2024 18:15:09 +0200
Message-ID: <bd03706d336e9be360dd53cf125c27fbeb26acf7.1716912651.git.mprivozn@redhat.com>
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

Simple reproducer:
qemu.git $ ./build/qemu-system-x86_64 \
-m size=8389632k,slots=16,maxmem=25600000k \
-object
'{"qom-type":"memory-backend-file","id":"ram-node0","mem-path":"/hugepages2M/","prealloc":true,"size":8590983168,"host-nodes":[0],"policy":"bind"}' \
-numa node,nodeid=0,cpus=0,memdev=ram-node0

With current master I get:

qemu-system-x86_64: cannot bind memory to host NUMA nodes: Invalid argument

The problem is that memory size (8193MiB) is not an integer
multiple of underlying pagesize (2MiB) which triggers a check
inside of mbind(), since we can't really set policy just to a
fraction of a page. As qemu_madvise() has the same expectation,
round size passed to underlying pagesize.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 backends/hostmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 1a6fd1c714..9b727699f6 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -179,6 +179,8 @@ static void host_memory_backend_set_merge(Object *obj, bool value, Error **errp)
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
+        sz = ROUND_UP(sz, qemu_ram_pagesize(backend->mr.ram_block));
+
         if (qemu_madvise(ptr, sz,
                          value ? QEMU_MADV_MERGEABLE : QEMU_MADV_UNMERGEABLE)) {
             warn_report("Couldn't change property 'merge' on '%s': %s",
@@ -208,6 +210,8 @@ static void host_memory_backend_set_dump(Object *obj, bool value, Error **errp)
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
+        sz = ROUND_UP(sz, qemu_ram_pagesize(backend->mr.ram_block));
+
         if (qemu_madvise(ptr, sz,
                          value ? QEMU_MADV_DODUMP : QEMU_MADV_DONTDUMP)) {
             warn_report("Couldn't change property 'dump' on '%s': %s",
@@ -344,6 +348,13 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     ptr = memory_region_get_ram_ptr(&backend->mr);
     sz = memory_region_size(&backend->mr);
 
+    /*
+     * Round up size to be an integer multiple of pagesize, because
+     * both madvise() and mbind() does not really like setting
+     * advice/policy to just a fraction of a page.
+     */
+    sz = ROUND_UP(sz, qemu_ram_pagesize(backend->mr.ram_block));
+
     if (backend->merge &&
         qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE)) {
         warn_report("Couldn't set property 'merge' on '%s': %s",
-- 
2.44.1


