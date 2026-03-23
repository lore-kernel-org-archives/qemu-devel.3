Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EFFEC01BE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cXa-000333-9T; Mon, 23 Mar 2026 06:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4cXY-00032i-OA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4cXW-0008Fa-V0
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774261782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXKx2eZSRRxB3m9Jr0Wq1EtQtmX2RWQ+MaUvt9gRf1Y=;
 b=c/GhSBO6esAHdB0UmJgMxMsJSqINQkRcN+S3AoaLS8wuiZwJly8Iyt54z3md8GPHmX219A
 GK3jrf1UaC+TS6/JabY6iB5NyruvTR+kwDH14Bt1W8RjhFKT16SiXRIqMjHC9fWSgKVxL2
 gg4M+2Y5y9SUHmeL67Fyqqd1TFDVRIs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-HCeoZSw1Op-GAsPIad4QEQ-1; Mon,
 23 Mar 2026 06:29:41 -0400
X-MC-Unique: HCeoZSw1Op-GAsPIad4QEQ-1
X-Mimecast-MFC-AGG-ID: HCeoZSw1Op-GAsPIad4QEQ_1774261780
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E80CE1977031; Mon, 23 Mar 2026 10:29:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B2D6300019F; Mon, 23 Mar 2026 10:29:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/6] tests/functional: fix log placement when run directly
Date: Mon, 23 Mar 2026 11:29:19 +0100
Message-ID: <20260323102920.25170-6-thuth@redhat.com>
In-Reply-To: <20260323102920.25170-1-thuth@redhat.com>
References: <20260323102920.25170-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Daniel P. Berrangé <berrange@redhat.com>

When running functional tests directly there are some heuristics
to figure out where the build directory lives, along with the
possibility to override the logic by setting the QEMU_BUILD_DIR
env variable. This env var is set as part of the test env when
run via Meson but not when run directly.

A particular flaw with the currently logic is that it silently
uses the wrong location when the build directory is a sub-dir
under "./build", which is a common usage scenario for some devs.

With the recent introduction of the 'run' script, we now have
the MESON_BUILD_ROOT env variable set unconditionally, so we
can rely on that from the functional tests to get the correct
location in all scenarios.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260310114756.146083-2-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build         | 2 +-
 tests/functional/qemu_test/config.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 9bec5a07516..0f7c90bed0f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -75,7 +75,7 @@ foreach speed : ['quick', 'thorough']
       test_deps += [qemu_img]
     endif
     test_env.set('QEMU_TEST_QEMU_BINARY', test_emulator.full_path())
-    test_env.set('QEMU_BUILD_ROOT', meson.project_build_root())
+    test_env.set('MESON_BUILD_ROOT', meson.project_build_root())
     test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
                                meson.current_source_dir())
 
diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
index 6d4c9c3ce1d..0192027233e 100644
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


