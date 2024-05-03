Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724F5C25B10
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ubM-0005q5-K1; Fri, 03 May 2024 11:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubJ-0005oG-7E
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubG-00076w-GU
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:28 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e3c3aa8938so62133365ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749205; x=1715354005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8aiuTj5/6yjo0wKZf1j2mdDbeTtUm906YMvC+PIZPk=;
 b=dhh5hm3Et4gSwin9L7A54VkF/R/ffpuO4p3Dc//5aC50N4P/UdcT9lqBSNU1dilSwZ
 ZVy7JwxyEg3sGyuBc7zlQosXJLBxfWUQ5hc+elmPN1Syan6FW8jDqziLvSABoFHrEwb6
 aJPecNLL7u2751eyug6jrm+OnrXE88DTk7sZAgFLkqgthQCsIx0XqNBlx//Jk/j8DSar
 XKPzda8RBWfiljpCnolvZnOeNvYoWDsaNH7lzN3hZVfrnyXVBTlmjfnU95tybYiAAKDU
 e39UuchtouwvER9LuJR6iZUGdMCnx50AGez60PzNyuU+HmV/zaUVojqtmY7fh+eFPMOq
 FPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749205; x=1715354005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8aiuTj5/6yjo0wKZf1j2mdDbeTtUm906YMvC+PIZPk=;
 b=ubG9fq0xT9tIvefD0g+JzFQ5unJfPM+lY/oZf3kAC+jJ1oLqyreisbErYnWe9Sl5cH
 ae7LhU3F8TK6qV8PxMbodTIIls9Sroo/sOfsyCx2a+RGikPJ+7HjCSRfx1TWUJ7vSTS2
 vOnx+YXR4MJbzBh50vOkqZXlsDTWmCXGQsgAj4erPFdsyUkueKJ9tk6bo9rZU07PTNOr
 Hd/1weAAMsIeX+Wp5O0XUPqGIEmo44NI117x+bSgv//oXZ3g3FCh3tiOC2XoKjPd7iaf
 Jux48jjWeA72pEGtlGFovefsI0Y/8TSBuEwDeYh5fcb6lyZ61LPLFR3NMr6D7riG31Gb
 Yp/A==
X-Gm-Message-State: AOJu0Yx81wGjS807cKKRmYLMnT34kKvIanDiMVEWkQVN8v20I1IdCFyH
 qdBT+CPA+PkLsx93dmVkUycdxfCNooO+J47adSU7wnL0ZwYT3iMyo3Q4EmcnjilaSFKXdkmzcbk
 h
X-Google-Smtp-Source: AGHT+IG2rEdg0/DbGOhIhWo300L2aS9pjhb9N/r2M+Z5xBqcs4Ul7LEwdvq/+tI3to8j6E2PplfKtw==
X-Received: by 2002:a17:902:cf04:b0:1ec:4054:9f47 with SMTP id
 i4-20020a170902cf0400b001ec40549f47mr3670436plg.26.1714749205079; 
 Fri, 03 May 2024 08:13:25 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902c70a00b001e81c778784sm3366611plp.67.2024.05.03.08.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:13:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/10] tests/bench: Add bufferiszero-bench
Date: Fri,  3 May 2024 08:13:14 -0700
Message-Id: <20240503151314.336357-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503151314.336357-1-richard.henderson@linaro.org>
References: <20240503151314.336357-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


