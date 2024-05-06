Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D15FC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 03:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3ocO-00074p-A5; Sun, 05 May 2024 23:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s3ocK-00073T-BP
 for qemu-devel@nongnu.org; Sun, 05 May 2024 23:02:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s3ocH-0008GE-Fy
 for qemu-devel@nongnu.org; Sun, 05 May 2024 23:02:16 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cx7+svSDhmNuIHAA--.22198S3;
 Mon, 06 May 2024 11:02:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxvlcuSDhmFvwRAA--.31503S2; 
 Mon, 06 May 2024 11:02:06 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] Add migration test for loongarch64
Date: Mon,  6 May 2024 11:02:01 +0800
Message-Id: <20240506030206.2119832-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxvlcuSDhmFvwRAA--.31503S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Migration test case is added for loongarch64 here. Since compat machine
type is required for migration test case, also compat machine qemu 9.0
is added for loongarch virt machine.

Migration test case passes to run in both tcg and kvm mode with the
patch, 54 migration subtests passes in 188 seconds.

---
v2 ... v3:
  1. Refresh the patch based on the latest qemu version, solve the
confliction issue.

v1 ... v2:
  1. Keep the default memory size unchanged with 1GB, only modify minimum
memory size with 256MB
  2. Remove tab char in file tests/migration/loongarch64/a-b-kernel.S
---
Bibo Mao (5):
  hw/loongarch: Rename LOONGARCH_MACHINE with VIRT_MACHINE
  hw/loongarch: Rename LoongArchMachineState with VirtMachineState
  hw/loongarch: Add compat machine for 9.0
  hw/loongarch: Set minimium memory size as 256M
  tests: Add migration test for loongarch64

 hw/loongarch/acpi-build.c                |  80 ++---
 hw/loongarch/boot.c                      |  10 +-
 hw/loongarch/fw_cfg.c                    |   2 +-
 hw/loongarch/fw_cfg.h                    |   2 +-
 hw/loongarch/virt.c                      | 364 ++++++++++++-----------
 include/hw/loongarch/virt.h              |  10 +-
 tests/migration/Makefile                 |   2 +-
 tests/migration/loongarch64/Makefile     |  18 ++
 tests/migration/loongarch64/a-b-kernel.S |  49 +++
 tests/migration/loongarch64/a-b-kernel.h |  16 +
 tests/migration/migration-test.h         |   3 +
 tests/qtest/meson.build                  |   4 +
 tests/qtest/migration-test.c             |  10 +
 13 files changed, 351 insertions(+), 219 deletions(-)
 create mode 100644 tests/migration/loongarch64/Makefile
 create mode 100644 tests/migration/loongarch64/a-b-kernel.S
 create mode 100644 tests/migration/loongarch64/a-b-kernel.h


base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5
-- 
2.39.3


