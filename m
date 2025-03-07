Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBDDC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWH2-0002NM-6f; Fri, 07 Mar 2025 06:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWGz-0002Mu-IH
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWGx-0000Ks-V7
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741348424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X/Gx09Fa5xKgnrPHQVMi3DB/WVQEZMM2n1MRlNhuThA=;
 b=RQKGeNUNrVGWdj3QTmehYVPpcJ/IymjIkaL5P52yaSQpt1SmOPY4JjAyztLy5GNibh2yZh
 yheTmc2+ypptQTA6rD3HDryoIX2lrHsUJbNv5JDKe/7942JCeStKriLKW37+HdE57cH8q9
 o8lRu3o9am1Spq9F30lfCxtjHRIEzUs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-EtZJ8h8qPe6Wd2fXBR_Uww-1; Fri,
 07 Mar 2025 06:53:43 -0500
X-MC-Unique: EtZJ8h8qPe6Wd2fXBR_Uww-1
X-Mimecast-MFC-AGG-ID: EtZJ8h8qPe6Wd2fXBR_Uww_1741348418
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1ADD1800258
 for <qemu-devel@nongnu.org>; Fri,  7 Mar 2025 11:53:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44C441944E45; Fri,  7 Mar 2025 11:53:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 07/15] tests/functional: Move the code for testing HTTP
 downloads to a common function
Date: Fri,  7 Mar 2025 12:53:06 +0100
Message-ID: <20250307115314.1096373-8-thuth@redhat.com>
In-Reply-To: <20250307115314.1096373-1-thuth@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We are going to use this code in other tests, too, so let's move it
to the qemu_test module to be able to re-use it more easily.

Message-ID: <20250227103915.19795-2-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/linuxkernel.py | 26 ++++++++++++++++++++++-
 tests/functional/test_intel_iommu.py      | 22 +------------------
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
index 2c9598102d0..2aca0ee3cd0 100644
--- a/tests/functional/qemu_test/linuxkernel.py
+++ b/tests/functional/qemu_test/linuxkernel.py
@@ -3,8 +3,12 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import hashlib
+import urllib.request
+
+from .cmd import wait_for_console_pattern, exec_command_and_wait_for_pattern
 from .testcase import QemuSystemTest
-from .cmd import wait_for_console_pattern
+from .utils import get_usernet_hostfwd_port
 
 
 class LinuxKernelTest(QemuSystemTest):
@@ -26,3 +30,23 @@ def launch_kernel(self, kernel, initrd=None, dtb=None, console_index=0,
         self.vm.launch()
         if wait_for:
                 self.wait_for_console_pattern(wait_for)
+
+    def check_http_download(self, filename, hashsum, guestport=8080,
+                            pythoncmd='python3 -m http.server'):
+        exec_command_and_wait_for_pattern(self,
+                        f'{pythoncmd} {guestport} & sleep 1',
+                        f'Serving HTTP on 0.0.0.0 port {guestport}')
+        hl = hashlib.sha256()
+        hostport = get_usernet_hostfwd_port(self.vm)
+        url = f'http://localhost:{hostport}{filename}'
+        self.log.info(f'Downloading {url} ...')
+        with urllib.request.urlopen(url) as response:
+            while True:
+                chunk = response.read(1 << 20)
+                if not chunk:
+                    break
+                hl.update(chunk)
+
+        digest = hl.hexdigest()
+        self.log.info(f'sha256sum of download is {digest}.')
+        self.assertEqual(digest, hashsum)
diff --git a/tests/functional/test_intel_iommu.py b/tests/functional/test_intel_iommu.py
index a9e8f82ab59..62268d6f278 100755
--- a/tests/functional/test_intel_iommu.py
+++ b/tests/functional/test_intel_iommu.py
@@ -10,11 +10,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-import hashlib
-import urllib.request
-
 from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
-from qemu_test.utils import get_usernet_hostfwd_port
 
 
 class IntelIOMMU(LinuxKernelTest):
@@ -125,23 +121,7 @@ def run_and_check(self):
 
         # Check virtio-net via HTTP:
         exec_command_and_wait_for_pattern(self, 'dhclient eth0', prompt)
-        exec_command_and_wait_for_pattern(self,
-                        f'python3 -m http.server {self.GUEST_PORT} & sleep 1',
-                        f'Serving HTTP on 0.0.0.0 port {self.GUEST_PORT}')
-        hl = hashlib.sha256()
-        hostport = get_usernet_hostfwd_port(self.vm)
-        url = f'http://localhost:{hostport}{filename}'
-        self.log.info(f'Downloading {url} ...')
-        with urllib.request.urlopen(url) as response:
-            while True:
-                chunk = response.read(1 << 20)
-                if not chunk:
-                    break
-                hl.update(chunk)
-
-        digest = hl.hexdigest()
-        self.log.info(f'sha256sum of download is {digest}.')
-        self.assertEqual(digest, hashsum)
+        self.check_http_download(filename, hashsum, self.GUEST_PORT)
 
     def test_intel_iommu(self):
         self.common_vm_setup()
-- 
2.48.1


