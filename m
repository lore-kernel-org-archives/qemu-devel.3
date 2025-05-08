Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918ACC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD0Jm-0005XH-IB; Thu, 08 May 2025 08:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0Jk-0005VB-3r
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:25:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0Jh-0002mD-Gl
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:25:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22fbbf9c01bso1442345ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746707130; x=1747311930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JN8yzStfIrke6Ih4ToR7vQPWRj4Mc0F9s94EUPsMOtA=;
 b=WcMHeftCAVCyim2kwaGMHKKAed1kJbnm0bp9gmO76OCCVUft4GJ5T2raEfz7VfBUHo
 wBouxUYJvGYxeQHoyWbrd1eAaHASbYfx38p0F/P8+G06IP4nVuOYRsKuhFt/xcM6z30W
 W6JiucMadkCZlhoVWgy2dQADuaoTjrZG0IqG5A46CDwSu5TqRZo6thiDh1gJIrqBpvKg
 RjTWlp5mNeIk5x72autYWAdGd/8XVdNNLw6N5DxTGnWljUG83DzFL1SN7luptaLj+0qQ
 V33VcCUGSKAH4K7WCa/ucSQSti17emkRfYqPxBHAI3iVHOENFM9SEfN0UWvHXYEDLq8k
 P1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746707130; x=1747311930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JN8yzStfIrke6Ih4ToR7vQPWRj4Mc0F9s94EUPsMOtA=;
 b=R27oVQ5Dm5h8dS66v0PHhv2PQqkb1w8LuS7kf/YQVQ7CrxsjbcpZD17BBK0XSwFkCn
 0MCdwbN1N6xMb6AwQmENbTTuGRfF3/18C9hWwFZ8r6dsp2JFhEP9Ynd4T4Mabt14txMk
 cPYyjQQ7BgETM6+x8j7VzBechHBZim2WNHEFTnRKq5l8CHCgj6sjTvBUM/ovcWztNFTZ
 vWnMIu9R8Z/mTCz3hh2iZcZmbl8MWN3jO0o2vxm8W4gzXoUo4ha7H1DXwzC8dfolKKeb
 8qQA3EmlJneoPGmjFofHbfh7ALw3QVEuXN9El6u7HcwiFqj0rsByDcMJO4f5PFog7WqN
 XAyQ==
X-Gm-Message-State: AOJu0YzV85phF0LH31iZKh5TFpz6B/avXyL73giWsxO/u+pF3xkfPx01
 Znk0or5Jx7awpVFEtKF6xi47L5jupP7Ned81DEgqS919ew93JTeCHUd8aYZrrZEk98v1YWS201G
 kvYmL0Q==
X-Gm-Gg: ASbGncvDhkQu3AiGn/Ih/4cDWdPWmYTR73k119wGAASE11bjxiCiCAfbNqwDXMYSPBO
 c7fnYO20/JAMr91vJYWkupXgXXHgEKfGYs0IF27NpbRqp6bH8amiabCqcGGHHrqndeJoF0gPuFq
 nQn3Y9WB4BJY1M1OYHGBOIAMFqvEvtjRaSBxVrn1ae5nYmaRynhw3PmsDrlQHuQqJCTZhx+CBWu
 6lFPgynlvAYDijvRTUon8zNVuN19J4n1OUTiBU4fvHg0+7D5YAHq8VaXobfUrK1i/miM2RRVyi/
 UII0KJClzxBLEHjxBquUbKIw4rzzaIxQQqePQgGMxo7fslFScsQLSZSTkPeyoINMEcGkdpUmazV
 CM6Cn0gBh4QYjstk=
X-Google-Smtp-Source: AGHT+IG8b89VgigiAiBjtCWLVGvwnx9FErpbK9LPZaj4spds58qV0H7wtrT2LVf95NqAfx3lcjCmNA==
X-Received: by 2002:a17:903:41c1:b0:220:c63b:d93c with SMTP id
 d9443c01a7336-22e5ecabfbamr98724415ad.44.1746707130553; 
 Thu, 08 May 2025 05:25:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fbff4a805sm1140355ad.179.2025.05.08.05.25.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 05:25:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/19] Misc HW patches for 2025-05-08
