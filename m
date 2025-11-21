Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C898BCFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd7e-00057q-TJ; Fri, 21 Nov 2025 21:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd1j-00011x-53; Fri, 21 Nov 2025 21:07:03 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd05-0001rH-3i; Fri, 21 Nov 2025 21:06:03 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 42FCE16C6EA;
 Fri, 21 Nov 2025 16:51:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 99892321987;
 Fri, 21 Nov 2025 16:52:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 18/76] esp.c: fix esp_cdb_ready() FIFO wraparound
 limit calculation
Date: Fri, 21 Nov 2025 16:50:56 +0300
Message-ID: <20251121135201.1114964-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250925122846.527615-2-mark.cave-ayland@ilande.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 36ec1a829a07cd9a926b2f0ddfa5079c8dc9dae5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


