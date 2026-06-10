Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B83CD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHxe-0006rQ-KT; Wed, 10 Jun 2026 08:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wXHxd-0006rI-EK
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:23:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wXHxb-0005r5-KP
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:23:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso3594041f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 05:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1781094185; x=1781698985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cjBwYepmjSvQ6jukhT3XfMOwNq9BqshO0Vaowzj8bx4=;
 b=hfiVRCNaMW2jHH2GOPT9YWZwuutyO1dr6Mami/FqxmymClja6xRwxeIqcaOMxTKhRH
 XpHLlvZhD0HxmBYXn3Q1y18qKnexubOFVJ/5JdHIRJeXxcze6SHDhv4daQjoaSkTPWcV
 7pnksVV/hkrwGF0nHlGgOWTt0YsgpEl5sCl/Tkl4Cuwd1r1hOFvnNjRqmp8Jg3RhpeNw
 t3CYK9BsRQmLVQngONIM2u/z+R8KSb21zUJa1jcG9Lb57tKuzULoC4qBv84e2sb2UyxZ
 hUX3xSdQqjtqMbTB8IUxMIjBjleqypFp8tY+MJxJ5fA5zRIg4yXeUd9dzxzR4qZUnTAL
 KmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781094185; x=1781698985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjBwYepmjSvQ6jukhT3XfMOwNq9BqshO0Vaowzj8bx4=;
 b=V5AmHlt10fEPL809Ittz8JNsv/JMlmNlikSTUEsfdKHiuSv7UqUMq1OZeeB/PBHtPY
 xr/i+ST8A62O+cyF6/MhlT/BTHBkzhSUu3VPJFCdB8Nwsr7cvw8SxCqUvD/ZUzdEprXI
 sND+glu0UBQ2JFy2kE2Xtx36UtnAqityP5gMvPqtyu4021K/apoS6HUqSKBcD86MNfCf
 VbkAb/clRpZ0xfo3rOnQnEvyaH30utD85KF309daSPz5NO7A8fJXhzDUNYCZdC7MzuE/
 jQMaQom68vp7fMfOLZQsmikwnT27rzZ2Fm2kvlIQ84Chprps+3GhSiavBaoEJEv505rq
 xpvQ==
X-Gm-Message-State: AOJu0YwCm4L3YyQRTVTMJPQgh1aPwqyYr++UzrP02u6m6z2F35uaKsO2
 dl7HPpPfYi6q9hhcDULGI2nXdTLbLF/+mqfz857sYcR1L9E+CrPPtoEfHGKqoIgFRlJmj3zknIV
 oIZydkNQ=
X-Gm-Gg: Acq92OFGSJhuoAx1JKyp7KiKiHS5Ib5AL/SaNUBUGwxUQtEoHd9MaZNSzaAel91V2m2
 dejkGp1Atxl6uEz/e/Z2+gclShCtfQkSp8TdepvIm5sNR6cv//LJBQbgnd+wC9uw9C507jenGas
 3pfZsZGWE6PFH3ux+lNjROsFB6CLQ1rlWe/q/zrWIi4vmqv8RfMf2Y9nNHY6CzbBBiAasFPS9Xo
 jYTQXh+zV9Tz5ZZMYSUdH469TsNq7sCxGv9vovQVE08JdgNfK1DVCTQRgF65qu+QKnWOJW9WXRe
 gtoecS+bKu9HL73e8M4OXrH1BkddqMycJcS353e4pxeDo2JSark6Vp6byeeFbZk0YaZ/c2l9JnE
 Qzj4un1dcVDn64Zk7aNpi9bn4nAAGQtw8ofUtogJmPZmB1l3XJ8OmCkIIUeJ08Wv6qXa2tC2zNr
 iD03vpGJq3C+y+bZKRMnMCmT1LP31Jmq6WLqlpyi0hsEcgroK3Qbk/pr22lFjKjUwo4A==
