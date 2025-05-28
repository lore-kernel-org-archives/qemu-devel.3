Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2F5C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDgP-0004uD-8j; Wed, 28 May 2025 06:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDg6-0004LN-IC
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDg4-0007HT-E2
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rt3bHuCxCuBXdn4uoTDU3Fdy2gUlNffEYdVpuhW8WkE=;
 b=EtMKFRSbYVTpwVySr3ArOepc2bCJDP/l+O4RDIfsHPlwwUj6tej9M5OmpUFJFDbg7dOUGx
 qUJZ+6sPEnaJvn+A0CnM3jfjIGLIQ9ATSwfDCQ3CYVakEd851KQkdTRFTHPFdPC7T8G7JU
 UhbWPL/62p/MquFDylCRxg8FV1oEIRA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-yPtv79oZM9qUJSneKt9oYA-1; Wed,
 28 May 2025 06:05:22 -0400
X-MC-Unique: yPtv79oZM9qUJSneKt9oYA-1
X-Mimecast-MFC-AGG-ID: yPtv79oZM9qUJSneKt9oYA_1748426721
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 222961800875; Wed, 28 May 2025 10:05:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1587E180049D; Wed, 28 May 2025 10:05:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/27] tests/functional/test_mem_addr_space: Use set_machine()
 to select the machine
Date: Wed, 28 May 2025 12:04:43 +0200
Message-ID: <20250528100507.313906-4-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

By using self.set_machine() the tests get properly skipped in case
the machine has not been compiled into the QEMU binary, e.g. when
"configure" has been run with "--without-default-devices".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250521143732.140711-1-thuth@redhat.com>
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


