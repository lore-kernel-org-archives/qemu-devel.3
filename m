Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACD8E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 17:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQVK-0006uP-8l; Wed, 11 Dec 2024 12:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQVH-0006n7-Og
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQVG-0001E2-7k
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733938079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddv86qZJr20tnipF27e1O9UMnzOCqzdZZCTwkM3/Ixk=;
 b=DQjLShuoDap1MnJ+8Ytl+W9u+IthN9K1QulLRFjhJI2dGxll7U+pUMxOHG2lqS5F8fjJIw
 dcQxZ1rXvWwKuOQb3F0Ky4Hs6pOeZC5Pl9ts3qnwfwhCAvM0F2EMp/EPUrzlKgzouUXRYi
 cQ8WznjNnQ6hg8uE63wWPdsGFJ1PCOg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-pmgumwAsOA638pPfLF3E5Q-1; Wed,
 11 Dec 2024 12:27:57 -0500
X-MC-Unique: pmgumwAsOA638pPfLF3E5Q-1
X-Mimecast-MFC-AGG-ID: pmgumwAsOA638pPfLF3E5Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E2FF195420C; Wed, 11 Dec 2024 17:27:56 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3300E1956048; Wed, 11 Dec 2024 17:27:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 22/31] tests/functional: add 'archive_extract' to
 QemuBaseTest
Date: Wed, 11 Dec 2024 17:26:38 +0000
Message-ID: <20241211172648.2893097-23-berrange@redhat.com>
In-Reply-To: <20241211172648.2893097-1-berrange@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This helper wrappers archive.archive_extract, forcing the use of the
scratch directory, to ensure any extracted files are cleaned at test
termination. If a specific member is requested, then the path to the
extracted file is also returned.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 493938240c..19fb1d0c07 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -25,6 +25,7 @@
 from qemu.machine import QEMUMachine
 from qemu.utils import kvm_available, tcg_available
 
+from .archive import archive_extract
 from .asset import Asset
 from .cmd import run_cmd
 from .config import BUILD_DIR
@@ -39,6 +40,37 @@ class QemuBaseTest(unittest.TestCase):
     log = None
     logdir = None
 
+    '''
+    @params archive: filename, Asset, or file-like object to extract
+    @params format: optional archive format (tar, zip, deb, cpio)
+    @params sub_dir: optional sub-directory to extract into
+    @params member: optional member file to limit extraction to
+
+    Extracts @archive into the scratch directory, or a directory beneath
+    named by @sub_dir. All files are extracted unless @member specifies
+    a limit.
+
+    If @format is None, heuristics will be applied to guess the format
+    from the filename or Asset URL. @format must be non-None if @archive
+    is a file-like object.
+
+    If @member is non-None, returns the fully qualified path to @member
+    '''
+    def archive_extract(self, archive, format=None, sub_dir=None, member=None):
+        self.log.debug(f"Extract {archive} format={format}" +
+                       f"sub_dir={sub_dir} member={member}")
+        if type(archive) == Asset:
+            archive.fetch()
+        if sub_dir is None:
+            archive_extract(archive, self.scratch_file(), format, member)
+        else:
+            archive_extract(archive, self.scratch_file(sub_dir),
+                            format, member)
+
+        if member is not None:
+            return self.scratch_file(member)
+        return None
+
     '''
     Create a temporary directory suitable for storing UNIX
     socket paths.
-- 
2.46.0


