Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2CAECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzx0-0007AH-0h; Tue, 10 Sep 2024 08:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzwy-000794-KT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:26:28 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzww-0003dp-QH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:26:28 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f761461150so44164301fa.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725971184; x=1726575984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yMbcFoOzWZLnMx1hP8NxuXXLnMO/tZV1JBHxtiwK6ko=;
 b=oFaEQRT5loSjWle9cLOiEQymHKR3dzBm14GIBZn1XRb5vRJfRR+wRhOH3jjqaKz0dF
 pYOSEGYjA7ZmolMIVRbTftqyYKc1NN7SClXrU2kZb1WjLV9T25xOxYSOqdRwyJJadcp9
 iAnaYmyzruIqqcQ1rSsbYTWsRo2PtZ5RWtfvf4mJE0nPa+vsQSWecGx17bEmAyCKL+G9
 3RlwIwtHBr4O/6CIu49NEj5V26/bBa+owzxhqlUB4g6AVueGux2uFN7Cdgq6ltmsc/Tz
 EEIAxykQmhYq1aTs1E3JdYs1nBRvEPrl3HPHyfQ/hFenPoTVyEozXE6odhhJ1T2Onqkz
 /IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725971184; x=1726575984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yMbcFoOzWZLnMx1hP8NxuXXLnMO/tZV1JBHxtiwK6ko=;
 b=Cwss8E8C1ddj7IrCZWeXYeaiRxvJZWtNrXI56m2oQ5L1uDdPFCh97tAMdBwKY4jlH5
 eWqA7Ct0h8PXF3oiHtjVxvdGmchzSonD60OSP9/tajAnfG55uRt5tN9sE9KnLAW8DpfA
 atqPVKcxbblm4VB07JJcBr/qKrdPvo/qIS1XVjw0z3Lj0D+Oce0z/kYx4Xt7Y/dA48fW
 NIC6tmBga7HnYCYDTzxkDvN7oaFTp+5HmWIODK4+9kZefQ3nELb/PCskNacQ4ekfnmEa
 iXubbYHdnAFG2o7jhwbqeJwgq0CBozyPtWXb+skyGOEhMpSY41WgvnfZ3XTMgov1zHZd
 Jjnw==
X-Gm-Message-State: AOJu0Ywis+f1wClybyGr5RaKiKC9Mx/fgX90jF/XlFu5dKFT/FoLT5LA
 FkwAYPI4lSDE+FewuIz/KdleW6NG7IIyj9c0r3P5lPBmwbTBSJw+PoVwbMJPDJQ/ooaUPGAQXwZ
 m
X-Google-Smtp-Source: AGHT+IGl8VrBfqLDvqSOb0o3TcO2u0pjuZdi2LQXyhgdiS+mk1CABkqDGxFLGiVOQOfcagMnLhT+YQ==
X-Received: by 2002:a05:651c:2207:b0:2f3:cd4e:b931 with SMTP id
 38308e7fff4ca-2f75a96da0amr103149801fa.10.1725971184137; 
 Tue, 10 Sep 2024 05:26:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ced18csm472751066b.161.2024.09.10.05.26.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Sep 2024 05:26:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/5] license: Fix typos and update SPDX tags
Date: Tue, 10 Sep 2024 14:26:13 +0200
Message-ID: <20240910122618.33056-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

Series fully reviewed (thanks Thomas!)

Since v1:
. Updated regex to cover all GPL-2.0* cases.

- Fix a pair of typos
- Upgrade the deprecated GPL-2.0+/LGPL-2.0+ SPDX tags
  to GPL-2.0-only / GPL-2.0-or-later / LGPL-2.0-or-later.

