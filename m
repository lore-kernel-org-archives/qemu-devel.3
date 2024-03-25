Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7B5C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokRz-0002V4-Fp; Mon, 25 Mar 2024 09:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokRn-0002TK-NM
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokRk-0007Je-8R
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4147e135f4dso18396255e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711373582; x=1711978382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mCxNPNDuz72bEraA+KHzlReHJxE9cKV4qETiCw6TYOw=;
 b=lZrWSbKLVfF7/Ol5Xa1dz4GpM0WyOBcI6UkOz2ff1Noqi4RIV0bWS3Ip3gjn7jTqYN
 IplkwURHGl6hnMuSlmK/tc2OYN112211BIbG3OrkqKr2BLx/VrQTJoHpWBEnPszHCKs3
 2eXLiwLqGsUZ/HRA4y89uvmh59lZ9Pd9GCOW3HJwF0D7evRcCgnLY035++cFQn/GCMYU
 W8BeqyJG7i/ncSxOkYJ0CmbzqD4lG44MTiULGjlGlFeYJt/5PuLb7JzolBMFlPLBz20j
 U0WF/aA8MgUL3Qv5bh+EGtGgShVUaLVy+Wrbk9oTo9uxBPBlalTocUYzYcMgUaiv3s9v
 0wBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711373582; x=1711978382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mCxNPNDuz72bEraA+KHzlReHJxE9cKV4qETiCw6TYOw=;
 b=s9B/KqCqL0deaeWSvbHNoRf4RRTHsJt2PsG970CfUNXkE1TCCRb1jIODILVTtuG07n
 1qxs4vvjUhY+tOBlv7/I6ZtEldWtydj5hZ3DaCaqWPqx7nCf7T7I4J/4qMQv0TBKUfPz
 /HVxFUgPDMtndkA4eE/aCYpgQ7F1807OU47nO0t61lHFeBjcLZCQJj1l65FMm0NZc4sv
 pv7TzQi+2yhiiwcDSVhqQxdnQJWgWr+blPKv+VZVimsTADh9VmcWIB5wLJKluQ2uYR7x
 E5fy0VgEGOPiBIwo+SPh/pFBqiJTFn1ahOLagFeX6JpIgW5fpYB8teEaTea8jhl3LX8I
 HTDQ==
X-Gm-Message-State: AOJu0Yz/Xw7kri0Er/dlkfccgAFR/cT4jVz2CuzgIn6NmUzkq21cn+9k
 g26QQXqwakIp/H8tD5Zn2hMwA2g6SdZm+gE/YpVDyTHaId+uWksn18sYCYh9ea/c153ohCQ2J9M
 J2E8=
X-Google-Smtp-Source: AGHT+IFx7V7fa7hRDnLV+gKhj/ei+ujGUFfzZASSwXej474w6a1DHF0Xk3dQNZEsqkUUX5E1BZyeNg==
X-Received: by 2002:a05:600c:35d2:b0:414:ff4:5957 with SMTP id
 r18-20020a05600c35d200b004140ff45957mr4398058wmq.5.1711373582156; 
 Mon, 25 Mar 2024 06:33:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 ay4-20020a5d6f04000000b0033e48db23bdsm9640652wrb.100.2024.03.25.06.33.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Mar 2024 06:33:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? v2 0/8] hw/clock: Propagate clock changes when
 STM32L4X5 MUX is updated
Date: Mon, 25 Mar 2024 14:32:50 +0100
Message-ID: <20240325133259.57235-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
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

Since v1:
- Rework API to only propagate when both clock_set
  and clock_set_mul_div modified the clock params
  (Peter & Luc).
- Use that in zynq_slcr.

Per https://www.qemu.org/docs/master/devel/clocks.html#clock-multiplier-and-divider-settings:

  Note that clock_set_mul_div() does not automatically call
  clock_propagate(). If you make a runtime change to the
  multiplier or divider you must call clock_propagate() yourself.

Fix what we forgot to do that in recent commit ec7d83acbd
("hw/misc/stm32l4x5_rcc: Add an internal clock multiplexer object")

Arnaud Minier (1):
  hw/misc/stm32l4x5_rcc: Propagate period when enabling a clock

Philippe Mathieu-Daudé (7):
  hw/clock: Have clock_set_mul_div() return early when nothing to change
  hw/clock: Pass optional &bool argument to clock_set()
  hw/clock: Pass optional &bool argument to clock_set_ns()
  hw/clock: Pass optional &bool argument to clock_set_hz()
  hw/clock: Pass optional &bool argument to clock_set_mul_div()
  hw/misc/stm32l4x5_rcc: Inline clock_update() in clock_mux_update()
  hw/misc/zynq_slcr: Only propagate clock changes when necessary

 docs/devel/clocks.rst      |  6 +++++-
 include/hw/clock.h         | 21 +++++++++++---------
 hw/arm/aspeed.c            |  2 +-
 hw/arm/fby35.c             |  2 +-
 hw/arm/mps2-tz.c           |  4 ++--
 hw/arm/mps2.c              |  4 ++--
 hw/arm/mps3r.c             |  2 +-
 hw/arm/msf2-soc.c          |  2 +-
 hw/arm/msf2-som.c          |  2 +-
 hw/arm/musca.c             |  4 ++--
 hw/arm/netduino2.c         |  2 +-
 hw/arm/netduinoplus2.c     |  2 +-
 hw/arm/nrf51_soc.c         |  2 +-
 hw/arm/olimex-stm32-h405.c |  2 +-
 hw/arm/stellaris.c         |  2 +-
 hw/arm/stm32f100_soc.c     |  2 +-
 hw/arm/stm32f205_soc.c     |  2 +-
 hw/arm/stm32f405_soc.c     |  2 +-
 hw/arm/stm32vldiscovery.c  |  2 +-
 hw/arm/xilinx_zynq.c       |  2 +-
 hw/char/cadence_uart.c     |  4 ++--
 hw/core/clock.c            | 19 +++++++++++++++----
 hw/misc/bcm2835_cprman.c   |  2 +-
 hw/misc/stm32l4x5_rcc.c    |  9 +++++++--
 hw/misc/zynq_slcr.c        | 39 +++++++++++++++++++++++++-------------
 25 files changed, 89 insertions(+), 53 deletions(-)

-- 
2.41.0


