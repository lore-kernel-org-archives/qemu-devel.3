Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E13CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhCQ-0006PW-QJ; Mon, 22 Jun 2026 12:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wbhCJ-0006J0-JI
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:08:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wbhCF-0006ia-MW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:08:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4924593f45dso29353855e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782144503; x=1782749303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J0EfpXJQfGVoHw5LHOqoFn3S99dQ8UghOoxA1O/4SRM=;
 b=LPkwQiKbfRD5v7gCmMqC5+iBFxjSeCGwNwuHBU3HRxf+WSq0aSnIoy6Q10L18SgZWa
 xsc5wyDJk5+4jgB7JAMXCawqCOcYggBdgjSfAMzlhq2KTlVm2SGcVjYC+Oege0+EftNk
 ZzVcr/9me3SaygyXKTgR9qSGTa5Clq7aMQayUiZ4ikNIlckpteeIdZFkftQZqY6yRTGy
 urVvihMjl1/cggSG+jGGly4vxEsDm+tjRw/2t04jmVW93Hy/qaBF/L1TsK7cPSY+4rsq
 3CNiuAe5C05oUKHbLTaO1W4YoRz9GLad1CsZJ+3/Z9m4HWlW+sayVYPpeDWVtxCq2Xi8
 lTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782144503; x=1782749303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0EfpXJQfGVoHw5LHOqoFn3S99dQ8UghOoxA1O/4SRM=;
 b=bZiA/2UW9UWo4H9NlTstI5iB6Qx3KaQX5RClZk58LFalJZvaqvvwNKW1Mmh7WJN9TC
 KykHgiTnaVK4jJ8rDh6xdFUEPLjCGCQvGVzgFYUjGZU2RQTatqHQy/i9WopkgEalW3OU
 hjVTsE32iiIXjnt6bbQG/MkSwvGlfLqFwp89ITkjw/KdPj1QKzQ8PI2RPf+hRm+k7BHj
 Bc+InP0KaStFefc8tUKDeN7aqd13657h7RgKxcRKl1QGqJcCNV9l1ujpq2hc9l2flu/w
 BDj1Et91BhwRJFSCVxkCU0JtvN13WTcSeur1BHi8SEDZ5BbtphFfQIxlihCpSqvV4XtQ
 U51w==
X-Gm-Message-State: AOJu0Yx/CQfpB2bQ4v9aFkrNXk0ziZqxEev24pXLLH8wMK5JG5sWOTe+
 JlsLYcazW8ipBA9On4mskD6A7PqYiD/pka++23qhqYMqR+4Nrl3xtpDDESJUkZ/j
X-Gm-Gg: AfdE7ckqwcRbUSk660LCWGwQLOhbffYbAzYTTlnxHaNd1XPReeouzh8P1qZlzOfvctf
 iIzgtanjzRyBJTqradvAhKtAOYexD05xMx7T3cwCAGlGVd8Jf6AduPVWQAA1NJfDC94jbZ7MHbU
 IRZDcpq7E/Zmr/vBJOinA/VihDCxTedAPXShWq4zREp1j1pU9n/GwKVW5lOlDb1VvP6XDMjEkLu
 wzDVrXu52iPEbxi+rmiMFEowO4gqaUt08hGzOsOWMkInGt/adyfC4u3tT9nI5FyMDLDvWcql1Y7
 b93NakiR+V/LKNbFx2fLtl+O27ScAi2xXy2USAI5Q6xHI0MIDiTRTJcI+40/d9QOeJ6xWlNgVW0
 hT+iBADhUk3S/Hb0tYqh2kSqlo3JdkYuxeMhH0bEiAwOvoTHWJSMiXy+wxsrUDR8YkK48/eE8Cx
 cfRUOEbrL0NJjP++O47IC+Xqc6Rq2KkAL+I+RCh9yfmNNZKAmP087TAQ==
X-Received: by 2002:a05:600c:4f53:b0:490:6e12:542d with SMTP id
 5b1f17b1804b1-4923f572d60mr243139625e9.19.1782144503181; 
 Mon, 22 Jun 2026 09:08:23 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496d8sm225062545e9.9.2026.06.22.09.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 09:08:21 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrey Volkov <andrey@volkov.fr>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v6 0/7] hw/arm/sabrelite: Add FlexCAN support
Date: Mon, 22 Jun 2026 18:08:05 +0200
Message-ID: <cover.1782140438.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x330.google.com
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

Changes from v5:
- fixed buffer overflow due to unchecked input in
  flexcan_enabled_mailbox_count
- rebased onto latest master
- Link to v5: https://lore.kernel.org/qemu-devel/cover.1781111270.git.matyas.bobek@gmail.com/

Changes from v4 to v5:
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
 hw/net/can/flexcan.c          | 1396 +++++++++++++++++++++++++++++++++
 hw/net/can/flexcan_regs.h     |  197 +++++
 hw/net/can/meson.build        |    1 +
 hw/net/can/trace-events       |   18 +
 include/hw/arm/fsl-imx6.h     |    6 +
 include/hw/misc/imx6_ccm.h    |    4 +
 include/hw/misc/imx_ccm.h     |    1 +
 include/hw/net/flexcan.h      |  145 ++++
 tests/qtest/flexcan-test.c    |  421 ++++++++++
 tests/qtest/meson.build       |    1 +
 19 files changed, 2343 insertions(+), 10 deletions(-)
 create mode 100644 hw/net/can/flexcan.c
 create mode 100644 hw/net/can/flexcan_regs.h
 create mode 100644 include/hw/net/flexcan.h
 create mode 100644 tests/qtest/flexcan-test.c

-- 
2.54.0


