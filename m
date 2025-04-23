Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBC7C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UfS-0003RG-63; Wed, 23 Apr 2025 03:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfN-0003JF-93
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfK-0003JQ-FZ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+sGRaPNLJFFzE4winYe8fJw+6o17Oi8yTqbGM972Eo=;
 b=WDYx+vkbzj6suxLiugT1CI97jR1NRyBYa0jWSP5KX4681opp62kOkKBKwwg4gI8/uDwnVE
 q9xBiyZqQPmNkDgY9OpWQ9RzZyeowELJhndoxjEuKxj9s4K4dugakYw+O9Lxoa30O54D6r
 ah7VKYfguWHFsL/2o9ycJ1EevplfKcQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-79_-EBErMWKbWrs8HtcvkQ-1; Wed,
 23 Apr 2025 03:37:02 -0400
X-MC-Unique: 79_-EBErMWKbWrs8HtcvkQ-1
X-Mimecast-MFC-AGG-ID: 79_-EBErMWKbWrs8HtcvkQ_1745393821
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 910F918001CA; Wed, 23 Apr 2025 07:37:01 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00B9319560A3; Wed, 23 Apr 2025 07:36:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 21/29] tests/functional: Use the tuxrun kernel for the x86
 replay test
Date: Wed, 23 Apr 2025 09:36:01 +0200
Message-ID: <20250423073610.271585-22-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

This way we can do a full boot in record-replay mode and
should get a similar test coverage compared to the old
replay test from tests/avocado/replay_linux.py. Thus remove
the x86 avocado replay_linux test now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-12-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/replay_linux.py          | 46 --------------------------
 tests/functional/test_x86_64_replay.py | 43 ++++++++++++++++++------
 2 files changed, 33 insertions(+), 56 deletions(-)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index 59169224353..6ba283d3bf6 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -118,52 +118,6 @@ def run_replay_dump(self, replay_path):
         except subprocess.CalledProcessError:
             self.fail('replay-dump.py failed')
 
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-class ReplayLinuxX8664(ReplayLinux):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=accel:tcg
-    """
-
-    chksum = 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0'
-
-    def test_pc_i440fx(self):
-        """
-        :avocado: tags=machine:pc
-        """
-        self.run_rr(shift=1)
-
-    def test_pc_q35(self):
-        """
-        :avocado: tags=machine:q35
-        """
-        self.run_rr(shift=3)
-
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-class ReplayLinuxX8664Virtio(ReplayLinux):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=virtio
-    :avocado: tags=accel:tcg
-    """
-
-    hdd = 'virtio-blk-pci'
-    cd = 'virtio-blk-pci'
-    bus = None
-
-    chksum = 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0'
-
-    def test_pc_i440fx(self):
-        """
-        :avocado: tags=machine:pc
-        """
-        self.run_rr(shift=1)
-
-    def test_pc_q35(self):
-        """
-        :avocado: tags=machine:q35
-        """
-        self.run_rr(shift=3)
 
 @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
 class ReplayLinuxAarch64(ReplayLinux):
diff --git a/tests/functional/test_x86_64_replay.py b/tests/functional/test_x86_64_replay.py
index 180f23a60c5..27287d452dc 100755
--- a/tests/functional/test_x86_64_replay.py
+++ b/tests/functional/test_x86_64_replay.py
@@ -5,30 +5,53 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset, skipFlakyTest
+from subprocess import check_call, DEVNULL
+
+from qemu_test import Asset, skipFlakyTest, get_qemu_img
 from replay_kernel import ReplayKernelBase
 
 
 class X86Replay(ReplayKernelBase):
 
     ASSET_KERNEL = Asset(
-         ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
-          '/releases/29/Everything/x86_64/os/images/pxeboot/vmlinuz'),
-        '8f237d84712b1b411baf3af2aeaaee10b9aae8e345ec265b87ab3a39639eb143')
+        'https://storage.tuxboot.com/buildroot/20241119/x86_64/bzImage',
+        'f57bfc6553bcd6e0a54aab86095bf642b33b5571d14e3af1731b18c87ed5aef8')
+
+    ASSET_ROOTFS = Asset(
+        'https://storage.tuxboot.com/buildroot/20241119/x86_64/rootfs.ext4.zst',
+        '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
 
-    def do_test_x86(self, machine):
+    def do_test_x86(self, machine, blkdevice, devroot):
+        self.require_netdev('user')
         self.set_machine(machine)
+        self.cpu="Nehalem"
         kernel_path = self.ASSET_KERNEL.fetch()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'VFS: Cannot open root device'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
+        raw_disk = self.uncompress(self.ASSET_ROOTFS)
+        disk = self.scratch_file('scratch.qcow2')
+        qemu_img = get_qemu_img(self)
+        check_call([qemu_img, 'create', '-f', 'qcow2', '-b', raw_disk,
+                    '-F', 'raw', disk], stdout=DEVNULL, stderr=DEVNULL)
+
+        args = ('-drive', 'file=%s,snapshot=on,id=hd0,if=none' % disk,
+                '-drive', 'driver=blkreplay,id=hd0-rr,if=none,image=hd0',
+                '-device', '%s,drive=hd0-rr' % blkdevice,
+                '-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
+                '-device', 'virtio-net,netdev=vnet',
+                '-object', 'filter-replay,id=replay,netdev=vnet')
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               f"console=ttyS0 root=/dev/{devroot}")
+        console_pattern = 'Welcome to TuxTest'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
+                    args=args)
 
     @skipFlakyTest('https://gitlab.com/qemu-project/qemu/-/issues/2094')
     def test_pc(self):
-        self.do_test_x86('pc')
+        self.do_test_x86('pc', 'virtio-blk', 'vda')
 
     def test_q35(self):
-        self.do_test_x86('q35')
+        self.do_test_x86('q35', 'ide-hd', 'sda')
 
 
 if __name__ == '__main__':
-- 
2.49.0


