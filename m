Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D01C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 14:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHka0-0003tk-Dk; Wed, 21 May 2025 10:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHkZw-0003tH-Qy
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHkZr-0004iC-4v
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747838268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q+rE6fnkQpnm188HCu1TcKy3vpKzC4BWBoK3D33Wc/M=;
 b=bEHdaWI9wZzNq352jh5pC5XDhP9Z0gVdCqlxAGzWPKSN++vK6k3qghu2CRddONQPUZavL6
 pW2oP1n9fWKy62/FNIYHXqG3sSZ7tNwdPSovFWfHPpxGFShYHQBTIuEeIoAmT/wAQrLY2e
 DDqJ8vibcjicehCWBP1lWHuHxjyoMr0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-l-3qmVioOkKuaeHbkgMfKQ-1; Wed,
 21 May 2025 10:37:45 -0400
X-MC-Unique: l-3qmVioOkKuaeHbkgMfKQ-1
X-Mimecast-MFC-AGG-ID: l-3qmVioOkKuaeHbkgMfKQ_1747838264
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FBD819560A3; Wed, 21 May 2025 14:37:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.199])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 373C5180045B; Wed, 21 May 2025 14:37:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/functional/test_mem_addr_space: Use set_machine() to
 select the machine
Date: Wed, 21 May 2025 16:37:32 +0200
Message-ID: <20250521143732.140711-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

By using self.set_machine() the tests get properly skipped in case
the machine has not been compiled into the QEMU binary, e.g. when
"configure" has been run with "--without-default-devices".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_mem_addr_space.py | 63 +++++++++++++------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/tests/functional/test_mem_addr_space.py b/tests/functional/test_mem_addr_space.py
index 2d9d31efb59..61b4a190b41 100755
--- a/tests/functional/test_mem_addr_space.py
+++ b/tests/functional/test_mem_addr_space.py
@@ -58,8 +58,8 @@ def test_phybits_low_pse36(self):
         should start fine.
         """
         self.ensure_64bit_binary()
-        self.vm.add_args('-S', '-machine', 'q35', '-m',
-                         '512,slots=1,maxmem=59.6G',
+        self.set_machine('q35')
+        self.vm.add_args('-S', '-m', '512,slots=1,maxmem=59.6G',
                          '-cpu', 'pentium,pse36=on', '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -76,8 +76,8 @@ def test_phybits_low_pae(self):
         with pse36 above.
         """
         self.ensure_64bit_binary()
