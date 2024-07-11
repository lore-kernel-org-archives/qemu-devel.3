Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3D9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsPz-00059L-VZ; Thu, 11 Jul 2024 07:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsPd-0004GY-ME
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsPa-0004ER-Un
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720698994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5PcsCgL2IcK8j5iQ5rWgADeldCnm0hNp0IysS8YInY=;
 b=cPIGj1Gn959lUGaSMsAig1mQsB+/2ZRVGCBs5+AJYXpYfY5L2GmOdrpuVjSJG+Cznne3n9
 KsMxsOPOHN3xSlffNSHCl8LED3wxw0Z+vD5m0KesXSektp8+6Sa8fuWDswTdJ9VnohGncI
 G5QCwde7RcCt482ilj2d3JjZrANewpE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-X1AUam9sNcW5Bpm4uk_6dg-1; Thu,
 11 Jul 2024 07:56:32 -0400
X-MC-Unique: X1AUam9sNcW5Bpm4uk_6dg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 308251944DFE; Thu, 11 Jul 2024 11:56:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.118])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E636D1955E85; Thu, 11 Jul 2024 11:56:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 8/8] tests/pytest: Convert avocado test that needed
 avocado.utils.archive
Date: Thu, 11 Jul 2024 13:55:46 +0200
Message-ID: <20240711115546.40859-9-thuth@redhat.com>
In-Reply-To: <20240711115546.40859-1-thuth@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of using the "archive" module from avocado.utils, switch
these tests to use the new wrapper function that is based on the
"tarfile" module instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/pytest/meson.build                       |  5 +++++
 .../test_arm_canona1100.py}                    | 16 +++++++---------
 .../test_ppc_bamboo.py}                        | 18 ++++++------------
 3 files changed, 18 insertions(+), 21 deletions(-)
 rename tests/{avocado/machine_arm_canona1100.py => pytest/test_arm_canona1100.py} (74%)
 rename tests/{avocado/ppc_bamboo.py => pytest/test_ppc_bamboo.py} (75%)

diff --git a/tests/pytest/meson.build b/tests/pytest/meson.build
index d3607db362..baaacf00cc 100644
--- a/tests/pytest/meson.build
+++ b/tests/pytest/meson.build
@@ -9,6 +9,7 @@ pytests_generic = [
 ]
 
 pytests_arm = [
+  'arm_canona1100',
   'machine_arm_n8x0',
 ]
 
@@ -24,6 +25,10 @@ pytests_mips64el = [
   'machine_mips_loongson3v',
 ]
 
+pytests_ppc = [
+  'ppc_bamboo',
+]
+
 pytests_x86_64 = [
   'cpu_queries',
   'mem_addr_space',
diff --git a/tests/avocado/machine_arm_canona1100.py b/tests/pytest/test_arm_canona1100.py
similarity index 74%
rename from tests/avocado/machine_arm_canona1100.py
rename to tests/pytest/test_arm_canona1100.py
index a42d8b0f2b..296df41a06 100644
--- a/tests/avocado/machine_arm_canona1100.py
+++ b/tests/pytest/test_arm_canona1100.py
@@ -8,9 +8,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import archive
+from qemu_pytest import QemuSystemTest
+from qemu_pytest import wait_for_console_pattern
+from qemu_pytest.utils import archive_extract
 
 class CanonA1100Machine(QemuSystemTest):
     """Boots the barebox firmware and checks that the console is operational"""
@@ -18,16 +18,14 @@ class CanonA1100Machine(QemuSystemTest):
     timeout = 90
 
     def test_arm_canona1100(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:canon-a1100
-        :avocado: tags=device:pflash_cfi02
-        """
+        self.machine = 'canon-a1100'
+
         tar_url = ('https://qemu-advcal.gitlab.io'
                    '/qac-best-of-multiarch/download/day18.tar.xz')
         tar_hash = '068b5fc4242b29381acee94713509f8a876e9db6'
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
+        archive_extract(file_path, dest_dir=self.workdir,
+                        member="day18/barebox.canon-a1100.bin")
         self.vm.set_console()
         self.vm.add_args('-bios',
                          self.workdir + '/day18/barebox.canon-a1100.bin')
diff --git a/tests/avocado/ppc_bamboo.py b/tests/pytest/test_ppc_bamboo.py
similarity index 75%
rename from tests/avocado/ppc_bamboo.py
rename to tests/pytest/test_ppc_bamboo.py
index a81be3d608..4964dedbfe 100644
--- a/tests/avocado/ppc_bamboo.py
+++ b/tests/pytest/test_ppc_bamboo.py
@@ -5,30 +5,24 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import exec_command_and_wait_for_pattern
+from qemu_pytest.utils import archive_extract
+from qemu_pytest import QemuSystemTest
+from qemu_pytest import wait_for_console_pattern
+from qemu_pytest import exec_command_and_wait_for_pattern
 
 class BambooMachine(QemuSystemTest):
 
     timeout = 90
 
     def test_ppc_bamboo(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:bamboo
-        :avocado: tags=cpu:440epb
-        :avocado: tags=device:rtl8139
-        :avocado: tags=accel:tcg
-        """
+        self.machine = 'bamboo'
         self.require_accelerator("tcg")
         self.require_netdev('user')
         tar_url = ('http://landley.net/aboriginal/downloads/binaries/'
                    'system-image-powerpc-440fp.tar.gz')
         tar_hash = '53e5f16414b195b82d2c70272f81c2eedb39bad9'
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
+        archive_extract(file_path, self.workdir)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.workdir +
                                    '/system-image-powerpc-440fp/linux',
-- 
2.45.2


