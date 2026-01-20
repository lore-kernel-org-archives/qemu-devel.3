Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E44D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 04:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi3p5-0002H4-Lk; Mon, 19 Jan 2026 23:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi3p1-0002Fd-EN
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 23:58:31 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi3oz-00009I-F2
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 23:58:31 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2a110548cdeso32798875ad.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 20:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768885108; x=1769489908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NVI3ApO7RmLFbE/3IFLmPIZEGchwJ5z1FrZzmRnT3W4=;
 b=a7sfRDjAAWTRMRnkp91qnD8i9Q/87UIA6U5E7hnP23zKSUx0RdkVfOiH9Nb9Qwog5s
 +MVvGQGfAyMSxGVqaAwIBl+bUwG/lVuLLHsgFC6RmXxUZDz5jOO6iguE4zDrZJMOOgHw
 RwZpZgxMx6sYy1FkAa8J15NeeTOW2xif5D7jQWacNSF0spYHc7zcPZFU5UQcGdyD9zqf
 IeF0cShlQjD3wihx/BfbbT4AgGeEWN06kVm89ePVi9Viw+ZHNJbOKyCTrjgtUUZqUGqO
 OZLzrw+CkmhxxjPVGy/OnIGBkt4iq86kmkl1NHQco3kBo4PR00NJdzalA+k7VSr3Frme
 SRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768885108; x=1769489908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVI3ApO7RmLFbE/3IFLmPIZEGchwJ5z1FrZzmRnT3W4=;
 b=k1bI8b0566QnVBz+r2sJ8fJkCbNmfGLVURnDg1h7unqMgel+BWCg7HoOHWm95uz6qL
 ykgvfZ0l0rDH7KqBATW68lAuBgLVfzZdViYUrJOnpXfu83MF8mTo9Ccjv74KGBRrXsXu
 ge+WmIJBLX5xjp+/rWvIW834Oh+7tk3SoGvNrfwcGlKIbFMyKzJjj6zVKUy6W0hQQAyt
 p5uzNK8draY3iA/08Z0o1olCVt2gwj0tYYnQIEgPMezgMSLNIkK/MP6epsrRuZU6P0fo
 AH6ScX8nKtKnhcYuMmGKUsdSPG6XnNrdzRKhb/A992iFPoWpa7l72P1aTXcZkPO3MgMX
 /SDg==
X-Gm-Message-State: AOJu0Yw8EqYqbhl/GjUQ1IiQo2H6NwJrtW21THjidudW72HW7nP2Brc5
 XVw86yc0x3oQqSGXbpUvX6k3x2pR4KH6bjrBeedPzVJXKDJCEldYT5Bo
X-Gm-Gg: AZuq6aJJjRal3imq2cEEouEgtoQ/14JI99GyhsZM7rScprFVC7u48EslggwbgWRYWlJ
 3g3nIs+ITeSiSxF6yinpDIApqyY6krqbPm3KxX96R2rEYJv0smEcA3qd5Si7la8JQV+D2E8regN
 bRG7XITraDP8ZgFaa0UR4mH+oIakgtGcV8wsxzCKEXjYV7cWwAl2ZyVtY3HoPvX4xSoQ9RM0dZ2
 3y4UVqGv+Edr6PzKUgwZKSw8T/267nJbuVUVpoFHmrxKy97fayAlqKiVlC8ckgLFQh3ecyqwAm+
 aB8GpyzniWmBJekEiG+i+dAAIuH0R5LdsVxdNnADnyvMvwMTrVyWl+IdGYOoROmSxhQk+iPhC8A
 TGFDbTHrDXcX1iDbgCOi3Q+jCmH4x8JlmWjedofphOcqlwLlpG+186WsmbZLveLh71VGS8kVNIz
 L8Wq3joBfCQ8/d/I1YzUIuKb7F29vy8YV6h1VD0V+U89/K2q3aMfNoFNx66etjmuD0pA0Utw==
