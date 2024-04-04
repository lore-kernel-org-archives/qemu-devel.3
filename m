Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D87CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO38-0004st-Er; Thu, 04 Apr 2024 10:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO36-0004ky-LD
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:40 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO35-00068g-1T
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RGI/dW+wU4cE10AbKx7qwjc00hana6geqec5d2Ig5yc=; b=ApRpZAYYQ+qFCij4falSflhdmp
 ZkVPecp0gAvU6gojpXppz9zdK/tleN7puGkr4L8UmjjmYDRsQVOtYwPx8egAUexTM636i/Jr4OTif
 +ZX2BNBeer8PKwLz4ImG24DMxsIg9sb9TiVKoDDGXIaHTv2euBF/vIgvPaumleVH2KewCUvdDBxk9
 f4t7U5oAQl17ytha0dLdvI+LEUdXwp+fMWxruYTMRt+35MLz6RbPKKtpYaacyVOGhHm2noCf+8idU
 0j3wHPEJHaYWa+cg08IGlQUtjgeqCo+YQVWf/PeehFLsokVtV4b6ovfofWec142rHFbqsxvm1YG+f
 f/+S8z8AUg5kJUh//ikqW7M9XqgYkQVid+l1RsMOI6h5BxCu4wBR4x1syALMJVVE+ksuXsClh4fKr
 Npwi0pmCXrEuzlYnX3pkXarTjr3F7mW2dafv+xZaGJfjeDu6NbbTImweD1F1Z7YKJJzEpby0kRRBm
 BOIOiqPRxUZKEYUe/JoqqNXKvk/KeOrnho2iK09aUbUpCtC3h1qZp5RwzHb80O/RVlrH6iWnm2VG4
 X2HlI7mPf6aRB2so8g2Z/+rVedNxeBB9aevVTls93IvcfIfzupCNgqNtJc1CBUvds6TYXn53HIjIO
 cY+VCcaHJ/BkdnctNp1M0CIbQUTicFIJlj8jGqKUc=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO26-000Bmt-Sj; Thu, 04 Apr 2024 15:25:42 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:34 +0100
Message-Id: <20240404142539.711134-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 12/17] esp.c: prevent cmdfifo overflow in esp_cdb_ready()
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

During normal use the cmdfifo will never wrap internally and cmdfifo_cdb_offset
will always indicate the start of the SCSI CDB. However it is possible that a
malicious guest could issue an invalid ESP command sequence such that cmdfifo
wraps internally and cmdfifo_cdb_offset could point beyond the end of the FIFO
data buffer.

Add an extra check to fifo8_peek_buf() to ensure that if the cmdfifo has wrapped
internally then esp_cdb_ready() will exit rather than allow scsi_cdb_length() to
access data outside the cmdfifo data buffer.

Reported-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240324191707.623175-13-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f47abc36d6..d8db33b921 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -429,13 +429,23 @@ static bool esp_cdb_ready(ESPState *s)
 {
     int len = fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset;
     const uint8_t *pbuf;
+    uint32_t n;
     int cdblen;
 
     if (len <= 0) {
         return false;
     }
 
-    pbuf = fifo8_peek_buf(&s->cmdfifo, len, NULL);
+    pbuf = fifo8_peek_buf(&s->cmdfifo, len, &n);
+    if (n < len) {
+        /*
+         * In normal use the cmdfifo should never wrap, but include this check
+         * to prevent a malicious guest from reading past the end of the
+         * cmdfifo data buffer below
+         */
+        return false;
+    }
+
     cdblen = scsi_cdb_length((uint8_t *)&pbuf[s->cmdfifo_cdb_offset]);
 
     return cdblen < 0 ? false : (len >= cdblen);
-- 
2.39.2


