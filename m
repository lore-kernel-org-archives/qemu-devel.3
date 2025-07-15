Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A842EC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ1N-0002XU-44; Tue, 15 Jul 2025 02:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1D-0002Q3-Lk
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:59 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ17-000756-RD
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:57 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ab112dea41so2725298f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560392; x=1753165192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3MLTcRuffySxmo9fZCX5euu5HiVw+PIWupCatub9TA=;
 b=WvvOKxeOJ+ih6ZgZEtEawQ62CYJ8PRAePKQug19v/p/PlEadmpVKl8PsgXOWWAJUbk
 h/2L1LckHxxXA8VugNtohAik9/U5Xov2825z0oN7GofQ+NRFAR6aTIMgRc9ncfH329ag
 5rYq5WJye8HXmtzQnqCIstODjedA52l4RZy5ZjHoDM0MHACPLE21ltOSJLUrXakZ2QWm
 TBTn67MWyuB16I8UCLumPlYxU/RqIIQY4GXlfAqc1OOH9EAWd0/keNYToVhLpcNzUggZ
 KKAP1kXvCniNLRfK+LNMpdqmZGG1GcWtz8wOImZdTLmGFIdssSI+9ekbUYBqrnGPldiY
 Otrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560392; x=1753165192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3MLTcRuffySxmo9fZCX5euu5HiVw+PIWupCatub9TA=;
 b=aUTrqBlX3KvM24AfhX0vXBRzKHvzcfA7Xj56gCxZEiqSWaCw2uwjZr4k3p9U4C8VEA
 yuZ1RzxCnEsDij0gqvHnPXdeWzsHNc1r7ZDfe0oVm5thraPIg6ZIqCPcpck1tN6chV/9
 07KqEpKJ4K0yLnO1tlE5m9PmyfU82gJKRcYSWZ6CL3eCE6mF3NzfJUD2KFjE/2zrqFaG
 l7ZyeR1tZTfWtLyvHLtM1kWn6If9zBA3v6iD4VIvJ506IfcFQi7vaklga3h8X2HRxEYO
 YvBq8Onp+vy6ML/me7icIZqaW49ajdUSeT0iW7dtF1KjHmjcK07fliD3/3EGcWs6r4rk
 TrSw==
X-Gm-Message-State: AOJu0Yx8GryqV+51voFq2xhdo/SS4Lv7zIeI72k8IZ5IzUYzSP3f0NI6
 28GzkW31jTVre/bM2W8yB8Yosk8Q8xOx6BQns8aSE0WjJL4QMUIJ2DTRN9RcKoJ+QTkbgKYzNLB
 VPZsP
X-Gm-Gg: ASbGncvW9HB2odzBONILzUxjkwgZYzqTP1IVBWKMzQqHzMr64mEpOBoe/qPlHgGrNM7
 DURSJkNdCEsrL7rrRfJ5IQ3Hsm9CCh2s5/HlxA5NyWnLaZNIyxvhLUADe4b6nA5vqkfFhGwOBrx
 VPPHFBY1fQCCi9B07/gKUP+yrz6cTVgcVBHl2JZe6haGxTtt25nj4Y9TrE53SysiyQbAPhKCBJn
 FXkptEmPfK6K38z03thZHzuOfNYY9I9i+hT4vHidnLjgrUQmH+8S+SdKextsQIjORrqM1Y1w3dw
 Y154OdVwC/kJGfrkfrpjEXv5Ahoh9cPeC4rb6jrSFxh6IFgC2M1eoxvBh7BInMQmOxD6E+daIWh
 jO44toCARB1sDCuMeKB3Tw+PANrfnpv+MulbjZ9kH+rXqWYhgCqODwRVwA1Fuvoapyl9EkGw3
X-Google-Smtp-Source: AGHT+IHqUP9MTR6WKxixK7k0vLBdS+ARvfTSNxCFAURB+Bk6495ZZ6+eCi52/NogwdOu2okG/t8mBw==
X-Received: by 2002:a05:6000:25c1:b0:3a4:e4ee:4ca9 with SMTP id
 ffacd0b85a97d-3b5f35416b9mr10329750f8f.23.1752560391291; 
 Mon, 14 Jul 2025 23:19:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d77asm14541552f8f.58.2025.07.14.23.19.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:19:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 Yongbok Kim <yongbok.kim@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 06/17] tests/tcg/mips: Add tests for MIPS CRC32[c] instructions
Date: Tue, 15 Jul 2025 08:19:06 +0200
Message-ID: <20250715061918.44971-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
Message-ID: <20250214173702.2308488-3-aleksandar.rakic@htecgroup.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/tcg/mips/include/wrappers_mips64r6.h    |  32 ++++
 .../isa/mips64r6/crc/test_mips64r6_crc32b.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cb.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cd.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32ch.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cw.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32d.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32h.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32w.c   | 142 ++++++++++++++++++
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  40 +++++
 10 files changed, 1208 insertions(+)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile

