Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99714F54ADB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54jw-00016i-Of; Tue, 24 Mar 2026 12:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w54jq-00015m-Cp
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w54jl-0004ja-E5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774370172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+yoAx/LMss+x6qgLSY59oej7Px3L1jy1uYYD5EKmfaA=;
 b=hEqBjOKEJdoSGIaIY/BVkMXwA2pHXVkrKWZjnwbXctULnsAVxe982wO3gbIIgGvTzHzVNM
 c+RZWgSGnN9OneLY8JIwDOuiFeCCVyC+CoK3Hc1S1UdhTf4GGZcnSjY825A2+4C/KjKSto
 vv7SD7nMr1WjHkrW3A0zneEpQRNXxjA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-R9aFR6ObOgeVkL1iFh-7eQ-1; Tue,
 24 Mar 2026 12:36:11 -0400
X-MC-Unique: R9aFR6ObOgeVkL1iFh-7eQ-1
X-Mimecast-MFC-AGG-ID: R9aFR6ObOgeVkL1iFh-7eQ_1774370170
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20C3F1800365; Tue, 24 Mar 2026 16:36:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.189])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8F3D1800107; Tue, 24 Mar 2026 16:36:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/4] tests/functional/qemu_test: Silence (most) warnings from
 pylint in asset.py
Date: Tue, 24 Mar 2026 17:35:39 +0100
Message-ID: <20260324163543.55503-3-thuth@redhat.com>
In-Reply-To: <20260324163543.55503-1-thuth@redhat.com>
References: <20260324163543.55503-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Pylint currently complains:

 asset.py:1:0: C0114: Missing module docstring (missing-module-docstring)
 asset.py:21:0: C0115: Missing class docstring (missing-class-docstring)
 asset.py:28:15: C0209: Formatting a regular string which could be an f-string (consider-using-f-string)
 asset.py:34:0: C0115: Missing class docstring (missing-class-docstring)
 asset.py:49:15: C0209: Formatting a regular string which could be an f-string (consider-using-f-string)
 asset.py:73:4: C0116: Missing function or method docstring (missing-function-docstring)
 asset.py:80:4: C0116: Missing function or method docstring (missing-function-docstring)
 asset.py:83:4: C0116: Missing function or method docstring (missing-function-docstring)
 asset.py:125:4: C0116: Missing function or method docstring (missing-function-docstring)
 asset.py:181:43: C0209: Formatting a regular string which could be an f-string (consider-using-f-string)
 asset.py:190:39: C0209: Formatting a regular string which could be an f-string (consider-using-f-string)
 asset.py:201:39: C0209: Formatting a regular string which could be an f-string (consider-using-f-string)
 asset.py:213:15: W0718: Catching too general exception Exception (broad-exception-caught)
 asset.py:218:35: C0209: Formatting a regular string which could be an f-string (consider-using-f-string)
 asset.py:125:4: R0912: Too many branches (16/12) (too-many-branches)
 asset.py:125:4: R0915: Too many statements (64/50) (too-many-statements)
 asset.py:228:4: C0116: Missing function or method docstring (missing-function-docstring)
 asset.py:249:4: C0116: Missing function or method docstring (missing-function-docstring)
 asset.py:257:4: C0116: Missing function or method docstring (missing-function-docstring)

Fix all the warnings except for the R0912 and R0915 which will be tackled
in a later commit.
And while we're at it, also add a proper SPDX license identifier.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/asset.py | 53 +++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 45a2e01e2e6..1cd03c2a9a9 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -1,9 +1,12 @@
-# Test utilities for fetching & caching assets
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright 2024 Red Hat, Inc.
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
+'''
+Test utilities for fetching & caching assets
+'''
 
 import hashlib
 import logging
@@ -18,21 +21,27 @@
 from shutil import copyfileobj
 from urllib.error import HTTPError, URLError
 
+
 class AssetError(Exception):
+    '''This exception will be raised if an asset is not usable'''
     def __init__(self, asset, msg, transient=False):
         self.url = asset.url
         self.msg = msg
         self.transient = transient
 
     def __str__(self):
-        return "%s: %s" % (self.url, self.msg)
+        return f"{self.url}: {self.msg}"
 
-# Instances of this class must be declared as class level variables
-# starting with a name "ASSET_". This enables the pre-caching logic
-# to easily find all referenced assets and download them prior to
-# execution of the tests.
-class Asset:
 
+class Asset:
+    '''
+    This class is used to represent an asset that gets downloaded from
+    the internet and will be stored in the local asset cache.
+    Instances of this class must be declared as class level variables
+    starting with a name "ASSET_". This enables the pre-caching logic
+    to easily find all referenced assets and download them prior to
+    execution of the tests.
+    '''
     def __init__(self, url, hashsum):
         self.url = url
         self.hash = hashsum
