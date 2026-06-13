Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6267ECD98D6
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV66-0001fp-8H; Sat, 13 Jun 2026 16:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV5w-0001Ya-I5; Sat, 13 Jun 2026 16:36:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV5u-0003Dy-Vg; Sat, 13 Jun 2026 16:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382962; bh=LTAxSberyWeoDcQ5ZuEoxEhrXnHV2K4/3Fs3fFdtb8o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fXeercP4Jpedw94EZwL5YZSA+WtEeEdvN38LyyQz08ZJ9Gy8hnTr/hJC3r18Re5NL
 XfWMeQnPlIR7EN3+jJQNWAbyW/XHV3cKH0dd1xCIkM2neJX6pypwqgTBXV/wQpvYwK
 1h16JTDo3W8XIzqi+QMuE9noMZuuOJULI7LdUxZ0Efs5eJWjt7J5/ihkEFp94BWvZJ
 t9zA2HG+cq0zrltn+W6er9SpWTqplZWZMqzHrAfLnQHK2do/eJKSXEpUqEEQ1WJufk
 /kWh/yFF9NQOi9ZaIhiHuE3TUNUqNffLxF9gh3lzFg5vcWG+PGHGcfQWO9mgFXwkuh
 nY9NN4FcMG5ig==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CD6801B6EE1;
 Sat, 13 Jun 2026 23:36:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3F04F3CE933;
 Sat, 13 Jun 2026 23:36:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Frank Chang <frank.chang@sifive.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 07/72] hw/char: Check interrupt after txctrl register
 is written
Date: Sat, 13 Jun 2026 23:34:33 +0300
Message-ID: <20260613203542.1809153-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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

From: Frank Chang <frank.chang@sifive.com>

It's possible that the transmit watermark level (txctrl.txcnt) is
updated when the user writes to txctrl register, which may decrease the
transmit watermark level to less than the number of entries in the
transmit FIFO. In such a case, the interrupt should be raised so we need to
call sifive_uart_update_irq() to check and update interrupt when txctrl
register is written. Otherwise, the interrupt will have to be delayed
until next TX FIFO transmission is processed.

Suggested-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260513030503.3665414-1-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit e07077a766071418e76d1c7db7e51e344776eaf2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index b4de662d61..b9bbaaef59 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -213,6 +213,7 @@ sifive_uart_write(void *opaque, hwaddr addr,
         if (SIFIVE_UART_TXEN(s->txctrl) && !fifo8_is_empty(&s->tx_fifo)) {
             sifive_uart_trigger_tx_fifo(s);
         }
+        sifive_uart_update_irq(s);
         return;
     case SIFIVE_UART_RXCTRL:
         s->rxctrl = val64;
-- 
2.47.3


