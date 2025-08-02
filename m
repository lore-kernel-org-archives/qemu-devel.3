Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274B0C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLxs-0006De-FA; Sat, 02 Aug 2025 19:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLsE-0004aX-FV
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:42:53 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLsC-0006tl-Rj
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:42:46 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71a39f93879so43443217b3.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754178163; x=1754782963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1ak1ZU/AR0+1y4HNoJj/qDB25/smzJJgjU2bzP6iSw=;
 b=bHVFX6cRhnJ5h2MOrnOub9olzuajmAnB5ToZ4/h/vhjlXtna3EnbbS32KCr2lYLi7v
 t9Kl4Ml8IyjzIsY1GsCM/5Av8uwQlzRvOFAdcSBs56Hw7SpCkug3KnI/P0ASO8kfe2fy
 4WMdicdTrRlP2xrlCpizJeZJF4cDBsqaxBIU0W0sjJUKM2dfWJ8/WXTcbnkosv+wyK/G
 L+m54hJhEaIeunNAeXir+QGzArrlwb4iUoJUCSsvkrFMbi4acBf5XIUbqQqyfnlOkGMj
 oMo9s0dquRJzo8fn+/W4c5YPriXfcwvA3pPQ9hXP6OTylfy0kMzEs78+F55Y8+mrmKhU
 BfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754178163; x=1754782963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1ak1ZU/AR0+1y4HNoJj/qDB25/smzJJgjU2bzP6iSw=;
 b=Oga5TPoBuqJExaDCxQjwvtGEQeAxdDs31CoDmqFI2W5M+cI/6A8GDTPNTtVk/MYTXK
 2ZWu3Wh/UQ/deESJaW5osbOCULfk7uO/1linzhlgf3WCEZt84afiYJ5mQf7lYO9Gqgae
 CRRGwPfjo6G9HVd6c1i3UVJH+1wgmWWjlQvuzxb2GyMKbzpg+CFSl9gt+TFbPOhMcoLD
 ahQaIt+3+4xGgPrVEeYm+640H1ssdpzwxhauvWE32uB8C+3XaITUCZ8e4cRPYbTZ1PLf
 dTm/N2EZvtiYPtNZIcDSlzT/TQ4oJ1I7Sccg5EcuS8V4PX25d0ih9svxwT0qx2WEF3Gf
 Fn1g==
X-Gm-Message-State: AOJu0YzIYquU6yPSVvb+ldi9OOVLZuvQDvA+uZv5OIvO2/JoHH2Opm3F
 Dgc7UBSZ7Tu1eAwwAoFy/pj1DXMa8yIWEtEjtxvKR6mT5BDFe0UNnoes8NCncs/+/8ohYwpOMy3
 lV5As/zI=
X-Gm-Gg: ASbGncs7m9h3qUui17LcRNag0yTfXZ10d/bFrBiN0MCy+I16rXAuEiaBwVRQhVJKD2Q
 2qvTp/aI6Pjz10oj/h7shMUx4HobGTLOvWTB+682/NOs7NMnMlv+r00AQdj69edoO8xFML8B4gA
 KLU6Si82Qn6irj+g6R4cTuEixhCdMTQ/hDIrU99B8vyH7XW501cFc4jArFIU7Xgbuhq2ErVwUaE
 nb0yuJgJoKcsR7JVNxAnCmokOJ071HEy11Zvti32ag7+7cAshw2NMQCGkruEKOF5xvWZ2O3qAsT
 ysIR1yZR004all1vHsgmxV2AZd1bkd+nOvK+UFYOSk3TyhipedmobTCXVCC+7U7AwJm5rLQuhUe
 N8G1aUKhuSKOSt7WS0SgRoMLnpI2hPJU89K76verevEudbnsQ4JHE
X-Google-Smtp-Source: AGHT+IF9NFvaNOKhXcz62pjxStwnQKSB/FE6G2Hf22mP9LCryNxA4mVg0eE/bEQplMzcpntFJv0hWA==
X-Received: by 2002:a05:690c:660f:b0:71a:231b:d046 with SMTP id
 00721157ae682-71b5a6e54fbmr143797507b3.2.1754178163565; 
 Sat, 02 Aug 2025 16:42:43 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a423f38sm18461527b3.40.2025.08.02.16.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:42:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 85/85] tests/tcg/aarch64: Add gcsss
