Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD49CD0421
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd05U-00051h-6k; Tue, 06 Jan 2026 00:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05A-0004Yj-7l
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:16 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd058-0001rn-BG
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:15 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c84dc332cso714628a91.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679093; x=1768283893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vv8gsGomA/loU05EEpIQ2SGJs0ppGtppGMsdkJPddME=;
 b=hPG4jZatES/XAAdUJrBLgtfUP1Kh3Uq1HHboxSARR6DS7hlvYqPxwhCQu/lRAr0XXB
 SquXBGXHY64PQpgPXrl04oKHJU0EtM47mt+NQTFGuA18jMFS9dJSM3yn+ljf4M/Dp6EH
 S6tlQtZIaSzcEd9Vi07g07o+qTtvK4c6k/EYGKap43Humt7NP6y6A1jaJVIbcO4FnwCz
 HZ3vSGpEYzVk7cWEyX+l09WRiU6XjQwWn4IlW1gNPbNXFVnb7KXBT7+lYSAUH6/D+oNQ
 eDh/q8zj3y+FIB4fy8qbNpp01zNY6TQz8WlMKNyrclsJgFU1aDboSIo8831RBSqlq/RR
 62JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679093; x=1768283893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vv8gsGomA/loU05EEpIQ2SGJs0ppGtppGMsdkJPddME=;
 b=TIEFkWBqeWgdRErdI+4dHSRDWyV8mJvVs2xOGpZNP7peBSW1m7M26afX5z4J5dn+eG
 sZr+N6iHqBEuBNfH4kkeqgj6RwfQknytolmsfsblcBYutOWS6WADKrDbRhGCcber/qQ7
 in3TwP/2Zn/DwXEXqJYX1VIHMcJt1xeghjRR9x5KhGuSpUz2K8j14xbQ2BkPduy5Dc/C
 SpDGRTQj+WXrs71BGylDYFnKfQXRYsemaFyqLKWTN0fQaAwJDKhd4a320udn1at88q5B
 ge0m0fg8fvaN9EI9CEE+enMO+TJlpY+fO3TTas9FduAZGQ7g6cxPSE7C0Flt+23LzG1/
 tWjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5akTfdpt7ge5vf25WS84iDuhv7mm9TJuX76swl8EJc5ToWHVO2oWaTbtkNJ8VzMFyWzQQEimo0W9j@nongnu.org
X-Gm-Message-State: AOJu0YwCYimTSG618fHS94v4wlUetr/V2rXI5mcFVU22y4M4eJbCkTVt
 9lsooYvL3MV6seDrpheH1NMABeDSpgqOOSjkpD/FXVasOiD54XthPOmS
X-Gm-Gg: AY/fxX59N/IWYH5YBHgiuqLkE2R1/m+FMhNTDPCKC3XPA2DK6CeX92M8AQUAEg61wdC
 OZRxJiM21FrXYIxpzzr8J1DBuQmg8aBacz9Wr2uzFKXW/Zq2z4dl/oSMTwpveR7fZ4Td8bqd5F0
 Wyi1XM71l+N+VJIOHNvGXtDL4DMIumstgOKCRnftKBr1BD29TuNc999qzPbP5MAp5kxbpQlNgCt
 M5faWYRJZIT/miPjJcMP93qExBxtXu7l4KkBfONliY1q41mcX0bZrxvED7ZWX6rv94WcGbyvety
 DtwKHznL0ffBx/ogsWW+xLKxEv1oNd9mp0V8fuphiXBzv+GQKo6VuB1RbYKMdAPdJhKdoZMwRD7
 o2+3WBi4j2nqu5dZuyn/bFhhXG4uW1nv6y5xhtUPWqaBtLkzocSjDIdwfLz53ggNWdD9EZcf8n3
 A3Em2s++pa//WvAD19CYMf
