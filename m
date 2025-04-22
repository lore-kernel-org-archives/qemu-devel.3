Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CC0C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76GM-0008PF-6z; Tue, 22 Apr 2025 01:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76D5-0002zj-8k; Tue, 22 Apr 2025 01:30:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76D2-0008BP-ME; Tue, 22 Apr 2025 01:30:18 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224100e9a5cso54472365ad.2; 
 Mon, 21 Apr 2025 22:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299814; x=1745904614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZJBhCTsN3O6Lx1qPX+scfds1YZkk4ZSjoc7nql2Rf8=;
 b=hELil73mVeg4x9E8r9ZojkZLpuJ3RMxJXcgrLpXR9kb9fVbCNj2VpAV1KEaM74YVKl
 w2BegkYTCl3hm7r8Wu6S7W6G29m+x+WmO9OB67VHtGlb/oZA6OSL2ODhguqlYhf0S2EK
 xJ02iNwdFhCtSfiq0EqAuuwKeaBJ/5632sFIaIOg82+PMeY4+h9sJvhDuqwKNO4x0uP8
 sIezA4Gd/Dcykc94ZW+mD9I7sBWWZLAT0cfdjWTGWo80KceJof22OGCTaTngTVDdORzo
 tc/X9Z5INpZP1mrmWEG1yLRFFSM5H01OgmRA87KMH5pq8wJhf+JdP7zkL4Yx9+LLxBDi
 yqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299814; x=1745904614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZJBhCTsN3O6Lx1qPX+scfds1YZkk4ZSjoc7nql2Rf8=;
 b=mGP4+O+0Vzs4euc2eWZuadQ2xfxVOrFypnK/Wm0aqAisECNNKN4IMbT5cH1pOytoEO
 NhvcYl/bgxxXIziXMIAyB31V1fAYaMnpN5BiLY4tDEg4saXphtqNBpfOjY0Zrn2Tw9Kh
 U/0PEYe6xyR+PU93+cABW8s3lS5FDomT2lbe9TUInwgahRyDYwHLzdadJ91bszRNg9Ae
 /JGBbLbTNa9vV0FWdyrZuRgoEPcOXgYng5shEtYF+ZVF0TMP0QDTg+NTh+PICAYJR77p
 z9hP3iTTDCa4HHNpTFc6l/cXt7QT94wCxvp6VSjtY9EjIi+FOViYKuTQobJUEwEYuukK
 5KTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN6gxhYbCJDbq62P/CFi42OMo15lahBfoNF4aNTKvJaOORdHMAoAPG9+LDfrio05ChEAR2wdubLpo=@nongnu.org,
 AJvYcCWVLdVUpo9xP7w+aqjstdyV2uPbSx/ZSb3s0tP9fsdgc4mts0fUqZOuFlnDZr/3l6ZnY+Eh61N+L2AuFA==@nongnu.org,
 AJvYcCWgumN4ULBDWW7GmJAQYSjmOj52XwrHqTMl6LN5WWGvOsF17Wpw0XltA8HkO3hpJRhn6vS4LbiAAw==@nongnu.org,
 AJvYcCXs/VjKYwaOBAth/hlGVHX+76gfvsWVK1J01rACKw5X8buYwJ1CVe0mVb3+2is0r8HVCjwAVQO4RKovPg==@nongnu.org
X-Gm-Message-State: AOJu0Yz8dGeiisIYX9J26TsVW8FyZC+CK6mbtDILa16jrMAfZekrUC+i
 +B2sQz2rgvz5pNEaEJgJ6Hd0iQIB9DgY9/zHASe6/vi4xJc+3irRMCsV2G7D
X-Gm-Gg: ASbGncsWiMHW7MDwUS30CNlFv/RgMeMS3t0JGQidmQLOHYnc2BirR+klZVKnHnQL1Vh
 5lyX4Zk8hq9xUNGlgbO92GtJ2WiFUQZWGT8pFNXPEiKc4XSDcv+WYfBu79o7OP+onOW5rNynNEy
 ftCAO569ee9v35i1+pD0++ftayFgfm+AE7i1VinCwixPAk7EQMzYB+NCwnrVSNwBPpbF2u4Lxeq
 nMq2opvDdBV8g89dT/xgUqwlFxNQqdlxEPQzwDCIalqqr3/i/7uA2uBq2NAXzOYoYB9BfaBxyYz
 UnIrFBHP1OCMmV+5DsGLaQHZ7Qw4bYCfifdjk02DKQz8RgsZO5VZesknCo0=
X-Google-Smtp-Source: AGHT+IFSt/tJV0CpnE6V2hLouTHQ6ku88AMsbKVeVRMXeP3Flg699MixtrSFkbPBDLaSqOsNQluUDg==
X-Received: by 2002:a17:902:ebc3:b0:220:e63c:5aff with SMTP id
 d9443c01a7336-22c5361b3e7mr198582405ad.47.1745299813562; 
 Mon, 21 Apr 2025 22:30:13 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:30:12 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
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
Subject: [PATCH v2 17/20] util: Add coroutine backend for emscripten
Date: Tue, 22 Apr 2025 14:27:21 +0900
Message-Id: <82afa4d287a16f89fa59f08cba14fb06e017ea83.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x629.google.com
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
---
 MAINTAINERS           |   1 +
 util/coroutine-wasm.c | 127 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 util/coroutine-wasm.c

V2:
- Split the MAINTAINERS file change that adds coroutine-wasm.c from the
  previous 19th patch into this commit.

diff --git a/MAINTAINERS b/MAINTAINERS
index c7a20ac8d7..72319f804e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -624,6 +624,7 @@ M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
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
2.25.1


