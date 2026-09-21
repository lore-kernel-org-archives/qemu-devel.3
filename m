Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BAAC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrS-00067w-AD; Mon, 21 Sep 2026 17:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrH-000656-5q
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:32 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrE-0008Vm-5f
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:30 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so20228215e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027247; x=1790632047; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+IwVAR5hQk41iaSDqqRVV9sGGspFHtjxv/N5uIj75rI=;
 b=GkScrwPCV2wxolVL1gz66ZH3Jb5qmavZ8JebnSMBxs2qwitmx0oc90wBR5hd4/UIT5
 IDZyzwOg5irfvaEmRbEsWDOnGNHGzqBYYIXH3jSulMhM9gSl9rFHH03UGze/6OvqBYf+
 fNcw02HuUFuVOgiix4/CiuAfH4MYkbga77dIW31PSkYjw8kvP/yekA9jz3f/wYpFdIlr
 A9LAINY10zinnGp9zRxHA9twX/nGKvIE0xXfoyzpscZM3D+51EAO/40xuYVlqUNBq37h
 Em5SFiuKBIHltZVx15amO+w6qHqEUutbgaaUQCEaVKzhxGCkOaF1Zvf9cHljGK82wku8
 xlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027247; x=1790632047;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+IwVAR5hQk41iaSDqqRVV9sGGspFHtjxv/N5uIj75rI=;
 b=N7A23kbdex6vaZtRhhwhRO8CMCWu/ISQXdGOXgjSiLJDBAGZCSbvRpCKCV6ILTH1h1
 lXtYOp7gk9I6PRloNov7aX2DMcHKhmjjiJ5g72OPu8NDWD2Uf9z8pic9xJwzXk8t5D39
 uAFH7ne1sb5KIfp/f+FHisM5G2tFecW1eQGLKmaQp4Nf/LWd+wEL46OktkR11RyCpphj
 PGD5s3nfc/cMVqnfA+8JNsMSOB4xxa+AlgLIKQBGXOB5tvxeQKMq1mSthW9fU2rf8OKJ
 WpjaHgKrW3iKj+zIUPvuCXEHW1RHtRIGvIsmrgK1P/mYNCL0jF+5jAdYl3zycK5v56TP
 M8cg==
X-Gm-Message-State: AFuF++llUALkz4IPzSaFoafu2w9/xFl+RLvTNr2t2mqkTvWro/bYflHh
 qjxsEHUC1NAG0dGY/Girf23EAFmH5Dl02weOLGtgZrCSVuL1MJB4bxx4ec9fAw==
X-Gm-Gg: AYBFou1b4wv51oAjEDIYsnsfUGW/87IvSPqFfPJgwRAoIJwjk1XpVbvatdDm5jHg5aE
 NehZMMLw1SDNdt4xmE/tz0PVMJDHNLKwrj1xsvdOGjUnbJWy/cOeO0bvP6dZknF+4gHeBv/C5JJ
 GmmZ2zPvVqHhM6xbJD5sR2i6SiS+xi1Z/74l4DHTyzlAz19n96r99WzUFCtBqFbGOR/imvfOe8S
 nuoA2DlkvzBAEKhPEoFwDPTyMBu5mduVVhXKfIqgMdT+38E3Arc3kzb0WCrwRj89iTZVzN+nF6n
 XO6HEoPj9rS5f++b3L+FyatyS1CeujV7KP+buxKTHD2+M5Cx3ywlnfKC2OAkxkueMkjwdy2FKVt
 pbyqD5rcAgBdQcGNZ7TUxeKeGQonHz5db7AdVLW8NhmmumArqOSW+DrycZLrf67NS/h8kmfitA6
 ZSYmfQJzMiisAtCOmEvT6JOB3vQxMYbl+gPZsgPo4fSWpI9jmM+6OxbrYrKKnI4gZiV1rAWnrt3
 s5nIuveXxIyxqMDyrZdWh5IhN1+k+mfeN07sTLNbqv49VU7K4QAiwxiK15JSn/VmdNhV5/rba56
 KAQ=