Date: Thu,  8 May 2025 14:25:20 +0200
Message-ID: <20250508122522.73786-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit 57b6f8d07f1478375f85a4593a207e936c63ff59:

  Merge tag 'pull-target-arm-20250506' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2025-05-07 14:28:20 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250508

for you to fetch changes up to 201965865dd88b28e9a40a350642ce25784a574a:

  hw/i2c/imx_i2c: Always set interrupt status bit if interrupt condition occurs (2025-05-08 14:22:12 +0200)

----------------------------------------------------------------
Misc HW patches

- Allow using plugins on BSD user-emulation
- Inline VMSTATE_CPU() macro
- Fix headear includes for HVF x86
- Build hw/hyperv/ files once
- Various typo fixed
- Fix issue in i.MX I2C model

----------------------------------------------------------------

Bernhard Beschow (1):
  hw/i2c/imx_i2c: Always set interrupt status bit if interrupt condition
    occurs

Eric Auger (3):
  hw/pci/pcie_port: Fix pcie_slot_is_hotpluggbale_bus typo
  hw/acpi/ged: Fix wrong identation
  hw/i386/acpi-build: Fix build_append_notfication_callback typo

Gustavo Romero (2):
  hw/i386/acpi-build: Update document reference
  hw/i386/acpi-build: Fix typo and grammar in comment

Philippe Mathieu-Daudé (4):
  target/migration: Inline VMSTATE_CPU()
  accel/hvf: Include missing 'hw/core/cpu.h' header
  system/hvf: Avoid including 'cpu.h'
  system/hvf: Expose hvf_enabled() to common code

Pierrick Bouvier (8):
  bsd-user: add option to enable plugins
  hw/hyperv/hv-balloon-stub: common compilation unit
  hw/hyperv/hyperv.h: header cleanup
  hw/hyperv/vmbus: common compilation unit
  hw/hyperv/syndbg: common compilation unit
  hw/hyperv/balloon: common balloon compilation units
  hw/hyperv/hyperv_testdev: common compilation unit
  hw/hyperv/hyperv: common compilation unit

Steve Sistare (1):
  qom: Factor qom_resolve_path() out

 MAINTAINERS                    |  1 +
 hw/i386/acpi-build.h           |  2 +-
 include/hw/core/cpu.h          | 12 ------------
 include/hw/hyperv/hyperv.h     |  3 ++-
 include/system/hvf.h           | 17 +++++++++++------
 include/system/hvf_int.h       |  2 ++
 accel/hvf/hvf-all.c            |  1 +
 accel/stubs/hvf-stub.c         | 12 ++++++++++++
 bsd-user/main.c                | 12 ++++++++++++
 hw/acpi/generic_event_device.c | 10 +++++-----
 hw/hyperv/hyperv.c             |  3 ++-
 hw/hyperv/syndbg.c             |  9 ++++++---
 hw/hyperv/vmbus.c              |  2 +-
 hw/i2c/imx_i2c.c               | 11 +++++------
 hw/i386/acpi-build.c           | 10 +++++-----
 hw/pci/pcie_port.c             |  4 ++--
 qom/qom-qmp-cmds.c             | 21 +++++++++++++++------
 target/alpha/machine.c         |  2 +-
 target/hppa/machine.c          |  2 +-
 target/microblaze/machine.c    |  2 +-
 target/openrisc/machine.c      |  2 +-
 accel/stubs/meson.build        |  1 +
 hw/hyperv/meson.build          | 11 ++++++-----
 23 files changed, 94 insertions(+), 58 deletions(-)
 create mode 100644 accel/stubs/hvf-stub.c

-- 
2.47.1


