Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12B6CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkFx-0003Pv-3B; Tue, 12 May 2026 06:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wMkFw-0003Ph-40
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:22:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wMkFu-0001jo-8E
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:22:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso34733405e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1778581343; x=1779186143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lwgb940ndz39SBYXWIjFts9Psr23hwEux4dJ55VWeIM=;
 b=f/veQ0m7yICT1VnN5U+MWTqtSy0ZYG/rj/Fi9ZeOA3YWPPR9NDy4vbR5HbWsvJlZAZ
 W4hn2SxFmKjZgu5PQaUpZYD7nrJFiRWKPQE6UXWkghCxfVbBicsbdJ6fkXs4pjlysx2h
 ts7pCqJNy2RDV6csg2+l/RP9kgq57yMEpFyvvlgx+p8BJVNDdl2R+YtLp0NhSHAqS+ly
 S+BYiYIyNhbySjKy6zRVwo/u4hkhNnmSe7jTiVYsmLa2LKxbEPr0yINKF5aCl49EZ0cq
 vDbVZnUAJFhlcDbfmmt/zJD3k1BKG5SdCiXQRFiwxc0KhfuEBcSsAFy6z9HQJztUlJ19
 NKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778581343; x=1779186143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwgb940ndz39SBYXWIjFts9Psr23hwEux4dJ55VWeIM=;
 b=AB7iDmT82RQoLfCcs3vVzomVqyYJ0j8HF3c7Z8kguRimR3V+uxY7W+wWCbog/++6fK
 4wKAPe+dadhndhR9mSK6kHhvBOgDZU7XPed7Hr3Z9wI5++7tDeXnAd6LfbySjq07Pueo
 TqmUxs4vYHM2AyTvAmZM7DuVdbVWSyjDEZekvqEZ39FJGDIGbCCUt0XTL6g8w0RfIOgR
 KchMvn0svazUWKi1kaylDw0x2+bPNqrxUESpPTAxRexc/SxCYUTzCEjXNoNSseWToT/p
 cGhU6lW1WN8Tmn+ZMIxKXwh1Ne8ywJ7lw7y0GTVMrYH7OBsXV2uB3SDjB0RA9J8QkljJ
 30lw==
X-Gm-Message-State: AOJu0Ywj8jjbmNhtTdHRX71Lm3cJhP5riyHRIJNmNDiVg8tuzKjtd3Jy
 lJIIJaXVA6fekhJ/fXGz7KgUV0wvzLpRgT7mXPabr663AFAGmxIevTVej8y3e4Bnn/fBZT8/5Oi
 03JHfuEo=
X-Gm-Gg: Acq92OGcHcJ77hPus9XkMZnEdPsGtLKT3gLZlctk0ITYVeAOm3kmOfwHf4SWgRFNqcX
 GbJ7/hQ4TivK5tLEof+vu+Wvm8fZ/JrlPRz9WAOeoGbeVKAeVyUdITjmKQiTjKvYoZ1Z6Na9U5u
 cBY3wXGiaC11J08fgJsBNLUnX9R+AKt3tuhU5sdAweHLG4dGWMubobgiBg+wXLTfUPE77+R3O7q
 VqzjFrvXksBCh/aT3RnAQVrRTcKuAqaPq8kryWymDnXy58TMcMtGXKZSuJPw/vllhHfy8TxfzSU
 KZrWreqgmxApbifo5JCyUPLBP8D4JBLG5F7cTSe523/TUV2tBjT5JBbkfFXlO+hvZlZ6MQwj/4q
 7nGDDuD9PIpUcqfYhMcgSzaaIPBOxxuVKzdAEJSCjr3HTFMtVTSHBDaosMGj9R9MUPmMROtjisR
 1yZPHyPlnaC1gKO+InF8jIy44ripVUbwuEb2yXIFzdVfYwM9d3QvORgR4=
X-Received: by 2002:a05:600c:4e0c:b0:48d:46a:6e5b with SMTP id
 5b1f17b1804b1-48e51e19110mr465107235e9.7.1778581343380; 
 Tue, 12 May 2026 03:22:23 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a68ebsm29991198f8f.1.2026.05.12.03.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 03:22:22 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>
Subject: [PATCH v3 0/5] initial support for yosemite v4
Date: Tue, 12 May 2026 12:20:35 +0200
Message-ID: <20260512102157.176511-1-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add initial and incomplete support for yosemite v4 BMC-side emulation.

As part of this effort 3 new sensor ICs are added.

Alexander Hansen (5):
  ast2600: yosemite4 initial support
  ast2600: yosemite4 functional test
  hw/sensor: MAX31790 support
  hw/sensor: support MAX11615
  hw/sensor: support Texas Instruments ADC128D818

 MAINTAINERS                              |   3 +
 hw/arm/Kconfig                           |   3 +
 hw/arm/aspeed_ast2600_fby4.c             | 281 +++++++++++++
 hw/arm/meson.build                       |   1 +
 hw/sensor/Kconfig                        |  12 +
 hw/sensor/adc128d818.c                   | 414 +++++++++++++++++++
 hw/sensor/max11615.c                     | 202 +++++++++
 hw/sensor/max31790.c                     | 499 +++++++++++++++++++++++
 hw/sensor/meson.build                    |   3 +
 hw/sensor/trace-events                   |  24 ++
 include/hw/sensor/adc128d818.h           |  20 +
 include/hw/sensor/max11615.h             |  20 +
 include/hw/sensor/max31790.h             |   7 +
 tests/functional/arm/meson.build         |   2 +
 tests/functional/arm/test_aspeed_fby4.py |  80 ++++
 15 files changed, 1571 insertions(+)
 create mode 100644 hw/arm/aspeed_ast2600_fby4.c
 create mode 100644 hw/sensor/adc128d818.c
 create mode 100644 hw/sensor/max11615.c
 create mode 100644 hw/sensor/max31790.c
 create mode 100644 include/hw/sensor/adc128d818.h
 create mode 100644 include/hw/sensor/max11615.h
 create mode 100644 include/hw/sensor/max31790.h
 create mode 100755 tests/functional/arm/test_aspeed_fby4.py

-- 
2.54.0


