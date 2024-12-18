Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2446E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrxP-0007A9-LB; Wed, 18 Dec 2024 06:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxM-000751-DX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxK-0005sp-KH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65MiMhA4jSO6oLI4hjrqt0Dpnla7RPH3avVMrOtkE1s=;
 b=GwOXSInBHHiPCp4fKBzWdjfeUXKrmHx1pq1mKTX4P+54XVvD7H4bHvik0VGM+9i11acPNB
 tePnp1BQx1+YNvkyi1rflvTtzvoj2cbwAwBTIOlHLxuXf3qmGFNsHKvt8oW6dicJCYzhfG
 4UOtIGUFrC1UxkoiP0ASqbRj50RdfXE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-Flz_xKLcOvCZ0d-v0Nzaxg-1; Wed,
 18 Dec 2024 06:11:04 -0500
X-MC-Unique: Flz_xKLcOvCZ0d-v0Nzaxg-1
X-Mimecast-MFC-AGG-ID: Flz_xKLcOvCZ0d-v0Nzaxg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C50C719560B4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:11:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC748195606B; Wed, 18 Dec 2024 11:10:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 24/38] tests/functional: add a generalized uncompress helper
Date: Wed, 18 Dec 2024 12:09:44 +0100
Message-ID: <20241218110958.226932-25-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

There are many types of compression that the tests deal with, and
it makes sense to have a single helper 'uncompress' that can deal
with all.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-25-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/__init__.py   |  1 +
 tests/functional/qemu_test/uncompress.py | 47 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 665c482d13..3bd043e608 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -17,3 +17,4 @@
     skipFlakyTest, skipUntrustedTest, skipBigDataTest, \
     skipIfMissingImports
 from .archive import archive_extract
+from .uncompress import uncompress
diff --git a/tests/functional/qemu_test/uncompress.py b/tests/functional/qemu_test/uncompress.py
index 955170df65..6d02ded066 100644
--- a/tests/functional/qemu_test/uncompress.py
+++ b/tests/functional/qemu_test/uncompress.py
@@ -11,6 +11,9 @@
 import lzma
 import os
 import shutil
+from urllib.parse import urlparse
+
+from .asset import Asset
 
 
 def gzip_uncompress(gz_path, output_path):
@@ -34,3 +37,47 @@ def lzma_uncompress(xz_path, output_path):
         except:
             os.remove(output_path)
             raise
+
+'''
+@params compressed: filename, Asset, or file-like object to uncompress
+@params uncompressed: filename to uncompress into
+@params format: optional compression format (gzip, lzma)
+
+Uncompresses @compressed into @uncompressed
+
+If @format is None, heuristics will be applied to guess the format
+from the filename or Asset URL. @format must be non-None if @uncompressed
+is a file-like object.
+
+Returns the fully qualified path to the uncompessed file
+'''
+def uncompress(compressed, uncompressed, format=None):
+    if format is None:
+        format = guess_uncompress_format(compressed)
+
+    if format == "xz":
+        lzma_uncompress(str(compressed), uncompressed)
+    elif format == "gz":
+        gzip_uncompress(str(compressed), uncompressed)
+    else:
+        raise Exception(f"Unknown compression format {format}")
+
+'''
+@params compressed: filename, Asset, or file-like object to guess
+
+Guess the format of @compressed, raising an exception if
+no format can be determined
+'''
+def guess_uncompress_format(compressed):
+    if type(compressed) == Asset:
+        compressed = urlparse(compressed.url).path
+    elif type(compressed) != str:
+        raise Exception(f"Unable to guess compression cformat for {compressed}")
+
+    (name, ext) = os.path.splitext(compressed)
+    if ext == ".xz":
+        return "xz"
+    elif ext == ".gz":
+        return "gz"
+    else:
+        raise Exception(f"Unknown compression format for {compressed}")
-- 
2.47.1


