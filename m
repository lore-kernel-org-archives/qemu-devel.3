Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E3FEE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soP1J-0003R7-2b; Wed, 11 Sep 2024 11:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soP0x-00027r-CR
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:12:18 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soP0v-0001Gy-4e
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:12:15 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so20839421fa.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726067530; x=1726672330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B9oM8Ne18x0eSKs2eGImbQDt47h4Zb8ccSIXYvNWAjg=;
 b=mJayO/a+c0eoCtZDpCGhPu0tdGJGeqTmcETQT/+kgNqKFlGSasEKtSvZeXJ1tZ5b6H
 Wr7K6EQE4s2lrFG9C5MF36prCP/aW2QsF7VLFYsf+Ti42xSBqsDPvKOx+8WNsgwL65NF
 R8mQPj61QPDOnsat8zw0Tc3WgWIwrSGnOSWJXrrOTBZIEtdm9HlEFEb48xKedSAKP+q6
 RZD61Mr7Eky56b70mgb5DOo6sZ/3T+30JjtH8BH9CxGlN7InQ/0jZDzvr0V9oiW/4hqh
 6T1s2VsRZAZHypRuZRb914NBCcsi4rUdaO6pTooWezAxSjStr8u8KOaMMvM6mj77sCgP
 +GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726067530; x=1726672330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B9oM8Ne18x0eSKs2eGImbQDt47h4Zb8ccSIXYvNWAjg=;
 b=mK2P5IBzHuj9WNV2eCtyFvDf8tcvtranRpEYJaQgRjLri7rbOkGSeudIlVP/iD+ypd
 zSF6S7Fvv1ndL2jQbTQ5/e1CwY+KP+57AHBIipqn3gesd/BjK1sBbWpEsvvl/sjBWLoB
 +WVlGUwUAhv4z2DZjaHgwphSWw8xTxhIx5axPvvSF7GCoPg4iF7+zy7ggttqTyxHtsFe
 DGxoouwDJ0KUgqjWLfDLFWxjteD67/zKEZ4BhTz6uxo8hnoQDhRyiEdzqtryU/8ze3yF
 2uxLp77NYslUuJhOR5E0PUJqCGCXEqUxD1kx1ivKfwWVtzf/oZb/5L5arnFFxEP5dRh9
 6cMg==
X-Gm-Message-State: AOJu0YyfXJ2wzS+RWrBYPXW29E5/EoSxVhQtqb8ULY5SqS09exKzz0DS
 2YIgWuvxYK/KWoW8GWAGeAb0EpwaQO/gZzAOkD5oGBDo51negcSKcDkogMVUIMQBzQGtQSHHfpU
 t
X-Google-Smtp-Source: AGHT+IHPRcLm4FnWUA6AOh9rEKiut+/J70ZAHoCbo9uxNzlNuI1UUKqrSPh76VqbQXTu9EOvwVKwPg==
X-Received: by 2002:a05:6512:3b10:b0:533:c9d:a01f with SMTP id
 2adb3069b0e04-536587a6704mr14952557e87.4.1726067529788; 
 Wed, 11 Sep 2024 08:12:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25926ee8sm627279466b.50.2024.09.11.08.12.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 08:12:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH v3 0/5] license: Fix typos and update SPDX tags
Date: Wed, 11 Sep 2024 17:12:01 +0200
Message-ID: <20240911151206.60368-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

Series fully reviewed (thanks Thomas & Richard)

Since v2:
. Updated few missed "2 | 3+" expressions

Since v1:
. Updated regex to cover all GPL-2.0* cases.

- Fix a pair of typos
- Upgrade the deprecated GPL-2.0+/LGPL-2.0+ SPDX tags
  to GPL-2.0-only / GPL-2.0-or-later / LGPL-2.0-or-later.

Philippe Mathieu-Daudé (5):
  tests/functional: Correct typo in test_netdev_ethtool.py SPDX tag
  license: Simplify GPL-2.0-or-later license descriptions
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
 include/qemu/timed-average.h            | 4 +++-
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
 block/vdi.c                             | 4 +++-
 gdbstub/gdbstub.c                       | 2 +-
 gdbstub/syscalls.c                      | 2 +-
 gdbstub/system.c                        | 2 +-
 gdbstub/user-target.c                   | 2 +-
 gdbstub/user.c                          | 2 +-
 hw/net/eepro100.c                       | 4 +++-
 hw/nvram/fw_cfg-acpi.c                  | 2 +-
 hw/ppc/rs6000_mc.c                      | 4 +++-
 hw/virtio/virtio-acpi.c                 | 2 +-
 util/timed-average.c                    | 4 +++-
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
 66 files changed, 78 insertions(+), 66 deletions(-)

-- 
2.45.2


