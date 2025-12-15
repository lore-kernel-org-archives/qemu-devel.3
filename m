Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C772D5B866
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVEnk-0000f2-Hf; Mon, 15 Dec 2025 15:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1vVEni-0000el-Pb
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:04:10 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1vVEnh-0007t4-2I
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:04:10 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso19471045e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765829047; x=1766433847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J5syRGw+m96ON7wgJuHkIp0bOgB7gS8JVijH/4j4eIM=;
 b=B0vd8NMJj+j+s6t5BzODcJituMu/FAsb6dFm/sbc3tlP3Mk273IjNgSM6Lu5sGHViK
 fdlpGPTZngZ/kNcq6fHHMUvbESonus6eNn+BLDciMwkzTs4lRzGLsxHM3tfk7kHbO6Yq
 7NkPlyYji3SYEt9Ui9EENwrTlfCCpDiwVzMqSS5u9JJY8H8d1BhXE2FpfjBjl0RIORDy
 ICLGWS4ZHVCHH2MGR8Y5YxrPtRO+GhJLgpU3h9Yy0/PLd3SAFFBQQcjevAbN4KOnVf/4
 UK+lKPmSz/YyhbnXLv/nhCNcZEuHtPyaDtesS8ENS1ayMNQQWyjS3PrtBUcv7cRUztyi
 Md6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765829047; x=1766433847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5syRGw+m96ON7wgJuHkIp0bOgB7gS8JVijH/4j4eIM=;
 b=lnHKYNyLCUWirsdN2yb5C+CXnyXTArU0GseoHpEhYeIfCpkU0tnKM0azyzqzxgg7HA
 LLyr5TvwJnBgh2zoXlpku/S/o4yb7UWLcluoaqkjyGPtwNlis9wSMZa4HTlBpc5UoO6Z
 AgQD4rqYMW1yKJAdianOh9JDnEythhkTkMQqVhoZnx0GSz9GKybOUk1iPVTcWCmqDuYn
 LIrr0+t316p5hbf8Hrn8laMIFqqFrzRtFKgJqXj3pjKifBUaWGsIbiSwiXIA/bTj8wey
 +r9ScG7438UAIF25s9eBk1mYQqx5kazDtsPwJZUsvrwKj446KYLsAAAJOICNSDc2yD2r
 Iz6w==
X-Gm-Message-State: AOJu0YwyzgdSqGU2ekIKqKBwFqgc8PtOxb1C5chPecjzxRcS2X9IAY1y
 XM8AnxwjMHirBzok7P54EWdNe/S3JZY0YUkqrTjgmRjgX2eH6DhYOXnpQnl5cw==
X-Gm-Gg: AY/fxX5X47L48mNZ0+piDC8TPXf41Zyf0HHBfKvvMlFX0O7nke2aQ0NNnhYjK4nVmYL
 o4nQhIOrkHWVeykPJLGw3U50jgqyYRwbxfGkK31CPo7TcGLFFdhITYv7Cc6HrPosoQep7O5sZCy
 2a05WPURuqCVrE9e2Liip0Pwj3+nhDdq09bbn5Hg9hjrW9jw5eS8pUBV271J825eWkCpldXnO3T
 SOFZCKlDvI9TI1A6qDZv5N/rYgR3GNEVKF7qIXjKmBoM9/0YBqhTobpaLt7E+F8FGiVKumB2nT6
 sNSJDZcOwizPN503YOyoxrk7toUoJ8io6nLalR/mjaRpP7PCg6FhXSdIEqahdhA949oyIBPTdta
 G1hgvZsrNHuQc4lJsoNuTA0ut0qO310syidCnKv4C9YByHe8oSvqdZlSw5pngxRAFbpVKLCPbNk
 +W3AOL329JOGi/zFNqkGIgJXqThu4mT93XykmEs4NgPg==
X-Google-Smtp-Source: AGHT+IEpO3I8vWR+5QywvxORMyI5P6CDnRbdJrs8hHILLulutOZjYJmQO0wwC7l0cmeHEMNFhzaoZA==
X-Received: by 2002:a05:600c:4e90:b0:477:557b:691d with SMTP id
 5b1f17b1804b1-47a942cd40dmr99154595e9.25.1765829046615; 
 Mon, 15 Dec 2025 12:04:06 -0800 (PST)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f703efesm72603235e9.16.2025.12.15.12.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:04:06 -0800 (PST)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v1 0/6] hw/arm/sabrelite: Add FlexCAN support
Date: Mon, 15 Dec 2025 21:03:09 +0100
Message-ID: <cover.1765826753.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x32f.google.com
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

[1] http://dspace.cvut.cz/bitstream/handle/10467/122654/F3-BP-2025-Bobek-Matyas-BP_Bobek_FlexCAN_final_4.pdf

Matyáš Bobek (6):
  hw/arm/sabrelite: Convert machine to full class
  hw/misc/imx6_ccm: Add PLL3 and CAN clock
  hw/net/can/flexcan: NXP FlexCAN core emulation
  hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
  tests: Add qtests for FlexCAN
  docs/arm/sabrelite: Mention FlexCAN support

 MAINTAINERS                   |    2 +
 docs/system/arm/sabrelite.rst |    1 +
 docs/system/devices/can.rst   |   20 +
 hw/arm/Kconfig                |    1 +
 hw/arm/fsl-imx6.c             |   29 +
 hw/arm/sabrelite.c            |   70 +-
 hw/misc/imx6_ccm.c            |   24 +
 hw/misc/trace-events          |    2 +
 hw/net/Kconfig                |    5 +
 hw/net/can/flexcan.c          | 1469 +++++++++++++++++++++++++++++++++
 hw/net/can/flexcan_regs.h     |  188 +++++
 hw/net/can/meson.build        |    1 +
 hw/net/can/trace-events       |   18 +
 include/hw/arm/fsl-imx6.h     |    7 +
 include/hw/misc/imx6_ccm.h    |    4 +
 include/hw/misc/imx_ccm.h     |    1 +
 include/hw/net/flexcan.h      |  153 ++++
 tests/qtest/flexcan-test.c    |  411 +++++++++
 tests/qtest/meson.build       |    1 +
 19 files changed, 2397 insertions(+), 10 deletions(-)
 create mode 100644 hw/net/can/flexcan.c
 create mode 100644 hw/net/can/flexcan_regs.h
 create mode 100644 include/hw/net/flexcan.h
 create mode 100644 tests/qtest/flexcan-test.c

-- 
2.52.0


