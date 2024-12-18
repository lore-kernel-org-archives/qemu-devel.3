Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20F7E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrxT-0007OH-Gq; Wed, 18 Dec 2024 06:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxS-0007K0-9M
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxN-0005tB-QZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vvLqDeZxftPTdh15J7PVqYr0pTAOYiofqxvrCYh7t+s=;
 b=SpbMIaI/WGBYjZTQY1paln17aCQ157aj1uTEpdRERJzaEgog5CCWo9TDBU04dRcbuLVE7X
 r6p6E0ODx4OyqEmVKjyJRKxcy88LG2H0UBWCJDfhYV51b1fV9pg5nCpOrvkr1U/X/rn1A1
 niv6hzBwTOE71lfqdlw7W3h134Ls3wE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-gblCkewxNmWtb3SDRTccXA-1; Wed,
 18 Dec 2024 06:11:07 -0500
X-MC-Unique: gblCkewxNmWtb3SDRTccXA-1
X-Mimecast-MFC-AGG-ID: gblCkewxNmWtb3SDRTccXA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F76E1955D4C
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:11:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47CD619560AD; Wed, 18 Dec 2024 11:11:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 25/38] tests/functional: add 'uncompress' to QemuBaseTest
Date: Wed, 18 Dec 2024 12:09:45 +0100
Message-ID: <20241218110958.226932-26-thuth@redhat.com>
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

This helper wrappers utils.uncompress, forcing the use of the scratch
directory, to ensure any uncompressed files are cleaned at test
termination.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-26-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.47.1


