Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8A6C54FA6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHi9-0007MF-8t; Wed, 28 Aug 2024 08:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHi6-0007BE-92
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:38 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHi4-0001CB-PF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Ez0rcljDHngw2opcQWQvPxakBFq+td5nNgWaWj++x6U=; b=OWrtKi8gPCdisTcHiz0XgKQV4X
 Tkpnxx8MCkklCaO/RLpq6NN8n5eJySR6LKb/MszTcD0vyTRL/F+jMpBg1jhQSfdbBgHlVE2bP+PuL
 cKn24Pickmzl7ST+WwQBmx0DhQMGdkhJl0Vbpvy1JSBWPnwMNaK9zb0dTW0dd1AnDmi9WPg5qxhsh
 URfQ0rRlA3evt+OOL8aXV5vduY62o+bAmPBr9lcEmym44vogc2vxxmWleyQKwEtEIn1G9uvAL9mSp
 JOHaONxMi6fKeBVPn40KLqDEOf/3WNCOwj/rJu/s8TCwwqcqk4nGn9cWh1Qz/MpyutjKhDcXQJ/6W
 kQXIznti2FZ9gUCHyHznKwBva6wmOZRy1ebVBAA/hiLKAYf7ET1+HDKpjqD2HC724E8EyfPpLOuvA
 yO6zQhEHY6ODxNx/xdJcXmwQ8cR5Qwh+M4JV55mz4YSoB2H7OI234WWRS5QVDnk9dPaFZEIh6+uo2
 FLo1EgJi5npwDtY2rjEDhw2IUe5Bey8j2hOICFJEmAjzWzcIn5jCLtnZRLqyty3eU2lEhLLO9HdsQ
 yDMeb+Y5iwMyVsobGPTXHiH8OMjVYB4Fkye5UNFjwo87C0TgYUPn4+l55A1Vfvohi8y2lqEHaIBqK
 4lvNZN30xOUhscCSIQXbX0HbxktXOprVmqfi5iCL0=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhm-000B8d-L4; Wed, 28 Aug 2024 13:23:22 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
Date: Wed, 28 Aug 2024 13:22:55 +0100
Message-Id: <20240828122258.928947-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 6/9] fifo8: honour do_pop argument in fifo8_peekpop_buf()
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

Pass the do_pop value from fifo8_peekpop_buf() to fifo8_peekpop_bufptr() to
allow peeks to the FIFO buffer, including adjusting the skip parameter to
handle the case where the internal FIFO buffer wraps around.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 util/fifo8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 5453cbc1b0..1031ffbe7e 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -117,7 +117,7 @@ static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen,
     }
 
     len = destlen;
-    buf = fifo8_peekpop_bufptr(fifo, len, 0, &n1, true);
+    buf = fifo8_peekpop_bufptr(fifo, len, 0, &n1, do_pop);
     if (dest) {
         memcpy(dest, buf, n1);
     }
@@ -126,7 +126,7 @@ static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen,
     len -= n1;
     len = MIN(len, fifo8_num_used(fifo));
     if (len) {
-        buf = fifo8_peekpop_bufptr(fifo, len, 0, &n2, true);
+        buf = fifo8_peekpop_bufptr(fifo, len, do_pop ? 0 : n1, &n2, do_pop);
         if (dest) {
             memcpy(&dest[n1], buf, n2);
         }
-- 
2.39.2


