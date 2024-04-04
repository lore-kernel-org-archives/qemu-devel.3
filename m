Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2EACD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO2g-0004ER-R9; Thu, 04 Apr 2024 10:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2Z-00045Y-7D
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:07 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2W-00062N-FP
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OUFNvM+qAzbqKKg2MdX8r2zHUUV7uxQBgRO0uH1Fn6A=; b=ZeisTYuX1d7CkjXTwatdp4Dwu+
 fl7bzpEBNRWQDfmnDlbWvtn+iez9JBzC6pR2CLB4Iw65CqUhPD6MY0gLvsLxKGl4GhFurlXY9q6MO
 JoSKCyJw3JI3Jqt0I5AyJg3FCSVzW/4ZZJlO6jl3E/deYbZeeQlqpQ5gIHvFCPZNpPb/aYgdoVlOz
 OwRb3SNYj9gOtK1ig3/UrW7hLAKgpTXe/uWMLI63R+TGDf6mVS161D7uLHsKce4JDZJaL6Oo2PZ+p
 /rb+cENGMXFKpi4xzS2/abIoBnPVKU1S1IZSBP1O+muFUZ1/WQMxexv7VcvCMjR5u5cEaWzjaLD22
 rEZOYwGNE1B20XzK7lAhO6+QJ2O8mK/+7p838NAxssqSpVNXXzgKT1DiCo5aVn0vWjHOS2i0iK761
 YblrMa1NDlYVYtCwWUFNUuhr4p4GDVWhIqQbsYi7tk+FJO0KkA5kV6NINYt3+r5rHrO5CcwT6U0WJ
 m3yIYFOb+kugHcwLfKxql6jb5HgDBAXBcEfHDaOENMN8lF/6dP+xyARHH8P/wUzmK3os3ioChnbc0
 FqiZqdx5VFBQcOHjudE2Pa+7lE9NatA6gyW09SZZleXwrSXCcojSK4GUQNU062mEHx+Hi/GrVF6N5
 jWVAeaV0Z1s7Wkz0PmfqYe9gVoLy8bcyUrJOp918s=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO1U-000Bmt-3i; Thu, 04 Apr 2024 15:25:04 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:23 +0100
Message-Id: <20240404142539.711134-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 01/17] esp.c: move esp_fifo_pop_buf() internals to new
 esp_fifo8_pop_buf() function
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

Update esp_fifo_pop_buf() to be a simple wrapper onto the new esp_fifo8_pop_buf()
function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240324191707.623175-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 590ff99744..1b7b118a0b 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -125,7 +125,7 @@ static uint8_t esp_fifo_pop(Fifo8 *fifo)
     return fifo8_pop(fifo);
 }
 
-static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
+static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
 {
     const uint8_t *buf;
     uint32_t n, n2;
@@ -155,6 +155,11 @@ static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
     return n;
 }
 
+static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
+{
+    return esp_fifo8_pop_buf(fifo, dest, maxlen);
+}
+
 static uint32_t esp_get_tc(ESPState *s)
 {
     uint32_t dmalen;
-- 
2.39.2


