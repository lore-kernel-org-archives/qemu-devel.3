Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0FBE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrx4-0006Y8-8H; Wed, 18 Dec 2024 06:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrx2-0006XX-Kb
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrx0-0005av-Q8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qs5dlXSPnSiSRt+HDWuEqrKKDqyGCdmAxE6Hu1wPZYI=;
 b=JD+Zz5E8zBbdO5s/rnt0yg/1nNTq7oXvFPD/fQ8SZxClZ21ptWLuiHT4HIiQBPQ8TnxA8T
 BQPfgfu6ml3PgZma4atPMh/D5+cKyjtVGxt7WeK9Rl4s36JgDwIuQu9EtX1SpGxrKpQYtB
 nYkq/L0tflAnpQ8Wn2GmF9yEL8XBiWU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-sClXd2QzPVuu2ohxGjrPrQ-1; Wed,
 18 Dec 2024 06:10:43 -0500
X-MC-Unique: sClXd2QzPVuu2ohxGjrPrQ-1
X-Mimecast-MFC-AGG-ID: sClXd2QzPVuu2ohxGjrPrQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9721519560B8
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 408F319560AD; Wed, 18 Dec 2024 11:10:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 17/38] tests/functional: move uncompress handling into new
 uncompress.py file
Date: Wed, 18 Dec 2024 12:09:37 +0100
Message-ID: <20241218110958.226932-18-thuth@redhat.com>
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

More uncompress related code will be added shortly, so having a
separate file makes more sense.

The utils.py imports the functions from archive.py, so that
existing callers don't need to be modified. This avoids
redundant code churn until later in the series when all
calls will be adapted for other reasons.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-18-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/uncompress.py | 36 ++++++++++++++++++++++++
 tests/functional/qemu_test/utils.py      | 27 ++----------------
 2 files changed, 38 insertions(+), 25 deletions(-)
 create mode 100644 tests/functional/qemu_test/uncompress.py

diff --git a/tests/functional/qemu_test/uncompress.py b/tests/functional/qemu_test/uncompress.py
new file mode 100644
index 0000000000..955170df65
--- /dev/null
+++ b/tests/functional/qemu_test/uncompress.py
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Utilities for python-based QEMU tests
+#
+# Copyright 2024 Red Hat, Inc.
+#
+# Authors:
+#  Thomas Huth <thuth@redhat.com>
+
+import gzip
+import lzma
+import os
+import shutil
+
+
+def gzip_uncompress(gz_path, output_path):
+    if os.path.exists(output_path):
+        return
+    with gzip.open(gz_path, 'rb') as gz_in:
+        try:
+            with open(output_path, 'wb') as raw_out:
+                shutil.copyfileobj(gz_in, raw_out)
+        except:
+            os.remove(output_path)
+            raise
+
+def lzma_uncompress(xz_path, output_path):
+    if os.path.exists(output_path):
+        return
+    with lzma.open(xz_path, 'rb') as lzma_in:
+        try:
+            with open(output_path, 'wb') as raw_out:
+                shutil.copyfileobj(lzma_in, raw_out)
+        except:
+            os.remove(output_path)
+            raise
diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index 5ce1c4388e..6b87af4414 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -8,13 +8,12 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-import gzip
-import lzma
 import os
-import shutil
 
 from .archive import tar_extract as archive_extract
 from .archive import cpio_extract
+from .uncompress import gzip_uncompress
+from .uncompress import lzma_uncompress
 
 """
 Round up to next power of 2
@@ -36,25 +35,3 @@ def image_pow2ceil_expand(path):
         if size != size_aligned:
             with open(path, 'ab+') as fd:
                 fd.truncate(size_aligned)
-
-def gzip_uncompress(gz_path, output_path):
-    if os.path.exists(output_path):
-        return
-    with gzip.open(gz_path, 'rb') as gz_in:
-        try:
-            with open(output_path, 'wb') as raw_out:
-                shutil.copyfileobj(gz_in, raw_out)
-        except:
-            os.remove(output_path)
-            raise
-
-def lzma_uncompress(xz_path, output_path):
-    if os.path.exists(output_path):
-        return
-    with lzma.open(xz_path, 'rb') as lzma_in:
-        try:
-            with open(output_path, 'wb') as raw_out:
-                shutil.copyfileobj(lzma_in, raw_out)
-        except:
-            os.remove(output_path)
-            raise
-- 
2.47.1


