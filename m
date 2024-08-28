Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381ACC54F32
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHi0-0006nZ-B1; Wed, 28 Aug 2024 08:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhx-0006eB-Rv
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhw-0001BI-El
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=vGpfbNq2Of1XusU1luTkApo6WOYeX4WUm8cX9OwaBRI=; b=Uz0vGsRR4OzggowHrkjjlfiVLY
 Ru9XPhDKn3Y3mW6DGreleIxFP+/o5ILqKhR7N+wuXcPUYpS/ReL3u4NqAEAzPWxwPLQUDQpxOpf1v
 EgMl6snJlfVne/phXJM2h+f8P5UFeCuWvMvmjplsSlrTW5XjbmahY2f1yAF2P0h3ZU+xn8fBM+3nw
 E44TqYvzSN4k/xIImpJZ8AWicjezIwBqpErHBLft1g/yaDQqw1wKn48OSDBi7Aven85Cd8ZClAzP+
 CE6lq5BTtzpmU9G047MADDP+w5y6CgmaNhrIfh3NB7KD7N6SdJsn53OpnWrYmCBc2PziZ4i1TFPI9
 DmKSwMPvG4JjwwVfXgnGpVS7IT8e0Y139iACTXfwKhGcNhBl9DYu2nlNryF/D4Pm5yan6lK2MIkQR
 ecdWiSWfKQ1TAxpD1W5sUayaq7FYDE8ttsIjRxfCaSFQVbC+wzzTh3AcIu3ueeNgmuJUTMbbxxsk1
 /jQQYrfMqRszxtu2DmvEj8RRVrssSWPKIgH1CfAjRsKmHsfq4QXIGHU2fExGN0KybovORLIS/F1j4
 eZ+HLzz3wn3usEGm+bN+bjsAYpO+sIEkmVRonvemdZcYUqey2oykHkCBS6ar+Wo59aLvQ03utbMZz
 A93q/jHwHCHmf0GF3BP0/y1lmY+lAk/sjJc99OK+Y=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhe-000B8d-5E; Wed, 28 Aug 2024 13:23:14 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
Date: Wed, 28 Aug 2024 13:22:53 +0100
Message-Id: <20240828122258.928947-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 4/9] fifo8: replace fifo8_pop_bufptr() with
 fifo8_peekpop_bufptr() in fifo8_pop_buf()
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

The upcoming peek functionality will require passing a non-zero value to
fifo8_peekpop_bufptr().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 util/fifo8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 62d6430b05..efe0117b1f 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -116,7 +116,7 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
     }
 
     len = destlen;
-    buf = fifo8_pop_bufptr(fifo, len, &n1);
+    buf = fifo8_peekpop_bufptr(fifo, len, 0, &n1, true);
     if (dest) {
         memcpy(dest, buf, n1);
     }
@@ -125,7 +125,7 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
     len -= n1;
     len = MIN(len, fifo8_num_used(fifo));
     if (len) {
-        buf = fifo8_pop_bufptr(fifo, len, &n2);
+        buf = fifo8_peekpop_bufptr(fifo, len, 0, &n2, true);
         if (dest) {
             memcpy(&dest[n1], buf, n2);
         }
-- 
2.39.2


