Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B4CCF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd4h-0002uX-Hb; Fri, 21 Nov 2025 21:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcQS-0006s2-Sm; Fri, 21 Nov 2025 20:28:32 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcOQ-0000Cz-Bu; Fri, 21 Nov 2025 20:28:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D8F1E16CA7D;
 Fri, 21 Nov 2025 21:44:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9667D321CB9;
 Fri, 21 Nov 2025 21:44:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 66/81] tests: move test_kvm_xen to share.linaro.org
Date: Fri, 21 Nov 2025 21:44:05 +0300
Message-ID: <20251121184424.1137669-66-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Alex Bennée <alex.bennee@linaro.org>

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20251117115523.3993105-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit 533b5ac2d6a826619cf80b009bf23ae3246d7011)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/functional/test_x86_64_kvm_xen.py b/tests/functional/test_x86_64_kvm_xen.py
index c6abf6bba3..0f1f5d8f0b 100755
--- a/tests/functional/test_x86_64_kvm_xen.py
+++ b/tests/functional/test_x86_64_kvm_xen.py
@@ -25,18 +25,11 @@ class KVMXenGuest(QemuSystemTest):
     kernel_path = None
     kernel_params = None
 
-    # Fetch assets from the kvm-xen-guest subdir of my shared test
-    # images directory on fileserver.linaro.org where you can find
-    # build instructions for how they where assembled.
-    ASSET_KERNEL = Asset(
-        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
-         'path=%2Fkvm-xen-guest&files=bzImage'),
-        'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
-
-    ASSET_ROOTFS = Asset(
-        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
-         'path=%2Fkvm-xen-guest&files=rootfs.ext4'),
-        'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')
+    ASSET_KERNEL = Asset('https://share.linaro.org/downloadFile?id=UG0V8dzzHrrHb9X',
+                         'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
+
+    ASSET_ROOTFS = Asset('https://share.linaro.org/downloadFile?id=VwLRKDXKFl6oKti',
+                         'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')
 
     def common_vm_setup(self):
         # We also catch lack of KVM_XEN support if we fail to launch
-- 
2.47.3


