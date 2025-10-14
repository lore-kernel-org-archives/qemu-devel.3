Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F8DCCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aUV-0006ij-07; Tue, 14 Oct 2025 04:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8aUP-0006hw-Os
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8aUN-00056S-Uk
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760430874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w2V4xpcELNsmUXcdwA/hPiXZ1qayVpp4dZQTRqmN3c0=;
 b=YyZaWZI32Wc1qQ1hIhY2rn4WsSKknruMtGOAdKCtdov0LAOh5qJHMnAPokDtc9A0a8JIIQ
 25FYOjZE/IkK+rrz8gxiB9a5unb+meSZCNX+Ny9hfTPHEBzS9ApkGQu5R9yogasWoLkE6G
 JrkoCbg2fJTjzghyQg67E/9vvkTKPPk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-5PkEekZ4Ph2tnX815gSWUg-1; Tue,
 14 Oct 2025 04:34:31 -0400
X-MC-Unique: 5PkEekZ4Ph2tnX815gSWUg-1
X-Mimecast-MFC-AGG-ID: 5PkEekZ4Ph2tnX815gSWUg_1760430870
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38EE31800366; Tue, 14 Oct 2025 08:34:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.162])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 505E219560A2; Tue, 14 Oct 2025 08:34:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/2] tests/functional: Set current time stamp of assets
 when using them
Date: Tue, 14 Oct 2025 10:34:23 +0200
Message-ID: <20251014083424.103202-2-thuth@redhat.com>
In-Reply-To: <20251014083424.103202-1-thuth@redhat.com>
References: <20251014083424.103202-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We are going to remove obsolete assets from the cache, so keep
the time stamps of the assets that we use up-to-date to have a way
to detect stale assets later.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/asset.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index f666125bfaf..ab3a7bb591d 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -10,6 +10,7 @@
 import os
 import stat
 import sys
+import time
 import unittest
 import urllib.request
 from time import sleep
@@ -113,6 +114,16 @@ def _wait_for_other_download(self, tmp_cache_file):
         self.log.debug("Time out while waiting for %s!", tmp_cache_file)
         raise
 
+    def _save_time_stamp(self):
+        '''
+        Update the time stamp of the asset in the cache. Unfortunately, we
+        cannot use the modification or access time of the asset file itself,
+        since e.g. the functional jobs in the gitlab CI reload the files
+        from the gitlab cache and thus always have recent file time stamps,
+        so we have to save our asset time stamp to a separate file instead.
+        '''
+        self.cache_file.with_suffix(".stamp").write_text(f"{int(time.time())}")
+
     def fetch(self):
         if not self.cache_dir.exists():
             self.cache_dir.mkdir(parents=True, exist_ok=True)
@@ -120,6 +131,7 @@ def fetch(self):
         if self.valid():
             self.log.debug("Using cached asset %s for %s",
                            self.cache_file, self.url)
+            self._save_time_stamp()
             return str(self.cache_file)
 
         if not self.fetchable():
@@ -208,6 +220,7 @@ def fetch(self):
             tmp_cache_file.unlink()
             raise AssetError(self, "Hash does not match %s" % self.hash)
         tmp_cache_file.replace(self.cache_file)
+        self._save_time_stamp()
         # Remove write perms to stop tests accidentally modifying them
         os.chmod(self.cache_file, stat.S_IRUSR | stat.S_IRGRP)
 
-- 
2.51.0


