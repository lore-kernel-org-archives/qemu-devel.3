Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726FFC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYwC-0000Uh-C6; Mon, 26 Feb 2024 06:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwB-0000U4-6i
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:23 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYw9-0008QY-2F
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:22 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d09cf00214so46195131fa.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946059; x=1709550859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7XB/ZyRFfn+958+Q6PUd5FWmB6iBcVL88J1E1ITJE1Q=;
 b=ngtRe3XGHF4oRHXoaQEwybmG+qmniD+A3qReGfJ4hoSIhpH/3guXy+ZUdWe8VzcZGn
 JrjC/X7bBeP+1+dVz9BsLFs1OiBY44OBVlcrV4pNN5Gctd+DRASfCqeInm/Jo98TSrK+
 ho41rqXmUM8ze7Nb9HtF3cSroxjYtqGsHoNCJtLJ8hJ09DW/O8RhuA8MVnk31NAUM1kU
 k6siOuOMDplfkQwDoXF5l6c0cSJvKi/X+3nGdFRaIrTQEAXWxJkmALrWiXxtFnxGFnRE
 lfZT1F3G4LHmdI7YuJKMW4S3bssWtDd6chHJgLo4bz7GoEOjKfKoqLgV7hKO/sMbAvHD
 rd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946059; x=1709550859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7XB/ZyRFfn+958+Q6PUd5FWmB6iBcVL88J1E1ITJE1Q=;
 b=e/TeMONJnT1pRJ0FGYYclYvgPxrqOzsaCNxDp16g/ZWHQCG7zUTDrgHiJJxpjST1ZQ
 Lyay+hOM/7A59eO0+vc8KDKlHCTzQVXouzkT//iEnr8KoxA1Wijt3NmzaNxQRkHBnSzW
 EkB69BnlJaIdSNDNj1jwOBH8a5YhNKmZdGbBTx3rbTYbH5ld5Knduw6ApgzKI7Lk9/e9
 vbkE4WbHsJExoR/Kk193civxQH00pV2qmxqABZrJ605qrzbioNa7RwpmjOiYWar39aq8
 kNHbpxDrshKeyy2uu2yf/LJYJXy3dmDrRlJh1Tc6jIZZ7RSra/DTJic+Avs8HJmn5FYk
 Jc6w==
X-Gm-Message-State: AOJu0YxcLOQoT9U1h4sZisxyTY/HA3hih/9vH14iroN8xsWsSBnxR2gs
 lt2SYT0Kfk771EEYyscrPorrQ4UugHOXU30nTGR2JR7+yTR0/TwwOL5+f9E66Vxo24GFosPnF2I
 1
X-Google-Smtp-Source: AGHT+IGrivj9MMHAnrEyxzdfRuSmI0t5SZPSqRN1khSQinJflV74KNbZBRKhCUqIXlfwBuPmZobATA==
X-Received: by 2002:a2e:be89:0:b0:2d2:5430:605a with SMTP id
 a9-20020a2ebe89000000b002d25430605amr4977757ljr.7.1708946059092; 
 Mon, 26 Feb 2024 03:14:19 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 bj20-20020a0560001e1400b0033db0c866f7sm8064485wrb.11.2024.02.26.03.14.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:14:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/15] hw/southbridge: Extract ICH9 QOM container model
Date: Mon, 26 Feb 2024 12:13:59 +0100
Message-ID: <20240226111416.39217-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since v1 [1]:
- Rebased on top of Bernhard patches
- Rename files with 'ich9_' prefix (Bernhard)

Hi,

I have a long standing southbridge QOM rework branches. Since
Bernhard is actively working on the PIIX, I'll try to refresh
and post. This is also motivated by the Dynamic Machine work
where we are trying to figure the ideal DSL for QEMU, so having
complex models well designed help.

Here we introduce the ICH9 'southbridge' as a QOM container.
Since the chipset comes as a whole, we shouldn't instantiate
its components separately. However in order to maintain old
code we expose some properties to configure the container and
not introduce any change for the Q35 machine. There is no
migration change, only QOM objects moved around.

More work remain in the LPC function (more code to remove from
Q35). Maybe worth doing in parallel with the PIIX to clean both
PC machines.

