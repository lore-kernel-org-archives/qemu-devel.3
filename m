Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDAAC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8hk-0006o8-Ok; Wed, 12 Aug 2026 09:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8hc-0006Rc-Rl; Wed, 12 Aug 2026 09:09:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8hZ-0005ZE-JU; Wed, 12 Aug 2026 09:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=4EACNSb41NykVhjIA0+ehmFV7QgSEePtQyRjDj2uJg8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=loXNTGdwMwqYBHPIo5jNksdjDrsfLLkfz6BkZbDcl19FYWXl/07kXgkTf/okAi7es
 VCQVxtq5hO7nWdRfaNJBPnfwH4FFljuJsUQ9c517N4WsnloKLdrxQ53dLxYidDaEu5
 XO8KOWpCjtm7pDrXeFsqOFcE7b0ym1mQjLhj40b+JGET0dRoG/lec1DaPQuHWlub2m
 24aHssyzgxJ3F4Iz6QBZ09xP/lYHfSLwerDpDBDg/EIKCtlGkNtmXipcWsT1O7IihL
 XuqZD8bixAzQQGqwk9CRf40EMid5yKy4Z+tx387BTVICkGc7IuIsOSRLGsmuh7qLaQ
 S23Xg4CMKXImA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 31F991CA4BC;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 684AD409B9F;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6B7DA2F90E; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 061/102] hw/net/xilinx_axienet: Don't write checksums
 off end of packet
Date: Wed, 12 Aug 2026 16:01:36 +0300
Message-ID: <20260812130233.621965-61-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The xilinx_axienet device has ethernet checksum offloading, with a
mode where the guest provides the offsets within the packet where
the data to be checksummed starts, and where the final checksum
should be written into the packet.

We don't sanity check the TX_CSINSERT offset before writing the
checksum data into it, which means the guest can pass us a value that
is larger than the packet itself and cause us to write the checksum
off the end of the buffer.  We also don't explicitly check the
TX_CSBEGIN offset; this doesn't currently cause any problems because
we will pass a negative length to net_checksum_add() which does
nothing, but it's a potential trap for the future if the type
used for the length gets changed to be unsigned.

Explicitly check the offsets.  The datasheet doesn't say what happens
if the guest misprograms this, so we choose to log an error and send
the packet as-is.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3599
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260706162704.787495-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 8cbcf7579355f995340aa27ad197ef61c4969c06)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index d2f98db1026..d0b51851f48 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -918,20 +918,27 @@ xilinx_axienet_data_stream_push(StreamSink *obj, uint8_t *buf, size_t size,
     if (s->hdr[0] & 1) {
         unsigned int start_off = s->hdr[1] >> 16;
         unsigned int write_off = s->hdr[1] & 0xffff;
-        uint32_t tmp_csum;
-        uint16_t csum;
 
-        tmp_csum = net_checksum_add(s->txpos - start_off,
-                                    buf + start_off);
-        /* Accumulate the seed.  */
-        tmp_csum += s->hdr[2] & 0xffff;
+        if (start_off > s->txpos || write_off + 2 > s->txpos) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: offsets outside packet, skipping checksum\n",
+                          TYPE_XILINX_AXI_ENET);
+        } else {
+            uint32_t tmp_csum;
+            uint16_t csum;
+
+            tmp_csum = net_checksum_add(s->txpos - start_off,
+                                        buf + start_off);
+            /* Accumulate the seed.  */
+            tmp_csum += s->hdr[2] & 0xffff;
 
-        /* Fold the 32bit partial checksum.  */
-        csum = net_checksum_finish(tmp_csum);
+            /* Fold the 32bit partial checksum.  */
+            csum = net_checksum_finish(tmp_csum);
 
-        /* Writeback.  */
-        buf[write_off] = csum >> 8;
-        buf[write_off + 1] = csum & 0xff;
+            /* Writeback.  */
+            buf[write_off] = csum >> 8;
+            buf[write_off + 1] = csum & 0xff;
+        }
     }
 
     qemu_send_packet(qemu_get_queue(s->nic), buf, s->txpos);
-- 
2.47.3


