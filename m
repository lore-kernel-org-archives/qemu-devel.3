Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D94CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4gdK-0004T0-LA; Fri, 03 Oct 2025 10:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gd8-0004Ra-C1
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:35 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcc-0000PW-1d
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:29 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b57d93ae3b0so1603801a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759501131; x=1760105931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jokD56wajshYv74g5ApJLjeyFkJUqNnydeoGpzr//Zw=;
 b=AntG1Kem7POYRNSTU6T1tDlxuh2lLd3DwuL3xvCkT+72aE5GDm9nrX5ibq1ezxRmXB
 t7nJzKIXibtcR2HsIQwW2kHC5NCq0Z1mw1O5dnoaBn645VnzfLDr1iBKKKQIvlgClb0J
 ZIXmdgXa03yOz2QFMSrkS7QWhH2UFfrqLQh+at6yDZHjGcV44BsHWOA7FbDTCl8wNHHs
 o5+JWkpOStrR+4M03jBDpSrAlYBCnHMUnzxBTmaNHYL99Ag016CkkHIDC7pu+yYHJQrH
 rszzIfbUERJoZORVYL44X03H9M4zC0jcugLeJD6HOjRIvOq7DAIoVGySP9pzjHG5dB5U
 m06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759501131; x=1760105931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jokD56wajshYv74g5ApJLjeyFkJUqNnydeoGpzr//Zw=;
 b=IhuXAoyfyC19nGY+U9ojg1JHFKCD5Pjd3/61HEjTtRD0HgxBcAqHOAois4SUx2MnM/
 l584w5e30JH3i43Cvnap2V/4GHC6dTrAgHgnNOnMsd2bOjpmxiElTtKO+5vieHni+hti
 RVYBeQdpoa8QKL7n0iH3I+BW3a87e/QXF48eBpcAFwJkvWdL/elh5epcb9a9ujh2cXRi
 rq3luDjJ5mXrOotn1VIQUhxAjAZGnMMDXNvt+XPOcfZaalNIiQRZ0MoM/WaCdcEFje/v
 86AJ+xqcAL5h9pu3TOtBS9ElVmD3MysA9tqBtanNHwibeGP9ZmoSDlQp7007Z3YRbFFT
 c4FQ==
X-Gm-Message-State: AOJu0YzUg+gdwLfhAngGM66RuMZdbKnPFIonuXwL73TUZtehMCSK3gIS
 DwrxxNCE7JWZ9FP81AOdZJoIwd0tw/7MGF83TN52ifxatap4pquCE0l7wTdG03r7m4gZQyEHEuO
 M8vmo
X-Gm-Gg: ASbGncuG5BrMQ05I38vxEHONdqHPDFlDuU7YlvPVM0wtk6YMYBcdkIhC52a1bEsp8CH
 ie9wTt2l7pn6o4S1XwqlKhjayfIwjsCxvE5pg1nHrWYpuPsb0D1ZWRt9K75Kj1d49N7TIE1HtLy
 HSh+DOS+yagqnSrx2hYcLtmhaZ5Gn+DvQy8jc7aNSFRv+moSaHYKyf68VeBr6Rh0wYB3P1X0OQD
 ce6O5MQFdG2wobUQHcF9ZarwIIPSTqU4GI/e1jSfUh/FMsDYRBLQkEMzdw1MQOQow2+rNLPnZwh
 TYdfPLDIUFIvg7nsm6cGUIzLN04xIY3iIGaeh1jT3lnczmLgUYtf+kHBO4Vj21TcTDn07Xc9zQe
 OzJPxtbSVtCWesx9BNSalADULqhP8DPrqymyUoGG5J3pP/sU5DmAruVSg
X-Google-Smtp-Source: AGHT+IFt+vaQd7pSavoksEgfOncnCXu/UI67BUKVQS8+9ay81OTLaQbOCU51feUj3MZovKhlEGuw3g==
X-Received: by 2002:a17:902:ef0c:b0:25a:24f2:af00 with SMTP id
 d9443c01a7336-28e9a543ba1mr45691365ad.12.1759501130915; 
 Fri, 03 Oct 2025 07:18:50 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5635sm51759645ad.102.2025.10.03.07.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 07:18:50 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 9/9] tests/functional: Adapt arches to reverse_debugging
 w/o Avocado
Date: Fri,  3 Oct 2025 14:18:20 +0000
Message-Id: <20251003141820.85278-10-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003141820.85278-1-gustavo.romero@linaro.org>
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