X-Received: by 2002:a17:903:37c4:b0:29e:facd:7c02 with SMTP id
 d9443c01a7336-2a7175be530mr124153205ad.28.1768885107946; 
 Mon, 19 Jan 2026 20:58:27 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.21.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190d14cfsm110703045ad.38.2026.01.19.20.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 20:58:27 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v4 0/5] Add support for K230 board
Date: Tue, 20 Jan 2026 12:56:50 +0800
Message-ID: <cover.1768884546.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x643.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alistair,

This patch series adds support for U-Boot + OpenSBI + standard Linux kernel on
K230 board. Thanks to Peng Jiang, Mig Yang, Renzao Ren, Yao Zi for their help.

This v4 series has been rebased on the latest master branch and is ready for
review.

Test command:

```
$QEMU -M k230 -bios [OpenSBI binary] -m 2G -dtb k230_canmv.dtb -kernel [img]
```

PATCH v4 changelog:
- Rebased on the latest master branch
- No functional changes from v3

PATCH v3 changelog:
- Patch 1: Align T-Head C908 CPU's RISC-V extension with XUANTIE-QEMU
- Patch 2: Adjust PLIC and CLINT addresses to match K230 datasheet
https://lore.kernel.org/qemu-devel/cover.1765816341.git.chao.liu.zevorn@gmail.com/

PATCH v2 changelog:
- Patch 1: Add Svpbmt extension support for the T-Head C908 CPU
- Patch 2: Move the k230.rst definition from MAINTAINERS to Patch 5
- Patch 5: Apply Daniel's bugfix to build the k230 documentation successfully
https://lore.kernel.org/qemu-devel/cover.1764830405.git.chao.liu@zevorn.cn/

PATCH v1 changelog:
- Patch1: Add T-Head C908 and C908v CPU support
- Patch2: Add K230 board initial support(big core is not supported yet)
- Patch3: Add Programmable Watchdog Timer (WDT) peripheral support
- Patch4: Add QEMU test for K230 watchdog
- Patch5: Add documentation for K230 machine
https://lore.kernel.org/qemu-devel/cover.1764493931.git.chao.liu@zevorn.cn/T/#t


Thanks,
Chao

Chao Liu (5):
  target/riscv: add thead-c908 cpu support
  hw/riscv: add k230 board initial support
  hw/watchdog: add k230 watchdog initial support
  tests/qtest: add test for K230 watchdog
  docs/system/riscv: add documentation for k230 machine

 MAINTAINERS                    |  12 +-
 docs/system/riscv/k230.rst     |  48 ++++
 docs/system/target-riscv.rst   |   1 +
 hw/riscv/Kconfig               |  11 +
 hw/riscv/k230.c                | 501 +++++++++++++++++++++++++++++++++
 hw/riscv/meson.build           |   2 +-
 hw/watchdog/Kconfig            |   4 +
 hw/watchdog/k230_wdt.c         | 307 ++++++++++++++++++++
 hw/watchdog/meson.build        |   1 +
 hw/watchdog/trace-events       |   9 +
 include/hw/riscv/k230.h        | 153 ++++++++++
 include/hw/watchdog/k230_wdt.h | 130 +++++++++
 target/riscv/cpu-qom.h         |   2 +
 target/riscv/cpu.c             |  51 ++++
 target/riscv/th_csr.c          | 380 ++++++++++++++++++++++++-
 tests/qtest/k230-wdt-test.c    | 199 +++++++++++++
 tests/qtest/meson.build        |   3 +-
 17 files changed, 1810 insertions(+), 4 deletions(-)
 create mode 100644 docs/system/riscv/k230.rst
 create mode 100644 hw/riscv/k230.c
 create mode 100644 hw/watchdog/k230_wdt.c
 create mode 100644 include/hw/riscv/k230.h
 create mode 100644 include/hw/watchdog/k230_wdt.h
 create mode 100644 tests/qtest/k230-wdt-test.c

-- 
2.52.0


