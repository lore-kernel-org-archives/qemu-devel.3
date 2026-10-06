Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C6BCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENMG-0006vr-UN; Wed, 07 Oct 2026 04:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEKNm-00072q-D9
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:40:15 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEKNk-0007yN-Fh
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:40:02 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6acba4bf65eso24884a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791351598; x=1791956398; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e06GNJ4kvQuBbpZar3XCy1iXf5bv9F7GR7YSfB4psk0=;
 b=KnQG8Vy/mzSQ/IIbEmRfuyBZHyD2UDzVJsEHt1z7qpsYUsKCxGOK+Ksw4TqR/rNgXF
 Zwsclu6zWCFbEDvOZMZvSvGaaa05Jb4y0/QtZMoQKx4rgmQ5n1Elicwh/N7vNdYi0AKV
 r02NiI5fYr1gPaciW8yD8VGWoYO+52nPzVI45eMuldc/ax6wuMK8AoYo686keFLZeeBX
 MmhlcmTvJ1RL7VaRKjg+GZrKN0hvll3DOnUul+4D+oyDZrYjIdb2GKEwbFQK2X78mSxa
 4gK5iy37HpipBN4A6xvWjop478P4NOOEwlNy1qI1VJUp6gEdlYeqhbFDVxyGVO6CrgMr
 gBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791351598; x=1791956398;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e06GNJ4kvQuBbpZar3XCy1iXf5bv9F7GR7YSfB4psk0=;
 b=jHGS8YuhOy4t6WshDzMHkMv75eVkd0yMYjRom0fMNZ0AsLI8dw7jduCfXNa58Ff8WY
 EKQ+ne+fuUbGkVvYLidbXf6Fsi5Mx89aIVavrv2EBkVr8Ia3COqXxmJlzYiWb73UJmOT
 OcdPfowqDxtH4RfnDlqL09BsQpqmPhBiETjX0R9mEN7SObxIEgbLVm7nAZx7Nf0fwmzO
 nKi8BrV0mltfxOVyUuWFdrq9YDXb8NjfiZj+gKqGpthwBfBLtXaUmEnqB/NYvWz5h7nn
 wJLUKRT2QPx0mUZFzRVD74Cg0pzcdrddkgq5fJ8EysSJQlTJoVNQ3gG2nKVQHZxaqGC4
 sPDA==
X-Gm-Message-State: AFq9FYJHLe93A6wLO5sn3L34cqvol/wmHj87I9LIsVgh8uxwjXke/WZq
 iDKwoqvHYqP25Zk7tg5n5Lz0ghQSIqhwa1pV/BHExipjtnT38TdM58ZDk5em2g==
X-Gm-Gg: AYBFou2SwTCQfolGrm0PsQ7IcyFMYjZrxOfvH5tX23KH3LDmIaSdGHdYiQWJlTVKQ9s
 cIbupFzf94RSSDjOw3nKdd52CnPgI9YVIM/QCXBYB1LSQl/ktAhxqEiHNR9/ope3+rJTb2slqU1
 nZbaCX4IbTi96ng16vr7Y5kbVnqXbpa/9zvVkam3roNECHIyviwqGiGMl7fp5p+ZnFbkfhU3juZ
 NdZrEcvQrJPzwgELvH2iR7ziAjF2pmzr+LXweT6ORhUTwQRyVdURhMYm+pOewuNHxly61zw3SVz
 GmiOGJ9/awmw6NFshlKwdoyRhXRW1SzcZMlky/py0gMBsgmRV8W23rg85uVptEmShSa3kRYjHS9
 aXNyVWV9PlEQUHcdtj115mB0g5JKUdl47p1jPS61g7YbeQyyifJk1RKwtgwUgqLzqgKYAnuGIyP
 w3HrXqR9/fgCecdNm9ngFPbtSJhomoXJUkEBDIPDV7N//UEJfc1rsW1zrRFLQP+PrSEZrz1EQ7C
 M7P8NT4vVdX8hJ7rIVWiJemTJs2ziCT68IAZw==
