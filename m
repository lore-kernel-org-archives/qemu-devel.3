Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2ABCF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPO-0001ah-7A; Mon, 23 Sep 2024 05:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPM-0001Wt-CE; Mon, 23 Sep 2024 05:31:04 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPK-0006wU-J0; Mon, 23 Sep 2024 05:31:04 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8d24f98215so558139566b.1; 
 Mon, 23 Sep 2024 02:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083859; x=1727688659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JV0fe214eWya3VLAdHWiH6CiRck5Drm7MecD1y0pT1U=;
 b=e9GvLZ0qHnqS4S0CgThpn0l1J4H06O1t7Huf6HYUBAxyK7+LW70n4zwe9FyNVb/C8t
 J5Ml1ibuCCcbWEryBWzh7PzNhRcNF+s1WhqzmuqsKd3rZvGkX/Wd0Nt8LjK6yI6Ij0sq
 08LPUs/Db7fAMSkg+/mdN82VNZjqIDwW0db6VDcu5Qxcv/UDZBwzvj3HpjCdqx1p7aHi
 WYJBzIM19cdoZJOb8kGyfbRjHsR4VfQE145YdwPrAGHUAhAiMr9g6CTqv2ksk6Y1Aw9+
 8US12uuabNcMPt1Na2PF87mBl2F/H5hXy+uw5gkgMZGRZd17rLRKoBo9ZQ4ngdEoBX8Y
 qMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083859; x=1727688659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JV0fe214eWya3VLAdHWiH6CiRck5Drm7MecD1y0pT1U=;
 b=S6Ry13IOZiNpq03ZPW4gUUiZF5q0RJ0aY+YjUzAb4uCkWBDg+tUX6bOPuLLBJuMddX
 sB/tig5Qwjd2/lQvCkrc5JsVJV/nupRmR1M5NayrluVnw6Veys93zIhQ2isPkPwoQMJd
 dopPShu0dZpA7bd/aBfMooF1cYkNa9MB57nulqxkYDIftQbAlldIxiFkTelF9viKiBbx
 cGKbEF5iduar8ctEX95pjFGwZqXTJSGaLqVQKgKh685sZlP5VmiMmudh+EjOHsujq/hW
 9/ogo8EmlubemrYXcWdoiM8bi7GwqC/DuridHItPmBRAv6sOAFVvy1ybF4yY6kSmN24O
 k2pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnxXyzx1MVkBrJfoGqen0WN6+mYk1T26hxXIUGXHtoI9Oh3WlxtbQJS+BEqRNX6Fyf3kApAnRD2uY=@nongnu.org,
 AJvYcCWCChhqiHJK92TgsH2/iCim91KfZDIOR1F+vxzSpkcZpwSnCjF2waGjRvP+GllG85C1695lJipYo0IL@nongnu.org
X-Gm-Message-State: AOJu0Ywy2TFVAN0iCBNHXrJwGRHMq0i3ie4sUp4V1AAhIc6ak0hFNgNr
 LIxtqcLbqRy2hv4i7DZfefSV6vpvXbVi+zqPNcsKnlWZw96J+X72MqWH7Q==
X-Google-Smtp-Source: AGHT+IEAQKaHnzdMkLbwW/Zq3uAWWGFJ3n3C9cbcspfWrnGZE95cFlHk0TQMp7ik1HnAke4+JXFGGg==
X-Received: by 2002:a17:907:3f25:b0:a8a:ead3:8515 with SMTP id
 a640c23a62f3a-a90d514a83fmr1115692566b.65.1727083859022; 
 Mon, 23 Sep 2024 02:30:59 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:30:58 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 00/23] E500 Cleanup
Date: Mon, 23 Sep 2024 11:29:53 +0200
Message-ID: <20240923093016.66437-1-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
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
[1] https://github.com/shentok/qemu/tree/e500-fdt=0D
=0D
Bernhard Beschow (23):=0D
  hw/ppc/e500: Do not leak struct boot_info=0D
  hw/ppc/e500: Reduce scope of env pointer=0D
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
 MAINTAINERS              |   2 +-=0D
 hw/ppc/e500-ccsr.h       |   2 +=0D
 hw/ppc/e500.h            |   8 +++=0D
 hw/block/pflash_cfi01.c  |  21 +++----=0D
 hw/gpio/mpc8xxx.c        |  22 +++-----=0D
 hw/i2c/mpc_i2c.c         |  29 +++++-----=0D
 hw/i2c/smbus_eeprom.c    |  19 +++----=0D
 hw/net/fsl_etsec/etsec.c |  22 +++-----=0D
 hw/pci-host/ppce500.c    |  54 ++++++++----------=0D
 hw/ppc/e500.c            |  61 +++++---------------=0D
 hw/ppc/mpc8544_guts.c    |  32 +++++++----=0D
 hw/ppc/ppce500_ccsr.c    |  67 ++++++++++++++++++++++=0D
 hw/rtc/ds1338.c          |  20 +++----=0D
 hw/sd/sdhci.c            |  62 +++++++++-----------=0D
 hw/usb/hcd-ehci-sysbus.c | 118 +++++++++++++++++----------------------=0D
 hw/vfio/platform.c       |   7 +--=0D
 hw/i2c/trace-events      |   5 ++=0D
 hw/intc/Kconfig          |   4 ++=0D
 hw/intc/meson.build      |   3 +-=0D
 hw/ppc/meson.build       |   1 +=0D
 hw/ppc/trace-events      |   3 +=0D
 21 files changed, 285 insertions(+), 277 deletions(-)=0D
 create mode 100644 hw/ppc/ppce500_ccsr.c=0D
=0D
-- =0D
2.46.1=0D
=0D

