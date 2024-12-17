Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5FBE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZzp-0004Fr-0Z; Tue, 17 Dec 2024 11:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNZzl-0004Eo-Cb
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNZzh-00025Z-2E
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68U+RfBlTpidD3nEgFbqAFrzUZ4u7M4ylio/Pj7h03Q=;
 b=PiNym1f6y8zLVbp5sAaRKuJ267Iyv1BWId5LivrthBBwIK0dVwUmCOVYcpINh7skyT5txG
 JRTHL9Aa0mx7BXp5K4OLcEdGpHzyKULu+RnzpCGM7uJQvQh7jWZJzoZl4ob5c0oK4dyjL5
 RpOtd0HkMbV96se1uy4TzvG3iNAqGfQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-s9E-c5-fOSu7PbxNG89yfQ-1; Tue,
 17 Dec 2024 11:00:15 -0500
X-MC-Unique: s9E-c5-fOSu7PbxNG89yfQ-1
X-Mimecast-MFC-AGG-ID: s9E-c5-fOSu7PbxNG89yfQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18FC6195607A; Tue, 17 Dec 2024 16:00:14 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBACA30044C1; Tue, 17 Dec 2024 16:00:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 06/32] tests/functional: drop 'tesseract_available' helper
Date: Tue, 17 Dec 2024 15:59:27 +0000
Message-ID: <20241217155953.3950506-7-berrange@redhat.com>
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

Platforms we target have new enough tesseract that it suffices to merely
check if the binary exists.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/tesseract.py | 12 +-----------
 tests/functional/test_m68k_nextcube.py  |  8 +++-----
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
index ef1833139d..1b7818090a 100644
--- a/tests/functional/qemu_test/tesseract.py
+++ b/tests/functional/qemu_test/tesseract.py
@@ -7,17 +7,7 @@
 
 import logging
 
-from . import has_cmd, run_cmd
-
-def tesseract_available(expected_version):
-    (has_tesseract, _) = has_cmd('tesseract')
-    if not has_tesseract:
-        return False
-    (stdout, stderr, ret) = run_cmd([ 'tesseract', '--version'])
-    if ret:
-        return False
-    version = stdout.split()[1]
-    return int(version.split('.')[0]) >= expected_version
+from . import run_cmd
 
 def tesseract_ocr(image_path, tesseract_args=''):
     console_logger = logging.getLogger('console')
diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/test_m68k_nextcube.py
index 0124622c40..e6e8d4fd3f 100755
--- a/tests/functional/test_m68k_nextcube.py
+++ b/tests/functional/test_m68k_nextcube.py
@@ -13,7 +13,8 @@
 from qemu_test import QemuSystemTest, Asset
 from unittest import skipUnless
 
-from qemu_test.tesseract import tesseract_available, tesseract_ocr
+from qemu_test import has_cmd
+from qemu_test.tesseract import tesseract_ocr
 
 PIL_AVAILABLE = True
 try:
@@ -53,10 +54,7 @@ def test_bootrom_framebuffer_size(self):
         self.assertEqual(width, 1120)
         self.assertEqual(height, 832)
 
-    # Tesseract 4 adds a new OCR engine based on LSTM neural networks. The
-    # new version is faster and more accurate than version 3. The drawback is
-    # that it is still alpha-level software.
-    @skipUnless(tesseract_available(4), 'tesseract OCR tool not available')
+    @skipUnless(*has_cmd('tesseract'))
     def test_bootrom_framebuffer_ocr_with_tesseract(self):
         self.set_machine('next-cube')
         screenshot_path = os.path.join(self.workdir, "dump.ppm")
-- 
2.46.0


