Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE65CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIs4P-0002tr-51; Tue, 11 Nov 2025 12:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzx-0005lD-1k
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:41 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzp-0003xR-M3
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:40 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-640f4b6836bso8255020a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 09:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762881452; x=1763486252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06bmaVkTHcaq4jFseyDrJdNi7QHB236TwhvYBcaGYEw=;
 b=d4Ndk8hj2Q13L1O2pDQxuzFIqMvMXO+9jDWIy3qty43Z3GZHtXhVL9u/humP5HL3wy
 kRWzlR+faFNe3W1GyI5CcDe3PVFU3tayL1LU1b2Xh6+Av1hloyEe+LRKa12d31hgbLVU
 oqpVBoj6uJoOeqmDq0VNP1MaDsK9YhdFFXH3s9vEhTxq0DZEAL5FYg9mjxsKnzoJWqeN
 ukCmqYTU2kuL7i4zpulB2U1kv1smKGq7/6srQZoXJklOHW4MAYweMy7kKsnhpAkT9ywO
 vuXec/dhB5bkA9cpS54U6HadGyTAa1vAAFpr6UkyaHE6cTcgJCw0I3/KI9Hv7GJH/zan
 gFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762881452; x=1763486252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=06bmaVkTHcaq4jFseyDrJdNi7QHB236TwhvYBcaGYEw=;
 b=pq+L6E+NnYo+vZECoOkQKTGXhoINu3BHgkTPG2mkkjrVHFLS4SCa9kSkvhXY+lMl/d
 6CDYtk+g7DzFNQnyv4Ufkoe6lLkgU3KioLFNyuRPT5I9VhaTEKml96LoRW4ezw5GhrKB
 ejD5+J9FBVGRsynr8EyHtoy1hAZ8mlXfuU6mMs834yUJOpHJSsI3zZmV1Hsbl5O1T9AF
 afzHNJC4vuwx78lWYBYrDvlsBuYgAr0Jinc0o8egtEhJllvCbC2BV41D6+fLImw4LEsc
 65i4X941b2S2mwCsNQBFJlrU1IUYIHtTGMLeQE3/QKIqU4dM1r53A3ICRvEfI4OxijYU
 obWA==
X-Gm-Message-State: AOJu0YzujvfCA8OGwl8Z9TFAMcF0391mJsTxPaelEQj7QJEz1nXUlhLE
 WwtSOTM+2GAH0CPxcm3q1tGqilTYuXKKP1BUhglabmL4kt84B3gwad5gwLBCYlwL3NI=
X-Gm-Gg: ASbGncs3SGKxRPh4F6Ji88W1IL/m4riA144GRcMK7cE2qH29wBXmkOqUFqdUEnsFLxe
 Mwn+76blDG0IiBxlYsAoeJut/OhESZ4RbkK8yKPPQbQATuOC85pO1izo63OKX4C9ZLvdw2Oc0jI
 yHFOiLFju8v/wn4By7/Bj5HdKcyAh6FwNzRoQ/hPRrMoo86BCNM73jm4h2nqpSbMUhnZneGcm7e
 D4qtGIrloO8uzB4WcBp9tayuhFWQ61NLsH20ui2a4mKIjsqzM1jmkkwqjWVg19seUpU/OFdCETq
 14kxhcd7+ByN/Wd/8Kc1svcXgH1MAp2AvQ++7eAzPDbdJyAAGg2EqQ5coLLlhQs5HcmzKnsPGVD
 BdGPFVm222UKgDTkKlPsEGLjwEURBGpVrtV8JAF/DQl72VR1xpVu+fNKd64VZl+5bta7Wqqwerf
 5bIiZNaybUADA=
X-Google-Smtp-Source: AGHT+IGr3XLOugC8bzrCaYk2H56TbbkA5nKddOGaxJUwm/kqqfmw/9zhpFl4ujmyi3w4w994599hfw==
X-Received: by 2002:a05:6402:3058:20b0:640:f994:b887 with SMTP id
 4fb4d7f45d1cf-6415e8312d3mr9031169a12.38.1762881451935; 
 Tue, 11 Nov 2025 09:17:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6415d91f486sm9287598a12.22.2025.11.11.09.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 09:17:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 00EC05F956;
 Tue, 11 Nov 2025 17:17:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 05/16] gitlab: add initial ppc64le custom-runner test
Date: Tue, 11 Nov 2025 17:17:12 +0000
Message-ID: <20251111171724.78201-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111171724.78201-1-alex.bennee@linaro.org>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

This is a plain configure/make check build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing/ci-jobs.rst.inc            |  6 +++
 .gitlab-ci.d/custom-runners.yml               |  1 +
 .../custom-runners/debian-13-ppc64le.yml      | 40 +++++++++++++++++++
 3 files changed, 47 insertions(+)
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
index 00000000000..6733a8e0dae
--- /dev/null
+++ b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
@@ -0,0 +1,40 @@
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
+    MAKE_CHECK_ARGS: check
-- 
2.47.3