X-Received: by 2002:a05:6000:c01:b0:45e:ed10:8dff with SMTP id
 ffacd0b85a97d-4603050f573mr29196031f8f.24.1781094185386; 
 Wed, 10 Jun 2026 05:23:05 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm70995963f8f.0.2026.06.10.05.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 05:23:04 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v6 0/5] initial support for yosemite4
Date: Wed, 10 Jun 2026 14:20:57 +0200
Message-ID: <20260610122252.349321-1-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x435.google.com
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


Thanks to Cedric for reviewing

Summary of changes from v5:

machine:
- add documentation to docs/system/arm/aspeed.rst
- inline fby4_i2c_init_multiple_blade_chassis

machine functional test:
- no changes

max31790:
- max31790_set_rpm: clamp to maximum value instead of overflowing
  when writing the uint16_t value

- max31790_reset: fix out of bounds write through max31790_pwm_write.
  The loop was going over MAX31790_NUM_TACHS when it should be
  MAX31790_NUM_FANS

 > How does the 0x4444 value relates to the one used in the tests ?

There is something in the image which is writing the pwm, if you look at the traces
it should be more obvious in the latest patchset

max31790_pwm_write i2c_addr: 0x2f, index: 5, value: 0xb200
max31790_rpm_write i2c_addr: 0x2f, index: 5, value: 0x1c34
max31790_tach_count_reg i2c_addr: 0x2f, index: 5, value: 0x0440
max31790_send i2c_addr: 0x2f, data: 0x80
max31790_pwm_write i2c_addr: 0x2f, index: 5, value: 0xb280
max31790_rpm_write i2c_addr: 0x2f, index: 5, value: 0x1c48
max31790_tach_count_reg i2c_addr: 0x2f, index: 5, value: 0x0420

Looking then at the latest fan dynamics read from the driver

max31790_fan_dynamics_read i2c_addr: 0x20, channel: 0, value: 0x0000
max31790_recv_return i2c_addr: 0x20, reg_addr: 0x08, returns: 0x00

and plugging that into the equation

 >>> (60 * 1 * 8192) / (0x0420 >> 4)
7447.272727272727

we get the value found in the test.

However the fan dynamics did not match the POR value so i noticed the reset function needs to be called from realize function to set the initial values.

Then the values read by the driver are as expected.
Also added some example calculation to the functional test to showcase
how the rpm read by the driver is created from the initial pwm write.

- fix redundant import and extra newline in functional test

- consolidate 2 trace logs in recv function and add more useful traces

max11615:

- remove "qemu/osdep.h" include from include/hw/sensor/max11615.h as requested
- fix missing '\n' in log message
- call reset function on realize to set initial POR register values.
  Wrong reset flow caused the configured value to be overwritten before.
- review test values and linux driver, adjust the test to the correct value

adc128d818:

- no changes for now, focusing on getting the machine
  and the first 2 sensors done.

Alexander Hansen (5):
  ast2600: yosemite4 initial support
  ast2600: yosemite4 functional test
  hw/sensor: MAX31790 support
  hw/sensor: support MAX11615
  hw/sensor: support Texas Instruments ADC128D818

 MAINTAINERS                              |   3 +
 docs/system/arm/aspeed.rst               |   3 +-
 include/hw/sensor/adc128d818.h           |  23 +
 include/hw/sensor/max11615.h             |  19 +
 hw/arm/aspeed_ast2600_fby4.c             | 273 +++++++++++
 hw/sensor/adc128d818.c                   | 433 ++++++++++++++++++
 hw/sensor/max11615.c                     | 322 +++++++++++++
 hw/sensor/max31790.c                     | 556 +++++++++++++++++++++++
 hw/arm/Kconfig                           |   3 +
 hw/arm/meson.build                       |   1 +
 hw/sensor/Kconfig                        |  12 +
 hw/sensor/meson.build                    |   3 +
 hw/sensor/trace-events                   |  30 ++
 tests/functional/arm/meson.build         |   2 +
 tests/functional/arm/test_aspeed_fby4.py | 110 +++++
 15 files changed, 1792 insertions(+), 1 deletion(-)
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


