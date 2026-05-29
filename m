Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CAECD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwYl-0000wd-TG; Fri, 29 May 2026 08:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wSwYg-0000w4-6I
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:43:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wSwYe-0004dp-3r
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:43:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso8075909f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1780058601; x=1780663401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MGYpyhlsFPpssWFIKk+bTtS3CLvV1LisbhN8DsHyngM=;
 b=C0ErYFrmMXnH6K4yBAKM+atTdpUktotJUb19YoJ9+IX9zblB4Mmt3eTHCdywuhL5sK
 x7GouF4ouDE5R1kOK2af7enYM4YLdtWWTz5igWcjyneJdOqQ1m1ajstaJEw5CEbB0jRi
 sV8IgifsoLq/DLmwMEytWEwjwOnIZtU39WNkYYFHBKOwDgMR9iLTQPpjTYBPZtvCoM6R
 ZDSAZIdchl5J7hT6A87OUFMZbWrBg+cDSBDONzxpb3JTJXB5K9oXSJi1QRYifE3XcKq1
 HQxrMk+qVUuD0/K7Kj4uZHqrAp9J0Cs13edVzPfsq5WTlcoz2HJizhM26/HjSGim6QsF
 tMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780058601; x=1780663401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGYpyhlsFPpssWFIKk+bTtS3CLvV1LisbhN8DsHyngM=;
 b=YiA1YJ7oHYz56bpmdL7uyyenY6ZOrm//YSec1/TDu++SDTni/hVMY/zAQ1f8ckNBdh
 OhxYKqWazkP54k2z+oXjp8uzu/gYI6fdhzSX3cOSqsLUdOsUfFZ10b+ezQo5m6kxHOhH
 3n3wqRi2JL1wk5moAXF4VcLvtKEbKwTm/TFP+OIHnWOdq7SYnMqfoTOHFMhi+6n9WMWt
 HGWr2CKXQ/zgKokadTmYlKMBIzMUrzh1oXWo2R8oTUnzBgtRtuazG6PWKfBTvueC+Zku
 nZ3zm85DKhIDjCHeHsJo5R3Vlz7n21hUZQZR40Kj3gvEOHDuWlKmCCbME03+3z/3rZs0
 4fjA==
X-Gm-Message-State: AOJu0YzVqMNS7PYaqm2AVJnGA1H7P13eR9wNJOw6t1o7vff9DeTcnPv+
 ZVsPCUBuNbMk7UjUaAS5Y71Sz9ge3nB34v9Ua6y34ttNaWBx4X9M2Tkft3wT5ZyjpO9CIKlUGgI
 HBnNhlYE=
X-Gm-Gg: Acq92OGj3LwZl/7gu6NYktLk/o3XMvsYW/1q3+SjgK86DE2E5iGDJly/ivV5oZQKJHA
 SHhr1gX2OMeoYEbmK0F/w3UvKT4cVzqwJWbXq6edPRjAz2x5U9k2oIJciyPD9Z8foS/MOW4TkR6
 jY5EsdU2EMIrZ3bz9cRK/EyTLiFSesYZQncuy6UddDBUd24rJxCyVvILkYFfTHMIvbXvSDPuZzO
 ExNRoRrIflQyf/J+xAy3vYJGDDLkE06L8VLj4LrqtY3197A3mrmlJ0MDuaP4Twap2GDcSVHzQBd
 oAgc0i5GgVybFOTeGla0QEHxM2C0ZVzaHCWW5EhrUExFC+H/jZBtRa2SHqXfFlZPMRZEGOQ79Bf
 fcs9C6uLoesjJiqUIyDapsqEjn/PLqcM7msSxPgtnOZVmVC7TJC8vWes5l2uBUL+f7sxtoNfP0X
 rsPFkWPwVJJbEjlW4FbzrYTpw/8hnIsLCprcHqP0IVFKqmQd/f4IUYCj8=
