Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66551C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oBu-0003MS-Jw; Mon, 07 Apr 2025 11:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nlh-00027c-DN; Mon, 07 Apr 2025 10:48:11 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nle-0001fo-Qb; Mon, 07 Apr 2025 10:48:08 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-af241f0a4beso3664432a12.2; 
 Mon, 07 Apr 2025 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744037284; x=1744642084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/vXoOU9/WH6B8z0Pp6XgozbGmRLjl1o39LJP8NE6XY=;
 b=V55PK0ayEZZPdr6tJvJ2UexOv6oasowMOWVoaGxPcR4xEWcCP4UX1A02rud0GOgB+L
 4F563XazQd7V9HxLb1n6d7NmaCnGgm11K4fT4M/BwBiUBKzDNZNjJy8Ho4ux3cyGncTm
 FesZErZ9R/iOB37z3iLvetF+ZD6Nhrq2MuyFNbLTeHvKRYL+Vv1r7nM/Z4s1rHwDGtQE
 0uSAybyNqQxp+y2JwxiyyYj6hdiio77X8El9UxJi8ocqswIcY7TnYWWGBl1gkp8AYenk
 GjWpVAZV3Kwxq0uDrLOUQ8o6EWNi6hnjBiJDTFsbAedqlw4QozH1nVWIh3zMYdpcgvk7
 aoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037284; x=1744642084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/vXoOU9/WH6B8z0Pp6XgozbGmRLjl1o39LJP8NE6XY=;
 b=JR2lAaV4UB9/WCmR4ynYyOx0XC1f6IiMXqHYCs5IV8rNIJyn1BmyVJHvTbF0WMTdRy
 4Dfu+/ZqRGEFP5oEWtaNXz6YIUoQ5bl8sNvTtrKStRBNDLRDE9d+5ro6RS1PBqErzmUL
 TS0zJUOcfbTegKeweFe4Uh1DRrt54IWCTleR+YX37ZZDiKa4tuvv+he1cvCFbL2WVUqJ
 /cpLi7bQrGHtcfXZId27luBf3RlViZYow/hdIGVf6AN48r1sw/0s8JbvVGyElYDAkLBj
 BFOvhaFlvSyTGevNAlKfdx7Zi1mYtJdQdLTf00qYoTt+MQ9OIQQahB8R7CBxd8KK2f0M
 R22A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX/nuqE+6mzKYRh5IFT50GXBvPgD5/NZYgu00cQAuBRsrhC2mi/iL4pjh/1aJK844l5vOC/ijA2w==@nongnu.org,
 AJvYcCXLQgWe/eTy8aMkWfKI30fUF5gw+oeu8ODRrnMBqEHM785M/44+ZEMQ3lWQRe2/1ks+FWLELGthZglXOg==@nongnu.org,
 AJvYcCXznCK/cl7t+1W2ve9aYBoPKybOW/jAdeEM0etyyBsmqJWCt8ThMN3rGM+9nJFjAel/CtZIPrKny7bVCw==@nongnu.org
X-Gm-Message-State: AOJu0Yz5kp8PyFFKPr0gc49gNRHo5m2akFvegeol4Rx0vylTp4K8Xj44
 sPTE/i/q5TknQFvoTMBtDXOZNVb+efWbczMTr0/aCyfww5Q6JcPpW8CEw+qW
X-Gm-Gg: ASbGncvxiet70KcN7AofBa93JGc3I1WXNoP/gLa1bvR6NXfIctdbETbE/P3QCGrsJGr
 +kcwg2euwpvMYbeQ72LnVwCrTNcCa6W4gjo138XlpBj1qq8yy+XmRDZvfoIJGKbyHfWmyHn3iFj
 0UnKAb+SE+AjqHOIfjG19yqqaFlDSF1j5GK0pO6GFlopzt+gzOGkqsMdTBofCtuELD1xWBvkcKS
 fJCDsrzuAIkuHOd32zo2BJj7JZ1WL/N4/+ihUpLMyHCbKXOK53rUe4VtN6YMSZcMG+vD9MDjSza
 ZJNgspcKpumhg5ZqXMCNfcztSS2mIMWuW9svLPhBrXeczYDtFhofhKozcMmwJQ==
X-Google-Smtp-Source: AGHT+IGVX4WZdwjz8t2px+L/u1IusGGhdA+M9JnGeDomm+fX2PtXqK/fd/imZowOMFEYatlfbwDLfA==
X-Received: by 2002:a17:902:e749:b0:224:13a4:d61e with SMTP id
 d9443c01a7336-22a8a8d31e9mr167348655ad.51.1744037284265; 
 Mon, 07 Apr 2025 07:48:04 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:8768:486:6a8e:e855])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ef3c2sm8856960b3a.59.2025.04.07.07.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:48:03 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 04/10] util: Add coroutine backend for emscripten
Date: Mon,  7 Apr 2025 23:45:55 +0900
Message-Id: <b6b8274b7dae5f3e4ee12c1d20cf9c329dd350bf.1744032780.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744032780.git.ktokunaga.mail@gmail.com>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Apr 2025 11:14:07 -0400
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
 util/coroutine-fiber.c | 127 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 util/coroutine-fiber.c

diff --git a/util/coroutine-fiber.c b/util/coroutine-fiber.c
new file mode 100644
index 0000000000..cb1ec92509
--- /dev/null
+++ b/util/coroutine-fiber.c
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


