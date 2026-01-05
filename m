Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F0DC79FB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcp7a-0001AQ-C4; Mon, 05 Jan 2026 13:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7T-00017K-J0
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:57 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7P-00037O-CW
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:54 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8b2d6df99c5so224234785a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767636941; x=1768241741; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ons3pkeG+AVih1XQoRu6SV66GeauT557hqhIckf2+cs=;
 b=QYBj3sKBj4n/ggZ3VSWGe+OtphBUK3uPgU9hVO778IDKczsI1f1QFsv+EIormiJ0g8
 24U7WpfHbjrKhtaXb1pa6zdyc+oJp9jInecQ2FV/JwLFqo16E4PuaNhER/6NIzRQpe5h
 +4E9/ZY3E67Pqlx579Ai01KFYq3mFv5C5KvtpGosPrXoLhBHYg2GcPTreqFnZtAenWKI
 spV8HoLYu0MPMSGu14R5AXiRh7NaPy7M1nxJA1BHfkjTC3ogmTFjqZkTosCTt3Mg4gUQ
 fDk9wy7abBUjqucLizakpdZMhfTEQ7Uq6lpUU7XU4bycWGb/YLB95Tt3vYlED1JMmHBF
 Tr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767636941; x=1768241741;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ons3pkeG+AVih1XQoRu6SV66GeauT557hqhIckf2+cs=;
 b=D2Q29O69kmZvapRADfMiDz7qVHFRNCI/aCU7deDnHIuKkxzB73tZr+aJf2IKXE1DxN
 +muZqRLLa6cFjJGERZYxI/ZfMY6Uum2PSjgbHAHX0+95S+qLVEjLK8vCek6mirg0KRaY
 Z7M4yAYjY+bIhncpuNh7aKPxhWOK9SVITFDxQUXuOK2mXvLIZEgoNoIaN8a/eK09Lqa5
 ui0I6OtRYxLCWbBC5fkcn8jc9duxUsJfNUUGRVtYCqwERRaVKBynTooXEpm+aNayml/Y
 SdguAhavi9b6/rd8+OTIZs/IXFvDxN/vQBOQsl11qEDbKRGE9+xwHAkAvYzBrhh7j+/3
 eZGg==
X-Gm-Message-State: AOJu0YywxKV0wxwEVJxADh1CxvQKsbVJ+ZImnLgONQDtdjRKe/XXoUZV
 N+bIUDAiq1EnjQdraZLluPEgzO4SdxxxIIn4XsvEM0T3H9zFzdri76ba
X-Gm-Gg: AY/fxX4uIQXA64bwktLwpOjtJ9Yi4OwyntLu/0yJVRkHfLWxne7Djs4CMA9iYLYA2GE
 9cLqfImo+wFj8Eo0TaQej5XBuB/i/e1gXPiXnbRAOTGKBx/B+5gvyfkDFR0Rs1tjGSnbdf9Wloq
 fAitodeD6KznJR5Md7ZKG7ZRaF1iJIZb25MydW1gKKvtr7QjKoEqHEG1C+GWTOEcFBYN8iIG8KI
 YU0UPRUAh0WwSKM6JmTqdZIWYjsmhV0FPZWU/xxJQ6jfU/jp4O8R5lgKTr41e32Tkl9O5p9g/ze
 4YXjrbeKBMg8KsD06MQQr5r7JTAYFQS2IH7HJJG6xSmE6i4LWkCsxsjMhAW1O/nWVgnKf3raNmj
 9IfAEXYrlDbjIhT/cr4ssYWiFQ6fyCTrCsD7f32yNEY0KSXy2KPHgueMxlOK+rIwlZSNNSS/szp
 n8krMW2lrJXZfhCQ6F2GP7P8SB
X-Google-Smtp-Source: AGHT+IHauq1L/g3mk0vi3UtS1CQgEx2X0Yl7WmRuvwfGIG6cn649R5xeuMnWC/5DCaHaD2kSFfnMzQ==
X-Received: by 2002:ad4:55e4:0:b0:888:7c40:6bfc with SMTP id
 6a1803df08f44-89076992cd9mr772276d6.4.1767636941239; 
 Mon, 05 Jan 2026 10:15:41 -0800 (PST)
Received: from [192.168.1.204] ([185.213.193.254])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907540e24csm3855706d6.25.2026.01.05.10.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 10:15:40 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 05 Jan 2026 11:15:00 -0700
Subject: [PATCH RFC v3 11/12] tests/tcg: add test for MTE FAR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-feat-mte4-v3-11-86a0d99ef2e4@gmail.com>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
In-Reply-To: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767636923; l=2355;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=9H3S2yi32msQiijkL2anIOhzD686SvaCB6f4b0JzVdc=;
 b=w+dWMJzzOkLssHJVULkEuGKinX4cxjnS+YyLTk3hYQH3uCCcJr6n2Yda6NbqIeQg3e42ogV/E
 4XFTBOvD2QLAlTttC/zJtL4k6XSIEUxHveex/CDyILr4kAg6/N74nXN
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qk1-x731.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This functionality was previously enabled but not advertised or tested.
This commit adds a new test, mte-9, that tests the code for proper
full-address reporting. FEAT_MTE_TAGGED_FAR requires that FAR_ELx
report the full logical address, including tag bits.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/mte-9.c         | 48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 9fa8687453..b491cfb5e1 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -64,7 +64,7 @@ AARCH64_TESTS += bti-2
 
 # MTE Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8
+AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8 mte-9
 mte-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_MTE)
 endif
 
diff --git a/tests/tcg/aarch64/mte-9.c b/tests/tcg/aarch64/mte-9.c
new file mode 100644
index 0000000000..9626a90c13
--- /dev/null
+++ b/tests/tcg/aarch64/mte-9.c
@@ -0,0 +1,48 @@
+/*
+ * Memory tagging, full-address reporting.
+ *
+ * Copyright (c) 2021 Linaro Ltd
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "mte.h"
+
+static void *faulting_ptr;
+
+void pass(int sig, siginfo_t *info, void *uc)
+{
+    assert(faulting_ptr == info->si_addr);
+    exit(0);
+}
+
+int main(int ac, char **av)
+{
+    struct sigaction sa;
+    int *p0, *p1, *p2;
+    long excl = 1;
+
+    enable_mte(PR_MTE_TCF_SYNC);
+    p0 = alloc_mte_mem(sizeof(*p0));
+
+    /* Create two differently tagged pointers. */
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(excl));
+    asm("gmi %0,%1,%0" : "+r"(excl) : "r" (p1));
+    assert(excl != 1);
+    asm("irg %0,%1,%2" : "=r"(p2) : "r"(p0), "r"(excl));
+    assert(p1 != p2);
+
+    /* Store the tag from the first pointer.  */
+    asm("stg %0, [%0]" : : "r"(p1));
+
+    *p1 = 0;
+
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = pass;
+    sa.sa_flags = SA_SIGINFO;
+    sigaction(SIGSEGV, &sa, NULL);
+
+    faulting_ptr = p2;
+    *p2 = 0;
+
+    abort();
+}

-- 
2.52.0