Philippe Mathieu-Daudé (5):
  NSIS: Simplify license description
  tests/functional: Correct typo in test_netdev_ethtool.py SPDX tag
  license: Update deprecated SPDX tag LGPL-2.0+ to LGPL-2.0-or-later
  license: Update deprecated SPDX tag GPL-2.0+ to GPL-2.0-or-later
  license: Update deprecated SPDX tag GPL-2.0 to GPL-2.0-only

 hw/core/uboot_image.h                   | 2 +-
 hw/m68k/bootinfo.h                      | 2 +-
 hw/net/igb_regs.h                       | 2 +-
 include/gdbstub/syscalls.h              | 2 +-
 include/gdbstub/user.h                  | 2 +-
 include/hw/nvram/fw_cfg_acpi.h          | 2 +-
 include/hw/usb/dwc2-regs.h              | 2 +-
 include/hw/virtio/virtio-acpi.h         | 2 +-
 include/qemu/crc-ccitt.h                | 2 +-
 target/alpha/cpu-param.h                | 2 +-
 target/arm/cpu-param.h                  | 2 +-
 target/cris/cpu-param.h                 | 2 +-
 target/hppa/cpu-param.h                 | 2 +-
 target/i386/cpu-param.h                 | 2 +-
 target/m68k/cpu-param.h                 | 2 +-
 target/microblaze/cpu-param.h           | 2 +-
 target/mips/cpu-param.h                 | 2 +-
 target/openrisc/cpu-param.h             | 2 +-
 target/ppc/cpu-param.h                  | 2 +-
 target/riscv/cpu-param.h                | 2 +-
 target/s390x/cpu-param.h                | 2 +-
 target/sh4/cpu-param.h                  | 2 +-
 target/sparc/cpu-param.h                | 2 +-
 tests/tcg/loongarch64/system/regdef.h   | 2 +-
 target/sparc/insns.decode               | 2 +-
 gdbstub/gdbstub.c                       | 2 +-
 gdbstub/syscalls.c                      | 2 +-
 gdbstub/system.c                        | 2 +-
 gdbstub/user-target.c                   | 2 +-
 gdbstub/user.c                          | 2 +-
 hw/nvram/fw_cfg-acpi.c                  | 2 +-
 hw/virtio/virtio-acpi.c                 | 2 +-
 linux-user/alpha/syscall.tbl            | 2 +-
 linux-user/alpha/syscallhdr.sh          | 2 +-
 linux-user/arm/syscallhdr.sh            | 2 +-
 linux-user/hppa/syscall.tbl             | 2 +-
 linux-user/hppa/syscallhdr.sh           | 2 +-
 linux-user/i386/syscallhdr.sh           | 2 +-
 linux-user/m68k/syscall.tbl             | 2 +-
 linux-user/m68k/syscallhdr.sh           | 2 +-
 linux-user/microblaze/syscall.tbl       | 2 +-
 linux-user/microblaze/syscallhdr.sh     | 2 +-
 linux-user/mips/syscall_o32.tbl         | 2 +-
 linux-user/mips/syscallhdr.sh           | 2 +-
 linux-user/mips64/syscall_n32.tbl       | 2 +-
 linux-user/mips64/syscall_n64.tbl       | 2 +-
 linux-user/mips64/syscallhdr.sh         | 2 +-
 linux-user/ppc/syscall.tbl              | 2 +-
 linux-user/ppc/syscallhdr.sh            | 2 +-
 linux-user/s390x/syscall.tbl            | 2 +-
 linux-user/s390x/syscallhdr.sh          | 2 +-
 linux-user/sh4/syscall.tbl              | 2 +-
 linux-user/sh4/syscallhdr.sh            | 2 +-
 linux-user/sparc/syscall.tbl            | 2 +-
 linux-user/sparc/syscallhdr.sh          | 2 +-
 linux-user/x86_64/syscallhdr.sh         | 2 +-
 linux-user/xtensa/syscall.tbl           | 2 +-
 linux-user/xtensa/syscallhdr.sh         | 2 +-
 qemu.nsi                                | 4 +++-
 scripts/kernel-doc                      | 2 +-
 tests/functional/test_netdev_ethtool.py | 2 +-
 61 files changed, 63 insertions(+), 61 deletions(-)

-- 
2.45.2