X-Received: by 2002:a05:600c:8b8b:b0:49c:fc6e:a3dc with SMTP id
 5b1f17b1804b1-49fc584fd80mr155526355e9.27.1790027246403; 
 Mon, 21 Sep 2026 14:47:26 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:25 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 00/42] i.MX fixes and cleanup
Date: Mon, 21 Sep 2026 23:46:28 +0200
Message-ID: <20260921214710.29422-1-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
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

This series fixes various issues in i.MX device emulation, cleans up i.MX
Kconfig handling, improves tracing, and improves some code. Functional console
tests for the remaining i.MX boards are added where images are publicly
available, except for imx6ul which is taken care of in a different series [1].
Fixes which appear safe for backporting are cc'd to qemu-stable.

The series is structured as follows: Patches 1-4 fix some issues and are
mostly marked for backporting. Patch 2 is a follow-up on patch 1 which allows
patch 1 to be backported while patch 2 shouldn't because it breaks migration.

Patches 5-10 add and improve functional tests for i.MX devices. While at it,
saner defaults for the amount of RAM and number of CPUs are established.

Patches 11-15 turn the remaining i.MX SoC device models into SySBus devices
which fixes their reset behavior.

Patches 16 and 17 are QOM fixes inspired by Phil's comment during the FlexCAN
series.

Patches 18-33 are Kconfig cleanups where the majority is about splitting
CONFIG_IMX into dedicated config items.

The remainder is cosmetics and adding a QOM path to some i.MX trace events.

Testing done:
* Run functional tests for sabrelite, imx8mp-evk, imx8mm-evk, mcimx7d-sabre.

[1]
https://lore.kernel.org/qemu-devel/20260904161438.3838261-1-bin.
meng@processmission.com/

