Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E77CD4849
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnRZ-0005gb-Vi; Wed, 04 Sep 2024 06:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRY-0005Wp-8o
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRW-0000PF-Ak
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JQzJpzesH1N3A3aQsAKx+l2IijSmpbQecserzAcvts=;
 b=CTbX0qyBeLZjT87jjbLdeQseP7+apRYuWCcYQqaW62N4qNqS0vPB30qGEo3gPivEt3sqQ5
 YyDSmUpPuLNz32omeFxSZBkRO/2fmvv/hgw4BVm50RhR/grBx58VMl/0m0GtfxpP+kfJyx
 jYYTiD41NjntcJEfH4eQ+osvG1L7ut0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-gGQLOt8uMDK-th46dTJ_5w-1; Wed,
 04 Sep 2024 06:40:52 -0400
X-MC-Unique: gGQLOt8uMDK-th46dTJ_5w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21C4619560AE; Wed,  4 Sep 2024 10:40:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C1421955F44; Wed,  4 Sep 2024 10:40:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 30/42] tests/functional: Convert the linux_initrd avocado test
 into a standalone test
Date: Wed,  4 Sep 2024 12:39:05 +0200
Message-ID: <20240904103923.451847-31-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While we're at it, update the SHA1 hashes to SHA256 hashes since
SHA1 should not be used anymore nowadays.

Message-ID: <20240830133841.142644-32-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                  |  1 +
 .../test_linux_initrd.py}                     | 37 +++++++++++--------
 2 files changed, 22 insertions(+), 16 deletions(-)
 rename tests/{avocado/linux_initrd.py => functional/test_linux_initrd.py} (76%)
 mode change 100644 => 100755

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 3857630f58..2e34f4ddfd 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -102,6 +102,7 @@ tests_x86_64_system_quick = [
 
 tests_x86_64_system_thorough = [
   'acpi_bits',
+  'linux_initrd',
   'netdev_ethtool',
   'virtio_gpu',
 ]
diff --git a/tests/avocado/linux_initrd.py b/tests/functional/test_linux_initrd.py
old mode 100644
new mode 100755
similarity index 76%
rename from tests/avocado/linux_initrd.py
rename to tests/functional/test_linux_initrd.py
index 7f47b98ae7..c71a59d4c9
--- a/tests/avocado/linux_initrd.py
+++ b/tests/functional/test_linux_initrd.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Linux initrd integration test.
 #
 # Copyright (c) 2018 Red Hat, Inc.
@@ -12,20 +14,27 @@
 import logging
 import tempfile
 
-from avocado_qemu import QemuSystemTest
-from avocado import skipUnless
+from qemu_test import QemuSystemTest, Asset
+from unittest import skipUnless
 
 
 class LinuxInitrd(QemuSystemTest):
     """
     Checks QEMU evaluates correctly the initrd file passed as -initrd option.
-
-    :avocado: tags=arch:x86_64
-    :avocado: tags=machine:pc
     """
 
     timeout = 300
 
+    ASSET_F18_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/18/Fedora/x86_64/os/images/pxeboot/vmlinuz'),
+        '1a27cb42559ce29237ac186699d063556ad69c8349d732bb1bd8d614e5a8cc2e')
+
+    ASSET_F28_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/28/Everything/x86_64/os/images/pxeboot/vmlinuz'),
+        'd05909c9d4a742a6fcc84dcc0361009e4611769619cc187a07107579a035f24e')
+
     def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
         """
         Pretends to boot QEMU with an initrd file with size of 2GiB
@@ -33,10 +42,8 @@ def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
         Fedora-18 shipped with linux-3.6 which have not supported xloadflags
         cannot support more than 2GiB initrd.
         """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora/li'
-                      'nux/releases/18/Fedora/x86_64/os/images/pxeboot/vmlinuz')
-        kernel_hash = '41464f68efe42b9991250bed86c7081d2ccdbb21'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.set_machine('pc')
+        kernel_path = self.ASSET_F18_KERNEL.fetch()
         max_size = 2 * (1024 ** 3) - 1
 
         with tempfile.NamedTemporaryFile() as initrd:
@@ -56,16 +63,11 @@ def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
     def test_with_2gib_file_should_work_with_linux_v4_16(self):
         """
-        :avocado: tags=flaky
-
         QEMU has supported up to 4 GiB initrd for recent kernel
         Expect guest can reach 'Unpacking initramfs...'
         """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/28/Everything/x86_64/os/images/pxeboot/'
-                      'vmlinuz')
-        kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.set_machine('pc')
+        kernel_path = self.ASSET_F28_KERNEL.fetch()
         max_size = 2 * (1024 ** 3) + 1
 
         with tempfile.NamedTemporaryFile() as initrd:
@@ -89,3 +91,6 @@ def test_with_2gib_file_should_work_with_linux_v4_16(self):
                     break
                 if 'Kernel panic - not syncing' in msg:
                     self.fail("Kernel panic reached")
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


