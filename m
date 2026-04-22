Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8325F94CDF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSZO-0005Aj-Sp; Wed, 22 Apr 2026 04:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZD-0005AB-Dr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZB-00013d-SI
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891f625344so33619005e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845051; x=1777449851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ML8T4VS3mDxO1fHOZRiPVMSAXhjsw4fX0Ve05LNp2/c=;
 b=RYsOGdZBXUNxma7jO9YoumRYYXLFHyDnn/ZDllHOafmKq+1UnjgtJDd/O/KgqKLqRF
 G8QO40xt+DKvuNtInWabky4INjUzKe0EMArtWOJPsrA2pSAl2ObENlgFY069HCe3atQW
 a7c9TtOyIHzXM8J/fFxQJb8LpfeT047TPECRS0TJMHutB42FiWfGWsClT0yxAYEEaFpZ
 nCnFtltfbCQtzxkRIKzkJKvMTkozngHXeYwsC53i5OTXG7V8Zvkf02mr2QsRlt5ZP/AZ
 t2zEi5KmUFjN3mszNGRDIkyJriPXAjjS/Oc6jVW609cHdJMc5gCZIPMpg1qvFFDbM0hk
 HwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845051; x=1777449851;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ML8T4VS3mDxO1fHOZRiPVMSAXhjsw4fX0Ve05LNp2/c=;
 b=aGneNZGBg2NT/n5gEAvs4HNCKYx4lnaj1+/l8iuB9/z4Iq4k+XpMX0iOt0ExB6JAqH
 q8Z0Vlt6ZqjEz7S/YBcMcWYV902wDZ6vf04nDLjNKjItqptHjbZGQS0lwJqRrGSzK6a9
 l7uT9BHsCBSX4dy6V7b40JeVA8aly5AvfkHi7dRXK7EvbGmGmOEEsV0D4NgPwuetdo/A
 xSO522gLRYdpACRS1vRLgnDnTjAzpqq3OasYzpkVJYYcZqBSs7dWZPa3OdrRAJ1FBwmZ
 W/y2/9qUl3u7EqPSK4X/q3QAtPePjd4Qtc75dEHqzu4v1xBgcIxqMnXe6yeMfzo47wSJ
 ODow==
X-Gm-Message-State: AOJu0Ywz7XWivijCD0i4TOKH0xG8AZalCuVVHUcy3ffNa4K11XaktY6t
 boMjvYqKxVs3sMP+SfQTeNXmqVnYMRL3XZclXa9bHtlCFb4fOG2xXnrX4u+AwpO776BhRkbP/fw
 leGFhYhg=
X-Gm-Gg: AeBDievTYpI+lIK9iSl/7QyPQeVLxuBHllDvwjHBB7pT7hT5HAYVk3rpM3CSiqQNGUe
 FxbVS+3HCxYxU2RFZq4F19eMLY8hth4okC+b/g9OsvcHyacraNK0OiBxpXS0OrMU78GEyEfZd1/
 pgN/ZMqNINGwQ/0uJorT6exKYwNBZ7g0ZdBDpE2S/gUmV0TWeAkl0jjPAnQJi117FlduU9DeVv+
 bZpvdYthB5ajYc0boNr7oclHYvqvFgqc9i9g5oh6bQbXp5MgkCGFAZCAeQf8Tj9f0psYdbOhTmD
 nc+t/PTicoZcDKuOlo5qp2Y4xWVpcG8NVgt7S/r9wc4IQbGIUWV90BaTIMwh3yzyY44na+dIBCQ
 dJ4SEDfQ4CkrqnIgX/IeSsiyjde2pQbg7a6HaojKSM2BRAzAf2XxSiuWh9ijjwqkodvH1ewCbcQ
 wsIkn9hd24u6uBWSNDr2I4L0chn+g+5OB+3v9Wo4v8VE6tnBF7s6G2xTW9s9ypxnUwiO5nrgT8u
 xuFp7KyF+8=
X-Received: by 2002:a05:600c:1d05:b0:489:1baf:8c03 with SMTP id
 5b1f17b1804b1-4891baf8d2cmr161167635e9.11.1776845050566; 
 Wed, 22 Apr 2026 01:04:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891941e05bsm80429465e9.36.2026.04.22.01.04.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 01:04:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/10] MAINTAINERS: Update PhilMD entries
Date: Wed, 22 Apr 2026 10:03:55 +0200
Message-ID: <20260422080406.62638-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

v2:
- Addressed Markus & Daniel comments w.r.t. FW sections
- Drop T: tags
- Remove dead emails

Based-on: <20260416091654.316158-1-peter.maydell@linaro.org>

Philippe Mathieu-Daudé (10):
  MAINTAINERS: Remove my unused git tree locations
  MAINTAINERS: Remove my disfunctional emails
  MAINTAINERS: Maintain MIPS Boston
  MAINTAINERS: Step up to maintain core machine code
  MAINTAINERS: Merge PCIe DOE section within SPDM
  MAINTAINERS: Cover hexloader tests under the Generic Loader section
  MAINTAINERS: Remove PhilMD from NVMe Block Driver
  MAINTAINERS: Transfer FW schema specs section to Daniel
  MAINTAINERS: Remove PhilMD from firmware sections
  MAINTAINERS: Transfer CI maintenance to Pierrick

 MAINTAINERS                                 | 40 ++++++++-------------
 hw/sd/sdmmc-internal.h                      |  2 +-
 include/crypto/tls-cipher-suites.h          |  2 +-
 include/hw/i2c/arm_sbcon_i2c.h              |  2 +-
 include/hw/misc/bcm2835_thermal.h           |  2 +-
 include/hw/misc/led.h                       |  2 +-
 include/hw/timer/bcm2835_systmr.h           |  2 +-
 include/qemu/units.h                        |  2 +-
 crypto/tls-cipher-suites.c                  |  2 +-
 hw/i386/fw_cfg.c                            |  2 +-
 hw/i386/pc_sysfw_ovmf-stubs.c               |  2 +-
 hw/misc/bcm2835_thermal.c                   |  2 +-
 hw/misc/led.c                               |  2 +-
 hw/ppc/fw_cfg.c                             |  2 +-
 hw/sd/sd.c                                  |  2 +-
 hw/timer/bcm2835_systmr.c                   |  2 +-
 hw/usb/bus-stub.c                           |  2 +-
 stubs/fw_cfg.c                              |  2 +-
 stubs/hotplug-stubs.c                       |  2 +-
 stubs/qdev.c                                |  2 +-
 tests/qtest/fuzz-sb16-test.c                |  2 +-
 tests/qtest/fuzz-sdcard-test.c              |  2 +-
 tests/qtest/sdhci-test.c                    |  2 +-
 tests/functional/aarch64/test_raspi3.py     |  2 +-
 tests/functional/arm/test_bflt.py           |  2 +-
 tests/functional/arm/test_raspi2.py         |  2 +-
 tests/functional/m68k/test_nextcube.py      |  2 +-
 tests/functional/mips/test_malta.py         |  2 +-
 tests/functional/mips64el/test_fuloong2e.py |  2 +-
 tests/functional/mips64el/test_malta.py     |  2 +-
 tests/functional/mipsel/test_malta.py       |  2 +-
 tests/functional/ppc/test_40p.py            |  2 +-
 tests/functional/qemu_test/tesseract.py     |  2 +-
 33 files changed, 47 insertions(+), 57 deletions(-)

-- 
2.53.0