X-Received: by 2002:a05:6000:4b04:b0:486:f6dc:52c8 with SMTP id
 ffacd0b85a97d-48c6d1981ffmr1216536f8f.37.1791275720335; 
 Tue, 06 Oct 2026 01:35:20 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:19 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 00/31] i.MX fixes and cleanup
Date: Tue,  6 Oct 2026 10:34:12 +0200
Message-ID: <20261006083445.30362-1-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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

This series fixes various issues in i.MX device emulation, cleans up i.MX=0D
Kconfig handling, and improves some code. Functional console tests for the=
=0D
remaining i.MX boards are added where images are publicly available, except=
 for=0D
imx6ul which is taken care of in a different series [1]. Fixes which appear=
 safe=0D
for backporting are cc'd to qemu-stable.=0D
=0D
The series is structured as follows: Patches 1-5 fix some issues and are=0D
mostly marked for backporting. Patch 4 is a follow-up on patches 1-3 and=0D
should not be backported since it breaks migration.=0D
=0D
Patches 6-11 add and improve functional tests for i.MX devices. While at it=
,=0D
saner defaults for the amount of RAM and number of CPUs are established.=0D
=0D
Patches 12-16 turn the remaining i.MX SoC device models into SySBus devices=
=0D
which fixes their reset behavior.=0D
=0D
Patches 17-30 are Kconfig cleanups where CONFIG_IMX gets split into dedicat=
ed=0D
config items.=0D
=0D
The last commit just fixes some typos in the code.=0D
=0D
Changes in v4:=0D
* Fix triggering of watchdog_perform_action() (Bin)=0D
* Pick up R-b tags=0D
=0D
Testing done:=0D
* `make check-functional-aarch64`=0D
* `make check-functional-arm`=0D
=0D
Changes in v3:=0D
* Add dedicated patch fixing write one once WCR bits, cc'd to qemu-stable (=
Bin)=0D
Done as yet another patch to tell the issues apart.=0D
* Add and fix some commit messages (Bin)=0D
* Add functional tests to 'tests_arm_system_thorough' (Bin)=0D
* Fix typo in functional tests for mcimx7d-sabre machine (Bin)=0D
* Use sysbus_realize() rather than sysbus_realize_and_unref() in case of=0D
embedded SoC struct (Bin)=0D
* Pick up R-b tags=0D
=0D
Changes in v2:=0D
* Remove patch adding `mc->ignore_memory_transaction_failures =3D true;` (P=
eter)=0D
* Rework wdt_imx2 patches (Peter)=0D
* Remove all but "hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from co=
nfig=0D
IMX" already queued by Phil. The preserved patch is required to remove all=
=0D
dependencies from CONFIG_IMX such that it can be removed.=0D
* Pick up R-b tags=0D
* Rebase onto latest master=0D
=0D
[1]=0D
https://lore.kernel.org/qemu-devel/20261004090500.3082641-1-bin.=0D
meng@processmission.com/=0D
=0D
base-commit: d7a65d1793d691d356a56833620f7d1e6f5d653b=0D
=0D
Bernhard Beschow (31):=0D
  hw/watchdog/wdt_imx2: Preserve own locked bits in WCR=0D
  hw/watchdog/wdt_imx2: Fix handling of write one once WCR bits=0D
  hw/watchdog/wdt_imx2: Clear WDT lock on reset=0D
  hw/watchdog/wdt_imx2: Remove redundant attributes=0D
  hw/arm/imx8mm-evk: Fix reference count of SoC object=0D
  docs, tests/functional: Drop redundant CLI arguments in imx8m*-evk=0D
    invocations=0D
  hw/arm/sabrelite: Have 4 CPUs and 1 GiB of RAM by default=0D
  tests/functional/arm: Add console test for `sabrelite` machine=0D
  hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by default=0D
  hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of RAM by default=0D
  tests/functional/arm: Add console test for `mcimx7d-sabre` machine=0D
  hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE=0D
  hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE=0D
  hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE=0D
  hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE=0D
  hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE=0D
  hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from config IMX=0D
  Kconfig: Extract config IMX_AVIC from config IMX=0D
  Kconfig: Extract config IMX_GPCV2 from config IMX=0D
  Kconfig: Extract config IMX_RNG from config IMX=0D
  Kconfig: Extract config FSL_IMX7_GPR from config IMX=0D
  Kconfig: Extract config FSL_IMX{6, 7}_SRC from config IMX=0D
  Kconfig: Extract config FSL_IMX7_SNVS from config IMX=0D
  Kconfig: Extract dedicated config FSL_IMXx_CCM from config IMX=0D
  Kconfig: Extract config IMX_GPT from config IMX=0D
  Kconfig: Extract config IMX_EPIT from config IMX=0D
  Kconfig: Extract config GPIO_IMX from config IMX=0D
  Kconfig: Extract config IMX_SPI from config IMX=0D
  Kconfig: Extract config IMX_SERIAL from config IMX=0D
  Kconfig: Remove config IMX=0D
  hw/arm/fsl-imx8m: Fix typo=0D
