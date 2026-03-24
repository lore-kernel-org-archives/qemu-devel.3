Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2466CF54ACD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Pe-0000dO-5N; Tue, 24 Mar 2026 11:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pa-0000bM-8L
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:19 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53PX-0005BZ-Mh
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:17 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso2832316f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365074; x=1774969874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=niru6SwWeTR7yjsRkhP1W/j/ESmXSIGaT4fjq9guthI=;
 b=yKy+PokoWg+7WGnVp5Pg5VVjK6ZvtXR0Osdr01WferzJsd5uHrYP9Jre3jVHJLDKJY
 VXsrzBEkXgd5atC2E340na1WXD9JntEiw6Irto/56AbJwcNfKI3BtzFSRjVwxReaujss
 OYEVw8Ld9XcGdxJHwJQxMmmFHi8xC554LL+78d7FKiU+Plfi+ZRdeVWyst1XLjq5+xdf
 sK0UcKei4viTO5liUHn/svZItnj6DChv1nZPhsaY3D7cNKJGugshjEx3HaZq5u2sIez5
 TK31C0xllZyf7o4Jn9H+02FIUaW8sg4hXbkmgu5wIVTGW0UtqZfr25z1rjpKUFISJtWv
 e6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365074; x=1774969874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=niru6SwWeTR7yjsRkhP1W/j/ESmXSIGaT4fjq9guthI=;
 b=ea0+8EKbmcGUDc/l4Zcbqs02HL9h5FFaI4t6e1Y2YQLj46EXsclxRu3APgfZ0BTjuc
 asyBkLTM+Gv6T34SZrY08yiQ1zuIcmNl891nc6tj8ab5ZHWHcC/PWYI+/7GfFZF+HkbI
 wVV2FWgKAiu6CdcLlQ7kvUGtRipOQlIz/RRCp5RJXUAkPCeNGFApyeTqsDyeJZCyy6Rc
 muvHasa40owQtVyHYVKG2mGoAXoCtD1kIj5BRSwyCm8zI4LqtzDd0mMU/t6F6IPQNK3r
 r+MXt1F7wdW5OVqPRsxNRUTb3qBZCuPDsjWWPqKQv2jNex7rHhJAQgLj6/KWgv9Oljp6
 uwQg==
X-Gm-Message-State: AOJu0YzytmJ68p/5ZEHyoQ5LfcjPIbrqmpeWeR4WS7GjEr/O85nIVy+V
 Si+N+Lrw6aAwILvsSoy3G32AH5oMX5BQIf+nd5s22wDjRH4+iXH6kNXE+tshZbRxA71HNlOXEPn
 2arcg1ak=
X-Gm-Gg: ATEYQzxIa4WXmXe41ImG8ucYYGXvrij3PRi9jskFFE49JcnzywMBWIwkdTHKPnBlPSz
 eGKkuDtGoj65yu3DNTrAfICmDWfxAqoXojsrT+aX7dFYI+IqTNVLrP/V8k1OFXmxyT+lIbY8gPT
 9GyTWMKh5ZS78iqfBy4+zoz5PUqOHLXdKZXsZTYBFLiAtoGDc5GY1ktf4cRJ7YKPWa1vcdgqzY+
 9eFo6xV8iKDqkZZDhL0NynPWL7qBRpdrHXPYD6ri47mgTdN+nS3aI7m9+kR9dgXgoENC/4fw2JG
 KMRgOS6CP5dI/vfJ8fm9vbnF5AvyzAKtmuCMRuYX/SY8eeGQZFtkPqwPF34OK4ZL38MNggLI4TJ
 k1Bahx35A/Hi9zemxc/287/uMROL0xR4vyKnsIpdrZvQEIsj2Ea2chwWiUbMM3LRG+vyAc3rRdF
 fFoOiOghnrrY/wrLgs18tDfTrlisRzc4h5yWYzrh3liiXhwrlCiiSoR9J3ZU8ASymXRW6/4Yfvd
 HU1BRAXFq3qrlZl6bcmilgmMv3DN8815chAmhlTWw==
X-Received: by 2002:a05:6000:601:b0:43b:634d:1a9e with SMTP id
 ffacd0b85a97d-43b64244c2amr26360051f8f.15.1774365073534; 
 Tue, 24 Mar 2026 08:11:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] target-arm queue
Date: Tue, 24 Mar 2026 15:11:00 +0000
Message-ID: <20260324151111.237411-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

The following changes since commit fa4b2e31e649ba6fdb3eb2dd43952aad4a3bd675:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-03-24 10:41:21 +0000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260324

for you to fetch changes up to af35bc0c146ced44f6bfe98587495ae193adcec4:

  qemu-options.hx: Document arm-smmuv3 device's accel properties (2026-03-24 14:02:30 +0000)

----------------------------------------------------------------
target-arm queue:
 * linux-user/i386/signal.c: Correct definition of target_fpstate_32
 * hw/dma/pl080: Fix transfer logic in PL080
 * hw/arm/smmuv3-accel: Switch to OnOffAuto properties
 * qemu-options.hx: Document arm-smmuv3 device's accel properties

----------------------------------------------------------------
Jose Martins (1):
      target/arm: fix s2prot not set for two-stage PMSA translations

Nathan Chen (8):
      hw/arm/smmuv3-accel: Check ATS compatibility between host and guest
      hw/arm/smmuv3-accel: Change "ats" property type to OnOffAuto
      hw/arm/smmuv3-accel: Change "ril" property type to OnOffAuto
      qdev: Add a SsidSizeMode property type
      hw/arm/smmuv3-accel: Change "ssidsize" property type to SsidSizeMode
      qdev: Add an OasMode property type
      hw/arm/smmuv3-accel: Change "oas" property type to OasMode
      qemu-options.hx: Document arm-smmuv3 device's accel properties

Peter Maydell (1):
      linux-user/i386/signal.c: Correct definition of target_fpstate_32

Tao Ding (1):
      hw/dma/pl080: Fix transfer logic in PL080

 hw/arm/smmuv3-accel.c                    | 41 +++++++++++++++++---
 hw/arm/smmuv3.c                          | 64 ++++++++++++++++++++------------
 hw/arm/virt-acpi-build.c                 |  2 +-
 hw/core/qdev-properties-system.c         | 27 ++++++++++++++
 hw/dma/pl080.c                           | 17 ++++++---
 include/hw/arm/smmuv3-common.h           |  3 --
 include/hw/arm/smmuv3.h                  | 11 ++++--
 include/hw/core/qdev-properties-system.h |  6 +++
 linux-user/i386/signal.c                 | 25 ++++++++++++-
 qapi/misc-arm.json                       | 44 ++++++++++++++++++++++
 qapi/pragma.json                         |  1 +
 qemu-options.hx                          | 32 +++++++++++++++-
 target/arm/ptw.c                         |  7 ++++
 13 files changed, 235 insertions(+), 45 deletions(-)

