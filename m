Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4776CCD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXy-0000B7-D3; Wed, 10 Jun 2026 12:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXY-0007k1-Qw
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:29 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXX-0005Vl-8i
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so3530661f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107945; x=1781712745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RIOhe60Csom8C5yKptAinH/iPxRN928G+lz8/fHu/oY=;
 b=puUmk/jZ+RABdL2u+SLWSzJu/ZiFqp+h/2QXYHhuqrKwIxjGdS+8eIOvwRL/LrOqq4
 jX88hhlY4m1dFhdH+bf/Xczo37PhXDMY9LnDO3Cz0T0wVtTxB90PtilVOJ+gCbVmbRgH
 UzWQxr9MZ2HCNNZz2zkaxmOpCyTg9ItORF/HFBQKraYl6LWanXlEGkgXeaF9xn192eUK
 HbDINQBRi8GU3PRYv8CvXY+rRW9rKmWlpx8QYiAfbVj54znKM52VIU9G6se7A9Q1gqtt
 09K/OrSVgLtbiKpl5cnKCp1uaer1banigUuLAljOATl9jDDp35zYYlyC1NOUGBfrIOK0
 i/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107945; x=1781712745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RIOhe60Csom8C5yKptAinH/iPxRN928G+lz8/fHu/oY=;
 b=SzYVuvbht7rgsQ6xiuYh4PJia0Xf0YAaQ2AIrx/prB0Kjt8bnO8kPm4ETxfYWF5paE
 QZdmqoCkLPACDgGQo0Naq56KhUVtZ9fuQgCKN4J+2ZTOEPBMiDEAnpsFcoQa54MCBvsx
 IrIo755931+hNZJrY0BpO4lPj4cza3XCyLTzzBO2p7MD6lcsjEiJYIvEpb5MWEzxNMwf
 KieFHjWhXyaSrPKe7++zIta0ouWOM0dLX4aGocGJkPSrHLBaFO69/50k8k+hF5E2CZSR
 P+iucF78FcEMFvntcUqoVYfdwKQEqDKPWCQOeAjSmpmxWxwGGEiFhfa65VdCLhM0NqgI
 zetQ==
X-Gm-Message-State: AOJu0YyUupAd8tT0ZssgHxH/GXA1dUPTA7u8cUr43PRBkKYef2VQliSM
 buObSfQzEG37om2XYzYOpKl3j5xNYLrLWwdJP5fCunTygixVpfQ9MSOEiNVKHkkf+3j5MMFlPgR
 V1TYh
X-Gm-Gg: Acq92OGALe6zeezttyYAlz2m32Ktg/Lru8Dimg7omzKiu53Uvt5TlrXqWJ4M/K/oBlg
 mevllKXbW99lLNRF+fI3xooGFofaKcwVKTiyr3miZ2hhz6QpteMCvwj33G6fjOptERv4aM7z063
 Rkhjr9xyznS0zjtT88IP74FmNDUHt7pgmdmp02Xlpt+FqUkKfvLbWF0gGq3TDUnEneF35KVouLI
 m2LdARykR201Q1S3cVfyQa1yWRQtpnkiI6eIydjHiaP4EH4zWq5DuJwzipBGK/ioLYhpjt/GaEb
 EIPNsRUWjmdAGoBrFnNSSvIETSZ0oNQyd/ujCIk6cOP77wUHclcYx3B9oLChxAoBNFY7RP7aDT+
 QxD7VqErDaIIgZc+5MrO9H0+IL2gk7HQPA8mOxU9BEzEp5FQc8lhT24YCwRUqK4SzDSiIrI98fd
 AAA2z9DZUMzix7vkq8VBbH7xz/Vu4Y1phxKZv2ONvRxd5bu+uylp197uq6udxXJawe8IdvI2U/R
 9raV7XPk8suHzPbTy+qHzcA4oMhmam161i4A3cKBugEblSdpuse6w==
X-Received: by 2002:a05:6000:1861:b0:460:3234:77d3 with SMTP id
 ffacd0b85a97d-4603234789emr38498424f8f.41.1781107944597; 
 Wed, 10 Jun 2026 09:12:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/71] tests/tcg: add test for MTE FAR
Date: Wed, 10 Jun 2026 17:11:06 +0100
Message-ID: <20260610161202.2235298-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Gabriel Brookman <brookmangabriel@gmail.com>

This functionality was previously enabled but not advertised or tested.
This commit adds a new test, mte-9, that tests the code for proper
full-address reporting. FEAT_MTE_TAGGED_FAR requires that FAR_ELx
report the full logical address, including tag bits.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-14-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/mte-9.c         | 48 +++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/mte-9.c

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
2.43.0


