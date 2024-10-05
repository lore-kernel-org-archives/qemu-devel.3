Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB37CCFB42D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAk0-0005FN-Mx; Sat, 05 Oct 2024 15:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAjy-0005EP-HF; Sat, 05 Oct 2024 15:46:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAjw-0007c3-S2; Sat, 05 Oct 2024 15:46:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37cc5fb1e45so2265158f8f.2; 
 Sat, 05 Oct 2024 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157614; x=1728762414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QW8k5SmLFZkwpDcvisrwWksWH/17h7EZsOkbMCPDoEA=;
 b=XhI8C9vq3RT3lNwbLhMgmOFbB2untx2qtKAKIe131EutPcWBTsURlGxV7Bw9cOEIg8
 fExWR4gzwJg73p7q7ccmLWRnYUaz3DqmQBXaabywAu+i+i+ueyfuBGFhdZijjJ1/HTaH
 amXV0AwHSbJk6xT8xAtbu3wJwxj8Q3V3wlH1gIJzZWIAopbo7OW9urvBPCLXTmgOF3jN
 x8cYQBoMVl73mb9oyrhJp5D50zhloWBZvt4HWq5plFesDK4bfG0J1Dvcycn3oY4lOS2q
 ZvG/El5rDKqQblmBuF4gKanNFVA3SaBqR+fCn0+hLI2k2+ln31fyudksqJRxCnb/u73J
 QB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157614; x=1728762414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QW8k5SmLFZkwpDcvisrwWksWH/17h7EZsOkbMCPDoEA=;
 b=V7gv54ZboY9RbAvQoyr+3UcH50AglqyEYf7WDPABlZ2pJ8Y6dzb97yx6SoGQwXxMQh
 NulgQkvTx0JIEEiQrnq2M45aM2xjXYengz7phjl9mUt25kDDaoAQYVTPnTRJyucA/9oq
 jtMtBXRrDHg4EWJeUvMON0tQI+Kr8oCCdq+vts7621guMkusJCccKYegRqilArJeatWb
 Svi09mF48l9BS9D8H1NWr5FdCOxcUFkPQpZvPPDxcmWhjP5LcNhfkbYamKJI8+j/NcOR
 QwUUDaGc3wtRhM6RIUmz0MRGqlI6SHssYpOLK9Q0G8+Wz19+w4aCg7uh4dzDjAfhBV+z
 5Aqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe5nUAp76a50Geidlxf7K3zZCT6L4B45eHQ2SboNoAD+f2VE8R2+Nytd/FRblo9sXx+vV5WcISCil5@nongnu.org,
 AJvYcCWqVDCaIyAvjY9VkeAmOf0I2rOCJeZTTG2pJpeAbijIsTcJt175GEC/u9SAqDyfhAUGSwtd4KVQHAI=@nongnu.org
X-Gm-Message-State: AOJu0YxX/nvZv5AOBgY/WA8voPwIyADUZ6zpIt1s4OgTwzsZMyojp5Re
 kT+jQDLI0GihjXm3l0qLld1dJPMrIC4U11MJw7S+fagDdpektHmk0wh6Ig==
X-Google-Smtp-Source: AGHT+IEEN33eQMcf3xQdlUYJioNbcEUKlRZzx6umhDyR3ZAOGid9UbuzK7gjvmRBhtXOaqQKEasQug==
X-Received: by 2002:a5d:6448:0:b0:37c:c80c:a6aa with SMTP id
 ffacd0b85a97d-37d0e6f000cmr3737345f8f.15.1728157612995; 
 Sat, 05 Oct 2024 12:46:52 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:46:52 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 00/23] E500 Cleanup
Date: Sat,  5 Oct 2024 21:45:40 +0200
Message-ID: <20241005194603.23139-1-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
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
v2:=0D
* Add R-b tags (Cedric, Zoltan -- thanks!)=0D
* Add missing S-o-b tag to ds1338 patch (Cedric)=0D
* Populate POR PLL ratio status register with real-world values (Zoltan)=0D
* Rephrase one commit message (Zoltan)=0D
* Also rename header of ppce500_ccsr to match struct name=0D
* Don't mention ppc440_bamboo in license since unrelated (Zoltan)=0D
* Various style changes (Zoltan)=0D
=0D
[1] https://github.com/shentok/qemu/tree/e500-fdt=0D
=0D
Bernhard Beschow (23):=0D
  hw/ppc/e500: Do not leak struct boot_info=0D
  hw/ppc/e500: Remove firstenv variable=0D
  hw/ppc/e500: Prefer QOM cast=0D
  hw/ppc/e500: Remove unused "irqs" parameter=0D
  hw/ppc/e500: Add missing device tree properties to i2c controller node=0D
  hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal=0D
    resources=0D
  hw/ppc/e500: Extract ppce500_ccsr.c=0D
  hw/ppc/ppce500_ccsr: Log access to unimplemented registers=0D
  hw/ppc/mpc8544_guts: Populate POR PLL ratio status register=0D
  hw/i2c/mpc_i2c: Convert DPRINTF to trace events for register access=0D
  hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro=0D
  hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE define=0D
  hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro=0D
  hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro=0D
  hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro=0D
  hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro=0D
  hw/intc: Guard openpic_kvm.c by dedicated OPENPIC_KVM Kconfig switch=0D
  hw/sd/sdhci: Prefer DEFINE_TYPES() macro=0D
  hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro=0D
  hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro=0D
  hw/rtc/ds1338: Prefer DEFINE_TYPES() macro=0D
  hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro=0D
  hw/vfio/platform: Let vfio_start_eventfd_injection() take=0D
    VFIOPlatformDevice pointer=0D
=0D
 MAINTAINERS                            |   2 +-=0D
 hw/ppc/e500.h                          |   9 +-=0D
 hw/ppc/{e500-ccsr.h =3D> ppce500_ccsr.h} |   8 +-=0D
 hw/block/pflash_cfi01.c                |  21 ++---=0D
 hw/gpio/mpc8xxx.c                      |  22 ++---=0D
 hw/i2c/mpc_i2c.c                       |  29 +++---=0D
 hw/i2c/smbus_eeprom.c                  |  19 ++--=0D
 hw/net/fsl_etsec/etsec.c               |  22 ++---=0D
 hw/pci-host/ppce500.c                  |  54 +++++------=0D
 hw/ppc/e500.c                          |  65 ++++----------=0D
 hw/ppc/mpc8544_guts.c                  |  32 ++++---=0D
 hw/ppc/ppce500_ccsr.c                  |  64 ++++++++++++++=0D
 hw/rtc/ds1338.c                        |  20 ++---=0D
 hw/sd/sdhci.c                          |  62 ++++++-------=0D
 hw/usb/hcd-ehci-sysbus.c               | 118 +++++++++++--------------=0D
 hw/vfio/platform.c                     |   7 +-=0D
 hw/i2c/trace-events                    |   5 ++=0D
 hw/intc/Kconfig                        |   4 +=0D
 hw/intc/meson.build                    |   3 +-=0D
 hw/ppc/meson.build                     |   1 +=0D
 hw/ppc/trace-events                    |   3 +=0D
 21 files changed, 285 insertions(+), 285 deletions(-)=0D
 rename hw/ppc/{e500-ccsr.h =3D> ppce500_ccsr.h} (71%)=0D
 create mode 100644 hw/ppc/ppce500_ccsr.c=0D
=0D
-- =0D
2.46.2=0D
=0D

