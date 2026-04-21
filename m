Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649B6F8FA78
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 14:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFBzz-0006DT-Jf; Tue, 21 Apr 2026 10:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFBzx-0006CX-NW
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:22:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFBzu-0007Oy-EF
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:22:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso58111025e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776781360; x=1777386160; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XBTtSCI18DkWDQHBLKzhfLHt3mYdWEkzO4NSBhCDchs=;
 b=T2/Y1riSrZier7qOAMDNfq7XI26hR4tE/6dPJHZxLF9l8g9D1/1R0sjz+aH+63hGp5
 QpwxPkjmkk1tLSv3/NFNJctJGWYeL6yILk21jwGJkcboURwE20sjbVQ5NQzNm7RyMF+3
 ZYpWeWA4PIMCXVb6uUgXcq9m1wtaLU+szzjyjeL3+RVheqlHJ1/2uZm1zjpqEYntI1mQ
 P4vnZLgCTjhDm90GEm7xADXFR1Slu4oWdvyOodr2/OitDsybq0DuwiTnjWGBomUh5Vc2
 mhk1RYyWvpeU9pQ3xyb5LpoKZir5kZe6z8+8506fbBKcL7inNTrBYT4FQ4Ze9cSng/t3
 B3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781360; x=1777386160;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XBTtSCI18DkWDQHBLKzhfLHt3mYdWEkzO4NSBhCDchs=;
 b=eWPq7h0biC+maHIPOf6jsyBp0nFZnSfaJh7hKu+661UpWAJOujieSsLL5r5xKgql9A
 O66lOnLeoF4GPHC/qUqnRwm6dMPCbClR84ndT/rGlgWcZEvouH/RuR2JJeIYT3HsJeKP
 fsXZUvhqOkFqj6k89dkg7qwbjESKeqOiIoZ8ahVL9v189ICMtjK9/9QAWXEbvtIgk2QQ
 YGMMfdutifngVfoSLTXH4wTqr3LVCsBetSjMIf+HvzgyU5J6VdQf5zomAVZ0yp7xZ/rq
 f483Crryt8HbVufv3DM6WY5lEdnwesI6ufFCLsAT91I9DGUnCb1roOu1ZmReoQZOgoGc
 EY7w==
X-Gm-Message-State: AOJu0YxH5IcBdkccRp0DBD6kVQPW75BHkFGcZbvwX79xB5v1KFryCAKt
 I82XGJ2gtfZxeSKtWIs/YHvHE07LREu40t2HozsRGvUwN1f6RWpHpMaljDtpHb6Q6VEdhAXVVd/
 PwDqg
X-Gm-Gg: AeBDieu6OxaixZmoh9jG0bsdIcMgL/qCshtHnI7RtmgnmguIWP/s8mpZqS3LyQwHOOC
 1JKUMO2kIg0vJupNKBa9Gd/vffI+RyHOezvcEXb4CR7QkKarlo8t14Jgt+Z4b6M1NnUUMRjBf5o
 pPZqLPdV+nWoP01wSJcs5NaQhKiqwtBmkbBt0Kw0XSqJFE56/i1J1XFjhu24dm6DfS+tRQ352AE
 aWvS/2N4a1XK6ZpNhVclQuhtW1ThHb37rK7iPdmuHoRhUiDtCkKNAY+tA5lOb975zRrcvVpR/pZ
 08ASEYH+0S4ShUoJcg4zBj+Iq+JJd35nyril7RuGzil51+X+K/5LEZeMNtvQ8QbonW3N5tKkwah
 pzMpQpM6dshi5VrahHKns4TUZxa+irnNJS/fHp24rZKp0AD6aklficsZjtZW00TzEufrmyVdqMh
 kY87GGksK6ZlK8xd959hBP8XLOTAuEdeOZUG2tYw==
X-Received: by 2002:a05:600c:3596:b0:48a:563c:c8c5 with SMTP id
 5b1f17b1804b1-48a563cd1b2mr41046955e9.8.1776781360394; 
 Tue, 21 Apr 2026 07:22:40 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:5364:f814:f749:9bf5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cca5743sm164250465e9.9.2026.04.21.07.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:22:40 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 21 Apr 2026 15:22:37 +0100
Subject: [PATCH v3 4/4] tests/tcg/aarch64/system/rme_gdi.c: Very basic test
 of GDI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-jmac-feat_rme_gdi-v3-4-ecd20c77eae1@linaro.org>
References: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
In-Reply-To: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x336.google.com
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

Simply tests GDI's prerequisites; that if GDI is enabled then
so are FEAT_RME and FEAT_RME_GPC2.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tests/tcg/aarch64/system/rme_gdi.c | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/tcg/aarch64/system/rme_gdi.c b/tests/tcg/aarch64/system/rme_gdi.c
new file mode 100644
index 0000000000..e869943a13
--- /dev/null
+++ b/tests/tcg/aarch64/system/rme_gdi.c
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ * FEAT_RME_GDI Feature presence and enabled bits test
+ *
+ * Copyright (c) 2026 Linaro Ltd
+ *
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+
+#define ID_AA64PFR0_EL1 "S3_0_C0_C4_0"
+#define ID_AA64MMFR4_EL1 "S3_0_C0_C7_4"
+
+int main()
+{
+    uint64_t mmfr4;
+    uint64_t pfr0;
+    int rme_status;
+    int rmegdi_status;
+
+    asm("mrs %[pfr0], " ID_AA64PFR0_EL1 "\n\t"
+        : [pfr0] "=r" (pfr0));
+
+    /* rme_status is 1 for RME, 2 for RME + GPC2, 3 for RME+GPC3 */
+    rme_status = (pfr0 >> 52) & 0xF;
+
+    asm("mrs %[mmfr4], " ID_AA64MMFR4_EL1 "\n\t"
+        : [mmfr4] "=r" (mmfr4));
+
+    rmegdi_status = ((mmfr4 >> 28) & 0xF);
+
+    if (rmegdi_status < 1) {
+        ml_printf("SKIP: GDI not implemented\n");
+        return 0;
+    }
+
+    /* Check FEAT_RME and FEAT_RME_GPC2 also present */
+    if (rme_status < 2) {
+        ml_printf("FAIL: GDI is %d, but RME is %d; RME should be >= 2\n",
+                  rmegdi_status, rme_status);
+        return 1;
+    }
+    return 0;
+}

-- 
2.43.0


