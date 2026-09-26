Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395E0C9830E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 03:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAIs2-0004Y7-3Z; Fri, 25 Sep 2026 23:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xAIry-0004Vx-2B
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 23:14:34 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xAIru-0007Or-UM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 23:14:33 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-67109935888so1464849d50.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 20:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790392469; cv=none;
 d=google.com; s=arc-20260327;
 b=GjhJC+RXL0G+mC7EDNWY+vkDwniCxrq6dj/W4fS75Lq03TDGdpX3reIrif3TRxpKo2
 lDjpIFuhFJ+2cK+nB7z6U2jLImXbkZ1uGTISzPaKivwQogXo3eOk6etqO5bj/5aSmube
 7IL2M1H4G0K2ll8iFwlD14ax1GAiXp3g9M+MRVbUgOoMOKTV8Bh4ZXUDv60xrDbehSn5
 dS//qH2eynDhM4wuGVfhGL8UVm0pNYkWcE786ZF7lVKWHIb9tGJqKLWZ5hCh9I6NPe+S
 x46Xhhb3jLPjx7D97GzNXJrz+fg15zAU1Y1KZFcR2EhZH5XXS+y4TAur4vuztCIF9eiu
 qJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9ZLU6BIDOq8PheYVMT28Ujfq8XdsjeNPyBZPVFCs2Dg=;
 fh=BLho5fuS4AHXX0+i7ic523ssJ2LWVh4vIhWYFf89VOY=;
 b=QA5fHg5GVTC7PNmbQEhl49twYelvbJVFX/1Pphc2Vg9BoWNquqotQnm3+7iYA1RHbP
 gv0zCjx2KvbFIpPbVxKPODNjp0cE8ZHiwxXMn+e5Pu3fc/nGG2i5uobxZTXYJYDYCN5q
 q98nei+REQbV3JUxHlHTaxE3H+bdZOb09YSc+5rdXrWYXuEoWqv3thbByVR+/B6/glI4
 DC1+pntyHa8MLzbiIBfIuvgHFAIs4FeKf3lyxFmGD9kOCD5VJUzMMmVbShikyiwMy+at
 sv5LMKYh6T1J3lyONnzDbHW0PTri2xkzOte2uKIa9nkSvCZ1EAwyEnpyfAWq9zWP0bgK
 9ZMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790392469; x=1790997269; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9ZLU6BIDOq8PheYVMT28Ujfq8XdsjeNPyBZPVFCs2Dg=;
 b=BXEDj7Wd4asHlIwelHT1BsGZfUAVKaqqbbYkHVtLXSj7m/BqUnyswbsCLTERcICrUm
 jKFEio+ujDRcSKSBmGJPCwfT3H8UgRayemDfnWblEvN1yP5QkY8sD40BJFl9txDrd2au
 371v+xS6KkEjyILj7abiv9Gz/2vwwnx+fJUwS8jWP8w7jRidoZwotsKbCiKes6pQaWoP
 ePaxdVRL0RUZfr11ynP1KKv9aO1KpPOHxxD69cE9A/ZoEGDm/rQuJpMjej81zBJOxMAE
 YuN1uwc1VixQs7u6vYw/var5kHorIlMoZSv2WdzVtyfxIi/fHCd45HrVL9KcDNqmJmjp
 AR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790392469; x=1790997269;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ZLU6BIDOq8PheYVMT28Ujfq8XdsjeNPyBZPVFCs2Dg=;
 b=VRRO1Qs9clO7sF9KJS7/pUnO34wATNd9A6dTiU6sr96TMwO+ZAlfZVceoFr4kv3zet
 yuZg5NqUIsWIa5Ro+QXYlw+yjmreX2up1yvUpfjzMxCC3rV3uOGNZ+trvX6BoNNBIfJj
 aP08rNO3FTcyfvp0dYy7cSl5Pl8CJ5MdZwAufK82D8/P6Oe2yHKeIz7hKnKSNK+Uteub
 womUqZGxG0QcheDsl5s4AviTGV+uXiQcYm/Knmb22QUPqJgJTU6YJ9ke5Qju6IxtDF3U
 oPMTSC5n7G4PLJKuVnZkpkJEYfCrGmu0X5l3yl1EDfy8z7sCiW2ouczW4ccgubWn6eFp
 S36w==
X-Gm-Message-State: AFq9FYJxOLX5Hm2PC+UMX6kJQLmIrOsanelY8EQqi/EHCL27mi875YMV
 X9dTk4Skafs+ruYKWczFI0v6N+uS0TqjhAABKGVm3VoBkISQpAs047URLyKiBpDVdS+k7KNaHzj
 juv44i+69ZHXV5AjSPctkQH6HnydsKkw=
