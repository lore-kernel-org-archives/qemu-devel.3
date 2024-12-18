Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D9FE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrxf-00081E-Ct; Wed, 18 Dec 2024 06:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxc-0007kv-3R
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxZ-0005uq-Me
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3lAGJZgh87TWGw/P0Dg2h/VAfADNIRws+tUUgIHn+s=;
 b=MFnBiVnr4JeiigXHd1wk1pBDcCRkLUOzvPzpp3ABdfpTiYhpASpsN7R97eF5QfzN+ydWna
 dsYERp4+MuM5lU+KeVoSU1XnR4YvEmYQd0rOs6PF8Fx6oXV/rCUJZ8wfEokXZaq/n0AF3w
 /TIdAAM/fqiC9XHcfb5bVBEFP9bFCUo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-u0pa13KHNVKYNmQ0I4s6_g-1; Wed,
 18 Dec 2024 06:11:19 -0500
X-MC-Unique: u0pa13KHNVKYNmQ0I4s6_g-1
X-Mimecast-MFC-AGG-ID: u0pa13KHNVKYNmQ0I4s6_g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2F3819560BD
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:11:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9114E19560AD; Wed, 18 Dec 2024 11:11:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 30/38] tests/functional: skip tests if assets are not available
Date: Wed, 18 Dec 2024 12:09:50 +0100
Message-ID: <20241218110958.226932-31-thuth@redhat.com>
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

If downloading of assets has been disabled, then skip running a
test if the assets it has registered are not already downloaded.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-31-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/asset.py    |  8 +++++++-
 tests/functional/qemu_test/testcase.py | 11 +++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index c5d3e73c4b..39832b2587 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -65,6 +65,12 @@ def _check(self, cache_file):
     def valid(self):
         return self.cache_file.exists() and self._check(self.cache_file)
 
+    def fetchable(self):
+        return not os.environ.get("QEMU_TEST_NO_DOWNLOAD", False)
+
+    def available(self):
+        return self.valid() or self.fetchable()
+
     def _wait_for_other_download(self, tmp_cache_file):
         # Another thread already seems to download the asset, so wait until
         # it is done, while also checking the size to see whether it is stuck
@@ -103,7 +109,7 @@ def fetch(self):
                            self.cache_file, self.url)
             return str(self.cache_file)
 
-        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
+        if not self.fetchable():
             raise Exception("Asset cache is invalid and downloads disabled")
 
         self.log.info("Downloading %s to %s...", self.url, self.cache_file)
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index aa6c9c0d64..869f3949fe 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -184,6 +184,14 @@ def scratch_file(self, *args):
     def log_file(self, *args):
         return str(Path(self.outputdir, *args))
 
+    def assets_available(self):
+        for name, asset in vars(self.__class__).items():
+            if name.startswith("ASSET_") and type(asset) == Asset:
+                if not asset.available():
+                    self.log.debug(f"Asset {asset.url} not available")
+                    return False
+        return True
+
     def setUp(self, bin_prefix):
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
         self.arch = self.qemu_bin.split('-')[-1]
@@ -209,6 +217,9 @@ def setUp(self, bin_prefix):
         self.machinelog.setLevel(logging.DEBUG)
         self.machinelog.addHandler(self._log_fh)
 
+        if not self.assets_available():
+            self.skipTest('One or more assets is not available')
+
     def tearDown(self):
         if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
             shutil.rmtree(self.workdir)
-- 
2.47.1


