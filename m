Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CC9C52D6D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 21:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb4xJ-0000aU-EI; Mon, 05 Aug 2024 17:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xF-0000CS-9J
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xB-0008TC-4L
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722892151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUWqcmXjQgVAIGwNEeavlkl8JSNFY7ZhrAygvXVLmWM=;
 b=AxAOSJB7Px1qxh33sDjvT/T6o3YRj7xO9YWtyAdHmsfknppDG+HtSacAJgkYJSridANAaV
 tOEGM+XIPK+nUnO/voIJc9RqWNIWu81z7R7OkuaunIJ/HBzMQ7BsyHjEK7OL5unmxKXoMu
 paHyOby7bQiDDeIfdwROolO6hgHZp9M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-Bg7X1643MqyWud0Ek7PUDA-1; Mon,
 05 Aug 2024 17:09:08 -0400
X-MC-Unique: Bg7X1643MqyWud0Ek7PUDA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 693741956064; Mon,  5 Aug 2024 21:09:07 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BC0330001AA; Mon,  5 Aug 2024 21:09:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 03/13] block/graph-lock: Make WITH_GRAPH_RDLOCK_GUARD() fully
 checked
Date: Mon,  5 Aug 2024 23:08:41 +0200
Message-ID: <20240805210851.314076-4-kwolf@redhat.com>
In-Reply-To: <20240805210851.314076-1-kwolf@redhat.com>
References: <20240805210851.314076-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Upstream clang 18 (and backports to clang 17 in Fedora and RHEL)
implemented support for __attribute__((cleanup())) in its Thread Safety
Analysis, so we can now actually have a proper implementation of
WITH_GRAPH_RDLOCK_GUARD() that understands when we acquire and when we
release the lock.

-Wthread-safety is now only enabled if the compiler is new enough to
understand this pattern. In theory, we could have used some #ifdefs to
keep the existing basic checks on old compilers, but as long as someone
runs a newer compiler (and our CI does), we will catch locking problems,
so it's probably not worth keeping multiple implementations for this.

The implementation can't use g_autoptr any more because the glib macros
define wrapper functions that don't have the right TSA attributes, so
the compiler would complain about them. Just use the cleanup attribute
directly instead.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240627181245.281403-3-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/graph-lock.h | 21 ++++++++++++++-------
 meson.build                | 14 +++++++++++++-
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
index d7545e82d0..dc8d949184 100644
--- a/include/block/graph-lock.h
+++ b/include/block/graph-lock.h
@@ -209,31 +209,38 @@ typedef struct GraphLockable { } GraphLockable;
  * unlocked. TSA_ASSERT_SHARED() makes sure that the following calls know that
  * we hold the lock while unlocking is left unchecked.
  */
-static inline GraphLockable * TSA_ASSERT_SHARED(graph_lock) TSA_NO_TSA coroutine_fn
+static inline GraphLockable * TSA_ACQUIRE_SHARED(graph_lock) coroutine_fn
 graph_lockable_auto_lock(GraphLockable *x)
 {
     bdrv_graph_co_rdlock();
     return x;
 }
 
-static inline void TSA_NO_TSA coroutine_fn
-graph_lockable_auto_unlock(GraphLockable *x)
+static inline void TSA_RELEASE_SHARED(graph_lock) coroutine_fn
+graph_lockable_auto_unlock(GraphLockable **x)
 {
     bdrv_graph_co_rdunlock();
 }
 
-G_DEFINE_AUTOPTR_CLEANUP_FUNC(GraphLockable, graph_lockable_auto_unlock)
+#define GRAPH_AUTO_UNLOCK __attribute__((cleanup(graph_lockable_auto_unlock)))
 
+/*
+ * @var is only used to break the loop after the first iteration.
+ * @unlock_var can't be unlocked and then set to NULL because TSA wants the lock
+ * to be held at the start of every iteration of the loop.
+ */
 #define WITH_GRAPH_RDLOCK_GUARD_(var)                                         \
-    for (g_autoptr(GraphLockable) var = graph_lockable_auto_lock(GML_OBJ_()); \
+    for (GraphLockable *unlock_var GRAPH_AUTO_UNLOCK =                        \
+            graph_lockable_auto_lock(GML_OBJ_()),                             \
+            *var = unlock_var;                                                \
          var;                                                                 \
-         graph_lockable_auto_unlock(var), var = NULL)
+         var = NULL)
 
 #define WITH_GRAPH_RDLOCK_GUARD() \
     WITH_GRAPH_RDLOCK_GUARD_(glue(graph_lockable_auto, __COUNTER__))
 
 #define GRAPH_RDLOCK_GUARD(x)                                       \
-    g_autoptr(GraphLockable)                                        \
+    GraphLockable * GRAPH_AUTO_UNLOCK                               \
     glue(graph_lockable_auto, __COUNTER__) G_GNUC_UNUSED =          \
             graph_lockable_auto_lock(GML_OBJ_())
 
diff --git a/meson.build b/meson.build
index 97f63aa86c..c2a050b844 100644
--- a/meson.build
+++ b/meson.build
@@ -649,7 +649,19 @@ warn_flags = [
 ]
 
 if host_os != 'darwin'
-  warn_flags += ['-Wthread-safety']
+  tsa_has_cleanup = cc.compiles('''
+    struct __attribute__((capability("mutex"))) mutex {};
+    void lock(struct mutex *m) __attribute__((acquire_capability(m)));
+    void unlock(struct mutex *m) __attribute__((release_capability(m)));
+
+    void test(void) {
+      struct mutex __attribute__((cleanup(unlock))) m;
+      lock(&m);
+    }
+  ''', args: ['-Wthread-safety', '-Werror'])
+  if tsa_has_cleanup
+    warn_flags += ['-Wthread-safety']
+  endif
 endif
 
 # Set up C++ compiler flags
-- 
2.45.2


