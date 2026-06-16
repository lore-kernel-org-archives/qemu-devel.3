Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32A7CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQin-0005u3-Rs; Tue, 16 Jun 2026 06:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQim-0005ts-HL
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:40 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQik-0003iI-NL
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:40 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c858b5de728so2759392a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604517; x=1782209317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6/HL728qanwHhItg7PFEzOq2yYEp9+MhTefHX4QvFE=;
 b=XjHi7wUFb6gn947VERBkK6WKRU8f+FM+SFYNap5Pqv1QAPMr/cdF9DlPcZ9kxSegnP
 Fh9lGpuExmXb7jslBEdfzl7otVybLWLmfYPSA5BtAcepWwtYrpCp+0A4WkE3OaPPZAaV
 JM3Uf+tMsN6fGhP4dFMha9ROHHh/lw6KIO1nBa0vDER7Sje1xA0QhqiTk6CL3AomJlCY
 9r0hOAaxKOy55eYONUa8PQmGcDb9smVY63X6zXc4UewVOSl6wE4fIcnBmgymurIv73bK
 8RQX0+2AxTlMYljNtKxo8YFmPhhz4xC8/VQQnIZFc7TKWvilV1omYNdDNPRPPVKALBu0
 N3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604517; x=1782209317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o6/HL728qanwHhItg7PFEzOq2yYEp9+MhTefHX4QvFE=;
 b=C7ihTii6Zmv6wpjDgEHnxxy+qk1bBJ7Zwzx6fvBzr7bhnggsVEjzTLwj0N25Lu+Ia/
 n2Tk+nwT5OWPiwziWZID8Zib7pDTh2ursW2YDyutvHl0sHRgDBu9q0jSD+qQZcwqDquN
 d3B2ENksfgw54RXCK3b8/JYmWCU8vBDDNKfs1joWec/AckMLgq81k/Z38n2Fxwf+tSOp
 mn/iWW+N3uvWcrtZ+TIyBjhddhIfciOZEW0nGUqPiggGBkZZV8xvd/RhIUzmoFZrFPLl
 eWimFaDBvSvaX2t4Du4HQUC7IGGOn8ChPL59DS2cs76+nITCROtOkVHpAf5eixzx3uti
 MreA==
X-Gm-Message-State: AOJu0Yx2poKzXAHUwyq54vk8kyF28h/xHT/WyhT2BchFwNlDVtbhHi75
 dX7mrqBynfchhHAhG8p3XzCnwVpogCtjnrcmR6tvLOToeh5wbWs+HhqXZX2ly62A
X-Gm-Gg: Acq92OF+8qO2CsUTZQ/B2zsJbxrXDtFmvDRaG0quduqio0m/SkB3pJQvHQi05Kr8cMC
 0UGpqQFybnNLYGUs0U7/TSeAyVgoFairEfPWhdaCQq19G7PGDp+bNcgmPDWTPJRnWxonUJP2Q9V
 LSn1IF547i5L0JTEQHRiMKZs7QVE1jbRyMFH75TjwkDsp8DR5RJ1wtg1fwxQD8fayNPz45/7QtD
 wf/nIQYTkLpeZTPrNkPgMuawqvTJSfN2Ir6BOT/Z+sm3mnN2I4MPdl4ATStRIcODTNgre3l8rUG
 2hRcRFNZ6+2PqOSFTVS5lz2O2u5GK8XBiYxgSLuzgGvn0C0PhCDzNIQXSUKK2D93k2Yw9E5NbNa
 YvfmAWrfcTzM1kW38A6ZgfF4aoB8LtFM7H8m0Xl0q2HjuIfX02/4LF3qlchxph+edU3hfzBgJ1T
 UE1mhAVNAtRGjH3jD2/0M53T22B+6JNTg7q9mQlQxM
X-Received: by 2002:a05:6a20:d049:b0:3b4:85db:1bdb with SMTP id
 adf61e73a8af0-3b79642c556mr16772257637.44.1781604517478; 
 Tue, 16 Jun 2026 03:08:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 52/83] tests/functional: Add RISC-V endianness test
Date: Tue, 16 Jun 2026 20:04:55 +1000
Message-ID: <20260616100527.1939565-53-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add functional test for the RISC-V 'big-endian' CPU property.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260527201348.29511-13-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/functional/riscv64/meson.build        |  1 +
 tests/functional/riscv64/test_endianness.py | 57 +++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tests/functional/riscv64/test_endianness.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index b996c89d7d..5871211e89 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -11,6 +11,7 @@ tests_riscv64_system_quick = [
 ]
 
 tests_riscv64_system_thorough = [
+  'endianness',
   'boston',
   'sifive_u',
   'tuxrun',
diff --git a/tests/functional/riscv64/test_endianness.py b/tests/functional/riscv64/test_endianness.py
new file mode 100644
index 0000000000..9e0b3b7db5
--- /dev/null
+++ b/tests/functional/riscv64/test_endianness.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Functional tests for RISC-V big-endian support
+#
+# Copyright (c) 2026 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvBigEndian(QemuSystemTest):
+    """
+    Tests for RISC-V runtime big-endian data support.
+
+    Uses a bare-metal RV64 ELF that detects data endianness at runtime
+    by storing a 32-bit word and reading back byte 0. Prints "ENDIAN: BE"
+    or "ENDIAN: LE" to the NS16550A UART on the virt machine.
+    """
+
+    timeout = 10
+
+    ASSET_BE_TEST = Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/'
+        'riscvbe-baremetal/be-test-bare-metal.elf',
+        '9ad51b675e101de65908fadbac064ed1d0564c17463715d09dd734db86ea0f58')
+
+    def _run_bare_metal(self, big_endian=False):
+        self.set_machine('virt')
+        kernel = self.ASSET_BE_TEST.fetch()
+        self.vm.add_args('-bios', 'none')
+        self.vm.add_args('-kernel', kernel)
+        if big_endian:
+            self.vm.add_args('-cpu', 'rv64,big-endian=on')
+        self.vm.set_console()
+        self.vm.launch()
+        expected = 'ENDIAN: BE' if big_endian else 'ENDIAN: LE'
+        wait_for_console_pattern(self, expected)
+
+    def test_bare_metal_littleendian(self):
+        """
+        Boot bare-metal ELF on virt with default little-endian CPU.
+        Expects "ENDIAN: LE" on UART.
+        """
+        self._run_bare_metal(big_endian=False)
+
+    def test_bare_metal_bigendian(self):
+        """
+        Boot bare-metal ELF on virt with big-endian=on CPU property.
+        Expects "ENDIAN: BE" on UART.
+        """
+        self._run_bare_metal(big_endian=True)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.54.0


