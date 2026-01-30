Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F5BD49C69
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 07:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlioI-0004Vj-Sw; Fri, 30 Jan 2026 02:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlioF-0004UG-Dx
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:20:51 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlioD-0006u4-NA
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:20:51 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso1120960b3a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 23:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769757648; x=1770362448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R6yegkBHtabSHKXnUJDgRDiFmje8njaONnVxPtzhyHM=;
 b=Iqs8OeA3MKcPT3ZH7nISaROETUQihqmlver3+5u9+PAP1a18JB2rbz5i1h5ofE0Hm2
 IW486cMyLveJHHvyOT0I94SHwc9M60y8LWTPWMeVg6u58UYzeokSP65wsTd7+vMbMQAI
 QgypjEKG6bW+ufIHZNoQxQeCnKB1zZ/z/xpu0xrOnBIuJYCs53LYurSvaMjYLosjNWa/
 psdP0XRBdmhnLI5lEtwFfvW/IPVWJrl44yAIMCY6DwN6X+Jl/x8DH3DZ3P4zFO/n/Zwd
 eVeH/Xg4Djyxx04u1nrPQQ7QTT5uxdAPZRRBk1HtCnOo2C6V6ERGkkckeNGClLQ7FwC4
 Q67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769757648; x=1770362448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6yegkBHtabSHKXnUJDgRDiFmje8njaONnVxPtzhyHM=;
 b=sIuy42pm+lnxcXMQiazVbsDNOZEcjKiYzYkXhy6tyLt+SKVBx/Cskt1kJxcO4iF+K9
 ei3wz9lllLM0XyMnP4uU65Lt1QNSa3gM2qOpOHLr3Wv7oWG3Q6/HLQL9LOqyAkDbzjev
 FBLsF/xNkZGZhWawOqKxzfS7VSEkjwjVxPsc0zQazyIemuYjnXqzvvOUcZCXoVLYnM7j
 G7bEQw4WI4ZaOlNNxjlnc8lFVcp2Khq69vOhHPgZFjlo0/xUnXh/KJxxvHu/F/0lBS/o
 gaJl9ip54nFXjoAZpfIQjQCX2SLZfYkLeHrVLAONX8jRtG8cn6FxCNolVd+32M3L5BBX
 78KQ==
X-Gm-Message-State: AOJu0YxnZZfMTbrbfwTy0d4FZmElfKt1DEJozjKcy1+pn8rxQLusjLMw
 TEXJmFD67nOwqxJmIjCXHmdwD51aVee6JCS5gd523RR1Fa5v0E9fFPHz
X-Gm-Gg: AZuq6aL87rSN+b82/TxrPuYndueKK3JS1iLJbiZC0XbIX4EGaBLKt0yq589fj9cLeyp
 AGi5iyJ4sE+ESexbTN/0kuSviSKVUBMju2jbjlh0ibqYT+qKV+svUEQsJunVrgbOZlQZ5llKAcA
 A6DGxVpjCVoX1bc15J6j7usZSUjOQjdi2CiZSY0R2aJ9AhGfyOEZl1nvl1mssNV1kPnMAY8wCqI
 pMTolSQzI0H1iAO6cq5oVqzufpYO0hky5hPnjQaBAzlUzZ2II3Uyak9pyLK7V9ips+7CPJJOXc8
 8nq6igwsq4TDqZ5KXch7ogr7XbCPLB2LYRI2GDcDxJbHJGnJvR2dDm+3Y/5kp6cI3CMKZCUbMoL
 lkZSaoRZwmOTjrk9l1U6ibegb4EydlJ/QeGGHAFeLdkZCl3yTLEzxsLbpE/l7FXIs0IAFRa1L7M
 EIWepOuhQvYouzYrP/z5//YSt0/EKe+NdTlhIi5k37rvJFbu/6zIXOyVpNcLE=
X-Received: by 2002:a05:6a00:4285:b0:7e8:4587:e8b5 with SMTP id
 d2e1a72fcca58-823aa70f3b6mr2340841b3a.40.1769757647886; 
 Thu, 29 Jan 2026 23:20:47 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.20.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c227c2sm7269905b3a.53.2026.01.29.23.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 23:20:47 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
Subject: [PATCH v5 0/5] Add support for K230 board
Date: Fri, 30 Jan 2026 15:19:38 +0800
Message-ID: <cover.1769757064.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x443.google.com
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

This v5 series has been rebased on Alistair's riscv-to-apply.next branch [1]
and is ready for review.

Test command:

```
$QEMU -M k230 -bios [OpenSBI binary] -m 2G -dtb k230_canmv.dtb -kernel [img]
```

PATCH v5 changelog:
- Rebased on Alistair's riscv-to-apply.next branch.
- Patch 2: Fixed reset vector ROM jump to trap-handler bug.

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
2.52.0


