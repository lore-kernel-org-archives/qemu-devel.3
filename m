Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBC5ECE57A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so08q-00079l-EV; Tue, 10 Sep 2024 08:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08o-0006z7-AU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08f-0005E6-Il
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725971907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5h6C1ogU94942iJagKeEubLv7OV7M3ODG1KrvwDwxXs=;
 b=WYQ+R2YZaTI22ThQlCB6IZM+2zpia/uwaAqWO2Ekm5zsUqEjTDffdUUW1MEsk7ey3t6FBg
 EdsjrnnrbNzCCiz0Y12hf38V6LAuXgtxCg/nKsePWg50KrRrdBkxAsBQGNNrFwaIpmmDYA
 xK+NlWcG1ZFTUTEP+ZK35LY1LBphvhY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-SMcM0jSKNPKfXAnSmDi2Vw-1; Tue,
 10 Sep 2024 08:38:24 -0400
X-MC-Unique: SMcM0jSKNPKfXAnSmDi2Vw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB9471955F25; Tue, 10 Sep 2024 12:38:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 202ED19560AB; Tue, 10 Sep 2024 12:38:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 22/22] tests/functional: Fix bad usage of has_cmd
Date: Tue, 10 Sep 2024 14:37:23 +0200
Message-ID: <20240910123726.182975-23-thuth@redhat.com>
In-Reply-To: <20240910123726.182975-1-thuth@redhat.com>
References: <20240910123726.182975-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

has_cmd returns a tuple, not a boolean value. This fixes a crash when
e.g. "tesseract" is not available in the test_m68k_nextcube test.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240910075820.51346-1-thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


