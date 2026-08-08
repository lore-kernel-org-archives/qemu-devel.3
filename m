Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58C1C5AD48
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 02:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsWtD-0000HB-Mk; Fri, 07 Aug 2026 22:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1wsWt2-0000Df-0U
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 22:34:13 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1wsWsw-0007Lx-73
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 22:34:11 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so65542a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 19:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786156435; x=1786761235; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qq1GltB+RqYMbLpB7D9UbLnWlndbrmYdK/X3PzWj93A=;
 b=i4FaCz8Z2rtqfPEG6Stg4mKbhQ3UHhB1/eWMt8T7X/VJzxFXJ0o5S7DGYvpeuBgqA/
 QfUKLpOwpFzxYWzR02I6AZrgOASYUV12Mjf0lIIgRTX6WR6mFinsHJRqVZ6RviVJC5t7
 94luKjGugYYhd8JdsqrwEy8Svsqvk1V3O5Gskwq80Oe/AjbOsCECjsIH5VfNnkl0NSIV
 YLcRJd2CFBBmfZX77N06CSPJgxominZvO0FT6BvJOWxAEXUJ81zip3mMkxWcnfVXLbnf
 f69NGBh3O32cLFniSp95Wz7xSo8DFTyHj6f8zz4uHOgYdEw9eM5HDkuEJtWO9eUtE/R/
 sj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786156435; x=1786761235;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qq1GltB+RqYMbLpB7D9UbLnWlndbrmYdK/X3PzWj93A=;
 b=pST1IkhE02yLmpPLtDEOvaMUJ7v3yoI9ySZ/2iXIvgvuBbRUfQ7MD5M14ycSfX20mK
 xdwr70jacHcVMKPuBvkFoWHR/NJE2LpQM4ptUmYsbtbTZoA0aj7lCle6m3/Jf0ofZWuD
 y4xhvYc61iicz3QVdUEPr//zB6AzfuuYqrcxAqOP0I0pMfTjntxOcuVJqbdAf1TbCDqU
 EWOlVez9d5miE3H+LRBc0dVYW7fzWixSj5mDyFIzUQrSa6n/um6OANRjG2EltP9zidyK
 2TPASlqUBGI+UXCq9w4CxZuHkZpKo9IP2wy4hfLEg3h+VikndTT7kR98lY+iY40Ai1pe
 zHRw==
X-Gm-Message-State: AOJu0YwB9gBbib1B/q1RhWHwqg2OpDrTytzIs9eJzbDcGxcW8wr7nXyA
 vZRTkU/NFJ0XpivAU8Ig3YnX4AxaF5BbxyOn6ukwYKsfBhzV5TOurn5H
X-Gm-Gg: AR+sD10UOkTU9xqziwxWqlpUbYr1lq4igTxzwdlYE5UwM/a2zg4+LY07fkWpMsgy1ST
 rnl4HHLpyTcFZ7cWaa46uXMI0bOqfcVGognaLG4es1RDBrAvNmdaQMatyJCcREMVNduHHbo/fyG
 6V73fxtzAOyfAyqt9u0zRbXu4qREsoFK7oZpjTWd4kkoxnYHW6N0/p2xywLd0PcZXDm2zzH+ZRM
 aWNKzHa2da2FRsuGb4kRNZpTeO5esQhDyW8Z6S+LJ1UGi7dm3lpb1EDPFdJOF/+a0EcCVTQOUEE
 oNwUO+LHX/j45/ctZZI8VSxyG2xugx7+02Quq9LMa0zc3HcjtTwlOqn0Nn6Gl3x37RjBoWYR2Nk
 rmSbqyUYot0WgMNycsU+Xnr24SC+8QPWuUt/4BTzcvUfKs63FUaSa8Vg4QyQucrhsR8SRl2VpiX
 5qtpkrkofpHYcyff0D5Jmby0es7ct7KQoI9Cvj84kblA/e+WMDP0GDXaRQt+S56s61PYc2QA==
