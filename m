Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AFCC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgLW-0002hN-A9; Tue, 16 Jul 2024 07:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKw-00012S-2d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKr-0003hg-GK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721129228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkB61+6tDH/3jxHpJUmWndWzqnh9iRnjS743PT395Dw=;
 b=Nd725xUgaN6XFosY13dS9KqIXuZNgQJbecSNwy3dzAa4U2ckRM9P2c1FZAFFTA4AZfgwfZ
 eRX1UXmXsXO/dsGlPUQy5UbG9tHuPYcbCPKo5ZT8/+ItlHKr9SSAipzEhkfotjXybQwzXB
 9sia0JYCeUPJWwgEPnMnadhYEQYbcFY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-J3x5kLa-MWCMDHYAwQfZ0g-1; Tue,
 16 Jul 2024 07:27:04 -0400
X-MC-Unique: J3x5kLa-MWCMDHYAwQfZ0g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 303381944AB5; Tue, 16 Jul 2024 11:27:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE0231955F40; Tue, 16 Jul 2024 11:26:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 11/11] gitlab-ci: Add "check-functional" to the build tests
Date: Tue, 16 Jul 2024 13:26:14 +0200
Message-ID: <20240716112614.1755692-12-thuth@redhat.com>
In-Reply-To: <20240716112614.1755692-1-thuth@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now that we converted many tests from the "check-avocado" test suite
to the "check-functional" test suite, we should make sure that these
also get tested in the CI.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml |  3 +-
 .gitlab-ci.d/buildtest.yml          | 60 ++++++++++++++---------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 8f7ebfaed8..54cae74a8e 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -71,7 +71,7 @@
     reports:
       junit: build/meson-logs/testlog.junit.xml
 
-.avocado_test_job_template:
+.functional_test_job_template:
   extends: .common_test_job_template
   cache:
     key: "${CI_JOB_NAME}-cache"
@@ -98,6 +98,7 @@
         du -chs ${CI_PROJECT_DIR}/avocado-cache ;
       fi
     - export AVOCADO_ALLOW_UNTRUSTED_CODE=1
+    - export QEMU_TEST_ALLOW_UNTRUSTED_CODE=1
   after_script:
     - cd build
     - du -chs ${CI_PROJECT_DIR}/avocado-cache
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index e3a0758bd9..8b1d61911c 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -22,14 +22,14 @@ check-system-alpine:
     IMAGE: alpine
     MAKE_CHECK_ARGS: check-unit check-qtest
 
-avocado-system-alpine:
-  extends: .avocado_test_job_template
+functional-system-alpine:
+  extends: .functional_test_job_template
   needs:
     - job: build-system-alpine
       artifacts: true
   variables:
     IMAGE: alpine
-    MAKE_CHECK_ARGS: check-avocado
+    MAKE_CHECK_ARGS: check-avocado check-functional
     AVOCADO_TAGS: arch:avr arch:loongarch64 arch:mips64 arch:mipsel
 
 build-system-ubuntu:
@@ -53,14 +53,14 @@ check-system-ubuntu:
     IMAGE: ubuntu2204
     MAKE_CHECK_ARGS: check
 
-avocado-system-ubuntu:
-  extends: .avocado_test_job_template
+functional-system-ubuntu:
+  extends: .functional_test_job_template
   needs:
     - job: build-system-ubuntu
       artifacts: true
   variables:
     IMAGE: ubuntu2204
-    MAKE_CHECK_ARGS: check-avocado
+    MAKE_CHECK_ARGS: check-avocado check-functional
     AVOCADO_TAGS: arch:alpha arch:microblazeel arch:mips64el
 
 build-system-debian:
@@ -85,14 +85,14 @@ check-system-debian:
     IMAGE: debian
     MAKE_CHECK_ARGS: check
 
-avocado-system-debian:
-  extends: .avocado_test_job_template
+functional-system-debian:
+  extends: .functional_test_job_template
   needs:
     - job: build-system-debian
       artifacts: true
   variables:
     IMAGE: debian
