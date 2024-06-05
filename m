Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF60C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 10:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEo8n-0008MZ-VD; Wed, 05 Jun 2024 06:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sEo8m-0008M5-Sp
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sEo8l-0007Xn-7y
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717584309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4D/kenT1/13dMTLp2DYmnMq53lBRYp23R5RDb0lM/OY=;
 b=L25VLTqL7YO5wFd4z1sMX9Bm1ddGtphxQmiJA9ZdZQqEJHseHjC66g0FlkWCy2Yk3L86p3
 190Fxg0iTwNZTMgSSp4o+tNoPTeEJdRrNZaPlIcR3tx/yvqeXgAXEfBUPvISqMjA8HcJne
 3loMkYYgEvkAgFpuh7TC/mDihgyWtLM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145--WtqjVbqN7COuIzeyw8M7g-1; Wed,
 05 Jun 2024 06:45:08 -0400
X-MC-Unique: -WtqjVbqN7COuIzeyw8M7g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5141195C269
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 10:45:06 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0226E19560A2
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 10:45:05 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/5] backends/hostmem: Report error on qemu_madvise()
 failures
Date: Wed,  5 Jun 2024 12:44:57 +0200
Message-ID: <891a67f48e71b70110a7066ec622260c2ff28fc9.1717584048.git.mprivozn@redhat.com>
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

If user sets .merge or .dump attributes qemu_madvise() is called
with corresponding advice. But it is never checked for failure
which may mislead users into thinking the attribute is set
correctly. Report an appropriate error.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
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


