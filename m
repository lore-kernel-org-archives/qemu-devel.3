Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA23D31A38
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 10:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfxqj-0000Mz-SD; Wed, 14 Jan 2026 05:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfxqP-0000K7-2j
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:11:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfxqN-0000lD-D9
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768385472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oi2KTjx80N/hXg1Mut14wxJNtWFiqknj/geHCvsLFQ4=;
 b=gPdrO+8aM8EU3f7fBFlydqsuUdxJom1IAPg+qES00BatL/JdLMYVu0RYXg78sDTFA7cSUF
 iqMx7e9J3hDT4L+P0l9z+Cw2pymeHwCedmtexeCVnUA1C9gZ5tQ0PswWpY+b1AQYYNK1+O
 lgiqbKohlNA9eMGpFvOuQ/uVvzRSOVg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-UKBCDnElMOCq5cR7pIGBKg-1; Wed,
 14 Jan 2026 05:11:08 -0500
X-MC-Unique: UKBCDnElMOCq5cR7pIGBKg-1
X-Mimecast-MFC-AGG-ID: UKBCDnElMOCq5cR7pIGBKg_1768385467
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C20DB18005B4; Wed, 14 Jan 2026 10:11:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.254])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5039F18001D5; Wed, 14 Jan 2026 10:11:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] tests/functional/x86_64: Use the right Python interpreter &
 fix format string
Date: Wed, 14 Jan 2026 11:11:01 +0100
Message-ID: <20260114101101.36225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

The bad_vmstate test currently fails if the host does not have a "python3"
binary in $PATH because the vmstate-static-checker.py script is executed
directly, so that it gets run via its shebang line. Use the right Python
interpreter from sys.executable to fix this problem.

Additionally, there was another bug with the formatting of the error
message in case of failures: The "+" operator can only concatenate strings,
but not strings with integers. Use a proper format string here instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/x86_64/test_bad_vmstate.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/functional/x86_64/test_bad_vmstate.py b/tests/functional/x86_64/test_bad_vmstate.py
index 40098a8490b..71a1c0cf638 100755
--- a/tests/functional/x86_64/test_bad_vmstate.py
+++ b/tests/functional/x86_64/test_bad_vmstate.py
@@ -5,6 +5,7 @@
 '''Test whether the vmstate-static-checker script detects problems correctly'''
 
 import subprocess
+import sys
 
 from qemu_test import QemuBaseTest
 
@@ -41,12 +42,13 @@ def test_checker(self):
                                        'vmstate-static-checker.py')
 
         self.log.info('Comparing %s with %s', src_json, dst_json)
-        cp = subprocess.run([checkerscript, '-s', src_json, '-d', dst_json],
+        cp = subprocess.run([sys.executable, checkerscript,
+                             '-s', src_json, '-d', dst_json],
                             stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT,
                             text=True, check=False)
         if cp.returncode != 13:
-            self.fail('Unexpected return code of vmstate-static-checker: ' +
+            self.fail('Unexpected return code of vmstate-static-checker: %d' %
                       cp.returncode)
         if cp.stdout != EXPECTED_OUTPUT:
             self.log.info('vmstate-static-checker output:\n%s', cp.stdout)
-- 
2.52.0


