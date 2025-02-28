Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606D7C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxbQ-0002F8-Ft; Fri, 28 Feb 2025 05:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnxbN-0002Bu-S1
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnxbJ-0002y2-IU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIj5CgtbSPT839WS9zQCCyOAoHEVDwFLnrX2MfMsPi0=;
 b=fTTK61NjJxU/MFPxPta6wJkAyiRvKJHz0qTvvXwb4pqtkYliBzrh9T1Hwkdj9zH4R9G0IV
 87Ci8Kg3UG9sxc/1fOBYOlXPHSVKf05VJfyuktJ49MmVBJFZs7rlg3uRSsAFx2AkjNjtL0
 rXZRTNo3lZWySQTk05blnWUjlvoyQks=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-8giQ7Ju5P2KKdHNgwWtilQ-1; Fri,
 28 Feb 2025 05:28:07 -0500
X-MC-Unique: 8giQ7Ju5P2KKdHNgwWtilQ-1
X-Mimecast-MFC-AGG-ID: 8giQ7Ju5P2KKdHNgwWtilQ_1740738486
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CFFE1954B1C; Fri, 28 Feb 2025 10:28:06 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9211180035F; Fri, 28 Feb 2025 10:28:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 5/7] tests/functional: skip memaddr tests on 32-bit builds
Date: Fri, 28 Feb 2025 10:27:36 +0000
Message-ID: <20250228102738.3064045-6-berrange@redhat.com>
In-Reply-To: <20250228102738.3064045-1-berrange@redhat.com>
References: <20250228102738.3064045-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

If the QEMU binary was built for a 32-bit ELF target we cannot run the
memory address space tests as they all require ability to address more
RAM that can be represented on 32-bit.

We can't use a decorator to skip the tests as we need setUp() to run to
pick the QEMU binary, thus we must call a method at the start of each
test to check and skip it. The functional result is effectively the
same as using a decorator, just less pretty. This code will go away when
32-bit hosts are full dropped from QEMU.

The code allows any non-ELF target since all macOS versions supported
at 64-bit only and we already dropped support for 32-bit Windows.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/test_mem_addr_space.py | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tests/functional/test_mem_addr_space.py b/tests/functional/test_mem_addr_space.py
index bb0cf062ca..c8bde77e51 100755
--- a/tests/functional/test_mem_addr_space.py
+++ b/tests/functional/test_mem_addr_space.py
@@ -20,6 +20,25 @@ class MemAddrCheck(QemuSystemTest):
     # this reason.
     DELAY_Q35_BOOT_SEQUENCE = 1
 
+    # This helper can go away when the 32-bit host deprecation
+    # turns into full & final removal of support.
+    def ensure_64bit_binary(self):
+        with open(self.qemu_bin, "rb") as fh:
+            ident = fh.read(4)
+
+            # "\x7fELF"
+            if ident != bytes([0x7f, 0x45, 0x4C, 0x46]):
+                # Non-ELF file implies macOS or Windows which
+                # we already assume to be 64-bit only
+                return
+
+            # bits == 1 -> 32-bit; bits == 2 -> 64-bit
+            bits = int.from_bytes(fh.read(1))
+            if bits != 2:
+                # 32-bit ELF builds won't be able to address sufficient
+                # RAM to run the tests
+                self.skipTest("64-bit build host is required")
+
     # first, lets test some 32-bit processors.
     # for all 32-bit cases, pci64_hole_size is 0.
     def test_phybits_low_pse36(self):
@@ -38,6 +57,7 @@ def test_phybits_low_pse36(self):
         If maxmem is set to 59.5G with all other QEMU parameters identical, QEMU
         should start fine.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-machine', 'q35', '-m',
                          '512,slots=1,maxmem=59.6G',
                          '-cpu', 'pentium,pse36=on', '-display', 'none',
@@ -55,6 +75,7 @@ def test_phybits_low_pae(self):
         access up to a maximum of 64GiB of memory. Rest is the same as the case
         with pse36 above.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-machine', 'q35', '-m',
                          '512,slots=1,maxmem=59.6G',
                          '-cpu', 'pentium,pae=on', '-display', 'none',
@@ -71,6 +92,7 @@ def test_phybits_ok_pentium_pse36(self):
         Setting maxmem to 59.5G and making sure that QEMU can start with the
         same options as the failing case above with pse36 cpu feature.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-machine', 'q35', '-m',
                          '512,slots=1,maxmem=59.5G',
                          '-cpu', 'pentium,pse36=on', '-display', 'none',
