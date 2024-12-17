Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08976E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa0i-0005LG-Tn; Tue, 17 Dec 2024 11:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0b-0004wm-VV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0a-0002D8-CT
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shEyQbtzxEHCSLnIh2H3SKPNkLOycBJ1B5KXtp/FWSI=;
 b=d91F+VQHO/0R6H9ilPZjoRvz1cfAwdgf6nU9dUbPCw8WIDCUal8yqPV9wakHjS+JZ+wbDc
 IjAn3CfsU8jaAZvtJhCcSGHvjSjZi5zHIBIlQiIchLO/7NoZtMg2dCZLCwIzYSOTsza7dC
 DJdlMr90385pW0Kcl7LSKldCb9SkCPM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-OoHMDI_DNbqltfzrtdnWsg-1; Tue,
 17 Dec 2024 11:01:11 -0500
X-MC-Unique: OoHMDI_DNbqltfzrtdnWsg-1
X-Mimecast-MFC-AGG-ID: OoHMDI_DNbqltfzrtdnWsg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0BB819560A3; Tue, 17 Dec 2024 16:01:10 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44618300F9B5; Tue, 17 Dec 2024 16:01:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 24/32] tests/functional: add a generalized uncompress helper
Date: Tue, 17 Dec 2024 15:59:45 +0000
Message-ID: <20241217155953.3950506-25-berrange@redhat.com>
In-Reply-To: <20241217155953.3950506-1-berrange@redhat.com>
References: <20241217155953.3950506-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

There are many types of compression that the tests deal with, and
it makes sense to have a single helper 'uncompress' that can deal
with all.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.46.0


