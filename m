Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4FDC5321D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 08:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sggjo-0001AL-Qd; Wed, 21 Aug 2024 04:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggjW-0007dR-CL
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggjS-0004pZ-FB
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724229010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ymUBzVtYuXA4pa1NmUt51Z62ZvFir+NuzwaCdkEyUW8=;
 b=SRnBHa7XzM6tigAlMlRT4C3LUJOwCf5bzi8oapUpPlEjLb4NKYeRY8Xc1VoZqLenldKCns
 CM9Ky3vrXnwktWhV4M5c5+n/h7qBbeHYjvrTZ7Sf3k1kNRj6RRRfK1aa23X7amf8hzCZ56
 3viita60hAqNug4FYEVxI5c2w+HHVOI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-Sq_1ll7oMX-BVQloKeM3AQ-1; Wed,
 21 Aug 2024 04:30:06 -0400
X-MC-Unique: Sq_1ll7oMX-BVQloKeM3AQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E587A19560AD; Wed, 21 Aug 2024 08:30:04 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A77181955DD8; Wed, 21 Aug 2024 08:30:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 34/35] docs/devel/testing: Rename avocado_qemu.Test class
Date: Wed, 21 Aug 2024 10:27:35 +0200
Message-ID: <20240821082748.65853-35-thuth@redhat.com>
In-Reply-To: <20240821082748.65853-1-thuth@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The avocado_qemu.Test class has been renamed a while back in commit
2283b627bc ("tests/avocado: Rename avocado_qemu.Test -> QemuSystemTest"),
so we should reflect this now in the documentation, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/avocado.rst | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/docs/devel/testing/avocado.rst b/docs/devel/testing/avocado.rst
index 0d207a05c5..eda76fe2db 100644
--- a/docs/devel/testing/avocado.rst
+++ b/docs/devel/testing/avocado.rst
@@ -8,11 +8,11 @@ The ``tests/avocado`` directory hosts integration tests. They're usually
 higher level tests, and may interact with external resources and with
 various guest operating systems.
 
-These tests are written using the Avocado Testing Framework (which must
-be installed separately) in conjunction with a the ``avocado_qemu.Test``
+These tests are written using the Avocado Testing Framework (which must be
+installed separately) in conjunction with a the ``avocado_qemu.QemuSystemTest``
 class, implemented at ``tests/avocado/avocado_qemu``.
 
-Tests based on ``avocado_qemu.Test`` can easily:
+Tests based on ``avocado_qemu.QemuSystemTest`` can easily:
 
  * Customize the command line arguments given to the convenience
    ``self.vm`` attribute (a QEMUMachine instance)
@@ -154,7 +154,7 @@ Overview
 --------
 
 The ``tests/avocado/avocado_qemu`` directory provides the
-``avocado_qemu`` Python module, containing the ``avocado_qemu.Test``
+``avocado_qemu`` Python module, containing the ``avocado_qemu.QemuSystemTest``
 class.  Here's a simple usage example:
 
 .. code::
@@ -186,11 +186,11 @@ in the current directory, tagged as "quick", run:
 
   avocado run -t quick .
 
-The ``avocado_qemu.Test`` base test class
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+The ``avocado_qemu.QemuSystemTest`` base test class
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-The ``avocado_qemu.Test`` class has a number of characteristics that
-are worth being mentioned right away.
+The ``avocado_qemu.QemuSystemTest`` class has a number of characteristics
+that are worth being mentioned right away.
 
 First of all, it attempts to give each test a ready to use QEMUMachine
 instance, available at ``self.vm``.  Because many tests will tweak the
@@ -233,15 +233,15 @@ and hypothetical example follows:
 
           self.assertEqual(first_res, second_res, third_res)
 
-At test "tear down", ``avocado_qemu.Test`` handles all the QEMUMachines
-shutdown.
+At test "tear down", ``avocado_qemu.QemuSystemTest`` handles all the
+QEMUMachines shutdown.
 
 The ``avocado_qemu.LinuxTest`` base test class
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The ``avocado_qemu.LinuxTest`` is further specialization of the
-``avocado_qemu.Test`` class, so it contains all the characteristics of
-the later plus some extra features.
+``avocado_qemu.QemuSystemTest`` class, so it contains all the characteristics
+of the later plus some extra features.
 
 First of all, this base class is intended for tests that need to
 interact with a fully booted and operational Linux guest.  At this
@@ -298,7 +298,7 @@ the following approaches:
    working directory, or in the current source tree.
 
 The resulting ``qemu_bin`` value will be preserved in the
-``avocado_qemu.Test`` as an attribute with the same name.
+``avocado_qemu.QemuSystemTest`` as an attribute with the same name.
 
 Attribute reference
 -------------------
@@ -308,7 +308,7 @@ Test
 
 Besides the attributes and methods that are part of the base
 ``avocado.Test`` class, the following attributes are available on any
-``avocado_qemu.Test`` instance.
+``avocado_qemu.QemuSystemTest`` instance.
 
 vm
 ""
@@ -365,7 +365,7 @@ source tree.
 LinuxTest
 ^^^^^^^^^
 
-Besides the attributes present on the ``avocado_qemu.Test`` base
+Besides the attributes present on the ``avocado_qemu.QemuSystemTest`` base
 class, the ``avocado_qemu.LinuxTest`` adds the following attributes:
 
 distro
@@ -446,7 +446,7 @@ The exact QEMU binary to be used on QEMUMachine.
 LinuxTest
 ^^^^^^^^^
 
-Besides the parameters present on the ``avocado_qemu.Test`` base
+Besides the parameters present on the ``avocado_qemu.QemuSystemTest`` base
 class, the ``avocado_qemu.LinuxTest`` adds the following parameters:
 
 distro
-- 
2.46.0


