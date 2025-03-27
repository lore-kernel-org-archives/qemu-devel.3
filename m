Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAEEC3600C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 08:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txiGC-0000PI-Kc; Thu, 27 Mar 2025 04:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txiG8-0000Og-7U
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txiG6-000631-AL
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743062797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uh9WZBy2XlV+60/QKs9gjhj0GiQ0FnBBh7/xX9RfVHY=;
 b=V5FPPcOakR5yK/q7XnYkfyCOHyxgI+cqKf3ubK8THDMn3ZcH0tCAmqGwhxrCS0CoFgiUEZ
 3swPF+Yx9CGgeoOo8JQ2E/O986xvbvCxYX3QaGP1VvJt+8a0cxAjgTjeX2Q1S9PIVUugML
 lvjxFJPBPuQknV11IBCT9zOe9mNlacE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-KmWIUSGMO4ippRUaqnaD9g-1; Thu,
 27 Mar 2025 04:06:35 -0400
X-MC-Unique: KmWIUSGMO4ippRUaqnaD9g-1
X-Mimecast-MFC-AGG-ID: KmWIUSGMO4ippRUaqnaD9g_1743062795
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8E7D1809CA6
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 08:06:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.126])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 226CF19560AB; Thu, 27 Mar 2025 08:06:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 3/6] tests/functional: Add missing require_netdev('user')
 statements
Date: Thu, 27 Mar 2025 09:06:19 +0100
Message-ID: <20250327080622.954388-4-thuth@redhat.com>
In-Reply-To: <20250327080622.954388-1-thuth@redhat.com>
References: <20250327080622.954388-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

A bunch of tests are using "-netdev user" but fail to check
for the availability of SLIRP in the binary, so these tests
fail if QEMU has been configured with "--disable-slirp"
(most of the tests are disabled by default with a decorator,
that's likely why nobody noticed this problem yet). Add the
missing self.require_netdev('user') statements to skip the
tests if SLIRP is not available.

Message-ID: <20250324123450.111307-1-thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_aarch64_rme_sbsaref.py | 1 +
 tests/functional/test_aarch64_rme_virt.py    | 4 +++-
 tests/functional/test_arm_bpim2u.py          | 2 ++
 tests/functional/test_arm_cubieboard.py      | 2 ++
 tests/functional/test_arm_orangepi.py        | 4 ++++
 tests/functional/test_ppc64_hv.py            | 3 +++
 tests/functional/test_x86_64_kvm_xen.py      | 1 +
 7 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/test_aarch64_rme_sbsaref.py
index ddcc9493a6c..0f4f6103a1e 100755
--- a/tests/functional/test_aarch64_rme_sbsaref.py
+++ b/tests/functional/test_aarch64_rme_sbsaref.py
@@ -33,6 +33,7 @@ class Aarch64RMESbsaRefMachine(QemuSystemTest):
     def test_aarch64_rme_sbsaref(self):
         self.set_machine('sbsa-ref')
         self.require_accelerator('tcg')
+        self.require_netdev('user')
 
         self.vm.set_console()
 
diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
index 38e01721a4e..f4ad4d33d58 100755
--- a/tests/functional/test_aarch64_rme_virt.py
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -60,8 +60,10 @@ class Aarch64RMEVirtMachine(QemuSystemTest):
     # and launching a nested VM using it.
     def test_aarch64_rme_virt(self):
         self.set_machine('virt')
-        self.vm.set_console()
         self.require_accelerator('tcg')
+        self.require_netdev('user')
+
+        self.vm.set_console()
 
         stack_path_tar_gz = self.ASSET_RME_STACK_VIRT.fetch()
         self.archive_extract(stack_path_tar_gz, format="tar")
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
index 12cd3597460..8de6ccba881 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -140,6 +140,8 @@ def test_arm_bpim2u_gmac(self):
     @skipBigDataTest()
     def test_arm_bpim2u_openwrt_22_03_3(self):
         self.set_machine('bpim2u')
+        self.require_netdev('user')
+
         # This test download a 8.9 MiB compressed image and expand it
         # to 127 MiB.
         image_path = self.uncompress(self.ASSET_SD_IMAGE)
diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/test_arm_cubieboard.py
index 423db710e82..b87a28154da 100755
--- a/tests/functional/test_arm_cubieboard.py
+++ b/tests/functional/test_arm_cubieboard.py
@@ -107,6 +107,8 @@ def test_arm_cubieboard_openwrt_22_03_2(self):
         # This test download a 7.5 MiB compressed image and expand it
         # to 126 MiB.
         self.set_machine('cubieboard')
+        self.require_netdev('user')
+
         image_path = self.uncompress(self.ASSET_OPENWRT)
         image_pow2ceil_expand(image_path)
 
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index 28919391e5d..1815f56e027 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -147,6 +147,8 @@ def test_arm_orangepi_sd(self):
     @skipBigDataTest()
     def test_arm_orangepi_armbian(self):
         self.set_machine('orangepi-pc')
+        self.require_netdev('user')
+
         # This test download a 275 MiB compressed image and expand it
         # to 1036 MiB, but the underlying filesystem is 1552 MiB...
         # As we expand it to 2 GiB we are safe.
@@ -181,6 +183,8 @@ def test_arm_orangepi_armbian(self):
     @skipBigDataTest()
     def test_arm_orangepi_uboot_netbsd9(self):
         self.set_machine('orangepi-pc')
+        self.require_netdev('user')
+
         # This test download a 304MB compressed image and expand it to 2GB
         # We use the common OrangePi PC 'plus' build of U-Boot for our secondary
         # program loader (SPL). We will then set the path to the more specific
diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 62f996adf6d..1920e91f18b 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -125,6 +125,7 @@ def do_test_kvm(self, hpt=False):
 
     def test_hv_pseries(self):
         self.require_accelerator("tcg")
+        self.require_netdev('user')
         self.set_machine('pseries')
         self.vm.add_args("-accel", "tcg,thread=multi")
         self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
@@ -136,6 +137,7 @@ def test_hv_pseries(self):
 
     def test_hv_pseries_kvm(self):
         self.require_accelerator("kvm")
+        self.require_netdev('user')
         self.set_machine('pseries')
         self.vm.add_args("-accel", "kvm")
         self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
@@ -147,6 +149,7 @@ def test_hv_pseries_kvm(self):
 
     def test_hv_powernv(self):
         self.require_accelerator("tcg")
+        self.require_netdev('user')
         self.set_machine('powernv')
         self.vm.add_args("-accel", "tcg,thread=multi")
         self.vm.add_args('-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234,drive=drive0',
diff --git a/tests/functional/test_x86_64_kvm_xen.py b/tests/functional/test_x86_64_kvm_xen.py
index 3bedef6c98c..c6abf6bba3b 100755
--- a/tests/functional/test_x86_64_kvm_xen.py
+++ b/tests/functional/test_x86_64_kvm_xen.py
@@ -41,6 +41,7 @@ class KVMXenGuest(QemuSystemTest):
     def common_vm_setup(self):
         # We also catch lack of KVM_XEN support if we fail to launch
         self.require_accelerator("kvm")
+        self.require_netdev('user')
 
         self.vm.set_console()
 
-- 
2.49.0