-        self.vm.add_args('-S', '-machine', 'q35', '-m',
-                         '512,slots=1,maxmem=59.6G',
+        self.set_machine('q35')
+        self.vm.add_args('-S', '-m', '512,slots=1,maxmem=59.6G',
                          '-cpu', 'pentium,pae=on', '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -93,8 +93,8 @@ def test_phybits_ok_pentium_pse36(self):
         same options as the failing case above with pse36 cpu feature.
         """
         self.ensure_64bit_binary()
-        self.vm.add_args('-machine', 'q35', '-m',
-                         '512,slots=1,maxmem=59.5G',
+        self.set_machine('q35')
+        self.vm.add_args('-m', '512,slots=1,maxmem=59.5G',
                          '-cpu', 'pentium,pse36=on', '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -111,8 +111,8 @@ def test_phybits_ok_pentium_pae(self):
         with the same options as the case above.
         """
         self.ensure_64bit_binary()
-        self.vm.add_args('-machine', 'q35', '-m',
-                         '512,slots=1,maxmem=59.5G',
+        self.set_machine('q35')
+        self.vm.add_args('-m', '512,slots=1,maxmem=59.5G',
                          '-cpu', 'pentium,pae=on', '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -128,8 +128,8 @@ def test_phybits_ok_pentium2(self):
         with pse36 ON.
         """
         self.ensure_64bit_binary()
-        self.vm.add_args('-machine', 'q35', '-m',
-                         '512,slots=1,maxmem=59.5G',
+        self.set_machine('q35')
+        self.vm.add_args('-m', '512,slots=1,maxmem=59.5G',
                          '-cpu', 'pentium2', '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -148,8 +148,8 @@ def test_phybits_low_nonpse36(self):
         above 4 GiB due to the PCI hole and simplicity.
         """
         self.ensure_64bit_binary()
-        self.vm.add_args('-S', '-machine', 'q35', '-m',
-                         '512,slots=1,maxmem=4G',
+        self.set_machine('q35')
+        self.vm.add_args('-S', '-m', '512,slots=1,maxmem=4G',
                          '-cpu', 'pentium', '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -176,8 +176,8 @@ def test_phybits_low_tcg_q35_70_amd(self):
         make QEMU fail with the error message.
         """
         self.ensure_64bit_binary()
-        self.vm.add_args('-S', '-machine', 'pc-q35-7.0', '-m',
-                         '512,slots=1,maxmem=988G',
+        self.set_machine('pc-q35-7.0')
+        self.vm.add_args('-S', '-m', '512,slots=1,maxmem=988G',
                          '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -197,8 +197,8 @@ def test_phybits_low_tcg_q35_71_amd(self):
         than 988 GiB).
         """
         self.ensure_64bit_binary()
-        self.vm.add_args('-S', '-machine', 'pc-q35-7.1', '-m',
-                         '512,slots=1,maxmem=976G',
+        self.set_machine('pc-q35-7.1')
+        self.vm.add_args('-S', '-m', '512,slots=1,maxmem=976G',
                          '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -214,8 +214,8 @@ def test_phybits_ok_tcg_q35_70_amd(self):
         successfully start when maxmem is < 988G.
         """
         self.ensure_64bit_binary()
-        self.vm.add_args('-S', '-machine', 'pc-q35-7.0', '-m',
-                         '512,slots=1,maxmem=987.5G',
+        self.set_machine('pc-q35-7.0')
+        self.vm.add_args('-S', '-m', '512,slots=1,maxmem=987.5G',
                          '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -231,8 +231,8 @@ def test_phybits_ok_tcg_q35_71_amd(self):
         successfully start when maxmem is < 976G.
         """
         self.ensure_64bit_binary()
-        self.vm.add_args('-S', '-machine', 'pc-q35-7.1', '-m',
-                         '512,slots=1,maxmem=975.5G',
+        self.set_machine('pc-q35-7.1')
+        self.vm.add_args('-S', '-m', '512,slots=1,maxmem=975.5G',
                          '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -249,9 +249,9 @@ def test_phybits_ok_tcg_q35_71_intel(self):
         "above_4G" memory starts at 4G.
         """
         self.ensure_64bit_binary()
+        self.set_machine('pc-q35-7.1')
         self.vm.add_args('-S', '-cpu', 'Skylake-Server',
-                         '-machine', 'pc-q35-7.1', '-m',
-                         '512,slots=1,maxmem=976G',
+                         '-m', '512,slots=1,maxmem=976G',
                          '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -274,9 +274,9 @@ def test_phybits_low_tcg_q35_71_amd_41bits(self):
         fail to start.
         """
         self.ensure_64bit_binary()
+        self.set_machine('pc-q35-7.1')
         self.vm.add_args('-S', '-cpu', 'EPYC-v4,phys-bits=41',
-                         '-machine', 'pc-q35-7.1', '-m',
-                         '512,slots=1,maxmem=992G',
+                         '-m', '512,slots=1,maxmem=992G',
                          '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -293,9 +293,9 @@ def test_phybits_ok_tcg_q35_71_amd_41bits(self):
         QEMU should start fine.
         """
         self.ensure_64bit_binary()
+        self.set_machine('pc-q35-7.1')
         self.vm.add_args('-S', '-cpu', 'EPYC-v4,phys-bits=41',
-                         '-machine', 'pc-q35-7.1', '-m',
-                         '512,slots=1,maxmem=990G',
+                         '-m', '512,slots=1,maxmem=990G',
                          '-display', 'none',
                          '-object', 'memory-backend-ram,id=mem1,size=1G',
                          '-device', 'pc-dimm,id=vm0,memdev=mem1')
@@ -314,12 +314,12 @@ def test_phybits_low_tcg_q35_intel_cxl(self):
         alignment constraints with 40 bits (1 TiB) of processor physical bits.
         """
         self.ensure_64bit_binary()
+        self.set_machine('q35')
         self.vm.add_args('-S', '-cpu', 'Skylake-Server,phys-bits=40',
-                         '-machine', 'q35,cxl=on', '-m',
-                         '512,slots=1,maxmem=987G',
+                         '-m', '512,slots=1,maxmem=987G',
                          '-display', 'none',
                          '-device', 'pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1',
-                         '-M', 'cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=1G')
+                         '-M', 'cxl=on,cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=1G')
         self.vm.set_qmp_monitor(enabled=False)
         self.vm.launch()
         self.vm.wait()
@@ -333,9 +333,10 @@ def test_phybits_ok_tcg_q35_intel_cxl(self):
         with cxl enabled.
         """
         self.ensure_64bit_binary()
+        self.set_machine('q35')
         self.vm.add_args('-S', '-cpu', 'Skylake-Server,phys-bits=40',
-                         '-machine', 'q35,cxl=on', '-m',
-                         '512,slots=1,maxmem=987G',
+                         '-machine', 'cxl=on',
+                         '-m', '512,slots=1,maxmem=987G',
                          '-display', 'none',
                          '-device', 'pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1')
         self.vm.set_qmp_monitor(enabled=False)
-- 
2.49.0


