Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C256E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrwi-0006Se-HR; Wed, 18 Dec 2024 06:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwd-0006S5-OB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwb-0004wK-2E
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cTTn2IhdolQSoysGUEZrfD716N6257SFKdo2UUyZe4g=;
 b=H6E9WCyBg/if0Wq7NxLzdtj0/sf3RP7Z1Z+bx3Wl+j38lbuQsIpzufmROrKGzQGOewRWdj
 TMAw3DxsPryvnDGxQl//pIWVPefMXFvnWDMibyCm0kZYqn4VRB6x9NKdrXfSG4nDlm/BJd
 RNRY6Y3H/5jAllvbbh3fFUcRNL9HiE4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-PuLBNXt-NwWzCRNE8XGp4A-1; Wed,
 18 Dec 2024 06:10:18 -0500
X-MC-Unique: PuLBNXt-NwWzCRNE8XGp4A-1
X-Mimecast-MFC-AGG-ID: PuLBNXt-NwWzCRNE8XGp4A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CC2F1956057
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2A7119560AD; Wed, 18 Dec 2024 11:10:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 06/38] tests/functional: drop 'tesseract_available' helper
Date: Wed, 18 Dec 2024 12:09:26 +0100
Message-ID: <20241218110958.226932-7-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Daniel P. Berrangé <berrange@redhat.com>

Platforms we target have new enough tesseract that it suffices to merely
check if the binary exists.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241217155953.3950506-7-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.47.1


