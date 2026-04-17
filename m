Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2754F436B4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDmIN-0003S3-JV; Fri, 17 Apr 2026 12:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI4-0003OE-QK
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI1-0004rz-JI
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so11791265e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776444212; x=1777049012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoM5YIgDCI4LaK2PcP9hwlCuHqwwsV6FnJoskoTZop4=;
 b=L1DEPqMMO8PA+XCP4exq6cwa66CjOcBcHoV8dcaJpW6IheqPNqQoOgNRyI/QJQ97Rb
 EyGbhCu6uinFuw3uFxUwLaRriO/Iaby0d1LWz3l8F4/LyJuElG9t1SNroSJ4MTc4YcPU
 npM1ywheVtOZF92ZDwY6BHxGZBNx0GpOicPqxDs6ZYdL0KKXEgAyatP1+mnaHVreRG3A
 Qkvr4RsU47lB55jmJAWplSRapSs+pAcLzAeABn01zg4YvPqQBDSD+PoyBKuktZb6I86V
 5r13ohkPY3G3IJs12oH8Oac1PA/6tuJ+W38KhgtedXuWIW1sKqKvDrLS9ocF1aVTHFry
 KvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444212; x=1777049012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CoM5YIgDCI4LaK2PcP9hwlCuHqwwsV6FnJoskoTZop4=;
 b=iaItdXMzkk3msfkLpu7uAJRWNuqzxDNwUV/wua/txugnjA8eD89qAvyVxKZQIA0Imy
 5dotCWS9qGThEnZ1MnVrMfcwwUxc/yJ/9CYR66OsgjyVeYdlbKMeq2veuxJy0sJbKoLj
 bx60L05BEPUk90nNnHOMdWd/A+hEzMa5a0sCaOH2uIX9ZvU06Tl3loIvnSCoj0KB4hBD
 7kwK4/8ZFFSKGIvYTgARmQWniHCs76NNMYgZpKYPDnVByXw7wD58fhwMuHaPBDPI72BK
 lvVUMDdYreDxEIr7n00P8jUMpXySo2aVXRROLEI5tZOcfUzYH4XcYvzE8OqK1SAn0IXw
 SYuA==
X-Gm-Message-State: AOJu0YzHHe562AywgszPPqcJ8yz1pvTAqzdYAcPRhd6FtuDwrQRfMN4Y
 maanXhuiBImPG2B8b4P+yyp44iT29dlCCI4+IDeDfH9z1cQHGFhEjHDp3Uc4QswPTNV411udsPC
 ZMcHVWQo=
X-Gm-Gg: AeBDieuN9nEv9Qvt9p39h/rPaLEXkJrOsLYYj/K1IHxVNkBZslu9fea7fx7W54vOxGp
 s08qFBDYq6kyzWRy2N4luczLoV6Dkkf8QnQhOzcginp5WbsIRUQxvlmlvLpHH3NOa4mxPXq4vIx
 2AE7JG6YmRlYctl/tDU6HuaUvD/xY072fwAMF7K15PqK6crB2nvFX/Ph4TpBjG00tscFi5yTIk8
 qwqujSWrHwFU2n1oW+s4qqzfE3SoLgFaBQz4quJ8DMghtgSfD6vriq2VocV9yIK0SpglC1/Frb7
 FCSeOiT+/ldyvyRV5l3dj6yqAYNtmIUSvkPjgnHZ44S44shC92I22cIe5+CJXr5ep3FbDdTgz3m
 lBO7kRO0nAg/u8e878tp2tmBXYGIfGER4OWkTRZ89TuRwlhJnIB5Sr45nNL/KMN4gozdneqJoKU
 JzEcRMa7KmYhUdiUPGbZlIqUo1CMnE8fYPfg==
