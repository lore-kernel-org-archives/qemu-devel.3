Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D7FC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6fa-0001HA-07; Mon, 19 Feb 2024 11:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6fY-0001G6-Bq
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:04 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6fW-0002u4-EU
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:04 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4125df90568so15055675e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360739; x=1708965539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kTU8ttLQ0Q/QZTFMRvnUDY5Q7E85B92+i/v0dSrq/0k=;
 b=zZZIskw5aOq8cUd5eelBruas0cx90VuNe1fcGag/9y4DhL2CxbRAc2YbvndFqgYlvr
 Pu6DoKE036pK9ea4A07e+jxy7F404V5St1rFVYV4xkxgLnn9NlVnbBXpPYbTHonBhcau
 G4nW9NoOo3qIGGqYxiN9/Xkq3wnIwIjiS4U6qucn0z4w6XD59Ke02UAquc/vc4ZS20ys
 EHPqXcui+67GHWirvzo1QRrZ8ba4RcpnfMnVa3HEqBAYuGzPQ/1vhwXxriONx9A3tdr5
 sxtH+5VzNG75cRzckxlIoFsWHe9WlK4eta8YORkZn2hze9cjViAC9Ax4fVhmrfMfp+1d
 8aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360739; x=1708965539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kTU8ttLQ0Q/QZTFMRvnUDY5Q7E85B92+i/v0dSrq/0k=;
 b=vkSEYD1+NXE0pGrInPxsTP3zWT0VXzIh9FCoJ4ac0xLTQXUldjeCdFjM+CaRWgtV5c
 NkMLwjtOh/UyTEEfUXvinx4Twa5J5Nm/6a8RiuPQHuZysJRFvPUv8y9ULeXeh97Adqj7
 ADpU0oQfVm0iLscG3wLJc0CCosGJPEtZU3dcWQO1+8ph8E/4GZI/FhPqpkvmkXySjLzY
 BIJ1IHL585iE8yy2SVV6CtTttK9ak0eCpMb0s2yl9l65un2yQGZKMa4PCvIRBkC+oCCz
 xMuWYUBH/xwfvH/ESmMHUhjOoFqEZ1fGinqA6tm8V+/bIlK2NZsnVWYQ4nneRBztQHZU
 kiOA==
X-Gm-Message-State: AOJu0Yx0ZllRVLRfFeICDvxcl8dnoyM7QF0l4PL1l31M2/E7yo69jI9r
 cdgzkreptTGDYnk+sf5mHj8kKAFUOEb5abnSCKfW1ioeiqiWRUoH+ff5tPAmrYiYlg1nxtlvNR1
 S
X-Google-Smtp-Source: AGHT+IH7dcTn8XhdCeP8hGMxlC0FveKf6g0dovZdSVYZjKswOqkfFldbX2Z7rkCwNY/kknNacyapaQ==
X-Received: by 2002:a5d:66d2:0:b0:33d:13ea:cf39 with SMTP id
 k18-20020a5d66d2000000b0033d13eacf39mr6614537wrw.36.1708360739474; 
 Mon, 19 Feb 2024 08:38:59 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 r10-20020adfda4a000000b0033d3b8820f8sm5722396wrl.109.2024.02.19.08.38.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:38:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/14] hw/southbridge: Extract ICH9 QOM container model
Date: Mon, 19 Feb 2024 17:38:40 +0100
Message-ID: <20240219163855.87326-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Note that GSI is currently broken [1]. Once the LPC/ISA part is
done, it might be easier to fix it.

Based-on: <20240213043859.61019-1-philmd@linaro.org> [2]
Based-on: <20240219141412.71418-1-philmd@linaro.org> [3]

[1] https://lore.kernel.org/qemu-devel/cd0e13c6-c03d-411f-83a5-1d4d28ea4345@linaro.org/
[2] https://lore.kernel.org/qemu-devel/20240213043859.61019-1-philmd@linaro.org/ (USB)
[3] https://lore.kernel.org/qemu-devel/20240219141412.71418-1-philmd@linaro.org/ (AHCI)

Philippe Mathieu-Daudé (14):
  MAINTAINERS: Add 'ICH9 South Bridge' section
  hw/i386/q35: Add local 'lpc_obj' variable
  hw/acpi/ich9: Restrict definitions from 'hw/southbridge/ich9.h'
  hw/acpi/ich9_tco: Include 'ich9' in names
  hw/acpi/ich9_tco: Restrict ich9_generate_smi() declaration
  hw/pci-bridge: Extract QOM ICH definitions to 'ich_dmi_pci.h'
  hw/southbridge/ich9: Introduce TYPE_ICH9_SOUTHBRIDGE stub
  hw/southbridge/ich9: Add the DMI-to-PCI bridge
  hw/southbridge/ich9: Add a AHCI function
  hw/i2c/smbus: Extract QOM ICH9 definitions to 'smbus_ich9.h'
  hw/southbridge/ich9: Add the SMBus function
  hw/southbridge/ich9: Add the USB EHCI/UHCI functions
  hw/southbridge/ich9: Extract LPC definitions to 'hw/isa/ich9_lpc.h'
  hw/southbridge/ich9: Add the LPC / ISA bridge function

 MAINTAINERS                         |  21 ++-
 include/hw/acpi/ich9.h              |  15 ++
 include/hw/acpi/ich9_tco.h          |   6 +-
 include/hw/i2c/smbus_ich9.h         |  25 +++
 include/hw/isa/ich9_lpc.h           | 166 ++++++++++++++++++++
 include/hw/pci-bridge/ich_dmi_pci.h |  20 +++
 include/hw/southbridge/ich9.h       | 235 +---------------------------
 hw/acpi/ich9.c                      |   9 +-
 hw/acpi/ich9_tco.c                  |   5 +-
 hw/i2c/smbus_ich9.c                 |  36 +++--
 hw/i386/acpi-build.c                |   1 +
 hw/i386/pc_q35.c                    | 124 +++------------
 hw/isa/lpc_ich9.c                   |  37 ++++-
 hw/pci-bridge/i82801b11.c           |  11 +-
 hw/southbridge/ich9.c               | 212 +++++++++++++++++++++++++
 tests/qtest/tco-test.c              |   2 +-
 hw/Kconfig                          |   1 +
 hw/i386/Kconfig                     |   3 +-
 hw/meson.build                      |   1 +
 hw/southbridge/Kconfig              |  11 ++
 hw/southbridge/meson.build          |   3 +
 21 files changed, 581 insertions(+), 363 deletions(-)
 create mode 100644 include/hw/i2c/smbus_ich9.h
 create mode 100644 include/hw/isa/ich9_lpc.h
 create mode 100644 include/hw/pci-bridge/ich_dmi_pci.h
 create mode 100644 hw/southbridge/ich9.c
 create mode 100644 hw/southbridge/Kconfig
 create mode 100644 hw/southbridge/meson.build

-- 
2.41.0


