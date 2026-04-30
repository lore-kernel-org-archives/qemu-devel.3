Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9606CD13DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIW6d-0006qN-4U; Thu, 30 Apr 2026 14:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wIW5i-0006WA-4O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:26:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wIW5e-0005U7-B4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:26:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso885684f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777573579; x=1778178379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bVcTOSBzgf8YzSLv34DedErZlS0+u7paIqWok/bj8ko=;
 b=gUEHY34DjmcKm2A5uwQH1ENuQw6OhJSv4jjXKMIbK9LkbjoKIPotFD86wPdehmyfd/
 z3pV9J1mWJ7Q/d+ZgTKzBeKl2j6nuHpVdHB3ZkH5nxrboe2uL1cCfs67UjpHudXGDM72
 Fc91jl9w7mUrxHR3a4Vm7GAWeKXiTaP/25HQm0VQr21MkJlYtsnLGn8+L8lmlRtH1roc
 ASLu0lmaHrftDuOy7HQK/gvqdf/cqxLUr0sWaN2DKJJvJIGboLPMu7y8KxtK2Hvft3Lk
 VluXu8nYKP5egSELbHyGUv62zQ0PB6HjZN/z+khv4SvWqBV1NIibi3gAWoEnMMrB3F6c
 dTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777573579; x=1778178379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVcTOSBzgf8YzSLv34DedErZlS0+u7paIqWok/bj8ko=;
 b=BcBGcvmZ/1Xji7H26NpxOSU9hOEpx+Q/nnMaZdA/yesXj+5V03MTdgdA42v2tNMQjF
 W1maNaCXDl8Hgo/u5ioVikxlQ7cnDt+A4j5v/KZnQAZQgVHgqgStxY1ttub2aubfNA7b
 tL7up7filnanrBkfqMaSYlCJfLqlUzJNcun4jb0hHFKuDDDKM7OLAEEbB6IS1OPkn0XR
 JktfVjT21nc+DfFa66EyxnwpVgjGChtkI9K6HxMBHaD7KGcbdywAVpR4hkIZjgsyc+LJ
 U+yU8Sbi8C39UmBg2cVG8KD7+3BA+PEU4tgLA6U+Jr1MZVxPYmcoLTkhANM91m6cKPeJ
 0xgA==
X-Gm-Message-State: AOJu0YwY3TPAVQMwA/iwv6jms2WV7SVnsL42cXXWJCwWfJE++OtEfnO0
 qWX/6V2/rTiMs9rtbnBbjMhnUNpKbM9s64QuejURrowwVKo+TPjalP35kKa6C1Pm
X-Gm-Gg: AeBDieuJDRoGjvNTdFJSq/KWVQMVAEqC9JWODX4A2/Lio341rxZspy6g0+xC+qhORoW
 KqNK9kozdxNSSrlf7vvd/PPx+d45Xu6uQLXMHrJH50aKJtsP3WjyUUGHFmSzppDwd7mSHFDBVgg
 4oTpB9ArLh/MKoSICRb2V63R5dYgZMfh5v237W2JP4QShl4YwVw5A4MgdXbL4qeKUh5LVDishOL
 xGcVEw+auUC/i7wlr//502IHi0bVoeQ1UFh8vX/BxoTMoO8la+blGv5aggrsZu9IYnWboJStRIu
 RS4GOxPjcuXzh+V1FdaGkQn3bMP4dCsq82p04X+BLuL+Sm/35CLaaMb3Duu6QaKNH9jRKdsVC1k
 Qd30sjmeAVHnf2LtlsWhvA3UGXRDSdR0SlvB+j1l0LvFiOgxQfGT7SCdHOitRLfD8J0cQyfnbQV
 yVXIINxqB+MKm9IcGMLh1Y+sfSYwJ4sW2VExDeaTJ/cEzaYIkQokiSekdUfhi10YXT
X-Received: by 2002:a05:6000:2f8a:b0:441:1cf9:4f06 with SMTP id
 ffacd0b85a97d-4493fed64c0mr6949536f8f.31.1777573579066; 
 Thu, 30 Apr 2026 11:26:19 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c00sm14674925f8f.25.2026.04.30.11.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 11:26:18 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
Date: Thu, 30 Apr 2026 20:26:02 +0200
Message-ID: <cover.1777571962.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The headers (struct FlexcanRegs and flexcan_regs.h macros) were copied
from the Linux kernel. Marc Kleine-Budde is the copyright holder. He
has been kindly asked to provide consent, to confirm his approval for
the inclusion of said header fragments into QEMU. The approval is still
pending, hopefully it will be resolved soon. I will update the patchset
on request if another wording/solution for the copyright statement is
proposed/requested.

Changes from v2:
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
 hw/net/can/flexcan_regs.h     |  193 +++++
 hw/net/can/meson.build        |    1 +
 hw/net/can/trace-events       |   18 +
 include/hw/arm/fsl-imx6.h     |    6 +
 include/hw/misc/imx6_ccm.h    |    4 +
 include/hw/misc/imx_ccm.h     |    1 +
 include/hw/net/flexcan.h      |  139 ++++
 tests/qtest/flexcan-test.c    |  421 ++++++++++
 tests/qtest/meson.build       |    1 +
 19 files changed, 2332 insertions(+), 10 deletions(-)
 create mode 100644 hw/net/can/flexcan.c
 create mode 100644 hw/net/can/flexcan_regs.h
 create mode 100644 include/hw/net/flexcan.h
 create mode 100644 tests/qtest/flexcan-test.c

-- 
2.53.0


