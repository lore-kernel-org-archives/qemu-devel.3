Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3150CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUOj-0000oI-A1; Sat, 13 Jun 2026 15:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUON-0000ge-CJ; Sat, 13 Jun 2026 15:51:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUOL-0003Rr-Lx; Sat, 13 Jun 2026 15:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380258; bh=GJ8nDPknSaLTHenVPepcwqgkeXQtz0uFvdNGQXaODmA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fQUpPYgTKwWG2nih6X3NnfOdbVQBAJuw2P6putVD9WVRSHTN++s4NaB85nFJr+hum
 iCpgF7wv1x6+5bn09uVhd0yd2kJrFEk7bPRYkjGw1mITBHqjUrDoHqpHcxWAtghb3/
 l85bqM9i8uiSGY6rHnNdLQgWuYrmKHUYmjVgNRZx6b8K456KS1mlC1GhUvmkYtClp6
 B24dJ+UzlsYovtcW+K2K1ipFxsG2amQhuNZW2J0jEuGOMf66czGbwW37KTpDqjNiGH
 SSXXlQdkyRHFKQkS+dlbqM+cndLcc6VPkO55Xxggy1R17D92r9HMYwGUVu9PGmFED+
 uioNbs0nljTTg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 362AD1B6E14;
 Sat, 13 Jun 2026 22:50:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 901B53CE88E;
 Sat, 13 Jun 2026 22:51:16 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Florian Lugou <florian.lugou@provenrun.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 05/56] hw/char: sifive_uart: Avoid infinite delay of
 async xmit function
Date: Sat, 13 Jun 2026 22:50:19 +0300
Message-ID: <20260613195116.1807273-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Florian Lugou <florian.lugou@provenrun.com>

The current handler for TXFIFO writes schedules an async callback to
pop characters from the queue. When software writes to TXFIFO faster
than the async callback delay (100ns), the timer may be pushed back
while the previous character has not be dequeued yet. This happens in
particular when using -icount with small shift values. This is
especially worrysome when software repetitively issues amoor.w
instructions (as suggested by SiFive specification) and the FIFO is
full, leading to the callback being infinitly pushed back.

This commit fixes the issue by never pushing back the timer, only
updating it if it is not already active.

Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250605101255.797162-1-florian.lugou@provenrun.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 61240e3a06dc622d249b530557d5ce03c5854592)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 6da3401aa3..c4258c2ebf 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -128,8 +128,10 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
         s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
     }
 
-    timer_mod(s->fifo_trigger_handle, current_time +
-                  TX_INTERRUPT_TRIGGER_DELAY_NS);
+    if (!timer_pending(s->fifo_trigger_handle)) {
+        timer_mod(s->fifo_trigger_handle, current_time +
+                      TX_INTERRUPT_TRIGGER_DELAY_NS);
+    }
 }
 
 static uint64_t
-- 
2.47.3


