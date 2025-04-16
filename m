Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463D3C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xzy-00067W-FA; Wed, 16 Apr 2025 04:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xxJ-0002Xl-3G; Wed, 16 Apr 2025 04:17:29 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xxG-0005ye-C1; Wed, 16 Apr 2025 04:17:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223fb0f619dso70489485ad.1; 
 Wed, 16 Apr 2025 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791427; x=1745396227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIbAMZeonD1y/THuAvolLW7txmOpN+fF9GLLZzGqdZQ=;
 b=J/a+dx+JDpy+x8eWyQwXDmNCJ4+LX4g7/bvCenpJO6zsPIqtV+H/28k0kTv8WIhbxa
 Msfl787l8FwOTPa0x9qasqQ0gbTCnVsO12tghR3dWpkeH1prUEqmzxAOwr9ctGDfmJyE
 3b0Pc186N8c54tGgDsvSjH69FxTHOM7zY9NxnN7LEC1yJTKfPJXOhhGJLbLSotmxR3km
 ggoqU+wVV7DmWQGKRnsnW1n+EEeCrkyFBAJDom7fpGBHbac2kBZ4pwkKnt4+jrDT0BOr
 b3MVdRvxmC3uViWMLwJZ1KpP+OhHEDfiNW87rWR/c1X5CStQ8Tb2ADWZ1SfhzXqiy471
 jRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791427; x=1745396227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIbAMZeonD1y/THuAvolLW7txmOpN+fF9GLLZzGqdZQ=;
 b=XAMBAoSlNlPyi3F04I9ahiJ5FBbDNddPiDDy0X1FUbbhHpGARcRxlZJfd+6RQ5bBN4
 rQ2vpF6VJ4hWi1qWwuhk0kutgxf60eTJqRE27HQQG383LrlaVEWnVZcVHcqalY1oDWcM
 hbTmO8aFlAyrCs7ZlYxIeYC1DyDoHNvWdlFFj32oUoNLLyVf8catis9oPUx9ZTxGXSSo
 FBY2ljCaE6vKiV/LuHVNn7sJBjvynVoMOwGSo4xzW88hA76kH2/7iVEKzhLq89XZKbQw
 /BQdz6f1oJsFpzkBfxN1TSAaMdMmY+CVg1dB9lT0Ccka1l2DEmHYULcFSn4xdtam8Csp
 1FZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV//IyruN3q0KxvMGjQU0xhixoF7UHO+CPTyAiWN5jlkB8BWisKcSKJRRZvQWePMf/M66/z/N8mkjzxLQ==@nongnu.org,
 AJvYcCVUKyuMqxuX92DB8m32rf9qYEGcT5n7iJ9CNOKIB+D5yJfrAvacMziu27QQpqj3xYL7iuRxmbY1+o4=@nongnu.org,
 AJvYcCWijqgLNk2s0MKVDObAnczwE9aWjoaSLCnLKFYQ2tkOcXPvFAuOHa4x/XuBP5IAQd+bHBV2xkGgCA==@nongnu.org,
 AJvYcCXOLfAioAemkqobYc8ZQ1xDoYUKn1wQ/m2mGZDlqhTnD52OEm3EcMdjunhHu05nm8VeJhbkuiPsyEyFkw==@nongnu.org
X-Gm-Message-State: AOJu0YxaA6aG8e9wjLbN5R3bcq/XvdSH+b8e6Hy5Q+LlFKQ7ZdcUz+Tw
 1xBfl3euhvJP9tHYAew2j2XKFna9pdaJdJC0brQ1RcZcsoBJpgut7j/RsANL
X-Gm-Gg: ASbGncslSF36zWQqoVZbd3S5FPC5zqGmnVRmDoywEwCy4i9ScM65PIT4BJAmSnanG/p
 /DwXhLfpdr8QJcZS2Tko4rZ+JqTLQoRiiwZgn8piMy3iy1VWPAi4Mqax67SNEeLKt1djuAf/unl
 8skNQ1NUSn4lqiUOfKMVWCrJUNdpURHrslm//GJr6qTUKAsNFL/obXEFIXQoMWKIxFOXn7NSmfr
 LUeU7eqUxX0mdKhZqvFyGlFCIVr452DFnf5i+sxopi9YOhoj+6d8O+TOvJNVik3hc1Pxy74cW5d
 sln4vifLyKPYggKHcLrEMJ4nGP4K6l3xBVegHhz6Fxj2NdIGfDKO+A3DQg==
X-Google-Smtp-Source: AGHT+IFYdhSnB9zITJ1aITjDAOjnlnlic7rRWk+WIB51c/0DcssgTKezLLv7xrxaBupxkzncoPYm3w==
X-Received: by 2002:a17:902:ef01:b0:223:517c:bfa1 with SMTP id
 d9443c01a7336-22c3597ec25mr17871905ad.38.1744791426992; 
 Wed, 16 Apr 2025 01:17:06 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:17:06 -0700 (PDT)
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
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 16/19] util: Add coroutine backend for emscripten
Date: Wed, 16 Apr 2025 17:14:21 +0900
Message-Id: <f89c3ddfcb3d1fe04781ac1b1ed94f3feec8601d.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x630.google.com
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
 util/coroutine-wasm.c | 127 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 util/coroutine-wasm.c

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