X-Gm-Gg: AYBFou25ws9y21/3K6eiOLZ8M1hHma4luIgTgQNJbE7yVzSuQM62uQSNw/TvH2u1oh/
 JpZkTVsQpI3//YvLbXzWVRNTG+y5utiU+7fJAdOPMZ0qO05Jxk2LHxovtTeKsBOVwE7MSM5whl8
 thLqWllaXy129pLyWXkrGL9VwEOhJtCCC/fACc+uVolbHllVNCDD3VgL64zqls+9Q1kzptL5+9C
 7HEaOhXSDpSZOT8Y0Yr9gaNZlpWSdgySzdGjUiPuAF+q9C5m9F+w9GeOh6N0T+yxYFluDLYknFD
 c9KqlSKxG+CU4owsiyBkfX1rF5w+ow6yFVBXXmBsQTqdpdkjI2ltdQ3oye/g8gIGS+UWn1lfaov
 ZnM0m/jEn3VjPPqY=
X-Received: by 2002:a05:690e:d0d:b0:674:139f:243e with SMTP id
 956f58d0204a3-674139f2b18mr1571563d50.84.1790392469420; Fri, 25 Sep 2026
 20:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260904155758.3833179-1-bin.meng@processmission.com>
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 26 Sep 2026 11:14:16 +0800
X-Gm-Features: AclHuK_diIzqWCiekyHK1DG-C3IIiXE-DxP_nr_BKr9utJCSJ-dEZlOv1BAW5CU
Message-ID: <CAEUhbmVjC0JWk+LdM-Cy5mwppg_oZG2AQ_EC7Re=qzJ4XDebyA@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] hw/riscv: Restore Microchip PolarFire SoC Icicle
 Kit firmware boot
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Thomas Huth <thuth@redhat.com>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 4, 2026 at 11:58=E2=80=AFPM Bin Meng <bin.meng@processmission.c=
om> wrote:
>
>
> The microchip-icicle-kit machine was originally validated with an older
> Hart Software Services (HSS) firmware stack. HSS v2024.06 cannot boot
> through U-Boot to Linux because several firmware-visible parts of the
> PolarFire SoC are missing or incomplete.
>
> The first failure occurs before the UART is initialized because the L2
> zero window is not mapped. HSS then needs additional L2 cache controller
> and DDR training behavior. Later boot stages exercise system services,
> the RTC, SDHC version 4 DMA, and high-capacity SD card block sizing,
> along with the complete DDR aliases. The existing models ither reject
> these accesses or expose behavior that does not match the hardware
> specifications.
>
> This series restores the complete firmware boot flow. With these
> changes, QEMU boots the HSS v2024.06 eNVM image, loads its U-Boot
> payload from an SD card, and reaches the Buildroot 2026.05 Linux
> login prompt.
>
> The changes are organized around the firmware boot sequence:
>
> * Correct the L2-LIM size, map the L2 zero window, and provide the DMC
>   status transitions required by HSS DDR initialization.
> * Model the documented L2CC Config, WayEnable, and WayMask registers,
>   and resize L2-LIM as cache ways are enabled.
> * Complete SDHCI version 4 support used by the Cadence controller,
>   including Host Control 2, SDMA system addressing, 64-bit ADMA2
>   descriptors, and SDMA boundary continuation.
> * Run ADMA from a bounded timer-driven engine instead of performing work
>   from command or unrelated MMIO accesses.  This keeps DMA progress
>   independent of guest register traffic and avoids consuming a polling
>   deadline inside the command write.
> * Keep SDHC and SDXC memory transfers at their fixed 512-byte block
>   size, and advertise the Cadence controller's 64-bit system bus
>   support.
> * Add the PolarFire SoC serial-number system service and RTC, and honor
>   the system-service notification control bit.
> * Correct the DDR aliases and fix the board topology at its physical
>   configuration of 2 GiB of RAM and five harts.
> * Document direct and HSS boot, add focused qtests and a full firmware
>   functional test, and restore the machine's Supported maintainer
>   status.
>
> Testing performed:
>
> * Built qemu-system-riscv64 and the documentation.
> * Passed various newly added qtests.
> * Booted HSS v2024.06, U-Boot, and Buildroot 2026.05 Linux to the login
>   prompt using the functional-test image.
>
> The functional test downloads this versioned image archive:
>
> https://github.com/processmission/qemu-machine-images/releases/download/
> v1.0.0/riscv64-microchip-icicle-kit-v1.0.0.tar.zst
>
> When restoring the HSS boot support, 3 potential bugs were identified in
> the upstream HSS source codes that either blocks the DDR training from
> succeed or traps in a multi-core race at the very beginning or after
> a succesfully DDR training but stuck at OpenSBI/U-Boot hand-off. There
> are already bug reports filed aginst various upstream projects.
>
> Changes in v2:
> - Use the Resettable API instead of a legacy reset handler
> - tests/qtest: add Cadence SDHCI ADMA pacing/MMIO reproducer
> - Assert bounded ADMA pacing and MMIO-independent progress
> - Reuse existing SDHCI definitions and command helpers
> - Verify transferred data against a known image pattern
> - Make 64-bit system bus support a device property
> - hw/riscv: pfsoc: Enable 64-bit SDHCI system bus support
> - Reset the RTC to the documented hardware values
> - Expect the documented hardware state after RTC reset
> - MAINTAINERS: Move Conor Dooley to PolarFire SoC reviewer
> - Drop sdhci patches that are already merged
>
> Bin Meng (23):
>   hw/riscv: pfsoc: Correct the L2LIM maximum mapped size
>   hw/riscv: pfsoc: Map the L2 zero device window
>   hw/misc: pfsoc: Support DDR training with newer HSS
>   hw/misc: pfsoc: Model L2 cache controller registers
>   hw/riscv: pfsoc: Couple L2CC to L2-LIM
>   tests/qtest: Add PolarFire SoC L2CC coverage
>   hw/sd: sdhci: Run ADMA independently of MMIO
>   hw/sd: sd: Keep high-capacity memory blocks at 512 bytes
>   hw/sd: cadence: Add 64-bit system bus property
>   hw/riscv: pfsoc: Enable 64-bit SDHCI system bus support
>   hw/misc: pfsoc: Model PolarFire SoC serial number service
>   hw/rtc: Add PolarFire SoC RTC model
>   hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
>   tests/qtest: Add PolarFire SoC RTC coverage
>   hw/misc: pfsoc: Honor PolarFire service notification requests
>   hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
>   hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
>   hw/riscv: pfsoc: Fix Icicle Kit hart count at five
>   docs/system/riscv: Document Icicle Kit HSS boot
>   docs/system/riscv: pfsoc: Document CLINT topology for direct Linux
>     boot
>   tests/functional/riscv64: Add Icicle Kit firmware boot test
>   MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer
>   MAINTAINERS: Move Conor Dooley to PolarFire SoC reviewer
>
> Wadim Mueller (1):
>   tests/qtest: add Cadence SDHCI ADMA pacing/MMIO reproducer
>
>  MAINTAINERS                                   |  13 +-
>  docs/system/riscv/microchip-icicle-kit.rst    | 129 ++++-
>  include/hw/misc/mchp_pfsoc_dmc.h              |   6 +
>  include/hw/misc/mchp_pfsoc_ioscb.h            |   8 +
>  include/hw/misc/mchp_pfsoc_l2cc.h             |  31 ++
>  include/hw/riscv/microchip_pfsoc.h            |   7 +
>  include/hw/rtc/mchp_pfsoc_rtc.h               |  46 ++
>  include/hw/sd/cadence_sdhci.h                 |   1 +
>  hw/misc/mchp_pfsoc_dmc.c                      | 273 +++++++++-
>  hw/misc/mchp_pfsoc_ioscb.c                    | 174 ++++++-
>  hw/misc/mchp_pfsoc_l2cc.c                     | 231 +++++++++
>  hw/misc/mchp_pfsoc_sysreg.c                   |   9 +-
>  hw/riscv/microchip_pfsoc.c                    |  94 ++--
>  hw/rtc/mchp_pfsoc_rtc.c                       | 477 ++++++++++++++++++
>  hw/sd/cadence_sdhci.c                         |  11 +
>  hw/sd/sd.c                                    |  43 +-
>  hw/sd/sdhci.c                                 | 143 ++++--
>  tests/qtest/cadence-sdhci-test.c              | 282 +++++++++++
>  tests/qtest/mchp_pfsoc_l2cc_test.c            | 221 ++++++++
>  tests/qtest/mchp_pfsoc_rtc_test.c             | 315 ++++++++++++
>  hw/misc/Kconfig                               |   3 +
>  hw/misc/meson.build                           |   1 +
>  hw/riscv/Kconfig                              |   2 +
>  hw/rtc/Kconfig                                |   3 +
>  hw/rtc/meson.build                            |   1 +
>  tests/functional/riscv64/meson.build          |   2 +
>  .../riscv64/test_microchip_icicle_kit.py      |  56 ++
>  tests/qtest/meson.build                       |   6 +
>  28 files changed, 2429 insertions(+), 159 deletions(-)
>  create mode 100644 include/hw/misc/mchp_pfsoc_l2cc.h
>  create mode 100644 include/hw/rtc/mchp_pfsoc_rtc.h
>  create mode 100644 hw/misc/mchp_pfsoc_l2cc.c
>  create mode 100644 hw/rtc/mchp_pfsoc_rtc.c
>  create mode 100644 tests/qtest/cadence-sdhci-test.c
>  create mode 100644 tests/qtest/mchp_pfsoc_l2cc_test.c
>  create mode 100644 tests/qtest/mchp_pfsoc_rtc_test.c
>  create mode 100644 tests/functional/riscv64/test_microchip_icicle_kit.py
>
> ---
> base-commit: d2843fbf80260e4346c856819e8cea11768c9d0e
> branch: icicle-kit
>
> --

Ping for review?

