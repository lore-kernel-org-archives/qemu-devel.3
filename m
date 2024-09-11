Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A6CEE49A0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJq-0001xM-Pv; Wed, 11 Sep 2024 08:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMI4-0001oV-6E
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHu-0007ZL-Nv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3787ddbd5a2so1170926f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057053; x=1726661853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Nx+lj200bo+xsg0LIsQyP8I0DcjUxGoGWnFa0dywV4=;
 b=hdeOgvN2djdyTB5Z2AeS/Sow0u8JMsaBAwz/jweEc/Glhs4GgxJrm3von+qaqMkzZZ
 n5Ayo46EYR5++Klyi1kfvcZcXsPElyTvu9WfR2AYGxYQIrq180p7vJ4LGRuEG6zyWOCj
 Hp3zjzdeJSeNNQy/5HYpT/PsJvOHLepLO8hdKZdXDvRilYynf3brsynSlxu+2ey9FIMr
 sbMv+XeMgJJpQWMWD9biTa0kBD1SmoTYJM08XiMB4FjxskkAzLK3EOoJiaxAXtLVSU9i
 xEykhTOZbWFD4xj5f0XSTX3mN60AJhLVAOORE9qPfpB9xXCpOnAvfV0jYh9P/N6izKtK
 3Ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057053; x=1726661853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Nx+lj200bo+xsg0LIsQyP8I0DcjUxGoGWnFa0dywV4=;
 b=FOGQ57KGlCSNyqMepNXphL4eqXUUZcIrSDGjheZyerVnrs5tcuhsSK8urnFGZfguqh
 CUKsm2Nw7WAQz6sliNS2Jw0bdGS8WK67zN/LQh53jh0V8PYHuVZ+M91XHkHT3P26/r/H
 nPvIXxreSuGchzJ+otfKACgqlXV6805nQiTAizikykyjoyLjicGYnfbgx+1b3LwSGt7+
 0U97rCH3MaunrJIUI6XNY2w/bnzChRMX4e6xPdjPhVwh3xlnhi70hn5p7YHW1+RMULZJ
 GKEVmHdn8Nj42X5AIKj/+6EpOHr5ffTnZOTdhr2iuxx3krfVUoH3WFT9mhCB24umnjSs
 BzxA==
X-Gm-Message-State: AOJu0YwRONFqPPtGum+gH+6fN/Zr/T0Q0bKLZVDJyFcK7ptxNeTtVFvv
 1B2/I+vhrlVmn62z9zKUyQZmmApSATO+Hf+OUZO5h1miEYpdKpZ8E6/rBZ6XjN8mT1GeZv+tvAV
 Y
X-Google-Smtp-Source: AGHT+IHy3HCgkItht2dPUkBPNwtLgIk0znc/WhoNqIqNlsfcfhJu+pBqMiTVECRSpV6CUxpNDo7vDg==
X-Received: by 2002:adf:eb8b:0:b0:371:88b9:256d with SMTP id
 ffacd0b85a97d-378b07966f2mr1836355f8f.6.1726057052793; 
 Wed, 11 Sep 2024 05:17:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789564a072sm11511514f8f.2.2024.09.11.05.17.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:17:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 28/56] hw/char/pl011: Extract pl011_read_rxdata() from
 pl011_read()
Date: Wed, 11 Sep 2024 14:13:53 +0200
Message-ID: <20240911121422.52585-29-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

To keep MemoryRegionOps read/write handlers with similar logic,
factor pl011_read_txdata() out of pl011_read(), similar to what
the previous commit did to pl011_write().
No functional change intended.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240719181041.49545-8-philmd@linaro.org>
---
 hw/char/pl011.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 1dfa60cb12..26d391a16d 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -235,31 +235,38 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
     pl011_update(s);
 }
 
+static uint32_t pl011_read_rxdata(PL011State *s)
+{
+    uint32_t c;
+
+    s->flags &= ~PL011_FLAG_RXFF;
+    c = s->read_fifo[s->read_pos];
+    if (s->read_count > 0) {
+        s->read_count--;
+        s->read_pos = (s->read_pos + 1) & (pl011_get_fifo_depth(s) - 1);
+    }
+    if (s->read_count == 0) {
+        s->flags |= PL011_FLAG_RXFE;
+    }
+    if (s->read_count == s->read_trigger - 1) {
+        s->int_level &= ~INT_RX;
+    }
+    trace_pl011_read_fifo(s->read_count);
+    s->rsr = c >> 8;
+    pl011_update(s);
+    qemu_chr_fe_accept_input(&s->chr);
+    return c;
+}
+
 static uint64_t pl011_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
     PL011State *s = (PL011State *)opaque;
-    uint32_t c;
     uint64_t r;
 
     switch (offset >> 2) {
     case 0: /* UARTDR */
-        s->flags &= ~PL011_FLAG_RXFF;
-        c = s->read_fifo[s->read_pos];
-        if (s->read_count > 0) {
-            s->read_count--;
-            s->read_pos = (s->read_pos + 1) & (pl011_get_fifo_depth(s) - 1);
-        }
-        if (s->read_count == 0) {
-            s->flags |= PL011_FLAG_RXFE;
-        }
-        if (s->read_count == s->read_trigger - 1)
-            s->int_level &= ~ INT_RX;
-        trace_pl011_read_fifo(s->read_count);
-        s->rsr = c >> 8;
-        pl011_update(s);
-        qemu_chr_fe_accept_input(&s->chr);
-        r = c;
+        r = pl011_read_rxdata(s);
         break;
     case 1: /* UARTRSR */
         r = s->rsr;
-- 
2.45.2


