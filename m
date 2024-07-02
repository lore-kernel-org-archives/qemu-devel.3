Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FF5C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVds-00077w-2n; Tue, 02 Jul 2024 01:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVdo-00077h-HG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVdm-000582-EH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42565697036so28050885e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896475; x=1720501275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wc0MaQgBES3M1CkLvxNOArN1CUAzFOoiIWOq/I+5GYY=;
 b=b34+kKpIcHecW7t5ROqNaxQl62BbeTPXfNmaDrLnkthbkObfjm9ZDgy4bnnqPbdtsx
 CjQbWYHbCnk6TLK04S4a0OGhx99WAFxrEeO6OHCokOVqUCDbGv0W5TDfgZbGJa80fvQR
 nNdWckmPosOFtIXLRXlqn9r9FpKksQLng1zx+Hd9N0s0Q7dgQTTWIiCNmaWVJljKvCKz
 u14dx4TkmU0shPyZ3Jz9ZpW2pEoJzXEjhZXCB5reM5Lw5LFB+H1jPn38quN9Zxx0+Itz
 CHhp3RIGDU6BXjS1BEVT0ORfHpipTRUYnGikmMGXBdufIi/4Pn6X4iDvjo/qzt3vAEwN
 2KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896475; x=1720501275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wc0MaQgBES3M1CkLvxNOArN1CUAzFOoiIWOq/I+5GYY=;
 b=kbdzAcqtixMkwVQvCaFw6IJYI2lUwrTovLX0MkUiVbtXZ6asu+2TNu66um/3Q4JE7I
 WcGDC61BRtsNag5LC67tfH9si/jGwCBdFFEfmXyzkCySzg+WEhJLX/7zI2yMYGLzvRUv
 8JI6g7rAeYlaycLm8UKBK8v64B67ixfvXkqF+fcPfsmSPpRl60cltz3mjUjfaWa8ceFg
 9MRpMW0481IPRkxG/xumr/UI4pFskEzQ6sNrxcUxWURaxHW9f562FtkTYD9zGoXLyg97
 BmYxOcEB1uVdzQubrQA7wClCQ48mVkyWxOasTKBKKBSDe9nqnnk9v95AkEWJiIMiWoiT
 Fb2A==
X-Gm-Message-State: AOJu0YwK8yI/eZ7JsXeuN2ikJ1F24Pr9kttfwtJV6KBJ0akI1tRitIOB
 l5u9dJhS2/R+EYDCnvttc3cxtVHl1poH0fq4qe0+p/CXZ95/XCU9T7xO8dcH783DnuGHlHKYiDK
 L
X-Google-Smtp-Source: AGHT+IFo3YKoVtRnowO7gROdAueoYzi47Zws7orXaxWBnqqH4ExNBi1hwOWbnQng0qg2aEbY9Ba0Cw==
X-Received: by 2002:a05:6000:1e46:b0:362:ad01:5435 with SMTP id
 ffacd0b85a97d-36774f938ddmr6810942f8f.29.1719896475198; 
 Mon, 01 Jul 2024 22:01:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd778sm12174609f8f.5.2024.07.01.22.01.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:01:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/22] Misc HW patches for 2024-07-02
Date: Tue,  2 Jul 2024 07:00:50 +0200
Message-ID: <20240702050112.35907-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The following changes since commit b6d32a06fc0984e537091cba08f2e1ed9f775d74:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-06-30 16:12:24 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240702

for you to fetch changes up to f0936cbc1d42410ccd58c042bc26fa33a23a77d6:

  Remove inclusion of hw/hw.h from files that don't need it (2024-07-02 06:58:48 +0200)

Ignored checkpatch warnings:

  WARNING: line over 80 characters
  #45: FILE: include/hw/boards.h:431:
  + *          mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " Virtual Machine"; \
  #205: FILE: include/hw/boards.h:591:
  +    prefix ## _machine_ ## major ## _ ## minor ## _ ## micro ## _ ## tag ## _ ## sym
  #40: FILE: hw/arm/virt.c:112:
  +        mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
  #55: FILE: hw/s390x/s390-virtio-ccw.c:828:
  +        mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
  #43: FILE: hw/m68k/virt.c:345:
  +        mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " M68K Virtual Machine"; \

----------------------------------------------------------------
Misc HW patches queue

- Prevent NULL deref in sPAPR network model (Oleg)
- Automatic deprecation of versioned machine types (Daniel)
- Correct 'dump-guest-core' property name in hint (Akihiko)
- Prevent IRQ leak in MacIO IDE model (Mark)
- Remove dead #ifdef'ry related to unsupported macOS 12.0 (Akihiko)
- Remove "hw/hw.h" where unnecessary (Thomas)

----------------------------------------------------------------

Akihiko Odaki (5):
  system/physmem: Fix reference to dump-guest-core
  hvf: Drop ifdef for macOS versions older than 12.0
  audio: Drop ifdef for macOS versions older than 12.0
  block/file-posix: Drop ifdef for macOS versions older than 12.0
  net/vmnet: Drop ifdef for macOS versions older than 12.0

Daniel P. Berrangé (14):
  include/hw: add helpers for defining versioned machine types
  hw/arm: convert 'virt' machine definitions to use new macros
  hw/s390x: convert 'ccw' machine definitions to use new macros
  hw/ppc: convert 'spapr' machine definitions to use new macros
  hw/m68k: convert 'virt' machine definitions to use new macros
  hw/i386: convert 'i440fx' machine definitions to use new macros
  hw/i386: convert 'q35' machine definitions to use new macros
  include/hw: add macros for deprecation & removal of versioned machines
  include/hw: temporarily disable deletion of versioned machine types
  hw: set deprecation info for all versioned machine types
  hw: skip registration of outdated versioned machine types
  hw/ppc: remove obsolete manual deprecation reason string of spapr
    machines
  hw/i386: remove obsolete manual deprecation reason string of i440fx
    machines
  docs: document special exception for machine type deprecation &
    removal

Mark Cave-Ayland (1):
  hw/ide/macio: switch from using qemu_allocate_irq() to qdev input
    GPIOs

Oleg Sviridov (1):
  hw/net/spapr: prevent potential NULL dereference

Thomas Huth (1):
  Remove inclusion of hw/hw.h from files that don't need it

 docs/about/deprecated.rst     |  13 ++
 include/hw/boards.h           | 298 ++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h          |  28 ++++
 include/hw/misc/macio/macio.h |   7 +-
 include/hw/misc/xlnx-cfi-if.h |   1 -
 accel/hvf/hvf-all.c           |   3 -
 block/file-posix.c            |   5 -
 hw/arm/virt.c                 |  34 ++--
 hw/i386/pc_piix.c             | 220 +++++++++++--------------
 hw/i386/pc_q35.c              | 215 ++++++++++--------------
 hw/ide/macio.c                |  10 +-
 hw/m68k/virt.c                |  57 ++++---
 hw/misc/edu.c                 |   1 -
 hw/net/spapr_llan.c           |   6 +
 hw/ppc/spapr.c                | 100 +++++++-----
 hw/s390x/s390-virtio-ccw.c    | 102 +++++++-----
 hw/vfio/container.c           |   1 -
 net/vmnet-host.c              |  24 +--
 net/vmnet-shared.c            |  13 --
 system/physmem.c              |   2 +-
 target/i386/hvf/hvf.c         |  23 +--
 audio/coreaudio.m             |   5 -
 net/vmnet-bridged.m           |  13 +-
 net/vmnet-common.m            |   3 -
 24 files changed, 710 insertions(+), 474 deletions(-)

-- 
2.41.0


