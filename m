Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873B3E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrx2-0006XW-T5; Wed, 18 Dec 2024 06:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrx1-0006X6-2V
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwz-0005Sj-Fh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PR/5MqTtNFFd2UJsVh8lixPNUBQdzfVc0rIa7tdDUEo=;
 b=OwqMMaPMX62n8rK7vRbtEiMwwPbDRTcB2aX0WygBbzKQr5PPwsll3+TrBntaI45YNmt2VV
 g209XgyO50G0yk/ck2Di4f+kW11S3K3h1lqZfQe+IagvywLYH0laOEsdLrpVQLBvJHvLaM
 BE6M/L31TklppzZlpaTPpnJGmECqJTc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-I3jz4ngmOEey5ZJ8-Wtayg-1; Wed,
 18 Dec 2024 06:10:41 -0500
X-MC-Unique: I3jz4ngmOEey5ZJ8-Wtayg-1
X-Mimecast-MFC-AGG-ID: I3jz4ngmOEey5ZJ8-Wtayg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4154B19560A7
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36CB019560AD; Wed, 18 Dec 2024 11:10:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 16/38] tests/functional: move archive handling into new
 archive.py file
Date: Wed, 18 Dec 2024 12:09:36 +0100
Message-ID: <20241218110958.226932-17-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Daniel P. Berrangé <berrange@redhat.com>

More archive related code will be added shortly, so having a
separate file makes more sense.

The utils.py imports the functions from archive.py, so that
existing callers don't need to be modified. This avoids
redundant code churn until later in the series when all
calls will be adapted for other reasons.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-17-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/archive.py | 31 +++++++++++++++++++++++++++
 tests/functional/qemu_test/utils.py   | 23 +++-----------------
 2 files changed, 34 insertions(+), 20 deletions(-)
 create mode 100644 tests/functional/qemu_test/archive.py

diff --git a/tests/functional/qemu_test/archive.py b/tests/functional/qemu_test/archive.py
new file mode 100644
index 0000000000..9872f08d23
--- /dev/null
+++ b/tests/functional/qemu_test/archive.py
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Utilities for python-based QEMU tests
+#
+# Copyright 2024 Red Hat, Inc.
+#
+# Authors:
+#  Thomas Huth <thuth@redhat.com>
+
+import os
+import subprocess
+import tarfile
+
+
+def tar_extract(archive, dest_dir, member=None):
+    with tarfile.open(archive) as tf:
+        if hasattr(tarfile, 'data_filter'):
+            tf.extraction_filter = getattr(tarfile, 'data_filter',
+                                           (lambda member, path: member))
+        if member:
+            tf.extract(member=member, path=dest_dir)
+        else:
+            tf.extractall(path=dest_dir)
+
+def cpio_extract(cpio_handle, output_path):
+    cwd = os.getcwd()
+    os.chdir(output_path)
+    subprocess.run(['cpio', '-i'],
+                   input=cpio_handle.read(),
+                   stderr=subprocess.DEVNULL)
+    os.chdir(cwd)
diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index 1bf1c410d5..5ce1c4388e 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -12,8 +12,9 @@
 import lzma
 import os
 import shutil
-import subprocess
-import tarfile
+
+from .archive import tar_extract as archive_extract
+from .archive import cpio_extract
 
 """
 Round up to next power of 2
@@ -36,16 +37,6 @@ def image_pow2ceil_expand(path):
             with open(path, 'ab+') as fd:
                 fd.truncate(size_aligned)
 
-def archive_extract(archive, dest_dir, member=None):
-    with tarfile.open(archive) as tf:
-        if hasattr(tarfile, 'data_filter'):
-            tf.extraction_filter = getattr(tarfile, 'data_filter',
-                                           (lambda member, path: member))
-        if member:
-            tf.extract(member=member, path=dest_dir)
-        else:
-            tf.extractall(path=dest_dir)
-
 def gzip_uncompress(gz_path, output_path):
     if os.path.exists(output_path):
         return
@@ -67,11 +58,3 @@ def lzma_uncompress(xz_path, output_path):
         except:
             os.remove(output_path)
             raise
-
-def cpio_extract(cpio_handle, output_path):
-    cwd = os.getcwd()
-    os.chdir(output_path)
-    subprocess.run(['cpio', '-i'],
-                   input=cpio_handle.read(),
-                   stderr=subprocess.DEVNULL)
-    os.chdir(cwd)
-- 
2.47.1


