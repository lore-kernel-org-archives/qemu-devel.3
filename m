Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F571CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0QV-00010W-B1; Mon, 18 May 2026 12:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0Pn-0000EX-Ha
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0Pl-0005IB-G4
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779120116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLs7ZqNW0VBC8AicYt1b1FhaleTUeEEaRstYy+L2ocE=;
 b=C2Wv6pJXWyDf2HKT2mLLPu8a3wFZVFD+QZpQk8BH46Pv+gGv4IH8TI36ekpDfVRd141l02
 XJtWC2O/Wsrbs2tm8Io7ZA24EwqweB+A9NJswssKDRUbVqWAW4NVfklhUQ4R1RoDFlSNl6
 8vmLUjz3n1OyyiidkDsciZgieZ4ARto=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-x4JrZycpNRWD7ZgyVEqi_g-1; Mon,
 18 May 2026 12:01:52 -0400
X-MC-Unique: x4JrZycpNRWD7ZgyVEqi_g-1
X-Mimecast-MFC-AGG-ID: x4JrZycpNRWD7ZgyVEqi_g_1779120108
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3E5418002D7; Mon, 18 May 2026 16:01:47 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0498C30001A2; Mon, 18 May 2026 16:01:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v8 11/16] iotests: use 'driver' as collective term for either
 format or protocol
Date: Mon, 18 May 2026 17:00:46 +0100
Message-ID: <20260518160051.903616-12-berrange@redhat.com>
In-Reply-To: <20260518160051.903616-1-berrange@redhat.com>
References: <20260518160051.903616-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The I/O tests integration previously exclusively tested block formats
and now also covers the NBD protocol. Replace references to 'format'
with 'driver', as a generic term to collectively apply to either a
format or protocol.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/testing/main.rst    | 13 +++++++------
 tests/Makefile.include         |  4 ++--
 tests/qemu-iotests/meson.build | 24 ++++++++++++------------
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 843592e3e0..c0321d1d25 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -237,7 +237,8 @@ check-block
 ~~~~~~~~~~~
 
 There are a variety of ways to exercise the block layer I/O tests
-via make targets.
+via make targets for a selection of formats / protocols (collectively
+referred to as ``drivers`` below).
 
 A default ``make check`` or ``make check-block`` command will exercise
 the ``qcow2`` format, using the tests tagged into the ``auto`` group
@@ -246,14 +247,14 @@ only.
 These targets accept the ``SPEED`` variable to augment the set of tests
 to run. A slightly more comprehensive test plan can be run by defining
 ``SPEED=slow``, which enables all tests for the ``qcow2`` and ``raw``
-formats. The most comprehensive test plan can be run by defining
-``SPEED=thorough``, which enables all available tests for the formats
+drivers. The most comprehensive test plan can be run by defining
+``SPEED=thorough``, which enables all available tests for the drivers
 ``luks``, ``nbd``, ``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``,
 ``vhdx``, ``vmdk``, and ``vpc``.
 
-Each of formats also has its own dedicated make target, named
-``make check-block-$FORMAT`` which will run all available tests for
-the designated format and does not require the ``SPEED`` variable
+Each of drivers also has its own dedicated make target, named
+``make check-block-$DRIVER`` which will run all available tests for
+the designated driver and does not require the ``SPEED`` variable
 to be set.
 
 See the "QEMU iotests" section below for more information on the
diff --git a/tests/Makefile.include b/tests/Makefile.include
index a820980bbe..a063a1d60f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -14,8 +14,8 @@ check-help:
 	@echo " $(MAKE) check-unit                    Run qobject tests"
 	@echo " $(MAKE) check-qapi-schema             Run QAPI schema tests"
 	@echo " $(MAKE) check-tracetool               Run tracetool generator tests"
-	@echo " $(MAKE) check-block                   Run block tests (all formats)"
-	@echo " $(MAKE) check-block-FORMAT            Run block tests (only for FORMAT)"
+	@echo " $(MAKE) check-block                   Run block tests (all formats/protocols)"
+	@echo " $(MAKE) check-block-DRIVER            Run block tests (only for format/protocol 'DRIVER')"
 ifneq ($(filter $(all-check-targets), check-softfloat),)
 	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
 	@echo " $(MAKE) check-tcg                     Run TCG tests"
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 744d0b6e88..bc6132a0f7 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -12,7 +12,7 @@ qemu_iotests_binaries = [qemu_img, qemu_io, qemu_nbd, qsd]
 qemu_iotests_env = {'PYTHON': python.full_path()}
 # If altering this definition, also update docs/devel/testing/main.rst
 # section on 'check-block' targets to reflect the changes
-qemu_iotests_formats = {
+qemu_iotests_drivers = {
   'qcow2': 'quick',
   'raw': 'slow',
   'luks': 'thorough',
@@ -33,12 +33,12 @@ endforeach
 
 qemu_iotests_check_cmd = files('check')
 
-foreach format, speed: qemu_iotests_formats
-  # Formats tagged 'quick' get the subset of tests in the 'auto'
+foreach driver, speed: qemu_iotests_drivers
+  # Drivers tagged 'quick' get the subset of tests in the 'auto'
   # group, run by default with 'make check' / 'make check-block'
   seen = []
   if speed == 'quick'
-    args = ['-tap', '-' + format, '-g', 'auto']
+    args = ['-tap', '-' + driver, '-g', 'auto']
     suites = ['block']
 
     rc = run_command(
@@ -49,13 +49,13 @@ foreach format, speed: qemu_iotests_formats
     foreach item: rc.stdout().strip().split()
       seen += item
       args = [qemu_iotests_check_cmd,
-              '-tap', '-' + format, item,
+              '-tap', '-' + driver, item,
               '--source-dir', meson.current_source_dir(),
               '--build-dir', meson.current_build_dir()]
       # Some individual tests take as long as 45 seconds
       # Bump the timeout to 3 minutes for some headroom
       # on slow machines to minimize spurious failures
-      test('io-' + format + '-' + item,
+      test('io-' + driver + '-' + item,
            python,
            args: args,
            depends: qemu_iotests_binaries,
@@ -66,9 +66,9 @@ foreach format, speed: qemu_iotests_formats
     endforeach
   endif
 
-  # Every format gets put in the format specific suite
-  suites = ['block-' + format + '-optional']
-  # Any format tagged quick or slow also gets added to slow
+  # Every driver gets put in the driver specific suite
+  suites = ['block-' + driver + '-optional']
+  # Any driver tagged quick or slow also gets added to slow
   # otherwise its tagged thorough
   if speed != 'thorough'
     suites += ['block-slow']
@@ -76,7 +76,7 @@ foreach format, speed: qemu_iotests_formats
     suites += ['block-thorough']
   endif
 
-  args = ['-tap', '-' + format]
+  args = ['-tap', '-' + driver]
 
   rc = run_command(
       [python, qemu_iotests_check_cmd] + args + ['-n'],
@@ -91,13 +91,13 @@ foreach format, speed: qemu_iotests_formats
       endif
 
       args = [qemu_iotests_check_cmd,
-              '-tap', '-' + format, item,
+              '-tap', '-' + driver, item,
               '--source-dir', meson.current_source_dir(),
               '--build-dir', meson.current_build_dir()]
       # Some individual tests take as long as 45 seconds
       # Bump the timeout to 3 minutes for some headroom
       # on slow machines to minimize spurious failures
-      test('io-' + format + '-' + item,
+      test('io-' + driver + '-' + item,
            python,
            args: args,
            depends: qemu_iotests_binaries,
-- 
2.54.0


