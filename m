Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AD4CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNzs-0000A2-JF; Sat, 30 Aug 2025 12:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEUz-0008Va-HO
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:51:40 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEUx-0005kR-SB
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:51:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7722d6cc437so1233448b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756533094; x=1757137894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1ak1ZU/AR0+1y4HNoJj/qDB25/smzJJgjU2bzP6iSw=;
 b=UwjGaNhbb1bz3lMNrBfXQbc1M22tsZYfCVmHOY/psP2QES4Eg0viWo/cFxKorV6AzQ
 srMUWGeNs581WQoVEvqLtGMLw9jGg9ugUxZVyyI9IdeXVJTY0G33J6RocNO4rM1fa5yR
 rgchWLPaEX1Af9mCP0PPdg8obAgvBEzwarGA9PS4yTZvtQi54tqV9aX3ZYGyH92kJ+Qp
 D7M5rLlUxAeOJnKBzhkcS0VsVx45z+x0qfnyjryL+ZU/chqCdZBC+uZ4HMRRgSNdz8d/
 JeMp79LSgYirFzhlm3GOw1/jgH6EyUG7eDqQpdcyuKmo2Wq5yNAcmTuG3i3k8xUwl5Nr
 FBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756533094; x=1757137894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1ak1ZU/AR0+1y4HNoJj/qDB25/smzJJgjU2bzP6iSw=;
 b=ivYcJDpOGC2ZQYAOJuTncX4tfawipxu4I3pe74jjGXpU2NEupprtSekWfiKp8BqgAJ
 9c6i0EgUtQyD/lAT7P855R3yT7UeuSMx6OYRJUiRQBC4ypGlolZEc86iKcDe61yoqx9E
 z4pwGT32WfQX1gcBK43nnOmDhDMLaLiA+YMWs5qvfprNDUCKv6XFoeJPE1Smg4O57Nud
 MXxmWtoDDGAzE5ez7gTPfOpymckB0UeCQMI+Aedue4xbKFTI8Dad8rIg3QIZruWjT11/
 rA//fJIO/aUmcDMm7UbXbGe2qqQ9I30DFw6kl0oY42LTcL54hV43/SHmuJoxcFLOwRie
 CcJg==
X-Gm-Message-State: AOJu0Yxy5MD3tchwcTzVRBHV1hJSjabH6s2xI89/mSrEcMTt/60NHUc8
 /shgZO77o1j5UCJ3zcGqtrnJxPBiIVcXd3nJhNd2crN/OGxTBn8AioA+6ylWoShfLRa+0IlEysb
 QnEpLeKM=
X-Gm-Gg: ASbGnctaArdGYRprlTLWnKNgpF0METR/qOwkXM+y4QYzd+XNre+ewCmY9AnsNWOEfwd
 CE9LEDryFcIi2t9Ikqs/vY77t3uWzg9CjPLEZ7lr9pScBdRI6sG7EyGq4NbmX5itVUitIQ/ayUG
 H12rryxQ3X/g8rtd9XPWfUQglNI9bcdfjvQZ9HWwqF6SMkN3Lx5GBwJhR4NIBYjr4UWKzpkTCvp
 z79Leb6ioneI33zkaGTGauC7Twbfz/5Avmhb8rj/YUyYIMdRab9LDhAhtGvd4AI62PX0mxdKlGe
 FgD0irS1tve2VSx+2RXehMlTqgIU27l32GFnBS3pTaVgjcDjmnhF8KhOUhqDktgefHqAiLUJ1tI
 dgUV2GBLMw2Ijt0TRO3yLRr9GcZ/6ZHHLzjLAoangeE85fvrd4Hnis9HJqdmRLUV0Eil1SfvGe4
 +JjD/1rw==
X-Google-Smtp-Source: AGHT+IES2RaBv1ArD50wML2GJ64TXKFFhPNOkZ9drEUGnKjBtxe1oAJGtvMHelp/yPRqATUqF/A4Mw==
X-Received: by 2002:a05:6a00:8904:b0:746:195b:bf1c with SMTP id
 d2e1a72fcca58-7723c50237dmr1586766b3a.10.1756533094526; 
 Fri, 29 Aug 2025 22:51:34 -0700 (PDT)
Received: from stoup.. (122-150-204-64.dyn.ip.vocus.au. [122.150.204.64])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a2b7d10sm4198475b3a.33.2025.08.29.22.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:51:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 84/84] tests/tcg/aarch64: Add gcsss
Date: Sat, 30 Aug 2025 15:41:28 +1000
Message-ID: <20250830054128.448363-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