X-Received: by 2002:a17:90b:1d02:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-3903c599356mr27805927a91.2.1786156434791; 
 Fri, 07 Aug 2026 19:33:54 -0700 (PDT)
Received: from [127.0.1.1] ([14.19.40.154]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925ff69eabsm4475835a91.15.2026.08.07.19.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 19:33:54 -0700 (PDT)
From: WX Chen <wxchen0913@gmail.com>
Date: Sat, 08 Aug 2026 10:32:44 +0800
Subject: [PATCH v3 3/3] tests/qtest: add K230 UART test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260808-feat-k230-uart-v3-v3-3-d73b31f0034b@gmail.com>
References: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
In-Reply-To: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 WX Chen <wxchen0913@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786156416; l=17851;
 i=wxchen0913@gmail.com; s=20260725; h=from:subject:message-id;
 bh=Pjoeg6icFvXO56//Vt79+felKYLQvRr4fkFPGGj4gT4=;
 b=16L4zqLGm1aBxmHgqkcW6jkXcjf27Wl+76DZOFtn19UDbjQ4EhypoO32U7KuYj1+u65FqywNK
 X0l5iUc68xDBTN+ija0MFukJOnuCg9EDDVkp02ViEbID83LfPZqFrq2
X-Developer-Key: i=wxchen0913@gmail.com; a=ed25519;
 pk=FX63IRxmtz1BCNzHxOOWDPTo8L/D0YUxlIKc1WKi7wo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=wxchen0913@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add 8 test cases covering the main register paths and driver usage
scenarios: device probe, init & baud, TX/RX datapath, THRE interrupt,
RX interrupts (timeout & trigger level), error interrupts & IIR
priority, USR & busy detect, and advanced features (shadow registers,
HTX, SRR, PTIME/TET).

All tests pass.

Signed-off-by: WX Chen <wxchen0913@gmail.com>
---
 tests/qtest/k230-uart-test.c | 514 +++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |   2 +-
 2 files changed, 515 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/k230-uart-test.c b/tests/qtest/k230-uart-test.c
new file mode 100644
index 0000000000000000000000000000000000000000..488dbbb7ffd28726434cdfebe976c3155e14b455
--- /dev/null
+++ b/tests/qtest/k230-uart-test.c
@@ -0,0 +1,514 @@
+/*
+ * QTest for the K230 UART — functional-path coverage.
+ *
+ * Tests are organised around driver usage scenarios rather than
+ * enumerating every register in isolation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include <string.h>
+
+#define UART_BASE  0x91400000
+#define R(off)     (UART_BASE + (off))
+
+/* register offsets */
+#define THR    0x00
+#define IER    0x04
+#define IIR    0x08
+#define LCR    0x0c
+#define MCR    0x10
+#define LSR    0x14
+#define SCR    0x1c
+#define USR    0x7c
+#define TFL    0x80
+#define RFL    0x84
+#define SRR    0x88
+#define SRTS   0x8c
+#define SBCR   0x90
+#define SDMAM  0x94
+#define SFE    0x98
+#define SRT    0x9c
+#define STET   0xa0
+#define HTX    0xa4
+#define CPR    0xf4
+#define CTR    0xfc
+
+/* bit fields */
+#define LCR_DLAB     0x80
+#define LCR_BC       0x40
+#define LCR_8N1      0x03
+
+#define LSR_DR       0x01
+#define LSR_OE       0x02
+#define LSR_THRE     0x20
+#define LSR_TEMT     0x40
+#define LSR_RESET    0x60
+
+#define IIR_IID      0x0f
+#define IIR_NONE     0x01
+#define IIR_THR      0x02
+#define IIR_RX       0x04
+#define IIR_LINE     0x06
+#define IIR_BUSY     0x07
+#define IIR_TO       0x0c
+#define IIR_FF       0xc0
+
+#define IER_RX       0x01
+#define IER_TX       0x02
+#define IER_LS       0x04
+#define IER_COLR     0x10
+#define IER_PTIME    0x80
+
+#define MCR_LB       0x10
+#define MCR_RTS      0x02
+
+#define FCR_FE       0x01
+#define FCR_RR       0x02
+#define FCR_XR       0x04
+#define FCR_TET_H    (3 << 4)
+#define FCR_RT_Q     (1 << 6)
+#define FCR_RT_F     (3 << 6)
+
+#define USR_BUSY     0x01
+#define USR_RESET    0x06
+
+#define SRR_UR       0x01
+#define SRR_RFR      0x02
+
+/* helpers */
+static uint32_t rd(QTestState *qts, uint32_t o)
+{
+    return qtest_readl(qts, R(o));
+}
+static uint32_t iid(QTestState *qts)
+{
+    return rd(qts, IIR) & IIR_IID;
+}
+
+static void poll_lsr(QTestState *qts, uint32_t m)
+{
+    int i;
+
+    for (i = 0; i < 1000; i++) {
+        if (rd(qts, LSR) & m) {
+            return;
+        }
+        qtest_clock_step(qts, 1000);
+    }
+    g_assert_not_reached();
+}
+
+static void s1(QTestState *qts, int fd, char c)
+{
+    g_assert_cmpint(send(fd, &c, 1, 0), ==, 1);
+    poll_lsr(qts, LSR_DR);
+}
+
+static void sn(QTestState *qts, int fd, const char *d, int n)
+{
+    g_assert_cmpint(send(fd, d, n, 0), ==, n);
+    poll_lsr(qts, LSR_DR);
+}
+
+static void oe_nf(QTestState *qts, int fd)
+{
+    int i;
+
+    s1(qts, fd, 'A');
+    {
+        char c = 'B';
+        g_assert_cmpint(send(fd, &c, 1, 0), ==, 1);
+    }
+    for (i = 0; i < 200; i++) {
+        rd(qts, SCR);
+        qtest_clock_step(qts, 1000);
+    }
+}
+
+/* 1. device probe */
+static void test_device_probe(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t cpr = rd(qts, CPR);
+
+    g_assert_cmphex(cpr & 0x3, ==, 0x2);
+    g_assert_cmphex(cpr & (1 << 5), ==, (1 << 5));
+    g_assert_cmphex(cpr & (1 << 8), ==, (1 << 8));
+    g_assert_cmphex((cpr >> 16) & 0xff, ==, 0x2);
+    g_assert_cmphex(cpr & (1 << 4), ==, 0);
+    g_assert_cmphex(rd(qts, CTR), ==, 0x44570110);
+    g_assert_cmphex(rd(qts, LSR), ==, LSR_RESET);
+    g_assert_cmphex(rd(qts, USR), ==, USR_RESET);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, 0);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+
+    qtest_writel(qts, R(IIR), FCR_FE);
+    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, IIR_FF);
+    qtest_quit(qts);
+}
+
+/* 2. init & baud */
+static void test_init_and_baud(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_DLAB);
+    qtest_writel(qts, R(THR), 0x55);
+    g_assert_cmphex(rd(qts, THR), ==, 0x55);
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    g_assert_cmphex(rd(qts, THR), ==, 0x00);
+
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_F);
+    qtest_writel(qts, R(IER), IER_RX);
+
+    /* divisor=1 -> timeout=12800ns */
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    qtest_writel(qts, R(THR), 1); qtest_writel(qts, R(IER), 0);
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    s1(qts, fd, 'X');
+    qtest_clock_step(qts, 13000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+
+    /* divisor=100 -> timeout=1.28e6ns; 13000ns too short */
+    rd(qts, THR);
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    qtest_writel(qts, R(THR), 100); qtest_writel(qts, R(IER), 0);
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    s1(qts, fd, 'Y');
+    qtest_clock_step(qts, 13000);
+    g_assert_cmphex(iid(qts), !=, IIR_TO);
+    qtest_clock_step(qts, 1300000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 3. TX / RX datapath */
+static void test_tx_rx_datapath(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    g_assert_cmphex(rd(qts, LSR) & (LSR_THRE | LSR_TEMT),
+                    ==, LSR_THRE | LSR_TEMT);
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(rd(qts, LSR) & (LSR_THRE | LSR_TEMT),
+                    ==, LSR_THRE | LSR_TEMT);
+
+    /* external RX (FIFO mode) */
+    qtest_writel(qts, R(IIR), FCR_FE);
+    qtest_writel(qts, R(IER), IER_RX);
+    sn(qts, fd, "K230", 4);
+    for (int i = 0; i < 4; i++) {
+        if (i < 3) {
+            g_assert_cmphex(iid(qts), ==, IIR_RX);
+        }
+        g_assert_cmphex(rd(qts, THR), ==, "K230"[i]);
+    }
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* loopback */
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(THR), 'L');
+    g_assert_cmphex(rd(qts, THR), ==, 'L');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* no loopback */
+    qtest_writel(qts, R(MCR), 0);
+    qtest_writel(qts, R(THR), 'Z');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* TFL / RFL */
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR | FCR_XR);
+    qtest_writel(qts, R(THR), 'X'); qtest_writel(qts, R(THR), 'Y');
+    g_assert_cmphex(rd(qts, TFL), ==, 0);
+    g_assert_cmphex(rd(qts, RFL), ==, 2);
+
+    /* non-FIFO mode */
+    qtest_writel(qts, R(MCR), 0);
+    qtest_writel(qts, R(IIR), 0);
+    s1(qts, fd, 'N');
+    g_assert_cmphex(rd(qts, THR), ==, 'N');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+
+    /* non-FIFO overrun */
+    int i;
+    s1(qts, fd, 'n');
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, LSR_DR);
+    {
+        char c = 'o';
+        send(fd, &c, 1, 0);
+    }
+    for (i = 0; i < 200; i++) {
+        rd(qts, SCR);
+        qtest_clock_step(qts, 1000);
+    }
+    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, LSR_OE);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 4. THRE interrupt */
+static void test_thre_interrupt(void)
+{
+    QTestState *qts = qtest_init("-machine k230 "
+                                 "-chardev null,id=c0 -serial chardev:c0");
+    qtest_writel(qts, R(LCR), LCR_8N1);
+
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+
+    qtest_writel(qts, R(IER), IER_TX);
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+
+    qtest_writel(qts, R(THR), 'B');
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_quit(qts);
+}
+
+/* 5. RX interrupts: timeout & trigger level */
+static void test_rx_interrupts(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_F);
+    qtest_writel(qts, R(IER), IER_RX);
+
+    /* basic timeout */
+    s1(qts, fd, 'T');
+    qtest_clock_step(qts, 400000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    g_assert_cmphex(rd(qts, THR), ==, 'T');
+    g_assert_cmphex(iid(qts), !=, IIR_TO);
+
+    /* timeout reset by new byte */
+    s1(qts, fd, 'A'); qtest_clock_step(qts, 200000);
+    s1(qts, fd, 'B');
+    qtest_clock_step(qts, 200000);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_clock_step(qts, 200000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    rd(qts, THR);
+    rd(qts, THR);
+
+    /* timeout rearmed by partial drain */
+    s1(qts, fd, 'X');
+    s1(qts, fd, 'Y');
+    qtest_clock_step(qts, 400000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    g_assert_cmphex(rd(qts, THR), ==, 'X');
+    qtest_clock_step(qts, 200000);
+    g_assert_cmphex(iid(qts), !=, IIR_TO);
+    qtest_clock_step(qts, 250000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    g_assert_cmphex(rd(qts, THR), ==, 'Y');
+
+    /* RX trigger level: RT=Q -> trigger at 8 bytes */
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RT_Q);
+    sn(qts, fd, "ABCDEFG", 7);
+    qtest_clock_step(qts, 20000);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_clock_step(qts, 400000);
+    g_assert_cmphex(iid(qts), ==, IIR_TO);
+    for (int i = 0; i < 7; i++) {
+        rd(qts, THR);
+    }
+
+    sn(qts, fd, "12345678", 8);
+    for (int i = 0; i < 1000; i++) {
+        if (iid(qts) == IIR_RX) {
+            break;
+        }
+        qtest_clock_step(qts, 1000);
+    }
+    g_assert_cmphex(iid(qts), ==, IIR_RX);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 6. error interrupts & IIR priority */
+static void test_error_interrupts(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IER), IER_LS);
+
+    /* OE -> IIR=0x6; LSR clears; ELCOLR=0: RBR clears; ELCOLR=1: RBR keeps */
+    oe_nf(qts, fd);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, LSR);
+    g_assert_cmphex(iid(qts), !=, IIR_LINE);
+
+    oe_nf(qts, fd);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, THR);
+    g_assert_cmphex(iid(qts), !=, IIR_LINE);
+
+    qtest_writel(qts, R(IER), IER_LS | IER_COLR);
+    oe_nf(qts, fd);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, THR);
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    rd(qts, LSR);
+    g_assert_cmphex(iid(qts), !=, IIR_LINE);
+
+    /* IIR priority: RX > TX (loopback) */
+    qtest_writel(qts, R(IIR), FCR_FE);
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(IER), IER_TX | IER_RX);
+    qtest_writel(qts, R(THR), 'P');
+    g_assert_cmphex(iid(qts), ==, IIR_RX);
+    g_assert_cmphex(rd(qts, THR), ==, 'P');
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+    iid(qts);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+
+    /* OE in FIFO mode via loopback */
+    qtest_writel(qts, R(IER), IER_LS);
+    for (int i = 0; i < 32; i++) {
+        qtest_writel(qts, R(THR), 'a');
+    }
+    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, 0);
+    qtest_writel(qts, R(THR), 'z');
+    g_assert_cmphex(iid(qts), ==, IIR_LINE);
+    g_assert_cmphex(rd(qts, LSR) & LSR_OE, ==, LSR_OE);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 7. USR & busy detect */
+static void test_busy_detect(void)
+{
+    int fd;
+    QTestState *qts = qtest_init_with_serial("-machine k230", &fd);
+
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE);
+
+    g_assert_cmphex(rd(qts, USR) & 0x1e, ==, 0x06);
+
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(rd(qts, USR) & 0x08, ==, 0x08);
+    rd(qts, THR);
+    g_assert_cmphex(rd(qts, USR) & 0x08, ==, 0);
+    qtest_writel(qts, R(MCR), 0);
+
+    /* BUSY via RX & loopback */
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+    s1(qts, fd, 'Z');
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
+    rd(qts, THR);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+
+    qtest_writel(qts, R(MCR), MCR_LB);
+    qtest_writel(qts, R(THR), 'L');
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
+    rd(qts, THR);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+
+    /* busy-detect: LCR write rejected while BUSY=1 */
+    qtest_writel(qts, R(MCR), 0);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR | FCR_XR);
+    s1(qts, fd, 'B');
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, USR_BUSY);
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    g_assert_cmphex(rd(qts, LCR), ==, LCR_8N1);
+    g_assert_cmphex(iid(qts), ==, IIR_BUSY);
+    rd(qts, USR);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_RR);
+    g_assert_cmphex(rd(qts, USR) & USR_BUSY, ==, 0);
+    qtest_writel(qts, R(LCR), LCR_8N1 | LCR_DLAB);
+    g_assert_cmphex(rd(qts, LCR), ==, LCR_8N1 | LCR_DLAB);
+
+    close(fd); qtest_quit(qts);
+}
+
+/* 8. advanced features */
+static void test_advanced_features(void)
+{
+    QTestState *qts = qtest_init("-machine k230 "
+                                 "-chardev null,id=c0 -serial chardev:c0");
+
+    /* shadow: SRTS<->MCR.RTS, SBCR<->LCR.BC, SDMAM, SFE, SRT, STET, HTX */
+    qtest_writel(qts, R(SRTS), 1);
+    g_assert_cmphex(rd(qts, MCR) & MCR_RTS, ==, MCR_RTS);
+    qtest_writel(qts, R(MCR), 0); g_assert_cmphex(rd(qts, SRTS), ==, 0);
+    qtest_writel(qts, R(SBCR), 1);
+    g_assert_cmphex(rd(qts, LCR) & LCR_BC, ==, LCR_BC);
+    qtest_writel(qts, R(LCR), 0); g_assert_cmphex(rd(qts, SBCR), ==, 0);
+    qtest_writel(qts, R(SDMAM), 1); g_assert_cmphex(rd(qts, SDMAM), ==, 1);
+    qtest_writel(qts, R(SRT), 0x2); g_assert_cmphex(rd(qts, SRT), ==, 0x2);
+    qtest_writel(qts, R(STET), 0x3); g_assert_cmphex(rd(qts, STET), ==, 0x3);
+    qtest_writel(qts, R(SFE), 1); g_assert_cmphex(rd(qts, SFE), ==, 1);
+    g_assert_cmphex(rd(qts, IIR) & IIR_FF, ==, IIR_FF);
+    qtest_writel(qts, R(HTX), 1); g_assert_cmphex(rd(qts, HTX), ==, 1);
+    qtest_writel(qts, R(HTX), 0); g_assert_cmphex(rd(qts, HTX), ==, 0);
+
+    /* HTX halt TX */
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE);
+    qtest_writel(qts, R(MCR), MCR_LB);
+
+    qtest_writel(qts, R(HTX), 1);
+    qtest_writel(qts, R(THR), 'H');
+    g_assert_cmphex(rd(qts, TFL), ==, 1);
+    g_assert_cmphex(rd(qts, RFL), ==, 0);
+
+    qtest_writel(qts, R(HTX), 0);
+    g_assert_cmphex(rd(qts, TFL), ==, 0);
+    g_assert_cmphex(rd(qts, RFL), ==, 1);
+    g_assert_cmphex(rd(qts, THR), ==, 'H');
+
+    /* SRR: RFR & UR */
+    qtest_writel(qts, R(THR), 'Z');
+    g_assert_cmphex(rd(qts, RFL), ==, 1);
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, LSR_DR);
+    qtest_writel(qts, R(SRR), SRR_RFR);
+    g_assert_cmphex(rd(qts, RFL), ==, 0);
+    g_assert_cmphex(rd(qts, LSR) & LSR_DR, ==, 0);
+    g_assert_cmphex(rd(qts, SRR), ==, 0);
+    qtest_writel(qts, R(THR), 'Y');
+    qtest_writel(qts, R(SRR), SRR_UR);
+    g_assert_cmphex(rd(qts, LSR), ==, LSR_RESET);
+    g_assert_cmphex(iid(qts), ==, IIR_NONE);
+    g_assert_cmphex(rd(qts, RFL), ==, 0);
+
+    /* PTIME + TET programmable THRE */
+    qtest_writel(qts, R(LCR), LCR_8N1);
+    qtest_writel(qts, R(IIR), FCR_FE | FCR_TET_H);
+    qtest_writel(qts, R(IER), IER_TX | IER_PTIME);
+    qtest_writel(qts, R(THR), 'A');
+    g_assert_cmphex(rd(qts, LSR) & LSR_THRE, ==, LSR_THRE);
+    g_assert_cmphex(iid(qts), ==, IIR_THR);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/k230-uart/device_probe",       test_device_probe);
+    qtest_add_func("/k230-uart/init_and_baud",      test_init_and_baud);
+    qtest_add_func("/k230-uart/tx_rx_datapath",     test_tx_rx_datapath);
+    qtest_add_func("/k230-uart/thre_interrupt",     test_thre_interrupt);
+    qtest_add_func("/k230-uart/rx_interrupts",      test_rx_interrupts);
+    qtest_add_func("/k230-uart/error_interrupts",   test_error_interrupts);
+    qtest_add_func("/k230-uart/busy_detect",        test_busy_detect);
+    qtest_add_func("/k230-uart/advanced_features",  test_advanced_features);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 822e0bd286970339fe28127649feb131ce8a81b2..93246d9bf77206e9cebb9d8ade5801f4541d3b8d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -294,7 +294,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-uart-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 

-- 
2.48.1


