Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9976CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 12:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1l5x-00053r-14; Thu, 25 Sep 2025 08:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1l5u-00053Y-1v
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 08:29:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1l5q-00005r-SO
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 08:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=yzR378beEnouElcu9qJJzaLyoNzQwCHIKwblljupTIQ=; b=JAjQXQsShvDtmZ4VlWOYEl2BPZ
 LTAYeHQdXLe8j3rrsY1KvwNLkfmR3VK+5dVT+jEHWTFUysLb68Qo/Gj//0RUzGsQbYcFwM9rqrk9I
 8FKQ+2U9BsJnhwV1SlYWkzTtgd+V1V/Ohn6Rmv3BKQFMQBhl7zvn66f8Cb4q+1/T+VPJu/DkoCvZh
 6FPaunZVfznmHlHLpva8kKNlo/Mw6XB4cixXUaDmfBbcfY1Rxx0Ucf/aF3QZlEjZHS+IVoMBnU/9/
 EJAkE+xk/QjCTlFkdr4OgZj6CID7VANWtOSDBb8wlVZP+6h41qNYWagIZToFjnR40IhcSkrWMMSw+
 eRHwjmKe4JTDNRS6ehRzH94ig2iH8ZGJ2eVIYSuUQcCi+V9Rp8qmsIkzkEqBLHkwGII4i8R+1A+1i
 Rr92OaU1RBm7H+1ash4jgM/fMyKyIKx/jznzBS49rFH5A/zWOyZwu5mg7i20o0GknGlUTN0Sb3sP5
 xaTJf7o+HmHONjZ786pM5gg72nN0MSB90irCiZtUYRGEyPotnuJMHAFjdtSsKwylY5aJUoSZpWbuj
 1WkkYQz5Z9BFyQaCWb7gnnQCrRaWazM4cBTMKotQEyztaYPQHnPZP3RADXkemO/Akpul1Hhcq8FxR
 SnOtnpgvWpCaHh+eXHnY64+VDEfDgn/ZBPSIrnNWs=;
Received: from [217.155.175.48] (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1l3h-0008Tc-2X; Thu, 25 Sep 2025 13:26:49 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, farosas@suse.de, lvivier@redhat.com,
 qemu-devel@nongnu.org
Date: Thu, 25 Sep 2025 13:28:45 +0100
Message-Id: <20250925122846.527615-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250925122846.527615-1-mark.cave-ayland@ilande.co.uk>
References: <20250925122846.527615-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/2] esp.c: fix esp_cdb_ready() FIFO wraparound limit
 calculation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The original calculation in commit 3cc70889a3 ("esp.c: prevent cmdfifo overflow
in esp_cdb_ready()") subtracted cmdfifo_cdb_offset from fifo8_num_used() to
calculate the outstanding cmdfifo length, but this is incorrect because
fifo8_num_used() can also include wraparound data.

Instead calculate the maximum offset used by scsi_cdb_length() which is just
the first byte after cmdfifo_cdb_offset, and then peek the entire content
of the cmdfifo. The fifo8_peek_bufptr() result will then return the maximum
length of remaining data up to the end of the internal cmdfifo array, which
can then be used for the overflow check.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: 3cc70889a3 ("esp.c: prevent cmdfifo overflow in esp_cdb_ready()")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3082
---
 hw/scsi/esp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1d264c40e5..2809fcdee0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -447,7 +447,9 @@ static void write_response(ESPState *s)
 
 static bool esp_cdb_ready(ESPState *s)
 {
-    int len = fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset;
+    /* scsi_cdb_length() only reads the first byte */
+    int limit = s->cmdfifo_cdb_offset + 1;
+    int len = fifo8_num_used(&s->cmdfifo);
     const uint8_t *pbuf;
     uint32_t n;
     int cdblen;
@@ -457,7 +459,7 @@ static bool esp_cdb_ready(ESPState *s)
     }
 
     pbuf = fifo8_peek_bufptr(&s->cmdfifo, len, &n);
-    if (n < len) {
+    if (n < limit) {
         /*
          * In normal use the cmdfifo should never wrap, but include this check
          * to prevent a malicious guest from reading past the end of the
-- 
2.39.5