-    MAKE_CHECK_ARGS: check-avocado
+    MAKE_CHECK_ARGS: check-avocado check-functional
     AVOCADO_TAGS: arch:arm arch:i386 arch:riscv64 arch:sh4 arch:sparc arch:xtensa
 
 crash-test-debian:
@@ -129,14 +129,14 @@ check-system-fedora:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check
 
-avocado-system-fedora:
-  extends: .avocado_test_job_template
+functional-system-fedora:
+  extends: .functional_test_job_template
   needs:
     - job: build-system-fedora
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado
+    MAKE_CHECK_ARGS: check-avocado check-functional
     AVOCADO_TAGS: arch:microblaze arch:mips arch:xtensa arch:m68k
       arch:riscv32 arch:ppc arch:sparc64
 
@@ -243,14 +243,14 @@ check-system-centos:
     IMAGE: centos9
     MAKE_CHECK_ARGS: check
 
-avocado-system-centos:
-  extends: .avocado_test_job_template
+functional-system-centos:
+  extends: .functional_test_job_template
   needs:
     - job: build-system-centos
       artifacts: true
   variables:
     IMAGE: centos9
-    MAKE_CHECK_ARGS: check-avocado
+    MAKE_CHECK_ARGS: check-avocado check-functional
     AVOCADO_TAGS: arch:ppc64 arch:or1k arch:s390x arch:x86_64 arch:rx
       arch:sh4
 
@@ -274,14 +274,14 @@ check-system-opensuse:
     IMAGE: opensuse-leap
     MAKE_CHECK_ARGS: check
 
-avocado-system-opensuse:
-  extends: .avocado_test_job_template
+functional-system-opensuse:
+  extends: .functional_test_job_template
   needs:
     - job: build-system-opensuse
       artifacts: true
   variables:
     IMAGE: opensuse-leap
-    MAKE_CHECK_ARGS: check-avocado
+    MAKE_CHECK_ARGS: check-avocado check-functional
     AVOCADO_TAGS: arch:s390x arch:x86_64 arch:aarch64
 
 #
@@ -302,15 +302,15 @@ build-system-flaky:
       ppc64-softmmu rx-softmmu s390x-softmmu sh4-softmmu x86_64-softmmu
     MAKE_CHECK_ARGS: check-build
 
-avocado-system-flaky:
-  extends: .avocado_test_job_template
+functional-system-flaky:
+  extends: .functional_test_job_template
   needs:
     - job: build-system-flaky
       artifacts: true
   allow_failure: true
   variables:
     IMAGE: debian
-    MAKE_CHECK_ARGS: check-avocado
+    MAKE_CHECK_ARGS: check-avocado check-functional
     QEMU_JOB_OPTIONAL: 1
     QEMU_TEST_FLAKY_TESTS: 1
     AVOCADO_TAGS: flaky
@@ -484,14 +484,14 @@ check-cfi-aarch64:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check
 
-avocado-cfi-aarch64:
-  extends: .avocado_test_job_template
+functional-cfi-aarch64:
+  extends: .functional_test_job_template
   needs:
     - job: build-cfi-aarch64
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado
+    MAKE_CHECK_ARGS: check-avocado check-functional
 
 build-cfi-ppc64-s390x:
   extends:
@@ -522,14 +522,14 @@ check-cfi-ppc64-s390x:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check
 
-avocado-cfi-ppc64-s390x:
-  extends: .avocado_test_job_template
+functional-cfi-ppc64-s390x:
+  extends: .functional_test_job_template
   needs:
     - job: build-cfi-ppc64-s390x
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado
+    MAKE_CHECK_ARGS: check-avocado check-functional
 
 build-cfi-x86_64:
   extends:
@@ -556,14 +556,14 @@ check-cfi-x86_64:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check
 
-avocado-cfi-x86_64:
-  extends: .avocado_test_job_template
+functional-cfi-x86_64:
+  extends: .functional_test_job_template
   needs:
     - job: build-cfi-x86_64
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado
+    MAKE_CHECK_ARGS: check-avocado check-functional
 
 tsan-build:
   extends: .native_build_job_template
-- 
2.45.2


