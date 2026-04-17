Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4883F436B4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkri-0006RP-9K; Fri, 17 Apr 2026 11:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDkrg-0006Qx-BZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:12:16 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDkre-0007eZ-KX
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:12:16 -0400
Received: by mail-vs1-xe44.google.com with SMTP id
 ada2fe7eead31-612d8a59ca0so535550137.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776438733; x=1777043533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7zAGXxsg+5cVA6Q3sFJNuuhruZpzrgtVk1o7C5t7Zk=;
 b=lAEzeI3aoDwb7GkI+nZfS7tYSciAXRaMg1c7ALjHKqOvV9YdiPE+OX8+AA99vHFpZo
 nN9fb32Ft4UDOBXXfHwRI0eLrCO+G6+HhSchcF4TFcRluJroIayIShBBTLBi17KocaUR
 UC/aBAVAleXxZwQ7Rtw9WiTo8dd25hQwU81B1JBVhhhb6xQHsNNXuGtZUHffJAEayWuV
 2wQlPt06TQ9gNpNLEFHHEBhNQm/Jfl9PSTvtH2ett71NKJY3qcSgY4eAzbW6ZF5YkUJS
 C235Ej1TYpANExR5IsyF1Zn7bPCXNUVI1UZ+H0/AIfm0itBGiejHj3zm9Q4DRd2fy/8Z
 92KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776438733; x=1777043533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7zAGXxsg+5cVA6Q3sFJNuuhruZpzrgtVk1o7C5t7Zk=;
 b=lzzt3uImrVHj2QXpD07AH0pESugQ43pVUqvqUnWKO0BQJuacpP71NFKrYd3gUiLlhA
 TpAhvRMwWYvNHo6RPyFbmAGu8ja7RugWa2/U3zNhxbPI7E8ue/6/dSM9jiSgyAX3QQJj
 53Vj55DJ7YvoO74mmzwf2/xt8D8KD4TRo9GqElBP4tBjV+8XRucOkkLGN/mg59fBo7Lq
 h3D4rf3kXzo0WdnC3ACp52dAFm+cMgz+VJvzWhuRaMAgAsPWB+sP4CfkXjhxs8oGPvOB
 +Ubz4VlIMfbCHPVue6wgt7wMPu+Fuvz3vwcNg29+nSrmfT4oydPj7ay2jE4qH4xt1BJY
 cGcg==
X-Gm-Message-State: AOJu0Yxr6egurmzqpTrCK7V6fGgqnqn/48GxhfRRpf9C6gYZY2dnUL1v
 6RQyV7LSl/Zu7Ttvmk9SnmX6oBdgKHb3X7S9fwVsdgtkEemg0W7WNg0t
X-Gm-Gg: AeBDiethSvjehVriOHRFVSnLWG3C7c68fMQ+SXt69kJaoKQSA0/vaTF1g4KVv8pvuQp
 EXW2t4LbNzWqQUIdrIRXpFY0uq+Rp/2ypFuNdcW7TwvN4QS3Pn9sw5oDNQSX6ubltiC1DaIk+AI
 YPUfzRlfWLF5C9xu61iO6FYeabuIqs8HKCL48xrlk4vLjTKZW1Mrhjv2yqZNxfSlBRa7GpqEzDk
 zQS1kfJ2elPZJArz7AeUD2mzaFEprQkJK0uzExt1OIGnwYtfD9aOQl2R2w26wJ1sxZ9pr2B66ID
 oRnDhd3Za1iTVMttgIxRHXvhPDceOW712ZtAU5qJh/GMqWpzwq40oupVvhfHPM3OA5BJ1FREOWN
 lOjxuua9pMU6tDbrsyqJysTObS9pU9und7NYZVubGTi1tAz1Q9oRACPAWZ6dTTs/pVc+Th9xC7q
 Hp/3zGAHSt+EZIE5sSftNv+KDLFzL05BPcLFwMOF8JaDwcKUimi92NWVI9lI5y3hGoKBGtuPzLr
 XFDb5o=
X-Received: by 2002:a05:6102:419f:b0:604:f029:224c with SMTP id
 ada2fe7eead31-616f4d6abf2mr1635676137.8.1776438733120; 
 Fri, 17 Apr 2026 08:12:13 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-61747cb501asm788923137.7.2026.04.17.08.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:12:12 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v6 0/5] Add support for K230 board
Date: Fri, 17 Apr 2026 23:11:24 +0800
Message-ID: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e44;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-vs1-xe44.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This v6 series has been rebased on Alistair's riscv-to-apply.next branch [1]
and is ready for review.

Test command:

```
$QEMU -M k230 -bios [OpenSBI binary] -m 2G -dtb k230_canmv.dtb -kernel [img]
```

PATCH v6 changelog:
- Rebased on the latest Alistair's riscv-to-apply.next branch.
- Patch 4: Picked up Fabiano's Acked-by.

PATCH v5 changelog:
- Rebased on Alistair's riscv-to-apply.next branch.
- Patch 2: Fixed reset vector ROM jump to trap-handler bug.
  https://lore.kernel.org/qemu-devel/cover.1769757064.git.chao.liu.zevorn@gmail.com/

PATCH v4 changelog:
- Rebased on the latest master branch.
- No functional changes from v3.

PATCH v3 changelog:
- Patch 1: Align T-Head C908 CPU's RISC-V extension with XUANTIE-QEMU.
- Patch 2: Adjust PLIC and CLINT addresses to match K230 datasheet.

PATCH v2 changelog:
- Patch 1: Add Svpbmt extension support for the T-Head C908 CPU.
- Patch 2: Move the k230.rst definition from MAINTAINERS to Patch 5.
- Patch 5: Apply Daniel's bugfix to build the k230 documentation successfully.

PATCH v1 changelog:
- Patch1: Add T-Head C908 and C908v CPU support.
- Patch2: Add K230 board initial support(big core is not supported yet).
- Patch3: Add Programmable Watchdog Timer (WDT) peripheral support.
- Patch4: Add QEMU test for K230 watchdog.
- Patch5: Add documentation for K230 machine.

[1] https://github.com/alistair23/qemu/tree/riscv-to-apply.next

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
 hw/riscv/k230.c                | 502 +++++++++++++++++++++++++++++++++
 hw/riscv/meson.build           |   2 +-
 hw/watchdog/Kconfig            |   4 +
 hw/watchdog/k230_wdt.c         | 307 ++++++++++++++++++++
 hw/watchdog/meson.build        |   1 +
 hw/watchdog/trace-events       |   9 +
 include/hw/riscv/k230.h        | 154 ++++++++++
 include/hw/watchdog/k230_wdt.h | 132 +++++++++
 target/riscv/cpu-qom.h         |   2 +
 target/riscv/cpu.c             |  51 ++++
 target/riscv/th_csr.c          | 380 ++++++++++++++++++++++++-
 tests/qtest/k230-wdt-test.c    | 199 +++++++++++++
 tests/qtest/meson.build        |   3 +-
 17 files changed, 1814 insertions(+), 4 deletions(-)
 create mode 100644 docs/system/riscv/k230.rst
 create mode 100644 hw/riscv/k230.c
 create mode 100644 hw/watchdog/k230_wdt.c
 create mode 100644 include/hw/riscv/k230.h
 create mode 100644 include/hw/watchdog/k230_wdt.h
 create mode 100644 tests/qtest/k230-wdt-test.c

-- 
2.53.0


