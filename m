Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9C3EC01BE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cXg-000379-85; Mon, 23 Mar 2026 06:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4cXe-00035U-12
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4cXc-0008Ft-EW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774261787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYFFP1Q/3RTsXIUtXyfWqmNdeCk8HMsQrSZQdg/MncY=;
 b=Tse/giZRyg/s8sHFsIQqnBPftb8VY+sNcwD/nsPf+TCrdMegYW0bCbfv1v7XNITAQozHCm
 b9L54aXV+e8pKaXvTP80R1xnsSyYX3y/Ncn8pIA+9XXhkW8xGy8rTvCx9+b7+1DNq7fKCg
 gIwp2IQabVDIGKt9OPvP6Ar3Y8Ss+F4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-wzBt3M-WPw2cxYuLwFlg0Q-1; Mon,
 23 Mar 2026 06:29:46 -0400
X-MC-Unique: wzBt3M-WPw2cxYuLwFlg0Q-1
X-Mimecast-MFC-AGG-ID: wzBt3M-WPw2cxYuLwFlg0Q_1774261785
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB4CA1918E40; Mon, 23 Mar 2026 10:29:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68E6530001A2; Mon, 23 Mar 2026 10:29:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/6] tests/functional: remove heuristics for finding build dir
Date: Mon, 23 Mar 2026 11:29:20 +0100
Message-ID: <20260323102920.25170-7-thuth@redhat.com>
In-Reply-To: <20260323102920.25170-1-thuth@redhat.com>
References: <20260323102920.25170-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Currently some heuristics are used to locate the build dir, if the
MESON_BUILD_ROOT environment variable is not set. These are not
entirely accurate, however, especially if the developer is using
nested sub-dirs under $PWD/build/...

Since the introduction of the 'run' script, we can ensure any
direct execution of the tests will have MESON_BUILD_ROOT set.

Meanwhile when meson runs the test it will also have this env
set. The only gap is when running pre-caching, and that is easily
fixed to set MESON_BUILD_ROOT.

It can thus be assumed that MESON_BUILD_ROOT will always be set
in any supported execution scenario, which allows the heuristics
to be removed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260310114756.146083-3-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build         |  1 +
 tests/functional/qemu_test/config.py | 11 +++--------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 0f7c90bed0f..3b42299e7ce 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -96,6 +96,7 @@ foreach speed : ['quick', 'thorough']
       teststamp = testname + '.tstamp'
       test_precache_env = environment()
       test_precache_env.set('QEMU_TEST_PRECACHE', meson.current_build_dir() / teststamp)
+      test_precache_env.set('MESON_BUILD_ROOT', meson.project_build_root())
       test_precache_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
                                           meson.current_source_dir())
       precache = custom_target('func-precache-' + testname,
diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
index 0192027233e..e0893f630ee 100644
--- a/tests/functional/qemu_test/config.py
+++ b/tests/functional/qemu_test/config.py
@@ -24,15 +24,10 @@ def _build_dir():
     root = os.getenv('MESON_BUILD_ROOT')
     if root is not None:
         return Path(root)
-    # Makefile.mtest only exists in build dir, so if it is available, use CWD
-    if os.path.exists('Makefile.mtest'):
-        return Path(os.getcwd())
 
-    root = os.path.join(_source_dir(), 'build')
-    if os.path.exists(root):
-        return Path(root)
-
-    raise Exception("Cannot identify build dir, set MESON_BUILD_ROOT")
+    raise Exception("Missing MESON_BUILD_ROOT environment variable. " +
+                    "Please use the '<BUILD-DIR>/run' script if invoking " +
+                    "directly instead of via make/meson")
 
 BUILD_DIR = _build_dir()
 
-- 
2.53.0


