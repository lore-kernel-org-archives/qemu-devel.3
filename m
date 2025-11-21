Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535BECFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcwB-0001jw-1X; Fri, 21 Nov 2025 21:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMc7J-00053P-K5; Fri, 21 Nov 2025 20:08:45 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMc79-0003xK-5c; Fri, 21 Nov 2025 20:08:42 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2404716CA72;
 Fri, 21 Nov 2025 21:44:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D50D1321CAE;
 Fri, 21 Nov 2025 21:44:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 55/81] hw/display/xlnx_dp.c: Don't abort on AUX FIFO
 overrun/underrun
Date: Fri, 21 Nov 2025 21:43:54 +0300
Message-ID: <20251121184424.1137669-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Peter Maydell <peter.maydell@linaro.org>

The documentation of the Xilinx DisplayPort subsystem at
https://www.xilinx.com/support/documents/ip_documentation/v_dp_txss1/v3_1/pg299-v-dp-txss1.pdf
doesn't say what happens if a guest tries to issue an AUX write
command with a length greater than the amount of data in the AUX
write FIFO, or tries to write more data to the write FIFO than it can
hold, or issues multiple commands that put data into the AUX read
FIFO without reading it such that it overflows.

Currently QEMU will abort() in these guest-error situations, either
in xlnx_dp.c itself or in the fifo8 code.  Make these cases all be
logged as guest errors instead.  We choose to ignore the new data on
overflow, and return 0 on underflow. This is in line with how we handled
the "read from empty RX FIFO" case in commit a09ef5040477.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1418
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1419
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1424
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20251106145209.1083998-2-peter.maydell@linaro.org
(cherry picked from commit f52db7f34242d3398bab0bacaa3e5dde99be5258)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 1272da0133..1ca7ab860d 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -435,7 +435,18 @@ static void xlnx_dp_aux_clear_rx_fifo(XlnxDPState *s)
 
 static void xlnx_dp_aux_push_rx_fifo(XlnxDPState *s, uint8_t *buf, size_t len)
 {
+    size_t avail = fifo8_num_free(&s->rx_fifo);
     DPRINTF("Push %u data in rx_fifo\n", (unsigned)len);
+    if (len > avail) {
+        /*
+         * Data sheet doesn't specify behaviour here: we choose to ignore
+         * the excess data.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: ignoring %zu bytes pushed to full RX_FIFO\n",
+                      __func__, len - avail);
+        len = avail;
+    }
     fifo8_push_all(&s->rx_fifo, buf, len);
 }
 
@@ -466,7 +477,18 @@ static void xlnx_dp_aux_clear_tx_fifo(XlnxDPState *s)
 
 static void xlnx_dp_aux_push_tx_fifo(XlnxDPState *s, uint8_t *buf, size_t len)
 {
+    size_t avail = fifo8_num_free(&s->tx_fifo);
     DPRINTF("Push %u data in tx_fifo\n", (unsigned)len);
+    if (len > avail) {
+        /*
+         * Data sheet doesn't specify behaviour here: we choose to ignore
+         * the excess data.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: ignoring %zu bytes pushed to full TX_FIFO\n",
+                      __func__, len - avail);
+        len = avail;
+    }
     fifo8_push_all(&s->tx_fifo, buf, len);
 }
 
@@ -475,8 +497,10 @@ static uint8_t xlnx_dp_aux_pop_tx_fifo(XlnxDPState *s)
     uint8_t ret;
 
     if (fifo8_is_empty(&s->tx_fifo)) {
-        error_report("%s: TX_FIFO underflow", __func__);
-        abort();
+        /* Data sheet doesn't specify behaviour here: we choose to return 0 */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: attempt to read empty TX_FIFO\n",
+                      __func__);
+        return 0;
     }
     ret = fifo8_pop(&s->tx_fifo);
     DPRINTF("pop 0x%2.2X from tx_fifo.\n", ret);
-- 
2.47.3


