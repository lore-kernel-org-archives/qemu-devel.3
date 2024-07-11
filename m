Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09453C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsPj-0004bG-1P; Thu, 11 Jul 2024 07:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsPQ-0003Ir-6j
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsPO-0004A1-CA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720698981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UTuTKKfgydqIlWwz40hk1KYERihdyi4iwi8ncTl+GqU=;
 b=EVbmz/EN2IgMvg9p9Xde9wSgZ2ZCSwp+lOOaDYsJxO8nGAl3Mg2bnyjR2sfBQA/4/vHnYw
 tmPrtzDuktIU2wNgSHcsxs7zot5FtCoXtufAKJSHvnsOXp4iPfDDp8K3+Q1o0ErIBqQwEl
 Hkyh/yll4OtjaMOc1AO6itBW0WkkA8o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-8fKPfOauNiqQ3xuDW3yjlg-1; Thu,
 11 Jul 2024 07:56:18 -0400
X-MC-Unique: 8fKPfOauNiqQ3xuDW3yjlg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBA6419792FB; Thu, 11 Jul 2024 11:56:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.118])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2ECA1955BD4; Thu, 11 Jul 2024 11:56:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 5/8] tests_pytest: Implement fetch_asset() method for
 downloading assets
Date: Thu, 11 Jul 2024 13:55:43 +0200
Message-ID: <20240711115546.40859-6-thuth@redhat.com>
In-Reply-To: <20240711115546.40859-1-thuth@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In the pytests, we cannot use the fetch_asset() function from Avocado
anymore, so we have to provide our own implementation now instead.
Thus add such a function based on the _download_with_cache() function
from tests/vm/basevm.py for this purpose.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/pytest/qemu_pytest/__init__.py | 40 ++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/tests/pytest/qemu_pytest/__init__.py b/tests/pytest/qemu_pytest/__init__.py
index e3ed32e3de..73d80b3828 100644
--- a/tests/pytest/qemu_pytest/__init__.py
+++ b/tests/pytest/qemu_pytest/__init__.py
@@ -11,6 +11,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import hashlib
 import logging
 import os
 import shutil
@@ -201,17 +202,34 @@ def setUp(self, bin_prefix):
         self.assertIsNotNone(SOURCE_DIR,'PYTEST_SOURCE_ROOT must be set')
         self.assertIsNotNone(self.qemu_bin, 'PYTEST_QEMU_BINARY must be set')
 
-    def fetch_asset(self, name,
-                    asset_hash, algorithm=None,
-                    locations=None, expire=None,
-                    find_only=False, cancel_on_missing=True):
-        return super().fetch_asset(name,
-                        asset_hash=asset_hash,
-                        algorithm=algorithm,
-                        locations=locations,
-                        expire=expire,
-                        find_only=find_only,
-                        cancel_on_missing=cancel_on_missing)
+    def check_hash(self, file_name, expected_hash):
+        if not expected_hash:
+            return True
+        if len(expected_hash) == 32:
+            sum_prog = 'md5sum'
+        elif len(expected_hash) == 40:
+            sum_prog = 'sha1sum'
+        elif len(expected_hash) == 64:
+            sum_prog = 'sha256sum'
+        elif len(expected_hash) == 128:
+            sum_prog = 'sha512sum'
+        else:
+            raise Exception("unknown hash type")
+        checksum = subprocess.check_output([sum_prog, file_name]).split()[0]
+        return expected_hash == checksum.decode("utf-8")
+
+    def fetch_asset(self, url, asset_hash):
+        cache_dir = os.path.expanduser("~/.cache/qemu/download")
+        if not os.path.exists(cache_dir):
+            os.makedirs(cache_dir)
+        fname = os.path.join(cache_dir,
+                             hashlib.sha1(url.encode("utf-8")).hexdigest())
+        if os.path.exists(fname) and self.check_hash(fname, asset_hash):
+            return fname
+        logging.debug("Downloading %s to %s...", url, fname)
+        subprocess.check_call(["wget", "-c", url, "-O", fname + ".download"])
+        os.rename(fname + ".download", fname)
+        return fname
 
 
 class QemuSystemTest(QemuBaseTest):
-- 
2.45.2