Also we'd need to decouple the cpu_interrupt() calls between hw/
and target/.

Note that GSI is currently broken [2]. Once the LPC/ISA part is
done, it might be easier to fix it.

[1] https://lore.kernel.org/qemu-devel/20240219163855.87326-1-philmd@linaro.org/
[2] https://lore.kernel.org/qemu-devel/cd0e13c6-c03d-411f-83a5-1d4d28ea4345@linaro.org/

Philippe Mathieu-Daudé (15):
  MAINTAINERS: Add 'ICH9 South Bridge' section
  hw/i386/q35: Add local 'lpc_obj' variable
  hw/acpi/ich9: Restrict definitions from 'hw/southbridge/ich9.h'
  hw/acpi/ich9_tco: Include 'ich9' in names
  hw/acpi/ich9_tco: Restrict ich9_generate_smi() declaration
  hw/ide: Rename ich.c -> ich9_ahci.c
  hw/i2c/smbus: Extract QOM ICH9 definitions to 'ich9_smbus.h'
  hw/pci-bridge: Extract QOM ICH definitions to 'ich9_dmi.h'
  hw/southbridge/ich9: Introduce TYPE_ICH9_SOUTHBRIDGE stub
  hw/southbridge/ich9: Add the DMI-to-PCI bridge
  hw/southbridge/ich9: Add a AHCI function
  hw/southbridge/ich9: Add the SMBus function
  hw/southbridge/ich9: Add the USB EHCI/UHCI functions
  hw/southbridge/ich9: Extract LPC definitions to 'hw/isa/ich9_lpc.h'
  hw/southbridge/ich9: Add the LPC / ISA bridge function

 MAINTAINERS                               |  21 +-
 include/hw/acpi/ich9.h                    |  15 ++
 include/hw/acpi/ich9_tco.h                |   6 +-
 include/hw/i2c/ich9_smbus.h               |  25 +++
 include/hw/isa/ich9_lpc.h                 | 166 +++++++++++++++
 include/hw/pci-bridge/ich9_dmi.h          |  20 ++
 include/hw/southbridge/ich9.h             | 235 +---------------------
 hw/acpi/ich9.c                            |   9 +-
 hw/acpi/ich9_tco.c                        |   5 +-
 hw/i2c/{smbus_ich9.c => ich9_smbus.c}     |  36 +++-
 hw/i386/acpi-build.c                      |   1 +
 hw/i386/pc_q35.c                          | 126 +++---------
 hw/ide/{ich.c => ich9_ahci.c}             |   0
 hw/isa/{lpc_ich9.c => ich9_lpc.c}         |  37 +++-
 hw/pci-bridge/{i82801b11.c => ich9_dmi.c} |  11 +-
 hw/southbridge/ich9.c                     | 213 ++++++++++++++++++++
 tests/qtest/tco-test.c                    |   2 +-
 hw/Kconfig                                |   1 +
 hw/i2c/meson.build                        |   2 +-
 hw/i386/Kconfig                           |   3 +-
 hw/ide/meson.build                        |   2 +-
 hw/isa/meson.build                        |   2 +-
 hw/meson.build                            |   1 +
 hw/pci-bridge/meson.build                 |   2 +-
 hw/southbridge/Kconfig                    |  11 +
 hw/southbridge/meson.build                |   3 +
 26 files changed, 587 insertions(+), 368 deletions(-)
 create mode 100644 include/hw/i2c/ich9_smbus.h
 create mode 100644 include/hw/isa/ich9_lpc.h
 create mode 100644 include/hw/pci-bridge/ich9_dmi.h
 rename hw/i2c/{smbus_ich9.c => ich9_smbus.c} (77%)
 rename hw/ide/{ich.c => ich9_ahci.c} (100%)
 rename hw/isa/{lpc_ich9.c => ich9_lpc.c} (95%)
 rename hw/pci-bridge/{i82801b11.c => ich9_dmi.c} (95%)
 create mode 100644 hw/southbridge/ich9.c
 create mode 100644 hw/southbridge/Kconfig
 create mode 100644 hw/southbridge/meson.build

-- 
2.41.0


