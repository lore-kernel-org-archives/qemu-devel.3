Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F13FCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUep-0006zr-4V; Tue, 29 Sep 2026 06:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUen-0006z1-7U
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:53 -0400
Received: from mail-wr2-x17.google.com ([2a00:1450:4864:30::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUel-000893-By
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:52 -0400
Received: by mail-wr2-x17.google.com with SMTP id
 ffacd0b85a97d-4888598e4f9so2571599f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676110; x=1791280910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AkUs5FcHHq3ZNmfUAuWrP3BSCWbBwLXF75uepS3V6Sc=;
 b=ZgZypBaa6lM4wS1lox+HenTwZt1d7DXcnNtOsEi9ss9AIhqc+w9ozpSem8Tx63M3lx
 4P9/7k21gJbwDYYR9xb/Mm0rE/na/LJGwYkYZqjGrst6skpsDb9KOM3xjeTQEoThXWIY
 uYAiDfNI2glsU0y51W9XjS+vQDXJyrsm7JmHjSc3sLRe2SquwAlpTXBXKq91GZHIaOAD
 LF7qbUpSNbSj5N1SKPcmweyCkfgDfigyZmXQZS7wtvufmF/ibJ8dUPQ+8SGuugVsuOui
 QvuWhmy8vUsbSuelcnlPZY5PYj6ng1HX4XUc8sSsKbABCMwOMBqHRMlAF0STEeBwKVFQ
 DNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676110; x=1791280910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AkUs5FcHHq3ZNmfUAuWrP3BSCWbBwLXF75uepS3V6Sc=;
 b=db7FDMerWWLkmzHOpP5ujYx0beuHiLxvgq5f0lcI+LgMItyvT5L8inmMSfnXXMKq+b
 Tt+qhqmSQcBXfRZtFuoW1Y0SXgyw+oWo5OnHMpNYUtEslgrKlJvdBBhW/JM3+BooSXZe
 9KmzUFivy0mu5BHbAi+2bUaguRXdWy1JDZEulIxLIaZ2cg5EejJrHlqA8aFrQawoZc3g
 S1UvT7zpmyaoScTQCH4450PLaT6Axg+BKhZ51cJV01W/cbUHyQS/H10x8VLk1Gig1GEU
 lBaZB+FIZaT/Q35ZZhwS7cP5fGgjTA2u+jDwVgEH26m8qqefsCVDivxt1hBorKJZH2Vg
 ws7w==
X-Gm-Message-State: AFq9FYLeiXYaY3twZJqlxvoNI/y5rowMqL44oz4gR2kD0M6Gzt2X76lu
 vOyZcV9ufUWD2KRZ3CDJFzzuCw1G4xlT4UYpYxCBcE5e1oADXMTj+0P1BFOOUs1EjiBvaFilpDN
 QOizD
X-Gm-Gg: AYBFou19fp8XR5FcZe3zgneeCB/GrbNol2zOSQUh5xAcP0t6YozqJ2ocrJzXrCtX/3S
 xUrH4yaJihHGfBiNLu4ZEuGKBAyzCR1NrsUjf12JDsBC954fzSg+0vQfWKeRUsZeB9d12Oa1UuB
 nkhPve1qus+qVa0QSl4KmpxAburV0hKotgDWIJT71914ILal9e05tOCtY7TL2vK8iQQSdGOqnCE
 iCz/MQHvtKXuzTy7LUiZnfJKJ9CwwRAYPCouZ6jdyXFM7xluJb8rWYHip2FBR8ZDan4fu6tXezt
 qKhK2/Xw6Cb/n0WMjyM8+Trzew6MWjHR7PtrrhV2GD/sGhUNSrKcNO5ydU8xz5XTyHlG0G4fN9S
 mpAFUA+Mxg3HpEnD1LmF06wvDKUC9vhvIFNEgwIAG7ymih0ZyAWBM7A0qWCKJLRTZkhdvOV204R
 lMfs2p7Hnj5J9+/jEpgi3zMq3mOhisFPSyA/8UQJRm2Vj2VX/p/a7Dy7ttFEsP42VdZ4+D5getF
 2p+V5TSimFFHHFE1u48QqC4CnYae3M4mUlMSUf1og2oI21OCOVH1YbZkM508ds1gOeEYUypYF9t
 vkZq/awMohzsaA==
X-Received: by 2002:a05:6000:4009:b0:487:92e:c608 with SMTP id
 ffacd0b85a97d-48af1b1cc9amr3412760f8f.1.1790676108131; 
 Tue, 29 Sep 2026 03:01:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/37] tests/qtest: add test for exynos4210 uart fifo overflow
 bug
Date: Tue, 29 Sep 2026 11:01:03 +0100
Message-ID: <20260929100133.2598676-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::17;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x17.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: jprx <jravi@mit.edu>

The Exynos 4210 UART FIFO implementation will overflow if a large buffer
is sent via a chardev. This test demonstrates the issue by sending an
input message that is 4x the size of the UART0 FIFO length.

A correct implementation will return the complete message, and an
incorrect one will timeout. This is because the FIFO overflows when
receiving data from the chardev, skipping over the first part of the
input message, resulting in us not reading the full message and timing
out.

Signed-off-by: Joseph Ravichandran <jravi@mit.edu>
Message-id: 178983644340.22135.11298603231632238119-1@git.sr.ht
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/exynos4210_uart_fifo-test.c | 86 +++++++++++++++++++++++++
 tests/qtest/meson.build                 |  4 ++
 2 files changed, 90 insertions(+)
 create mode 100644 tests/qtest/exynos4210_uart_fifo-test.c

diff --git a/tests/qtest/exynos4210_uart_fifo-test.c b/tests/qtest/exynos4210_uart_fifo-test.c
new file mode 100644
index 00000000000..54c09a6de72
--- /dev/null
+++ b/tests/qtest/exynos4210_uart_fifo-test.c
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/* defs from exynos4210.c */
+#define UART0_BASE_ADDR     0x13800000
+#define UART0_FIFO_SIZE     256
+#define UFCON      0x0008 /* FIFO Control             */
+#define UTRSTAT    0x0010 /* Tx/Rx Status             */
+#define URXH       0x0024 /* Receive Buffer           */
+#define UFCON_FIFO_ENABLE                    0x1
+#define UTRSTAT_Rx_BUFFER_DATA_READY         0x1
+
+#define TEST_BUFFER_LEN        ((4 * UART0_FIFO_SIZE))
+
+static bool uart_wait_for_flag(QTestState *qts, uint32_t event_addr,
+                               uint32_t flag)
+{
+    while (true) {
+        if ((qtest_readl(qts, event_addr) & flag)) {
+            return true;
+        }
+        g_usleep(1000);
+    }
+
+    return false;
+}
+
+static void uart_receive_string(QTestState *qts, int sock_fd, const char *in,
+                                char *out)
+{
+    size_t i, in_len = strlen(in);
+
+    g_assert_true(send(sock_fd, in, in_len, 0) == in_len);
+    for (i = 0; i < in_len; i++) {
+        g_assert_true(uart_wait_for_flag(qts,
+            UART0_BASE_ADDR + UTRSTAT, UTRSTAT_Rx_BUFFER_DATA_READY));
+        out[i] = qtest_readl(qts, UART0_BASE_ADDR + URXH);
+    }
+    out[i] = '\0';
+}
+
+static void enable_uart_fifo(QTestState *qts)
+{
+    qtest_writel(qts, UART0_BASE_ADDR + UFCON, UFCON_FIFO_ENABLE);
+}
+
+/*
+ * If the FIFO overflows when receiving data from the chardev, early input
+ * chunks will be lost, and this will timeout waiting to read the full
+ * buffer. If the FIFO behaves correctly, we will receive the full buffer.
+ */
+static void test_recv_large_str(void)
+{
+    int sock_fd;
+    char *sendbuf, *recvbuf;
+    QTestState *qts = qtest_init_with_serial("-M smdkc210", &sock_fd);
+
+    enable_uart_fifo(qts);
+
+    sendbuf = g_new0(char, TEST_BUFFER_LEN);
+    recvbuf = g_new0(char, TEST_BUFFER_LEN);
+    memset(sendbuf, 'A', TEST_BUFFER_LEN);
+    sendbuf[TEST_BUFFER_LEN - 1] = '\x00';
+
+    g_assert_true(0 == strlen(recvbuf));
+    g_assert_true(TEST_BUFFER_LEN - 1 == strlen(sendbuf));
+
+    uart_receive_string(qts, sock_fd, sendbuf, recvbuf);
+
+    g_assert_true(TEST_BUFFER_LEN - 1 == strlen(recvbuf));
+    g_assert_true(strcmp(sendbuf, recvbuf) == 0);
+
+    close(sock_fd);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+
+    qtest_add_func("exynos4210/uart/receive_large_str", test_recv_large_str);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index a35ae79b03d..3aed0c3a00a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -249,6 +249,9 @@ qtests_stm32l4x5 = \
    'stm32l4x5_gpio-test',
    'stm32l4x5_usart-test']
 
+qtests_exynos4210 = \
+  ['exynos4210_uart_fifo-test']
+
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
@@ -283,6 +286,7 @@ qtests_aarch64 = \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
+  (config_all_devices.has_key('CONFIG_EXYNOS4') ? qtests_exynos4210 : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_ARM_VIRT') ?
    ['iommu-smmuv3-test'] : []) + \
-- 
2.43.0


