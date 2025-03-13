Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF85C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 08:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsdW3-00049G-9m; Thu, 13 Mar 2025 04:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsdW1-00048j-HF
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsdVz-0007it-CF
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741852922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPz43DVoBiqiUTTnpNo1dGZaHs+N1IBXlULeS92nwB4=;
 b=RRHUc5yP6Fb+5wiHA76zvDQ0fZakeVFytVPciNsyyXrX3vQRuE4jQcWosnj7y0+E87ha2r
 G70plRXLTw31Kruviev+Zq6f1v5m2xqBvgTBlguAWlKHreyVVBBa8M68YN5jx7RZRNlQ9D
 pJzHukR6rN8IaL8Clv12u6IEFxZj7bM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-QCdjSC4qOaeLyf9WSA3naA-1; Thu,
 13 Mar 2025 04:01:59 -0400
X-MC-Unique: QCdjSC4qOaeLyf9WSA3naA-1
X-Mimecast-MFC-AGG-ID: QCdjSC4qOaeLyf9WSA3naA_1741852918
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CA44180025F; Thu, 13 Mar 2025 08:01:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E33F1955F2D; Thu, 13 Mar 2025 08:01:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 7/8] tests/functional/asset: Add AssetError exception class
Date: Thu, 13 Mar 2025 09:01:31 +0100
Message-ID: <20250313080132.1467625-8-thuth@redhat.com>
In-Reply-To: <20250313080132.1467625-1-thuth@redhat.com>
References: <20250313080132.1467625-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Assets are uniquely identified by human-readable-ish url, so make an
AssetError exception class that prints url with error message.

A property 'transient' is used to capture whether the client may retry
or try again later, or if it is a serious and likely permanent error.
This is used to retain the existing behaviour of treating HTTP errors
other than 404 as 'transient' and not causing precache step to fail.
Additionally, partial-downloads and stale asset caches that fail to
resolve after the retry limit are now treated as transient and do not
cause precache step to fail.

For background: The NetBSD archive is, at the time of writing, failing
with short transfer. Retrying the fetch at that position (as wget does)
results in a "503 backend unavailable" error. We would like to get that
error code directly, but I have not found a way to do that with urllib,
so treating the short-copy as a transient failure covers that case (and
seems like a reasonable way to handle it in general).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250312130002.945508-4-npiggin@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/asset.py | 43 +++++++++++++++++++----------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 6bbfb9e1cad..704b84d0ea6 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -17,6 +17,14 @@
 from shutil import copyfileobj
 from urllib.error import HTTPError
 
+class AssetError(Exception):
+    def __init__(self, asset, msg, transient=False):
+        self.url = asset.url
+        self.msg = msg
+        self.transient = transient
+
+    def __str__(self):
+        return "%s: %s" % (self.url, self.msg)
 
 # Instances of this class must be declared as class level variables
 # starting with a name "ASSET_". This enables the pre-caching logic
@@ -51,7 +59,7 @@ def _check(self, cache_file):
         elif len(self.hash) == 128:
             hl = hashlib.sha512()
         else:
-            raise Exception("unknown hash type")
+            raise AssetError(self, "unknown hash type")
 
         # Calculate the hash of the file:
         with open(cache_file, 'rb') as file:
@@ -111,7 +119,8 @@ def fetch(self):
             return str(self.cache_file)
 
         if not self.fetchable():
-            raise Exception("Asset cache is invalid and downloads disabled")
+            raise AssetError(self,
+                             "Asset cache is invalid and downloads disabled")
 
         self.log.info("Downloading %s to %s...", self.url, self.cache_file)
         tmp_cache_file = self.cache_file.with_suffix(".download")
@@ -147,13 +156,23 @@ def fetch(self):
                                tmp_cache_file)
                 tmp_cache_file.unlink()
                 continue
+            except HTTPError as e:
+                tmp_cache_file.unlink()
+                self.log.error("Unable to download %s: HTTP error %d",
+                               self.url, e.code)
+                # Treat 404 as fatal, since it is highly likely to
+                # indicate a broken test rather than a transient
+                # server or networking problem
+                if e.code == 404:
+                    raise AssetError(self, "Unable to download: "
+                                     "HTTP error %d" % e.code)
+                continue
             except Exception as e:
-                self.log.error("Unable to download %s: %s", self.url, e)
                 tmp_cache_file.unlink()
-                raise
+                raise AssetError(self, "Unable to download: " % e)
 
         if not os.path.exists(tmp_cache_file):
-            raise Exception("Retries exceeded downloading %s", self.url)
+            raise AssetError(self, "Download retries exceeded", transient=True)
 
         try:
             # Set these just for informational purposes
@@ -167,8 +186,7 @@ def fetch(self):
 
         if not self._check(tmp_cache_file):
             tmp_cache_file.unlink()
-            raise Exception("Hash of %s does not match %s" %
-                            (self.url, self.hash))
+            raise AssetError(self, "Hash does not match %s" % self.hash)
         tmp_cache_file.replace(self.cache_file)
         # Remove write perms to stop tests accidentally modifying them
         os.chmod(self.cache_file, stat.S_IRUSR | stat.S_IRGRP)
@@ -190,15 +208,10 @@ def precache_test(test):
                 log.info("Attempting to cache '%s'" % asset)
                 try:
                     asset.fetch()
-                except HTTPError as e:
-                    # Treat 404 as fatal, since it is highly likely to
-                    # indicate a broken test rather than a transient
-                    # server or networking problem
-                    if e.code == 404:
+                except AssetError as e:
+                    if not e.transient:
                         raise
-
-                    log.debug(f"HTTP error {e.code} from {asset.url} " +
-                              "skipping asset precache")
+                    log.error("%s: skipping asset precache" % e)
 
         log.removeHandler(handler)
 
-- 
2.48.1


