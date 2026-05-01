Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B14BFF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIku8-0003zZ-Gy; Fri, 01 May 2026 06:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIku2-0003xb-DR
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIku0-0008N4-Op
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ba840146so14645175e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630519; x=1778235319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6fBvCYcxXcljcsjaxVxVKcZBMcAOoEdboxdW8oit2uM=;
 b=MUDrtg1+95ljBY6ywq3Fdq3nH9NvkmHxDVjktEVbJkrB6qF/U9KubaeiXic6T/PO3p
 ku4i0Zn8MqbNsIDRh4YS4FR2dkZm7U2CKKmyFaCw/XApO//Zc8ypLook4kxHwFIKOKg6
 36yTchtNCseUzJ5p8MpwdcwJ4QV+UcfBrhmkxQkGJtty+yOmWw1SbMsPT9hPZYfJyE3t
 LlgHPmGdW79iEi/NB1hFDJ+Whpunj8EfyuxKhQo08ei0mJru3IRradqdqc3ARF6zvF/b
 6indGVhEVJELeyKQNUGK2nTADNEezTTmBfhPXajAyfwxDVEEwpEq4/JXc1Kq+eYzYY3E
 0JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630519; x=1778235319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6fBvCYcxXcljcsjaxVxVKcZBMcAOoEdboxdW8oit2uM=;
 b=BQZPkccv6FGQLakrUBAjWgy3R2M176nW1R/0epKdaQo8mb2EVVqnDf6BHpijykR1i+
 CJ9AccLoONVWkkT+gR4N4Z8INWN47RHhieO3iNVPQId2MpBgCDWNlhSGniMEDHM81Kh3
 kQMI/CPc6ltHhgB/yekoo5PtF3ZNj8uDOce2qi7MWr6wgFlvlhA7rkTuKDZ68Gqpax8g
 pSwKperXVAXxf7mw35izQ1OpSSRrTYt3oevDqEFbEh0XxRR1fP5WncEplL1Gyiv14o3M
 QwgZAQNDmNkXSk28rwUEI0IwO+t2+bc2DL/ttqT5Q2+tBvmbkveZeoITRfa/odRFQ61F
 NNHQ==
X-Gm-Message-State: AOJu0YxydkkzDNTLjLKJThPJfTRpuKzjY8y6iK/uRBQ21Sqz8ZajV+Ig
 U9nCQypeT69mB45rzgobOSWWisK4yUDkgwCeRBcNZ0cShzKxkduAq1TouJhxC7oCWJMSumedy2h
 F5O9H
X-Gm-Gg: AeBDies6nM/q86J6lsL1qabhdg+qMJ24Tew4LJOaP9lmZ40SZcLARdSbiJWxk+XA9ey
 ewOaNenpqluNKUy1F9lx3grIQtQ5m3cOrFkX5py2JxBUiE1YsrFPUxeLd9sDpJQKYAgzpRhRip3
 ZVvD2FOeZY9aG6DNQBYEKNxJsRqepEhsgAdW5epirQnlDmbNCU52Aj2acPCMnwWMFe4QboUVg7G
 gsiutoEkyNE34ZFni8pBzdGrHywUzYGpbysQoxVwsoavKEewCDvIL5u2ITPl9P+AAsrzP3ujA/A
 7Hw5D5FNfGYH9pCayCo+wcGyQjg9zORTjhiQ2TB6v6sm5qpi6O6NWFtoXeBtQEAzE0j5hlw3rh7
 4ANKfk5QlA4qw5vjDSOJpHlY0aWgT82X+wMGhVGZEmtkh5PmZuHw143zufWewBRwuaQ6zT4teS3
 LWqmcgk2FrONo0T2kthxPoyk6Vvs96l+hrNLubyEGri3IEaggEuAp56uClPx9ovpuP0ju9oxEa0
 p+xtGDx7J0kt2bD9Q/TTUA2f0JtjMk2Vzp2uKdfDw==
X-Received: by 2002:a05:600c:4e05:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48a83e72f12mr106264835e9.12.1777630518664; 
 Fri, 01 May 2026 03:15:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/28] tests/tcg/aarch64/system/rme_gdi.c: Very basic test of
 GDI
Date: Fri,  1 May 2026 11:14:46 +0100
Message-ID: <20260501101505.3485916-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Simply tests GDI's prerequisites; that if GDI is enabled then
so are FEAT_RME and FEAT_RME_GPC2.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260421-jmac-feat_rme_gdi-v3-4-ecd20c77eae1@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/system/rme_gdi.c | 46 ++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/rme_gdi.c

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


