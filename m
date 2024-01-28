Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34329C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 17:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9K8-0005k4-2W; Sun, 28 Jan 2024 12:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9J0-0002np-NE; Sun, 28 Jan 2024 12:50:57 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9Iy-0000nh-OG; Sun, 28 Jan 2024 12:50:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B0DF248107;
 Sun, 28 Jan 2024 20:51:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 46A816D523;
 Sun, 28 Jan 2024 20:50:38 +0300 (MSK)
Received: (nullmailer pid 812413 invoked by uid 1000);
 Sun, 28 Jan 2024 17:50:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 58/71] coroutine-ucontext: Save fake stack for pooled
 coroutine
Date: Sun, 28 Jan 2024 20:50:21 +0300
Message-Id: <20240128175035.812352-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Coroutine may be pooled even after COROUTINE_TERMINATE if
CONFIG_COROUTINE_POOL is enabled and fake stack should be saved in
such a case to keep AddressSanitizerUseAfterReturn working. Even worse,
I'm seeing stack corruption without fake stack being saved.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240117-asan-v2-1-26f9e1ea6e72@daynix.com>
(cherry picked from commit d9945ccda08ef83b09ac7725b6ee2d1959f2c0c0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 7b304c79d9..8ef603d081 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -119,13 +119,11 @@ void finish_switch_fiber(void *fake_stack_save)
 
 /* always_inline is required to avoid TSan runtime fatal errors. */
 static inline __attribute__((always_inline))
-void start_switch_fiber_asan(CoroutineAction action, void **fake_stack_save,
+void start_switch_fiber_asan(void **fake_stack_save,
                              const void *bottom, size_t size)
 {
 #ifdef CONFIG_ASAN
-    __sanitizer_start_switch_fiber(
-            action == COROUTINE_TERMINATE ? NULL : fake_stack_save,
-            bottom, size);
+    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
 #endif
 }
 
@@ -165,7 +163,7 @@ static void coroutine_trampoline(int i0, int i1)
     if (!sigsetjmp(self->env, 0)) {
         CoroutineUContext *leaderp = get_ptr_leader();
 
-        start_switch_fiber_asan(COROUTINE_YIELD, &fake_stack_save,
+        start_switch_fiber_asan(&fake_stack_save,
                                 leaderp->stack, leaderp->stack_size);
         start_switch_fiber_tsan(&fake_stack_save, self, true); /* true=caller */
         siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
@@ -226,8 +224,7 @@ Coroutine *qemu_coroutine_new(void)
 
     /* swapcontext() in, siglongjmp() back out */
     if (!sigsetjmp(old_env, 0)) {
-        start_switch_fiber_asan(COROUTINE_YIELD, &fake_stack_save, co->stack,
-                                co->stack_size);
+        start_switch_fiber_asan(&fake_stack_save, co->stack, co->stack_size);
         start_switch_fiber_tsan(&fake_stack_save,
                                 co, false); /* false=not caller */
 
@@ -269,10 +266,28 @@ static inline void valgrind_stack_deregister(CoroutineUContext *co)
 #endif
 #endif
 
+#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
+static void coroutine_fn terminate_asan(void *opaque)
+{
+    CoroutineUContext *to = DO_UPCAST(CoroutineUContext, base, opaque);
+
+    set_current(opaque);
+    start_switch_fiber_asan(NULL, to->stack, to->stack_size);
+    G_STATIC_ASSERT(!IS_ENABLED(CONFIG_TSAN));
+    siglongjmp(to->env, COROUTINE_ENTER);
+}
+#endif
+
 void qemu_coroutine_delete(Coroutine *co_)
 {
     CoroutineUContext *co = DO_UPCAST(CoroutineUContext, base, co_);
 
+#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
+    co_->entry_arg = qemu_coroutine_self();
+    co_->entry = terminate_asan;
+    qemu_coroutine_switch(co_->entry_arg, co_, COROUTINE_ENTER);
+#endif
+
 #ifdef CONFIG_VALGRIND_H
     valgrind_stack_deregister(co);
 #endif
@@ -305,8 +320,10 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
 
     ret = sigsetjmp(from->env, 0);
     if (ret == 0) {
-        start_switch_fiber_asan(action, &fake_stack_save, to->stack,
-                                to->stack_size);
+        start_switch_fiber_asan(IS_ENABLED(CONFIG_COROUTINE_POOL) ||
+                                action != COROUTINE_TERMINATE ?
+                                    &fake_stack_save : NULL,
+                                to->stack, to->stack_size);
         start_switch_fiber_tsan(&fake_stack_save,
                                 to, false); /* false=not caller */
         siglongjmp(to->env, action);
-- 
2.39.2


