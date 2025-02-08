Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EE0C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 16:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgns5-0001DD-Uq; Sat, 08 Feb 2025 11:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgns3-00019i-5f
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:55 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgns1-0000JF-77
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:54 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso29811455e9.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 08:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739032791; x=1739637591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jH9Ymqij6X/GfoOzNSD/xDBEcCWv01J+bpak1JyU5gs=;
 b=B2uuuX1OyrMlAAe9XDZmfCWKlL1mSejNcoLOwlR0cXLSdWackCCdVMmsum0sR0kzhF
 1iV4V8XIlIfF26D14fMXo8YZLPHIbqlsM7McLGS6k2ycmIPJP7P3vP86kTXftHpoXvGd
 WiDUFF26HkK0q1Wmv/rxiOWCA9/Nres+RRoBRUkZwYjhxG/eijcQP+KvdnTguwYFpoQT
 qC1z9eWCdiZLaW/yxQFStzR4fnmRg5TI3TUMljxs4CepMAM8uPy8LeQJy9JlFUM4PB8r
 bVpJssTz2dLRencvf/OWmYrkyKwAW1fphvxYuwNtOSTcxaK9f8YdVBzBgMJODv2gisD5
 HP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739032791; x=1739637591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jH9Ymqij6X/GfoOzNSD/xDBEcCWv01J+bpak1JyU5gs=;
 b=jmL0t83q8cCam6PbEJ6hD4rtJ1zgCY3TCtGbxStSA6DRor4Pl4cnMYa4IxWlrQKA3E
 gCdFZOym0x+5/VrucpDmdjMJmFbGpYtgnZFrOyaRexeVrojV5BY00mtnjC/PjjZVmhBU
 SqLs+aX52MNEs70gdLHno8MeYxS/3tL8MqFO/eCp4S2X0OKNpuCb91YJh+kqyD2nEF7h
 izNVz6Gt0f0x19sYbnOBSuiMPLkI6mvkMUAVlQgS2fFY9QCSA/ECILzCpzz6MTEZ5u7W
 wx/vFEGQcn9II/FwbUUyJQ6wSKEAkIGpPKrYJA/HyIWKNB0ShVDRGnyqHoRB06hZuL4l
 4wdw==
X-Gm-Message-State: AOJu0YxLR2Hvz6nf7USxnDIYihp528C2XWJ6NiVsU5eS0E8FD/Lic1ID
 ylE069p93noqKUaa/JB59EqSyCcQW+x8bK5FU5WJGQkoGJ+dbHJ0ebVBnStFStIuNKF+PFovGoQ
 g1cE=
X-Gm-Gg: ASbGncuTH/u9cMWXcMApX3ARJ3GVpgNjvrlF2I3lMio3kBebbEdaqnRvP6nTuAtFab1
 LkzlBpyGWYQbIs5RwTQgI23qBubi15GfMoJiCKh3H5ARcvTxLaHqqGrkI9+z+LjWKE5QCdkQfSh
 nDikQiR2tukMZ2a3HfZgG2KhU8oO69/gQIcSDUqFX1kwHEP3d1oWQQgTfg34FyQOAHz8iW6H9Ux
 0UR71BUgKoEJmnGiq5O0k1+oewnmIRzs86wb7ERFcv/yHGVNPbhoccBkZ/loQrkCMdrxEaA5NKb
 z/IdgmjMRZbvxo25qnwKxNcrWWMuQgltDm0Z8TiNcBYXdMZsj5tN/bCAlaawwiTxLA==
X-Google-Smtp-Source: AGHT+IFDx2TnrORIfnq7ykrrFztI0awAHQvLJaf/Xc3aPE7Bg8TYqKnCdXrCzMx99dpIHY2+zbuFxw==
X-Received: by 2002:a05:600c:5114:b0:434:ff25:199f with SMTP id
 5b1f17b1804b1-439249bd37amr48708985e9.26.1739032791285; 
 Sat, 08 Feb 2025 08:39:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d964c7csm124586685e9.17.2025.02.08.08.39.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 08:39:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v6 7/7] hw/char/pl011: Implement TX FIFO