diff --git a/tests/tcg/mips/include/wrappers_mips64r6.h b/tests/tcg/mips/include/wrappers_mips64r6.h
index d1e5edb632e..33d03de50b2 100644
--- a/tests/tcg/mips/include/wrappers_mips64r6.h
+++ b/tests/tcg/mips/include/wrappers_mips64r6.h
@@ -23,6 +23,7 @@
 #ifndef WRAPPERS_MIPS64R6_H
 #define WRAPPERS_MIPS64R6_H
 
+#include <string.h>
 
 #define DO_MIPS64R6__RD__RS(suffix, mnemonic)                          \
 static inline void do_mips64r6_##suffix(const void *input,             \
@@ -80,4 +81,35 @@ DO_MIPS64R6__RD__RS_RT(DMULU, dmulu)
 DO_MIPS64R6__RD__RS_RT(DMUHU, dmuhu)
 
 
+#define DO_MIPS64R6__RT__RS_RT(suffix, mnemonic)                       \
+static inline void do_mips64r6_##suffix(const void *input1,            \
+                                        const void *input2,            \
+                                        void *output)                  \
+{                                                                      \
+    if (strncmp(#mnemonic, "crc32", 5) == 0)                           \
+        __asm__ volatile (                                             \
+           ".set crc\n\t"                                              \
+        );                                                             \
+                                                                       \
+   __asm__ volatile (                                                  \
+      "ld $t1, 0(%0)\n\t"                                              \
+      "ld $t2, 0(%1)\n\t"                                              \
+      #mnemonic " $t2, $t1, $t2\n\t"                                   \
+      "sd $t2, 0(%2)\n\t"                                              \
+      :                                                                \
+      : "r" (input1), "r" (input2), "r" (output)                       \
+      : "t0", "t1", "t2", "memory"                                     \
+   );                                                                  \
+}
+
+DO_MIPS64R6__RT__RS_RT(CRC32B, crc32b)
+DO_MIPS64R6__RT__RS_RT(CRC32H, crc32h)
+DO_MIPS64R6__RT__RS_RT(CRC32W, crc32w)
+DO_MIPS64R6__RT__RS_RT(CRC32D, crc32d)
+
+DO_MIPS64R6__RT__RS_RT(CRC32CB, crc32cb)
+DO_MIPS64R6__RT__RS_RT(CRC32CH, crc32ch)
+DO_MIPS64R6__RT__RS_RT(CRC32CW, crc32cw)
+DO_MIPS64R6__RT__RS_RT(CRC32CD, crc32cd)
+
 #endif
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
new file mode 100644
index 00000000000..bb1f3f69249
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32B
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+int32_t main(void)
+{
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =   "CRC32B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000ffffffULL,                    /*   0  */
+        0x000000002d02ef8dULL,
+        0x000000001bab0fd1ULL,
+        0x0000000036561fa3ULL,
+        0xffffffffbf1caddaULL,
+        0xffffffff92e1bda8ULL,
+        0x00000000278c7949ULL,
+        0x000000000a71693bULL,
+        0x000000002dfd1072ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000036a9e05cULL,
+        0x000000001b54f02eULL,
+        0xffffffff921e4257ULL,
+        0xffffffffbfe35225ULL,
+        0x000000000a8e96c4ULL,
+        0x00000000277386b6ULL,
+        0x000000001bfe5a84ULL,                    /*  16  */
+        0x0000000036034af6ULL,
+        0x0000000000aaaaaaULL,
+        0x000000002d57bad8ULL,
+        0xffffffffa41d08a1ULL,
+        0xffffffff89e018d3ULL,
+        0x000000003c8ddc32ULL,
+        0x000000001170cc40ULL,
+        0x0000000036fcb509ULL,                    /*  24  */
+        0x000000001b01a57bULL,
+        0x000000002da84527ULL,
+        0x0000000000555555ULL,
+        0xffffffff891fe72cULL,
+        0xffffffffa4e2f75eULL,
+        0x00000000118f33bfULL,
+        0x000000003c7223cdULL,
+        0xffffffffbf2f9ee9ULL,                    /*  32  */
+        0xffffffff92d28e9bULL,
+        0xffffffffa47b6ec7ULL,
+        0xffffffff89867eb5ULL,
+        0x0000000000ccccccULL,
+        0x000000002d31dcbeULL,
+        0xffffffff985c185fULL,
+        0xffffffffb5a1082dULL,
+        0xffffffff922d7164ULL,                    /*  40  */
+        0xffffffffbfd06116ULL,
+        0xffffffff8979814aULL,
+        0xffffffffa4849138ULL,
+        0x000000002dce2341ULL,
+        0x0000000000333333ULL,
+        0xffffffffb55ef7d2ULL,
+        0xffffffff98a3e7a0ULL,
+        0x0000000027fdbe55ULL,                    /*  48  */
+        0x000000000a00ae27ULL,
+        0x000000003ca94e7bULL,
+        0x0000000011545e09ULL,
+        0xffffffff981eec70ULL,
+        0xffffffffb5e3fc02ULL,
+        0x00000000008e38e3ULL,
+        0x000000002d732891ULL,
+        0x000000000aff51d8ULL,                    /*  56  */
+        0x00000000270241aaULL,
+        0x0000000011aba1f6ULL,
+        0x000000003c56b184ULL,
+        0xffffffffb51c03fdULL,
+        0xffffffff98e1138fULL,
+        0x000000002d8cd76eULL,
+        0x000000000071c71cULL,
+        0x0000000000286255ULL,                    /*  64  */
+        0x00000000784a5a65ULL,
+        0xffffffff9bdd0d3bULL,
+        0xffffffffe7e61ce5ULL,
+        0x00000000782fabf7ULL,
+        0x00000000004d93c7ULL,
+        0xffffffffe3dac499ULL,
+        0xffffffff9fe1d547ULL,
+        0xffffffff9b4ca0e5ULL,                    /*  72  */
+        0xffffffffe32e98d5ULL,
+        0x0000000000b9cf8bULL,
+        0x000000007c82de55ULL,
+        0xffffffffe7904f52ULL,
+        0xffffffff9ff27762ULL,
+        0x000000007c65203cULL,
+        0x00000000005e31e2ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32B(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32B(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
new file mode 100644
index 00000000000..1439d44bf20
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CB
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+int32_t main(void)
+{
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =   "CRC32CB";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000ffffffULL,                    /*   0  */
+        0xffffffffad7d5351ULL,
+        0x00000000647e6465ULL,
+        0xffffffffc9fcc8cbULL,
+        0x00000000237f7689ULL,
+        0xffffffff8efdda27ULL,
+        0xffffffff837defedULL,
+        0x000000002eff4343ULL,
+        0xffffffffad82acaeULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xffffffffc9033734ULL,
+        0x0000000064819b9aULL,
+        0xffffffff8e0225d8ULL,
+        0x0000000023808976ULL,
+        0x000000002e00bcbcULL,
+        0xffffffff83821012ULL,
+        0x00000000642b3130ULL,                    /*  16  */
+        0xffffffffc9a99d9eULL,
+        0x0000000000aaaaaaULL,
+        0xffffffffad280604ULL,
+        0x0000000047abb846ULL,
+        0xffffffffea2914e8ULL,
+        0xffffffffe7a92122ULL,
+        0x000000004a2b8d8cULL,
+        0xffffffffc9566261ULL,                    /*  24  */
+        0x0000000064d4cecfULL,
+        0xffffffffadd7f9fbULL,
+        0x0000000000555555ULL,
+        0xffffffffead6eb17ULL,
+        0x00000000475447b9ULL,
+        0x000000004ad47273ULL,
+        0xffffffffe756deddULL,
+        0x00000000234c45baULL,                    /*  32  */
+        0xffffffff8ecee914ULL,
+        0x0000000047cdde20ULL,
+        0xffffffffea4f728eULL,
+        0x0000000000ccccccULL,
+        0xffffffffad4e6062ULL,
+        0xffffffffa0ce55a8ULL,
+        0x000000000d4cf906ULL,
+        0xffffffff8e3116ebULL,                    /*  40  */
+        0x0000000023b3ba45ULL,
+        0xffffffffeab08d71ULL,
+        0x00000000473221dfULL,
+        0xffffffffadb19f9dULL,
+        0x0000000000333333ULL,
+        0x000000000db306f9ULL,
+        0xffffffffa031aa57ULL,
+        0xffffffff830c28f1ULL,                    /*  48  */
+        0x000000002e8e845fULL,
+        0xffffffffe78db36bULL,
+        0x000000004a0f1fc5ULL,
+        0xffffffffa08ca187ULL,
+        0x000000000d0e0d29ULL,
+        0x00000000008e38e3ULL,
+        0xffffffffad0c944dULL,
+        0x000000002e717ba0ULL,                    /*  56  */
+        0xffffffff83f3d70eULL,
+        0x000000004af0e03aULL,
+        0xffffffffe7724c94ULL,
+        0x000000000df1f2d6ULL,
+        0xffffffffa0735e78ULL,
+        0xffffffffadf36bb2ULL,
+        0x000000000071c71cULL,
+        0x0000000000286255ULL,                    /*  64  */
+        0xffffffffcbefd6b4ULL,
+        0xffffffffc334e94fULL,
+        0xffffffffac268ec5ULL,
+        0xffffffffcb8a2726ULL,
+        0x00000000004d93c7ULL,
+        0x000000000896ac3cULL,
+        0x000000006784cbb6ULL,
+        0xffffffffc3a54491ULL,                    /*  72  */
+        0x000000000862f070ULL,
+        0x0000000000b9cf8bULL,
+        0x000000006faba801ULL,
+        0xffffffffac50dd72ULL,
+        0x0000000067976993ULL,
+        0x000000006f4c5668ULL,
+        0x00000000005e31e2ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CB(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CB(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
new file mode 100644
index 00000000000..bf258e0696d
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CD
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+int32_t main(void)
+{
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =   "CRC32CD";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0xffffffffb798b438ULL,                    /*   0  */
+        0xffffffffc44ff94dULL,
+        0xffffffff992a70ebULL,
+        0xffffffffeafd3d9eULL,
+        0x000000005152da26ULL,
+        0x0000000022859753ULL,
+        0x0000000015cb6d32ULL,
+        0x00000000661c2047ULL,
+        0x0000000073d74d75ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x000000005d6589a6ULL,
+        0x000000002eb2c4d3ULL,
+        0xffffffff951d236bULL,
+        0xffffffffe6ca6e1eULL,
+        0xffffffffd184947fULL,
+        0xffffffffa253d90aULL,
+        0x0000000008f9ceacULL,                    /*  16  */
+        0x000000007b2e83d9ULL,
+        0x00000000264b0a7fULL,
+        0x00000000559c470aULL,
+        0xffffffffee33a0b2ULL,
+        0xffffffff9de4edc7ULL,
+        0xffffffffaaaa17a6ULL,
+        0xffffffffd97d5ad3ULL,
+        0xffffffffccb637e1ULL,                    /*  24  */
+        0xffffffffbf617a94ULL,
+        0xffffffffe204f332ULL,
+        0xffffffff91d3be47ULL,
+        0x000000002a7c59ffULL,
+        0x0000000059ab148aULL,
+        0x000000006ee5eeebULL,
+        0x000000001d32a39eULL,
+        0x0000000021e3b01bULL,                    /*  32  */
+        0x000000005234fd6eULL,
+        0x000000000f5174c8ULL,
+        0x000000007c8639bdULL,
+        0xffffffffc729de05ULL,
+        0xffffffffb4fe9370ULL,
+        0xffffffff83b06911ULL,
+        0xfffffffff0672464ULL,
+        0xffffffffe5ac4956ULL,                    /*  40  */
+        0xffffffff967b0423ULL,
+        0xffffffffcb1e8d85ULL,
+        0xffffffffb8c9c0f0ULL,
+        0x0000000003662748ULL,
+        0x0000000070b16a3dULL,
+        0x0000000047ff905cULL,
+        0x000000003428dd29ULL,
+        0xffffffffb89d59a6ULL,                    /*  48  */
+        0xffffffffcb4a14d3ULL,
+        0xffffffff962f9d75ULL,
+        0xffffffffe5f8d000ULL,
+        0x000000005e5737b8ULL,
+        0x000000002d807acdULL,
+        0x000000001ace80acULL,
+        0x000000006919cdd9ULL,
+        0x000000007cd2a0ebULL,                    /*  56  */
+        0x000000000f05ed9eULL,
+        0x0000000052606438ULL,
+        0x0000000021b7294dULL,
+        0xffffffff9a18cef5ULL,
+        0xffffffffe9cf8380ULL,
+        0xffffffffde8179e1ULL,
+        0xffffffffad563494ULL,
+        0x000000003a358bb3ULL,                    /*  64  */
+        0xffffffff975446ebULL,
+        0x0000000041d37ad6ULL,
+        0x000000004be84fe1ULL,
+        0xffffffff9671b1b3ULL,
+        0x000000003b107cebULL,
+        0xffffffffed9740d6ULL,
+        0xffffffffe7ac75e1ULL,
+        0xffffffffa1489696ULL,                    /*  72  */
+        0x000000000c295bceULL,
+        0xffffffffdaae67f3ULL,
+        0xffffffffd09552c4ULL,
+        0x0000000042bd7071ULL,
+        0xffffffffefdcbd29ULL,
+        0x00000000395b8114ULL,
+        0x000000003360b423ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CD(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CD(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
new file mode 100644
index 00000000000..0e7b67732e0
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CH
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+int32_t main(void)
+{
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =   "CRC32CH";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x000000000000ffffULL,                    /*   0  */
+        0x000000000e9e77d2ULL,
+        0xfffffffff92eaa4bULL,
+        0xfffffffff7b02266ULL,
+        0x00000000571acc93ULL,
+        0x00000000598444beULL,
+        0xfffffffff1e6ca77ULL,
+        0xffffffffff78425aULL,
+        0x000000000e9e882dULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xfffffffff7b0dd99ULL,
+        0xfffffffff92e55b4ULL,
+        0x000000005984bb41ULL,
+        0x00000000571a336cULL,
+        0xffffffffff78bda5ULL,
+        0xfffffffff1e63588ULL,
+        0xfffffffff92eff1eULL,                    /*  16  */
+        0xfffffffff7b07733ULL,
+        0x000000000000aaaaULL,
+        0x000000000e9e2287ULL,
+        0xffffffffae34cc72ULL,
+        0xffffffffa0aa445fULL,
+        0x0000000008c8ca96ULL,
+        0x00000000065642bbULL,
+        0xfffffffff7b088ccULL,                    /*  24  */
+        0xfffffffff92e00e1ULL,
+        0x000000000e9edd78ULL,
+        0x0000000000005555ULL,
+        0xffffffffa0aabba0ULL,
+        0xffffffffae34338dULL,
+        0x000000000656bd44ULL,
+        0x0000000008c83569ULL,
+        0x00000000571affa0ULL,                    /*  32  */
+        0x000000005984778dULL,
+        0xffffffffae34aa14ULL,
+        0xffffffffa0aa2239ULL,
+        0x000000000000ccccULL,
+        0x000000000e9e44e1ULL,
+        0xffffffffa6fcca28ULL,
+        0xffffffffa8624205ULL,
+        0x0000000059848872ULL,                    /*  40  */
+        0x00000000571a005fULL,
+        0xffffffffa0aaddc6ULL,
+        0xffffffffae3455ebULL,
+        0x000000000e9ebb1eULL,
+        0x0000000000003333ULL,
+        0xffffffffa862bdfaULL,
+        0xffffffffa6fc35d7ULL,
+        0xfffffffff1e6bbb0ULL,                    /*  48  */
+        0xffffffffff78339dULL,
+        0x0000000008c8ee04ULL,
+        0x0000000006566629ULL,
+        0xffffffffa6fc88dcULL,
+        0xffffffffa86200f1ULL,
+        0x0000000000008e38ULL,
+        0x000000000e9e0615ULL,
+        0xffffffffff78cc62ULL,                    /*  56  */
+        0xfffffffff1e6444fULL,
+        0x00000000065699d6ULL,
+        0x0000000008c811fbULL,
+        0xffffffffa862ff0eULL,
+        0xffffffffa6fc7723ULL,
+        0x000000000e9ef9eaULL,
+        0x00000000000071c7ULL,
+        0x0000000000002862ULL,                    /*  64  */
+        0x000000001190c4cfULL,
+        0x000000007b7fdbbeULL,
+        0xffffffff9204da99ULL,
+        0x000000001190a13eULL,
+        0x0000000000004d93ULL,
+        0x000000006aef52e2ULL,
+        0xffffffff839453c5ULL,
+        0x000000007b7f4a13ULL,                    /*  72  */
+        0x000000006aefa6beULL,
+        0x000000000000b9cfULL,
+        0xffffffffe97bb8e8ULL,
+        0xffffffff9204accaULL,
+        0xffffffff83944067ULL,
+        0xffffffffe97b5f16ULL,
+        0x0000000000005e31ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CH(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CH(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
new file mode 100644
index 00000000000..f7110b3a0a4
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CW
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+int32_t main(void)
+{
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =   "CRC32CW";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000000ULL,                    /*   0  */
+        0xffffffffb798b438ULL,
+        0xffffffff91d3be47ULL,
+        0x00000000264b0a7fULL,
+        0x0000000070b16a3dULL,
+        0xffffffffc729de05ULL,
+        0x0000000063c5950aULL,
+        0xffffffffd45d2132ULL,
+        0xffffffffb798b438ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x00000000264b0a7fULL,
+        0xffffffff91d3be47ULL,
+        0xffffffffc729de05ULL,
+        0x0000000070b16a3dULL,
+        0xffffffffd45d2132ULL,
+        0x0000000063c5950aULL,
+        0xffffffff91d3be47ULL,                    /*  16  */
+        0x00000000264b0a7fULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0xffffffffe162d47aULL,
+        0x0000000056fa6042ULL,
+        0xfffffffff2162b4dULL,
+        0x00000000458e9f75ULL,
+        0x00000000264b0a7fULL,                    /*  24  */
+        0xffffffff91d3be47ULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0x0000000056fa6042ULL,
+        0xffffffffe162d47aULL,
+        0x00000000458e9f75ULL,
+        0xfffffffff2162b4dULL,
+        0x0000000070b16a3dULL,                    /*  32  */
+        0xffffffffc729de05ULL,
+        0xffffffffe162d47aULL,
+        0x0000000056fa6042ULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0x000000001374ff37ULL,
+        0xffffffffa4ec4b0fULL,
+        0xffffffffc729de05ULL,                    /*  40  */
+        0x0000000070b16a3dULL,
+        0x0000000056fa6042ULL,
+        0xffffffffe162d47aULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0xffffffffa4ec4b0fULL,
+        0x000000001374ff37ULL,
+        0x0000000063c5950aULL,                    /*  48  */
+        0xffffffffd45d2132ULL,
+        0xfffffffff2162b4dULL,
+        0x00000000458e9f75ULL,
+        0x000000001374ff37ULL,
+        0xffffffffa4ec4b0fULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0xffffffffd45d2132ULL,                    /*  56  */
+        0x0000000063c5950aULL,
+        0x00000000458e9f75ULL,
+        0xfffffffff2162b4dULL,
+        0xffffffffa4ec4b0fULL,
+        0x000000001374ff37ULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  64  */
+        0xffffffffea0755b2ULL,
+        0x0000000008b188e6ULL,
+        0xffffffffff3cc8d9ULL,
+        0xffffffffea0755b2ULL,
+        0x0000000000000000ULL,
+        0xffffffffe2b6dd54ULL,
+        0x00000000153b9d6bULL,
+        0x0000000008b188e6ULL,                    /*  72  */
+        0xffffffffe2b6dd54ULL,
+        0x0000000000000000ULL,
+        0xfffffffff78d403fULL,
+        0xffffffffff3cc8d9ULL,
+        0x00000000153b9d6bULL,
+        0xfffffffff78d403fULL,
+        0x0000000000000000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CW(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CW(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
new file mode 100644
index 00000000000..e391be803f7
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32D
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+int32_t main(void)
+{
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =   "CRC32D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0xffffffffdebb20e3ULL,                    /*   0  */
+        0x0000000044660075ULL,
+        0x000000001e20c2aeULL,
+        0xffffffff84fde238ULL,
+        0x00000000281d7ce7ULL,
+        0xffffffffb2c05c71ULL,
+        0xffffffffd660a024ULL,
+        0x000000004cbd80b2ULL,
+        0xffffffff9add2096ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x000000005a46c2dbULL,
+        0xffffffffc09be24dULL,
+        0x000000006c7b7c92ULL,
+        0xfffffffff6a65c04ULL,
+        0xffffffff9206a051ULL,
+        0x0000000008db80c7ULL,
+        0x000000005449dd0fULL,                    /*  16  */
+        0xffffffffce94fd99ULL,
+        0xffffffff94d23f42ULL,
+        0x000000000e0f1fd4ULL,
+        0xffffffffa2ef810bULL,
+        0x000000003832a19dULL,
+        0x000000005c925dc8ULL,
+        0xffffffffc64f7d5eULL,
+        0x00000000102fdd7aULL,                    /*  24  */
+        0xffffffff8af2fdecULL,
+        0xffffffffd0b43f37ULL,
+        0x000000004a691fa1ULL,
+        0xffffffffe689817eULL,
+        0x000000007c54a1e8ULL,
+        0x0000000018f45dbdULL,
+        0xffffffff82297d2bULL,
+        0xffffffffa7157447ULL,                    /*  32  */
+        0x000000003dc854d1ULL,
+        0x00000000678e960aULL,
+        0xfffffffffd53b69cULL,
+        0x0000000051b32843ULL,
+        0xffffffffcb6e08d5ULL,
+        0xffffffffafcef480ULL,
+        0x000000003513d416ULL,
+        0xffffffffe3737432ULL,                    /*  40  */
+        0x0000000079ae54a4ULL,
+        0x0000000023e8967fULL,
+        0xffffffffb935b6e9ULL,
+        0x0000000015d52836ULL,
+        0xffffffff8f0808a0ULL,
+        0xffffffffeba8f4f5ULL,
+        0x000000007175d463ULL,
+        0x000000007a6adc3eULL,                    /*  48  */
+        0xffffffffe0b7fca8ULL,
+        0xffffffffbaf13e73ULL,
+        0x00000000202c1ee5ULL,
+        0xffffffff8ccc803aULL,
+        0x000000001611a0acULL,
+        0x0000000072b15cf9ULL,
+        0xffffffffe86c7c6fULL,
+        0x000000003e0cdc4bULL,                    /*  56  */
+        0xffffffffa4d1fcddULL,
+        0xfffffffffe973e06ULL,
+        0x00000000644a1e90ULL,
+        0xffffffffc8aa804fULL,
+        0x000000005277a0d9ULL,
+        0x0000000036d75c8cULL,
+        0xffffffffac0a7c1aULL,
+        0xffffffffed857593ULL,                    /*  64  */
+        0xffffffffe0b6f95fULL,
+        0x00000000253b462cULL,
+        0xffffffffe15579b9ULL,
+        0x0000000074897c83ULL,
+        0x0000000079baf04fULL,
+        0xffffffffbc374f3cULL,
+        0x00000000785970a9ULL,
+        0xffffffffa6bae0a9ULL,                    /*  72  */
+        0xffffffffab896c65ULL,
+        0x000000006e04d316ULL,
+        0xffffffffaa6aec83ULL,
+        0x000000005ae171feULL,
+        0x0000000057d2fd32ULL,
+        0xffffffff925f4241ULL,
+        0x0000000056317dd4ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32D(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32D(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
new file mode 100644
index 00000000000..100f02c7dda
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32H
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+int32_t main(void)
+{
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =   "CRC32H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x000000000000ffffULL,                    /*   0  */
+        0xffffffffbe2612ffULL,
+        0xffffffffdccda6c0ULL,
+        0x0000000062eb4bc0ULL,
+        0x000000004bbbc8eaULL,
+        0xfffffffff59d25eaULL,
+        0x0000000022259ac0ULL,
+        0xffffffff9c0377c0ULL,
+        0xffffffffbe26ed00ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000062ebb43fULL,
+        0xffffffffdccd593fULL,
+        0xfffffffff59dda15ULL,
+        0x000000004bbb3715ULL,
+        0xffffffff9c03883fULL,
+        0x000000002225653fULL,
+        0xffffffffdccdf395ULL,                    /*  16  */
+        0x0000000062eb1e95ULL,
+        0x000000000000aaaaULL,
+        0xffffffffbe2647aaULL,
+        0xffffffff9776c480ULL,
+        0x0000000029502980ULL,
+        0xfffffffffee896aaULL,
+        0x0000000040ce7baaULL,
+        0x0000000062ebe16aULL,                    /*  24  */
+        0xffffffffdccd0c6aULL,
+        0xffffffffbe26b855ULL,
+        0x0000000000005555ULL,
+        0x000000002950d67fULL,
+        0xffffffff97763b7fULL,
+        0x0000000040ce8455ULL,
+        0xfffffffffee86955ULL,
+        0x000000004bbbfbd9ULL,                    /*  32  */
+        0xfffffffff59d16d9ULL,
+        0xffffffff9776a2e6ULL,
+        0x0000000029504fe6ULL,
+        0x000000000000ccccULL,
+        0xffffffffbe2621ccULL,
+        0x00000000699e9ee6ULL,
+        0xffffffffd7b873e6ULL,
+        0xfffffffff59de926ULL,                    /*  40  */
+        0x000000004bbb0426ULL,
+        0x000000002950b019ULL,
+        0xffffffff97765d19ULL,
+        0xffffffffbe26de33ULL,
+        0x0000000000003333ULL,
+        0xffffffffd7b88c19ULL,
+        0x00000000699e6119ULL,
+        0x000000002225eb07ULL,                    /*  48  */
+        0xffffffff9c030607ULL,
+        0xfffffffffee8b238ULL,
+        0x0000000040ce5f38ULL,
+        0x00000000699edc12ULL,
+        0xffffffffd7b83112ULL,
+        0x0000000000008e38ULL,
+        0xffffffffbe266338ULL,
+        0xffffffff9c03f9f8ULL,                    /*  56  */
+        0x00000000222514f8ULL,
+        0x0000000040cea0c7ULL,
+        0xfffffffffee84dc7ULL,
+        0xffffffffd7b8ceedULL,
+        0x00000000699e23edULL,
+        0xffffffffbe269cc7ULL,
+        0x00000000000071c7ULL,
+        0x0000000000002862ULL,                    /*  64  */
+        0x0000000026a17af6ULL,
+        0xffffffffaa919152ULL,
+        0xffffffffcb865590ULL,
+        0x0000000026a11f07ULL,
+        0x0000000000004d93ULL,
+        0xffffffff8c30a637ULL,
+        0xffffffffed2762f5ULL,
+        0xffffffffaa9100ffULL,                    /*  72  */
+        0xffffffff8c30526bULL,
+        0x000000000000b9cfULL,
+        0x0000000061177d0dULL,
+        0xffffffffcb8623c3ULL,
+        0xffffffffed277157ULL,
+        0x0000000061179af3ULL,
+        0x0000000000005e31ULL
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32H(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32H(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
new file mode 100644
index 00000000000..b4f5f4bbee2
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32W
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+int32_t main(void)
+{
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =   "CRC32W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000000ULL,                    /*   0  */
+        0xffffffffdebb20e3ULL,
+        0x000000004a691fa1ULL,
+        0xffffffff94d23f42ULL,
+        0xffffffff8f0808a0ULL,
+        0x0000000051b32843ULL,
+        0x0000000065069dceULL,
+        0xffffffffbbbdbd2dULL,
+        0xffffffffdebb20e3ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xffffffff94d23f42ULL,
+        0x000000004a691fa1ULL,
+        0x0000000051b32843ULL,
+        0xffffffff8f0808a0ULL,
+        0xffffffffbbbdbd2dULL,
+        0x0000000065069dceULL,
+        0x000000004a691fa1ULL,                    /*  16  */
+        0xffffffff94d23f42ULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffc5611701ULL,
+        0x000000001bda37e2ULL,
+        0x000000002f6f826fULL,
+        0xfffffffff1d4a28cULL,
+        0xffffffff94d23f42ULL,                    /*  24  */
+        0x000000004a691fa1ULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x000000001bda37e2ULL,
+        0xffffffffc5611701ULL,
+        0xfffffffff1d4a28cULL,
+        0x000000002f6f826fULL,
+        0xffffffff8f0808a0ULL,                    /*  32  */
+        0x0000000051b32843ULL,
+        0xffffffffc5611701ULL,
+        0x000000001bda37e2ULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffea0e956eULL,
+        0x0000000034b5b58dULL,
+        0x0000000051b32843ULL,                    /*  40  */
+        0xffffffff8f0808a0ULL,
+        0x000000001bda37e2ULL,
+        0xffffffffc5611701ULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x0000000034b5b58dULL,
+        0xffffffffea0e956eULL,
+        0x0000000065069dceULL,                    /*  48  */
+        0xffffffffbbbdbd2dULL,
+        0x000000002f6f826fULL,
+        0xfffffffff1d4a28cULL,
+        0xffffffffea0e956eULL,
+        0x0000000034b5b58dULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffbbbdbd2dULL,                    /*  56  */
+        0x0000000065069dceULL,
+        0xfffffffff1d4a28cULL,
+        0x000000002f6f826fULL,
+        0x0000000034b5b58dULL,
+        0xffffffffea0e956eULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  64  */
+        0xffffffff90485967ULL,
+        0x000000006dfb974aULL,
+        0x00000000083e4538ULL,
+        0xffffffff90485967ULL,
+        0x0000000000000000ULL,
+        0xfffffffffdb3ce2dULL,
+        0xffffffff98761c5fULL,
+        0x000000006dfb974aULL,                    /*  72  */
+        0xfffffffffdb3ce2dULL,
+        0x0000000000000000ULL,
+        0x0000000065c5d272ULL,
+        0x00000000083e4538ULL,
+        0xffffffff98761c5fULL,
+        0x0000000065c5d272ULL,
+        0x0000000000000000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32W(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32W(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile b/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
new file mode 100644
index 00000000000..b7f5811a5e9
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
@@ -0,0 +1,40 @@
+#
+#  Test program for MIPS64R6 CRC32 instructions
+#
+#  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+#
+#  SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+ifndef PREFIX
+  $(error "PREFIX not set, please export GNU Toolchain install directory.")
+endif
+
+ifndef SYSROOT
+  $(error "SYSROOT not set, please export GNU Toolchain system root directory.")
+endif
+
+SIM = ../../../../../../../build/qemu-mips64
+SIM_FLAGS = -L $(SYSROOT)
+
+CC      =  $(PREFIX)/bin/mips64-r6-linux-gnu-gcc
+
+TESTCASES  = test_mips64r6_crc32b.tst
+TESTCASES += test_mips64r6_crc32h.tst
+TESTCASES += test_mips64r6_crc32w.tst
+TESTCASES += test_mips64r6_crc32d.tst
+TESTCASES += test_mips64r6_crc32cb.tst
+TESTCASES += test_mips64r6_crc32ch.tst
+TESTCASES += test_mips64r6_crc32cw.tst
+TESTCASES += test_mips64r6_crc32cd.tst
+
+all: $(TESTCASES)
+	@for case in $(TESTCASES); do \
+            echo $(SIM) $(SIM_FLAGS) ./$$case; \
+            $(SIM) $(SIM_FLAGS) ./$$case; \
+            echo $(RM) -rf ./$$case; \
+            $(RM) -rf ./$$case; \
+	done
+
+%.tst: %.c
+	$(CC) $< -o $@
-- 
2.49.0


