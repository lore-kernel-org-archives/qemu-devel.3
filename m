Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5420CE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 17:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQVN-0007Aq-QD; Wed, 11 Dec 2024 12:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQVK-0006vd-Gp
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQVI-0001F3-Ed
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733938083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yniLMEVLs++mgedoC3GIgzPwGodSupdOnSSR8cftK30=;
 b=f3VTaMkA+0ZRB/pem708L9MB7qf/oHOZk4Wqo6PnysCB0B7G5M2zuccjLwUM6UDvP0hApD
 t+LBAXgke7NjfyyAqEEph+TKPNEz7xJ7UdmtCneLgx16JC2v9QOogAP+L0DHgO/dCPjG8E
 CL2Du+PSn66B7ph2mVPHX70+bfitCCs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-y-2QIQQjMHWqgY84pbddDg-1; Wed,
 11 Dec 2024 12:28:02 -0500
X-MC-Unique: y-2QIQQjMHWqgY84pbddDg-1
X-Mimecast-MFC-AGG-ID: y-2QIQQjMHWqgY84pbddDg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C5F91954213; Wed, 11 Dec 2024 17:28:01 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8418C1956048; Wed, 11 Dec 2024 17:27:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 24/31] tests/functional: add a generalized uncompress helper
Date: Wed, 11 Dec 2024 17:26:40 +0000
Message-ID: <20241211172648.2893097-25-berrange@redhat.com>
In-Reply-To: <20241211172648.2893097-1-berrange@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


