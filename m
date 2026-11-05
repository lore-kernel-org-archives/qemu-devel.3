Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18A606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWFlSdyM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP5zv-00049l-SU; Thu, 05 Nov 2026 17:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5ze-00047Z-O5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:42 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zb-0002KY-SX
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:37 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D662243C4E;
 Thu,  5 Nov 2026 22:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB781F0089F;
 Thu,  5 Nov 2026 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793917894;
 bh=9YKYa16OlW6gff7bbNGW6ouixzpoLveDS0YSKd7LLdo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hWFlSdyMdpkejZrAVuWI4T/tThlIqNYh9jd7MfFRxkLeTs+g13gab/0LxM8Jz8HOg
 18qZ3mX7BgJlZnm/jzQ/egm/XoULw3/NiR7/jQx8FXsxMRfhu1zHKDXxnqWa7qV8Za
 tc2ae+maUwa2M5g6d/12bfPTsigNlVI7Y7TxwRWd8oZcgC2PhU/InLbL9hY3L19HeV
 zPF2/pCZrJCMK0vagQSk142Z3u+e0bEfw3I6uD/DAy5uWKxRj2SFpMRqhed8K2brDx
 3RG72m+P1/woK+WuWOMWSoETYblfH4863NJkgvXuM80k2RxCqusX8Zo/KNKuIbhz8H
 ZJc/WpMUp0gkg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL v2 6/8] i82596: Drop crc calculation
Date: Thu,  5 Nov 2026 23:31:20 +0100
Message-ID: <20261105223122.8729-7-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105223122.8729-1-deller@kernel.org>
References: <20261105223122.8729-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

No need to calculate and add additional CRCs here.

Noticed-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/i82596.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 35e0b58330..6bcae73815 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -180,7 +180,6 @@ static void examine_scb(I82596State *s);
 static bool i82596_check_medium_status(I82596State *s);
 static int i82596_csma_backoff(I82596State *s, int retry_count);
 static uint16_t i82596_calculate_crc16(const uint8_t *data, size_t len);
-static size_t i82596_append_crc(I82596State *s, uint8_t *buffer, size_t len);
 static void i82596_bus_throttle_timer(void *opaque);
 static void i82596_flush_queue_timer(void *opaque);
 static int i82596_flush_packet_queue(I82596State *s);
@@ -624,7 +623,7 @@ static int i82596_tx_copy_buffers(I82596State *s, hwaddr tfd_addr,
     return total_len;
 }
 
-static int i82596_tx_process_frame(I82596State *s, bool insert_crc)
+static int i82596_tx_process_frame(I82596State *s)
 {
     uint32_t total_len = s->tx_frame_len;
 
@@ -642,10 +641,6 @@ static int i82596_tx_process_frame(I82596State *s, bool insert_crc)
         total_len = I596_MIN_FRAME_LEN;
     }
 
-    if (insert_crc) {
-        total_len = i82596_append_crc(s, s->tx_buffer, total_len);
-    }
-
     s->tx_frame_len = total_len;
     return total_len;
 }
@@ -710,15 +705,12 @@ static void i82596_transmit(I82596State *s, uint32_t addr)
     int collision_count = 0;
     int frame_len;
     bool success = true;
-    bool insert_crc;
 
     i82596_tx_tfd_read(s, tfd_addr, &tfd);
     trace_i82596_tx_tfd(tfd_addr, tfd.status_bits, tfd.command,
                         tfd.link_addr, tfd.tbd_addr);
 
     s->current_tx_desc = tfd_addr;
-    insert_crc = (I596_NOCRC_INS == 0) && ((tfd.command & 0x10) == 0) &&
-                 !I596_LOOPBACK;
     collision_count = i82596_tx_csma_cd(s, &tx_status);
     if (collision_count < 0) {
         success = false;
@@ -730,7 +722,8 @@ static void i82596_transmit(I82596State *s, uint32_t addr)
         success = false;
         goto tx_complete;
     }
-    frame_len = i82596_tx_process_frame(s, insert_crc);
+    /* QEMU net clients exchange frames without the FCS */
+    frame_len = i82596_tx_process_frame(s);
     if (frame_len <= 0) {
         tx_status |= TX_ABORTED_ERRORS;
         success = false;
@@ -1401,25 +1394,6 @@ static uint16_t i82596_calculate_crc16(const uint8_t *data, size_t len)
     return crc;
 }
 
-static size_t i82596_append_crc(I82596State *s, uint8_t *buffer, size_t len)
-{
-    if (len + 4 > PKT_BUF_SZ) {
-        return len;
-    }
-
-    if (I596_CRC16_32) {
-        uint32_t crc = crc32(~0, buffer, len);
-        crc = cpu_to_be32(crc);
-        memcpy(&buffer[len], &crc, sizeof(crc));
-        return len + sizeof(crc);
-    } else {
-        uint16_t crc = i82596_calculate_crc16(buffer, len);
-        crc = cpu_to_be16(crc);
-        memcpy(&buffer[len], &crc, sizeof(crc));
-        return len + sizeof(crc);
-    }
-}
-
 static void i82596_update_statistics(I82596State *s, bool is_tx,
                                       uint16_t error_flags,
                                       uint16_t collision_count)
-- 
2.54.0


