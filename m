Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9F0D5D687
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t98av-0001TX-Ds; Thu, 07 Nov 2024 14:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ERstZwYKCjwrgrsqpemmejc.amkocks-bctcjlmlels.mpe@flex--titusr.bounces.google.com>)
 id 1t98at-0001Qt-5h
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:03 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ERstZwYKCjwrgrsqpemmejc.amkocks-bctcjlmlels.mpe@flex--titusr.bounces.google.com>)
 id 1t98aq-0003K0-A2
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:01 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e30ceaa5feeso2484651276.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 11:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731009297; x=1731614097; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Jzv6DPkMq+AatJ9bE5NP8pF1sQdsh9cAVnptctptWRA=;
 b=h1QWR4dmkZbMAaofqSXG9Y/s3OBcZ10KT4BSI62Vtoihrws1tiNiGfmui22DtlBq54
 eWeISE2e8HQgPh/sB7UzpeaalnCuOtxSQkorabzb6a4hbnBAjNeLR6ejwU6r4Q1rO9L5
 LpnUyDh6HlbCpGMEWKpdvJ+8cQNh2xE9XvUHEwo/sjwLYELg4/H73kYOtuCJJGUGw9xj
 ZG//Mo4sw22ravpGTZk1M1WlYTYVAat5VOqNp+agprDsYCPUMhFFZ9PfZJS0M9tp7ES3
 mAXwPok+WmuyHkl4lAqxRE67Hm8NsZrVkN4179bm389ElCjGGxwe5tRxA4SQZaw66+46
 4z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731009297; x=1731614097;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jzv6DPkMq+AatJ9bE5NP8pF1sQdsh9cAVnptctptWRA=;
 b=aYjrwCm2ZRhGiCGpCO4gTQVbn2aXiIZIfJhFP7M/XWiif1FrhFW5ddvpKGYZwgAdmw
 iKSUNKpsUiMZdOCdR/avQdM5hBUmqRHfUaV45kmYYw/wFdmWEgO9vvD0hkcJHfdzXJEB
 I/IsWO4YCFSG/waN2KnwahOzbCLIpfHjG1b2w/w7OD6ldAFCYMd9YTsO/e5p2A3paXu+
 SZ8oxTK9x4Rc0ANqsPP9zfypRQjpv6qJwc5a+qPEDYyIrPeVjU4zshxDBpk+Vkhr/89x
 seqMnIqe/AtLzAY7D6STn86SykH3oj1KXNKu1vkJuJGEs/hspIw1xRKNKplw6B+kRO0N
 +4PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkjLiA6ZTpv9etcH6ntaXYzSTvY3hgI9uW0Yuig8LPh/bAJS+P8X0ILCzt4dahgExia6cojt/hUHkJ@nongnu.org
X-Gm-Message-State: AOJu0YwiPYzVjTJsrw/Uce3mOagGfSnNk1MhOpUAwPbK3DAOtN+cbC5J
 eIs/9oO8dgXpmkrC9D0BG33p41VSXJzAtAsUZgjdk8LBFIS9NveXKccx9MQLuO/cNmEUedDiCX1
 TCQ==
X-Google-Smtp-Source: AGHT+IGiyA+yueDTMpEZ1QZ1cl7ZuslQI8OOpAYHv7YNk2TU8FvE5FXXjRKoEjfYhIf8p3t3LOTc6G/UDRY=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:e14])
 (user=titusr job=sendgmr) by 2002:a25:2d10:0:b0:e33:4850:b1bd with
 SMTP id
 3f1490d57ef6-e337f843c12mr621276.1.1731009297594; Thu, 07 Nov 2024 11:54:57
 -0800 (PST)
Date: Thu,  7 Nov 2024 19:54:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107195453.2684138-1-titusr@google.com>
Subject: [PATCH 0/6] Add Quanta GSZ BMC machine and PCA I2C GPIO expanders
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org, minyard@acm.org, clg@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 venture@google.com, wuhaotsh@google.com, milesg@linux.vnet.ibm.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3ERstZwYKCjwrgrsqpemmejc.amkocks-bctcjlmlels.mpe@flex--titusr.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This patch series bundles the GPIO sensors previously sent for review:
https://lore.kernel.org/all/20230206194936.168843-1-titusr@google.com

and the GSZ board commit sent here:
https://lore.kernel.org/all/20241007171700.1594342-1-titusr@google.com/

The Quanta GSZ a current Google machine of the day. This machine will be used as a platform to enable features such as the PECI bmc interface, and Intel eSPI virtual wire interface in QEMU.

This patch series also contains a set of i2c GPIO expanders, with support for 4, 8, and 16 GPIO connections.

The devices are configured as GPIO inputs by default, but can have pins configured to be inputs with qmp commands.

These sensors and machine are maintained and used in CI daily within Google.

Titus Rwantare (6):
  bitops.h: add deposit16 function
  hw/gpio: add PCA953x i2c GPIO expanders
  hw/gpio: add PCA9536 i2c gpio expander
  hw/i2c: add canonical path to i2c event traces
  hw/arm: imply I2C_DEVICES on NPCM7xx
  hw/arm: add Quanta GSZ bmc machine

 hw/arm/Kconfig                  |   1 +
 hw/arm/npcm7xx_boards.c         | 160 +++++++++++++
 hw/gpio/Kconfig                 |   5 +
 hw/gpio/meson.build             |   1 +
 hw/gpio/pca_i2c_gpio.c          | 409 ++++++++++++++++++++++++++++++++
 hw/gpio/trace-events            |   5 +
 hw/i2c/core.c                   |   8 +-
 hw/i2c/trace-events             |   2 +-
 include/hw/gpio/pca_i2c_gpio.h  |  70 ++++++
 include/qemu/bitops.h           |  26 ++
 tests/qtest/meson.build         |   1 +
 tests/qtest/pca_i2c_gpio-test.c | 188 +++++++++++++++
 12 files changed, 872 insertions(+), 4 deletions(-)
 create mode 100644 hw/gpio/pca_i2c_gpio.c
 create mode 100644 include/hw/gpio/pca_i2c_gpio.h
 create mode 100644 tests/qtest/pca_i2c_gpio-test.c

-- 
2.47.0.277.g8800431eea-goog


