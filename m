Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEA0C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IEQ-000121-77; Mon, 28 Apr 2025 02:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IBk-0004Wl-6Z; Mon, 28 Apr 2025 02:42:00 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IBi-0007GP-2q; Mon, 28 Apr 2025 02:41:59 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-301cda78d48so5634492a91.0; 
 Sun, 27 Apr 2025 23:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822515; x=1746427315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0Wf80NffurSlkXmcsdUzlJZxbjy4i/ytcK33G2V2E4=;
 b=mSadiNwALRMfyHSEO8WCmOSJYaCem3hI1TxDU2bL1nPbIhy25IrL9s+6eGxHLS4e+i
 EY+vteisqwRIK3lxbhBFL6Ptc5Vsiz3VZyc+cUIFGtTzkAxZY5pSAQ5BZRuUrcerGMxy
 YZJvvD/7z/j4pI/UFaYDXCkSsjL9aAaX48NBg1s7MdiPm4fRay7UwK3cGBOjk39a+eHs
 2n7LlB1DudHv549NjpKDnjJLGclP+i73i51LN4x+wpSz9ttTy6HRln2hPeru+DxuhKDL
 XIm69s9Hk5owxX4EMZMPCkfiBB5zhX+81WZdTFUzg4bOYm8YAQFBn4Xg91o4wmmtsPUN
 Dn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822515; x=1746427315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0Wf80NffurSlkXmcsdUzlJZxbjy4i/ytcK33G2V2E4=;
 b=fIKwgl5wnvwr2+a2WJxGK4pPzDvV/jOmUE/cSt0iC6rd5EHzgAhcYYWDwd8jARfPlj
 OPPJF58MI/oY97Xhesb0zs7qkkV+mKyDr8aJr9koVDyPBLnLVZcturgd2qVOjKbQjLvq
 AWocb+9PY/QJ8R7bv1LOqL2mcXRM/OyP4RhvBuMxgALCczA/KHfRAAZi6NV6HXCqcy9g
 YaR8dxmorjLWqWt/EYgyRCWzm84YOfFWx92wKyGpGXJPnMMZqbrKLKkWmgEvVcemx05+
 ppeV7QP3MUPdG2o6a0GHa4S0n6Xbps7GAUCkHn1o/dfBe8fs66ZkTMVfUcXHlmSSGMed
 f3qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCqkNV4WhHN2k4VlYSr1brJoWSN9HvA4jh9NsprjSKN3JchcwKg5n1kZpgqbAun7sAKZgu6f5ijQ==@nongnu.org,
 AJvYcCVc57R4IHkg8C5bTSztoF/Tsx+gOgeLZhSyKRFo1pM6Eq/09924cGBJ1cSwgLA4Pq+ZIcSSjL4PCA9EDA==@nongnu.org,
 AJvYcCVpDgyriLLz2BOCoi201wyEihcn0RRIKSEq3mUfqUme35+/+WmO3QfG4aKOvl4lhAo6pc1iNosZrjQ=@nongnu.org,
 AJvYcCWVKyAmsq8a6a1sO+Dzu9kpw4Ehxyg7vKU5irD9B0e4SvusV6d+xx0r0admROUw/mngWb/mMJyR5YdUpg==@nongnu.org
X-Gm-Message-State: AOJu0YzzKQKWKwSMfWXjeqjMdxSEDYrG1GYxq+sx3AEG09QLaBGLRKy0
 IkkqBRTOMDoIQqZf6qmuDbEO2mXws+W9tCLYvpSJTUjDxGr6umod+hEg5O0b
X-Gm-Gg: ASbGnct3RmNdEml2D5EwwYnFU9tWtH8xqMaVfHXT/Q9Na6uCTgtypAzaF2MTvudTPil
 EJg0R+aLeBTiAghM2wZLIHzZV84wel3H3fcO95Dkg1czgLy/tBoak/jqlB5vMIGQAknvoWIF4Po
 JZ6WuNAH+jDJFav+aSVlM8mSzCwQn+t0xCv+IVhrxDERrZN5Azt7XfQFj1Ih6KWobxvnYtNM0GO
 XnVropYJ6qKaACEqJo0LtgqXuRqWwUSPndR59j0UYUQDGdy1FGh08sUA9IWu+kixpnZMsNPdjYJ
 RXVyAGoFdrBuTpJerXnY6UfQgyGAq0mAgyY3aQ==
X-Google-Smtp-Source: AGHT+IHQKX6DhM37Ht0WV4SiSf/TUobWjgLJPNeO0UwuKZhXmTU4y+MYc25oI+0wuZVVoCFd6ncWIw==
X-Received: by 2002:a17:90a:c88b:b0:2fe:b016:a6ac with SMTP id
 98e67ed59e1d1-309f7df179fmr16640434a91.15.1745822514802; 
 Sun, 27 Apr 2025 23:41:54 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:41:54 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v3 17/20] util: Add coroutine backend for emscripten
