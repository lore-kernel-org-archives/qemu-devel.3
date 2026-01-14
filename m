Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D81CD31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsbV-00068o-3E; Tue, 13 Jan 2026 23:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfsbM-000682-Mc
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:35:25 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfsbJ-0008JA-R8
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:35:24 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b553412a19bso3687998a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768365320; x=1768970120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztnklFD3GnIMY96uOYyqD7VaK8orrIpX1h02am3gZbU=;
 b=YJGpTafItjU79GiNu3+NVkrN3em9WVSXMGy02eYw3bDWE40ZXi7nC3M0VG3Bq56eXr
 TfbfrbNuGiCUxnEJPwgYe41oLsEkqNEYxHyhPq313SWVYSGsb0YRRyxtTvcaKWeedAQ7
 UlzXpEqSKUKacqM1zXBuoMkLWWN7enkYLlCJOz43MeHvBFp3v9QIUmUZvAzO32Ljyzgf
 1AyEOaaULCDeCBnB+j+O/yaU5LPgvbcvMWqovzcSlFDACKbh5/g71P2noHdl0wMbiz2N
 k9/MmO6P4DjHNb/k50SSXWE2mU1Uuh2Ot63SwwPygMR0vgDXwsv0TFBOXP7/3b6paxqw
 LtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768365320; x=1768970120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ztnklFD3GnIMY96uOYyqD7VaK8orrIpX1h02am3gZbU=;
 b=jvMdKG+RCqwUr0x0BJdL94RIjh9lnhAms8wFleiAZrRIuOTfismht5s+HON5iDhWMe
 NOK4/9V/5tTCqa/hMy1dPfaai6B8wDumFUDICey/aWo1CzgHAZ8Nq5umGT5FFA59rzcb
 84dgqU3sq4b4Kjc+cKErQoVlKyBgZ04OYauJEbExW6kaV4zeEVogGX20T2CvecCKtDCY
 dTPnxz1AkZlBVXWDgkHXOLKq6b4JR3dc6H16j3dxTX56wpErPWzWH2BMeFiOcD0/7o5Z
 8aGGapiGYJlHuSceJ3ajqYMrbewX8ktOcCPLx44GchekX4Zu0UyqsNVzldLJZhY5+3Tk
 AI4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/WFxLaSTjfSy8/AVAuV8EqUUPTvHjl5QcVMuO+L7i+uQOcCnKG37rvcUdDiciRC3fvyXwh/jhUJD7@nongnu.org
X-Gm-Message-State: AOJu0Yx+ArUqQLZ4TKnUjH9PmqS3iv+/DeIvPBt+tfhRkqMm9D129TJD
 T8lqLBM0bG/wVZvBgidJ6sTCbQp3SUU3T85vp8+XHNXgpYbT1laselQJ
X-Gm-Gg: AY/fxX6Y2lAZ7tBdScJ3DnB8ZC3JneBjD8B6K0XHGfc0h2fdiFHDQPWHY2gz3DGWM4e
 Om5KbxqheH08SzLhwdRI3YBhTJeDHB0NWviNnFAOmkhxGmJVXWliXgE7Z5rE5yVD5MNMikICHGK
 FLpXfS1KqA211fYzN1/sO3omDThlSICtHXj1VBIOQw2bWWtlDxI9/AZQxJDQ00ybBQIvj9O1Tkj
 lmkTtkZwMuUjpAbkuB3CAfsv3zDwBRZ4j5s/w7MPi3A0eiynBdzQrnZUWNbmzRhWti5rd6KgJnM
 0vSv9NJiZfJxr/WcumXjzaGwtyXakKI99WCStJ2AWXISmA+RBFRE0N7WdDWIiWK6Iq26KrQa402
 l9+vBBD30f4m0skMGjEry2ZfgkHUjPAlSxC37TkD7yswZ8uPlNefDOqSkErk4Q1/Rp8SpOggWt2
 Ge6xxHY8bMguOd872uM2/Z
X-Received: by 2002:a05:6a21:6d8a:b0:364:387:8f4e with SMTP id
 adf61e73a8af0-38befae57c7mr819941637.34.1768365320366; 
 Tue, 13 Jan 2026 20:35:20 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cb5352268sm20702659a12.0.2026.01.13.20.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:35:19 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 3/6] tests/functional/riscv64: Add tt-atlantis tests
Date: Wed, 14 Jan 2026 15:04:25 +1030
Message-ID: <20260114043433.1056021-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114043433.1056021-1-joel@jms.id.au>
References: <20260114043433.1056021-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
index 0acaf0a3f411..91f71077c40a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1732,6 +1732,7 @@ S: Supported
 F: docs/system/riscv/tt_*.rst
 F: hw/riscv/tt_*.c
 F: include/hw/riscv/tt_*.h
+F: tests/functional/test_riscv64_tt_*.py
 
 AMD Microblaze-V Generic Board
 M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index b996c89d7df9..c4456fabd757 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -13,5 +13,6 @@ tests_riscv64_system_quick = [
 tests_riscv64_system_thorough = [
   'boston',
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


