Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7177D10F34
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEqK-0002rq-Pc; Wed, 26 Nov 2025 07:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vOEpq-0001q7-4V
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:29 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vOEpo-0003OS-7r
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:25 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42b2a0c18caso4106508f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 04:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764160882; x=1764765682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buG2cVnADLsjsxTOOezo5Vnu9BdAgY9Lq3Omdhcd4Cs=;
 b=UC8/84ZPlB/4j71otT2DIBupZOOCZ8CWP3l1QXgPH21lDqnVrRruk7G0vC5U81vY5M
 gBOERFgNYAhXbmN4UMWN+OO9KxOzkNFZXTaHO/bG1JX9c0csPRXmkvLAx1zsbMI5u/Go
 UsIiZtpBvw1UHiUMeAttdgPh8EPFmzlXbzcFceF/wlg2dftz7fpBYrj1i15LLgpv40f7
 XWcbOnSn30eFVXYKW28NYTGpHk5WhB9kFnG047t+sY9whBD/LxPLqiPV+VMktM+Vldj8
 ip7il4IevnYAdIeAYemnFJ0o/Kq5w0GHBKX3AzBP6k4duJDUdRiW5U3VasJx1cBUBuq8
 CoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764160882; x=1764765682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=buG2cVnADLsjsxTOOezo5Vnu9BdAgY9Lq3Omdhcd4Cs=;
 b=bKlowe2K314lupWl4nGYHTo+FdEipOwrBWlzbS2sjXzVOy1JVhFNQnOGaHic/nE2FE
 sPp+vV4uhYi+OWRR8iceyx5hvHshYo9jyER/Qdjy0lxWiGP4wbq576iB8cBn9HsE/6Tn
 vuLvCay8UY3mZxNJkxKjTMspbRDhBYV9J85WX1lhG8GzG47QSh98QeKKnAioUQz1X8aI
 SErepIOJHl4CyTudy3IFZo9Wl91dDrrGyICjdRJPDlegyLxFgsbTgAi7xIXcz8gpTCUU
 RHrmfxBRbUQ6QesyOb7UshShoX0qUDpg5ndKp9fvQEDrj9dZdSMkCgaXCF4/8RFXvJ5s
 q17w==
X-Gm-Message-State: AOJu0YxikMLO8/8HyiyMPAOPUvp83HItl5zuNIlF47wlGFpOLGBnXEJ3
 +HMXc26tXe0UNCpKhTAHNJkwUwySVOm3lMUhtFGVqI/hI6UVa/4Vx0tmonkzQPSS6CUgBxS6NxK
 /idLQ
X-Gm-Gg: ASbGncvmayOeKMAB0wXMg0+BHbYtlXkxV7PYNW6MhsKL5RJLcWDvXLAPSYU353FqTZY
 SvOTYVaZydalEK8TuapyMUeml66kcYDgu2wuZ6r9E2q5U1HTHalMc85hbenAaDAJn0feftvZj+L
 sEFz/2vbHsDQvnEFE0GY9PCFdg9ykWZwKF1K7krDWOMDkWc24zQV9MKz3drfo4PimvIAVwrXwZu
 IsvymeL3eoCC+w/91Zi+2gafReC3K4XKuIi17as6U9aEfWlRII6pyzD/0mb66T3xUsEIyR4WahV
 Q5D4In/v0txcgJ0ooEztWNHwSQ+lI/KNE1jTrs0f85uMXhy370bcBFsq/b/+DHiUdxJeBZD0l/3
 wSqAzHqv1sBf1X0n8ixcaE062CZAubqWnVIqa4nYHuI763/LyOSHPPFhx12qizstcwMM6OUDaL3
 5JgbCT/F6Ho6I=
X-Google-Smtp-Source: AGHT+IFv4c58ItXvwm0ihFCgNsmz/tZFGxuM0DybNKr7e8P7+etpgylCD/2ao2wDMc/mTYSad/yJmQ==
X-Received: by 2002:a05:6000:1a8f:b0:42b:5567:857b with SMTP id
 ffacd0b85a97d-42cc1d19e16mr20012340f8f.48.1764160882109; 
 Wed, 26 Nov 2025 04:41:22 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:a692:d4e2:eaed:fc4e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e556sm40044246f8f.5.2025.11.26.04.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 04:41:21 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH V3 4/4] tests: Add test for ASID2 and write/read of feature
 bits
Date: Wed, 26 Nov 2025 12:36:50 +0000
Message-ID: <20251126124116.351685-5-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126124116.351685-1-jim.macarthur@linaro.org>
References: <20251126124116.351685-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42b.google.com
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

Test for presence of ASID2; if it is, check FNG1, FNG0, and A2 are
writable, and read value shows the update. If not present, check these
read as RES0.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tests/tcg/aarch64/system/asid2.c | 75 ++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/asid2.c

diff --git a/tests/tcg/aarch64/system/asid2.c b/tests/tcg/aarch64/system/asid2.c
new file mode 100644
index 0000000000..a4887e4ce2
--- /dev/null
+++ b/tests/tcg/aarch64/system/asid2.c
@@ -0,0 +1,75 @@
+/*
+ * ASID2 Feature presence and enabled TCR2_EL1 bits test
+ *
+ * Copyright (c) 2025 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+
+#define ID_AA64MMFR3_EL1 "S3_0_C0_C7_3"
+#define ID_AA64MMFR4_EL1 "S3_0_C0_C7_4"
+#define TCR2_EL1 "S3_0_C2_C0_3"
+
+int main()
+{
+    /*
+     * Test for presence of ASID2 and three feature bits enabled by it:
+     * https://developer.arm.com/documentation/109697/2025_09/Feature-descriptions/The-Armv9-5-architecture-extension
+     * Bits added are FNG1, FNG0, and A2. These should be RES0 if A2 is
+     * not enabled and read as the written value if A2 is enabled.
+     */
+
+    uint64_t out;
+    uint64_t idreg3;
+    uint64_t idreg4;
+    int tcr2_present;
+    int asid2_present;
+
+    /* Mask is FNG1, FNG0, and A2 */
+    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
+    const uint64_t in = feature_mask;
+
+    asm("mrs %[x1], " ID_AA64MMFR3_EL1 "\n\t"
+        : [x1] "=r" (idreg3));
+
+    tcr2_present = ((idreg3 & 0xF) != 0);
+
+    if (!tcr2_present) {
+        ml_printf("TCR2 is not present, cannot perform test");
+        return 0;
+    }
+
+    asm("mrs %[x1], " ID_AA64MMFR4_EL1 "\n\t"
+        : [x1] "=r" (idreg4));
+
+    asid2_present = ((idreg4 & 0xF00) != 0);
+
+    asm("msr " TCR2_EL1 ", %[x0]\n\t"
+        "mrs %[x1], " TCR2_EL1 "\n\t"
+        : [x1] "=r" (out)
+        : [x0] "r" (in));
+
+    if (asid2_present) {
+        if ((out & feature_mask) == in) {
+            ml_printf("OK\n");
+            return 0;
+        } else {
+            ml_printf("FAIL: ASID2 present, but read value %lx != "
+                      "written value %lx\n",
+                      out & feature_mask, in);
+            return 1;
+        }
+    } else {
+        if (out == 0) {
+            ml_printf("TCR2_EL1 reads as RES0 as expected\n");
+            return 0;
+        } else {
+            ml_printf("FAIL: ASID2, missing but read value %lx != 0\n",
+                      out & feature_mask, in);
+            return 1;
+        }
+    }
+}
-- 
2.43.0


