Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50E4F54ADB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54jz-00017e-Cq; Tue, 24 Mar 2026 12:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w54jt-00016R-Hg
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w54jr-0004kc-UW
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774370178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzV8UoDsgxkpKzeQqTX0p9JHx0Z7uhkmA5QCkKohu6c=;
 b=SnT29n8zDBJW1HVpFJ0R3sqyJSBdc+z9X1mpg1Q35+FVZIgqEiDVkn+kaXVNUK0cALblhx
 XAkPXrk2pRWK1aFc/L6hmU6tQr4HKfEVRxWATrIzcdSucJwdv/RkZm6eYT2hkYFIAlMqwt
 /s+CISLuoBrf+ByymQ2F36tKaMrzu9Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-eKFkCV7sOvCypvJZYvZIRw-1; Tue,
 24 Mar 2026 12:36:16 -0400
X-MC-Unique: eKFkCV7sOvCypvJZYvZIRw-1
X-Mimecast-MFC-AGG-ID: eKFkCV7sOvCypvJZYvZIRw_1774370175
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C0B319560AB; Tue, 24 Mar 2026 16:36:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.189])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8DF61800768; Tue, 24 Mar 2026 16:36:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 3/4] tests/functional/qemu_test: Split huge fetch() function
 in asset.py
Date: Tue, 24 Mar 2026 17:35:40 +0100
Message-ID: <20260324163543.55503-4-thuth@redhat.com>
In-Reply-To: <20260324163543.55503-1-thuth@redhat.com>
References: <20260324163543.55503-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The fetch() function has become really huge and pylint complains about
that. Extract the internal retry-three-times-download loop into a
separate function to make it a little bit more readable and to make
pylint happy about this file again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/asset.py | 43 ++++++++++++++++-------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 1cd03c2a9a9..51a434b2b70 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -133,24 +133,7 @@ def _save_time_stamp(self):
         '''
         self.cache_file.with_suffix(".stamp").write_text(f"{int(time.time())}")
 
-    def fetch(self):
-        '''Download the asset from the internet'''
-        if not self.cache_dir.exists():
-            self.cache_dir.mkdir(parents=True, exist_ok=True)
-
-        if self.valid():
-            self.log.debug("Using cached asset %s for %s",
-                           self.cache_file, self.url)
-            self._save_time_stamp()
-            return str(self.cache_file)
-
-        if not self.fetchable():
-            raise AssetError(self,
-                             "Asset cache is invalid and downloads disabled")
-
-        self.log.info("Downloading %s to %s...", self.url, self.cache_file)
-        tmp_cache_file = self.cache_file.with_suffix(".download")
-
+    def _try_to_fetch(self, tmp_cache_file):
         for _retries in range(3):
             try:
                 with tmp_cache_file.open("xb") as dst:
@@ -176,7 +159,7 @@ def fetch(self):
                                "waiting for other thread to finish...",
                                tmp_cache_file)
                 if self._wait_for_other_download(tmp_cache_file):
-                    return str(self.cache_file)
+                    return True
                 self.log.debug("%s seems to be stale, "
                                "deleting and retrying download...",
                                tmp_cache_file)
@@ -213,6 +196,28 @@ def fetch(self):
                 tmp_cache_file.unlink()
                 raise AssetError(self, f"Unable to download: {e}",
                                  transient=True) from e
+        return False
+
+    def fetch(self):
+        '''Download the asset from the internet'''
+        if not self.cache_dir.exists():
+            self.cache_dir.mkdir(parents=True, exist_ok=True)
+
+        if self.valid():
+            self.log.debug("Using cached asset %s for %s",
+                           self.cache_file, self.url)
+            self._save_time_stamp()
+            return str(self.cache_file)
+
+        if not self.fetchable():
+            raise AssetError(self,
+                             "Asset cache is invalid and downloads disabled")
+
+        self.log.info("Downloading %s to %s...", self.url, self.cache_file)
+        tmp_cache_file = self.cache_file.with_suffix(".download")
+
+        if self._try_to_fetch(tmp_cache_file):
+            return str(self.cache_file)
 
         if not os.path.exists(tmp_cache_file):
             raise AssetError(self, "Download retries exceeded", transient=True)
-- 
2.53.0