X-Received: by 2002:a05:600c:c089:b0:487:1fc:14f9 with SMTP id
 5b1f17b1804b1-488fb771576mr37520525e9.15.1776444211998; 
 Fri, 17 Apr 2026 09:43:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb794e26sm29177745e9.6.2026.04.17.09.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:43:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B459A5F9CE;
 Fri, 17 Apr 2026 17:43:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/7] tests/tcg: convert aarch64 asid2 test to use sysreg
 helpers
Date: Fri, 17 Apr 2026 17:43:23 +0100
Message-ID: <20260417164328.1009132-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417164328.1009132-1-alex.bennee@linaro.org>
References: <20260417164328.1009132-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

While we are at it we can reduce the number of temporary variables
needed and fix a format string error.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/asid2.c | 35 ++++++++++++++------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/tests/tcg/aarch64/system/asid2.c b/tests/tcg/aarch64/system/asid2.c
index 7d5466af34a..8c93024b858 100644
--- a/tests/tcg/aarch64/system/asid2.c
+++ b/tests/tcg/aarch64/system/asid2.c
@@ -9,10 +9,11 @@
 
 #include <stdint.h>
 #include <minilib.h>
+#include "sysregs.h"
 
-#define ID_AA64MMFR3_EL1 "S3_0_C0_C7_3"
-#define ID_AA64MMFR4_EL1 "S3_0_C0_C7_4"
-#define TCR2_EL1 "S3_0_C2_C0_3"
+#define ID_AA64MMFR3_EL1 S3_0_C0_C7_3
+#define ID_AA64MMFR4_EL1 S3_0_C0_C7_4
+#define TCR2_EL1 S3_0_C2_C0_3
 
 int main()
 {
@@ -23,7 +24,7 @@ int main()
      * not enabled and read as the written value if A2 is enabled.
      */
 
-    uint64_t out;
+    uint64_t read_tcr2;
     uint64_t idreg3;
     uint64_t idreg4;
     int tcr2_present;
@@ -31,11 +32,8 @@ int main()
 
     /* Mask is FNG1, FNG0, and A2 */
     const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
-    const uint64_t in = feature_mask;
-
-    asm("mrs %[idreg3], " ID_AA64MMFR3_EL1 "\n\t"
-        : [idreg3] "=r" (idreg3));
 
+    idreg3 = read_sysreg(ID_AA64MMFR3_EL1);
     tcr2_present = ((idreg3 & 0xF) != 0);
 
     if (!tcr2_present) {
@@ -43,33 +41,30 @@ int main()
         return 0;
     }
 
-    asm("mrs %[idreg4], " ID_AA64MMFR4_EL1 "\n\t"
-        : [idreg4] "=r" (idreg4));
-
+    idreg4 = read_sysreg(ID_AA64MMFR4_EL1);
     asid2_present = ((idreg4 & 0xF00) != 0);
 
-    asm("msr " TCR2_EL1 ", %[x0]\n\t"
-        "mrs %[x1], " TCR2_EL1 "\n\t"
-        : [x1] "=r" (out)
-        : [x0] "r" (in));
+    /* write the feature mask and read back */
+    write_sysreg(feature_mask, TCR2_EL1);
+    read_tcr2 = read_sysreg(TCR2_EL1);
 
     if (asid2_present) {
-        if ((out & feature_mask) == in) {
+        if ((read_tcr2 & feature_mask) == feature_mask) {
             ml_printf("OK\n");
             return 0;
         } else {
             ml_printf("FAIL: ASID2 present, but read value %lx != "
                       "written value %lx\n",
-                      out & feature_mask, in);
+                      read_tcr2 & feature_mask, feature_mask);
             return 1;
         }
     } else {
-        if (out == 0) {
+        if (read_tcr2 == 0) {
             ml_printf("TCR2_EL1 reads as RES0 as expected\n");
             return 0;
         } else {
-            ml_printf("FAIL: ASID2, missing but read value %lx != 0\n",
-                      out & feature_mask, in);
+            ml_printf("FAIL: ASID2, missing but read value %lx != %lx\n",
+                      read_tcr2 & feature_mask, feature_mask);
             return 1;
         }
     }
-- 
2.47.3


