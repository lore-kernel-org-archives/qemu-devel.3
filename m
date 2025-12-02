Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74263CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQP5w-0006c4-Tw; Tue, 02 Dec 2025 07:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vQP5v-0006az-31
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:02:59 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vQP5s-0006V0-HW
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:02:58 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso56566715e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 04:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764676974; x=1765281774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buG2cVnADLsjsxTOOezo5Vnu9BdAgY9Lq3Omdhcd4Cs=;
 b=kIPNrze2zTwVZ0n17Zl/35rRuM/6IKXEUC5eCLfTC4t5/nWOfrZa1nynVfPDeJw9dw
 RupIQuxi68mO9WRwXl3YhbW0iUAffnJObh0v7TxryjtrCx5bm+8tV3A7fslzGdH05t5X
 uJ5BsXV4Fdhx10psxNjurdWRd6lP4bf11asmqnMvc7K/jVbqUj5Slf3ii/MdZbLIh4wn
 KnDCRfPgmKSE9dx2S5mNqZvb8T/ignMbTU02oY9C3zATeibK9mYCO168btJESv2ma1Um
 PpR0+/8VWCzY4V1OFJH4lNu1JNnB6D2JK0rh/qv/kJBTEAy8OIyxoHOVs+aGAPenHAiP
 JFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764676974; x=1765281774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=buG2cVnADLsjsxTOOezo5Vnu9BdAgY9Lq3Omdhcd4Cs=;
 b=iqC2+2TJZYimb5Ki/HqLZ6G4KeCcY4o704t72b9GlDM93StTteuz8zAcK4+30vdViz
 XcOsNgvu+wuPawmt/XB8bHIctgOvRZU5fSTbEyqx3Ax6SsxPrcsErwJReOgtw9zqfJ0l
 2cm+WaW8PgjXRdsTBMPGQz5JRA2Jht0oYlrSaVTq0w6gBzuPS5apS16ltEMbs/FSVbJY
 fNuoCmjERyCFur8961qoSCq458EBUWZALh42d8nJy6ktkwAD3quGWd+Gxk/yHMFO0KHV
 RXIfNQnc3qe9uZmDJOdqv4txyxb1LHn8POldKzKxUaQrXDcgG0fLfLkdzSuDq3DwK4s2
 72CA==
X-Gm-Message-State: AOJu0YzBw3isgDmBKZqm1DdgWZpzY1Q2wt3B3tkwjenqpv5xN+J0CVpL
 +0vCX5FjvIZUhKd6QbaWATu/D2Gtuxd1ax/N4lvG6iLlD3vkXKy0633gXFu3vd7qA3tMp75+xOr
 6MJTT
X-Gm-Gg: ASbGnctntqxtyUSzqS14dhwZ7rTOjJj/h+QNt58VxHKV4ginaK+VK/GAzknGzxkdmAH
 H6Iesk80Tux1aBOyTfse83T06XkWS57jr0fF+Ig/Ej2ax0j4C9LEyfw0rB6G6wujOCtmYyZm24h
 97U/uarClFMk5K7Oo7hz35L2eClSrD0z71egCkJ0i+zJBYTHIbPzNa1P9BpUCZKA8TMSBNfAL8a
 tmNWVKJehaG4Qwa/R4oeOkT+PketU0FrT7P3K645pCdxiXA5vkmwccPQgxwr/l4o3n5SCearklK
 rbWHfxelZJMW8bXnfgIMQ1YJ/R1aoP89kswdwBTCq+LC3ibrN5Av7Rd+WKBiVS3rclnjh/YhFzR
 U1QRBeWkQzVLfeAVwQt5GEwpxc/8PA66D0NxLLw6RWRmHzUiBD6lY+wB2wkyXgFbG+sSORFNZAp
 UFqjurcaw860CNjbwNLa2PcwY=
X-Google-Smtp-Source: AGHT+IE78jojHOBERuCaqAbVoEsBkqHU2BH/B9l21dNA0adhY+l4yhpe2h46RrXRqzEBfaAxsUyM/Q==
X-Received: by 2002:a05:600c:4e88:b0:46e:7247:cbc0 with SMTP id
 5b1f17b1804b1-477c01d4af2mr414114935e9.18.1764676974394; 
 Tue, 02 Dec 2025 04:02:54 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:d0df:e484:1145:883f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0e21e8sm381169835e9.15.2025.12.02.04.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 04:02:54 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH V4 4/4] tests: Add test for ASID2 and write/read of feature
 bits
Date: Tue,  2 Dec 2025 12:00:41 +0000
Message-ID: <20251202120250.763150-5-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202120250.763150-1-jim.macarthur@linaro.org>
References: <20251202120250.763150-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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


