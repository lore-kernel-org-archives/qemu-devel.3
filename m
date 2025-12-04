Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0350D24458
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDis-0006Az-44; Thu, 04 Dec 2025 13:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRDil-00068a-NB
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:06:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRDih-0005Y6-Fk
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:06:26 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477a219db05so9197895e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 10:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764871582; x=1765476382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zzJrLyR2vlRWkV9LLSEUDWhWY0B157Kg5d1h9ui2A0=;
 b=x3fO17cud0n7L9WPBILA4/9FSztm/kszP+uYuy3cOezhsX3Dv+gH813jZg1+ABBYkg
 HrkIqkvlzZgb21jJJjRboIYeKpvzRJVhF+WDExmNanyJ1Gk3Bl7PRVlkVEKs6O41XjZY
 j4vHIPttbSXEoABtuWvdYC+3XjnGBXN0MBRhVINGatIVoPYj17dGmoL+8oiSNwRX9pbg
 RtIaUr72HWXuCPgd3kVpeAvFCYalEQk6yb55NEmXxdk0W/I0ChuPBld2WCeEyoiGOJS3
 2Y6ViAItj2fI4l0J8DSHQI/SktMb7vxsCU73hoxJ90SJGSTyOfDnlDVCEJxr5jcuK3OW
 ut/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764871582; x=1765476382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5zzJrLyR2vlRWkV9LLSEUDWhWY0B157Kg5d1h9ui2A0=;
 b=IJI6YDNT9kZ80zapPDBlv3m+0gMMeFClRbb8n3/VRnchzmMAeZD89kcVL2tBMFwzBY
 FfpSf84qg67ICVgzzrBOR80b3OKMe2itGS2KB3erJNoJ+mQ0q4v0z38+v0JLQDyMwukI
 RssaIDaU7vC1/KI60O8ADri0l8SGARldfaM3ApaSs1YGqGn9wtNbkvLYTDTfxjgLWQzD
 0oSQYQ+C3Tenf2MnHVtHUQhzJFDfu3vVxCJeryEXvOGfSc/jYL/AIhV0iDWirsAqRjK7
 3LYUl05ukEjaTkn5PEs1bUgbo4DyQrzPDoIZmmYqi+WEdrom2cWAi4w8b583eHaEY/Xt
 w8nw==
X-Gm-Message-State: AOJu0YzYBJmuTP/avn0BPPX3ffuuo+cRCbIXBict6PHSyElOULq7YirY
 v/d/EOsR29QGn4nPZuGvQCVIdCfNZpNFLg6+Oa4fG67Ta7GNXYYZrWng17M6f04InizoUdQxVxF
 wKZdz
X-Gm-Gg: ASbGncv1IZ1EwYDQokc8ZIvZSPFAD5Uhn0aUskhgmRuYUQWuNK3hgFhBTew3mKD3cPi
 ZUm4lG/RI2kfIiw3JJWa4GXqU4fl9WpAvlL/U46w+iC+dwbzIXMdBXFLGWfBQZW8VVXAfbAwY1M
 ABEgxhVbCM+NLjsYJJIbC0s8fP+eb79IJ0R+j5S1QA/TGWPFkLF17cd/C8H8GhPgYLq3WslViQP
 rb4GSS2SCSd5X3A6Yt0boB1ydqPDDL/8PpvWaFZqpmGx1LSFVfxn1dDKduwZQKHBGwJ/DGXnZ4L
 r8S+phJiUlLtRlXsZfcRhkTgeWAP1Kp6E4dKoJUIxDYLmx5njwzhOTx3b+/sDjkCplLXgWGhSoJ
 p7JgZQNidHm97xHp5T1vN9Uf8T4e75CpHH9fHp1UI+PSXmoYcUjdATygXp78dwKzV41i1oXVj7n
 QBsf9EY2dmRq1A
X-Google-Smtp-Source: AGHT+IH5jtyoA0c0XrjC51fQWXyeNpZNhv7ZVgXoI6bjK/JJuem5B6tIRpVWRKgtsFlQtwbnn6wMgg==
X-Received: by 2002:a05:6000:2484:b0:42b:3298:4690 with SMTP id
 ffacd0b85a97d-42f731a523emr7770016f8f.33.1764871581928; 
 Thu, 04 Dec 2025 10:06:21 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:d817:b2ba:2766:5b2a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331e29sm4589641f8f.32.2025.12.04.10.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 10:06:21 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 4/4] tests: Add test for ASID2 and write/read of feature bits
Date: Thu,  4 Dec 2025 18:04:14 +0000
Message-ID: <20251204180617.1190660-5-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204180617.1190660-1-jim.macarthur@linaro.org>
References: <20251204180617.1190660-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32f.google.com
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
 tests/tcg/aarch64/system/asid2.c | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/asid2.c

diff --git a/tests/tcg/aarch64/system/asid2.c b/tests/tcg/aarch64/system/asid2.c
new file mode 100644
index 0000000000..7d5466af34
--- /dev/null
+++ b/tests/tcg/aarch64/system/asid2.c
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ * ASID2 Feature presence and enabled TCR2_EL1 bits test
+ *
+ * Copyright (c) 2025 Linaro Ltd
+ *
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
+    asm("mrs %[idreg3], " ID_AA64MMFR3_EL1 "\n\t"
+        : [idreg3] "=r" (idreg3));
+
+    tcr2_present = ((idreg3 & 0xF) != 0);
+
+    if (!tcr2_present) {
+        ml_printf("TCR2 is not present, cannot perform test");
+        return 0;
+    }
+
+    asm("mrs %[idreg4], " ID_AA64MMFR4_EL1 "\n\t"
+        : [idreg4] "=r" (idreg4));
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


