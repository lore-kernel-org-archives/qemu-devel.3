Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0764F3C260
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzan7-00089G-AD; Mon, 09 Mar 2026 09:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzams-00087l-8W
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzamq-0004gI-Fc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773063403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=httT+4K8tYibhwm0fXVvzC4IiCbaV5h+BQqL+XadykI=;
 b=TtoxKGjW1giwhHlPzpm6L3UX0YN0angDNU5PS5IdqCk/6EC1wYNIBd6uJoqN6WRF5qGZst
 8OoUobKzfx8Rig1ZZ1153CyqjnQD/9QbVgpRdh8SvsbYGHZ3TPI5o5ujp+2PFu77CN1/8g
 uPtCRpxsxAHgxHNxasqzxK1264Uh5eg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-igJpzPqNOQmURiqu9QbmVg-1; Mon,
 09 Mar 2026 09:36:38 -0400
X-MC-Unique: igJpzPqNOQmURiqu9QbmVg-1
X-Mimecast-MFC-AGG-ID: igJpzPqNOQmURiqu9QbmVg_1773063397
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F1441956095; Mon,  9 Mar 2026 13:36:37 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.33.95])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C5111800594; Mon,  9 Mar 2026 13:36:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] tests/functional: fix log placement when run directly
Date: Mon,  9 Mar 2026 13:36:33 +0000
Message-ID: <20260309133633.3619913-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When running functional tests directly there are some heuristics
to figure out where the build directory lives, along with the
possibility to override the logic by setting the QEMU_BUILD_DIR
env variable. This env var is set as part of the test env when
run via Meson but not when run directly.

A particular flaw with the currently logic is that it silently
uses the wrong location when the build directory is a sub-dir
under "./build", which is a common usage scenario for some devs.

With the recent introduction of the 'run' script, we now have
the MESON_BUILD_DIR env variable set unconditionally, so we
can rely on that from the functional tests to get the correct
location in all scenarios.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/meson.build         | 2 +-
 tests/functional/qemu_test/config.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b979cff2b9..d34aefa8b0 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -74,7 +74,7 @@ foreach speed : ['quick', 'thorough']
       test_deps += [qemu_img]
     endif
     test_env.set('QEMU_TEST_QEMU_BINARY', test_emulator.full_path())
-    test_env.set('QEMU_BUILD_ROOT', meson.project_build_root())
+    test_env.set('MESON_BUILD_ROOT', meson.project_build_root())
     test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
                                meson.current_source_dir())
 
diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
index 6d4c9c3ce1..0192027233 100644
--- a/tests/functional/qemu_test/config.py
+++ b/tests/functional/qemu_test/config.py
@@ -21,7 +21,7 @@ def _source_dir():
     return Path(__file__).parent.parent.parent.parent
 
 def _build_dir():
-    root = os.getenv('QEMU_BUILD_ROOT')
+    root = os.getenv('MESON_BUILD_ROOT')
     if root is not None:
         return Path(root)
     # Makefile.mtest only exists in build dir, so if it is available, use CWD
@@ -32,7 +32,7 @@ def _build_dir():
     if os.path.exists(root):
         return Path(root)
 
-    raise Exception("Cannot identify build dir, set QEMU_BUILD_ROOT")
+    raise Exception("Cannot identify build dir, set MESON_BUILD_ROOT")
 
 BUILD_DIR = _build_dir()
 
-- 
2.53.0


