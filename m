Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91345C02192
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6iI-0008GK-3S; Mon, 03 Feb 2025 19:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6iG-0008Fb-EX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:22:48 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6iE-0006zS-OB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:22:48 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso58285685e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628563; x=1739233363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kZOdbeb6T6qDJ09VSMCL2tbpN7fDjsLgjuUeDOztlJw=;
 b=qIu1M7rFh9SPE5OTMxroTS3RQmuc/EL3mAc17yi47aZU1vBm6P1Ni+sS+ePWguESff
 qhk9NZWkDRr0UpRcNBwSv7WIs0m9+pd7n153EshqEd/3OtsmdsmKjVSlwNiVjF61bdFN
 Y7Nh8o9ggz/lAHBN4bODLFbldVca8HfmrrwWi9a9Atytdff1gMIV9KlcvRt4c2xpehy5
 Dz3mH7lcxExk3NLlGxQQ48+QUZQEqajnUv1wOkp1DSVw4ea10Y88gPS1+jefEiTLiJuD
 sGR2bEq3fPlRELIjT55nUa1Vvc5ffC6De9EJq71LNI0PIYoLEwgfKcu9tKc6GJPo8DQ0
 vNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628563; x=1739233363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kZOdbeb6T6qDJ09VSMCL2tbpN7fDjsLgjuUeDOztlJw=;
 b=VK15l1rLXmilJ3GaqkIudOASBBdbS8OhHIXLJ+rQGW9aBlq4R7S/KPXd3A9sgHjipb
 wSopzsXerOUOs+3B9kHzCKKO6AdJaUxdeqs6TCjan5bYWWReNjMZ2Q9bH1ODSFAfeBKJ
 VFQHvyIug58LSaVoU31q9enDRXxG8LXrym0QYlVG8P9miwY9CyeEFkEsq+fyTdDgSSsD
 tQZvYv3JhY51JOQtHoXRMOr7u/+aZTRb2AFNNXqcZMEqA5sCYMh4eQYOTxQdYrh1CnJI
 2C+fR4AF4aLvk/fIw+MhnMDCfiDBCYiAhlsoAhKb0n1ctHpv2gGZ4FoHhaoyFfTn5nQJ
 beIQ==
X-Gm-Message-State: AOJu0YwEL+fptv24FcxteX1Go2CMkrfD1mbEbKt1VhQct7ze8/dg9dL0
 l2h45MKeLsiqQ+cKwHnX7KRMcK8egHAN/Rpnaig3oWfjpYlFhVNeBnPheanppMgR91shIuapyN7
 UHsk=
X-Gm-Gg: ASbGncuG/3tS2yCSwc2emdYbndC4piTquYuq2O2x9oCKJZsZdrSBS9dZM0k85Fwf5l5
 HTcWYmWyJ+OQaiavtLIJb/K/RGlWJGFA5TnniM28lraK0JHo5WSAv35bTytMqw3rydX5NZwejfL
 EjkAYzrHH0sCRFUzc3lclyzNYDJtT5PbpnxrG3XRAbwJt/YvDpeHAw0rgKpNJTtiMa54ua6Rmxt
 JoJK7TgyRVO9jnM5drTcCiji5B+WozV+UaZsIGh3r2FKNtE9rCKFcl88B/kECSe1G8OAZm3sGG5
 lM6M4fmxfbAChJ2W+P7awlUXbjMFWgTgf2o/XxJ+lAPhTOD9z04PGtmlD9G4OG0Njg==
X-Google-Smtp-Source: AGHT+IHy6CJhM2TwAoAA8lJ+tS6d0s5TrMMgkexQg1HbHClkotfNU8RmQ08pWBRgcSa5vbyB0b6P0g==
X-Received: by 2002:a05:6000:1fab:b0:386:416b:9c69 with SMTP id
 ffacd0b85a97d-38c5194a58cmr20463197f8f.16.1738628563523; 
 Mon, 03 Feb 2025 16:22:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38da8f6691bsm229504f8f.42.2025.02.03.16.22.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:22:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 00/12] hw/arm/raspi: Allow creating any Raspberry Pi machine
Date: Tue,  4 Feb 2025 01:22:28 +0100
Message-ID: <20250204002240.97830-1-philmd@linaro.org>
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

Full rewrite of v1 [1], addressing Zoltan & Peter suggestion.

Introduce a generic 'raspi' machine, which takes a 'model'
and 'revision' properties, and any memory size. The 'board_rev'
register is filled appropriately.

Before, merge raspi4b.c within raspi.c (more is planned here
with the MPCore refactor [2]).

Regards,

Phil.

[1] https://lore.kernel.org/qemu-devel/20250201091528.1177-1-philmd@linaro.org/
[2] https://lore.kernel.org/qemu-devel/20231212162935.42910-1-philmd@linaro.org/

Philippe Mathieu-Daudé (12):
  hw/arm/raspi: Access SoC parent object using  BCM283X_BASE() macro
  hw/arm/raspi: Merge model 4B with other models
  hw/arm/raspi: Unify RASPI_MACHINE types
  hw/arm/raspi: Pass board_rev as argument to raspi_base_machine_init()
  hw/arm/raspi: Consider processor id in types[] array
  hw/arm/raspi: Consider network interface for B models
  hw/arm/raspi: Check ramsize is within chipset aperture
  hw/arm/raspi: Introduce generic Raspberry Pi machine
  hw/arm/raspi: Have the generic machine take a 'revision' property
  hw/arm/raspi: List models creatable by the generic 'raspi' machine
  hw/arm/raspi: Deprecate old raspiX machine names
  hw/arm/raspi: Support more models

 docs/about/deprecated.rst               |  13 +
 include/hw/arm/raspi_platform.h         |   5 +-
 hw/arm/raspi.c                          | 383 ++++++++++++++++++++++--
 hw/arm/raspi4b.c                        | 136 ---------
 tests/qtest/bcm2835-dma-test.c          |   2 +-
 tests/qtest/bcm2835-i2c-test.c          |   2 +-
 tests/qtest/boot-serial-test.c          |   3 +-
 hw/arm/meson.build                      |   2 +-
 tests/functional/test_aarch64_raspi3.py |   5 +-
 tests/functional/test_aarch64_raspi4.py |   4 +-
 tests/functional/test_arm_raspi2.py     |   4 +-
 11 files changed, 385 insertions(+), 174 deletions(-)
 delete mode 100644 hw/arm/raspi4b.c

-- 
2.47.1


