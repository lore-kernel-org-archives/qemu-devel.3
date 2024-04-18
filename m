Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0967FC05023
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXyh-0001p7-UL; Thu, 18 Apr 2024 16:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXya-0001lY-Lv; Thu, 18 Apr 2024 16:03:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXyY-0005QJ-Te; Thu, 18 Apr 2024 16:03:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 199E65FE15;
 Thu, 18 Apr 2024 23:02:28 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 784EBB93FB;
 Thu, 18 Apr 2024 23:02:25 +0300 (MSK)
Received: (nullmailer pid 952878 invoked by uid 1000);
 Thu, 18 Apr 2024 20:02:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chuhong Yuan <hslester96@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 54/59] hw/net/lan9118: Fix overflow in MIL TX FIFO
Date: Thu, 18 Apr 2024 23:02:14 +0300
Message-Id: <20240418200224.952785-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When the MAC Interface Layer (MIL) transmit FIFO is full,
truncate the packet, and raise the Transmitter Error (TXE)
flag.

Broken since model introduction in commit 2a42499017
("LAN9118 emulation").

When using the reproducer from
https://gitlab.com/qemu-project/qemu/-/issues/2267 we get:

  hw/net/lan9118.c:798:17: runtime error:
  index 2048 out of bounds for type 'uint8_t[2048]' (aka 'unsigned char[2048]')
    #0 0x563ec9a057b1 in tx_fifo_push hw/net/lan9118.c:798:43
    #1 0x563ec99fbb28 in lan9118_writel hw/net/lan9118.c:1042:9
    #2 0x563ec99f2de2 in lan9118_16bit_mode_write hw/net/lan9118.c:1205:9
    #3 0x563ecbf78013 in memory_region_write_accessor system/memory.c:497:5
    #4 0x563ecbf776f5 in access_with_adjusted_size system/memory.c:573:18
    #5 0x563ecbf75643 in memory_region_dispatch_write system/memory.c:1521:16
    #6 0x563ecc01bade in flatview_write_continue_step system/physmem.c:2713:18
    #7 0x563ecc01b374 in flatview_write_continue system/physmem.c:2743:19
    #8 0x563ecbff1c9b in flatview_write system/physmem.c:2774:12
    #9 0x563ecbff1768 in address_space_write system/physmem.c:2894:18
    ...

[*] LAN9118 DS00002266B.pdf, Table 5.3.3 "INTERRUPT STATUS REGISTER"

Cc: qemu-stable@nongnu.org
Reported-by: Will Lester
Reported-by: Chuhong Yuan <hslester96@gmail.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2267
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240409133801.23503-3-philmd@linaro.org>
(cherry picked from commit ad766d603f39888309cfb1433ba2de1d0e9e4f58)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 00a6d82efb..bf81c84984 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -798,8 +798,22 @@ static void tx_fifo_push(lan9118_state *s, uint32_t val)
             /* Documentation is somewhat unclear on the ordering of bytes
                in FIFO words.  Empirical results show it to be little-endian.
                */
-            /* TODO: FIFO overflow checking.  */
             while (n--) {
+                if (s->txp->len == MIL_TXFIFO_SIZE) {
+                    /*
+                     * No more space in the FIFO. The datasheet is not
+                     * precise about this case. We choose what is easiest
+                     * to model: the packet is truncated, and TXE is raised.
+                     *
+                     * Note, it could be a fragmented packet, but we currently
+                     * do not handle that (see earlier TX_B case).
+                     */
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "MIL TX FIFO overrun, discarding %u byte%s\n",
+                                  n, n > 1 ? "s" : "");
+                    s->int_sts |= TXE_INT;
+                    break;
+                }
                 s->txp->data[s->txp->len] = val & 0xff;
                 s->txp->len++;
                 val >>= 8;
-- 
2.39.2


