Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01631CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJIB-0001Ts-2J; Tue, 21 Oct 2025 16:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJI8-0001KN-Tl
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:13 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHy-0001D1-99
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso51280425e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079739; x=1761684539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bK/IgKwRrJFV3OCY8FzyiKr65tuHFz4ebIlHwo+ale8=;
 b=x1NIOTsDlkpT5EDKUSULmLnrN9g82cgW3b/AeyVbAPA9jPX+k+eTskXAvMAXGZtuWJ
 zqvwnEY3/BdaymhtaS6900ZAbO/Bys1zIsZHw7xD7JjkNPsP6y61rYCxKaXk289J8191
 LnL2C3Y1y899YdoZGkpVCdLYWGkEiZj4K9HS65n2fHyzQ7jpL9CJSxeBFoFpAT5TtTMQ
 QjiOIyFxtRp47USrOub6dqSNNancPWn/XRi3Xf2o6Wb5ehDa1ZG+W3p3+j3A1WdTY+RC
 7tOCwsLHbTu+xiuqYc605sTauyYiLc2tRZe3YFAE+UNFd7Y3l2/ceCpogmiHochqbyjF
 UgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079739; x=1761684539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bK/IgKwRrJFV3OCY8FzyiKr65tuHFz4ebIlHwo+ale8=;
 b=LLYtMwdlK5Z1uK4wXvnrjB3/qhYb92KfwEkpB8nBr/LDifa0uAxzlyGYCtzUoXETcv
 oapabLydc3+CfkqCzV8qnuz2XdI3sbzoq+khkqUULGQI8Et3lIybbeBXMN4PHzVANREz
 VdbHeJW0P2ZplgWxk31GDlnLSIyfvC53Qsuu8unj0ADTdjotdhnkgnL/om/mcr4L2v0z
 EN5aOCICwsX1TQ3aLRoR5wRjJ2n0I7CqV9ZDJ6dVOzQ6UuyEv3GdJJkFAeypTaextMIB
 mnPsgPPhNsKAIKSlWmaNUpOU3ZMRgqMxDjwnWteKB9DfNZifvyngNNgz7LsdXe4CXLVQ
 p9NA==
X-Gm-Message-State: AOJu0Ywrw4ggR4rrtPcy8jpQbSLswufbO9ZMzXClSKCXVUP2A4PYZVsu
 dE3sEhzTHbaPku6x6yVADpzQVSbhViOLi/nJUCzqEvuPx8MeNVy9oGtYzyDohippbk+LsLz475/
 2IVSEFWM=
X-Gm-Gg: ASbGnctpMmSPK679/xJqs5mdlS7czR7uVP0O2DqtKP7A1Zd43mEtZgGXbcDb4Obsis/
 spvlG0BN7Ac6NEgmh6CHw+WUu2rz5elBgDrhEziw55S7Ij9JL8oaTzPO/nWuZDV/Drlbyu8kBKB
 1iKlFNtfZV27aBqdzJ0Pw5ZEZE5nv6oXtRQWYHjY2l2+KIJnXPEmXZy4vBbiK4gMbY+bPHUkgt5
 eKKxnaeEjuIUOxcgazOL0lNErfZdHathzBwr0xSh/ycZ8TJ++l0kOCSAXEkSmZkr/layKaO7ihC
 DSNMiVeYN3eLZtH8A/oHlHwvPlTtNkSbfpKHLltGNnuOkkUIprXMJ2rNYSD7kGroOwaeRJIE7/X
 VQ8b+FxGemlX4uuFcsrS4ogbzpyDdopoPfUGri6njkquYJRD8drgCEyTFH+OI4s0wadPtTM1K4m
 jY+ZAJVXpSMRpoOkFSq3Ni6MOimf6xrUxkdyl+c221sMhPwVw3Rw==
X-Google-Smtp-Source: AGHT+IHHtf7KB79DNuwlumMgH3spVGKBb5YUBUnO2iWD51AIOtvNgOqco4iS6f/r9Ah7VVWM+El6uw==
X-Received: by 2002:a05:600c:871a:b0:46e:4882:94c7 with SMTP id
 5b1f17b1804b1-471179177camr145140595e9.28.1761079739550; 
 Tue, 21 Oct 2025 13:48:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496d269dbsm22407965e9.11.2025.10.21.13.48.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/45] hw/audio/pcspk: Add I/O trace events
Date: Tue, 21 Oct 2025 22:46:39 +0200
Message-ID: <20251021204700.56072-26-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Allows to see how the guest interacts with the device.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251019210303.104718-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/pcspk.c      | 10 +++++++++-
 hw/audio/trace-events |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index a419161b5b1..f8020593b0b 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -34,6 +34,7 @@
 #include "hw/audio/pcspk.h"
 #include "qapi/error.h"
 #include "qom/object.h"
+#include "trace.h"
 
 #define PCSPK_BUF_LEN 1792
 #define PCSPK_SAMPLE_RATE 32000
@@ -137,13 +138,18 @@ static uint64_t pcspk_io_read(void *opaque, hwaddr addr,
 {
     PCSpkState *s = opaque;
     PITChannelInfo ch;
+    uint8_t val;
 
     pit_get_channel_info(s->pit, 2, &ch);
 
     s->dummy_refresh_clock ^= (1 << 4);
 
-    return ch.gate | (s->data_on << 1) | s->dummy_refresh_clock |
+    val = ch.gate | (s->data_on << 1) | s->dummy_refresh_clock |
        (ch.out << 5);
+
+    trace_pcspk_io_read(s->iobase, val);
+
+    return val;
 }
 
 static void pcspk_io_write(void *opaque, hwaddr addr, uint64_t val,
@@ -152,6 +158,8 @@ static void pcspk_io_write(void *opaque, hwaddr addr, uint64_t val,
     PCSpkState *s = opaque;
     const int gate = val & 1;
 
+    trace_pcspk_io_write(s->iobase, val);
+
     s->data_on = (val >> 1) & 1;
     pit_set_gate(s->pit, 2, gate);
     if (s->voice) {
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index b8ef5727678..30f59215453 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -23,6 +23,10 @@ hda_audio_format(const char *stream, int chan, const char *fmt, int freq) "st %s
 hda_audio_adjust(const char *stream, int pos) "st %s, pos %d"
 hda_audio_overrun(const char *stream) "st %s"
 
+# pcspk.c
+pcspk_io_read(uint16_t addr, uint8_t val) "[0x%"PRIx16"] -> 0x%"PRIx8
+pcspk_io_write(uint16_t addr, uint8_t val) "[0x%"PRIx16"] <- 0x%"PRIx8
+
 #via-ac97.c
 via_ac97_codec_write(uint8_t addr, uint16_t val) "0x%x <- 0x%x"
 via_ac97_sgd_fetch(uint32_t curr, uint32_t addr, char stop, char eol, char flag, uint32_t len) "curr=0x%x addr=0x%x %c%c%c len=%d"
-- 
2.51.0


