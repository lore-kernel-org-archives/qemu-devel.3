Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB56C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwkT-0005py-K0; Mon, 21 Jul 2025 16:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1udwjF-0004rU-8R; Mon, 21 Jul 2025 16:03:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1udwjB-0004kc-Fh; Mon, 21 Jul 2025 16:03:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 01474139044;
 Mon, 21 Jul 2025 23:02:48 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B4CB124BED0;
 Mon, 21 Jul 2025 23:03:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 67/70] hw/net/npcm_gmac.c: Send the right data for
 second packet in a row
Date: Mon, 21 Jul 2025 23:02:54 +0300
Message-ID: <20250721200302.133559-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250721221446@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250721221446@cover.tls.msk.ru>
MIME-Version: 1.0
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

The transmit loop in gmac_try_send_next_packet() is constructed in a
way that means it will send incorrect data if it it sends more than
one packet.

The function assembles the outbound data in a dynamically allocated
block of memory which is pointed to by tx_send_buffer.  We track the
first point in this block of memory which is not yet used with the
prev_buf_size offset, initially zero.  We track the size of the
packet we're sending with the length variable, also initially zero.

As we read chunks of data out of guest memory, we write them to
tx_send_buffer[prev_buf_size], and then increment both prev_buf_size
and length.  (We might dynamically reallocate the buffer if needed.)

When we send a packet, we checksum and send length bytes, starting at
tx_send_buffer, and then we reset length to 0.  This gives the right
data for the first packet.  But we don't reset prev_buf_size.  This
means that if we process more descriptors with further data for the
next packet, that data will continue to accumulate at offset
prev_buf_size, i.e.  after the data for the first packet.  But when
we transmit that second packet, we send length bytes from
tx_send_buffer, so we will send a packet which has the length of the
second packet but the data of the first one.

The fix for this is to also clear prev_buf_size after the packet has
been sent -- we never need the data from packet one after we've sent
it, so we can write packet two's data starting at the beginning of
the buffer.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 871a6e5b339f0b5e71925ec7d3f452944a1c82d3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index e1fb383772..d4dba630ac 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -615,6 +615,7 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
             trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, length);
             buf = tx_send_buffer;
             length = 0;
+            prev_buf_size = 0;
         }
 
         /* step 6 */
-- 
2.47.2


