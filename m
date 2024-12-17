Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E721CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa0h-0005IP-Br; Tue, 17 Dec 2024 11:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0a-0004nx-0w
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0W-0002Ch-E6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6BpfwBKsOvfGGc+m4xw1mdADVVXjWk9/VXy9Bp9SNw=;
 b=EQGDUcDoKjuyvIFMagzvbTuPNbwwN3cee0Ii87W/G9AweVf/DmBZD6nToFvOJSAhx2WoNu
 x6E5sbXsmijn6HYXcOc63G1jw5HFfhmdRGEbYbnPACIvCnEbb/xquioBuhZ2r0ZxKuFVGj
 WXZzq7LIxO4N9f+jWHDOLQEeNYRrzlg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-xnuHMhAQMGmz0i8WbZWndQ-1; Tue,
 17 Dec 2024 11:01:06 -0500
X-MC-Unique: xnuHMhAQMGmz0i8WbZWndQ-1
X-Mimecast-MFC-AGG-ID: xnuHMhAQMGmz0i8WbZWndQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC58819560A1; Tue, 17 Dec 2024 16:01:04 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C2CF300F9B7; Tue, 17 Dec 2024 16:01:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 22/32] tests/functional: add 'archive_extract' to
 QemuBaseTest
Date: Tue, 17 Dec 2024 15:59:43 +0000
Message-ID: <20241217155953.3950506-23-berrange@redhat.com>
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

This helper wrappers archive.archive_extract, forcing the use of the
scratch directory, to ensure any extracted files are cleaned at test
termination. If a specific member is requested, then the path to the
extracted file is also returned.

Reviewed-by: Thomas Huth <thuth@redhat.com>
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


