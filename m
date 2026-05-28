Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A87CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 17:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSeMg-0006ZS-1D; Thu, 28 May 2026 13:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wSeML-0006TE-BV
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:17:33 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wSeMJ-00046N-F9
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:17:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so74240405e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 10:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779988645; x=1780593445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lEwSIvtM/DW6o/9k7MPGdac3VdkV9MgPLv8CbJiO3YY=;
 b=X1Q35wk9+7OMwOGut07tBaV+khAUyuqyBnUK2ZFpDppo7pLAnWPLkRaqNCteDl/nM2
 NG/6GlfwjGvtWQEHT6GufOSYrY82hlD3rgo8YVM49jW1B14KRPNVHx0HnzSDDFn6Apn5
 ErG40aR4o/9Auopd4iMShETC9u58WiSVgF9CY6pWW1F1JZf5VnDAd4PzRulw6eOavWM5
 zpAgSW2i+M/NIRtovf/x8tFr7xGvO8cSW+FZRtVKT3xmmbEOfxrK1O8Hdp87rogL5vQK
 yneGZ+nFc3Ylo6XlIcoJ9wQ9rTF4fdVc9QzYXpieoqGF6s804aQ+3v5cKUHbtRQ1aySt
 ehFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988645; x=1780593445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lEwSIvtM/DW6o/9k7MPGdac3VdkV9MgPLv8CbJiO3YY=;
 b=l23f6Yed+uW/MrMagUZJVuFTh+A5ogQmL+o5tTkXpIQ76oqOgHYCAtfQ0CUwY9mqfL
 M7sANctdmmk7aqu1GdkkJ3Ud5QhMrC8AaPsWkmZuYW+IAtDw5/ogzGJQa05G5cGv1+tT
 /wifB4mM5SXzkKJ8XXTXFbwKeLSPGe84P8v+bYpdwyVPCdjNB3c0YG8Vf5s0mpx/MJYR
 xfWlTkRvn5BFD5Qo28b/KdaK3uNPoz45Bk2OEp7ZfAIBWskN8+jrsV77SRSdHpgW9vFZ
 +uF+WPT9BsBAA9IDXC7rONcQJOAdGif1S763UXAPkrLOQyndDlTigBpUJ0gNX6T2HSa3
 hMRQ==
X-Gm-Message-State: AOJu0Yxe0lFLDPOlxRRU3LFa9a/BHQd7v9TCYGlgtcg+Bo/cN1UZgmUI
 PFEheDD85OO2YIjWCpPx8VQa5qvNxB446Tsv4JL9gl36Hph5ZeCaVBrHyRrJWo98
X-Gm-Gg: Acq92OHrLeKinDXFazx7AO7ibpywhZnEGtAKWqoiV9ig/1daaYjEj8JwC3DD4FDmSs5
 +PvOoTAviuJBwCtZNVDsg8ue6MnQWwaxbb950yixIopyLdxT42+BvRdRJJs11WPqHgi9xzDosNP
 GscH0bmMeFI1vIY7kqclQSmJxhwCfi1vWy8fP96o+9PDvNCw8Sr4kzzhh1obEUgtHhDTkyiWuJv
 LpWFQ4vdqH4Iotj0xLZnyOXE+vj0sUBSpbl36VMErwTq6Cajgx79wMDIlB+8yju9JWVXYnQVWVt
 kMRB9tx9m/as/r+Ax2X89xd+sbSaql98jANAcMLsbyl7JqcMcjN9uZo5uyMnMg3INaDy18gsyzJ
 U6Va5iahBpQMeFDV8PJebvfVZXopBMX7ytEOo2RJmp4SCpFmv2lIaLZbTWEuTZGBHOF/6Ztv8ap
 iEOdIeUV67BTabVNKObfdLbIzKSM2oSgeyMANucpn81nxM17yExf2K2HMVjQo4gM7s
X-Received: by 2002:a05:600c:a402:b0:48f:e6de:1cba with SMTP id
 5b1f17b1804b1-490426c5b3emr392563345e9.17.1779988645078; 
 Thu, 28 May 2026 10:17:25 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092968066sm53774085e9.15.2026.05.28.10.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:17:24 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrey Volkov <andrey@volkov.fr>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v4 0/7] hw/arm/sabrelite: Add FlexCAN support
Date: Thu, 28 May 2026 19:17:10 +0200
Message-ID: <cover.1779986496.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x329.google.com
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

Changes from v3:
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
 hw/net/can/flexcan_regs.h     |  196 +++++
 hw/net/can/meson.build        |    1 +
 hw/net/can/trace-events       |   18 +
 include/hw/arm/fsl-imx6.h     |    6 +
 include/hw/misc/imx6_ccm.h    |    4 +
 include/hw/misc/imx_ccm.h     |    1 +
 include/hw/net/flexcan.h      |  144 ++++
 tests/qtest/flexcan-test.c    |  421 ++++++++++
 tests/qtest/meson.build       |    1 +
 19 files changed, 2340 insertions(+), 10 deletions(-)
 create mode 100644 hw/net/can/flexcan.c
 create mode 100644 hw/net/can/flexcan_regs.h
 create mode 100644 include/hw/net/flexcan.h
 create mode 100644 tests/qtest/flexcan-test.c

-- 
2.54.0


