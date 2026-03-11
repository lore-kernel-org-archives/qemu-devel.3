Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212E51125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LEx-0001Im-Re; Wed, 11 Mar 2026 11:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LCi-0003Ks-7B; Wed, 11 Mar 2026 11:10:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LCg-00066a-F6; Wed, 11 Mar 2026 11:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241483; bh=NyOkkYHXSesyPk6l9bUYnlkfII1YnExUjDXhYWA9fOw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=w+FrniagMYNaF/12OImMHfIENs2X7kMztctcFVibO1lsrCThMpFxl4oplvntBiPDl
 wbiLO3I0Icce0FSiHCkxaZcG5eGTZG4C3CCtIwvExfW1OZ8sc4hUerS5bcY5K/uwqF
 ftYoUuPs7Hipsfy9P3le5ylXxsNuJvixvjTDs0d58W2sXhnkedZE+VbVcCIeDVp9aa
 PsYvymPHj/QtMvRahA+yapV1icatKnAoxDIwRpotCcnorSaGgn/7Z4jPM27n4ggvVE
 1m9GIv63QUntskFYIVV88+cqQS74d9fuWlUugPEugjVVLOQ7cIZCLl6TKZ3pk0IN1s
 lZzbVozMY1RDw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D57CB191EAA;
 Wed, 11 Mar 2026 18:04:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BBBBC37C2EB;
 Wed, 11 Mar 2026 18:05:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 39/46] hw/net/xilinx_ethlite: Check for oversized TX
 packets
Date: Wed, 11 Mar 2026 18:03:15 +0300
Message-ID: <20260311150327.1084669-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The xilinx_ethlite network device wasn't checking that the TX packet
size set by the guest was within the size of its dual port RAM, with
the effect that the guest could get it to read off the end of the RAM
block.

Check the length.  There is no provision in this very simple device
for reporting errors, so as with various RX errors we just report via
tracepoint.

This lack of length check has been present since the device was first
introduced, though the code implementing the tx path has changed
somewhat since then.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3317
Fixes: b43848a1005ce ("xilinx: Add ethlite emulation")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20260303172718.437015-1-peter.maydell@linaro.org>
[PMD: renamed size -> tx_size to avoid shadow=compatible-local error]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 6595a8d5d17ea1716ddafb34455ec2b29381e232)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/trace-events b/hw/net/trace-events
index 72b69c4a8b..698290fe79 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -517,3 +517,4 @@ xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d f
 # xilinx_ethlite.c
 ethlite_pkt_lost(uint32_t rx_ctrl) "rx_ctrl:0x%" PRIx32
 ethlite_pkt_size_too_big(uint64_t size) "size:0x%" PRIx64
+ethlite_pkt_tx_size_too_big(uint64_t size) "size:0x%" PRIx64
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 42b19d07c7..665def8a34 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -162,9 +162,15 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
         break;
     case TX_CTRL:
         if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
-            qemu_send_packet(qemu_get_queue(s->nic),
-                             txbuf_ptr(s, port_index),
-                             s->port[port_index].reg.tx_len);
+            uint32_t tx_size = s->port[port_index].reg.tx_len;
+
+            if (tx_size >= BUFSZ_MAX) {
+                trace_ethlite_pkt_tx_size_too_big(tx_size);
+            } else {
+                qemu_send_packet(qemu_get_queue(s->nic),
+                                 txbuf_ptr(s, port_index),
+                                 tx_size);
+            }
             if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
                 eth_pulse_irq(s);
             }
-- 
2.47.3


