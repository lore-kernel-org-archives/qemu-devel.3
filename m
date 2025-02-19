Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEBEC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrJL-0001lg-MT; Wed, 19 Feb 2025 16:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJJ-0001l0-IS
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:08:49 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJF-0008U4-To
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:08:48 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso1172385e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739999324; x=1740604124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jwfRzD6O0YD7j2pvGbQ4kMoFWL7J1bU250ClTlckFJs=;
 b=auIL0L6EMoge4FRVEoJwJtaW419HAAV4xXsocHwfUz4vRl41We3XWvkKrQPBL4DSPi
 5ydS6wtoMELji4s9aYeiAFvNsnO1AK7kGCZUprS1Y9wUj3Whwg3jRNhB1Qx5jjhL9QUh
 zf7dRhbPPLwRbnBsgZuk8cTmDT2gRNHRV0MdKu4DLAkwCVRE8UJ3xalw0sSt5NDSvjPu
 EPhavCjJ/pDeqmExvC28lIAfuSJkX517aW/kZGBQXu+SmgHcGDGAEm2QEd5DlRHwhYPh
 +0gIQah+FjhfI6oon4jMDtZU97k34k2YLwwwvUMLjBKrKmA23qD8LJzMAGl6U0KyCZZJ
 QinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999324; x=1740604124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jwfRzD6O0YD7j2pvGbQ4kMoFWL7J1bU250ClTlckFJs=;
 b=JT+Gj2yTHQrC0I94emN10xxbgumQQSxpFkJz7OJjfeLyvbnfhCeHyv2f5o1d2bekOY
 9t6rlK/5jM9Cpks9LWOzM+f/jNWt6bz+fgNvDQRWWAP8sJkUTlUcnxVCY+pwLeHiA01Q
 cLQ6uOogSE781bBeBIxuDlwDTXKmeZxh2uHCe81pKDw3bjfuGLoKFLhPNoCKMUg6IALy
 3d1vGcFkk8+/dF1fMSYP5ZiXRBT5K1OPXCGihbb6fMDqzwF8HprXW85pFc0HTXYY8Qwt
 oC/++2iyaTehjaaLkuP2etNy18FVZ5MGEDjaOd0l0k72GXU6Z7jQA1d7WuPIlQyt5qOz
 52eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0P88kulCWvY1UUh7Gy3RkTzBsPb6zqXhoR4gv1wIqt6meY8syox9Wk4PsO4ikyEhnIQBSwBYwMP5H@nongnu.org
X-Gm-Message-State: AOJu0YyOba6BJfu6mrZeMs7vTJdu36Ih7UwE1TXubyEpH0Dsa+MGajFN
 w7s6mJ48IxZpsq1AQ5Kn0idDxZc/2F+11dPzLBdMn9S4yim70zF60lPxPhjjq0g=
X-Gm-Gg: ASbGncsiYjv5RSW5sRGJNa34ItdQk56jZPeMSUCKdwdh835OKa1dr51zKvtqA+S302q
 A3kd9JY9EIyn1Fna7QDriu5Ot2c7jkfufqeoA+VBYp08vzdVwYn1eYMROzCuC1f4P/sw4zVzKBL
 2cz9fDyrxsnbifp3xbdCUegrZJ4H0ee8hT70lgK210ZBxsHNWSvZ7LjpYZYK5itVqVqOsTv5Ceu
 VK5lo40p46qXPsY3exsSGQ7rO4Uw5JFfDi+yde/VaWYsNtHFV+Na+gc1LrtR3EL9OWwqZzBLvP5
 n9PjELWTg+vItZhgd9iPw/7sqW5zTOMTfJzn5+cp4ppY2Bb8GZDFeo88slh/iq9WCA==
X-Google-Smtp-Source: AGHT+IHduT0jWPJt3zNktPcWix1/Gcy05r8JAStrmmJCQqNFsZzmjva+oAwjfboNVKcjEzXFxBoaNw==
X-Received: by 2002:a05:600c:444e:b0:439:9f42:8652 with SMTP id
 5b1f17b1804b1-4399f428858mr26436395e9.17.1739999323712; 
 Wed, 19 Feb 2025 13:08:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439872b59e9sm90926805e9.31.2025.02.19.13.08.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 13:08:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Luc Michel <luc.michel@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH 0/9] hw/char: Improve RX FIFO depth uses
Date: Wed, 19 Feb 2025 22:08:32 +0100
Message-ID: <20250219210841.94797-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Some UART devices implement a RX FIFO but their code
(via IOCanReadHandler) only return a size of 1 element,
while we can receive more chars.

This series takes advantage of the full depth.

Inspired by pm215 chat comment on yesterday's community
meeting on the PL011 Rust implementation description by
Paolo :)

Philippe Mathieu-Daudé (9):
  hw/char/pl011: Warn when using disabled receiver
  hw/char/pl011: Simplify a bit pl011_can_receive()
  hw/char/pl011: Improve RX flow tracing events
  hw/char/pl011: Really use RX FIFO depth
  hw/char/bcm2835_aux: Really use RX FIFO depth
  hw/char/imx_serial: Really use RX FIFO depth
  hw/char/mcf_uart: Use FIFO_DEPTH definition instead of magic values
  hw/char/mcf_uart: Really use RX FIFO depth
  hw/char/sh_serial: Return correct number of empty RX FIFO elements

 hw/char/bcm2835_aux.c |  6 ++++--
 hw/char/imx_serial.c  |  8 ++++++--
 hw/char/mcf_uart.c    | 16 +++++++++++-----
 hw/char/pl011.c       | 28 ++++++++++++++++++++--------
 hw/char/sh_serial.c   | 30 ++++++++++++++----------------
 hw/char/trace-events  |  7 ++++---
 6 files changed, 59 insertions(+), 36 deletions(-)

-- 
2.47.1


