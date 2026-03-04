Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A17FEF8FEB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxn7P-0000Bj-A0; Wed, 04 Mar 2026 09:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxn7B-0008JP-1N
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:22:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxn79-0006Cr-CP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772634134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QiEhpZCrgNbz8msv8hZ3ATueUltWVmjH+otMAUblj1M=;
 b=DOOV4OBc85FPUFL4tp5nUghOL2yR6DKmRKgsjf5vEzC84yIsrrh2G1QXlR3R/WhyT8rvEO
 dbBMuBRWOmMaYegR2uMPpgr0dA+anCBYPpG7iHK8RhIZbRJNlXdUNZMYj664c8pEwRnwcH
 RnV/16PL6R7KlU8COY6Hz1YJhnYBioU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-qVy1llOLORipHe7RIcjOKA-1; Wed,
 04 Mar 2026 09:22:11 -0500
X-MC-Unique: qVy1llOLORipHe7RIcjOKA-1
X-Mimecast-MFC-AGG-ID: qVy1llOLORipHe7RIcjOKA_1772634130
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98F301956096; Wed,  4 Mar 2026 14:22:10 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.75])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B89F61958DC5; Wed,  4 Mar 2026 14:22:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v5 10/15] tests: use 'driver' as collective term for either
 format or protocol
Date: Wed,  4 Mar 2026 14:21:15 +0000
Message-ID: <20260304142120.2635617-11-berrange@redhat.com>
In-Reply-To: <20260304142120.2635617-1-berrange@redhat.com>
References: <20260304142120.2635617-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

The I/O tests integration previously exclusively tested block formats
and now also covers the NBD protocol. Replace references to 'format'
with 'driver', as a generic term to collectively apply to either a
format or protocol.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/testing/main.rst    | 13 +++++++------
 tests/Makefile.include         |  4 ++--
 tests/qemu-iotests/meson.build |  6 +++---
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 8067d0a3ed..797111009a 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -222,7 +222,8 @@ check-block
 ~~~~~~~~~~~
 
 There are a variety of ways to exercise the block layer I/O tests
-via make targets.
+via make targets for a selection of formats / protocols (collectively
+referred to as ``drivers`` below).
 
 A default ``make check`` or ``make check-block`` command will exercise
 the ``qcow2`` format, using the tests tagged into the ``auto`` group
@@ -231,14 +232,14 @@ only.
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
index 53f47972a3..852c01e97b 100644
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
 	@echo " $(MAKE) check-tcg                     Run TCG tests"
 	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 744d0b6e88..5d6b0b5ed9 100644
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
@@ -33,8 +33,8 @@ endforeach
 
 qemu_iotests_check_cmd = files('check')
 
-foreach format, speed: qemu_iotests_formats
-  # Formats tagged 'quick' get the subset of tests in the 'auto'
+foreach format, speed: qemu_iotests_drivers
+  # Drivers tagged 'quick' get the subset of tests in the 'auto'
   # group, run by default with 'make check' / 'make check-block'
   seen = []
   if speed == 'quick'
-- 
2.53.0


