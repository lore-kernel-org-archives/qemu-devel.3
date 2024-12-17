Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DC8E77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa17-0006PU-Dv; Tue, 17 Dec 2024 11:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0v-0005tC-CP
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0r-0002Fr-Bh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tlB1PN4HKsqWwJiz+Iw+8YRN7XwwJoyAT4q/5izh0W4=;
 b=CoiBHV6CpZC5KQdwcTyPapJllrbDy96p31syVfgfZCkso0pxaU6bkfT0Cj6Vdy3Zw0kxkK
 k+9bb033JSuC3IUMVQ58MoghVfVMJDNsuvg/tluQ5ppXN9HWgNKpDRVUL7S1adGacRK+/g
 YBrbgDM45/U5fbKhSQkzT5+2Zk6rR+U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-8qf2bvrNNlCEsOpIIJRhjw-1; Tue,
 17 Dec 2024 11:01:29 -0500
X-MC-Unique: 8qf2bvrNNlCEsOpIIJRhjw-1
X-Mimecast-MFC-AGG-ID: 8qf2bvrNNlCEsOpIIJRhjw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C2AD1955F41; Tue, 17 Dec 2024 16:01:28 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F33EA300F9B5; Tue, 17 Dec 2024 16:01:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 30/32] tests/functional: skip tests if assets are not
 available
Date: Tue, 17 Dec 2024 15:59:51 +0000
Message-ID: <20241217155953.3950506-31-berrange@redhat.com>
In-Reply-To: <20241217155953.3950506-1-berrange@redhat.com>
References: <20241217155953.3950506-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

If downloading of assets has been disabled, then skip running a
test if the assets it has registered are not already downloaded.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.46.0


