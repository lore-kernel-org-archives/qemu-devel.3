Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AB1C87FD1
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwUD-00033G-6t; Sun, 27 Jul 2025 04:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwSu-0000Cb-Ta
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:10:41 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwSs-0005RI-2w
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:10:40 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b3be5c0eb99so2982856a12.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603836; x=1754208636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMsWiUAscqE67euLD5nK2idOuvJcvFXzap5kwHEFlqU=;
 b=gcc1hXSRbytpgeNBMdPzowqlBbYE1wN+Bx7/sac9wNlo1OxaUGX1f7B1OSO+hJNoUP
 QwG/ssaZq+RdIfYLwQTNXnFAfqizf9yJAZhs53IA/o6O6Gz736sI9v03ThqkSfJLn/KH
 l7rHRbpIVLpsZ3ortf/ulnN5ruRqIrXe5mk10Kppgx8Ag9nqmnO40J2Zg4mDH0osQHsr
 mW2l6lCo3BKUha4LV2+lOojwtxlTpbcZRB1t44KkLh7TKghl8SWSZcfMn+29en0cYw8K
 k+tWU/q/NTH6/G0RmaCYeTtQdrBi7WYEe0f43on3GmqE5QMiv1+9djj07uPraQCprWOC
 VhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603836; x=1754208636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMsWiUAscqE67euLD5nK2idOuvJcvFXzap5kwHEFlqU=;
 b=wP83huBtq4bHYvFHA8pXH4Ohh1bgIeGM68umqb+E3UgQ5W918jj72Fl/cd/njYq2Wo
 GW5IBf1C8zdCmX76nD9N3cI58qvVl/jnZSpHD8zadUIwYcFW31bqraCTuix2mwRZsV3v
 AjpLfh6bRaomQQmIB0VFL4rzmN4WNHaGItG4lXk7MGQ5ECrkkV4O7EMl6c8VAnZkKNZc
 P5tVUWfxEVWAGPllD16JqFlKTrFyCggxan2qlaRJiP4IyDQm46tcSsWznlLcr/33SUcA
 wmbnV62J6fwQBLWxk+3gzzP2ZkggY8AeOyxl2ULDHPn09VQPOFF9YyC2Hyg6o+24RK3y
 xdIA==
X-Gm-Message-State: AOJu0YwzH2tDe3hZEz89SJ7D6f7XOUaGP2Ckj3rMZ2kWcUb3nbZhqAaN
 e4wPT0ntMnsigFRva5sVc+fqBt1irjvEZ2p35JGUEQmBW91x+Rcy8R8jph1I6CPztHLT5S0HXTf
 Cfa7M
X-Gm-Gg: ASbGncvZ+GJLdlSGbGxY+O6mBZvu246TmltGRZ3QUA9sYYdu/fok7Xqpge8QQ+CXQcW
 9/1VqghL4TXVqQwJML8TbFA7ZVMiLkIIkOSKdUH+WN9KR+UVFtlJ5+O7fx9IhBZt1u2I1dMYI1i
 TxjSc2NzrN+GIt6YmD5Vbv0G82tNDfhs3edrNYtslPgo03ANUqCEfyyOCsM34ylXoydcS/Y9uIk
 LdfUAv+lVWkrEPCcVZyg4F/bgRaO3514HBxF6okZKbD9OWe/wqeexjgCFdN2U8hPekTyN6hhNIE
 9Jl/RoPu72W8z3CpG1wH+vLR4J2qEDFvh+E8sxkx1UvvbUmW0vofz25DctNEBw1zj4F3Rb7yPDs
 nY+1sdiDbcFYACUm4abozfHi3xu8kfHiJS3oSvphlfCWqDv230Y3nL8GHwL+B6wxCRpSqHz5oQg
 lsvcPSR9vZDw==
X-Google-Smtp-Source: AGHT+IG6AZ1qJKcy+gdYGTYkFJTh1MTpuko1sMXaVVJn5VbtN+ITUpnR5Qr9Xd+jmDVvII519Haeeg==
X-Received: by 2002:a05:6a20:3ca1:b0:21f:5aa1:3102 with SMTP id
 adf61e73a8af0-23d70189e0emr12212839637.37.1753603835960; 
 Sun, 27 Jul 2025 01:10:35 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76408c0271csm3085491b3a.49.2025.07.27.01.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:10:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 82/82] tests/tcg/aarch64: Add gcsss