=0D
 MAINTAINERS                                 |  2 +=0D
 docs/system/arm/imx8m.rst                   |  2 +-=0D
 docs/system/arm/sabrelite.rst               |  4 +-=0D
 include/hw/arm/fsl-imx25.h                  |  5 +-=0D
 include/hw/arm/fsl-imx31.h                  |  5 +-=0D
 include/hw/arm/fsl-imx6.h                   |  5 +-=0D
 include/hw/arm/fsl-imx6ul.h                 |  5 +-=0D
 include/hw/arm/fsl-imx7.h                   |  5 +-=0D
 include/hw/arm/fsl-imx8mm.h                 |  4 +-=0D
 include/hw/arm/fsl-imx8mp.h                 |  4 +-=0D
 include/hw/watchdog/wdt_imx2.h              |  2 -=0D
 hw/arm/fsl-imx25.c                          |  7 +--=0D
 hw/arm/fsl-imx31.c                          |  7 +--=0D
 hw/arm/fsl-imx6.c                           |  4 +-=0D
 hw/arm/fsl-imx6ul.c                         |  4 +-=0D
 hw/arm/fsl-imx7.c                           |  5 +-=0D
 hw/arm/fsl-imx8mm.c                         |  2 +-=0D
 hw/arm/fsl-imx8mp.c                         |  2 +-=0D
 hw/arm/imx25_pdk.c                          |  2 +-=0D
 hw/arm/imx8mm-evk.c                         |  4 +-=0D
 hw/arm/kzm.c                                |  2 +-=0D
 hw/arm/mcimx6ul-evk.c                       |  3 +-=0D
 hw/arm/mcimx7d-sabre.c                      |  4 +-=0D
 hw/arm/sabrelite.c                          |  5 +-=0D
 hw/watchdog/wdt_imx2.c                      | 21 ++------=0D
 hw/arm/Kconfig                              | 56 ++++++++++++++++++---=0D
 hw/char/Kconfig                             |  3 ++=0D
 hw/char/meson.build                         |  2 +-=0D
 hw/gpio/Kconfig                             |  3 ++=0D
 hw/gpio/meson.build                         |  2 +-=0D
 hw/intc/Kconfig                             |  6 +++=0D
 hw/intc/meson.build                         |  3 +-=0D
 hw/misc/Kconfig                             | 41 +++++++++++++--=0D
 hw/misc/meson.build                         | 24 ++++-----=0D
 hw/net/Kconfig                              |  2 +-=0D
 hw/ssi/Kconfig                              |  4 ++=0D
 hw/ssi/meson.build                          |  2 +-=0D
 hw/timer/Kconfig                            | 10 ++++=0D
 hw/timer/meson.build                        |  4 +-=0D
 tests/functional/aarch64/test_imx8mm_evk.py |  4 +-=0D
 tests/functional/aarch64/test_imx8mp_evk.py |  4 +-=0D
 tests/functional/arm/meson.build            |  4 ++=0D
 tests/functional/arm/test_mcimx7d_sabre.py  | 46 +++++++++++++++++=0D
 tests/functional/arm/test_sabrelite.py      | 46 +++++++++++++++++=0D
 44 files changed, 273 insertions(+), 108 deletions(-)=0D
 create mode 100755 tests/functional/arm/test_mcimx7d_sabre.py=0D
 create mode 100755 tests/functional/arm/test_sabrelite.py=0D
=0D
-- =0D
2.56.0=0D
=0D

