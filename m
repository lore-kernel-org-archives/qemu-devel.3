Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79656CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsGs-0003lp-LK; Mon, 03 Nov 2025 05:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsGq-0003lS-WB
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsGk-00047q-J0
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TA3kpc+YHMk0qkvoJlY74Sz5ck9Tnfwg9efSklIJdY=;
 b=FtfRZ9CVTiUfmVhKPYEivOoJ6Jvtjk23ziztkT+KiqhCxOVmTxHU+loFmzZf5wZjRf3NPl
 VWKnGM5EQzJKib7UTP0SGecTGYq/IQaZs597oQxMzYXTpjP5G4HrTXmTSbBZxN4kob2siY
 KA47bGoppxZqYq/03E9/ujSewAriQkc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-HPWkvdp0OjSYB0k_fXocgw-1; Mon,
 03 Nov 2025 05:58:32 -0500
X-MC-Unique: HPWkvdp0OjSYB0k_fXocgw-1
X-Mimecast-MFC-AGG-ID: HPWkvdp0OjSYB0k_fXocgw_1762167511
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C7F01800D87; Mon,  3 Nov 2025 10:58:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E864C30001A1; Mon,  3 Nov 2025 10:58:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/22] tests/functional: Fix problems in asset.py reported by
 pylint
Date: Mon,  3 Nov 2025 11:57:59 +0100
Message-ID: <20251103105824.322039-3-thuth@redhat.com>
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
References: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The "raise" without an Exception was a real problem, the other
spots are rather cosmetics.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251015095454.1575318-2-thuth@redhat.com>
---
 tests/functional/qemu_test/asset.py | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index ab3a7bb591d..bae40765ce4 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -112,7 +112,7 @@ def _wait_for_other_download(self, tmp_cache_file):
                 return False
 
         self.log.debug("Time out while waiting for %s!", tmp_cache_file)
-        raise
+        raise TimeoutError(f"Time out while waiting for {tmp_cache_file}")
 
     def _save_time_stamp(self):
         '''
@@ -141,7 +141,7 @@ def fetch(self):
         self.log.info("Downloading %s to %s...", self.url, self.cache_file)
         tmp_cache_file = self.cache_file.with_suffix(".download")
 
-        for retries in range(3):
+        for _retries in range(3):
             try:
                 with tmp_cache_file.open("xb") as dst:
                     with urllib.request.urlopen(self.url) as resp:
@@ -181,7 +181,7 @@ def fetch(self):
                 # server or networking problem
                 if e.code == 404:
                     raise AssetError(self, "Unable to download: "
-                                     "HTTP error %d" % e.code)
+                                     "HTTP error %d" % e.code) from e
                 continue
             except URLError as e:
                 # This is typically a network/service level error
@@ -190,7 +190,7 @@ def fetch(self):
                 self.log.error("Unable to download %s: URL error %s",
                                self.url, e.reason)
                 raise AssetError(self, "Unable to download: URL error %s" %
-                                 e.reason, transient=True)
+                                 e.reason, transient=True) from e
             except ConnectionError as e:
                 # A socket connection failure, such as dropped conn
                 # or refused conn
@@ -201,7 +201,7 @@ def fetch(self):
             except Exception as e:
                 tmp_cache_file.unlink()
                 raise AssetError(self, "Unable to download: %s" % e,
-                                 transient=True)
+                                 transient=True) from e
 
         if not os.path.exists(tmp_cache_file):
             raise AssetError(self, "Download retries exceeded", transient=True)
@@ -214,7 +214,6 @@ def fetch(self):
                         self.hash.encode('utf8'))
         except Exception as e:
             self.log.debug("Unable to set xattr on %s: %s", tmp_cache_file, e)
-            pass
 
         if not self._check(tmp_cache_file):
             tmp_cache_file.unlink()
@@ -224,9 +223,10 @@ def fetch(self):
         # Remove write perms to stop tests accidentally modifying them
         os.chmod(self.cache_file, stat.S_IRUSR | stat.S_IRGRP)
 
-        self.log.info("Cached %s at %s" % (self.url, self.cache_file))
+        self.log.info("Cached %s at %s", self.url, self.cache_file)
         return str(self.cache_file)
 
+    @staticmethod
     def precache_test(test):
         log = logging.getLogger('qemu-test')
         log.setLevel(logging.DEBUG)
@@ -237,16 +237,17 @@ def precache_test(test):
         handler.setFormatter(formatter)
         log.addHandler(handler)
         for name, asset in vars(test.__class__).items():
-            if name.startswith("ASSET_") and type(asset) == Asset:
+            if name.startswith("ASSET_") and isinstance(asset, Asset):
                 try:
                     asset.fetch()
                 except AssetError as e:
                     if not e.transient:
                         raise
-                    log.error("%s: skipping asset precache" % e)
+                    log.error("%s: skipping asset precache", e)
 
         log.removeHandler(handler)
 
+    @staticmethod
     def precache_suite(suite):
         for test in suite:
             if isinstance(test, unittest.TestSuite):
@@ -254,9 +255,10 @@ def precache_suite(suite):
             elif isinstance(test, unittest.TestCase):
                 Asset.precache_test(test)
 
-    def precache_suites(path, cacheTstamp):
+    @staticmethod
+    def precache_suites(path, cache_tstamp):
         loader = unittest.loader.defaultTestLoader
         tests = loader.loadTestsFromNames([path], None)
 
-        with open(cacheTstamp, "w") as fh:
+        with open(cache_tstamp, "w", encoding='utf-8'):
             Asset.precache_suite(tests)
-- 
2.51.0


