Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A1EFCA198
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzies-00038W-LQ; Mon, 09 Mar 2026 18:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzieo-00035z-My
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:58 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vziem-0004ZS-DE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:58 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7987531082aso118074237b3.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093655; x=1773698455; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ons3pkeG+AVih1XQoRu6SV66GeauT557hqhIckf2+cs=;
 b=Ca8bQ35rmXLZtBmlA6I2dMih3ovyT0ISC8PyX/2PR1bb5JQTTSQzd5bNKHH4p/f5F8
 701u9WnTI4d+E4gEtVzlzQ978KQmih3c0FraiVt0BMRCsN1UJpD9T9LXObdE9wvj6K2K
 HI2MxRJCQGOm2bfTAOenzt6ZHRNLT6o/tH59fYn7GXDWLg30A9QQFjV6TnvHOCQHo+ON
 hRlmKVuq/Xhdk1HUhvRqlfqmQQyeQcBrtPyA9oQK3CbhrsW1mjqscSKqFza0ZFH2fh9D
 UAyxaiaARKuHAZZgL/8a7bnckmCcvIBiqn0AR7yfoxtPFHLR8vH77gUEN3ZGA2+ey+CT
 cEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093655; x=1773698455;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ons3pkeG+AVih1XQoRu6SV66GeauT557hqhIckf2+cs=;
 b=bIhlxesiH43iw+2RtFZQQ06Kxcseq9evZgcN5s1HNMNe6Q/tA9eyFMNBleHTzFYxPe
 jaUkl2SZUBuM47z0FOdbY04re7xiASiASHlPQmI1+WQPbFB38NkfTFcuQfEfiJZy2TI7
 ZeMOIS/mCuKtAaeXV7Ad+jgbizge2Jag2eW4sbjVywLb1Z2Q6aHx2RNYEKS9TOMUcx3j
 D/MLEAXI2h3rhHPNeCxWk4jAdfJcWfivr348WzPIqayEA71v/cqI6Z+vOGl4RTTLiPzp
 bNGp0A7p7GfisMQGr/zBigyuvQkXcBWj1ODgmfpp00BdPoOa+N76KQR9BzFqZ9Gc04TZ
 wA+Q==
X-Gm-Message-State: AOJu0YwGsRN57m9ue5yUq2uYPpwRePunE2YNWIICGfvLeWnJs+aWG3+T
 oV7m06UlJ8QAcD3LrL5qcBJWyv71bqbROy1jXSYZLhoadqqJYrz+1RpL
X-Gm-Gg: ATEYQzz+2MCmpPSBELfSI3Ouab3DrmxESrgoFWhgdmtwJJvojZ82i5Yz4Yu5Ys/UG8i
 G7JjYoNlRFmiwGE0zlnI5CI1mHHaIZGSMNJjW3UA+8aYDrdiJ2T+HAIbJormPw5N7y0OIYZaaAQ
 knIgJ9alANR9z+tngHhsf94FO6DNGiTEUBmQ1Tiad5vSSu0UJUZ1rZiqrcwcEpnYxs0qkLjEfpt
 LINYtur05uH/CAqM0C/7KrCQIFpFtaUmUeiyMgf4NiuDTOUqDFFCnN6VgWU/2SFoUQcGZVT3+2W
 ywDn5OAQwQS1aaLMcsMOcJMQYPskdAfVURdeEhgfLvQjLEP61bnmHv8lr740R7o8UelX+fcWoJY
 TLQWq51KV2LV7YnC1aLLqLaHcbgvf8ltTVnwTqE/SVF9tzZM0EARwXvDIYMjkLKs3PK4JGZOwjF
 iJqn84Bn1ayDq7oIAd9scNYM4Hn5MwLTrZkafRMrGAyMz/MQ==
X-Received: by 2002:a05:690c:e3ed:b0:798:7281:be71 with SMTP id
 00721157ae682-798dd752aabmr130832167b3.41.1773093655057; 
 Mon, 09 Mar 2026 15:00:55 -0700 (PDT)
Received: from [172.26.74.149] ([185.213.193.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7990a54ba7csm5218437b3.19.2026.03.09.15.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:00:54 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 09 Mar 2026 17:59:44 -0400
Subject: [PATCH v4 12/13] tests/tcg: add test for MTE FAR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-feat-mte4-v4-12-daaf0375620d@gmail.com>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
In-Reply-To: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773093641; l=2355;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=9H3S2yi32msQiijkL2anIOhzD686SvaCB6f4b0JzVdc=;
 b=hccPwX2VbR1d0TJREpIbLnyKtTf+Q/fXtn0osOMEbhuTwYiT93x+mOiyPOWUrepfQtUcMtB8V
 xlCxFT5W1JiBJkGWaEV8TmpYehQQGCx09K2ZbVXC14D2Z/mGk3/KNwJ
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=brookmangabriel@gmail.com; helo=mail-yw1-x112e.google.com
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


