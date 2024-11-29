Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14658D729E7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4rL-0004bR-4H; Fri, 29 Nov 2024 12:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4ql-0003o6-O1
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qk-00015E-3b
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCyAAhK263iWl5BFLtlHla09sTGKZa2FAEZ0CUv+p+s=;
 b=cdBwVf7CM03NphSMDNHM3DOngWYr/syMaZeC0MDizgCvA995ELDTC+PhJK3iBx1x/kE7Jp
 In8ved1fKvA+N6aPi9B3s6Dvzem9vcIxhcu4ynsT89Zzx1HtihQvYq7TRH1lg9DaCENxul
 3PqI4pPMXw1N94aZJT0kw1o4D0fN0zw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-nKYGnbAdPb-pUqxjuLqY7w-1; Fri,
 29 Nov 2024 12:32:11 -0500
X-MC-Unique: nKYGnbAdPb-pUqxjuLqY7w-1
X-Mimecast-MFC-AGG-ID: nKYGnbAdPb-pUqxjuLqY7w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9F1D1955D93; Fri, 29 Nov 2024 17:32:10 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D78FF1955F41; Fri, 29 Nov 2024 17:32:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 18/22] tests/functional: add 'archive_extract' to QemuBaseTest
Date: Fri, 29 Nov 2024 17:31:16 +0000
Message-ID: <20241129173120.761728-19-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This helper wrappers utils.archive_extract, forcing the use of the
scratch directory, to ensure any extracted files are cleaned at test
termination. If a specific member is requested, then the path to the
extracted file is also returned.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 2f32742387..31d06f0172 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -28,6 +28,8 @@
 from .asset import Asset
 from .cmd import run_cmd
 from .config import BUILD_DIR
+from .utils import (archive_extract as utils_archive_extract,
+                    guess_archive_format)
 
 
 class QemuBaseTest(unittest.TestCase):
@@ -39,6 +41,40 @@ class QemuBaseTest(unittest.TestCase):
     log = None
     logdir = None
 
+    '''
+    @params archive: filename, Asset, or file-like object to extract
+    @params sub_dir: optional sub-directory to extract into
+    @params member: optional member file to limit extraction to
+
+    Extracts @archive into the scratch directory, or a
+    directory beneath named by @sub_dir. All files are
+    extracted unless @member specifies a limit.
+
+    If @member is non-None, returns the fully qualified
+    path to @member
+    '''
+    def archive_extract(self, archive, format=None, sub_dir=None, member=None):
+        if type(archive) == Asset:
+            if format is None:
+                format = guess_archive_format(archive.url)
+            archive = archive.fetch()
+        elif format is None:
+            format = guess_archive_format(archive)
+
+        if member is not None:
+            if os.path.isabs(member):
+                member = os.path.relpath(member, '/')
+
+        if sub_dir is None:
+            utils_archive_extract(archive, self.scratch_file(), format, member)
+        else:
+            utils_archive_extract(archive, self.scratch_file(sub_dir),
+                                  format, member)
+
+        if member is not None:
+            return self.scratch_file(member)
+        return None
+
     def socket_dir(self):
         if self.socketdir is None:
             self.socketdir = tempfile.TemporaryDirectory(
-- 
2.46.0


