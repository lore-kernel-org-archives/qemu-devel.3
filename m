Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412D4C369D0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPvM-0007qC-Q2; Wed, 25 Sep 2024 07:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPvJ-0007hE-51
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPvH-0003VQ-8S
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPDYJOyxn7GuOEL9xBKlIrMR7I5s2Fo7LCV5NN/rZ8U=;
 b=Ni4nKC8Apx8uKaEFsti59C58WjhlyHw0Yp1CmZ/J9m55EHbVXTJ6UfJeD+hOdQfY4XiHOo
 hQy+/wUSHQQqlSoAXdaRGfnmc9liXWlqADB9Wh6pKCIkavfEQht1qXyh2fKYH+H0zkNrBf
 d9PK0KZkQ0/EyKZNLh6/+UEZHvFvu44=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-3MrmBv5tPVWcSqi_VbUe0Q-1; Wed,
 25 Sep 2024 07:11:02 -0400
X-MC-Unique: 3MrmBv5tPVWcSqi_VbUe0Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D88A1944DF9; Wed, 25 Sep 2024 11:11:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31C1C1956094; Wed, 25 Sep 2024 11:10:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/44] tests/functional: Convert the powernv tests from
 boot_linux_console.py
Date: Wed, 25 Sep 2024 13:09:49 +0200
Message-ID: <20240925111029.24082-9-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the tests into the already existing test_ppc64_powernv.py
file.

Message-ID: <20240920150319.81723-1-thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux_console.py    | 46 --------------------------
 tests/functional/test_ppc64_powernv.py | 42 +++++++++++++++++++++--
 2 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 759fda9cc8..23d1b3587b 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -907,49 +907,3 @@ def test_arm_ast2600_debian(self):
         self.wait_for_console_pattern("SMP: Total of 2 processors activated")
         self.wait_for_console_pattern("No filesystem could mount root")
 
-    def do_test_ppc64_powernv(self, proc):
-        self.require_accelerator("tcg")
-        images_url = ('https://github.com/open-power/op-build/releases/download/v2.7/')
-
-        kernel_url = images_url + 'zImage.epapr'
-        kernel_hash = '0ab237df661727e5392cee97460e8674057a883c5f74381a128fa772588d45cd'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
-                                       algorithm='sha256')
-        self.vm.set_console()
-        self.vm.add_args('-kernel', kernel_path,
-                         '-append', 'console=tty0 console=hvc0',
-                         '-device', 'pcie-pci-bridge,id=bridge1,bus=pcie.1,addr=0x0',
-                         '-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234',
-                         '-device', 'e1000e,bus=bridge1,addr=0x3',
-                         '-device', 'nec-usb-xhci,bus=bridge1,addr=0x2')
-        self.vm.launch()
-
-        self.wait_for_console_pattern("CPU: " + proc + " generation processor")
-        self.wait_for_console_pattern("zImage starting: loaded")
-        self.wait_for_console_pattern("Run /init as init process")
-        # Device detection output driven by udev probing is sometimes cut off
-        # from console output, suspect S14silence-console init script.
-
-    def test_ppc_powernv8(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:powernv8
-        :avocado: tags=accel:tcg
-        """
-        self.do_test_ppc64_powernv('P8')
-
-    def test_ppc_powernv9(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:powernv9
-        :avocado: tags=accel:tcg
-        """
-        self.do_test_ppc64_powernv('P9')
-
-    def test_ppc_powernv10(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:powernv10
-        :avocado: tags=accel:tcg
-        """
-        self.do_test_ppc64_powernv('P10')
diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/test_ppc64_powernv.py
index 67497d6404..685e2178ed 100755
--- a/tests/functional/test_ppc64_powernv.py
+++ b/tests/functional/test_ppc64_powernv.py
@@ -7,10 +7,10 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import QemuSystemTest, Asset
+from qemu_test import LinuxKernelTest, Asset
 from qemu_test import wait_for_console_pattern
 
-class powernvMachine(QemuSystemTest):
+class powernvMachine(LinuxKernelTest):
 
     timeout = 90
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
@@ -78,5 +78,41 @@ def test_linux_big_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+
+    ASSET_EPAPR_KERNEL = Asset(
+        ('https://github.com/open-power/op-build/releases/download/v2.7/'
+         'zImage.epapr'),
+        '0ab237df661727e5392cee97460e8674057a883c5f74381a128fa772588d45cd')
+
+    def do_test_ppc64_powernv(self, proc):
+        self.require_accelerator("tcg")
+        kernel_path = self.ASSET_EPAPR_KERNEL.fetch()
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', 'console=tty0 console=hvc0',
+                         '-device', 'pcie-pci-bridge,id=bridge1,bus=pcie.1,addr=0x0',
+                         '-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234',
+                         '-device', 'e1000e,bus=bridge1,addr=0x3',
+                         '-device', 'nec-usb-xhci,bus=bridge1,addr=0x2')
+        self.vm.launch()
+
+        self.wait_for_console_pattern("CPU: " + proc + " generation processor")
+        self.wait_for_console_pattern("zImage starting: loaded")
+        self.wait_for_console_pattern("Run /init as init process")
+        # Device detection output driven by udev probing is sometimes cut off
+        # from console output, suspect S14silence-console init script.
+
+    def test_powernv8(self):
+        self.set_machine('powernv8')
+        self.do_test_ppc64_powernv('P8')
+
+    def test_powernv9(self):
+        self.set_machine('powernv9')
+        self.do_test_ppc64_powernv('P9')
+
+    def test_powernv10(self):
+        self.set_machine('powernv10')
+        self.do_test_ppc64_powernv('P10')
+
 if __name__ == '__main__':
-    QemuSystemTest.main()
+    LinuxKernelTest.main()
-- 
2.46.0