Bernhard Beschow (42):
  hw/watchdog/wdt_imx2: Fix handling of write-once WCR bits
  hw/watchdog/wdt_imx2: Remove unused attributes
  hw/arm/imx8mm-evk: Fix reference count of SoC object
  hw/arm/mcimx7d-sabre: Ignore memory transaction failures
  docs, tests/functional: Drop redundant CLI arguments in imx8m*-evk
    invocations
  hw/arm/sabrelite: Have 4 CPUs and 1 GiB of RAM by default
  tests/functional/arm: Add console test for `sabrelite` machine
  hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by default
  hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of RAM by default
  tests/functional/arm: Add console test for `mcimx7d-sabre` machine
  hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
  hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
  hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
  hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE
  hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE
  hw/timer/imx_gpt: Wire clock control module via link property
  hw/timer/imx_epit: Wire clock control module via link property
  hw/arm/Kconfig: Select missing UNIMP in config FSL_IMX8MM
  hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from config IMX
  Kconfig: Extract config IMX_AVIC from config IMX
  Kconfig: Extract config IMX_GPCV2 from config IMX
  Kconfig: Extract config IMX_RNG from config IMX
  Kconfig: Extract config FSL_IMX7_GPR from config IMX
  Kconfig: Extract config FSL_IMX{6,7}_SRC from config IMX
  Kconfig: Extract config FSL_IMX7_SNVS from config IMX
  Kconfig: Extract dedicated config FSL_IMXx_CCM from config IMX
  Kconfig: Extract config IMX_GPT from config IMX
  Kconfig: Extract config IMX_EPIT from config IMX
  Kconfig: Extract config GPIO_IMX from config IMX
  Kconfig: Extract config IMX_SPI from config IMX
  Kconfig: Extract config IMX_SERIAL from config IMX
  Kconfig: Remove config IMX
  hw/vmapple/Kconfig: Remove unused GPIO_PWR dependency
  hw/arm/fsl-imx8m: Fix typo
  hw/misc/imx6_src: Avoid casting from void *
  hw/char/imx_serial: Avoid casting from void *
  hw/intc/imx_avic: Avoid casting from void *
  hw/misc/imx*_ccm: Avoid casting from void *
  hw/usb/imx-usb-phy: Avoid casting from void *
  hw/net/imx_fec: Trace with QOM path where easily possible
  hw/net/lan9118_phy: Trace with QOM path
  hw/watchdog/wdt_imx2: Trace with QOM path

 MAINTAINERS                                 |  2 +
 docs/system/arm/imx8m.rst                   |  2 +-
 docs/system/arm/sabrelite.rst               |  4 +-
 include/hw/arm/fsl-imx25.h                  |  5 +-
 include/hw/arm/fsl-imx31.h                  |  5 +-
 include/hw/arm/fsl-imx6.h                   |  5 +-
 include/hw/arm/fsl-imx6ul.h                 |  5 +-
 include/hw/arm/fsl-imx7.h                   |  5 +-
 include/hw/arm/fsl-imx8mm.h                 |  4 +-
 include/hw/arm/fsl-imx8mp.h                 |  4 +-
 include/hw/watchdog/wdt_imx2.h              |  2 -
 hw/arm/fsl-imx25.c                          | 13 ++---
 hw/arm/fsl-imx31.c                          | 13 ++---
 hw/arm/fsl-imx6.c                           | 10 ++--
 hw/arm/fsl-imx6ul.c                         | 10 ++--
 hw/arm/fsl-imx7.c                           |  8 ++-
 hw/arm/fsl-imx8mm.c                         |  5 +-
 hw/arm/fsl-imx8mp.c                         |  5 +-
 hw/arm/imx25_pdk.c                          |  2 +-
 hw/arm/imx8mm-evk.c                         |  4 +-
 hw/arm/kzm.c                                |  2 +-
 hw/arm/mcimx6ul-evk.c                       |  3 +-
 hw/arm/mcimx7d-sabre.c                      |  5 +-
 hw/arm/sabrelite.c                          |  5 +-
 hw/char/imx_serial.c                        | 10 ++--
 hw/intc/imx_avic.c                          |  6 +--
 hw/misc/imx25_ccm.c                         |  4 +-
 hw/misc/imx31_ccm.c                         |  4 +-
 hw/misc/imx6_ccm.c                          |  8 +--
 hw/misc/imx6_src.c                          |  4 +-
 hw/misc/imx6ul_ccm.c                        |  8 +--
 hw/misc/imx7_src.c                          |  4 +-
 hw/net/imx_fec.c                            | 28 +++++-----
 hw/net/lan9118_phy.c                        | 10 ++--
 hw/timer/imx_epit.c                         | 14 +++++
 hw/timer/imx_gpt.c                          | 14 +++++
 hw/usb/imx-usb-phy.c                        |  4 +-
 hw/watchdog/wdt_imx2.c                      | 30 +++--------
 hw/arm/Kconfig                              | 57 ++++++++++++++++++---
 hw/char/Kconfig                             |  3 ++
 hw/char/meson.build                         |  2 +-
 hw/gpio/Kconfig                             |  3 ++
 hw/gpio/meson.build                         |  2 +-
 hw/intc/Kconfig                             |  6 +++
 hw/intc/meson.build                         |  3 +-
 hw/misc/Kconfig                             | 41 +++++++++++++--
 hw/misc/meson.build                         | 24 ++++-----
 hw/net/Kconfig                              |  2 +-
 hw/net/trace-events                         | 33 ++++++------
 hw/ssi/Kconfig                              |  4 ++
 hw/ssi/meson.build                          |  2 +-
 hw/timer/Kconfig                            | 10 ++++
 hw/timer/meson.build                        |  4 +-
 hw/vmapple/Kconfig                          |  1 -
 hw/watchdog/trace-events                    |  8 +--
 tests/functional/aarch64/test_imx8mm_evk.py |  4 +-
 tests/functional/aarch64/test_imx8mp_evk.py |  4 +-
 tests/functional/arm/meson.build            |  2 +
 tests/functional/arm/test_mcimx7d_sabre.py  | 46 +++++++++++++++++
 tests/functional/arm/test_sabrelite.py      | 46 +++++++++++++++++
 60 files changed, 393 insertions(+), 190 deletions(-)
 create mode 100755 tests/functional/arm/test_mcimx7d_sabre.py
 create mode 100755 tests/functional/arm/test_sabrelite.py

-- 
2.55.0