Date: Sat,  8 Feb 2025 17:39:11 +0100
Message-ID: <20250208163911.54522-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250208163911.54522-1-philmd@linaro.org>
References: <20250208163911.54522-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If the UART back-end chardev doesn't drain data as fast as stdout
does or blocks, buffer in the TX FIFO to try again later.

This avoids having the IO-thread busy waiting on chardev back-ends,
reported recently when testing the Trusted Reference Stack and
using the socket backend.

Implement registering a front-end 'watch' callback on back-end
events, so we can resume transmitting when the back-end is writable
again, not blocking the main loop.

Similarly to the RX FIFO path, FIFO level selection is not
implemented (interrupt is triggered when a single byte is available
in the FIFO).

Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 39 +++++++++++++++++++++++++++++++--------
 hw/char/trace-events |  1 +
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 3c4264869df..70eba224a9c 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -251,11 +251,15 @@ static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
 {
     PL011State *s = opaque;
     int bytes_consumed;
-    uint8_t data;
+    uint8_t buf[PL011_FIFO_DEPTH];
     uint32_t count;
 
     count = fifo8_num_used(&s->xmit_fifo);
     trace_pl011_fifo_tx_xmit_used(count);
+    if (count < 1) {
+        /* FIFO empty */
+        return G_SOURCE_REMOVE;
+    }
 
     if (!qemu_chr_fe_backend_connected(&s->chr)) {
         /* Instant drain the fifo when there's no back-end. */
@@ -263,19 +267,29 @@ static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
         return G_SOURCE_REMOVE;
     }
 
-    data = fifo8_pop(&s->xmit_fifo);
-    bytes_consumed = 1;
+    count = fifo8_peek_buf(&s->xmit_fifo, buf, fifo8_num_used(&s->xmit_fifo));
+    trace_pl011_fifo_tx_xmit_peek(count);
 
-    /*
-     * XXX this blocks entire thread. Rewrite to use
-     * qemu_chr_fe_write and background I/O callbacks
-     */
-    qemu_chr_fe_write_all(&s->chr, &data, bytes_consumed);
+    /* Transmit as much data as we can. */
+    bytes_consumed = qemu_chr_fe_write(&s->chr, buf, count);
     trace_pl011_fifo_tx_xmit_consumed(bytes_consumed);
+    if (bytes_consumed < 0) {
+        /* Error in back-end: drain the fifo. */
+        pl011_drain_tx(s);
+        return G_SOURCE_REMOVE;
+    }
+
+    /* Pop the data we could transmit. */
+    fifo8_drop(&s->xmit_fifo, bytes_consumed);
     s->int_level |= INT_TX;
 
     pl011_update(s);
 
+    if (!fifo8_is_empty(&s->xmit_fifo)) {
+        /* Reschedule another transmission if we couldn't transmit all. */
+        return G_SOURCE_CONTINUE;
+    }
+
     return G_SOURCE_REMOVE;
 }
 
@@ -300,6 +314,10 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
     trace_pl011_fifo_tx_put(data);
     pl011_loopback_tx(s, data);
     fifo8_push(&s->xmit_fifo, data);
+    if (pl011_is_tx_fifo_full(s)) {
+        s->flags |= PL011_FLAG_TXFF;
+    }
+
     pl011_xmit(NULL, G_IO_OUT, s);
 }
 
@@ -651,6 +669,11 @@ static int pl011_post_load(void *opaque, int version_id)
         s->read_pos = 0;
     }
 
+    if (!fifo8_is_empty(&s->xmit_fifo)) {
+        /* Reschedule another transmission */
+        qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP, pl011_xmit, s);
+    }
+
     s->ibrd &= IBRD_MASK;
     s->fbrd &= FBRD_MASK;
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 7d1cba1b4f8..2d02c057483 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -69,6 +69,7 @@ pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_fifo_tx_is_full(const char *desc, bool full) "mode:%s full:%u"
 pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
+pl011_fifo_tx_xmit_peek(unsigned sent) "TX FIFO peek %u chars"
 pl011_fifo_tx_xmit_used(unsigned sent) "TX FIFO used %u chars"
 pl011_fifo_tx_xmit_consumed(unsigned sent) "TX FIFO consumed %u chars"
 pl011_fifo_tx_overrun(void) "TX FIFO overrun"
-- 
2.47.1


