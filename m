Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF63CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJwQ-0006Yw-GF; Tue, 19 May 2026 08:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJw1-0006Go-HK
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJw0-0000Xx-1X
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779195151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B7c5l9KxYlqTVQavHSDIGnpaQmuIRpDFa29K67QxinQ=;
 b=MC4zuWK86m3UInOLVwT2L+eoQ/ljHjnxKfQWdwfSund6JpnFLP2CwCWkWXtQmo4kpK2+gS
 Idt4wRil5JtOyVxt+mCwWBHIOUquFp4WbE9uXkCUjBLvjzhrNLp1edJu8NqDoPjXCL1vrY
 Fhdgm6bz+FcSNRIHEYfVrZNAXBzRLYk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-mbGhi6XwO5mIkWy6fgOoKg-1; Tue,
 19 May 2026 08:52:28 -0400
X-MC-Unique: mbGhi6XwO5mIkWy6fgOoKg-1
X-Mimecast-MFC-AGG-ID: mbGhi6XwO5mIkWy6fgOoKg_1779195147
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2E2C1956080; Tue, 19 May 2026 12:52:26 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB73118004A3; Tue, 19 May 2026 12:52:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 07/28] iotests: ensure all qcow2 I/O tests are able to be run
 via make
Date: Tue, 19 May 2026 13:51:31 +0100
Message-ID: <20260519125153.1015315-8-berrange@redhat.com>
In-Reply-To: <20260519125153.1015315-1-berrange@redhat.com>
References: <20260519125153.1015315-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For block formats marked as 'quick', only tests in the 'auto' group are
added to the meson test suite.

The result of this is that qcow2 tests not in the 'auto' group cannot be
run at all, even if passing SPEED=slow or SPEED=thorough.

To fix this we need todo two passes over the I/O test list. First add
all tests from 'auto' group into the 'block' suite, so they are run by
default. Then on the second pass add any tests which were not in 'auto'
into the 'block-slow' suite, so they get run when SPEED=slow or
SPEED=thorough.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/meson.build | 48 ++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index bf588cc2c9..1a24d801a3 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -30,16 +30,48 @@ endforeach
 qemu_iotests_check_cmd = files('check')
 
 foreach format, speed: qemu_iotests_formats
+  # Formats tagged 'quick' get the subset of tests in the 'auto'
+  # group, run by default with 'make check' / 'make check-block'
+  seen = []
   if speed == 'quick'
-    suites = 'block'
+    args = ['-tap', '-' + format, '-g', 'auto']
+    suites = ['block']
+
+    rc = run_command(
+      [python, qemu_iotests_check_cmd] + args + ['-n'],
+      check: true,
+    )
+
+    foreach item: rc.stdout().strip().split()
+      seen += item
+      args = [qemu_iotests_check_cmd,
+              '-tap', '-' + format, item,
+              '--source-dir', meson.current_source_dir(),
+              '--build-dir', meson.current_build_dir()]
+      # Some individual tests take as long as 45 seconds
+      # Bump the timeout to 3 minutes for some headroom
+      # on slow machines to minimize spurious failures
+      test('io-' + format + '-' + item,
+           python,
+           args: args,
+           depends: qemu_iotests_binaries,
+           env: qemu_iotests_env,
+           protocol: 'tap',
+           timeout: 180,
+           suite: suites)
+    endforeach
+  endif
+
+  suites = []
+  # Any format tagged quick or slow also gets added to slow
+  # otherwise its tagged thorough
+  if speed != 'thorough'
+    suites += ['block-slow']
   else
-    suites = ['block-' + speed]
+    suites += ['block-thorough']
   endif
 
   args = ['-tap', '-' + format]
-  if speed == 'quick'
-      args += ['-g', 'auto']
-  endif
 
   rc = run_command(
       [python, qemu_iotests_check_cmd] + args + ['-n'],
@@ -47,6 +79,12 @@ foreach format, speed: qemu_iotests_formats
   )
 
   foreach item: rc.stdout().strip().split()
+      # Skip any tests already added from the 'auto' group
+      # as they're run in the 'quick' suite already
+      if item in seen
+          continue
+      endif
+
       args = [qemu_iotests_check_cmd,
               '-tap', '-' + format, item,
               '--source-dir', meson.current_source_dir(),
-- 
2.54.0


