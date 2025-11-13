Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A296CD5BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUWR-0007wL-KZ; Thu, 13 Nov 2025 05:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWO-0007qP-DC
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:44 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWF-0007JE-5W
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:44 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso1024630a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763029533; x=1763634333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDxw1Ka0eIp3fKfaGtcSKA06rhQlT0+/YP0DJg0ZmfQ=;
 b=enfJ9tVWRusMjJ3OwcOZJMI6puZcdSZXCs/qiNz4/jat+v/OeD+vOwS/TVmQeS5gk8
 8jQTrM9oUgBFOkGdMzAbEGdrM0rS2KksJYavMXiNiti/Yt16hFSm4sl5gO8pvf6YA2a7
 28AF0FDTx30wTYJ4LeKlbwdO8OS9y3S7JqGial0l/I/sT03I69gudlQyu1+vJTZsUpi5
 p4wSTip8FSNiOaXjwVrO3/H0MFVzN7grDkFcNSOOOSkWVH0Cu5KbQEko3QAq7ssOhJEl
 eo+WFZz6CVUFhJYNFxVaWRydhNkQsIcM1SLXQHDjjy96Nq4HO8Mz5X5cJWOOYnHYLemr
 6yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763029533; x=1763634333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SDxw1Ka0eIp3fKfaGtcSKA06rhQlT0+/YP0DJg0ZmfQ=;
 b=oi0kCqhQierc0P8PIRjnHNtW5nqYRb16fZVxccMPV0Nno5RaMudo288athnYOj5kZQ
 H1K0eG+XrG6I/Z6JAYePqWzZlmSeQ9GuqE9q+7MqcuyRAyD7CcIs/fua2OnBU9KsQHHE
 hOt3jV27KDmUSAaknn6Ik9cBMDEPM5I9XiHh+nhWT5ip9WztbWPtd2kSKXqRJFbzKZHU
 Y0cXCB1NWvdVVQO8xVb/7+2q55ltoY0nZ6iIPxh+9cgM5Jb52ne1Jht/Ze3oV4EeuYNX
 2ygF9MW536q/giXvVMzLKUjdvgMaoakPz4rolZ/QNXcm0L8Itx/c1oLSFXlEvB0l8H3n
 uPSQ==
X-Gm-Message-State: AOJu0YzKKymaj/n0+harqbPyI8aCEFobQxiJmLItPpg+GvKux58T4Kvp
 ST6RdaGniKtD/MS7LFk2kKdVVzlKxfLCyaGzeeDZH6rTZRqEZEHppbuVRdXiSjhJHRs=
X-Gm-Gg: ASbGncuXn/3RsDsi48s6xy68IF0yIrMhwSx7CwnUG+N5yO7aY527ntNzClzOQiI+GSI
 2FKnkeslPQFPCe8BWuXxFc4I+vZgV54doRTwFXJvLA6cgA69iRMdQEwc644M69ieZZ4tJT3RShB
 m+MVxcknz0wsvE9ZdfqkHG867umA2GcWSwvbTmxHzTbfBCE+PP+WrmZwphJfL9IRommbjuJlWHi
 FfDOlGmW9sXxCQEPEU3FTUaApNYgfVA0/Dn8J5fcBn8e9sAZw2JvIIh1TdVaVngSegGbymWleV2
 8R0nHDBU5yobgwLW/T5itSU1x14f+0f9MoOX9q1SemmA6oR51ny/EnFl+KyT1wkUJssFeuRi/fJ
 1bHWGxwoZDeT4BehEwnZ2AVeI03OFXTs/fx+RPl9EZgwk/90EKZPcIrZrxsWH672pCF7aNHo5fv
 th
X-Google-Smtp-Source: AGHT+IG8ODICqVGXq3HoZY53C2Uooox+Rb+z86/D4erKnistjzAamXes8SBH1vL6RWFxosMMRuKDbQ==
X-Received: by 2002:a17:906:730a:b0:b73:2cf1:ba6 with SMTP id
 a640c23a62f3a-b7331a0054cmr555591966b.7.1763029533210; 
 Thu, 13 Nov 2025 02:25:33 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734e9e0f20sm138282266b.0.2025.11.13.02.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:25:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7233E5F91D;
 Thu, 13 Nov 2025 10:25:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 05/18] gitlab: add initial ppc64le custom-runner test
Date: Thu, 13 Nov 2025 10:25:11 +0000
Message-ID: <20251113102525.1255370-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113102525.1255370-1-alex.bennee@linaro.org>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a plain configure build but I only run a subset of the tests
until the kinks have been worked out.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - limit to check-unit check-tcg check-softfloat
---
 docs/devel/testing/ci-jobs.rst.inc            |  6 +++
 .gitlab-ci.d/custom-runners.yml               |  1 +
 .../custom-runners/debian-13-ppc64le.yml      | 41 +++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml

diff --git a/docs/devel/testing/ci-jobs.rst.inc b/docs/devel/testing/ci-jobs.rst.inc
index b92d372a0a9..f1c70344ece 100644
--- a/docs/devel/testing/ci-jobs.rst.inc
+++ b/docs/devel/testing/ci-jobs.rst.inc
@@ -174,6 +174,12 @@ If you've got access to an IBM Z host that can be used as a gitlab-CI
 runner, you can set this variable to enable the tests that require this
 kind of host. The runner should be tagged with "s390x".
 
+PPC64LE_RUNNER_AVAILABLE
+~~~~~~~~~~~~~~~~~~~~~~~~
+If you've got access to an PPC64LE host that can be used as a gitlab-CI
+runner, you can set this variable to enable the tests that require this
+kind of host. The runner should be tagged with "ppc64le".
+
 CCACHE_DISABLE
 ~~~~~~~~~~~~~~
 The jobs are configured to use "ccache" by default since this typically
diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 142fbf4a242..3e28e48c97c 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -31,3 +31,4 @@
 include:
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml'
+  - local: '/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml'
diff --git a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
new file mode 100644
index 00000000000..80706c7a956
--- /dev/null
+++ b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
@@ -0,0 +1,41 @@
+# All jobs should run successfully in an environment setup by the
+# scripts/ci/setup/build-environment.yml task:
+# "Install basic packages to build QEMU on Ubuntu/Debian"
+
+.debian_ppc64le_template:
+  extends: .custom_runner_template
+  needs: []
+  stage: build
+  tags:
+    - debian_13
+    - ppc64le
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+    - if: "$PPC64LE_RUNNER_AVAILABLE"
+  before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
+    - JOBS=$(expr $(nproc) - 2)
+    - section_end setup
+  script:
+    - mkdir build
+    - cd build
+    - section_start configure "Running configure"
+    - ../configure $CONFIGURE_ARGS ||
+          { cat config.log meson-logs/meson-log.txt && exit 1; }
+    - section_end configure
+    - section_start build "Building QEMU"
+    - make --output-sync -j"$JOBS"
+    - section_end build
+    - section_start test "Running tests"
+    - if test -n "$MAKE_CHECK_ARGS";
+      then
+        make -j"$JOBS" $MAKE_CHECK_ARGS ;
+      fi
+    - section_end test
+
+debian-13-ppc64le-default:
+  extends: .debian_ppc64le_template
+  variables:
+    # qtest currently fails: https://gitlab.com/qemu-project/qemu/-/issues/3207
+    MAKE_CHECK_ARGS: check-unit check-tcg check-softfloat
-- 
2.47.3


