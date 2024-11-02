Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB3FE677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E0a-00032h-Hz; Sat, 02 Nov 2024 09:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0U-00031d-IH; Sat, 02 Nov 2024 09:17:35 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0S-0001vI-Mm; Sat, 02 Nov 2024 09:17:34 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so335508566b.1; 
 Sat, 02 Nov 2024 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553449; x=1731158249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1zEI3lJSZSmhyWsVdXw4fUtvgV0geugfUic5JJ+BzKM=;
 b=aadotZwN/jHGgm4GkNOTKEDJlNQoa9BHn+RMrxrfEQlfD0l7bsqLeiqCuxaJcU/Gz5
 aNsmMZLlN5C6g/hpuofUnKtIr0LkJMFoY6klggA1Zs3CNScpHHni6Zva1pNzIKvtnb/J
 6NT9D1ttc2B6eRnomqqMMrW9ZCd5bHWVzZI0NUNB7pArKJ9X3sRLEVSG9cXRWAxKEH17
 A2QptynpeDNNMVUNfSPeXaDepGOJ8xFFT1H+ZXOYQ7M+3jjxfdKXvkbpZYi7+Pm/Zv+h
 2pEQVYcMQek55+cfl6Sj7ME66BQCWKgRNLXaYmzd16g/HCgUNj8tfjcZE7i4kcOGBu0T
 3Yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553449; x=1731158249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1zEI3lJSZSmhyWsVdXw4fUtvgV0geugfUic5JJ+BzKM=;
 b=mDTI01X3l9Mncdsqi0ygu0Dw36swLDfpeK+PEyTtomt2ChUIobAeTfYXDgujiXOQ/b
 kNsGhNYCUQZ2Jq4/BCpse7769PFtGsL2/kM6DaMYaqIhj2pTgWNaiD/DHRmMd9Pc/JNl
 xZXtXOR6PN8FDsFduqm3nO4Ljj3PKqrbCBkLQdsgb3WCgPGqPhsJMCcgTqX7Y0jkiZpO
 eGkPbFibWloU9AcJ1V69Iq1Oalrx4BDkma/z7Zd/7eNAOgO04dNiiEXlpx/vRym4IQJx
 SX9YPSu0C3rYwMwqFsPMbnPU8rg+st5T5sQNoP9s5rVkeKYyahuZx+yyQeiC+7VXvXbO
 VO6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyKhmhxQmbvrAoropHQRH1664hNdEWSr7fO8zRhTsRuiuAWWWMHW0RK7c8AHAyO2qWHlOTvvFq8j0n@nongnu.org,
 AJvYcCXTlbCkB2kH/8oQR540e+YUD/i4yOFXmg4W9Hc5UW1gMAfmpNpHMGXTsd9FBDXqarwIVeQyRFdZDzU=@nongnu.org
X-Gm-Message-State: AOJu0YyXEhqxPh1UnzeO7tbbFej3mCvjgZd2PXhdtQ9IPMmVzDazaKs9
 fNHm8BTxLFhmmbVxDn8lcsETmcgNfcLJ4U3CVw1QxsR8mpEXl28mvmmNHw==
X-Google-Smtp-Source: AGHT+IEONsDM//JpDGyxiNz2qqKA9rflM64+LO+iipXuS85SWvvksZLM0bpVQximVBIO0U9EzYGuOg==
X-Received: by 2002:a17:907:2d8e:b0:a9a:3705:9ad9 with SMTP id
 a640c23a62f3a-a9e50b95730mr839341266b.50.1730553449013; 
 Sat, 02 Nov 2024 06:17:29 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:28 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 00/26] E500 Cleanup
Date: Sat,  2 Nov 2024 14:16:49 +0100
Message-ID: <20241102131715.548849-1-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series is part of a bigger series exploring data-driven machine creati=
on=0D
using device tree blobs on top of the e500 machines [1]. It contains patche=
s to=0D
make this exploration easier which are also expected to provide value in=0D
themselves.=0D
=0D
The cleanup starts with the e500 machine class itself, then proceeds with=0D
machine-specific device models and concludes with more or less loosely rela=
ted=0D
devices. Device cleanup mostly consists of using the DEFINE_TYPES() macro.=
=0D
=0D
v3:=0D
* Pick up R-B tags (Kevin, Zoltan -- thanks!)=0D
* Rely on trace events only and drop unimp logging in CCSR space after=0D
  discussion=0D
* Merge https://patchew.org/QEMU/20241005100228.28094-1-shentey@gmail.com/ =
since=0D
  ARM now mostly unaffected=0D
