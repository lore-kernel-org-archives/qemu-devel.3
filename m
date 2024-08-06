Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4016C52D71
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 17:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbO2q-0007li-4K; Tue, 06 Aug 2024 13:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sbO2i-0007fa-S7
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 13:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sbO2f-0006OZ-AZ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 13:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722965532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X/GXQbUC+egQPtXlpcMkSOyDnU1wegvQLfhRmhDNQso=;
 b=cvBcIExnHBO9QaancAk2jTyQH+v1B3Pk2hW8y3sI/X4dw0sYMjeKM7hlI+w4N//nPUuoTo
 Uv2nOuLz451hZ6FA1XSpsHh/Lb+e0FImK1Xy/n7KkB1i6xZXOeBEPZ91P6UGc6iFvToqLr
 W2kmq0GWU1Ik+eCg57X+Kb9rOZOBOOc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-qFtQ_wqSOQOYfMZtDARYNA-1; Tue,
 06 Aug 2024 13:32:08 -0400
X-MC-Unique: qFtQ_wqSOQOYfMZtDARYNA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4783E1955BEF; Tue,  6 Aug 2024 17:32:04 +0000 (UTC)
Received: from p1.localdomain.com (unknown [10.39.192.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2C8F1956046; Tue,  6 Aug 2024 17:31:49 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Radoslaw Biernacki <rad@semihalf.com>, Troy Lee <leetroy@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Beraldo Leal <bleal@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paul Durrant <paul@xen.org>, Eric Auger <eric.auger@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>
Subject: [PATCH v2 2/9] tests/avocado: apply proper skipUnless decorator
Date: Tue,  6 Aug 2024 13:31:12 -0400
Message-ID: <20240806173119.582857-3-crosa@redhat.com>
In-Reply-To: <20240806173119.582857-1-crosa@redhat.com>
References: <20240806173119.582857-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit 9b45cc993 added many cases of skipUnless for the sake of
organizing flaky tests.  But, Python decorators *must* follow what
they decorate, so the newlines added should *not* exist there.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/avocado/boot_linux_console.py | 1 -
 tests/avocado/intel_iommu.py        | 1 -
 tests/avocado/linux_initrd.py       | 1 -
 tests/avocado/machine_aspeed.py     | 2 --
 tests/avocado/machine_mips_malta.py | 2 --
 tests/avocado/machine_rx_gdbsim.py  | 2 --
 tests/avocado/reverse_debugging.py  | 4 ----
 tests/avocado/smmu.py               | 1 -
 8 files changed, 14 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 2929aa042d..cffdd6b5a2 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1522,7 +1522,6 @@ def test_ppc_mac99(self):
     # like issues with a buggy kernel. As a result we don't want it
     # gating releases on Gitlab.
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_sh4_r2d(self):
         """
         :avocado: tags=arch:sh4
diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
index 008f214397..992583fa7d 100644
--- a/tests/avocado/intel_iommu.py
+++ b/tests/avocado/intel_iommu.py
@@ -13,7 +13,6 @@
 from avocado_qemu.linuxtest import LinuxTest
 
 @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
 class IntelIOMMU(LinuxTest):
     """
     :avocado: tags=arch:x86_64
diff --git a/tests/avocado/linux_initrd.py b/tests/avocado/linux_initrd.py
index aad5b19bd9..7f47b98ae7 100644
--- a/tests/avocado/linux_initrd.py
+++ b/tests/avocado/linux_initrd.py
@@ -54,7 +54,6 @@ def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
             self.assertRegex(self.vm.get_log(), expected_msg)
 
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_with_2gib_file_should_work_with_linux_v4_16(self):
         """
         :avocado: tags=flaky
diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
index f8e263d37e..c0b01e8f1f 100644
--- a/tests/avocado/machine_aspeed.py
+++ b/tests/avocado/machine_aspeed.py
@@ -323,7 +323,6 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
         self.wait_for_console_pattern('Starting kernel ...')
 
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_arm_ast2500_evb_sdk(self):
         """
         :avocado: tags=arch:arm
@@ -343,7 +342,6 @@ def test_arm_ast2500_evb_sdk(self):
         self.wait_for_console_pattern('nodistro.0 ast2500-default ttyS4')
 
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_arm_ast2600_evb_sdk(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 8cf84bd805..07a80633b5 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -102,7 +102,6 @@ def test_mips_malta_i6400_framebuffer_logo_1core(self):
         self.do_test_i6400_framebuffer_logo(1)
 
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
         :avocado: tags=arch:mips64el
@@ -114,7 +113,6 @@ def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         self.do_test_i6400_framebuffer_logo(7)
 
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         """
         :avocado: tags=arch:mips64el
diff --git a/tests/avocado/machine_rx_gdbsim.py b/tests/avocado/machine_rx_gdbsim.py
index 412a7a5089..72f0296e21 100644
--- a/tests/avocado/machine_rx_gdbsim.py
+++ b/tests/avocado/machine_rx_gdbsim.py
@@ -23,7 +23,6 @@ class RxGdbSimMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_uboot(self):
         """
         U-Boot and checks that the console is operational.
@@ -49,7 +48,6 @@ def test_uboot(self):
         #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
 
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_linux_sash(self):
         """
         Boots a Linux kernel and checks that the console is operational.
diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 92855a02a5..f24287cd0a 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -207,7 +207,6 @@ def get_pc(self, g):
 
     # unidentified gitlab timeout problem
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
@@ -225,7 +224,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):
 
     # unidentified gitlab timeout problem
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -250,7 +248,6 @@ class ReverseDebugging_ppc64(ReverseDebugging):
 
     # unidentified gitlab timeout problem
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_ppc64_pseries(self):
         """
         :avocado: tags=arch:ppc64
@@ -265,7 +262,6 @@ def test_ppc64_pseries(self):
 
     # See https://gitlab.com/qemu-project/qemu/-/issues/1992
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_ppc64_powernv(self):
         """
         :avocado: tags=arch:ppc64
diff --git a/tests/avocado/smmu.py b/tests/avocado/smmu.py
index aadda71e4b..83fd79e922 100644
--- a/tests/avocado/smmu.py
+++ b/tests/avocado/smmu.py
@@ -14,7 +14,6 @@
 from avocado_qemu.linuxtest import LinuxTest
 
 @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
 class SMMU(LinuxTest):
     """
     :avocado: tags=accel:kvm
-- 
2.45.2


