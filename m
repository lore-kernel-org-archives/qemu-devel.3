Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFB3CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ6EJ-0008M8-Q2; Mon, 15 Jun 2026 08:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wZ6EI-0008M0-5y
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:15:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wZ6EG-0003Sy-BF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:15:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4921e4dd62dso17533685e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781525746; x=1782130546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=avWpqqLXhoPVsAmO/pwtPf7BlT9OOPa6h8N6xRx0cFs=;
 b=eTdB+xc6xTng3qW+oRGVm+bNvzG/iNNOzKRtete8WaK6ODc3K623veQWDDQtmCNQQk
 FEyn29kY3OI4xB2a3nZUNFAClGmA8IEVmBj9G0VPkAT5/oD98uLFs0INul5mcYpk56H4
 /UyV7eAUhdFSPV4psuB3sTQGUMBPSCgYMTaHwF6fNRLSjsQFDDIc6F35qEUDahNYw6dt
 gqb2swFu4n0C9XMs1qE0cEK5JWcunMDmalUuVV/HgOVHsa20hFWH4ngld106RDZJXG1J
 1Jdw4vuCGJekjabvN0Fx3v9qZqq3//JCuEC7r96a2bz6IkQ0ROJASYofiXTcm2aZXQbh
 TsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525746; x=1782130546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avWpqqLXhoPVsAmO/pwtPf7BlT9OOPa6h8N6xRx0cFs=;
 b=XG2n80qhUuxvarodeOvF8G4TJcsU3aFGh6nk7q3Eg7hEg5/Ty2eo4hWklqI7jfdxe1
 UPAkJLJ92QqSclOvCySrk0/aR8TVtu5+PIvKPRNarLNNiOdB+yk60fystr9xVEDvfeeX
 6bzH3waAkxqJ7zKKmG+19nuRCbVRcKF+qq1132iAoLmqVUR8jSrqlge0BdgQAhSIzFS+
 9xYHkDujG34imuHmdmh9KwtYHSZJVzQjUv/ExWEEuq+QXcvgKoMlzQmFnCRZ7VTq6jlT
 016hsKBbHwxVHATpXIH2wAx683hoBLLefTcIjPQXnN4G3vfTzI8jc4XAxq/n8iWeesWf
 t06Q==
X-Gm-Message-State: AOJu0YweFX9Ass6WtzOlWpeMyopAxzmqEMJtj0KkzoJ66pTG+arHFn3w
 PXIqvaXrVcerllLkiOx4vmJmwXv6pfX+iRBW5j6sY4PlmmIpxSHeoAwX7Emtk3bu
X-Gm-Gg: Acq92OGKaBt/Tw4Pmajqvo8PPbk/pVnBl/uPquiyXRGlGhgntZDAHobWhwfhDfMppz/
 Q3r82oNeLGEMhZ9ZnfjCDL+AoCjqfh7yKHwxxs5ZSyO4T9M9LYZStYAcAwWmV+NLd/cL2J6EdO3
 h3FxYMyTwA+aHNloc4yP6tt6r+bCE2Ul1R/siURODNldUZZT6yNM/M+QlvPhaUiXeQkEckosVnA
 P6UUPOGzDAcSxzjtgQtSWaC7rTY8O/NDZSVCy+ygepMTQhZ7OSjq3VeEQRQhwFCfv+rQisb9Rz4
 gl4b6XcZSsAkqLd8FyYZofPOEEEKQ5wD/QkrDQ2p1LU+E47bREMyYeGULoLKSpPLX9Vvym0DIaS
 x2t0RppjUMX8Zek1XmYulEl9cJjIOy4hZ8vNxI97Kh/LW093woGWXCnQsRhCyJ6RwiPKKICrCpR
 MPeHacJ+pDiinRKRBcKt4jTfN6dp8vTuOQxl04FJVjx9rJ2QkFebL6r5IEVRKI+jxt
X-Received: by 2002:a05:600c:a203:b0:490:af63:2cb1 with SMTP id
 5b1f17b1804b1-490ec49a025mr90442705e9.7.1781525741870; 
 Mon, 15 Jun 2026 05:15:41 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm338491345e9.0.2026.06.15.05.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:15:41 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrey Volkov <andrey@volkov.fr>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v5 0/7] hw/arm/sabrelite: Add FlexCAN support