Date: Sat, 26 Jul 2025 22:02:54 -1000
Message-ID: <20250727080254.83840-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Validate stack switching and recursion depth.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/gcs.h           |  9 ++++
 tests/tcg/aarch64/gcsss.c         | 74 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gcsss.c

diff --git a/tests/tcg/aarch64/gcs.h b/tests/tcg/aarch64/gcs.h
index 99cb4d4e38..e821963cb8 100644
--- a/tests/tcg/aarch64/gcs.h
+++ b/tests/tcg/aarch64/gcs.h
@@ -69,3 +69,12 @@
 
 #define gcspr() \
     ({ uint64_t *r; asm volatile("mrs %0, s3_3_c2_c5_1" : "=r"(r)); r; })
+
+#define gcsss1(val) \
+    do {                                                                     \
+        asm volatile("sys #3, c7, c7, #2, %0" : : "r"(val) : "memory");      \
+    } while (0)
+
+#define gcsss2() \
+    ({ uint64_t *r;                                                          \
+       asm volatile("sysl %0, #3, c7, c7, #3" : "=r"(r) : : "memory"); r; })
diff --git a/tests/tcg/aarch64/gcsss.c b/tests/tcg/aarch64/gcsss.c
new file mode 100644
index 0000000000..9550c68e7e
--- /dev/null
+++ b/tests/tcg/aarch64/gcsss.c
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "gcs.h"
+
+#define IN_PROGRESS(X)  ((uint64_t)(X) | 5)
+#define CAP(X)          (((uint64_t)(X) & ~0xfff) + 1)
+
+static uint64_t * __attribute__((noinline)) recurse(size_t index)
+{
+    if (index == 0) {
+        return gcspr();
+    }
+    return recurse(index - 1);
+}
+
+int main()
+{
+    void *tmp;
+    uint64_t *alt_stack, *alt_cap;
+    uint64_t *orig_pr, *orig_cap;
+    uint64_t *bottom;
+    size_t pagesize = getpagesize();
+    size_t words;
+
+    enable_gcs(0);
+    orig_pr = gcspr();
+
+    /* Allocate a guard page before and after. */
+    tmp = mmap(0, 3 * pagesize, PROT_NONE, MAP_ANON | MAP_PRIVATE, -1, 0);
+    assert(tmp != MAP_FAILED);
+
+    /* map_shadow_stack won't replace existing mappings */
+    munmap(tmp + pagesize, pagesize);
+
+    /* Allocate a new stack between the guards. */
+    alt_stack = (uint64_t *)
+        syscall(__NR_map_shadow_stack, tmp + pagesize, pagesize,
+                SHADOW_STACK_SET_TOKEN);
+    assert(alt_stack == tmp + pagesize);
+
+    words = pagesize / 8;
+    alt_cap = alt_stack + words - 1;
+
+    /* SHADOW_STACK_SET_TOKEN set the cap. */
+    assert(*alt_cap == CAP(alt_cap));
+
+    /* Swap to the alt stack, one step at a time. */
+    gcsss1(alt_cap);
+
+    assert(gcspr() == alt_cap);
+    assert(*alt_cap == IN_PROGRESS(orig_pr));
+
+    orig_cap = gcsss2();
+
+    assert(orig_cap == orig_pr - 1);
+    assert(*orig_cap == CAP(orig_cap));
+    assert(gcspr() == alt_stack + words);
+
+    /* We should be able to use the whole stack. */
+    bottom = recurse(words - 1);
+    assert(bottom == alt_stack);
+
+    /* We should be back where we started. */
+    assert(gcspr() == alt_stack + words);
+
+    /* Swap back to the original stack. */
+    gcsss1(orig_cap);
+    tmp = gcsss2();
+
+    assert(gcspr() == orig_pr);
+    assert(tmp == alt_cap);
+
+    exit(0);
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index c6f401c317..b858f8692e 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -76,7 +76,7 @@ $(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # GCS Tests
-GCS_TESTS += gcsstr gcspushm
+GCS_TESTS += gcsstr gcspushm gcsss
 AARCH64_TESTS += $(GCS_TESTS)
 $(GCS_TESTS): gcs.h
 
-- 
2.43.0


