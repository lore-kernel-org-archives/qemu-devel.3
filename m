Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81125CD4849
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnRO-00049T-9n; Wed, 04 Sep 2024 06:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRJ-0003Ug-MC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRF-0000JL-0D
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yw4Ud8y3FlFb4oKs5mexih/+lbaE0vzZAzVIm7SPrQ0=;
 b=TRI8S2yu2WDqWCkbtKWi3DOOO//fxnk3X33H2WWjxJRYgaZk9pFjI6uGHzFoqOWuDcSJtu
 rwyifPdklEBgRHDD73lhXZ4GKFVz8a5n81qmg2/MnAYuutWOv8giCTuZxWyN94mgSzaUaa
 sp0UqZippqa7V0jP3QRTH26fqrUytt4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-U5FsSMnXNimiVqWTq7D9Mw-1; Wed,
 04 Sep 2024 06:40:16 -0400
X-MC-Unique: U5FsSMnXNimiVqWTq7D9Mw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5649E1955F56; Wed,  4 Sep 2024 10:40:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62EEB1955F44; Wed,  4 Sep 2024 10:40:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 16/42] tests/functional: Allow asset downloading with
 concurrent threads
Date: Wed,  4 Sep 2024 12:38:51 +0200
Message-ID: <20240904103923.451847-17-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
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

When running "make -j$(nproc) check-functional", tests that use the
same asset might be running in parallel. Improve the downloading to
detect this situation and wait for the other thread to finish the
download.

Message-ID: <20240830133841.142644-17-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/asset.py | 62 ++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index b329ab7dbe..d3be2aff82 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -12,6 +12,7 @@
 import sys
 import unittest
 import urllib.request
+from time import sleep
 from pathlib import Path
 from shutil import copyfileobj
 
@@ -55,6 +56,35 @@ def _check(self, cache_file):
     def valid(self):
         return self.cache_file.exists() and self._check(self.cache_file)
 
+    def _wait_for_other_download(self, tmp_cache_file):
+        # Another thread already seems to download the asset, so wait until
+        # it is done, while also checking the size to see whether it is stuck
+        try:
+            current_size = tmp_cache_file.stat().st_size
+            new_size = current_size
+        except:
+            if os.path.exists(self.cache_file):
+                return True
+            raise
+        waittime = lastchange = 600
+        while waittime > 0:
+            sleep(1)
+            waittime -= 1
+            try:
+                new_size = tmp_cache_file.stat().st_size
+            except:
+                if os.path.exists(self.cache_file):
+                    return True
+                raise
+            if new_size != current_size:
+                lastchange = waittime
+                current_size = new_size
+            elif lastchange - waittime > 90:
+                return False
+
+        self.log.debug("Time out while waiting for %s!", tmp_cache_file)
+        raise
+
     def fetch(self):
         if not self.cache_dir.exists():
             self.cache_dir.mkdir(parents=True, exist_ok=True)
@@ -70,18 +100,28 @@ def fetch(self):
         self.log.info("Downloading %s to %s...", self.url, self.cache_file)
         tmp_cache_file = self.cache_file.with_suffix(".download")
 
-        try:
-            resp = urllib.request.urlopen(self.url)
-        except Exception as e:
-            self.log.error("Unable to download %s: %s", self.url, e)
-            raise
+        for retries in range(3):
+            try:
+                with tmp_cache_file.open("xb") as dst:
+                    with urllib.request.urlopen(self.url) as resp:
+                        copyfileobj(resp, dst)
+                break
+            except FileExistsError:
+                self.log.debug("%s already exists, "
+                               "waiting for other thread to finish...",
+                               tmp_cache_file)
+                if self._wait_for_other_download(tmp_cache_file):
+                    return str(self.cache_file)
+                self.log.debug("%s seems to be stale, "
+                               "deleting and retrying download...",
+                               tmp_cache_file)
+                tmp_cache_file.unlink()
+                continue
+            except Exception as e:
+                self.log.error("Unable to download %s: %s", self.url, e)
+                tmp_cache_file.unlink()
+                raise
 
-        try:
-            with tmp_cache_file.open("wb+") as dst:
-                copyfileobj(resp, dst)
-        except:
-            tmp_cache_file.unlink()
-            raise
         try:
             # Set these just for informational purposes
             os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
-- 
2.46.0


