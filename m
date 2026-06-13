Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050BDCD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUbH-000861-BA; Sat, 13 Jun 2026 16:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUbF-00083l-Dc; Sat, 13 Jun 2026 16:05:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUbD-0008HA-IN; Sat, 13 Jun 2026 16:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381067; bh=4z7s1KUPov547AFUB0/0VKwnCG1xS0fdowh1v+qwB3k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h0y4WT4w9U82G39S9QDAzIdc9H72djADtJjeTSyxC0QtaVYwjmiCROCzAIEaSAZtj
 4dxAk/AZ/lbIwy/Z9ylQoS9n1WAkZy1G1ZOg6AzzHhdMF8v2zUjONU6lF0ryDFC9MM
 sxtGdCzIhtWyjQaqNxUD8Ohe8FZD1chiaf6RFKL0GEl5P2VBsPMNGWpdmYG4G/haFa
 wmH5Rs5Iz2IMJxBqSqMw3X48zxfEKP1TRkgd+n6ZYXi5sDGTeCEyNHA3mKoH/CcK2G
 y/41yWhLH0UYDg4NBwHYgJhGq11PAi01mk6kGu43x+IU/h+djStNkJ7Y7xTPOaRNLF
 UNBDPFcRkr9JQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 52F3C1B6E6E;
 Sat, 13 Jun 2026 23:04:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AE10B3CE8D1;
 Sat, 13 Jun 2026 23:04:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Frank Chang <frank.chang@sifive.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 07/61] hw/char: Check interrupt after txctrl register
 is written
Date: Sat, 13 Jun 2026 23:02:50 +0300
Message-ID: <20260613200411.1808021-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
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
index 4a54dd52a1..b76213e157 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -197,6 +197,7 @@ sifive_uart_write(void *opaque, hwaddr addr,
         if (SIFIVE_UART_TXEN(s->txctrl) && !fifo8_is_empty(&s->tx_fifo)) {
             sifive_uart_trigger_tx_fifo(s);
         }
+        sifive_uart_update_irq(s);
         return;
     case SIFIVE_UART_RXCTRL:
         s->rxctrl = val64;
-- 
2.47.3


