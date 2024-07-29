Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA74BC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSIN-0004dP-Sg; Mon, 29 Jul 2024 11:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIK-0004DE-EC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIH-0008Me-Ke
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:16 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so22983185e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266892; x=1722871692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIHOLD5EbcXB4owPcPVKVliv892NjsZAXtrM5p8AqZ4=;
 b=AJNp2+KM3F9C4XT9WbsVo2/ltUTCdql3m2rePQwV7Eph/62CZsGsrpQr99O/2w+CDN
 huc5FF6WPpWt0UVsg2F6HB1C2YANs6+CpNvzzqqennYtc8oFQSQ0cQXKjzR54CIB1n/x
 JQ3wEOA4Z+7NoEiXWgJigu6Ktsi8dv+mJ4fngQDvq9K9jT8yjdYBErS58ooA+q+ITFXa
 CY/vlhinUjtX2KefaysFXTJ1pQ/NAh51QxtnM1+iRjQZjvEzXrjl+rDJAZP261WAAWrJ
 vsf9ZRhXzG5cRcyeWE4AhabZ4h36DfE+AmMRL6/YYq34Rmofvvb8V97JmuPZgmTY7Rcg
 J+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266892; x=1722871692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIHOLD5EbcXB4owPcPVKVliv892NjsZAXtrM5p8AqZ4=;
 b=m4oya5MCPS3QQGHgI1ilqmQ1FYMOgm+wGYMyHupic4Xcu3KOaK1ZYicM4JoS6iohhi
 ElTMp84gdoPkZYrNERi9bzq/L7i8eSpr6LjlL5midyvTmccAUWOhhDBrv3nnH4CRvHtV
 9NYiDwR3nOvPYzDq1M5OgqI0kDuyrtfCL6lEvmKA9DMB+vvjHBxT9DgasCeeRZrzNtda
 VuEDAXz3rA3Y7lfN65/tZWBINGS1jKfT5d7FVF+q3er6TMD95iCssM0nv9risQHNmdhL
 BqBtU1GPBFf/qFLH3c+0XYTxHs3F3zfifHSe3DPXJ1c44LyMV7GANYNXxJH01a1JuUWE
 cjOA==
X-Gm-Message-State: AOJu0YyVpruOnbh+xPu648TrIwdA/eHCxPgdiZpilNQRiQH2RCFTcLxh
 kohTBKkozy4JaGjLRx7V5qTtWQzml+kp8bn/sq5dUj9lcKciHYcbL9p0dM6/ieQEyyWIjHVqkGO
 i
X-Google-Smtp-Source: AGHT+IHd5pW1JwRBWuKYrzM/W9SqI8ubDjQem4R5iflvvBuqFrjc44+HyZbqfdI0Z7KGXeu5mTqKtA==
X-Received: by 2002:a05:600c:33a3:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-42811e0b672mr64589275e9.35.1722266891871; 
 Mon, 29 Jul 2024 08:28:11 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427fb7bdfa0sm212853785e9.14.2024.07.29.08.28.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:28:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/14] tests/functional: Convert the x86_cpu_model_versions test
