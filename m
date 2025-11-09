Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A007CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 22:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIDYz-0007e6-2f; Sun, 09 Nov 2025 17:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYv-0007bC-Tw
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:05 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYt-0005sx-OY
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:05 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D0FFE60051;
 Sun,  9 Nov 2025 22:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C69AC4CEF8;
 Sun,  9 Nov 2025 22:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762726022;
 bh=AE064KC6fJp9k34pKNAiAgUpdKS2GXPpXNt8THd2RYM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J6gHySLG4UGVRHQ+ku2dDONlbsW72bRWWgPCGSauP0ULeIDNIZJ1fPJAR87Utfb8f
 YzM25gj5NJ4qTGc+g5hdJd6MAMGQi+lSQGlQGRQgynxH/LTQD2hWgHNbguhpQH1D3k
 kPC3tXS5UsoWAWPCZidrSkdSY99FRkiOrLc06Tdf/4HUQAW5syzBDgUboe7IQ5vjaP
 mIzYtnTCvVlZwqCqH4yaSr1/UVDaTgAPw7bubTclPOkVLKgbqjMQyQQz8/fOC4Vl7g
 xZMSLEqat1jnxkA1ltPSgV3kL0MWnoNFpbN1IHuiSBDeu7vm8w1ATyKgqZNCUv9Fi+
 criTCRsw7mCoQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 3/7] i82596: Remove crc_valid variable
Date: Sun,  9 Nov 2025 23:06:50 +0100
Message-ID: <20251109220654.46718-4-deller@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109220654.46718-1-deller@kernel.org>
References: <20251109220654.46718-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

While testing and developing for the HPUX 10.20 the crc_valid variable
was used in performing CRC checks for the loopback. I expected the
CRC to be absent on specific condition and would skip some
functional checks for the loopback packet, so initially it added
a if-clause that would skip the checks preventing HPUX from
getting stuck at phase loopback.

However, we can remove it, and this then fixes Coverity CID 1642868.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/i82596.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 37dcc0387b..fb6b54fd71 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -992,7 +992,6 @@ static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
     size_t payload_size = 0;
     size_t bytes_copied = 0;
     const uint8_t *packet_data = buf;
-    bool crc_valid = true;
     bool out_of_resources = false;
     size_t crc_size = i82596_get_crc_size(s);
 
@@ -1155,16 +1154,11 @@ rx_complete:
         }
     }
 
-    if (packet_completed && crc_valid) {
+    if (packet_completed) {
         rx_status |= STAT_C | STAT_OK;
         if (is_broadcast) {
             rx_status |= 0x0001;
         }
-    } else if (packet_completed) {
-        rx_status |= STAT_C;
-        if (!crc_valid) {
-            rx_status |= RX_CRC_ERRORS;
-        }
     } else {
         rx_status |= STAT_B;
     }
@@ -1187,7 +1181,7 @@ rx_complete:
         return size;
     }
 
-    if (packet_completed && crc_valid && s->rx_status == RX_READY) {
+    if (packet_completed && s->rx_status == RX_READY) {
         uint32_t next_rfd_addr = i82596_translate_address(s, rfd.link, false);
         if (next_rfd_addr != 0 && next_rfd_addr != I596_NULL) {
             set_uint32(s->scb + 8, next_rfd_addr);
-- 
2.51.1


