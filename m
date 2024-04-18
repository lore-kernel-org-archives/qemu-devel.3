Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F815C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVuv-0001kY-C0; Thu, 18 Apr 2024 13:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVum-0001T2-46; Thu, 18 Apr 2024 13:51:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVuj-0007ef-VC; Thu, 18 Apr 2024 13:51:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CB6FA5FD73;
 Thu, 18 Apr 2024 20:50:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3BE41B934D;
 Thu, 18 Apr 2024 20:50:01 +0300 (MSK)
Received: (nullmailer pid 947860 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 106/116] hw/net/lan9118: Replace magic '2048' value by
 MIL_TXFIFO_SIZE definition
Date: Thu, 18 Apr 2024 20:49:36 +0300
Message-Id: <20240418174955.947730-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
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

The magic 2048 is explained in the LAN9211 datasheet (DS00002414A)
in chapter 1.4, "10/100 Ethernet MAC":

  The MAC Interface Layer (MIL), within the MAC, contains a
  2K Byte transmit and a 128 Byte receive FIFO which is separate
  from the TX and RX FIFOs. [...]

Note, the use of the constant in lan9118_receive() reveals that
our implementation is using the same buffer for both tx and rx.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240409133801.23503-2-philmd@linaro.org>
(cherry picked from commit a45223467e4e185fff1c76a6483784fa379ded77)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index cf7b8c897a..f0a8a3fa10 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -150,6 +150,12 @@ do { printf("lan9118: " fmt , ## __VA_ARGS__); } while (0)
 
 #define GPT_TIMER_EN    0x20000000
 
+/*
+ * The MAC Interface Layer (MIL), within the MAC, contains a 2K Byte transmit
+ * and a 128 Byte receive FIFO which is separate from the TX and RX FIFOs.
+ */
+#define MIL_TXFIFO_SIZE         2048
+
 enum tx_state {
     TX_IDLE,
     TX_B,
@@ -166,7 +172,7 @@ typedef struct {
     int32_t pad;
     int32_t fifo_used;
     int32_t len;
-    uint8_t data[2048];
+    uint8_t data[MIL_TXFIFO_SIZE];
 } LAN9118Packet;
 
 static const VMStateDescription vmstate_lan9118_packet = {
@@ -182,7 +188,7 @@ static const VMStateDescription vmstate_lan9118_packet = {
         VMSTATE_INT32(pad, LAN9118Packet),
         VMSTATE_INT32(fifo_used, LAN9118Packet),
         VMSTATE_INT32(len, LAN9118Packet),
-        VMSTATE_UINT8_ARRAY(data, LAN9118Packet, 2048),
+        VMSTATE_UINT8_ARRAY(data, LAN9118Packet, MIL_TXFIFO_SIZE),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -544,7 +550,7 @@ static ssize_t lan9118_receive(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
-    if (size >= 2048 || size < 14) {
+    if (size >= MIL_TXFIFO_SIZE || size < 14) {
         return -1;
     }
 
-- 
2.39.2


