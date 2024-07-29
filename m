Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A23C3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSIS-0005E5-Ku; Mon, 29 Jul 2024 11:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIQ-00052d-QA
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:22 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIN-0008Nn-N7
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-368584f9e36so1419574f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266898; x=1722871698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJ0+ehSPNMw3L+RsXx/3bfW5qZR45CYyWXKfYU5cn30=;
 b=jkC+IoiQ56WmHqrXsCuQDVKNM8C7qAW2Bgzbcp2bxJoGIf7vl5h2j3GP0nMo9nRubh
 2w/GmgNe3Tgu60aOuE6gGxSccxu+OKkdyAQy8V8ZJ5vfz5RTP2qlis8H4x9i1h1eZH6Z
 tFjpOAGWMWfEc8zszyIA/2V85Nmjql5klV/JCyaOX4tHQpAFuwjNhgYeVYTdUC5lB3dg
 kGAMaqrtg+g32rTPwfF4luAgXXKrnbMT2XnnmgoM00yKt3qkbz7UwikEISaUzU/ba3cK
 J5ZfBgkSqHdVW8ZeWsIX5hdoATV4M6uKXM753zPoQYEPF5IXWKMLyuZjxaicWV+xLDEs
 Ra6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266898; x=1722871698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJ0+ehSPNMw3L+RsXx/3bfW5qZR45CYyWXKfYU5cn30=;
 b=YBaiVM5OGjj/9GFHseudXddBMbsldTou1rH2HcP+4Ds4dXfqeog4p025li++S1Lpv/
 zmF5CJFtXhOt3ara2rMYqCum7wTn5936ZVVxevGjn+QRygTJfhZoo36ZtM+1wIGn55qC
 LvlYFlDlJ7ZoK7SvmrY9QQrmz43drD08Ha0yy7jS+pUjsnPoaexsqrqS8eL5qydUTTJv
 kM+es7pnT30mK3oFHqUF9j+9VwSZRveyuRA/bMLRV31sVq9p4+vA46IMoF9QiahcYioA
 aCZ9LIn7zz2Ri29TMk8S2H6QapTRizAt4rAgsPz7aslP13jEOh9RDaiONCXOYcbOtNyU
 cUrA==
X-Gm-Message-State: AOJu0YwlJINBCeGQN6NWjhtFTPII3Ztpu6z3M2/SNTMNKwpR+0+7zz6L
 UKv0/wtdIIeEXrRUQ03KZmouBGdZDNV6SC4kDlPPc10VhNAKYbdgOyftBy7lz+FCiVMfwPmfqbM
 J
X-Google-Smtp-Source: AGHT+IG2RhidZfv4zGjcjCzezmJ1QGe09GAqM9S4tK2uNA5NTaEvp9OOnNwiigu6921i8ZFnU+iMgQ==
X-Received: by 2002:a05:6000:dc7:b0:367:9237:611d with SMTP id
 ffacd0b85a97d-36b5d096f0amr6103041f8f.60.1722266897790; 
 Mon, 29 Jul 2024 08:28:17 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857db6sm12533901f8f.73.2024.07.29.08.28.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:28:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/14] tests/functional: Convert the riscv_opensbi avocado test
 into a standalone test
Date: Mon, 29 Jul 2024 17:27:10 +0200
Message-ID: <20240729152714.10225-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Thomas Huth <thuth@redhat.com>

The avocado test defined test functions for both, riscv32 and riscv64.
Since we can run the whole file with multiple targets in the new
framework, we can now consolidate the functions so we have to only
define one function per machine now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240724175248.1389201-16-thuth@redhat.com>
[PMD: Updated MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                            |  1 +
 tests/avocado/riscv_opensbi.py         | 63 --------------------------
 tests/functional/meson.build           |  8 ++++
 tests/functional/test_riscv_opensbi.py | 36 +++++++++++++++
 4 files changed, 45 insertions(+), 63 deletions(-)
 delete mode 100644 tests/avocado/riscv_opensbi.py
 create mode 100755 tests/functional/test_riscv_opensbi.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a768808a4a..a906218f9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -337,6 +337,7 @@ F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
 F: tests/tcg/riscv64/
+F: tests/functional/test_riscv_opensbi.py
 
 RISC-V XThead* extensions
 M: Christoph Muellner <christoph.muellner@vrull.eu>
diff --git a/tests/avocado/riscv_opensbi.py b/tests/avocado/riscv_opensbi.py
deleted file mode 100644
index bfff9cc3c3..0000000000
--- a/tests/avocado/riscv_opensbi.py
+++ /dev/null
@@ -1,63 +0,0 @@
-# OpenSBI boot test for RISC-V machines
-#
-# Copyright (c) 2022, Ventana Micro
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-
-class RiscvOpenSBI(QemuSystemTest):
-    """
-    :avocado: tags=accel:tcg
-    """
-    timeout = 5
-
-    def boot_opensbi(self):
-        self.vm.set_console()
-        self.vm.launch()
-        wait_for_console_pattern(self, 'Platform Name')
-        wait_for_console_pattern(self, 'Boot HART MEDELEG')
-
-    def test_riscv32_spike(self):
-        """
-        :avocado: tags=arch:riscv32
-        :avocado: tags=machine:spike
-        """
-        self.boot_opensbi()
-
-    def test_riscv64_spike(self):
-        """
-        :avocado: tags=arch:riscv64
-        :avocado: tags=machine:spike
-        """
-        self.boot_opensbi()
-
-    def test_riscv32_sifive_u(self):
-        """
-        :avocado: tags=arch:riscv32
-        :avocado: tags=machine:sifive_u
-        """
-        self.boot_opensbi()
-
-    def test_riscv64_sifive_u(self):
-        """
-        :avocado: tags=arch:riscv64
-        :avocado: tags=machine:sifive_u
-        """
-        self.boot_opensbi()
-
-    def test_riscv32_virt(self):
-        """
-        :avocado: tags=arch:riscv32
-        :avocado: tags=machine:virt
-        """
-        self.boot_opensbi()
-
-    def test_riscv64_virt(self):
-        """
-        :avocado: tags=arch:riscv64
-        :avocado: tags=machine:virt
-        """
-        self.boot_opensbi()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 48a617033e..94ac97ac53 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -23,6 +23,14 @@ tests_ppc_quick = [
   'ppc_74xx',
 ]
 
+tests_riscv32_quick = [
+  'riscv_opensbi',
+]
+
+tests_riscv64_quick = [
+  'riscv_opensbi',
+]
+
 tests_x86_64_quick = [
   'cpu_queries',
   'mem_addr_space',
diff --git a/tests/functional/test_riscv_opensbi.py b/tests/functional/test_riscv_opensbi.py
new file mode 100755
index 0000000000..d077e40f42
--- /dev/null
+++ b/tests/functional/test_riscv_opensbi.py
@@ -0,0 +1,36 @@
+#!/usr/bin/env python3
+#
+# OpenSBI boot test for RISC-V machines
+#
+# Copyright (c) 2022, Ventana Micro
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+
+class RiscvOpenSBI(QemuSystemTest):
+
+    timeout = 5
+
+    def boot_opensbi(self):
+        self.vm.set_console()
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Platform Name')
+        wait_for_console_pattern(self, 'Boot HART MEDELEG')
+
+    def test_riscv_spike(self):
+        self.set_machine('spike')
+        self.boot_opensbi()
+
+    def test_riscv_sifive_u(self):
+        self.set_machine('sifive_u')
+        self.boot_opensbi()
+
+    def test_riscv_virt(self):
+        self.set_machine('virt')
+        self.boot_opensbi()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


