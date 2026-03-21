Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9771094489
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3yXx-00037f-EW; Sat, 21 Mar 2026 11:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yXv-00036e-7M; Sat, 21 Mar 2026 11:47:27 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yXr-0003JT-3a; Sat, 21 Mar 2026 11:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=MO
 W1hNfAfn57B9gVKObv9M+ctxXe6YQiGWq7CTF+mIw=; b=BlzFhGVKhbwLdK0LZq
 e7f1RpIHEZe7uaEmsXRy/IpxzaX/9teJxz/VQ+oHhw1HMjwchRELcAfhbIfIrBhG
 mNSeWp+4DWiqhWkcMaMwQ8rEfEDxDdaYUjk9+l0ycRf9H0RMZfOTKRLFx6MGmkDO
 jfXHTol1cxZhdNW667NpoqT+w=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgAH9XF2vb5p1YbwTQ--.2111S3;
 Sat, 21 Mar 2026 23:47:04 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v1 1/5] Fixed the PL011 FIFO level bug
Date: Sat, 21 Mar 2026 23:46:56 +0800
Message-ID: <53bae159845bae966f620b42e7873b7f24404284.1774099044.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1774099044.git.dingtao0430@163.com>
References: <cover.1774099044.git.dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgAH9XF2vb5p1YbwTQ--.2111S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4rur48Jry7ur4rKr15Jwb_yoW8Cw47pF
 na93W5Kas7CF1rXr4rA3WDJr4avFn2qFW2yrWxuFWFva43JrnYgrn2kay2g347WFWSv3yU
 uF43Xr4UJr17uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR-18kUUUUU=
X-Originating-IP: [101.204.36.117]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-RmX1Wm+vXkX8gAA3Q
Received-SPF: pass client-ip=117.135.210.5; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

According to TRM, PL011 generate a burst or a single DMA request based on the FIFO level

The FlowCntrl field description is as follows:
     Receive interrupt FIFO level select. 
     b000 = Receive FIFO becomes >= 1/8 full
     b001 = Receive FIFO becomes >= 1/4 full
     b010 = Receive FIFO becomes >= 1/2 full
     b011 = Receive FIFO becomes >= 3/4 full
     b100 = Receive FIFO becomes >= 7/8 full
     b101-b111 = reserved

Only the read_trigger of rx has been changed, and there is no need to set a trigger for tx 
because write tx data always completes in a blocking manner. That means tx FIFO is empty.

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/char/pl011.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index cb12c3e224..c96a706da1 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -129,6 +129,14 @@ static const uint32_t irqmask[] = {
     INT_E,
 };
 
+static const uint32_t fifo_level[] = {
+    PL011_FIFO_DEPTH / 8,
+    PL011_FIFO_DEPTH / 4,
+    PL011_FIFO_DEPTH / 2,
+    PL011_FIFO_DEPTH * 3 / 4,
+    PL011_FIFO_DEPTH * 7 / 8,
+};
+
 static void pl011_update(PL011State *s)
 {
     uint32_t flags;
@@ -344,17 +352,24 @@ static uint64_t pl011_read(void *opaque, hwaddr offset,
     return r;
 }
 
+static uint32_t pl011_decode_fifo_level(uint32_t val)
+{
+    if (val > 4) {
+        qemu_log_mask(LOG_GUEST_ERROR, "pl011: invalid fifo level field\n");
+        return 1;
+    }
+    return fifo_level[val];
+}
+
 static void pl011_set_read_trigger(PL011State *s)
 {
-#if 0
     /* The docs say the RX interrupt is triggered when the FIFO exceeds
        the threshold.  However linux only reads the FIFO in response to an
        interrupt.  Triggering the interrupt when the FIFO is non-empty seems
        to make things work.  */
     if (s->lcr & LCR_FEN)
-        s->read_trigger = (s->ifl >> 1) & 0x1c;
+        s->read_trigger = pl011_decode_fifo_level(extract32(s->ifl, 3, 3));
     else
-#endif
         s->read_trigger = 1;
 }
 
-- 
2.43.0


