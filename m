Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAE8CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Iw-0002oX-H9; Tue, 07 Oct 2025 07:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66Ic-0002ZG-4Y
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:56:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IF-0001K9-5l
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:56:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso40257465e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838141; x=1760442941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWkzNTNhVeSRuf8nBb9rMnj6+r8fAqh97An6MdGnAFU=;
 b=ZZESFUXNEthZ8mMAxRYjQ9SKEB/5TmxzzTA24nf8ap6RBiMZoL3tCpE2HeiWAkSEKp
 khy3d5/Cxl14GsCtPajaIc9rKzo6PJtd3VyPikytq0EKuq+Dpxe5Lhj13GCPD5ZAhDt7
 0QqjiQ1kQA/vGpUh2XiQdZlIA/TMNesoQqW0ZRFKeOv8bZawfpmkm7oxZPQ6ha6/Ysf/
 Uqe6H84YqssRw9MeG/mcJkhAn08M18XD7c4bhBGF/l5QXBfyzXzEjPSEwNDGxNlcJnMR
 61hsND4bCBVIdCaoDCsPc5BgpE/8d623VR5AMAw3n/NkMsgfZsjNn1KSz/aJm1E0hkIE
 OUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838141; x=1760442941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWkzNTNhVeSRuf8nBb9rMnj6+r8fAqh97An6MdGnAFU=;
 b=oQ0LkRmh1l5ivq+Gd2TFtzCgsFKvLgLsra6V5jQxOvTNmpdy8Jks7lEhLl+po/+6+i
 QdNZzPfOXTexmVlwgDMO/yWnd1tYW/Z6BYgcv6skYOsJY0KjDk4U1GgaqJZY8OuZZ+yW
 40POUn+tBGWQVBzejZLvzp+6Zedoj4AuD9+QHDhj51uLU/YsKKNs7nkAqlJXBPGt48Md
 UbzncXERABOryXDGglwz8TCJRQbrMKSN/KPwIDHdsAe86O99/A4hkjYJkOqpNQtItlNY
 eptrh+yBdaO/KEavmZoMKBpKaKI2uQ8J2/JKpx3miiPzbXmjIYPkaHCkXCN0E6nImzD/
 ISAA==
X-Gm-Message-State: AOJu0YyuJpMZcFDfGKAwYsBBKFZfkUUxOMrnZEQVN0G33ZtJ4wvPeXBQ
 mOQISzQ7CL/14r/D6v/FlQyjj2HlTz7hOvQQr4kt4hEY7v7SfAsaGQh1eiCQU2bLXPs=
X-Gm-Gg: ASbGncu1buNOWrOnAyhhhjQ6JcpiIJ5ifizAQ9TUtONXxEESF3MEy2UXmYbNbYFhMN5
 4NS88ENnXWUrpwE4KIksTelqKZ3yHMpSK4pK5tzWybo7yiO5RZQGEckmTrWMAsorNmysxxq1bGf
 5RuB0mjCDpGU1ZAIkxnYG7/ZOzRyZShyyhknaYFGegPpm24xMQ3/ICl5EF+O6trojSBHUxKONqn
 SalEOmGFRX8dE7lvsOhEfG9XZJ/CyVzQhNh5EN3vSMs5Mr5WXUCXuZT3q/U92dHEVymiNHMUgPO
 EE508WbKpQpvmSqtsHbWFD7CWjl14Yw1WwYUe1K11zdeJjysWbR423g4U3C5ph5+QeR8GxbMcmZ
 vgHaNGbXslDAdKBFeDI4PdoEgRIQ05ALkxV9xrUKZt5MPDOaoNrw=
X-Google-Smtp-Source: AGHT+IHuCRbDcyWjPmwNVhULKnB7gPUyp+OW3faylGNmCCTJcVnlBMByEE5B9XBoGZPgvGw+YCwW/Q==
X-Received: by 2002:a05:600c:538e:b0:46c:a569:71a0 with SMTP id
 5b1f17b1804b1-46e711510efmr111328225e9.26.1759838140636; 
 Tue, 07 Oct 2025 04:55:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a0241bsm291502615e9.11.2025.10.07.04.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 645AD605F0;
 Tue, 07 Oct 2025 12:55:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 16/17] tests/functional: Adapt arches to reverse_debugging w/o
 Avocado
Date: Tue,  7 Oct 2025 12:55:24 +0100
Message-ID: <20251007115525.1998643-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

reverse_debugging no longer depends on Avocado, so remove the import
checks for Avocado, the per-arch endianness tweaks, and the per-arch
register settings. All of these are now handled in the ReverseDebugging
class, automatically.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20251003141820.85278-10-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/aarch64/test_reverse_debug.py b/tests/functional/aarch64/test_reverse_debug.py
index 8bc91ccfde7..906f10aec55 100755
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
index 5931adef5a9..69551fb84df 100755
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
index d713e91e144..2b31ae87243 100755
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
2.47.3


