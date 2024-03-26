Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBAFCD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp8zE-0003a9-Oc; Tue, 26 Mar 2024 11:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zB-0003YT-8I
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:13 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8z9-00013S-3A
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:13 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d68cf90ec4so93860321fa.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467909; x=1712072709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hn7lLwxhhf3gNG9hNhmhqHwHMzru6i5It7d/ZRKMp5c=;
 b=Yb5lMLhXOiKn5VkpseRU65m2V2+9vB72Gq7NIpyoOd0vzxJydvcbsgZDZ8Tp9di5M4
 QyWICCpbJTOqd434AzBzLHiBf9qkZDmkWqCnsK2rUnaBmrNZ7i5urO2x7ZW4jLgx0Jh2
 xV0dhqjRwFIYCwc0mVk1VBDaf5QbAnHUtWDLDtlr4lXtZqtPtC0EjDhhByZ6Z5dhTM2d
 C8zwh22r+e9ayzvjwlC3+he10IbdY5zI37WDLzFR0wGFTFxF2H9z1GUjEAfpQ1aEtuS6
 wFYSBJHINrG32pOOCSdjVz4XRETqB+dmODdwx8qSLRXgcdZXbpNMF9Lt5O1dDotTMnKI
 3u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467909; x=1712072709;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hn7lLwxhhf3gNG9hNhmhqHwHMzru6i5It7d/ZRKMp5c=;
 b=s9a1El1ttMVrpBceqa2WWwqx4VrDUCDUsxebpZoFDZghuS3By4SPz1aqqB4SQDg581
 QiUO7NqcsNr00jGn9tdIP7DRtjc3gqLXI2CXQTO4y+vOzkeT8MLxORQpu8BIXMFLIpYH
 Roox8n6ibFq3FDGSUTNHBg2f8QDAjxHwDXAVr8Zg8KId5qs5LBCsE+ql0XbrjPTuipoS
 4UZqlcgUHuYti8tbEryc+KhTeHTL/3UF0qaPxjh/VTg0tCAhcMx0ZcRa1TKDLwbLrQO5
 VLwo1R/eSkqMF6HvPgVpGTsk8DISx/iJvEL3jrNEIExU0iR7fB6F2lonoJySfe1zh7ZV
 RP0A==
X-Gm-Message-State: AOJu0Yx5EK0I/ShH5ivv8BVnrO87mFYGGwwSI0bJk7e1Nvwm9gVtDLKK
 sVKcGYDvgFSrmAFe9s7LDc5aaUWSNKA52MEo+eq0dbI2E9oyQUakvcc/HNNJEB0mC0Yo/nA1HUr
 Q
X-Google-Smtp-Source: AGHT+IEALTk4jXcNz+fMQ88/UxCzvbm02IxmYranwLwGcphz5AA31i0Mrh7B9Am48JKgWGWF1x3MBA==
X-Received: by 2002:a2e:834e:0:b0:2d4:3c32:814d with SMTP id
 l14-20020a2e834e000000b002d43c32814dmr1302990ljh.26.1711467908686; 
 Tue, 26 Mar 2024 08:45:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 fb13-20020a05600c520d00b0041490a19e13sm1084314wmb.7.2024.03.26.08.45.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:45:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/13] Misc HW patches for 2024-03-26
Date: Tue, 26 Mar 2024 16:44:51 +0100
Message-ID: <20240326154505.8300-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

The following changes since commit 096ae430a7b5a704af4cd94dca7200d6cb069991:

  Merge tag 'pull-qapi-2024-03-26' of https://repo.or.cz/qemu/armbru into staging (2024-03-26 09:50:21 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240326

for you to fetch changes up to ccebb9ae352eea63cb1491cb829e4cd0f7576f1c:

  ui/cocoa: Use NSTrackingInVisibleRect (2024-03-26 14:32:54 +0100)

A pair of "WARNING: line over 80 characters" are ignored (82 chars).

----------------------------------------------------------------
Misc HW patch queue

[hw]
- Do not silently overwrite 'io_timeout' property in scsi-generic (Lorenz)
- Propagate period when enabling a clock in stm32l4x5 mux (Arnaud, Phil)
- Add missing smbios_get_table_legacy() stub (Igor)
- Append a space in gpa2hva() HMP error message (Yao)
- Fix compiler warning in 'execlog' plugin (Yao)

[target]
- i386: Enable page walking from MMIO memory (Gregory, Jonathan)
- tricore: Use correct string format in cpu_tlb_fill (Phil)

[docs]
- Fix formatting in amigang.rst (Zoltan)

[ui]
- Fix cocoa regression in platform fullscreen toggling (Akihiko)

----------------------------------------------------------------

Akihiko Odaki (3):
  ui/cocoa: Fix aspect ratio
  ui/cocoa: Resize window after toggling zoom-to-fit
  ui/cocoa: Use NSTrackingInVisibleRect

Arnaud Minier (1):
  hw/misc/stm32l4x5_rcc: Propagate period when enabling a clock

BALATON Zoltan (1):
  docs/system/ppc/amigang.rst: Fix formatting

Gregory Price (1):
  target/i386/tcg: Enable page walking from MMIO memory

Igor Mammedov (1):
  hw/smbios: add stub for smbios_get_table_legacy()

Lorenz Brun (1):
  hw/scsi/scsi-generic: Fix io_timeout property not applying

Philippe Mathieu-Daudé (3):
  target/tricore/helper: Use correct string format in cpu_tlb_fill()
  hw/clock: Let clock_set_mul_div() return a boolean value
  hw/misc/stm32l4x5_rcc: Inline clock_update() in clock_mux_update()

Yao Xingtao (2):
  monitor/hmp-cmds-target: Append a space in error message in gpa2hva()
  contrib/plugins/execlog: Fix compiler warning

 docs/devel/clocks.rst                |  4 ++
 docs/system/ppc/amigang.rst          |  4 +-
 include/hw/clock.h                   |  4 +-
 contrib/plugins/execlog.c            | 24 +++++++-
 hw/core/clock.c                      |  8 ++-
 hw/misc/stm32l4x5_rcc.c              |  9 ++-
 hw/scsi/scsi-generic.c               |  1 -
 hw/smbios/smbios_legacy_stub.c       |  5 ++
 monitor/hmp-cmds-target.c            |  2 +-
 target/i386/tcg/sysemu/excp_helper.c | 57 +++++++++---------
 target/tricore/helper.c              |  4 +-
 ui/cocoa.m                           | 90 +++++++++++++++++-----------
 12 files changed, 137 insertions(+), 75 deletions(-)

-- 
2.41.0


