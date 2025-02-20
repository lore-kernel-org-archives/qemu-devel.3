Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E12C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2sV-0008Ol-1N; Thu, 20 Feb 2025 04:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2sR-0008Lk-3j
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:29:51 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2sO-0003TV-N0
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:29:50 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22128b7d587so11508115ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043787; x=1740648587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+pfJWALs0vQU6dXlJLT5cjO4jcFzB6bulUI2QERKYM=;
 b=DFgbUxZ0PuPq0+WoDLjMqncYOM/EDhd4xxq+UPL0QBnrpBdgiiCXsDeJRaj5XYWxAT
 sbatLWuFHiOUYPcCSWPXJGZj8+x+r8ZKn9reHCCw693gWV4IhmeJ5UQcqTWBaUEst8ZZ
 nVhq4Wa4Jtmu0patd6v5HjO0ackg0Q4AEY1WDOTuF3lxwjsr6lUeWE585wE8IhdiCy0J
 S6YoJj2akrYiOw8+imeS04zpsYgUYw7w22INcrwLLxIAIIgCrxPhi+9FJVxWJ/k+fx1D
 c2iEXAJpAKAqbXyczkzrde9Ie6pB9160oJUDD7Cb5/petslKfnHoy42ihRe6ihUQCfOj
 7mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043787; x=1740648587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+pfJWALs0vQU6dXlJLT5cjO4jcFzB6bulUI2QERKYM=;
 b=aMJnc6uGjeq3nCijGX8OiHX6Jqd/kPAls9r6RSCIKMKLFXPq9PppihPuQ3vPzkPXDL
 X/1+B6qpmcYBuJojCrcr6uBufswL0rQqX6jf41emiXhQhbLWDSa619G0JdQoBhO50jkX
 i0jpiYNwLOFfhRPv06rSoi/2Q5U6mmjzKQ9k02DMLZsivV/L6zeS2Yq9QTcIVY2bLQ3w
 b4IaVeN0oLsU8/ZkI+4Ip3JTbdTfNzPdmPuNNadO3sMywAriwxuLuiqh13bbUJ8qygP0
 qKxAHDQnZS1m2epdSeSASNfQMaKBKO2uVBgqY4w3ZheyZEEy9ck93GsPveUU/7PVkUsm
 n8HA==
X-Gm-Message-State: AOJu0YzYYmQ6L6qiNCD4/FKbEzO8Rs51dxuFBPdI7m97G5U//XzIPUUQ
 K1c6ukzUCEByZ/AG6Z933Iv5eBdOIU7cCedZtNN6mMNK4gyHsE7MlE7wqrHHeg6jo7dkf9Xx2PY
 IwSc=
X-Gm-Gg: ASbGncumuM8Dv0kLA3YbanSTTrKXjI4Jsue0vT/3x9Dklp7FBQi3Gk9EYnU+bM3yIi6
 myqi3Z/V4HBvVU3gp73Oh1srETaYoLD+uj+2Ss2TG9zCJGknjivG79nLKsmUXwTfr2I2RcBnqgg
 RH9xNjizklCTYHYV9vPZrcWXK3zBsfJfNvPwzEFpv7BPsnmwjs8Jd2/xlFtbQvlTnHPndO0xD5z
 82+fY2GkiCF+TAy2VPZFhYsFYwUiikDxsY73t7j96gKlETp7qf1TeGD1QeplhHlqSwgAXaRNEZC
 5BZaFYBkNBpUvU22mn+JSKywbxurZ9LWVt+9L+1690jPmkBRtNP7to0PN7D9QGkhjA==
X-Google-Smtp-Source: AGHT+IFyDy+RMBEpTTStJH+i0NYoLasO08MPlQLnRqLRNU6PKPwJhJWBkMvplmAlz/1P8as+vVIHJQ==
X-Received: by 2002:aa7:88c5:0:b0:732:1d12:ded4 with SMTP id
 d2e1a72fcca58-7329de6ecc9mr11147509b3a.7.1740043786895; 
 Thu, 20 Feb 2025 01:29:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73264729945sm10067857b3a.179.2025.02.20.01.29.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 01:29:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-arm@nongnu.org,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 2/9] hw/char/pl011: Simplify a bit pl011_can_receive()
Date: Thu, 20 Feb 2025 10:28:55 +0100
Message-ID: <20250220092903.3726-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220092903.3726-1-philmd@linaro.org>
References: <20250220092903.3726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x632.google.com
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

Introduce 'fifo_depth' and 'fifo_available' local variables
to better express the 'r' variable use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
---
 hw/char/pl011.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 12a2d4bc7bd..5bb83c54216 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -486,7 +486,9 @@ static void pl011_write(void *opaque, hwaddr offset,
 static int pl011_can_receive(void *opaque)
 {
     PL011State *s = (PL011State *)opaque;
-    int r;
+    unsigned fifo_depth = pl011_get_fifo_depth(s);
+    unsigned fifo_available = fifo_depth - s->read_count;
+    int r = fifo_available ? 1 : 0;
 
     if (!(s->cr & CR_UARTEN)) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -496,7 +498,6 @@ static int pl011_can_receive(void *opaque)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "PL011 receiving data on disabled RX UART\n");
     }
-    r = s->read_count < pl011_get_fifo_depth(s);
     trace_pl011_can_receive(s->lcr, s->read_count, r);
     return r;
 }
-- 
2.47.1