Date: Mon, 29 Jul 2024 17:27:09 +0200
Message-ID: <20240729152714.10225-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Nothing thrilling in here, it's just a straight forward conversion.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240724175248.1389201-14-thuth@redhat.com>
[PMD: More uses of set_machine(), updated MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                   |  1 +
 tests/functional/meson.build                  |  1 +
 .../test_x86_cpu_model_versions.py}           | 63 ++++++-------------
 3 files changed, 21 insertions(+), 44 deletions(-)
 rename tests/{avocado/x86_cpu_model_versions.py => functional/test_x86_cpu_model_versions.py} (92%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c9a36dfd3..a768808a4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1833,6 +1833,7 @@ F: tests/unit/test-x86-topo.c
 F: tests/qtest/test-x86-cpuid-compat.c
 F: tests/functional/test_mem_addr_space.py
 F: tests/functional/test_pc_cpu_hotplug_props.py
+F: tests/functional/test_x86_cpu_model_versions.py
 
 PC Chipset
 M: Michael S. Tsirkin <mst@redhat.com>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8a8fa0ab99..48a617033e 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -28,6 +28,7 @@ tests_x86_64_quick = [
   'mem_addr_space',
   'pc_cpu_hotplug_props',
   'virtio_version',
+  'x86_cpu_model_versions',
 ]
 
 tests_x86_64_thorough = [
diff --git a/tests/avocado/x86_cpu_model_versions.py b/tests/functional/test_x86_cpu_model_versions.py
old mode 100644
new mode 100755
similarity index 92%
rename from tests/avocado/x86_cpu_model_versions.py
rename to tests/functional/test_x86_cpu_model_versions.py
index 11101e02b9..a7294b4b92
--- a/tests/avocado/x86_cpu_model_versions.py
+++ b/tests/functional/test_x86_cpu_model_versions.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python3
 #
 # Basic validation of x86 versioned CPU models and CPU model aliases
 #
@@ -20,11 +21,11 @@
 # License along with this library; if not, see <http://www.gnu.org/licenses/>.
 #
 
-
-import avocado_qemu
 import re
 
-class X86CPUModelAliases(avocado_qemu.QemuSystemTest):
+from qemu_test import QemuSystemTest
+
+class X86CPUModelAliases(QemuSystemTest):
     """
     Validation of PC CPU model versions and CPU model aliases
 
@@ -76,9 +77,8 @@ def validate_variant_aliases(self, cpus):
     def test_4_0_alias_compatibility(self):
         """
         Check if pc-*-4.0 unversioned CPU model won't be reported as aliases
-
-        :avocado: tags=machine:pc-i440fx-4.0
         """
+        self.set_machine('pc-i440fx-4.0')
         # pc-*-4.0 won't expose non-versioned CPU models as aliases
         # We do this to help management software to keep compatibility
         # with older QEMU versions that didn't have the versioned CPU model
@@ -110,9 +110,8 @@ def test_4_0_alias_compatibility(self):
     def test_4_1_alias(self):
         """
         Check if unversioned CPU model is an alias pointing to right version
-
-        :avocado: tags=machine:pc-i440fx-4.1
         """
+        self.set_machine('pc-i440fx-4.1')
         self.vm.add_args('-S')
         self.vm.launch()
 
@@ -217,9 +216,8 @@ def test_4_1_alias(self):
     def test_none_alias(self):
         """
         Check if unversioned CPU model is an alias pointing to some version
-
-        :avocado: tags=machine:none
         """
+        self.set_machine('none')
         self.vm.add_args('-S')
         self.vm.launch()
 
@@ -243,21 +241,16 @@ def test_none_alias(self):
         self.validate_aliases(cpus)
 
 
-class CascadelakeArchCapabilities(avocado_qemu.QemuSystemTest):
+class CascadelakeArchCapabilities(QemuSystemTest):
     """
     Validation of Cascadelake arch-capabilities
-
-    :avocado: tags=arch:x86_64
     """
     def get_cpu_prop(self, prop):
         cpu_path = self.vm.cmd('query-cpus-fast')[0].get('qom-path')
         return self.vm.cmd('qom-get', path=cpu_path, property=prop)
 
     def test_4_1(self):
-        """
-        :avocado: tags=machine:pc-i440fx-4.1
-        :avocado: tags=cpu:Cascadelake-Server
-        """
+        self.set_machine('pc-i440fx-4.1')
         # machine-type only:
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
@@ -268,10 +261,7 @@ def test_4_1(self):
                          'pc-i440fx-4.1 + Cascadelake-Server should not have arch-capabilities')
 
     def test_4_0(self):
-        """
-        :avocado: tags=machine:pc-i440fx-4.0
-        :avocado: tags=cpu:Cascadelake-Server
-        """
+        self.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
                         'Cascadelake-Server,x-force-features=on,check=off,'
@@ -281,10 +271,7 @@ def test_4_0(self):
                          'pc-i440fx-4.0 + Cascadelake-Server should not have arch-capabilities')
 
     def test_set_4_0(self):
-        """
-        :avocado: tags=machine:pc-i440fx-4.0
-        :avocado: tags=cpu:Cascadelake-Server
-        """
+        self.set_machine('pc-i440fx-4.0')
         # command line must override machine-type if CPU model is not versioned:
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
@@ -295,10 +282,7 @@ def test_set_4_0(self):
                         'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabilities should have arch-capabilities')
 
     def test_unset_4_1(self):
-        """
-        :avocado: tags=machine:pc-i440fx-4.1
-        :avocado: tags=cpu:Cascadelake-Server
-        """
+        self.set_machine('pc-i440fx-4.1')
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
                         'Cascadelake-Server,x-force-features=on,check=off,'
@@ -308,10 +292,7 @@ def test_unset_4_1(self):
                          'pc-i440fx-4.1 + Cascadelake-Server,-arch-capabilities should not have arch-capabilities')
 
     def test_v1_4_0(self):
-        """
-        :avocado: tags=machine:pc-i440fx-4.0
-        :avocado: tags=cpu:Cascadelake-Server
-        """
+        self.set_machine('pc-i440fx-4.0')
         # versioned CPU model overrides machine-type:
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
@@ -322,10 +303,7 @@ def test_v1_4_0(self):
                          'pc-i440fx-4.0 + Cascadelake-Server-v1 should not have arch-capabilities')
 
     def test_v2_4_0(self):
-        """
-        :avocado: tags=machine:pc-i440fx-4.0
-        :avocado: tags=cpu:Cascadelake-Server
-        """
+        self.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
                         'Cascadelake-Server-v2,x-force-features=on,check=off,'
@@ -335,10 +313,7 @@ def test_v2_4_0(self):
                         'pc-i440fx-4.0 + Cascadelake-Server-v2 should have arch-capabilities')
 
     def test_v1_set_4_0(self):
-        """
-        :avocado: tags=machine:pc-i440fx-4.0
-        :avocado: tags=cpu:Cascadelake-Server
-        """
+        self.set_machine('pc-i440fx-4.0')
         # command line must override machine-type and versioned CPU model:
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
@@ -349,10 +324,7 @@ def test_v1_set_4_0(self):
                         'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-capabilities should have arch-capabilities')
 
     def test_v2_unset_4_1(self):
-        """
-        :avocado: tags=machine:pc-i440fx-4.1
-        :avocado: tags=cpu:Cascadelake-Server
-        """
+        self.set_machine('pc-i440fx-4.1')
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
                         'Cascadelake-Server-v2,x-force-features=on,check=off,'
@@ -360,3 +332,6 @@ def test_v2_unset_4_1(self):
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server-v2,-arch-capabilities should not have arch-capabilities')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


