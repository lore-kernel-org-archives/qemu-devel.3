Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E310C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 11:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4I2F-0003m1-JY; Mon, 14 Apr 2025 07:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4I1j-0003VU-Fu
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 07:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4I1g-0003vH-F7
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 07:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744630254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+iAdaQ+NI5jREqyJw1BczLgIl/Xxx+7leiQHYSN6Rc=;
 b=COTc8lq6xwHFaAluqIfOcnrFd/KiprgCuIfo98zrUUzEWpb3JILV48m1Bjuel3NDmlRte+
 gqzClgnd/LMZr6LHAS+yNKBYAlizzuZuP4JxQ8qkHuH2NstRJbuVmISoc10XLqHiubIdl8
 xBRheM4L5NSCyLy25lZUz19DzaWWhLo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-eFl2C2d9NXiAqvZ5fzVWZA-1; Mon,
 14 Apr 2025 07:30:51 -0400
X-MC-Unique: eFl2C2d9NXiAqvZ5fzVWZA-1
X-Mimecast-MFC-AGG-ID: eFl2C2d9NXiAqvZ5fzVWZA_1744630251
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC7F2180025B; Mon, 14 Apr 2025 11:30:50 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD5C61956094; Mon, 14 Apr 2025 11:30:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH v2 10/15] tests/avocado: Remove the boot_linux.py tests
Date: Mon, 14 Apr 2025 13:30:24 +0200
Message-ID: <20250414113031.151105-11-thuth@redhat.com>
In-Reply-To: <20250414113031.151105-1-thuth@redhat.com>
References: <20250414113031.151105-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

These tests are based on the cloudinit functions from Avocado.
The cloudinit is very, very slow compared to our other tests,
so most of these Avocado tests have either been disabled by default
with a decorator, or have been marked to only run with KVM.

We won't include this sluggish cloudinit stuff in the functional
framework, and we've already got plenty of other tests there that
check pretty much the same things, so let's simply get rid of these
old tests now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux.py | 132 ------------------------------------
 1 file changed, 132 deletions(-)
 delete mode 100644 tests/avocado/boot_linux.py

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
deleted file mode 100644
index a029ef4ad1e..00000000000
--- a/tests/avocado/boot_linux.py
+++ /dev/null
@@ -1,132 +0,0 @@
-# Functional test that boots a complete Linux system via a cloud image
-#
-# Copyright (c) 2018-2020 Red Hat, Inc.
-#
-# Author:
-#  Cleber Rosa <crosa@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import os
-
-from avocado_qemu.linuxtest import LinuxTest
-from avocado_qemu import BUILD_DIR
-
-from avocado import skipUnless
-
-
-class BootLinuxX8664(LinuxTest):
-    """
-    :avocado: tags=arch:x86_64
-    """
-    timeout = 480
-
-    def test_pc_i440fx_tcg(self):
-        """
-        :avocado: tags=machine:pc
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pc_i440fx_kvm(self):
-        """
-        :avocado: tags=machine:pc
-        :avocado: tags=accel:kvm
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pc_q35_tcg(self):
-        """
-        :avocado: tags=machine:q35
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pc_q35_kvm(self):
-        """
-        :avocado: tags=machine:q35
-        :avocado: tags=accel:kvm
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-
-# For Aarch64 we only boot KVM tests in CI as booting the current
-# Fedora OS in TCG tests is very heavyweight. There are lighter weight
-# distros which we use in the machine_aarch64_virt.py tests.
-class BootLinuxAarch64(LinuxTest):
-    """
-    :avocado: tags=arch:aarch64
-    :avocado: tags=machine:virt
-    """
-    timeout = 720
-
-    def test_virt_kvm(self):
-        """
-        :avocado: tags=accel:kvm
-        :avocado: tags=cpu:host
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.vm.add_args("-machine", "virt,gic-version=host")
-        self.vm.add_args('-bios',
-                         os.path.join(BUILD_DIR, 'pc-bios',
-                                      'edk2-aarch64-code.fd'))
-        self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
-        self.vm.add_args('-object', 'rng-random,id=rng0,filename=/dev/urandom')
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-
-# See the tux_baseline.py tests for almost the same coverage in a lot
-# less time.
-class BootLinuxPPC64(LinuxTest):
-    """
-    :avocado: tags=arch:ppc64
-    """
-
-    timeout = 360
-
-    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
-    def test_pseries_tcg(self):
-        """
-        :avocado: tags=machine:pseries
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-    def test_pseries_kvm(self):
-        """
-        :avocado: tags=machine:pseries
-        :avocado: tags=accel:kvm
-        """
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.vm.add_args("-machine", "cap-ccf-assist=off")
-        self.launch_and_wait(set_up_ssh_connection=False)
-
-class BootLinuxS390X(LinuxTest):
-    """
-    :avocado: tags=arch:s390x
-    """
-
-    timeout = 240
-
-    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
-    def test_s390_ccw_virtio_tcg(self):
-        """
-        :avocado: tags=machine:s390-ccw-virtio
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        self.vm.add_args("-accel", "tcg")
-        self.launch_and_wait(set_up_ssh_connection=False)
-- 
2.49.0


