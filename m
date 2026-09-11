Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0841AC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53PV-0006C7-94; Fri, 11 Sep 2026 11:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x53PS-000683-6e
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 11:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x53PP-0002BZ-MH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 11:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789141396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9cHZKywM/PAXFaWgVDfjM1O3FfYQJZ27esAI8XiyWLo=;
 b=hpuODZIVC+r6IAdAkP1vyRTrhYSC/rFdiRJr9Rj1CjY7kk6bAvtdqaCiQ0q4M7Ywa0+sey
 Qi7vqX33bm2tCSqNhLnmk/BjeKZ87H9/0XbqlY6gOfLx+1k1Su6v7L/K2h5B03kcJYK62L
 WaFvQBlH6pM/fJoNuo6fNv1uU+JOq9E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-915dPdZUOhy4Jle1Metp-g-1; Fri,
 11 Sep 2026 11:42:52 -0400
X-MC-Unique: 915dPdZUOhy4Jle1Metp-g-1
X-Mimecast-MFC-AGG-ID: 915dPdZUOhy4Jle1Metp-g_1789141359
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F37B819540D3; Fri, 11 Sep 2026 15:42:38 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F2A3030002C7; Fri, 11 Sep 2026 15:42:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] tests: add SELinux label to container volume mounts
Date: Fri, 11 Sep 2026 19:42:35 +0400
Message-ID: <20260911154235.448312-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The cross-compilation container mounts lack the :z SELinux label.
On Fedora with SELinux enforcing, container_t is denied read
access to user_home_t files, failing the build.

Add :z to volume mounts in docker.py CompilerRecipe and in the
TCG meson.build, matching the existing extra source paths.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/docker/docker.py | 2 +-
 tests/tcg/meson.build  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 315fa2ff848f..bdfea380339d 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -626,7 +626,7 @@ def run(self, args, argv):
             argv = argv[1:]
         cwd = os.getcwd()
         cmd = ["-w", cwd,
-               "-v", "%s:%s:rw" % (cwd, cwd)]
+               "-v", "%s:%s:rw,z" % (cwd, cwd)]
         if args.paths:
             for p in args.paths:
                 cmd += ["-v", "%s:%s:ro,z" % (p, p)]
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d41a228fb3df..221c277dd09a 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -266,7 +266,7 @@ foreach target, plan: tcg_tests
       build_test_depends += image_targets[cc_dockerfile]
       build_test_depend_files += dockerfile
       mount = meson.project_source_root()
-      mount = mount + ':' + mount
+      mount = mount + ':' + mount + ':z'
       here = meson.project_build_root()
       cc = [docker_wrapper, 'run', '--run-as-current-user',
             '-w', here, '-v', mount,
-- 
2.55.0.543.g5ebe2ebe4ea8


