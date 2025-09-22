Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FF7CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ljH-0002qP-Fv; Mon, 22 Sep 2025 14:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lga-0006EM-8I
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:54 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfY-00053u-6V
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:51 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b5512bffbfaso4264536a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567226; x=1759172026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CvJSXdiWhbprsJzICEFPWeYtoNE9+mbwDhHlNPU7kM=;
 b=moC7dobDRaaxwjYpGVXVfUmGMmQZd0e/+z8KYu7Q4zJha3PHCT7Q6itGMs/mdQKy04
 ykuUUg0kttTqpcJetHOpta7hH4+FgMhCDRjfHE3qVtY5QyxiqZZgeAxQF/DNRs7EV27r
 QJmicYSmD5JnpnpQ4WqT1iwksT8dnqLwWrbLDPqADAewghqKN8QAUIMd3lr0VViLTYnh
 KEbw4kFMwMtZDRTBZkFiOM6aQPxBR6ICQBO2MvIte3YieAm/2C3VF3qGzW4SvSgO7NBA
 35xZSIiNmeKZTCFT2382wQ7pO6C2XJDF06MyFtAFJYQ0f9t3GapnZId44jiqPxwF/BDM
 LcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567226; x=1759172026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CvJSXdiWhbprsJzICEFPWeYtoNE9+mbwDhHlNPU7kM=;
 b=dzcrbyPq0hC8/UFLh01S2+xHYdy2EcGXOS3trstSrRuwjnxngyHX8+WDd5aS7nOK8t
 FIrVx5iKHJdVNw+8BAFtL5R5F0P13/DO3sMw9Nqv8YZSxQqJkzP6vwON4B3hMkNlpvUr
 ZTerO3dCngCZfwspdT2w8WKQgSTbejGqxhuKDKraI53s0eo7OFjezRldz9D8fiW829GW
 xS1RZrOL+XLov3sy5qE4+/1Dys+EQPgOk6/G6wsHQgjNgfVYtsXyR432K3jgoK8q3mOF
 duEMvhPeyVfhygmNUAuGz8+qngAXewx8iTJYaYNsSgGBbZ1YxPY030grKGkRshFFEsSw
 K8cQ==
X-Gm-Message-State: AOJu0Yw+gWRLT7lr7PvdeDY1fEeu8QF7uU4tJlKjyG7o0/l0V+e+1zpY
 D5i4BpVU2FwCCa5fuTnzomY9ROPfdojABPdzgAzYcqSHYY1kx/tb2/RvwiSV9ziooYZO7PdGcyd
 a0B2I
X-Gm-Gg: ASbGncuyLBV7crCnZWbANEocg/CRtycjYsRseee8j2TDdGUa1BbVWrs0AuXNZYrtzhY
 CCkIXJqUgA6Fa3ylS6MLFwVUS7vYsn7Z3JCtk5JlxhAvQxQk5AJpc56ENSaaZMNLNrav2WU2Vcm
 rsLhfl7n9+191BfsnZHl5yam1SgeiMqAEGdEQkT70qVbcTQ3c818vVz/O0IkWjBRj4jDve8h/hV
 BOShfIQ0irCiIMnPVArzuRkNsHVuj5CKjy7EgtTTA8fdkgdFXf+ibYrWAAGSq+PCrSd5bIs1C5a
 aAIE5CdfcjZmYi8JFNgu4gxObwDVWQ0v7xa57ubAtVEF/8sAcaGzJOJ6pzmMxau7rpxlpqvwW0l
 6oUeO2aBePpw0bQ5Yy5KZHtlsBdw3
X-Google-Smtp-Source: AGHT+IF2x+qiyjIjYIwD42/r8yX6ivjTvn2+lUHWTUGcC3Z1o6cpVa0xTyE9bV7vgURRdUNKQOlc6g==
X-Received: by 2002:a17:903:2285:b0:269:d978:7ec0 with SMTP id
 d9443c01a7336-269d9788368mr163743025ad.28.1758567225974; 
 Mon, 22 Sep 2025 11:53:45 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 76/76] tests/tcg/aarch64: Add gcsss
Date: Mon, 22 Sep 2025 11:49:24 -0700
Message-ID: <20250922184924.2754205-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index fddb7bc9cd..55ce34e45e 100644
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


