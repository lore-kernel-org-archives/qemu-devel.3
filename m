Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E470FD5B841
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 15:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVAVw-0006Jm-Ck; Mon, 15 Dec 2025 10:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vVAVS-0006AN-IR; Mon, 15 Dec 2025 10:29:05 -0500
Received: from out28-59.mail.aliyun.com ([115.124.28.59])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vVAVO-0004Ad-6e; Mon, 15 Dec 2025 10:29:01 -0500
Received: from ZEVORN-PC(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.fkrAZgR_1765812515 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 15 Dec 2025 23:28:36 +0800
From: "Zevorn(Chao Liu)" <chao.liu@zevorn.cn>
To: pbonzini@redhat.com, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, 1440332527@qq.com,
 3160104094@zju.edu.cn, temashking@foxmail.com, ziyao@disroot.org,
 "Zevorn(Chao Liu)" <chao.liu@zevorn.cn>
Subject: [PATCH v3 0/5] Add K230 board and thead-c908 CPU support
Date: Mon, 15 Dec 2025 23:28:28 +0800
Message-ID: <cover.1765811173.git.chao.liu@zevorn.cn>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.59; envelope-from=chao.liu@zevorn.cn;
 helo=out28-59.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

 MAINTAINERS                    |  10 +
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
 17 files changed, 1809 insertions(+), 3 deletions(-)
 create mode 100644 docs/system/riscv/k230.rst
 create mode 100644 hw/riscv/k230.c
 create mode 100644 hw/watchdog/k230_wdt.c
 create mode 100644 include/hw/riscv/k230.h
 create mode 100644 include/hw/watchdog/k230_wdt.h
 create mode 100644 tests/qtest/k230-wdt-test.c

--
2.51.0