X-Received: by 2002:a05:6000:461b:b0:43b:962b:5314 with SMTP id
 ffacd0b85a97d-45ef143d5f6mr4615669f8f.19.1780058601568; 
 Fri, 29 May 2026 05:43:21 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef35598e5sm3163354f8f.27.2026.05.29.05.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:43:21 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v5 0/5] initial support for yosemite4
Date: Fri, 29 May 2026 14:37:29 +0200
Message-ID: <20260529124237.94087-1-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x429.google.com
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

Thanks to Titus, Jonathan and Cedric for reviewing

Summary of changes from v4:

machine:
- no changes

functional test:
- add missing import: from qemu_test import wait_for_console_pattern

max31790:
- add trailing newline to log messages
- fix a couple of formatting issues
- log a guest error if max31790_recv detects over-read
- fix Kconfig (depends on I2C) instead of PMBUS
- remove an unused import from functional test
- rename 'rpm' array to 'tach_count' to better reflect its actual purpose
- fix functional test with correct RPM value and additional checks to test for

  pwm1 <= pwm2 => rpm(pwm1) <= rpm(pwm2)

  I must have had some misconception about what's stored in tach_count and how it
  relates to rpm, hope that's cleared up now in the code.

max11615:
- fix comment style in header
- remove #include <stdint.h>
- max11615_write_config_byte: fix comment (MAX11615 is only 8 channels)
- fix possible out of bounds access missed by max11615_write_config_byte
- remove an empty function
- max11615_init_with_values: simplify (directly applied the suggested code snippet)
- max11615_reset: reset channel readings as well.
- init_with_values uses decimals now instead of binary notation
- support differential mode
- support unipolar / bipolar mode
- max11615_write_config_byte: log unimplemented for scan mode != 0b11
- max11615_write_setup_byte: log unimplemented for external reference set
- max11615_recv: support multichannel scans
- functional test is using stable file name (bus + address + wildcard)

adc128d818:
- fix comment style in header
- replace #include <stdint.h> with #include <qemu/osdep.h>
- adc128d818_write_advanced_config: reset channel readings and interrupt status
- adc128d818_send: check s->len before writing into s->buf[s->len]
- adc128d818_init: remove (empty function)
- adc128d818_init_with_values: simplify channel init similar to max11615
- adc128d818_reset: reset channel readings

Alexander Hansen (5):
  ast2600: yosemite4 initial support
  ast2600: yosemite4 functional test
  hw/sensor: MAX31790 support
  hw/sensor: support MAX11615
  hw/sensor: support Texas Instruments ADC128D818

 MAINTAINERS                              |   3 +
 include/hw/sensor/adc128d818.h           |  23 +
 include/hw/sensor/max11615.h             |  20 +
 hw/arm/aspeed_ast2600_fby4.c             | 280 ++++++++++++
 hw/sensor/adc128d818.c                   | 433 ++++++++++++++++++
 hw/sensor/max11615.c                     | 312 +++++++++++++
 hw/sensor/max31790.c                     | 537 +++++++++++++++++++++++
 hw/arm/Kconfig                           |   3 +
 hw/arm/meson.build                       |   1 +
 hw/sensor/Kconfig                        |  12 +
 hw/sensor/meson.build                    |   3 +
 hw/sensor/trace-events                   |  26 ++
 tests/functional/arm/meson.build         |   2 +
 tests/functional/arm/test_aspeed_fby4.py |  89 ++++
 14 files changed, 1744 insertions(+)
 create mode 100644 include/hw/sensor/adc128d818.h
 create mode 100644 include/hw/sensor/max11615.h
 create mode 100644 hw/arm/aspeed_ast2600_fby4.c
 create mode 100644 hw/sensor/adc128d818.c
 create mode 100644 hw/sensor/max11615.c
 create mode 100644 hw/sensor/max31790.c
 create mode 100755 tests/functional/arm/test_aspeed_fby4.py

Cc: Titus Rwantare <titusr@google.com>
Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>

-- 
2.54.0


