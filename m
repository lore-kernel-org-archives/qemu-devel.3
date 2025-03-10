Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E98C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 01:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trRx6-0004FL-FG; Sun, 09 Mar 2025 21:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRx1-000499-RL
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:29:06 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRx0-0006UR-8G
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:29:03 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so2568682f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 18:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741570140; x=1742174940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKtjkSGQAPRNNqtasOzh5Hz0iRBusUZv23b35HZSLgg=;
 b=hVaxKV3TBOhDT371aMbXEMAPOBN31mYmf14ZqVNMrL3t6G3w8HZUrF/5HRqtGDfY/r
 8ofXTZ8J1xHO11jSqas9qX1I1AJTUn2NKffhqTAXdd/F+dH56KRxottocYoFWOY4phqR
 3WjrhQECVxxSyWig3rpzzzVS2b9VB5hdF55o0RNGkRsyMqRgjfP3zH4i/rjNDZsWrpBU
 HitHbRfWyRzAbV6jeXNi1oWCZ/9lTxXvyGlTXIwfjXBKFp5K1x3fOqi1MiNigXizhz2+
 /GhtC0c5Qej6IXr3o0HEiokW+RfLmQs0I3ri7jJpi/Thz6mLrPrxTLch3CyGd+aWoq0g
 02Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741570140; x=1742174940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nKtjkSGQAPRNNqtasOzh5Hz0iRBusUZv23b35HZSLgg=;
 b=VtN4BqRBmBP3HnscxZq869oLvgjVM1xwuH8EVFhid6wao8lmOAZN348wACo9ffPRSk
 I4iYQr3F5u3xrUrBrEnJZwI+TuGnPwYJGwSNSqEk4InCb6rVpYhQ8BvSp1O6MPVVqEkO
 yFQqL+CsznuskIF4hYmS9j0xiyXwwJTvfBMytc/n4IWZEVmWo81eUeli8E9mKi746+To
 IeT1f+uxBsZxnoqU2qJ7vZtOyTaujlH9iAb5FjWzsbXO53q5SzuZ5TK+okSFviiO7PJc
 j1G52US3/J4NAhUlhOSzxetqKySizayKhDp3h9jyZJqeM03So76RmWzqdURDQYZdlFqk
 zwOw==
X-Gm-Message-State: AOJu0YxLgYseZme/XKrp5uQ+kwy1AdklgE838dpQ03Y/FMPbsM4ZkVn0
 uCBo6Jyrl8P4d61O9pu98uV0lmk2BUVyOdDV7126jyz50KWHkxFV4dhG9upJFOxB1uRRB/H+Rht
 nZHw=
X-Gm-Gg: ASbGncvCf6jgLUYGBm/b4FzNWSZmIPu2sv7XFPJbonu0YhDrmJAYPuBSQ/nn5HD3pE9
 vhiGV8+fhiFQ/+dZkhz2L5jwVBhFCRhorBIl2NED35vNcPHn/MC95F7p8RozkHxzbHA4z9w73s8
 rX5mNf/XP0kUQVJd/SJSe8l2zLRLT8Q3cunobNDzpfPFmdLOqnnczWWdnVXX6jYhWTK8aBGjGya
 VDgfOnNBdbslNbi3ORRSBlZKqA1Q6nJm9KfGbjebOMZbu/ZWJJQWtvntt9Ae06LI7fBSbfz63Mx
 pduTmORCea/lzThsvdCuy/bmzqeumVtD83OUb82ambtQc+pBpa8KLNcUzJZs5hFuzq0Flrc6U+L
 DxnKn7WXrkGhFR8UIoks=
X-Google-Smtp-Source: AGHT+IHNntuQ+2t/fvIlVmWKxkKTZizcSizGwVgK0BelP3nmHfAzIaAMvncZimaF2C6X3H/VvhggUg==
X-Received: by 2002:adf:a3cd:0:b0:391:46a6:f0db with SMTP id
 ffacd0b85a97d-39146a6f2ddmr1260640f8f.37.1741570140590; 
 Sun, 09 Mar 2025 18:29:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cee22c13fsm51483595e9.40.2025.03.09.18.28.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 18:29:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 6/7] hw/char/pl011: Drain TX FIFO when no backend connected
Date: Mon, 10 Mar 2025 02:28:24 +0100
Message-ID: <20250310012825.79614-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310012825.79614-1-philmd@linaro.org>
References: <20250310012825.79614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

When no character backend is connected, the PL011 frontend
just drains the FIFO.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/pl011.c      | 13 +++++++++++++
 hw/char/trace-events |  1 +
 2 files changed, 14 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index f67ce951ac9..6d26a3e13f8 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -241,6 +241,13 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
     pl011_fifo_rx_put(s, value);
 }
 
+static void pl011_drain_tx(PL011State *s)
+{
+    trace_pl011_fifo_tx_drain(fifo8_num_used(&s->xmit_fifo));
+    pl011_reset_tx_fifo(s);
+    s->rsr &= ~RSR_OE;
+}
+
 static gboolean pl011_xmit_cb(void *do_not_use, GIOCondition cond, void *opaque)
 {
     PL011State *s = opaque;
@@ -252,6 +259,12 @@ static gboolean pl011_xmit_cb(void *do_not_use, GIOCondition cond, void *opaque)
     count = fifo8_num_used(&s->xmit_fifo);
     trace_pl011_fifo_tx_xmit_used(count);
 
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
+        /* Instant drain the fifo when there's no back-end. */
+        pl011_drain_tx(s);
+        return G_SOURCE_REMOVE;
+    }
+
     buf[0] = fifo8_pop(&s->xmit_fifo);
     bytes_consumed = 1;
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index d52f511a1e2..730d6292a2d 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -71,6 +71,7 @@ pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
 pl011_fifo_tx_xmit_used(unsigned sent) "TX FIFO used %u chars"
 pl011_fifo_tx_xmit_consumed(unsigned sent) "TX FIFO consumed %u chars"
 pl011_fifo_tx_overrun(void) "TX FIFO overrun"
+pl011_fifo_tx_drain(unsigned drained) "TX FIFO draining %u chars"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 pl011_receive(int size) "recv %d chars"
 
-- 
2.47.1


