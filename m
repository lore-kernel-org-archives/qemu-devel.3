Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25152ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 07:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snvlh-0005K7-LI; Tue, 10 Sep 2024 03:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1snvlg-0005Iu-Cn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1snvle-0005Dj-Ra
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725955109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xq1hviZuXGjD+v2eR9Lp5WUkx3LpkUg8w1gNj22idnA=;
 b=Q4SQFAm6/qV1IkRC9hUjjx2WD9L8KuYbVnEz+DwepkrLwJ863QvcIaRqPMEBLLQs2vxq85
 naBWPnMDnRdah8Z0nLrvlZeLWgWEweckpDB5SIOvrdAmWNghAUtLwZcfzFMOl8U/29Ryu0
 GPbvuh201HiTrzbLvSdjUEexq9OMqN8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-qyDmZ-KnOnqPBuzGndfNJQ-1; Tue,
 10 Sep 2024 03:58:25 -0400
X-MC-Unique: qyDmZ-KnOnqPBuzGndfNJQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87739195604F; Tue, 10 Sep 2024 07:58:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57CD030001A1; Tue, 10 Sep 2024 07:58:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional: Fix bad usage of has_cmd
Date: Tue, 10 Sep 2024 09:58:20 +0200
Message-ID: <20240910075820.51346-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

has_cmd returns a tuple, not a boolean value. This fixes a crash when
e.g. "tesseract" is not available in the test_m68k_nextcube test.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/cmd.py       | 6 +++---
 tests/functional/qemu_test/tesseract.py | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index 3acd617324..cbabb1ceed 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -187,7 +187,7 @@ def get_qemu_img(test):
     qemu_img = os.path.join(BUILD_DIR, 'qemu-img')
     if os.path.exists(qemu_img):
         return qemu_img
-    if has_cmd('qemu-img'):
+    (has_system_qemu_img, errmsg) = has_cmd('qemu-img')
+    if has_system_qemu_img:
         return 'qemu-img'
-    test.skipTest('Could not find "qemu-img", which is required to '
-                  'create temporary images')
+    test.skipTest(errmsg)
diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
index c4087b7c11..db441027b9 100644
--- a/tests/functional/qemu_test/tesseract.py
+++ b/tests/functional/qemu_test/tesseract.py
@@ -11,7 +11,8 @@
 from . import has_cmd, run_cmd
 
 def tesseract_available(expected_version):
-    if not has_cmd('tesseract'):
+    (has_tesseract, _) = has_cmd('tesseract')
+    if not has_tesseract:
         return False
     (stdout, stderr, ret) = run_cmd([ 'tesseract', '--version'])
     if ret:
-- 
2.46.0