* Add patch to reuse MII constants in etsec device=0D
=0D
Testing done:=0D
* Build qemu_ppc64_e5500_defconfig in Buildroot, run it in the ppce500 mach=
ine=0D
  and issue the `poweroff` command. Observe that QEMU is shut down cleanly.=
=0D
=0D
v2:=0D
* Add R-b tags (Cedric, Zoltan -- thanks!)=0D
* Add missing S-o-b tag to ds1338 patch (Cedric)=0D
* Populate POR PLL ratio status register with real-world values (Zoltan)=0D
* Rephrase one commit message (Zoltan)=0D
* Also rename header of ppce500_ccsr to match struct name=0D
* Don't mention ppc440_bamboo in license since unrelated (Zoltan)=0D
* Various style changes (Zoltan)=0D
=0D
Supersedes: 20241005100228.28094-1-shentey@gmail.com=0D
=0D
Bernhard Beschow (26):=0D
  hw/ppc/e500: Do not leak struct boot_info=0D
  hw/ppc/e500: Remove firstenv variable=0D
  hw/ppc/e500: Prefer QOM cast=0D
  hw/ppc/e500: Remove unused "irqs" parameter=0D
  hw/ppc/e500: Add missing device tree properties to i2c controller node=0D
  hw/ppc/e500: Reuse TYPE_GPIO_PWR=0D
  hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal=0D
    resources=0D
  hw/ppc/e500: Extract ppce500_ccsr.c=0D
  hw/ppc/ppce500_ccsr: Trace access to CCSR region=0D
  hw/ppc/mpc8544_guts: Populate POR PLL ratio status register=0D
  hw/i2c/mpc_i2c: Convert DPRINTF to trace events for register access=0D
  hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro=0D
  hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE define=0D
  hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro=0D
  hw/net/fsl_etsec/miim: Reuse MII constants=0D
  hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro=0D
  hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro=0D
  hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro=0D
  hw/intc: Guard openpic_kvm.c by dedicated OPENPIC_KVM Kconfig switch=0D
  hw/sd/sdhci: Prefer DEFINE_TYPES() macro=0D
  hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro=0D
  hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro=0D
  hw/rtc/ds1338: Prefer DEFINE_TYPES() macro=0D
  hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro=0D
  hw/vfio/platform: Let vfio_start_eventfd_injection() take=0D
    VFIOPlatformDevice pointer=0D
  MAINTAINERS: Add hw/gpio/gpio_pwr.c=0D
=0D
 MAINTAINERS                            |   3 +-=0D
 hw/ppc/e500.h                          |   9 +-=0D
 hw/ppc/{e500-ccsr.h =3D> ppce500_ccsr.h} |   8 +-=0D
 hw/block/pflash_cfi01.c                |  21 ++---=0D
 hw/gpio/mpc8xxx.c                      |  22 ++---=0D
 hw/i2c/mpc_i2c.c                       |  29 +++---=0D
 hw/i2c/smbus_eeprom.c                  |  19 ++--=0D
 hw/net/fsl_etsec/etsec.c               |  22 ++---=0D
 hw/net/fsl_etsec/miim.c                |  19 ++--=0D
 hw/pci-host/ppce500.c                  |  54 +++++------=0D
 hw/ppc/e500.c                          |  81 +++++------------=0D
 hw/ppc/mpc8544_guts.c                  |  32 ++++---=0D
 hw/ppc/ppce500_ccsr.c                  |  57 ++++++++++++=0D
 hw/rtc/ds1338.c                        |  20 ++---=0D
 hw/sd/sdhci.c                          |  62 ++++++-------=0D
 hw/usb/hcd-ehci-sysbus.c               | 118 +++++++++++--------------=0D
 hw/vfio/platform.c                     |   7 +-=0D
 hw/i2c/trace-events                    |   5 ++=0D
 hw/intc/Kconfig                        |   4 +=0D
 hw/intc/meson.build                    |   3 +-=0D
 hw/ppc/Kconfig                         |   1 +=0D
 hw/ppc/meson.build                     |   1 +=0D
 hw/ppc/trace-events                    |   3 +=0D
 23 files changed, 290 insertions(+), 310 deletions(-)=0D
 rename hw/ppc/{e500-ccsr.h =3D> ppce500_ccsr.h} (71%)=0D
 create mode 100644 hw/ppc/ppce500_ccsr.c=0D
=0D
-- =0D
2.47.0=0D
=0D

