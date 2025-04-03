Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4346C3601E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ML1-0007br-Ls; Thu, 03 Apr 2025 11:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MKz-0007bI-Ut
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:18:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MKx-0000OS-Ah
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:18:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3965c995151so686476f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693513; x=1744298313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nk7HkSl6ytbVk4kl2foDviXAGWH6GjCYLhLVx8jvfi4=;
 b=f5lYgJNr7BPEfSiL0WhuQY5XqACL8HbeDfgVEJ464bSFMT4QaZc8b3RnjbnGSVYy9N
 G6URyq+X0wBdJV4TNok6/oWDUwIZruuWUEIt0lPINM4EsFAyYa7nepA1g3+G29zOrBlQ
 0Sy9LBSo+alrhsiJfUaPnOe2SKMHWkETQEkJhT/DsW59VVbd0nK4sBwhaKc7lUA85sq/
 iqEkTHW4AMMsXB6iQ8h06F+ocqeoTa9tkPyXlZYk68b8sXKAvFbbma3WeCdogV4VQYS3
 D/ujvDj5rOOBJvQpXG0x9yCtAd2/O5NMaS/P6Oj749W3sGygIYvjZx1nCQ2pZdG8l538
 ZM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693513; x=1744298313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nk7HkSl6ytbVk4kl2foDviXAGWH6GjCYLhLVx8jvfi4=;
 b=S1GZFOc87LzjPFGmm7d/lmjnhZHOfy2/yeCiSg8g1NkxcoliwKXciPdDP5fxiz3DoY
 OGKLfVGaGnLFgO1d+7oqsL8E0YeXBXY9Ag74F6AJiIRGlAofiC6Yo1yBZvT9daeMWwDH
 NcrcYTP9oaf/k5SDYVV1xezzaazT5sB9+TzddAiEPAvE0RIL9tQyEIhRv0gpSkDMq08y
 kPT2YwOpMz6OuuqhnadoFZEG/IkN/77Nu6oxNWfGfwOTk3+FUvCN99MmXnQ5Qgi4lDB3
 vT7dEONlVG8C+qv+cwQMB99Fj9Em/bJd7HWiGCcUtHtJblZGeW79LI2UkRfwF69VitBn
 BqcQ==
X-Gm-Message-State: AOJu0Yy0jvNdJBWmEBJ7HwXlCCsKpvOFYEwBmXfxexiIbzGkUZ3Q/tca
 RjoWuQxb/ehOKqoZNvZGEwb8SWGwnMTGQXGeOOH66pAT62F1llna2FTP6LdduRxAc1Et7YXNC8c
 A
X-Gm-Gg: ASbGncu3jVvj60GU/tG8pZkdMuKkeJ0RSQR+fFT3fu+IXJw64+mgSBbMjE7yRBXY9Z7
 eEf3L+GNkFGT7hx2MhlgBp9m+0cBNPIDhI7gDlq1hWAdOWZvD/g1eSgK+13alL836m8Ydzr71HV
 Mf1cpw8IpfcaLdLanygOXsbvmV7niwuHL7Batad/uc9UTYB4fxEOX01qOSZqSTgZYoCY6qwkQec
 Yet3gTJUorwT1ckdknW9IlSquHkG97sBinAq/+noWZioblS3lBM8w4iTTvYOESn1VJnsPc27m1Y
 ls2W7FL/gEaZUdZnK71s6rRC4B3ds+Ds0dqw41bJVxFrxLla39nDSOnepVDrQWrt9tNTPJEeBjr
 hbc3A9J+wR3za9g2pKm8=
X-Google-Smtp-Source: AGHT+IEbJTCBFrbSyXuSCuQB8JSMdT9Rr0TuWMBudPsTzJaJXw7BLufu4Oeg1Yocmd8P5m1fXjju0g==
X-Received: by 2002:a5d:6d8a:0:b0:391:4835:d888 with SMTP id
 ffacd0b85a97d-39c297e526amr5638439f8f.42.1743693512823; 
 Thu, 03 Apr 2025 08:18:32 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301ba2dfsm2074928f8f.60.2025.04.03.08.18.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:18:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0 v2 00/14] hw/arm: Tests & ACPI tables fixes for 10.0
Date: Thu,  3 Apr 2025 17:18:15 +0200
Message-ID: <20250403151829.44858-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I tried to gather all the hw/arm/-related patches for
the GitLab issues tagged for 10.0.

First, trivial ones fixing / disabling broken tests;
then disable the VMapple machine (not sure about it);
finally fix ACPI tables for '-M its=off' CLI option.

While polishing the series, I noticed MST mentioning
the ACPI changes are likely too late:
https://lore.kernel.org/qemu-devel/20250403100406-mutt-send-email-mst@kernel.org/
I'll defer that jugement to Alex :)

Regards,

Phil.

Philippe Mathieu-Daudé (13):
  tests/functional: Add a decorator for skipping tests on particular OS
  tests/functional: Skip aarch64_replay test on macOS
  tests/qtest: Skip Aarch64 VMapple machine
  hw/arm: Do not build VMapple machine by default
  hw/arm/virt: Remove pointless VirtMachineState::tcg_its field
  hw/intc/gicv3_its: Do not check its_class_name() for NULL
  hw/arm/virt: Simplify create_its()
  hw/arm/virt-acpi: Factor its_enabled() helper out
  qtest/bios-tables-test: Add test for -M virt,its=off
  qtest/bios-tables-test: Whitelist aarch64/virt 'its_off' variant blobs
  hw/arm/virt-acpi: Always build IORT table (even with GIC ITS disabled)
  hw/arm/virt-acpi: Do not advertise disabled GIC ITS
  qtest/bios-tables-test: Update aarch64/virt 'its_off' variant blobs

Pierrick Bouvier (1):
  tests/functional/test_aarch64_rme_virt: fix sporadic failure

 configs/devices/aarch64-softmmu/default.mak |   1 +
 include/hw/arm/virt.h                       |   1 -
 include/hw/intc/arm_gicv3_its_common.h      |   2 +-
 hw/arm/virt-acpi-build.c                    |  48 ++++++++++++--------
 hw/arm/virt.c                               |  23 +++-------
 tests/qtest/bios-tables-test.c              |  22 +++++++++
 tests/qtest/libqtest.c                      |   1 +
 tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 164 bytes
 tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 212 bytes
 tests/functional/qemu_test/__init__.py      |   2 +-
 tests/functional/qemu_test/decorators.py    |  15 +++++-
 tests/functional/test_aarch64_replay.py     |   4 +-
 tests/functional/test_aarch64_rme_virt.py   |   4 +-
 14 files changed, 82 insertions(+), 41 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off

-- 
2.47.1