@@ -88,6 +110,7 @@ def test_phybits_ok_pentium_pae(self):
         Setting maxmem to 59.5G and making sure that QEMU can start fine
         with the same options as the case above.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-machine', 'q35', '-m',
                          '512,slots=1,maxmem=59.5G',
                          '-cpu', 'pentium,pae=on', '-display', 'none',
@@ -104,6 +127,7 @@ def test_phybits_ok_pentium2(self):
         Pentium2 has 36 bits of addressing, so its same as pentium
         with pse36 ON.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-machine', 'q35', '-m',
                          '512,slots=1,maxmem=59.5G',
                          '-cpu', 'pentium2', '-display', 'none',
@@ -123,6 +147,7 @@ def test_phybits_low_nonpse36(self):
         message because the region for memory hotplug is always placed
         above 4 GiB due to the PCI hole and simplicity.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-machine', 'q35', '-m',
                          '512,slots=1,maxmem=4G',
                          '-cpu', 'pentium', '-display', 'none',
@@ -150,6 +175,7 @@ def test_phybits_low_tcg_q35_70_amd(self):
         which is equal to 987.5 GiB. Setting the value to 988 GiB should
         make QEMU fail with the error message.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-machine', 'pc-q35-7.0', '-m',
                          '512,slots=1,maxmem=988G',
                          '-display', 'none',
@@ -170,6 +196,7 @@ def test_phybits_low_tcg_q35_71_amd(self):
         Make sure QEMU fails when maxmem size is 976 GiB (12 GiB less
         than 988 GiB).
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-machine', 'pc-q35-7.1', '-m',
                          '512,slots=1,maxmem=976G',
                          '-display', 'none',
@@ -186,6 +213,7 @@ def test_phybits_ok_tcg_q35_70_amd(self):
         Same as q35-7.0 AMD case except that here we check that QEMU can
         successfully start when maxmem is < 988G.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-machine', 'pc-q35-7.0', '-m',
                          '512,slots=1,maxmem=987.5G',
                          '-display', 'none',
@@ -202,6 +230,7 @@ def test_phybits_ok_tcg_q35_71_amd(self):
         Same as q35-7.1 AMD case except that here we check that QEMU can
         successfully start when maxmem is < 976G.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-machine', 'pc-q35-7.1', '-m',
                          '512,slots=1,maxmem=975.5G',
                          '-display', 'none',
@@ -219,6 +248,7 @@ def test_phybits_ok_tcg_q35_71_intel(self):
         Intel cpu instead. QEMU should start fine in this case as
         "above_4G" memory starts at 4G.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-cpu', 'Skylake-Server',
                          '-machine', 'pc-q35-7.1', '-m',
                          '512,slots=1,maxmem=976G',
@@ -243,6 +273,7 @@ def test_phybits_low_tcg_q35_71_amd_41bits(self):
         memory for the VM (1024 - 32 - 1 + 0.5). With 992 GiB, QEMU should
         fail to start.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-cpu', 'EPYC-v4,phys-bits=41',
                          '-machine', 'pc-q35-7.1', '-m',
                          '512,slots=1,maxmem=992G',
@@ -261,6 +292,7 @@ def test_phybits_ok_tcg_q35_71_amd_41bits(self):
         Same as above but by setting maxram between 976 GiB and 992 Gib,
         QEMU should start fine.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-cpu', 'EPYC-v4,phys-bits=41',
                          '-machine', 'pc-q35-7.1', '-m',
                          '512,slots=1,maxmem=990G',
@@ -281,6 +313,7 @@ def test_phybits_low_tcg_q35_intel_cxl(self):
         So maxmem here should be at most 986 GiB considering all memory boundary
         alignment constraints with 40 bits (1 TiB) of processor physical bits.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-cpu', 'Skylake-Server,phys-bits=40',
                          '-machine', 'q35,cxl=on', '-m',
                          '512,slots=1,maxmem=987G',
@@ -299,6 +332,7 @@ def test_phybits_ok_tcg_q35_intel_cxl(self):
         with the exact same parameters as above, QEMU should start fine even
         with cxl enabled.
         """
+        self.ensure_64bit_binary()
         self.vm.add_args('-S', '-cpu', 'Skylake-Server,phys-bits=40',
                          '-machine', 'q35,cxl=on', '-m',
                          '512,slots=1,maxmem=987G',
-- 
2.48.1


