Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04535C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqHS-0001MG-FM; Tue, 30 Jul 2024 13:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHR-0001IK-HI
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHP-0002TI-Jt
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWDo31JF0dwgQe053IKmKYsLW+m8d3O8K/CNOx3RdSg=;
 b=QYiqKHa5Z1ofuXPrUFtCUyZaVC+yDaqIrAB3HeneUKcnBYsS1SDrSTCNEUCx0og8tSxHWB
 Ja4o3R6zuVOuvIid/TZHjEwj1yUbCZxj8WYihv8nqzeIcb3easFSJt2fQjqpShgJ/J7Aa6
 YmYiX+RVW9sBi0IhVh9b56EzK4biyo4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-TNkDHJ7hO1KrOLR1QLERoA-1; Tue,
 30 Jul 2024 13:04:50 -0400
X-MC-Unique: TNkDHJ7hO1KrOLR1QLERoA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EC82195608A; Tue, 30 Jul 2024 17:04:49 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74990300018D; Tue, 30 Jul 2024 17:04:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 14/24] tests/functional: Convert the x86_cpu_model_versions
 test
Date: Tue, 30 Jul 2024 18:03:34 +0100
Message-ID: <20240730170347.4103919-15-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 tests/functional/meson.build                  |  1 +
 .../test_x86_cpu_model_versions.py}           | 63 ++++++-------------
 2 files changed, 20 insertions(+), 44 deletions(-)
 rename tests/{avocado/x86_cpu_model_versions.py => functional/test_x86_cpu_model_versions.py} (92%)
 mode change 100644 => 100755

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ce5e5be2f3..e85d869948 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -61,6 +61,7 @@ tests_x86_64_quick = [
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
index 11101e02b9..a5f27c737d
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
+        self.machine = 'none'
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