Date: Mon, 15 Jun 2026 14:15:00 +0200
Message-ID: <cover.1781111270.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series adds emulation of the FlexCAN CAN controller, version 2,
found in NXP i.MX6 series SoCs. The controller is integrated into
fsl-imx6 and the Sabrelite ARM board.

The chip has two FlexCAN controllers, but the Linux Sabrelite
device tree enables only one by default. Linux kernel with both
controllers enabled has been tested to work properly (using a custom
device tree).
See docs/system/devices/can.rst for an example of QEMU command line
invocation.

More information about the implementation can be found in my bachelor
thesis [1].

Changes from v4:
- renamed can in fsl-imx6 to flexcan
- corrected attribution for definitions borrowed from the Linux kernel
- rebased onto latest master
- Link to v4: https://lore.kernel.org/qemu-devel/cover.1779986496.git.matyas.bobek@gmail.com/

Changes from v3 to v4:
- corrected attribution for definitions borrowed from the Linux kernel
- rebased onto latest master
- Link to v3: https://lore.kernel.org/qemu-devel/cover.1777571962.git.matyas.bobek@gmail.com/

Changes from v2 to v3:
- moved variable declarations to the top-of-the-block
- cleanup
- removed redundant license boilerplate
- rebased onto latest master
- Link to v2: https://lore.kernel.org/qemu-devel/cover.1773866323.git.matyas.bobek@gmail.com/

Changes from v1 to v2:
- removed DPRINTF (turned into traces or guest errors)
- removed gotos and unnecessary continues
- register memory region shortened to actual length w/o padding
- make flexcan_* fns private
- used DEVICE(s)->canonical_path instead of allocating new strings
- changed DEVICE_NATIVE_ENDIAN to DEVICE_LITTLE_ENDIAN
- removed ugly USE macro
- used enums instead of define sequences in flexcan.c
- fixed FlexCAN KConfig conf (fixes build on non-arm-softmmu)
- fixed style and other issues from Bernhard's review
- better wording in docs
- rebased onto latest master
- Link to v1: https://lore.kernel.org/qemu-devel/cover.1765826753.git.matyas.bobek@gmail.com

Thanks Bernhard Beschow for the review and his patience.
I borrowed some fixes from his flexcan branch at [2].

[1] http://dspace.cvut.cz/bitstream/handle/10467/122654/F3-BP-2025-Bobek-Matyas-BP_Bobek_FlexCAN_final_4.pdf
[2] https://github.com/shentok/qemu/tree/flexcan

Matyáš Bobek (7):
  hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
  hw/arm/sabrelite: Introduce class SabreliteMachineState
  hw/misc/imx6_ccm: Add PLL3 and CAN clock
  hw/net/can/flexcan: NXP FlexCAN core emulation
  hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
  tests: Add qtests for FlexCAN
  docs/arm/sabrelite: Mention FlexCAN support

 MAINTAINERS                   |    9 +
 docs/system/arm/sabrelite.rst |    1 +
 docs/system/devices/can.rst   |   24 +
 hw/arm/Kconfig                |    1 +
 hw/arm/fsl-imx6.c             |   29 +
 hw/arm/sabrelite.c            |   68 +-
 hw/misc/imx6_ccm.c            |   24 +
 hw/misc/trace-events          |    2 +
 hw/net/Kconfig                |    5 +
 hw/net/can/flexcan.c          | 1395 +++++++++++++++++++++++++++++++++
 hw/net/can/flexcan_regs.h     |  197 +++++
 hw/net/can/meson.build        |    1 +
 hw/net/can/trace-events       |   18 +
 include/hw/arm/fsl-imx6.h     |    6 +
 include/hw/misc/imx6_ccm.h    |    4 +
 include/hw/misc/imx_ccm.h     |    1 +
 include/hw/net/flexcan.h      |  145 ++++
 tests/qtest/flexcan-test.c    |  421 ++++++++++
 tests/qtest/meson.build       |    1 +
 19 files changed, 2342 insertions(+), 10 deletions(-)
 create mode 100644 hw/net/can/flexcan.c
 create mode 100644 hw/net/can/flexcan_regs.h
 create mode 100644 include/hw/net/flexcan.h
 create mode 100644 tests/qtest/flexcan-test.c

-- 
2.54.0