reverse_debugging no longer depends on Avocado, so remove the import
checks for Avocado, the per-arch endianness tweaks, and the per-arch
register settings. All of these are now handled in the ReverseDebugging
class, automatically.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/aarch64/test_reverse_debug.py | 11 +++++------
 tests/functional/ppc64/test_reverse_debug.py   | 15 ++++++---------
 tests/functional/x86_64/test_reverse_debug.py  | 15 +++++----------
 3 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/tests/functional/aarch64/test_reverse_debug.py b/tests/functional/aarch64/test_reverse_debug.py
index 8bc91ccfde..906f10aec5 100755
--- a/tests/functional/aarch64/test_reverse_debug.py
+++ b/tests/functional/aarch64/test_reverse_debug.py
@@ -2,25 +2,24 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Reverse debugging test
+# Reverse debugging test for aarch64
 #
 # Copyright (c) 2020 ISP RAS
+# Copyright (c) 2025 Linaro Limited
 #
 # Author:
 #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import Asset, skipIfMissingImports, skipFlakyTest
+from qemu_test import Asset, skipFlakyTest
 from reverse_debugging import ReverseDebugging
 
 
-@skipIfMissingImports('avocado.utils')
 class ReverseDebugging_AArch64(ReverseDebugging):
 
-    REG_PC = 32
-
     ASSET_KERNEL = Asset(
         ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
          'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
@@ -31,7 +30,7 @@ def test_aarch64_virt(self):
         self.set_machine('virt')
         self.cpu = 'cortex-a53'
         kernel_path = self.ASSET_KERNEL.fetch()
-        self.reverse_debugging(args=('-kernel', kernel_path))
+        self.reverse_debugging(gdb_arch='aarch64', args=('-kernel', kernel_path))
 
 
 if __name__ == '__main__':
diff --git a/tests/functional/ppc64/test_reverse_debug.py b/tests/functional/ppc64/test_reverse_debug.py
index 5931adef5a..69551fb84d 100755
--- a/tests/functional/ppc64/test_reverse_debug.py
+++ b/tests/functional/ppc64/test_reverse_debug.py
@@ -2,39 +2,36 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Reverse debugging test
+# Reverse debugging test for ppc64
 #
 # Copyright (c) 2020 ISP RAS
+# Copyright (c) 2025 Linaro Limited
 #
 # Author:
 #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import skipIfMissingImports, skipFlakyTest
+from qemu_test import skipFlakyTest
 from reverse_debugging import ReverseDebugging
 
 
-@skipIfMissingImports('avocado.utils')
 class ReverseDebugging_ppc64(ReverseDebugging):
 
-    REG_PC = 0x40
-
     @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
     def test_ppc64_pseries(self):
         self.set_machine('pseries')
         # SLOF branches back to its entry point, which causes this test
         # to take the 'hit a breakpoint again' path. That's not a problem,
         # just slightly different than the other machines.
-        self.endian_is_le = False
-        self.reverse_debugging()
+        self.reverse_debugging(gdb_arch='powerpc:common64')
 
     @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
     def test_ppc64_powernv(self):
         self.set_machine('powernv')
-        self.endian_is_le = False
-        self.reverse_debugging()
+        self.reverse_debugging(gdb_arch='powerpc:common64')
 
 
 if __name__ == '__main__':
diff --git a/tests/functional/x86_64/test_reverse_debug.py b/tests/functional/x86_64/test_reverse_debug.py
index d713e91e14..2b31ae8724 100755
--- a/tests/functional/x86_64/test_reverse_debug.py
+++ b/tests/functional/x86_64/test_reverse_debug.py
@@ -2,34 +2,29 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Reverse debugging test
+# Reverse debugging test for x86_64
 #
 # Copyright (c) 2020 ISP RAS
+# Copyright (c) 2025 Linaro Limited
 #
 # Author:
 #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import skipIfMissingImports, skipFlakyTest
+from qemu_test import skipFlakyTest
 from reverse_debugging import ReverseDebugging
 
 
-@skipIfMissingImports('avocado.utils')
 class ReverseDebugging_X86_64(ReverseDebugging):
 
-    REG_PC = 0x10
-    REG_CS = 0x12
-    def get_pc(self, g):
-        return self.get_reg_le(g, self.REG_PC) \
-            + self.get_reg_le(g, self.REG_CS) * 0x10
-
     @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2922")
     def test_x86_64_pc(self):
         self.set_machine('pc')
         # start with BIOS only
-        self.reverse_debugging()
+        self.reverse_debugging(gdb_arch='x86-64')
 
 
 if __name__ == '__main__':
-- 
2.34.1


