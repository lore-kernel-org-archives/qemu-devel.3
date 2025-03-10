Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BB8C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 01:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trRwv-00044M-4p; Sun, 09 Mar 2025 21:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRwo-0003zG-3r
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:28:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRwl-0006RU-Dc
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:28:48 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1712421f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 18:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741570125; x=1742174925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ce/6NRq1JPvdEj2O0uStpJg+L6PTsOBLcGGWbCWAug=;
 b=tNUvdt5lwIZGxaZT9eXnOYNuO8PtEA+6+48BJaTtk7ziAx0FOlKCNsbqrOEEA+UJMg
 hAAkHiLAecUrtAmXWCQKdHI+HaP5Td0BwgEaJGSwe1nZG2ZYqnjSVrSb29CC0uVVHSUC
 tvDeqkcKnij1vYaHTr/ItqY62feMTj42Mt003imwgHzUnTN2oELnZ+JjOfI6FEdn1/Xe
 yURZsLH04i/xqW4SXqS6z6fqc9/gQd7pz6Fm6LIJhMtJW3uZsHVrZ519KwKed/F1neIP
 rQsotQ/9K+FV03Ves7JuFzaw4bxtHKu2OKrNO7boMeeE9xfjFx5vmqujXePsnO8gsCXY
 QoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741570125; x=1742174925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ce/6NRq1JPvdEj2O0uStpJg+L6PTsOBLcGGWbCWAug=;
 b=MTS76wW3I7Eb49ubDrA3lbv/gYyvGzgplowM8AxM+1m4YcKOtwJmgCynTDARTwTnIq
 JNsVN6z5vxy+CUmVw0XLW1OGt+3kxTSqVxDOfGmnO3DQ6OBryKLVSrw6JVd+K1xOIzSv
 CwtJuX9I9vl6DZle/8XMUUSQ/gkI9iWp4rHNGMYINqmfITqbzz5/vJPYOrNevJPVGQ/h
 xsOyNTRBCvTL0QyDWEz8yTQBfURh5c9EyGoR23ditGLgYZ49thI3oMeeedzh7QHLto1Q
 z55FFFh+6qNYQKWezQsmt3MTOMaHWqgXsp6lUdg8VAgT1iApNkwNU4X/2DBiyX7dbeX4
 47uA==
X-Gm-Message-State: AOJu0YxWCau8LD1/m5NZnoZHCoRk+QBwTG6F8DIi/w+R983NdtxVF1/0
 8udxY60yFi5TlUWOKBT+oZhGbxZsXM81mlpQch2nQx0UGqRNXqPGiy7YlJAqdUtB7CXoToJnrGX
 nHTw=
X-Gm-Gg: ASbGnctno87cxd1mJ+pCVZg0DDqEN8mDBt5DzEQcF3nHuP4mg/Ek44Nkn16tGGhLyfR
 dIU4FH/xTVrQXLmKHTZhA4YCMxubKLGE0aYzp9s+O6lL7kkzXfcX3Bhqp+J1kAlkTD5rRQ/ewCj
 MQ6jzfL6CqhRdIELjfugMxcJnXt4Opjp1fA3rwrHkCuexbSh+2jPD7rSfzFVWrYFuiaTlcy8UFg
 XAumUBp19LXDJODHLq9+yUr7FC9K5YqbN/Y3SH+tW0OJO95KckmQDmPQnradElWZR3Sjg+zDLte
 BjpThjaPShIGqZGpNOoGNLCQatpsI5BJFsfuoU15v0LgyJDZvsbxzMExPpIrrg0U56q6T8gcS5b
 d8838Kw8Z1tbebzpWPZuwRLYGdT5fwA==
X-Google-Smtp-Source: AGHT+IHMH17IYR5Ovj/m37Ab6pmHw+/2HW5zZIKNLc6UOxDZXcPHSvolywRQoMV9c6kqY3HkAiGxkA==
X-Received: by 2002:a05:6000:410a:b0:391:4559:8761 with SMTP id
 ffacd0b85a97d-39145598929mr1319845f8f.36.1741570125026; 
 Sun, 09 Mar 2025 18:28:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba83csm13154773f8f.6.2025.03.09.18.28.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 18:28:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 3/7] hw/char/pl011: Factor pl011_xmit_cb() out as GSource
Date: Mon, 10 Mar 2025 02:28:21 +0100
Message-ID: <20250310012825.79614-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310012825.79614-1-philmd@linaro.org>
References: <20250310012825.79614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Implement pl011_xmit_cb() using the FEWatchFunc prototype
to register it as GSource. While the return value is not
yet used, we return G_SOURCE_REMOVE, meaning the GSource is
removed from the main loop (because we only send one char).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 113b29cd9e6..18ea03a52f4 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -226,8 +226,9 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
     pl011_fifo_rx_put(s, value);
 }
 
-static void pl011_xmit(PL011State *s)
+static gboolean pl011_xmit_cb(void *do_not_use, GIOCondition cond, void *opaque)
 {
+    PL011State *s = opaque;
     int bytes_consumed;
     uint8_t buf[PL011_FIFO_DEPTH];
     uint32_t count;
@@ -254,6 +255,13 @@ static void pl011_xmit(PL011State *s)
     }
 
     pl011_update(s);
+
+    return G_SOURCE_REMOVE;
+}
+
+static void pl011_xmit(PL011State *s)
+{
+    (void)pl011_xmit_cb(NULL, G_IO_OUT, s);
 }
 
 static void pl011_write_txdata(PL011State *s, uint8_t data)
@@ -630,6 +638,11 @@ static int pl011_post_load(void *opaque, int version_id)
         s->read_pos = 0;
     }
 
+    if (!fifo8_is_empty(&s->xmit_fifo)) {
+        /* Reschedule another transmission */
+        qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP, pl011_xmit_cb, s);
+    }
+
     s->ibrd &= IBRD_MASK;
     s->fbrd &= FBRD_MASK;
 
-- 
2.47.1


