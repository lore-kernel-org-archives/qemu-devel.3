Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BD7CFC53B
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 21:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMusU-0001lX-GS; Sat, 22 Nov 2025 16:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMusR-0001kr-JV; Sat, 22 Nov 2025 16:10:39 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMusI-0007TR-Nj; Sat, 22 Nov 2025 16:10:36 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B563916D311;
 Sun, 23 Nov 2025 00:03:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 69E3A3223E5;
 Sun, 23 Nov 2025 00:03:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.22 23/25] hw/display/xlnx_dp.c: Don't abort on AUX FIFO
 overrun/underrun
Date: Sat, 22 Nov 2025 23:55:41 +0300
Message-ID: <20251122210344.48374-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
References: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index b0828d65aa..d5c6d19ab5 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -432,7 +432,18 @@ static void xlnx_dp_aux_clear_rx_fifo(XlnxDPState *s)
 
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
 
@@ -463,7 +474,18 @@ static void xlnx_dp_aux_clear_tx_fifo(XlnxDPState *s)
 
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
 
@@ -472,8 +494,10 @@ static uint8_t xlnx_dp_aux_pop_tx_fifo(XlnxDPState *s)
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


