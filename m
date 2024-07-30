Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2847CC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqH7-0008M3-5q; Tue, 30 Jul 2024 13:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqH3-000893-SW
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqH2-0002PW-3k
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8pbB6MRSFMctHq+rEUPH8W89d2P/0X7TFkH8tms4zs=;
 b=Cako3+7v+ATQGAEy36txoQ1qMG4Q9h71wuqMLSEd94luskIZIelHUvhUwFE3xO2tmIhode
 kBIux1vTN7LNtIInvwS97YzCNBgTJPP2rae6rYCtlA8X6LIc9otvZMy4OfjaL6OZu/ZCOk
 LaCJA0hL9mXH1g/evrkcKwl9d7ICcZQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-Zf60K98LMRKj3kz7dEkc-A-1; Tue,
 30 Jul 2024 13:04:26 -0400
X-MC-Unique: Zf60K98LMRKj3kz7dEkc-A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A33A71955D4B; Tue, 30 Jul 2024 17:04:25 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBEFF3000194; Tue, 30 Jul 2024 17:04:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 08/24] tests/functional: add a module for handling asset
 download & caching
Date: Tue, 30 Jul 2024 18:03:28 +0100
Message-ID: <20240730170347.4103919-9-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The 'Asset' class is a simple module that declares a downloadable
asset that can be cached locally. Downloads are stored in the user's
home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/__init__.py |  1 +
 tests/functional/qemu_test/asset.py    | 96 ++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
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
index 0000000000..6432da2e0b
--- /dev/null
+++ b/tests/functional/qemu_test/asset.py
@@ -0,0 +1,96 @@
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
+    def __init__(self, url, hash):
+        self.url = url
+        self.hash = hash
+        self.cache_dir = Path(Path("~").expanduser(),
+                              ".cache", "qemu", "download")
+        self.cache_file = Path(self.cache_dir,
+                               hashlib.sha256(url.encode("utf-8")).hexdigest())
+        self.log = logging.getLogger('qemu-test')
+
+    def __repr__(self):
+        return "Asset: url=%s hash=%s cache=%s" % (
+            self.url, self.hash, self.cache_file)
+
+    def _check(self, cache_file):
+        if self.hash is None:
+            return True
+        if len(self.hash) == 40:
+            sum_prog = 'sha1sum'
+        elif len(self.hash) == 64:
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
+            self.log.info("Unable to set xattr on %s: %s", tmp_cache_file, e)
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
2.45.2


