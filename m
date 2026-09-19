Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAD7C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 17:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yTo-0002a0-54; Sat, 19 Sep 2026 13:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1x7yDt-0002fO-CN; Sat, 19 Sep 2026 12:47:33 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1x7yDr-0007zG-AF; Sat, 19 Sep 2026 12:47:32 -0400
DKIM-Signature: a=rsa-sha256; bh=Rj9uNGEVJhRstE9JW5DAYITP9zahe6g9UYJbpThkatA=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1789836443; v=1;
 b=csGm2nFC5izikNCk6YDl9AkWaROiYSqm0IbOh/rSJogBPcaSpCt53GIQOVLQyxrDJz5bDbqk
 /UXabj/+NqmQRAMfLmu5VKtY9Grz8ICV35MebYmf3bCybW8kAXRpk7gSNjfDZ2ceSGNw0LhKkkV
 VBlhcHls8TSwpHqtqloowmecYkYtsAwal0X6LdXh/kxD24vUchIycALhnYoopDYhxcvd+AXR1nh
 VrkydAHiPjTZ0LKMirBVuQ9Wa9D29+RM3AMdaRYu28g8xHvz1xxrSpzENaeJVzKuDJQDfi9eUGW
 LFzIcM6xdMMtgcwUIOqFpcNU38FlsUX4XuBRRvMfaxnhg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 90F4522482;
 Sat, 19 Sep 2026 16:47:23 +0000 (UTC)
From: ~jprx <jprx@git.sr.ht>
Date: Sat, 19 Sep 2026 10:15:52 -0400
Subject: [PATCH qemu 1/2] tests/qtest: add test for exynos4210 uart fifo
 overflow bug
Message-ID: <178983644340.22135.11298603231632238119-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <178983644340.22135.11298603231632238119-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Joseph Ravichandran <jravi@mit.edu>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 19 Sep 2026 13:03:56 -0400
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
Reply-To: ~jprx <jravi@mit.edu>
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
---
 tests/qtest/exynos4210_uart_fifo-test.c | 86 +++++++++++++++++++++++++
 tests/qtest/meson.build                 |  4 ++
 2 files changed, 90 insertions(+)
 create mode 100644 tests/qtest/exynos4210_uart_fifo-test.c

diff --git a/tests/qtest/exynos4210_uart_fifo-test.c b/tests/qtest/exynos4210=
_uart_fifo-test.c
new file mode 100644
index 0000000000..54c09a6de7
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
+    size_t i, in_len =3D strlen(in);
+
+    g_assert_true(send(sock_fd, in, in_len, 0) =3D=3D in_len);
+    for (i =3D 0; i < in_len; i++) {
+        g_assert_true(uart_wait_for_flag(qts,
+            UART0_BASE_ADDR + UTRSTAT, UTRSTAT_Rx_BUFFER_DATA_READY));
+        out[i] =3D qtest_readl(qts, UART0_BASE_ADDR + URXH);
+    }
+    out[i] =3D '\0';
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
+    QTestState *qts =3D qtest_init_with_serial("-M smdkc210", &sock_fd);
+
+    enable_uart_fifo(qts);
+
+    sendbuf =3D g_new0(char, TEST_BUFFER_LEN);
+    recvbuf =3D g_new0(char, TEST_BUFFER_LEN);
+    memset(sendbuf, 'A', TEST_BUFFER_LEN);
+    sendbuf[TEST_BUFFER_LEN - 1] =3D '\x00';
+
+    g_assert_true(0 =3D=3D strlen(recvbuf));
+    g_assert_true(TEST_BUFFER_LEN - 1 =3D=3D strlen(sendbuf));
+
+    uart_receive_string(qts, sock_fd, sendbuf, recvbuf);
+
+    g_assert_true(TEST_BUFFER_LEN - 1 =3D=3D strlen(recvbuf));
+    g_assert_true(strcmp(sendbuf, recvbuf) =3D=3D 0);
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
index 33f58b0e95..860159df44 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -249,6 +249,9 @@ qtests_stm32l4x5 =3D \
    'stm32l4x5_gpio-test',
    'stm32l4x5_usart-test']
=20
+qtests_exynos4210 =3D \
+  ['exynos4210_uart_fifo-test']
+
 qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-du=
altimer-test'] : []) + \
@@ -282,6 +285,7 @@ qtests_aarch64 =3D \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', '=
tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) +=
 \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
+  (config_all_devices.has_key('CONFIG_EXYNOS4') ? qtests_exynos4210 : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_ARM_VIRT') ?
    ['iommu-smmuv3-test'] : []) + \
--=20
2.49.1


