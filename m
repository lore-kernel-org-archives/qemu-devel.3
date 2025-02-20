Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CF0C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2tz-00039u-W6; Thu, 20 Feb 2025 04:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2tw-0002wf-71
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:31:25 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2tu-0003wp-5b
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:31:23 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso18463255ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043880; x=1740648680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HC4oun0jFc0+NwBeUFjNGte1nRrGw6nA41LdkLLgvBM=;
 b=t7/b7faVAV5xQOKoKuhorNuNO0UdlONDAgByVN7RU+Jugx+eogG3wF2usQsbD3rvix
 hBm12CVVIOs+GWEXPieDiShpPWEOQwYNigXbjvbDRnzhzpox7p3J4tf/alOFk00kpGDr
 9jjSMC5hpwhj4EmbQMp1v177DOG5NhYN4cTt5giCnO7uWUTu/6M98vtxN46O2RbKUvup
 SvjFEXHtUX22dZOPzTilypCsSWzCSFZulQYYyPaLMgkZOLLKm6hxK72fViB8w+pPdNjj
 V8f6rZxyuOhYUmfsB4+9aQEta2iY0YM5ps8BsD+/pXmeWn87o7Q7Yq9QSWl4CBwMDliL
 TqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043880; x=1740648680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HC4oun0jFc0+NwBeUFjNGte1nRrGw6nA41LdkLLgvBM=;
 b=YR1UXL0bjnJBXKzWmliR7+51jqm15thpxuSDAv+sR1wahSw24Jr5qz4Bcr0h6NL+Mj
 FTYX8E3XhSq9XXG0jibz3DesMl5C66hQQOSChmz73o5KdnkCJ5BSsiaduQHEqFA72EXl
 cFG+pNrXhmktzWrwm1il1b9L6qvX5hlQcsHxf4DidbGpiVT/uhg5uhk2ggYpgmsoAbWu
 wgJ9Vcs6AkgasflpKjbZakjqiaQGxZ4lLXxQS5fMjCL4zEE5qP4yyS9WRZtcZZSMbFa2
 NJSgfjpqgJ3ssTe9s2l8AR/9vFLhdOUNGctTRfojVvZbS/wPJqf+QlFzaaZxQ8TAALRY
 LSFg==
X-Gm-Message-State: AOJu0YzOORfiPESAMZ9FoG5tpPBof9apO4ucuXBBpQq52/5ECjqMVxxp
 BCwyk+sgx/FKphyVjCBzeb2zY9X5q6/U6KqTgg3JuLO23acWcWd6ElFg0as6hiHxJ9wK6h6Lhzo
 YsAU=
X-Gm-Gg: ASbGncubOXODuVo0zToq12J6yRa0yyjwOttWmAO6HAsB8lszZorq2H1oliP27zFQlx0
 V8YO+9sVM5WqyuTzNxIQF5J/P3oK0Nx0yRpJgiFJfPvd6Q3E/W5A5TY1w/7g8zrV1bla2MP1jd7
 VFFcX6cu7MBm0/Rm/awVms9VK2HTV2/ariJRR/cImZ+lMLK5wl4zOkzn9e2Wzn0K19mMkmLfSxo
 ldLhD+0og9W6SVT8XwMHymKzMuYNlW4AwLgDK30wkJGaV0RVOrrVYaFdoDjgfkJXVnxW2ds8jUf
 fO2ro1xzqqaSWakhFLWFm61Hcqt6jyil5qhJtP4LPFJhW3AxuG+4+hDjWm8MLAQQew==
X-Google-Smtp-Source: AGHT+IFx+v4FclNABrQD9b4vP9z6wIrsuZioITVmY4/cv4uYCbV2ZK6EAFTucgkbxtN26HJ9CIIBTg==
X-Received: by 2002:a05:6a00:198c:b0:730:8e97:bd74 with SMTP id
 d2e1a72fcca58-732617756d7mr35402017b3a.2.1740043880114; 
 Thu, 20 Feb 2025 01:31:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5ea71sm12264684a12.8.2025.02.20.01.31.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 01:31:19 -0800 (PST)
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
Subject: [PATCH v2 8/9] hw/char/mcf_uart: Really use RX FIFO depth
Date: Thu, 20 Feb 2025 10:29:01 +0100
Message-ID: <20250220092903.3726-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220092903.3726-1-philmd@linaro.org>
References: <20250220092903.3726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x630.google.com
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

While we model a 4-elements RX FIFO since the MCF UART model
was introduced in commit 20dcee94833 ("MCF5208 emulation"),
we only read 1 char at a time!

Have the IOCanReadHandler handler return how many elements are
available, and use that in the IOReadHandler handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
---
 hw/char/mcf_uart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 95f269ee9b7..529c26be93a 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -281,14 +281,16 @@ static int mcf_uart_can_receive(void *opaque)
 {
     mcf_uart_state *s = (mcf_uart_state *)opaque;
 
-    return s->rx_enabled && (s->sr & MCF_UART_FFULL) == 0;
+    return s->rx_enabled ? FIFO_DEPTH - s->fifo_len : 0;
 }
 
 static void mcf_uart_receive(void *opaque, const uint8_t *buf, int size)
 {
     mcf_uart_state *s = (mcf_uart_state *)opaque;
 
-    mcf_uart_push_byte(s, buf[0]);
+    for (int i = 0; i < size; i++) {
+        mcf_uart_push_byte(s, buf[i]);
+    }
 }
 
 static const MemoryRegionOps mcf_uart_ops = {
-- 
2.47.1


