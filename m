Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F058EB1053
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 11:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzva6-0003Sb-KH; Tue, 10 Mar 2026 07:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzvZL-0003Lx-Oz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzvZK-000110-8F
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773143289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ticjyx0rJFT9ZL3vtP4WlISSvfOKWqzOPAwqglSEBDQ=;
 b=TERdi/Ly8UCKa4lCOh6g75RBxE2R8iT/B5fQ6VFY5VvJhXDUqQDThVREWKNy/v6YDYr+ew
 2GBTMAVPWmhQM/fBQHj+JO8daaNLcpPUWKYACgLp4UPHsdhuduffIfEWfyxi7WCQDGfOc1
 5B6Z0VU5ABtqj5rRPcPvA/sjTeLi714=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-WmiZlzjnNDihInI3UyjpCg-1; Tue,
 10 Mar 2026 07:48:06 -0400
X-MC-Unique: WmiZlzjnNDihInI3UyjpCg-1
X-Mimecast-MFC-AGG-ID: WmiZlzjnNDihInI3UyjpCg_1773143285
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F403119560BD; Tue, 10 Mar 2026 11:48:04 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.33.213])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3508A1800351; Tue, 10 Mar 2026 11:48:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] tests/functional: remove heuristics for finding build
 dir
Date: Tue, 10 Mar 2026 11:47:56 +0000
Message-ID: <20260310114756.146083-3-berrange@redhat.com>
In-Reply-To: <20260310114756.146083-1-berrange@redhat.com>
References: <20260310114756.146083-1-berrange@redhat.com>
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
---
 tests/functional/meson.build         |  1 +
 tests/functional/qemu_test/config.py | 11 +++--------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d34aefa8b0..1b94c2efb6 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -95,6 +95,7 @@ foreach speed : ['quick', 'thorough']
       teststamp = testname + '.tstamp'
       test_precache_env = environment()
       test_precache_env.set('QEMU_TEST_PRECACHE', meson.current_build_dir() / teststamp)
+      test_precache_env.set('MESON_BUILD_ROOT', meson.project_build_root())
       test_precache_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
                                           meson.current_source_dir())
       precache = custom_target('func-precache-' + testname,
diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
index 0192027233..e0893f630e 100644
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


