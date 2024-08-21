Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3414C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 08:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sggiV-000218-7U; Wed, 21 Aug 2024 04:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggiQ-0001nr-2O
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggiN-0004VD-TH
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724228951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gD7BYwceilZXA9Klt+9t02MkXthrZHabyY5pHQHlpAY=;
 b=hDtfZYbE9V3DdAAloEWM/dQT6iRIDig6bwpQpd6XZXqIM3MWZah70FY8Q3bvLD8pEe+jxm
 tJH1Btbg8jMYOaJGqtDjyDOF6/s7nzhoCkGZttwinwme9BW3BlQ6b9UKEATCjh/PtgzZAd
 Q/bTTvmdBHPkPVNtGoc1nRbz9QLhHBU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-sCFnS2OKOJ2eaueNBZBRRw-1; Wed,
 21 Aug 2024 04:29:07 -0400
X-MC-Unique: sCFnS2OKOJ2eaueNBZBRRw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC1FC1955BF7; Wed, 21 Aug 2024 08:29:05 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 002001955F1B; Wed, 21 Aug 2024 08:29:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 20/35] tests/functional: Convert the x86_cpu_model_versions
 test
Date: Wed, 21 Aug 2024 10:27:21 +0200
Message-ID: <20240821082748.65853-21-thuth@redhat.com>
In-Reply-To: <20240821082748.65853-1-thuth@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Nothing thrilling in here, it's just a straight forward conversion.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  1 +
 tests/functional/meson.build                  |  1 +
 .../test_x86_cpu_model_versions.py}           | 65 ++++++-------------
 3 files changed, 21 insertions(+), 46 deletions(-)
 rename tests/{avocado/x86_cpu_model_versions.py => functional/test_x86_cpu_model_versions.py} (92%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fad267307..bbb8fc78c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1836,6 +1836,7 @@ F: tests/unit/test-x86-topo.c
 F: tests/qtest/test-x86-cpuid-compat.c
 F: tests/functional/test_mem_addr_space.py
 F: tests/functional/test_pc_cpu_hotplug_props.py
+F: tests/functional/test_x86_cpu_model_versions.py
 
 PC Chipset
 M: Michael S. Tsirkin <mst@redhat.com>
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
index 11101e02b9..bd18acd44f
--- a/tests/avocado/x86_cpu_model_versions.py
+++ b/tests/functional/test_x86_cpu_model_versions.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python3
 #
 # Basic validation of x86 versioned CPU models and CPU model aliases
 #
@@ -20,15 +21,13 @@
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
-
-    :avocado: tags=arch:x86_64
     """
     def validate_aliases(self, cpus):
         for c in cpus.values():
@@ -76,9 +75,8 @@ def validate_variant_aliases(self, cpus):
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
@@ -110,9 +108,8 @@ def test_4_0_alias_compatibility(self):
     def test_4_1_alias(self):
         """
         Check if unversioned CPU model is an alias pointing to right version
-
-        :avocado: tags=machine:pc-i440fx-4.1
         """
+        self.set_machine('pc-i440fx-4.1')
         self.vm.add_args('-S')
         self.vm.launch()
 
@@ -217,9 +214,8 @@ def test_4_1_alias(self):
     def test_none_alias(self):
         """
         Check if unversioned CPU model is an alias pointing to some version
-
-        :avocado: tags=machine:none
         """
+        self.set_machine('none')
         self.vm.add_args('-S')
         self.vm.launch()
 
@@ -243,21 +239,16 @@ def test_none_alias(self):
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
@@ -268,10 +259,7 @@ def test_4_1(self):
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
@@ -281,10 +269,7 @@ def test_4_0(self):
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
@@ -295,10 +280,7 @@ def test_set_4_0(self):
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
@@ -308,10 +290,7 @@ def test_unset_4_1(self):
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
@@ -322,10 +301,7 @@ def test_v1_4_0(self):
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
@@ -335,10 +311,7 @@ def test_v2_4_0(self):
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
@@ -349,10 +322,7 @@ def test_v1_set_4_0(self):
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
@@ -360,3 +330,6 @@ def test_v2_unset_4_1(self):
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server-v2,-arch-capabilities should not have arch-capabilities')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