X-Google-Smtp-Source: AGHT+IGNgd0nCN95bmxIOyBl6HehRr4qwFcofTuATPYRpDq91rsSDhL5mXV0lJxNK6QxIqi85NPqRQ==
X-Received: by 2002:a17:90b:2d4e:b0:34a:a1c1:90a0 with SMTP id
 98e67ed59e1d1-34f5f333222mr1488555a91.28.1767679092918; 
 Mon, 05 Jan 2026 21:58:12 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:58:12 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 10/16] tests/functional/riscv64: Add tt-atlantis tests
Date: Tue,  6 Jan 2026 16:26:50 +1030
Message-ID: <20260106055658.209029-11-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Add OpenSBI and Linux boot tests for the tt-atlantis machine.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS                                  |  1 +
 tests/functional/riscv64/meson.build         |  1 +
 tests/functional/riscv64/test_opensbi.py     |  4 ++
 tests/functional/riscv64/test_tt_atlantis.py | 68 ++++++++++++++++++++
 4 files changed, 74 insertions(+)
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ae05f7e8d00..ece904fedccb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1731,6 +1731,7 @@ S: Supported
 F: docs/system/riscv/tt_*.rst
 F: hw/riscv/tt_*.c
 F: include/hw/riscv/tt_*.h
+F: tests/functional/test_riscv64_tt_*.py
 
 AMD Microblaze-V Generic Board
 M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index c1704d92751b..52d5cb117a39 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -11,5 +11,6 @@ tests_riscv64_system_quick = [
 
 tests_riscv64_system_thorough = [
   'sifive_u',
+  'tt_atlantis',
   'tuxrun',
 ]
diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/riscv64/test_opensbi.py
index d077e40f4278..0f8beb7e7a8c 100755
--- a/tests/functional/riscv64/test_opensbi.py
+++ b/tests/functional/riscv64/test_opensbi.py
@@ -28,6 +28,10 @@ def test_riscv_sifive_u(self):
         self.set_machine('sifive_u')
         self.boot_opensbi()
 
+    def test_riscv_tt_atlantis(self):
+        self.set_machine('tt-atlantis')
+        self.boot_opensbi()
+
     def test_riscv_virt(self):
         self.set_machine('virt')
         self.boot_opensbi()
diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
new file mode 100755
index 000000000000..fb6943509c28
--- /dev/null
+++ b/tests/functional/riscv64/test_tt_atlantis.py
@@ -0,0 +1,68 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Tenstorrent Atlantis machine
+# and checks the console
+#
+# Copyright (c) Linaro Ltd.
+#
+# Author:
+#  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import Asset, LinuxKernelTest
+from qemu_test import skipIfMissingCommands
+
+
+class TTAtlantis(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
+    ASSET_ROOTFS = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '9819da19e6eef291686fdd7b029ea00e764dc62f/rootfs/riscv64/'
+         'rootfs.ext2.gz'),
+        'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
+
+    def do_test_riscv64_tt_atlantis(self, connect_disk):
+        self.set_machine('tt-atlantis')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=sbi '
+                               'root=/dev/vda ')
+
+        if connect_disk:
+            kernel_command_line += 'root=/dev/vda panic=-1 noreboot rootwait '
+            self.vm.add_args('-device',
+                             'virtio-blk,drive=drive0,serial=0x1234,bus=pcie.0')
+            self.vm.add_args('-drive',
+                             f'file={rootfs_path},if=none,id=drive0,format=raw')
+            pattern = 'Boot successful.'
+        else:
+            kernel_command_line += 'panic=0 noreboot '
+            pattern = 'Cannot open root device'
+
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+
+        self.vm.launch()
+        self.wait_for_console_pattern(pattern)
+
+        os.remove(rootfs_path)
+
+    def test_riscv64_tt_atlantis(self):
+        self.do_test_riscv64_tt_atlantis(False)
+
+    def test_riscv64_tt_atlantis_disk(self):
+        self.do_test_riscv64_tt_atlantis(True)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.3