Date: Sun,  3 Aug 2025 09:29:53 +1000
Message-ID: <20250802232953.413294-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1132.google.com
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

Validate stack switching and recursion depth.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/gcs.h           |  9 ++++
 tests/tcg/aarch64/gcsss.c         | 74 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gcsss.c

diff --git a/tests/tcg/aarch64/gcs.h b/tests/tcg/aarch64/gcs.h
index 99cb4d4e38..e821963cb8 100644
--- a/tests/tcg/aarch64/gcs.h
+++ b/tests/tcg/aarch64/gcs.h
@@ -69,3 +69,12 @@
 
 #define gcspr() \
     ({ uint64_t *r; asm volatile("mrs %0, s3_3_c2_c5_1" : "=r"(r)); r; })
+
+#define gcsss1(val) \
+    do {                                                                     \
+        asm volatile("sys #3, c7, c7, #2, %0" : : "r"(val) : "memory");      \
+    } while (0)
+
+#define gcsss2() \
+    ({ uint64_t *r;                                                          \
+       asm volatile("sysl %0, #3, c7, c7, #3" : "=r"(r) : : "memory"); r; })
diff --git a/tests/tcg/aarch64/gcsss.c b/tests/tcg/aarch64/gcsss.c
new file mode 100644
index 0000000000..9550c68e7e
--- /dev/null
+++ b/tests/tcg/aarch64/gcsss.c
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "gcs.h"
+
+#define IN_PROGRESS(X)  ((uint64_t)(X) | 5)
+#define CAP(X)          (((uint64_t)(X) & ~0xfff) + 1)
+
+static uint64_t * __attribute__((noinline)) recurse(size_t index)
+{
+    if (index == 0) {
+        return gcspr();
+    }
+    return recurse(index - 1);
+}
+
+int main()
+{
+    void *tmp;
+    uint64_t *alt_stack, *alt_cap;
+    uint64_t *orig_pr, *orig_cap;
+    uint64_t *bottom;
+    size_t pagesize = getpagesize();
+    size_t words;
+
+    enable_gcs(0);
+    orig_pr = gcspr();
+
+    /* Allocate a guard page before and after. */
+    tmp = mmap(0, 3 * pagesize, PROT_NONE, MAP_ANON | MAP_PRIVATE, -1, 0);
+    assert(tmp != MAP_FAILED);
+
+    /* map_shadow_stack won't replace existing mappings */
+    munmap(tmp + pagesize, pagesize);
+
+    /* Allocate a new stack between the guards. */
+    alt_stack = (uint64_t *)
+        syscall(__NR_map_shadow_stack, tmp + pagesize, pagesize,
+                SHADOW_STACK_SET_TOKEN);
+    assert(alt_stack == tmp + pagesize);
+
+    words = pagesize / 8;
+    alt_cap = alt_stack + words - 1;
+
+    /* SHADOW_STACK_SET_TOKEN set the cap. */
+    assert(*alt_cap == CAP(alt_cap));
+
+    /* Swap to the alt stack, one step at a time. */
+    gcsss1(alt_cap);
+
+    assert(gcspr() == alt_cap);
+    assert(*alt_cap == IN_PROGRESS(orig_pr));
+
+    orig_cap = gcsss2();
+
+    assert(orig_cap == orig_pr - 1);
+    assert(*orig_cap == CAP(orig_cap));
+    assert(gcspr() == alt_stack + words);
+
+    /* We should be able to use the whole stack. */
+    bottom = recurse(words - 1);
+    assert(bottom == alt_stack);
+
+    /* We should be back where we started. */
+    assert(gcspr() == alt_stack + words);
+
+    /* Swap back to the original stack. */
+    gcsss1(orig_cap);
+    tmp = gcsss2();
+
+    assert(gcspr() == orig_pr);
+    assert(tmp == alt_cap);
+
+    exit(0);
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index c6f401c317..b858f8692e 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -76,7 +76,7 @@ $(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # GCS Tests
-GCS_TESTS += gcsstr gcspushm
+GCS_TESTS += gcsstr gcspushm gcsss
 AARCH64_TESTS += $(GCS_TESTS)
 $(GCS_TESTS): gcs.h
 
-- 
2.43.0