@@ -46,8 +55,7 @@ def __init__(self, url, hashsum):
         self.log = logging.getLogger('qemu-test')
 
     def __repr__(self):
-        return "Asset: url=%s hash=%s cache=%s" % (
-            self.url, self.hash, self.cache_file)
+        return f"Asset: url={self.url} hash={self.hash} cache={self.cache_file}"
 
     def __str__(self):
         return str(self.cache_file)
@@ -71,6 +79,7 @@ def _check(self, cache_file):
         return self.hash == hl.hexdigest()
 
     def valid(self):
+        '''Check whether the file exists in the cache and has the right hash'''
         if os.getenv("QEMU_TEST_REFRESH_CACHE", None) is not None:
             self.log.info("Force refresh of asset %s", self.url)
             return False
@@ -78,9 +87,11 @@ def valid(self):
         return self.cache_file.exists() and self._check(self.cache_file)
 
     def fetchable(self):
+        '''Check whether we are allowed to download assets from the internet'''
         return not os.environ.get("QEMU_TEST_NO_DOWNLOAD", False)
 
     def available(self):
+        '''Check whether the asset is either in the cache or fetchable'''
         return self.valid() or self.fetchable()
 
     def _wait_for_other_download(self, tmp_cache_file):
@@ -123,6 +134,7 @@ def _save_time_stamp(self):
         self.cache_file.with_suffix(".stamp").write_text(f"{int(time.time())}")
 
     def fetch(self):
+        '''Download the asset from the internet'''
         if not self.cache_dir.exists():
             self.cache_dir.mkdir(parents=True, exist_ok=True)
 
@@ -179,7 +191,7 @@ def fetch(self):
                 # server or networking problem
                 if e.code == 404:
                     raise AssetError(self, "Unable to download: "
-                                     "HTTP error %d" % e.code) from e
+                                     f"HTTP error {e.code}") from e
                 continue
             except URLError as e:
                 # This is typically a network/service level error
@@ -187,8 +199,9 @@ def fetch(self):
                 tmp_cache_file.unlink()
                 self.log.error("Unable to download %s: URL error %s",
                                self.url, e.reason)
-                raise AssetError(self, "Unable to download: URL error %s" %
-                                 e.reason, transient=True) from e
+                raise AssetError(self,
+                                 f"Unable to download: URL error{e.reason}",
+                                 transient=True) from e
             except ConnectionError as e:
                 # A socket connection failure, such as dropped conn
                 # or refused conn
@@ -198,7 +211,7 @@ def fetch(self):
                 continue
             except Exception as e:
                 tmp_cache_file.unlink()
-                raise AssetError(self, "Unable to download: %s" % e,
+                raise AssetError(self, f"Unable to download: {e}",
                                  transient=True) from e
 
         if not os.path.exists(tmp_cache_file):
@@ -210,12 +223,12 @@ def fetch(self):
                         self.url.encode('utf8'))
             os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
                         self.hash.encode('utf8'))
-        except Exception as e:
+        except OSError as e:
             self.log.debug("Unable to set xattr on %s: %s", tmp_cache_file, e)
 
         if not self._check(tmp_cache_file):
             tmp_cache_file.unlink()
-            raise AssetError(self, "Hash does not match %s" % self.hash)
+            raise AssetError(self, f"Hash does not match {self.hash}")
         tmp_cache_file.replace(self.cache_file)
         self._save_time_stamp()
         # Remove write perms to stop tests accidentally modifying them
@@ -226,6 +239,10 @@ def fetch(self):
 
     @staticmethod
     def precache_test(test):
+        '''
+        Look for variables starting with "ASSET_" and try to fetch the asset
+        that is specified there.
+        '''
         log = logging.getLogger('qemu-test')
         log.setLevel(logging.DEBUG)
         handler = logging.StreamHandler(sys.stdout)
@@ -247,6 +264,9 @@ def precache_test(test):
 
     @staticmethod
     def precache_suite(suite):
+        '''
+        Iterate through all tests/suites in a suite and precache their assets
+        '''
         for test in suite:
             if isinstance(test, unittest.TestSuite):
                 Asset.precache_suite(test)
@@ -255,6 +275,9 @@ def precache_suite(suite):
 
     @staticmethod
     def precache_suites(path, cache_tstamp):
+        '''
+        Get the available test suite and precache their assets
+        '''
         loader = unittest.loader.defaultTestLoader
         tests = loader.loadTestsFromNames([path], None)
 
-- 
2.53.0


