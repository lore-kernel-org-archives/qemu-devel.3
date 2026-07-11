Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421D4C44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifmw-0007PG-Hm; Sat, 11 Jul 2026 18:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifmd-00077Q-3H; Sat, 11 Jul 2026 18:02:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifmb-0008Si-8h; Sat, 11 Jul 2026 18:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=N6CrWlcueapDe57i8B21TJMFx1p1nROoiikxrxvS2aY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RLiFjxvdyMOuyfSXZNQDIYmAdTA3rMQWavHK4ZEXI8y2z7xN+hQtvrj6Xk1DLlrko
 0YxvPDoUKqUiiLI4SjQZAmr0ZMkfW4JrX+xBgtAQ8qm6SMuZlyK3i2opawUcq/Xp8q
 scP/lHjp21BZXj4mzRPZRAz54HwiyO7j1FTgWkpftMe7KOJXgsNk0qxk67cQXVeRno
 iZ610ERfSkb4dGzkBr5lR2yojcJlnDCDbuqKg7HzhDZzXlvCgdRJZ+jFrLGcN43979
 I3omPS67wHaQuDH44z9SdG4YQiFAtkq0qZ7+AEEcBWdSOnzkZdPa7HX0zgWNp7ZC5S
 SsIhA3asgeqcA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DBA6F1C0AAD;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 91D0C3EAF38;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 87A1713327; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Feifan Qian <bea1e@proton.me>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 34/81] hw/net/fsl_etsec: validate FCB offsets in
 process_tx_fcb()
Date: Sun, 12 Jul 2026 00:58:12 +0300
Message-ID: <20260711215904.3757-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Feifan Qian <bea1e@proton.me>

The TX Frame Control Block (FCB) is prepended to a TX frame when
BD_TX_TOEUN is set. It contains two guest-controlled u8 offset
fields that process_tx_fcb() uses to locate L3/L4 headers within
the frame buffer:

  l3_header_offset = FCB byte 3 (0..255)
  l4_header_offset = FCB byte 2 (0..255)

These offsets are applied without any bounds check. When the
UDP-no-CTU branch is taken, the function writes zero to
l4_header[6] and l4_header[7]. With both offsets set to 0xFF the
write target is:

  tx_buffer + 8 + 255 + 255 + 6/7 = tx_buffer + 525

A malicious guest can therefore corrupt up to 509 bytes of heap
memory beyond a minimally-sized (16 B) TX frame.

Fix: reject the frame and log a guest error when the minimum
required buffer length

  8 (FCB) + l3_header_offset + l4_header_offset + 8

exceeds tx_buffer_len. Move the l3_header and l4_header pointer
declarations past the new guard so that out-of-bounds pointers
are never materialised.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3517
Signed-off-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit bc22c7e4187a619bf9ff7776288b588322e9ee41)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 22660c32b84..e60303f52cf 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -176,15 +176,30 @@ static void tx_padding_and_crc(eTSEC *etsec, uint32_t min_frame_len)
 static void process_tx_fcb(eTSEC *etsec)
 {
     uint8_t flags = (uint8_t)(*etsec->tx_buffer);
-    /* L3 header offset from start of frame */
+    /* L3 header offset from start of frame (FCB byte 3) */
     uint8_t l3_header_offset = (uint8_t)*(etsec->tx_buffer + 3);
-    /* L4 header offset from start of L3 header */
+    /* L4 header offset from start of L3 header (FCB byte 2) */
     uint8_t l4_header_offset = (uint8_t)*(etsec->tx_buffer + 2);
+    uint8_t *l3_header;
+    uint8_t *l4_header;
+    int csum = 0;
+
+    /*
+     * Validate FCB header offsets before pointer arithmetic. The highest
+     * byte accessed is l4_header[7], at offset
+     *   8 (FCB size) + l3_header_offset + l4_header_offset + 7
+     * from tx_buffer. Drop the frame if this exceeds the buffer length.
+     */
+    if (etsec->tx_buffer_len < 8u + l3_header_offset + l4_header_offset + 8u) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "eTSEC: FCB offsets exceed frame length, dropping\n");
+        return;
+    }
+
     /* L3 header */
-    uint8_t *l3_header = etsec->tx_buffer + 8 + l3_header_offset;
+    l3_header = etsec->tx_buffer + 8 + l3_header_offset;
     /* L4 header */
-    uint8_t *l4_header = l3_header + l4_header_offset;
-    int csum = 0;
+    l4_header = l3_header + l4_header_offset;
 
     /* if packet is IP4 and IP checksum is requested */
     if (flags & FCB_TX_IP && flags & FCB_TX_CIP) {
-- 
2.47.3


