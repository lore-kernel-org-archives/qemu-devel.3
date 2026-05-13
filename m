Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5434ACD343F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 03:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMzuW-0004TP-Jf; Tue, 12 May 2026 23:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wMzuQ-0004Se-Lr
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:05:19 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wMzuM-0003DH-8l
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:05:17 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-367c26471f5so2953149a91.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 20:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778641509; x=1779246309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5XFIq6Q0hGUO+bb8YYjlYOCB/gp8A/fOf4w/ZERmcY=;
 b=hrz/NAJ2RcciwStqO48LkkFLa8465VRbp1xHWoLhX8+hI1gm94M9LWl0jDLdWLarbo
 sqVVZ81jhVDaC0FAeY3BQMgaSMNGv+pdmmwfNTl9HAr8IoDVtkIH8EfFoyeqTpw16FAw
 /LaRvO/jATVRAFR0Ql5rVmB3zAqRlWRjGLdDFrLF9JFzbz83ltJJsq6DPjuEgXwsyM8J
 VtUPvDyXNU+LUIHoseO86ZU1uQAUaSaJY/NvidlgwOG8kNSrAdKwWG9vn5K7kRqhsQSc
 WEqO+H88/7Ms9mn/PtDa8ftmxtLKmJasBD1RwUny6NxNga6Sr9GkpDeHJFMILp2kzvja
 O6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778641509; x=1779246309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5XFIq6Q0hGUO+bb8YYjlYOCB/gp8A/fOf4w/ZERmcY=;
 b=b7u7ZFo5jTIvu2ZJEw5qADhwRZAGIH9EIJl1hKnHuxRGrmvoMoGsGjkIPLUVI4JZgt
 CjLXlbNwSPzQxpDEsCujUSICknhW1O72ZtgzpIo3vzQNi5MQPuuf3VhmHpkuUEq7k3cz
 knb7I4nGxlfetcEOkoWA9dTHayyE53rAl1m4TtWKczv3JcNjtojSqYWWK4Y6rKch5VuJ
 db4LszUlzfOO7HW6oRq3kUCQPhR55McMAhlr54bArPArBIFI3qh+qPHKWYBkDCmCDWdT
 fEXb5/fP55+wcJpeHUltC2PZyNfX9HB4orxnJ2z2oHI/5hZ9KzRvjo8ekPbIewavzc/z
 FrJQ==
X-Gm-Message-State: AOJu0YwCcp6rWplk6xei3Pr7Ls0ie7dNBMZeGBIZfqqRTKmvQGzATonn
 l9LBI+tvvUmXpN4TqgUGpsnD27ZAnfdMNLc2F8mq9e+V28usZEO1DdwQnECXKF5SsWMTrEH6lOz
 SKqpwX9g+PftGcf7GeRE+nY8pEGDT+FUv6ulr0qsu+Xg0JRxdlk13hA8iWPgj47AnjmPeBFg+pI
 QU1X0En7wpsaHCHIiCGx/r7T689bp+IwDOj5UkSyQ3y45xuoP/
X-Gm-Gg: Acq92OGu4bb6jM89DGLaKSIhdQZsduHapN64dCBhgb6jlGjPxFVjCcqL72HzrBl8zUh
 Iueo1RJw6HTx4AqaltuPQUn9HCsp3w2Etzd7fjkuluD7aLCBzOKkNSNebZYvjkVm2zyQ5xFJArA
 1tfQ/5q35VxGFq87tHaf2XA0li2xFqzYl9JKiqzYbBPbucfNN1RHNEM+YDNLcYN+ggqCd7IJBFn
 hsOwl1P1nbLgJsqs0FIuXm721gQYJ3d71U+FAf9gTG36gm++iyfPi7nXT7zA4t0cukYvNzm464O
 moGvavLHwVOGfjYYEVLS6SxrUF9GMwFGEU66rCYNrIoqt28XuLYA7h1Z0REbD4CDB9N6PG8M/Ku
 FYj758TckoJyf6izKkrZbttFoidZyLL9PYqqkwISNnVL4Ys2iCFdhat2Oh0zGAX8e1IAHPi7mC4
 4hrSsloerNHKPaZLxCG9NRMFiutmjeXC1CclNYNKS4ZYDmCjGNkA==
X-Received: by 2002:a17:903:1a8d:b0:2b7:86be:7673 with SMTP id
 d9443c01a7336-2bd2f4cc12dmr9773735ad.6.1778641508934; 
 Tue, 12 May 2026 20:05:08 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d4050dsm142474405ad.31.2026.05.12.20.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 20:05:08 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH] hw/char: Check interrupt after txctrl register is written
Date: Wed, 13 May 2026 11:05:03 +0800
Message-ID: <20260513030503.3665414-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1030.google.com
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
---
 hw/char/sifive_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index b4de662d616..b9bbaaef595 100644
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
2.43.0


