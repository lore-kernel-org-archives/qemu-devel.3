Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84633E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa0b-0004qj-3N; Tue, 17 Dec 2024 11:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0H-0004R3-Pq
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0D-0002AR-Ec
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqMTiiD0E5HRxNd/+TqSUc1lmXPbcBRNJkAvf7IW0KA=;
 b=DbuK7A56tjP/2OTFMw/fdgzf5zdmbv09xCjC3egCPS1A28EyBskSTXUR1pAs90U/qYgXp1
 0fwHPDZ5HhScHPs8XUXXxBXpjanDiFAQ6x2fuV/9Gjf0Fa/BwdIZux5bPu4gGPphoLtquH
 EBXwPHI3kkEMaXVd2z/mwNDsj689eVc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-HGdXTIe9OMqHmTScjQfeRg-1; Tue,
 17 Dec 2024 11:00:49 -0500
X-MC-Unique: HGdXTIe9OMqHmTScjQfeRg-1
X-Mimecast-MFC-AGG-ID: HGdXTIe9OMqHmTScjQfeRg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 399FE19560A3; Tue, 17 Dec 2024 16:00:48 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB45C300F9B5; Tue, 17 Dec 2024 16:00:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 16/32] tests/functional: move archive handling into new
 archive.py file
Date: Tue, 17 Dec 2024 15:59:37 +0000
Message-ID: <20241217155953.3950506-17-berrange@redhat.com>
In-Reply-To: <20241217155953.3950506-1-berrange@redhat.com>
References: <20241217155953.3950506-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

More archive related code will be added shortly, so having a
separate file makes more sense.

The utils.py imports the functions from archive.py, so that
existing callers don't need to be modified. This avoids
redundant code churn until later in the series when all
calls will be adapted for other reasons.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.46.0