Date: Mon, 28 Apr 2025 15:39:06 +0900
Message-ID: <006b683fd578ed6303a2dc8679094da9a7e6dfb4.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Emscripten does not support couroutine methods currently used by QEMU but
provides a coroutine implementation called "fiber". This commit introduces a
coroutine backend using fiber. Note that fiber does not support submitting
coroutines to other threads.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS           |   1 +
 util/coroutine-wasm.c | 127 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 util/coroutine-wasm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dde5fd2a79..750afd44c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -633,6 +633,7 @@ M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
 S: Maintained
 F: include/system/os-wasm.h
 F: os-wasm.c
+F: util/coroutine-wasm.c
 
 Alpha Machines
 --------------
diff --git a/util/coroutine-wasm.c b/util/coroutine-wasm.c
new file mode 100644
index 0000000000..cb1ec92509
--- /dev/null
+++ b/util/coroutine-wasm.c
@@ -0,0 +1,127 @@
+/*
+ * emscripten fiber coroutine initialization code
+ * based on coroutine-ucontext.c
+ *
+ * Copyright (C) 2006  Anthony Liguori <anthony@codemonkey.ws>
+ * Copyright (C) 2011  Kevin Wolf <kwolf@redhat.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.0 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/coroutine_int.h"
+#include "qemu/coroutine-tls.h"
+
+#include <emscripten/fiber.h>
+
+typedef struct {
+    Coroutine base;
+    void *stack;
+    size_t stack_size;
+
+    void *asyncify_stack;
+    size_t asyncify_stack_size;
+
+    CoroutineAction action;
+
+    emscripten_fiber_t fiber;
+} CoroutineEmscripten;
+
+/**
+ * Per-thread coroutine bookkeeping
+ */
+QEMU_DEFINE_STATIC_CO_TLS(Coroutine *, current);
+QEMU_DEFINE_STATIC_CO_TLS(CoroutineEmscripten *, leader);
+size_t leader_asyncify_stack_size = COROUTINE_STACK_SIZE;
+
+static void coroutine_trampoline(void *co_)
+{
+    Coroutine *co = co_;
+
+    while (true) {
+        co->entry(co->entry_arg);
+        qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
+    }
+}
+
+Coroutine *qemu_coroutine_new(void)
+{
+    CoroutineEmscripten *co;
+
+    co = g_malloc0(sizeof(*co));
+
+    co->stack_size = COROUTINE_STACK_SIZE;
+    co->stack = qemu_alloc_stack(&co->stack_size);
+
+    co->asyncify_stack_size = COROUTINE_STACK_SIZE;
+    co->asyncify_stack = g_malloc0(co->asyncify_stack_size);
+    emscripten_fiber_init(&co->fiber, coroutine_trampoline, &co->base,
+                          co->stack, co->stack_size, co->asyncify_stack,
+                          co->asyncify_stack_size);
+
+    return &co->base;
+}
+
+void qemu_coroutine_delete(Coroutine *co_)
+{
+    CoroutineEmscripten *co = DO_UPCAST(CoroutineEmscripten, base, co_);
+
+    qemu_free_stack(co->stack, co->stack_size);
+    g_free(co->asyncify_stack);
+    g_free(co);
+}
+
+CoroutineAction qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
+                      CoroutineAction action)
+{
+    CoroutineEmscripten *from = DO_UPCAST(CoroutineEmscripten, base, from_);
+    CoroutineEmscripten *to = DO_UPCAST(CoroutineEmscripten, base, to_);
+
+    set_current(to_);
+    to->action = action;
+    emscripten_fiber_swap(&from->fiber, &to->fiber);
+    return from->action;
+}
+
+Coroutine *qemu_coroutine_self(void)
+{
+    Coroutine *self = get_current();
+
+    if (!self) {
+        CoroutineEmscripten *leaderp = get_leader();
+        if (!leaderp) {
+            leaderp = g_malloc0(sizeof(*leaderp));
+            leaderp->asyncify_stack = g_malloc0(leader_asyncify_stack_size);
+            leaderp->asyncify_stack_size = leader_asyncify_stack_size;
+            emscripten_fiber_init_from_current_context(
+                &leaderp->fiber,
+                leaderp->asyncify_stack,
+                leaderp->asyncify_stack_size);
+            leaderp->stack = leaderp->fiber.stack_limit;
+            leaderp->stack_size =
+                leaderp->fiber.stack_base - leaderp->fiber.stack_limit;
+            set_leader(leaderp);
+        }
+        self = &leaderp->base;
+        set_current(self);
+    }
+    return self;
+}
+
+bool qemu_in_coroutine(void)
+{
+    Coroutine *self = get_current();
+
+    return self && self->caller;
+}
-- 
2.43.0


