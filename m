Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591F0E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa0m-0005S4-6g; Tue, 17 Dec 2024 11:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0i-0005KC-0M
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0d-0002Dj-De
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOP9T65Y1N1eKANKaDuXNmoW4XhSoOjwKVDIlKN5TO4=;
 b=EElsX4/NfTH0JhD8BhwLDcz1TmYZ7PJ5fBy/X3EazRo+A6/CHftMZQt/5wZ5mPbLg4dXBD
 FHZBSvq2ICo/rfUdxKu202QENE0Wd4HWBQzIDFIGnHfSwx2tIfB9MdMyfNUjK90F/MSN2m
 nMR+A1+XNHVLD6UWNeAeW5x/hEyZ6Hk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-EpPgYyWyMRCQ-tWd2abLyQ-1; Tue,
 17 Dec 2024 11:01:14 -0500
X-MC-Unique: EpPgYyWyMRCQ-tWd2abLyQ-1
X-Mimecast-MFC-AGG-ID: EpPgYyWyMRCQ-tWd2abLyQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80267195609D; Tue, 17 Dec 2024 16:01:13 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F15D300F9B7; Tue, 17 Dec 2024 16:01:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 25/32] tests/functional: add 'uncompress' to QemuBaseTest
Date: Tue, 17 Dec 2024 15:59:46 +0000
Message-ID: <20241217155953.3950506-26-berrange@redhat.com>
In-Reply-To: <20241217155953.3950506-1-berrange@redhat.com>
References: <20241217155953.3950506-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This helper wrappers utils.uncompress, forcing the use of the scratch
directory, to ensure any uncompressed files are cleaned at test
termination.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 19fb1d0c07..d0bb3141d5 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -29,6 +29,7 @@
 from .asset import Asset
 from .cmd import run_cmd
 from .config import BUILD_DIR
+from .uncompress import uncompress
 
 
 class QemuBaseTest(unittest.TestCase):
@@ -40,6 +41,30 @@ class QemuBaseTest(unittest.TestCase):
     log = None
     logdir = None
 
+    '''
+    @params compressed: filename, Asset, or file-like object to uncompress
+    @params format: optional compression format (gzip, lzma)
+
+    Uncompresses @compressed into the scratch directory.
+
+    If @format is None, heuristics will be applied to guess the format
+    from the filename or Asset URL. @format must be non-None if @uncompressed
+    is a file-like object.
+
+    Returns the fully qualified path to the uncompressed file
+    '''
+    def uncompress(self, compressed, format=None):
+        self.log.debug(f"Uncompress {compressed} format={format}")
+        if type(compressed) == Asset:
+            compressed.fetch()
+
+        (name, ext) = os.path.splitext(str(compressed))
+        uncompressed = self.scratch_file(os.path.basename(name))
+
+        uncompress(compressed, uncompressed, format)
+
+        return uncompressed
+
     '''
     @params archive: filename, Asset, or file-like object to extract
     @params format: optional archive format (tar, zip, deb, cpio)
-- 
2.46.0


