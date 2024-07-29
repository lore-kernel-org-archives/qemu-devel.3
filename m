Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0626EC49EA1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSIb-0006IK-2y; Mon, 29 Jul 2024 11:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIX-0005pp-V4
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:30 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIV-0008Sk-Nw
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3684407b2deso1439307f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266904; x=1722871704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9+uYHMIghgd2LjabzUJzhrVG79tp1J2HB1deB4p2GI=;
 b=crQT4POTsIPbhfTqLWYCdhLPjkNbzGSaETnHggBbc0/66rQYAfMaEn+avRZmewpIxf
 RcvO9Y8HEh7vsfkihK7A1kmAyVVUtU7tlW8nC90epdhLU6yYnXVEFYcx4oMxa/Eb5x/Q
 2X4bWhTm8zbQe5s1F2gz86wFn3k0WFG9ZUA+vpX9I/ji9IYTVWhwaCWzqd/MYW+iEeyk
 8CdjjU0UXMRlSrziEyEp62NGwzFmItPE2przO1AEucLUMqWyBqlmHs31U8jiqTmCewje
 Df71rriUnwXeslEKbE7EkQtKNsB/2ZeJc+Q2SIpK1siqF/kBCtfg2fVo5etx2c6eOIhY
 Nznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266904; x=1722871704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9+uYHMIghgd2LjabzUJzhrVG79tp1J2HB1deB4p2GI=;
 b=qirXeUlmbdTjuPWkKvg2mIHvez4RpERFH2keUpj9/9iZsoajtgctVN29n6BZKunBV8
 uJYhF3CRjiGiDVee5nFrqTJUos8TCLdfbVWbrDxdtG9Rj8ykO3tR39N42i14EMnNK4AO
 ii4BAFXkXY5jqynaKT0Y566OS9CIUhbSm6r1teQ6UrhAj29o28NRny12zH72PwZXQEAt
 bm/RaWf8JEGh+lPRi8QPtUDDjC20Cc590yn0qQ9yVktoOfPvxuoqb4Hmx3hq9yzv6Kxz
 VyI4/9auMWeFtSndjMQcXDO4/uJJaqKwdpzG9h1EhEY9vprqEMxHxxQd0VQSDMjqLmoN
 r68A==
X-Gm-Message-State: AOJu0YweCmNxwaalSIsZJ4AWpKUJ6r3z5C8eeYOIfOaacjc6ye6O4C4Y
 xWjVOH6JZVE0myhuDbP+PWOe0r5y9lnPmC0SEMakElY4g7Q34D4as70QRzg6nw83NXK+45EYLD2
 d
X-Google-Smtp-Source: AGHT+IGic3LCoI+pgt5erQ15t+dFGoYJm2buPFRNoVFpKIqbYuF/Us6jXwbqW+uOubqhIhtN5OreSg==
X-Received: by 2002:a5d:64e1:0:b0:368:4ed7:2acc with SMTP id
 ffacd0b85a97d-36b5cecf2famr8645980f8f.5.1722266903772; 
 Mon, 29 Jul 2024 08:28:23 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857d4fsm12615930f8f.86.2024.07.29.08.28.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:28:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/14] gitlab-ci: Add "check-functional" to the build tests
Date: Mon, 29 Jul 2024 17:27:11 +0200
Message-ID: <20240729152714.10225-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Now that we converted many tests from the "check-avocado" test suite
to the "check-functional" test suite, we should make sure that these
also get tested in the CI.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240724175248.1389201-24-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index aa32782405..1d2afae996 100644
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
@@ -485,14 +485,14 @@ check-cfi-aarch64:
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
@@ -523,14 +523,14 @@ check-cfi-ppc64-s390x:
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
@@ -557,14 +557,14 @@ check-cfi-x86_64:
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


