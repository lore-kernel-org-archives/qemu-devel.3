Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BCDC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 17:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yTr-0002am-Ul; Sat, 19 Sep 2026 13:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1x7yDr-0002fA-Hn; Sat, 19 Sep 2026 12:47:33 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1x7yDp-0007z5-DN; Sat, 19 Sep 2026 12:47:31 -0400
DKIM-Signature: a=rsa-sha256; bh=llmQiWpenEqIM67Nd7lHkHHLXaF2afLo5sdJkkTqwaE=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1789836443; v=1;
 b=fJcjfeW+WWKT4wOAGC3T9RzUBYHilxxzPHUuSuT+jUYO1OD+/s9sLAEj7j1X9eXBahoI51gN
 skGGZQTHdIZXCDM8Mn+6OWu7K8fHPLE1I2IMfLsAimoKKDT+ovLcHQhIUFQlrSu17yywI2aybTg
 gfwRiK60GE6Xt9JUGVWUKLkKAdp6K2zjgfOEcm+9Nqt2hKAgSnCXkLCSeQxVDCzDtpEX0IX4tDq
 dmxynsqC3JDAYWqiMcerLM3mX27/mE05+FNGgq59jwPB4hIDYCdyvXuKxuQRq8rMJC6LNn5XRQQ
 HmAZGtbLUmZ57REnXd9cWfsTNHjWDeWvzCMJ2UxtWjeMA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 6DCC822443;
 Sat, 19 Sep 2026 16:47:23 +0000 (UTC)
From: ~jprx <jprx@git.sr.ht>
Date: Sat, 19 Sep 2026 16:47:23 +0000
Subject: [PATCH qemu 0/2] hw/char/exynos4210_uart: fix overflow in fifo
 implementation
MIME-Version: 1.0
Message-ID: <178983644340.22135.11298603231632238119-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Joseph Ravichandran <jravi@mit.edu>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

The Exynos 4210 UART FIFO implementation suffers from an overflow that
can occur when large buffers are sent into it. Specifically, this
overflow is caused by the underlying circular buffer implementation
making use of a store and retrieve pointer. When implemented this way, a
circular buffer's capacity is 1 less than the size of the buffer, but
the code as written assumes the entire buffer is available for storing
data.

If a large amount of data is sent into the UART when FIFO mode is
enabled, the FIFO may overflow before the guest has time to receive the
data, resulting in the first part of the message being lost.

This patch series includes a qtest that demonstrates the current
implementation suffers from an overflow that results in data truncation,
and a fix that switches the Exynos UART FIFO implementation for fifo8,
which does not suffer from this problem. After applying the suggested
fix, the test passes.

jprx (2):
  tests/qtest: add test for exynos4210 uart fifo overflow bug
  hw/char/exynos4210_uart: fix fifo overflow

 hw/char/exynos4210_uart.c               | 107 ++++++------------------
 tests/qtest/exynos4210_uart_fifo-test.c |  86 +++++++++++++++++++
 tests/qtest/meson.build                 |   4 +
 3 files changed, 117 insertions(+), 80 deletions(-)
 create mode 100644 tests/qtest/exynos4210_uart_fifo-test.c

-- 
2.49.1

