Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B695CC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLVu-0008Bu-Uh; Tue, 05 Aug 2025 13:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLVm-0008Af-CW
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:31:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLVk-0004qY-7x
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:31:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b78d337dd9so3060889f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415097; x=1755019897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qtVm36dKrnjFartRX0+r1x5lteIAiCuP/BwL/1JFMeo=;
 b=IMMFs+Esl3UNo50XHbsDfGWJjyXDv3mm2LuhVWJ/afEFhcvoSYG7wSnhG896ymEqQa
 bQhQg7/zb8xnHYYuGmQ8wklFfYBRt+9OALhCb2EvpZamgaJmqJblxnF7DNPlK0jAtqob
 0aGKx4O+lDFtdOdFhdn34y1szrTliJ2qt2C2jrfR4MISVTm8+iKeUvsEaXuwSu8h8a89
 TbFG6sO1EuXz9/Yr2mTXbQC+pxd5/W4RSmbLlq+rnkOR5EX4Gpj5dV6ac8pWukxO2NN3
 fJjXEE9ttrnLj14OKE7kNX9k7sTZg6bmzehR4Uvt0KpPVMUWuZHGJPdKEUXOyfJ0JgO4
 mVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415097; x=1755019897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qtVm36dKrnjFartRX0+r1x5lteIAiCuP/BwL/1JFMeo=;
 b=LWQvtuUjfSEZSYQSZgbJx7iLHSul2Sm0kcspe8knKWRvprtnIQS1+BmHRfOmOSyysJ
 /Xo8pEzWET0O0m3LjtGqKf/yBWiSIQMOW9SJzxVuCnAjjjrWF9q9o7ptMyRNrqQhLiab
 OlXVg1LR6bLZCGDYRezLqLdAyudCe/n0j4WaUsbctPyx0ZBevE2chbiVhH77MNrqW+Ck
 JC5zLqV3r5vZADllPnaOSHTgSmTUBiczBa+kTWV5gOU2rfKNIV+fZEKqH8h+qUX+Hxrw
 E1CV+U/RAV41BDJsLb9GV2J6xZBDyn7MvOi4gJrqhemV9kKpfmMraNS42bpG5XaITp6F
 Z8qA==
X-Gm-Message-State: AOJu0YxAF44RUC6DNVrQ7a/BHikM/oUs1SQ5e6PJe0ryi+UX8YgSyxLw
 zZhI90LUB62ZE9UKAO3gxRarpHre4P7F0DqLE2R69WD79txioVHzwSDqv5XJS82ePK7dJezN8Lu
 bPwGh
X-Gm-Gg: ASbGncvWQlQGTMX4PTCdmuc4gSAiMrwjPV7Ai85t0zHWsTMve68AHPW1jjZhtIkw51W
 9Or09ed5qX9gV/pEjq1C+icsskvzsh1Qh3uhLW9akL3m7zd5xwE1ISztj+4W29QVEmHvk5k9jRv
 9T9IEQGrv4q6QOrt1wcVo18Z4CxTCmIXHzXQFYwnb6EkHs2QS41JEjCFB1lOJJgzfqPUIvor5CV
 Oz2QBcVDR+Q3PrwE2P9dIFkNsBY8/AeFHlGc/uL4KgiIJrhqWRRvDPja9KP+S2co1z7GMzgwKwm
 yvOb8YBxYpI90XXzepKDBDxlE6EEbbvlLNdVTgShlFEuvGyNIx2SeYYDVHTJYMk0v6SnpB4ZIhZ
 8WNYLNHN/BA9GB988qN5yreduA0BpfOKln6My3Uof15Ye1GXcjbbqeEGkNM06Z6zI8sPSmENZ
X-Google-Smtp-Source: AGHT+IG+qhCr+RvwQjhMB1OqLqwhrW5gFplrVLSSX3yhHPlW3vtg2fXXPiJ2rIHL2sMlrhxgbMmR7g==
X-Received: by 2002:a05:6000:420d:b0:3a4:f6ba:51da with SMTP id
 ffacd0b85a97d-3b8d9470777mr11559139f8f.15.1754415096773; 
 Tue, 05 Aug 2025 10:31:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e009e465sm10683226f8f.43.2025.08.05.10.31.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:31:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/13] Misc HW patches for 2025-08-05
Date: Tue,  5 Aug 2025 19:31:21 +0200
Message-ID: <20250805173135.38045-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The following changes since commit a41280fd5b94c49089f7631c6fa8bb9c308b7962:

  Merge tag 'pull-aspeed-20250804' of https://github.com/legoater/qemu into staging (2025-08-04 08:57:07 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250805

for you to fetch changes up to eb013cd6a11951a8d76e737e9f6e89c96b059b48:

  hw/i386/microvm: Explicitly select ACPI_PCI (2025-08-05 17:30:45 +0200)

----------------------------------------------------------------
Misc HW patches

- Fix SD cards wired in SPI mode
- Fix microvm-only build by selecting Kconfig ACPI_PCI
- Fix legacy Intel SMT info removing 'x-vendor-cpuid-only-v2' property check

----------------------------------------------------------------

Eric Auger (1):
  hw/i386/microvm: Explicitly select ACPI_PCI

Philippe Mathieu-Daudé (11):
  hw/sd/sdcard: Do not ignore errors in sd_cmd_to_sendingdata()
  hw/sd/sdcard: Factor sd_response_size() out
  hw/sd/sdbus: Provide buffer size to sdbus_do_command()
  hw/sd/sdcard: Fill SPI response bits in card code
  hw/sd/sdcard: Implement SPI R2 return value
  hw/sd/sdcard: Use complete SEND_OP_COND implementation in SPI mode
  hw/sd/sdcard: Allow using SWITCH_FUNCTION in more SPI states
  hw/sd/sdcard: Factor spi_cmd_SEND_CxD() out
  hw/sd/sdcard: Disable checking STBY mode in SPI SEND_CSD/CID
  hw/sd/sdcard: Remove SDState::mode field
  tests/functional: Test SD cards in SPI mode (using sifive_u machine)

Zhao Liu (1):
  target/i386/cpu: Move addressable ID encoding out of compat property
    in CPUID[0x1]

 MAINTAINERS                               |   1 +
 include/hw/sd/sd.h                        |  23 ++-
 hw/sd/allwinner-sdhost.c                  |   7 +-
 hw/sd/bcm2835_sdhost.c                    |   7 +-
 hw/sd/core.c                              |   5 +-
 hw/sd/omap_mmc.c                          |   5 +-
 hw/sd/pl181.c                             |   6 +-
 hw/sd/sd.c                                | 198 ++++++++++++++++------
 hw/sd/sdhci.c                             |   6 +-
 hw/sd/ssi-sd.c                            | 100 ++---------
 target/i386/cpu.c                         |   3 +-
 hw/i386/Kconfig                           |   1 +
 hw/sd/trace-events                        |   4 +-
 tests/functional/meson.build              |   1 +
 tests/functional/test_riscv64_sifive_u.py |  51 ++++++
 15 files changed, 251 insertions(+), 167 deletions(-)
 create mode 100755 tests/functional/test_riscv64_sifive_u.py

-- 
2.49.0


