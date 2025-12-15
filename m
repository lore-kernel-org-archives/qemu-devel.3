Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE6ED5B84D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCAw-0007rS-Mx; Mon, 15 Dec 2025 12:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vVBx4-0008LM-3m
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:01:44 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vVBwx-0004dI-Mq
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:01:37 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7f0db5700b2so3261774b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 09:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765818087; x=1766422887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xopHPIY5pceYaVHWOTdnaoLrChgWcBcrxsSFmvaspCU=;
 b=g3RkZmgF9lV3aoSNgx1FxX/+B8IDbYXS5l7P1MoyKXWBTnxR03HMIrfBUltyrdGr27
 tumWztWya2OoBBBERSuYalb9ScnO6y6t+FFvkW73UVJ6oT+Hhwp9OogzTG+C7XYcTxYD
 UQiJ8IrFv25TzaffH5NhyuqqD0ES43OaaSvlrugPVJicbMfIYGJbEiIu5yN423ZNcVvl
 BZbFfPLKyPCXuLgigss/u62xUymkXDTQnbxOLzyAcLapP1x5J/htmEL7FiFjJORP7WAG
 9GhLOkeHyPMV4sh+UVuv9HoqMdrU/BmzZTztebAvP0UN5O3hS0fg0Q4l0gGW1xj0KYQT
 wz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765818087; x=1766422887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xopHPIY5pceYaVHWOTdnaoLrChgWcBcrxsSFmvaspCU=;
 b=AWheffeE1BVStHJg4HjSoqRPj66AYgQyji7TRCsNw3nLhElXy6TCANhZFbiQLYzBn0
 bKQbtuBQKDzz05d8yEFwQKMRDzjuyz3yD2nQGgG5WRl1GCCS1+U6Yx3XxIPxNaMg9sEA
 4Jm2UmTnKWHp5eU5b0raf+/SRJ4NJf6gY8G6ZltcD08aPio4xXDWGcqmiI4qhf8vaJkR
 tLjvMtqZG6L1EqC2St6brVBiQX6bQm3N4jYVsMGnhyVc6+qLB8fxCU6d/8Mz2RBL35tY
 0mH4cxb1YFzlPRV33iAmGVScaK6VTKJQeud1y+thu7cncPEstMfBGYCYP3njvzQQOp6R
 KIiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxjHFH+FM1TqZ8gf2iTdXjW2vO9cqonOjJT56D5v5zvjgiwizgvymVESyvIYHTBKcRDlkfEiZnMcB5@nongnu.org
X-Gm-Message-State: AOJu0YyZJlc+uMfsIE7Xmk4kSncAovi9y++nleTlF8Gxc4knNiN/jWAd
 aliNGkBmTTJi3rqn2arl3lXYl9wprP85J5fyXoBujwB6xGyzHE4v9O1x
X-Gm-Gg: AY/fxX7w2Hv4MUU2ftqCmUfypHcLuhOSdbWKW2tr/9n4jZf3LpnZoA4tr07hbRs3a6J
 QDcZbiOXQnTRI0M6d2BcJuiuzdmAFylK7hJn+5XGTjna42aOKGB6Ukrh1kzqXaY0QZ5OsrQjJJV
 mXUWsCS4oy1ypys29tjO0KxfuuJnBPlfhLGz0EYvvymx3927qMdRJ8X77H+mL7xnoTzopScfnHu
 jS0XBqlbiqOnxNAjV13mey3tYRejP3j9kMGpUXt2cIAkcyMRkqwRRt73q5QWi/pBKoNIj2JwlGf
 rUY4Y2UyMc8h5hQQWzf8losfr29GVcT2BZXVInV2miblTKu+d9iWRzK9QGmxyvausJmUQ995EcK
 xvee5M9b9XYXx1QKUFw2xXVRNgG8ylJITlnUEFYCGltDa/pbWGxYv+63YG6B7EuC/aZXXN/p8Cm
 Zugh7MdHnydOjfAFEM3ed6W8t3Acl6Hg==
X-Google-Smtp-Source: AGHT+IEclvjucFMiGeMjQQmV94bOQPV94Xg4DdjYS+XlJpRKfKS/jA5E/+TYlfYj6rG0exTLYuTBhQ==
X-Received: by 2002:a05:6a20:728a:b0:35d:2984:e5fd with SMTP id
 adf61e73a8af0-369ae48e4bcmr11065963637.32.1765818085960; 
 Mon, 15 Dec 2025 09:01:25 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c2589d4f7sm13132788a12.3.2025.12.15.09.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 09:01:25 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: pbonzini@redhat.com, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, 1440332527@qq.com,
 3160104094@zju.edu.cn, temashking@foxmail.com, me@ziyao.cc,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RESEND PATCH v3 0/5] Add K230 board and thead-c908 CPU support
Date: Tue, 16 Dec 2025 01:01:13 +0800
Message-ID: <cover.1765816341.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Dec 2025 12:14:57 -0500
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

I have updated my email address to chao.liu.zevorn@gmail.com to avoid email
delivery failures.

This patch series adds support for U-Boot + OpenSBI + standard Linux kernel on
K230 board. Thanks to Peng Jiang, Mig Yang, Renzao Ren, Yao Zi for their help.

Test command:

```
$QEMU -M k230 -bios [OpenSBI binary] -m 2G -dtb k230_canmv.dtb -kernel [img]
```

PATCH v3 changelog:
- Patch 1: Align T-Head C908 CPU's RISC-V extension with XUANTIE-QEMU
- Patch 2: Adjust PLIC and CLINT addresses to match K230 datasheet

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
2.51.0


