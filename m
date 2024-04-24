Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D4BC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlYS-0005Y3-6S; Wed, 24 Apr 2024 18:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYM-0005QJ-LS
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:27 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYL-0001pT-6O
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:26 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5aa2a74c238so281508eaf.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999444; x=1714604244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uDnD2JhudGEyHc/H+ZZoiEcnN6tpSM/3wit8Um6ah6g=;
 b=mG+rKjic6fGDOeNcPoWewMQB9wlHzaoVWPFgKzb4qzDWBFMe7HvJxL/PAYJa2FH1Kw
 a/lqLwbEVtA7fz5EOZnLbkiud5jRMWv6TrOXEuauR/3aXt9g45/o8x4sQiMziOuNI5BV
 FRmgDPqDQFw6V5ghxvGIDbMfvlXwVcF4eWiy2DNUyzkIXgpVkFvbYoI4mHGxaxe+XhIc
 G/cm4gI0lKmy8ObgyH3qDOboFoOBR7PYR/TODRjBUkiQq32HWt/NrAGTcwPHCaqXcRF/
 9gSb65BYIWIXumGRFmKWTFcvQum9Uld8XiEdv963uT23soDgFNEhPEaXnF+cZB1JiJL2
 9+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999444; x=1714604244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDnD2JhudGEyHc/H+ZZoiEcnN6tpSM/3wit8Um6ah6g=;
 b=r2AHREOJYN0EnauQxG38EsUzsGxfk3ewZ5Z1ojb8ZfuBX4mZ+pIvyFqCfXbdKCJXcw
 p8f2AP39BdpLCXVlYO5WQg1+WIb+WN6DwrgomJ7JnMIUwnsddhD93RTiCPmHe++xKy5v
 VDExOEiPIyrYODiVyt9HgJruvYBfOvT2njQgwCihJ49CbCdN7Z52m5VqxSnwvA/zESP0
 uPDvx6YWYWdXe3KnNL64BT+NGskhqv+Ghyvwr33gevZmZCCmZx9OqHB/BmVUR8LmDFJZ
 uMYd3r0ubcauq58YNUC3N2rpQvvoVwV13kv7SAulLtbXXYZENXgRS4U/Qz6MnKl1x5Gy
 /4vQ==
X-Gm-Message-State: AOJu0Yz/WE/VuaTXJWBLiaHILkxDgf2J+E7oLxpa43460isNvGBKP1wN
 QMqq1RqDNr4z/HZeozJlLD9VblVKuDP4u0qEnvlhPdh8msxUrMl78v7yGe9wBwMvgUJnsyNx2j0
 u
X-Google-Smtp-Source: AGHT+IHTPY/74tsfIDrYcStsv5KPyjyIfAvmqvx6MSnbk+mQ6XqpUDn5C73nrhmneTsEmX4IsJYqPQ==
X-Received: by 2002:a05:6870:3101:b0:22e:8ed:9f7a with SMTP id
 v1-20020a056870310100b0022e08ed9f7amr4331016oaa.4.1713999443927; 
 Wed, 24 Apr 2024 15:57:23 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 gu26-20020a056a004e5a00b006ed9760b815sm11947413pfb.211.2024.04.24.15.57.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:57:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/10] tests/bench: Add bufferiszero-bench
Date: Wed, 24 Apr 2024 15:57:05 -0700
Message-Id: <20240424225705.929812-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225705.929812-1-richard.henderson@linaro.org>
References: <20240424225705.929812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

Benchmark each acceleration function vs an aligned buffer of zeros.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/bench/bufferiszero-bench.c | 47 ++++++++++++++++++++++++++++++++
 tests/bench/meson.build          |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 tests/bench/bufferiszero-bench.c

diff --git a/tests/bench/bufferiszero-bench.c b/tests/bench/bufferiszero-bench.c
new file mode 100644
index 0000000000..222695c1fa
--- /dev/null
+++ b/tests/bench/bufferiszero-bench.c
@@ -0,0 +1,47 @@
+/*
+ * QEMU buffer_is_zero speed benchmark
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/units.h"
+
+static void test(const void *opaque)
+{
+    size_t max = 64 * KiB;
+    void *buf = g_malloc0(max);
+    int accel_index = 0;
+
+    do {
+        if (accel_index != 0) {
+            g_test_message("%s", "");  /* gnu_printf Werror for simple "" */
+        }
+        for (size_t len = 1 * KiB; len <= max; len *= 4) {
+            double total = 0.0;
+
+            g_test_timer_start();
+            do {
+                buffer_is_zero_ge256(buf, len);
+                total += len;
+            } while (g_test_timer_elapsed() < 0.5);
+
+            total /= MiB;
+            g_test_message("buffer_is_zero #%d: %2zuKB %8.0f MB/sec",
+                           accel_index, len / (size_t)KiB,
+                           total / g_test_timer_last());
+        }
+        accel_index++;
+    } while (test_buffer_is_zero_next_accel());
+
+    g_free(buf);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_data_func("/cutils/bufferiszero/speed", NULL, test);
+    return g_test_run();
+}
diff --git a/tests/bench/meson.build b/tests/bench/meson.build
index 7e76338a52..4cd7a2f6b5 100644
--- a/tests/bench/meson.build
+++ b/tests/bench/meson.build
@@ -21,6 +21,7 @@ benchs = {}
 
 if have_block
   benchs += {
+     'bufferiszero-bench': [],
      'benchmark-crypto-hash': [crypto],
      'benchmark-crypto-hmac': [crypto],
      'benchmark-crypto-cipher': [crypto],
-- 
2.34.1


