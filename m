Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD44CF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 12:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4Fi-0008Mq-Mh; Thu, 20 Nov 2025 07:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vM4Fe-0008JT-6G
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:59:06 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vM4Fb-0006KC-MI
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:59:05 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42bb288c1bfso559095f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 04:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763643541; x=1764248341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1HltNTxDcXeiGq7vyFlKSycQx69En1sBeoERy2dcAA=;
 b=mYDJDcyeL1AxP8RTjqJa5AkypZR8XUKiUn6gPTZIgsgGl/caI2+Ufc9OVNmUijaoHw
 Q9lQOjVAHLkXV7pS/bRT+gtU5CY4n29cofdP0kHQPFeU7Te9Gpeh6OqICDk4FFUbEXaL
 4Y3B3L5U4GS8+pk07OFCgNdrbm/3RlKd+pFpKUKjWtBaA/fw0WnVqqxnLWIY0SZjs/fO
 aMM5FkGNtxaQNML6mPgV6m5xWMccIUHIxUlWIHpNNzGA2D5UXrB8+LsIB/TsFbnjcodC
 4QRZD/Utsvdmaw3SuGXzXCaVGYWRceP5+fNfJGSzXh8/7RuxWyds5Pe1O4BUPhmkxQzN
 vPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763643541; x=1764248341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T1HltNTxDcXeiGq7vyFlKSycQx69En1sBeoERy2dcAA=;
 b=Ul/mZpz9w/YVzbnrd7qlYBWQko+IQ241cM/FrVVgXjA6l5mLbh4dk/k+Tx0rPzieal
 kyVPwWn1U5VZxHaplHrdietLcoayGKcPb2iY9fGZMt7CvcMpP/yLp++WE47nvjWOrOpc
 /apRHrzfWWluv4Y4pJwfWoMskVkVmE/yZnyk6dD9AhwcmfQ0SUELF7wUSWoINz/J4L4r
 xwGCOD807Is+jAZlr1fRLdGoGzymPkYD7ttR5s0Nnsc/8Fs8BzTYcrAogNV2/O/u1xo/
 Qo0AtNiCB51dtItEamvoTO3imVpXpF1gp6zi0ra6Zg6/pLV7wHkhYYM7qmncLfTWEvYH
 npeA==
X-Gm-Message-State: AOJu0Yyi/cY3BuAV3XrS1Z3DBWvohO+abg6UrfyRmQE8juzxNaafUwxO
 PTyTNcTQ77BadXi8s9AEtnNTnr1rotYJRv7ZJJfKIub++JB7KcsrvbjbTFhHtRvzINZY4SdWxgG
 kEKOgOUw=
X-Gm-Gg: ASbGncsHxlR/TF2z4Q2LoawUAI5NXtF+9WMnTgemphhNQcFAdduIyKcT35NfIRTV3uS
 OOxPClNekBQfoucnZZxBkt362JVGeP/WXRqu59SvtReIt4rzMerhT9LbnfgJezVq6ClcnTLLN5K
 9MtA+FC4wwQk8Ud1YFJwwg+TBIJuYXq32Pz86flCD3558ybz7RKI9zQ/ERCIwyfcdnUyISvl5UZ
 ppAVmtl/wu91vrXZofk3Pzs1apOWaetV9fcDo2TfIpic01uRmhGfpXryz63tprjUVyU0/da/F/0
 JxheUGDzuRJaXtnimD4f1EH86XMoKtYOBTngSqtPrLO+JEvmNMFOZu3EDDBM1myVOZV4HyYcPJe
 lih/8NbvpbI66KfaQIOFVWUTft10DModJ4uMfFXXguX4wXjSfqUDN4HKbPPNIbmzwHh2JX5RQnS
 j9knQ2dleTJFcXOKY0fvSdKkY=
X-Google-Smtp-Source: AGHT+IGXkFuEcDjABO5rJR8uEBtSRVgTHAfrr2Jf0BEmdTwImgqQMaG6AcV57zlSI1dcdUlClSImkw==
X-Received: by 2002:a05:600c:4695:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-477b8953aa8mr27783615e9.9.1763643541047; 
 Thu, 20 Nov 2025 04:59:01 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:1328:3324:f0af:9332])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b831421fsm46082145e9.10.2025.11.20.04.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 04:59:00 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 3/3] tests: Add test for ASID2 and write/read of feature bits
Date: Thu, 20 Nov 2025 12:54:16 +0000
Message-ID: <20251120125833.123813-4-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120125833.123813-1-jim.macarthur@linaro.org>
References: <20251120125833.123813-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42c.google.com
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

Tests ASID2 is present and FNG1, FNG0, and A2 are writable, and read
value shows the update.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tests/tcg/aarch64/system/asid2.c | 53 ++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/asid2.c

diff --git a/tests/tcg/aarch64/system/asid2.c b/tests/tcg/aarch64/system/asid2.c
new file mode 100644
index 0000000000..cfe69db2ae
--- /dev/null
+++ b/tests/tcg/aarch64/system/asid2.c
@@ -0,0 +1,53 @@
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
+    uint64_t idreg;
+
+    /* Mask is FNG1, FNG0, and A2 */
+    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
+    const uint64_t in = feature_mask;
+
+    asm("mrs %[x1], " ID_AA64MMFR4_EL1 "\n\t"
+        : [x1] "=r" (idreg));
+    if ((idreg & 0xF00) != 0) {
+        /* ASID2 is enabled */
+    } else {
+        ml_printf("FAIL: ASID2 not present in ID_AA64MMFR4 (%lx)\n", idreg);
+        return 1;
+    }
+
+    asm("msr " TCR2_EL1 ", %[x0]\n\t"
+        "mrs %[x1], " TCR2_EL1 "\n\t"
+        : [x1] "=r" (out)
+        : [x0] "r" (in));
+
+    if ((out & feature_mask) == in) {
+        ml_printf("OK\n");
+        return 0;
+    } else {
+        ml_printf("FAIL: read value %lx != written value %lx\n",
+                  out & feature_mask, in);
+        return 1;
+    }
+}
-- 
2.43.0


