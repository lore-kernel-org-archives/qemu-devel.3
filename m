Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE643C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UfQ-0003Kb-OM; Wed, 23 Apr 2025 03:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfN-0003JD-8C
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfK-0003JV-VK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZRqi4JdQILCcaeMQSCdPvw0mRP3kSVf+QSe3K1vKOo=;
 b=fvAWDpnZxhtzTYc7NxlqFPxSQIuh7SCFKFmUzncaGe4/cKi9AJVlGvsDWLAP2DVERqKYUP
 YKZ/VAxukl6nzc6ILyDv9Jq+661g8kLxlvcryt1IMn445R9Cf6ViMaMt5GzKmuUIXv9qgL
 oDe1pyl7LAwAnucQWtJFqPG1OwP0RMY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-rn5nguKmMwCuRKU3XiZ_pQ-1; Wed,
 23 Apr 2025 03:37:00 -0400
X-MC-Unique: rn5nguKmMwCuRKU3XiZ_pQ-1
X-Mimecast-MFC-AGG-ID: rn5nguKmMwCuRKU3XiZ_pQ_1745393819
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ACD11800263; Wed, 23 Apr 2025 07:36:59 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F27E619560A3; Wed, 23 Apr 2025 07:36:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 20/29] tests/avocado: Remove the boot_linux.py tests
Date: Wed, 23 Apr 2025 09:36:00 +0200
Message-ID: <20250423073610.271585-21-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

These tests are based on the cloudinit functions from Avocado.
The cloudinit is very, very slow compared to our other tests,
so most of these Avocado tests have either been disabled by default
with a decorator, or have been marked to only run with KVM.

We won't include this sluggish cloudinit stuff in the functional
framework, and we've already got plenty of other tests there that
check pretty much the same things, so let's simply get rid of these
old tests now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-11-thuth@redhat.com>
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


