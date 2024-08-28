Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB861C54FA7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHi4-000746-MM; Wed, 28 Aug 2024 08:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHi2-0006ua-3a
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:34 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHi0-0001Bn-Kv
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=kf9Ve67a1UgUxcnM/R9AUK9NzEj+yPiW0W7QQ3PtyCM=; b=gNZexQRKV24C/BfydNKs6dyBdU
 dzZNib4N7p74yeBBXcbfwetGcnUeUshOq91wt9y4YgVURfkQ+4Xt5+gShzPP03WiehXxHVyVEoLpT
 g8Lkn5D/T/FUL6+6zbJv1VFes7ICkG8czYDCWhTNayeW/7lTa84hF92AFh9NRBSQkLbHmEeffGYdC
 vVAYi8cnjjVs/L1EL2AxRbxrofRxctuxD0sMeV1i0dVk0KwBw2uuuTmD6H4+GBxUaGCGXwElzJHrX
 Y91Jhp7MCXr7UOP8HtxzCtzH8HJldNhn3XxDXdnnU7U1BZ3QHZtjo8a1dWXEmMMQdpQG7+Y7Q0WS5
 r3/mMPgTj4d4Q/g4IWkCjFFwSAHmC2Po/zTfsbCWZl7ZX7ghlEviChU/WF3wrhIxqMqwjugYJVFCb
 RGf2q7ZrOzaw3K0jtYALjiYZ3raWkHETYftUUNQDk/b6BHU8hqCPgEFMgj/VDwk52ox3tQ1scgySN
 oYUNBSHdVnspnN2BqEnEp4+sa/E4lJhJFQZeyzBjVtX5FQWb2qF8D0UPFdwlOo6wFlWWuOUsCp3+x
 hTaBwtKW1usaDfQRXllDduBoNC8oNIlO058dJ8Jz3dmjcuS7570v6vNMIK3ACjfiB7/2FRPkjkPHj
 EanZ5peBeWmg0H41EdRbE5GB9Xn89RcuxE+lhkUEo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhi-000B8d-EZ; Wed, 28 Aug 2024 13:23:18 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
Date: Wed, 28 Aug 2024 13:22:54 +0100
Message-Id: <20240828122258.928947-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 5/9] fifo8: rename fifo8_pop_buf() to fifo8_peekpop_buf()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The fifo8_pop_buf() function will soon also be used for peek operations, so rename
the function accordingly. Create a new fifo8_pop_buf() wrapper function that can
be used by existing callers.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 util/fifo8.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index efe0117b1f..5453cbc1b0 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -105,7 +105,8 @@ const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
     return fifo8_peekpop_bufptr(fifo, max, 0, numptr, true);
 }
 
-uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
+static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen,
+                                  bool do_pop)
 {
     const uint8_t *buf;
     uint32_t n1, n2 = 0;
@@ -134,6 +135,11 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
     return n1 + n2;
 }
 
+uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
+{
+    return fifo8_peekpop_buf(fifo, dest, destlen, true);
+}
+
 void fifo8_drop(Fifo8 *fifo, uint32_t len)
 {
     len -= fifo8_pop_buf(fifo, NULL, len);
-- 
2.39.2


