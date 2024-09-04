Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC84FCA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnQv-0002JA-9p; Wed, 04 Sep 2024 06:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQt-0002Co-Er
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQr-0000Gw-RR
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UpU2+/M58mm5T33rWo0QnRPqyX8ullh5Ml7wF7nd7NI=;
 b=N9U9dYVbTYwuS6caND3bLwglSBMDz2JPO9Oex+2ACA3LSsnXLS7Et6JrB6RnjlohaO1Ddq
 b9rXWwlBOVzv5DWNa+NKHYplmnc4/TUYW3HMCkPHZw6Jg1rEWCQ1XYONp4NFlbjPZuwNnA
 p59iCt60nT/Y6gSLREoXlfKT88Vy0Es=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-CaEDuh2tMiqUQdM4w2gfog-1; Wed,
 04 Sep 2024 06:40:11 -0400
X-MC-Unique: CaEDuh2tMiqUQdM4w2gfog-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B20BD19560A5; Wed,  4 Sep 2024 10:40:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F66B195605A; Wed,  4 Sep 2024 10:40:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/42] tests/functional: add a module for handling asset
 download & caching
Date: Wed,  4 Sep 2024 12:38:49 +0200
Message-ID: <20240904103923.451847-15-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Daniel P. Berrangé <berrange@redhat.com>

The 'Asset' class is a simple module that declares a downloadable
asset that can be cached locally. Downloads are stored in the user's
home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.

[thuth: Drop sha1 support, use hash on file content for naming instead of URL,
        add the possibility to specify the cache dir via environment variable]

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240830133841.142644-15-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/__init__.py |  1 +
 tests/functional/qemu_test/asset.py    | 97 ++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 tests/functional/qemu_test/asset.py

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 2f1e0bc70d..db05c8f412 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -6,6 +6,7 @@
 # later.  See the COPYING file in the top-level directory.
 
 
+from .asset import Asset
 from .config import BUILD_DIR
 from .cmd import has_cmd, has_cmds, run_cmd, is_readable_executable_file, \
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
new file mode 100644
index 0000000000..c0e675d847
--- /dev/null
+++ b/tests/functional/qemu_test/asset.py
@@ -0,0 +1,97 @@
+# Test utilities for fetching & caching assets
+#
+# Copyright 2024 Red Hat, Inc.
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import hashlib
+import logging
+import os
+import subprocess
+import urllib.request
+from pathlib import Path
+from shutil import copyfileobj
+
+
+# Instances of this class must be declared as class level variables
+# starting with a name "ASSET_". This enables the pre-caching logic
+# to easily find all referenced assets and download them prior to
+# execution of the tests.
+class Asset:
+
+    def __init__(self, url, hashsum):
+        self.url = url
+        self.hash = hashsum
+        cache_dir_env = os.getenv('QEMU_TEST_CACHE_DIR')
+        if cache_dir_env:
+            self.cache_dir = Path(cache_dir_env, "download")
+        else:
+            self.cache_dir = Path(Path("~").expanduser(),
+                                  ".cache", "qemu", "download")
+        self.cache_file = Path(self.cache_dir, hashsum)
+        self.log = logging.getLogger('qemu-test')
+
+    def __repr__(self):
+        return "Asset: url=%s hash=%s cache=%s" % (
+            self.url, self.hash, self.cache_file)
+
+    def _check(self, cache_file):
+        if self.hash is None:
+            return True
+        if len(self.hash) == 64:
+            sum_prog = 'sha256sum'
+        elif len(self.hash) == 128:
+            sum_prog = 'sha512sum'
+        else:
+            raise Exception("unknown hash type")
+
+        checksum = subprocess.check_output(
+            [sum_prog, str(cache_file)]).split()[0]
+        return self.hash == checksum.decode("utf-8")
+
+    def valid(self):
+        return self.cache_file.exists() and self._check(self.cache_file)
+
+    def fetch(self):
+        if not self.cache_dir.exists():
+            self.cache_dir.mkdir(parents=True, exist_ok=True)
+
+        if self.valid():
+            self.log.debug("Using cached asset %s for %s",
+                           self.cache_file, self.url)
+            return str(self.cache_file)
+
+        self.log.info("Downloading %s to %s...", self.url, self.cache_file)
+        tmp_cache_file = self.cache_file.with_suffix(".download")
+
+        try:
+            resp = urllib.request.urlopen(self.url)
+        except Exception as e:
+            self.log.error("Unable to download %s: %s", self.url, e)
+            raise
+
+        try:
+            with tmp_cache_file.open("wb+") as dst:
+                copyfileobj(resp, dst)
+        except:
+            tmp_cache_file.unlink()
+            raise
+        try:
+            # Set these just for informational purposes
+            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
+                        self.url.encode('utf8'))
+            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
+                        self.hash.encode('utf8'))
+        except Exception as e:
+            self.log.debug("Unable to set xattr on %s: %s", tmp_cache_file, e)
+            pass
+
+        if not self._check(tmp_cache_file):
+            tmp_cache_file.unlink()
+            raise Exception("Hash of %s does not match %s" %
+                            (self.url, self.hash))
+        tmp_cache_file.replace(self.cache_file)
+
+        self.log.info("Cached %s at %s" % (self.url, self.cache_file))
+        return str(self.cache_file)
-- 
2.46.0


