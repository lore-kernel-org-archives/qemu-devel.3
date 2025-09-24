Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956AFCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UqY-0002Tv-4m; Wed, 24 Sep 2025 15:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UmC-00071m-Bn
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:42 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uk8-0007tc-Bu
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-26e68904f0eso1685065ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740482; x=1759345282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qa2sDKUiUC20wAaM6+SQbaSw+0i5rndYlOzgzIF1jc8=;
 b=dOtNuENRZkrA9wWPs/jsFj35bVO5sHSOFlCytRTPlKjQ45Segep0rVPqhYeN2mmk6O
 KyT1FyZmKWOFhrmYWqJWlziq55Efs2eD2eQ9ABTf8znNfQUQmTAQZhRnircp29i3lrcb
 TaeguLjMurOiHfnvfJRvLoUsjv6Gq9e7/IcY3iAqCTfwQ4IsE5No4lXTcF9FzOtgnmN+
 BDbh4BD8opXCueJhmpQUIkM9mTv1j17IIoo7394US5KaEXSxioAssIJq3nxVp4/99m4N
 4PM1h/nUkgiCz7kye0U5EKcOVs0KOAIRdYUoLnOf1s8jUq2W87R+PemDx3/Mep/qqJDo
 LtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740482; x=1759345282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qa2sDKUiUC20wAaM6+SQbaSw+0i5rndYlOzgzIF1jc8=;
 b=ssfRgXuyJyO1vt5Ujn9CceBgyvDJgXALVsdGmWDT4sK6O8QDFtAHCqsjCSNiWK5J6M
 bmCebwVuY4QSGZUglMagL0ACHo3gzVcwRzGULYgNS5gq7J0nwR9sMCOKtfSpfpzCtr0h
 AeVi6b7ubGXNoAwV77+Z7TxcjCwcDRPLSGzcfggoDqA/vl8UJ7hEafEU6WC+7+eP2pBR
 opZi3Gyqk0Op2AzU96ZpaGoOLzWMjB5vuJIzG49szNY5AqcMWJJbSIDXjDWxLuFocvzl
 quvA8nCo3emBtrQBBTtRKfdgEvWkW0GJJk3blo7emyJJ7NdUCnJ/9VAPOMjjBI6ZO/7X
 Kycw==
X-Gm-Message-State: AOJu0Yy0NoPCj6cXK6HiXoLujeabUbPeB9zsbTFcpkwS0YVyNvn4IJUO
 2qYw3wa/nll22L0WOgWmxambtwaKjdwzkNJPUM75tvnzG+u7MelMtm8XmBvzgcIwLUSnfFTBIdn
 BS5Zh
X-Gm-Gg: ASbGncu4M0d44jz28JJZRUrS65a840zpNhZZ5QbN5SdlbvbD2tr/uWX6dT5C5en9uAa
 qvdL3ozfdxVxE4Eviw/7jmMy23vH64QuZtZfodYSh5ULXzW1vvWmvwKRZWqgFxMyXH/whsdOEvb
 hoG4X9nOXOt7vtoh7vbfi7hRVSJlzD0M/KsbCSalHfxMr3Ht5huc+aX8rC2n3TMLevcmPpRiYiK
 tsNUncTeuqvEBoBKPuglCoFyhttoXmobMNFQpxD1WybnSlydA21XFKXjFHc2IzqS/tbpGuh8NAW
 n8Htuj1X2wj3fMSmBPf6mJmfKyj8v8lVS8Kk1nE3D47+gRGkx+svVWe2sw3MYFh8kqwxAMABn1G
 EMwGfldtEkcwM+xLIJ6FnGKQCcU65
X-Google-Smtp-Source: AGHT+IFWga0YPa43HWu3lzRfrpX8ucM3rGOA6o9I2YrWLYeUlTEaEyMd9qPyYK0EA1gcDg9m0/nZ0w==
X-Received: by 2002:a17:902:cf42:b0:267:95ad:8cb8 with SMTP id
 d9443c01a7336-27ed4a96047mr7033055ad.44.1758740482418; 
 Wed, 24 Sep 2025 12:01:22 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/32] tests/tcg/multiarch: Add tb-link test
Date: Wed, 24 Sep 2025 12:00:53 -0700
Message-ID: <20250924190106.7089-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/tb-link.c       | 67 +++++++++++++++++++++++++++++
 tests/tcg/multiarch/Makefile.target |  2 +
 2 files changed, 69 insertions(+)
 create mode 100644 tests/tcg/multiarch/tb-link.c

diff --git a/tests/tcg/multiarch/tb-link.c b/tests/tcg/multiarch/tb-link.c
new file mode 100644
index 0000000000..4e40306fa1
--- /dev/null
+++ b/tests/tcg/multiarch/tb-link.c
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Verify that a single TB spin-loop is properly invalidated,
+ * releasing the thread from the spin-loop.
+ */
+
+#include <assert.h>
+#include <sys/mman.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <sched.h>
+
+
+#ifdef __x86_64__
+#define READY   0x000047c6      /* movb $0,0(%rdi) */
+#define LOOP    0xfceb9090      /* 1: nop*2; jmp 1b */
+#define RETURN  0x909090c3      /* ret; nop*3 */
+#define NOP     0x90909090      /* nop*4 */
+#elif defined(__aarch64__)
+#define READY   0x3900001f      /* strb wzr,[x0] */
+#define LOOP    0x14000000      /* b . */
+#define RETURN  0xd65f03c0      /* ret */
+#define NOP     0xd503201f      /* nop */
+#elif defined(__riscv)
+#define READY   0x00050023      /* sb zero, (a0) */
+#define LOOP    0x0000006f      /* jal zero, #0 */
+#define RETURN  0x00008067      /* jalr zero, ra, 0 */
+#define NOP     0x00000013      /* nop */
+#endif
+
+
+int main()
+{
+#ifdef READY
+    int tmp;
+    pthread_t thread_id;
+    bool hold = true;
+    uint32_t *buf;
+
+    buf = mmap(NULL, 3 * sizeof(uint32_t),
+               PROT_READ | PROT_WRITE | PROT_EXEC,
+               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    assert(buf != MAP_FAILED);
+
+    buf[0] = READY;
+    buf[1] = LOOP;
+    buf[2] = RETURN;
+
+    alarm(2);
+
+    tmp = pthread_create(&thread_id, NULL, (void *(*)(void *))buf, &hold);
+    assert(tmp == 0);
+
+    while (hold) {
+        sched_yield();
+    }
+
+    buf[1] = NOP;
+    __builtin___clear_cache(&buf[1], &buf[2]);
+
+    tmp = pthread_join(thread_id, NULL);
+    assert(tmp == 0);
+#endif
+    return 0;
+}
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 8dc65d7a06..f5b4d2b813 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -46,6 +46,8 @@ vma-pthread: LDFLAGS+=-pthread
 sigreturn-sigmask: CFLAGS+=-pthread
 sigreturn-sigmask: LDFLAGS+=-pthread
 
+tb-link: LDFLAGS+=-lpthread
+
 # GCC versions 12/13/14/15 at least incorrectly complain about
 # "'SHA1Transform' reading 64 bytes from a region of size 0"; see the gcc bug
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106709
-- 
2.43.0


