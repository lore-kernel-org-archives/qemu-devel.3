Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEDAEE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMIj-00043J-4c; Wed, 11 Sep 2024 08:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHt-0001AR-Gs
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHi-0007Xy-Nd
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so56894665e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057030; x=1726661830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOnWvRRyMi0ExO59Jh1Y9+c06EipfPZb/MJT4ZzRoR4=;
 b=DvOflJHN4xKbJS/YTXnR5bExQ2L/NCsZwdaua0WhS+Wk7RN1qPn1FLtGMkBhGJGkua
 Omblorw9DLWL7hgaL1s1y9/Tf9Hk+mPcWmy/Q4fkibBMN2vsoA1XKs/B3Pm2FgWkUSwv
 4gCp9gzLoe/9pv77XgV/sQ3JOQUVST3bX9/OITP5N6BGYuR5V0bIVUW39KSeNMhES1V5
 A1VavSpil+sBTaudG9KjVs884QuMAU11NbSMlm0196WF+EjyTg2xLMMxzfSJNfnwhWTD
 7maaIL5ENZUJDBxWjeChqBzLU85bFLuwv79C0jXPIaH11pZy/2tJMvWjKe7G4bbAC65Z
 HBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057030; x=1726661830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOnWvRRyMi0ExO59Jh1Y9+c06EipfPZb/MJT4ZzRoR4=;
 b=asbWSPlNbfE1uWIpQ3duMu8/aDJ3PxYtk9SOHxMryCiHtrde2mIB1owOZ2h50KkHEV
 RgLnUTSWJDMzx2tPHZmJmTRX4Ko9DeAoE2c5H8jjPXU4cg9ctEq1mhmFqENZ/StBVyO1
 nThVbvX76Z8A/YC1dJoRn7Ng7VWvigS3rRd6InH6/AdcKw+wDeapHQdnKvKScxKo7U+W
 3pf9GLZcxvPEWt1vxI6WPxrDZDXqY8urupwZ0LwZ/WqG2SExOShKehVFl0uy3E74r64W
 p65L6vzrZRyP+q5B2i8/PZAEJU1CuZNUJmfkaMb1NEyaKtp1e2bxzjjGCRcRZhG1e6a7
 IiYw==
X-Gm-Message-State: AOJu0Yw36jopX/DEGjAULA5snObrC6ThNCyl4T7C80rVBqZ72c8k7rtV
 JPdmuU+UMC2LfkmaSYV9bW1Garo3Jx1RGV9oSVZb3fp9kunL9+x97vZRS8W9GXKPD4RFkjHEZpj
 B
X-Google-Smtp-Source: AGHT+IFB1Zr+NsFYEDYW48xPslI3p1Nq812o5chSfoFY6eWpO/0nrp178h0rfNy/17NNTiAwrSh08Q==
X-Received: by 2002:a05:600c:3c8d:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-42c9f9d35f5mr130961605e9.22.1726057029990; 
 Wed, 11 Sep 2024 05:17:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb33a92sm140746885e9.20.2024.09.11.05.17.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:17:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 24/56] hw/char/pl011: Move pl011_put_fifo() earlier
Date: Wed, 11 Sep 2024 14:13:49 +0200
Message-ID: <20240911121422.52585-25-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Avoid forward-declaring pl011_put_fifo() by moving it earlier.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240719181041.49545-4-philmd@linaro.org>
---
 hw/char/pl011.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 260f5fc0bc..edb5395fb8 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -159,6 +159,28 @@ static inline void pl011_reset_fifo(PL011State *s)
     s->flags |= PL011_FLAG_RXFE | PL011_FLAG_TXFE;
 }
 
+static void pl011_put_fifo(void *opaque, uint32_t value)
+{
+    PL011State *s = (PL011State *)opaque;
+    int slot;
+    unsigned pipe_depth;
+
+    pipe_depth = pl011_get_fifo_depth(s);
+    slot = (s->read_pos + s->read_count) & (pipe_depth - 1);
+    s->read_fifo[slot] = value;
+    s->read_count++;
+    s->flags &= ~PL011_FLAG_RXFE;
+    trace_pl011_put_fifo(value, s->read_count);
+    if (s->read_count == pipe_depth) {
+        trace_pl011_put_fifo_full();
+        s->flags |= PL011_FLAG_RXFF;
+    }
+    if (s->read_count == s->read_trigger) {
+        s->int_level |= INT_RX;
+        pl011_update(s);
+    }
+}
+
 static uint64_t pl011_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
@@ -314,8 +336,6 @@ static void pl011_loopback_mdmctrl(PL011State *s)
     pl011_update(s);
 }
 
-static void pl011_put_fifo(void *opaque, uint32_t value);
-
 static void pl011_loopback_tx(PL011State *s, uint32_t value)
 {
     if (!pl011_loopback_enabled(s)) {
@@ -440,28 +460,6 @@ static int pl011_can_receive(void *opaque)
     return r;
 }
 
-static void pl011_put_fifo(void *opaque, uint32_t value)
-{
-    PL011State *s = (PL011State *)opaque;
-    int slot;
-    unsigned pipe_depth;
-
-    pipe_depth = pl011_get_fifo_depth(s);
-    slot = (s->read_pos + s->read_count) & (pipe_depth - 1);
-    s->read_fifo[slot] = value;
-    s->read_count++;
-    s->flags &= ~PL011_FLAG_RXFE;
-    trace_pl011_put_fifo(value, s->read_count);
-    if (s->read_count == pipe_depth) {
-        trace_pl011_put_fifo_full();
-        s->flags |= PL011_FLAG_RXFF;
-    }
-    if (s->read_count == s->read_trigger) {
-        s->int_level |= INT_RX;
-        pl011_update(s);
-    }
-}
-
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 {
     /*
-- 
2.45.2


