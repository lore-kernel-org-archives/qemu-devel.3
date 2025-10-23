Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AB4CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuBC-00020q-8i; Thu, 23 Oct 2025 08:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8x-0008UW-0A
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:12 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8s-0005Io-UZ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:09 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b6d53684cfdso167846066b.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761221402; x=1761826202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06bmaVkTHcaq4jFseyDrJdNi7QHB236TwhvYBcaGYEw=;
 b=h+c7DzOaT4gE2QP8zRX6W25a72F4y9/aB0YmfbhDEkW7YLN097PNnnsZfcDlhn6LKO
 rj/h6z0DRoNFtjggWRI3UFyalNomvTPUqifOVutG16H8S7KCoGvRUqCJEPFz120wAGQK
 3xuct1jGGzlN9xdZkwYMcodhZxxnzgYXxrJlHpZZGk4BgPyk8gi1HLjUAt4fHGOk4o2+
 lvCYx3EY4b+7s0B5dQFY8xPlq8rniaMi0aC176syhFGdil8WAvIV/qQEbOVt+yO/yaru
 XIcWrtJvD8L5A7qaAmhmrzFYkY49Tv2Bf8QvWKUE8lu4Nt0QUdKQRUCK8NRk87U0Ic+z
 lQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761221402; x=1761826202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06bmaVkTHcaq4jFseyDrJdNi7QHB236TwhvYBcaGYEw=;
 b=UkeUiP0hNqbbz33kdEQxaiDDx+BJlkML5LThZtRdZFay6deMfsnHivYffFoPVFUH2T
 loGIILGwxowTruNrudSV5PRBl2xUGcawl9T8RdHll9989Rsb5RW62xXvjP3PUzlKU+Wj
 SZzQia5HjSAN58xVXdEuqrxWONfra0HkFXHPK6TyhwpaP1km1+c+MUhuwn0dLUe+CqWE
 H3FV3lL8rRUf1LtQ66fDwySm1cn+meXrKyyN5058nix2+Xh/VZIcf3AMWtwhBxWOkc14
 OHbbjHwYzBP1+T/5OReemsrxyTlc97V6fVKs4cHTTvHGtdQkyGNEMdzkRK76Pu1K/zsF
 VycQ==
X-Gm-Message-State: AOJu0Yyd29rPmubf8DBWDK37kskZlBpErUOx2y0l3j8rhmEoN7u2WwHq
 owCPAvCzmuXBdlblU05a0L9ajWu3ZIwW21T+8rfofnqGoHpJMmokGiSg/SowwlnFwLk=
X-Gm-Gg: ASbGncu2rAa1dIYRCl1e++s6MfXxdJER+sA9kYbArwxI/PeaC+Ut9gexnLWiqAevIzW
 r3ZyNIE4osWJqpxl7lcNRmqp2cEE2DiQfeRw+paJJnt8uu4mCTC0jDWkRouAkg8DJKf5eiuUIVd
 rH9QWQt7PM2PG9c09RIwcBUXxdrH1ElUpj45lGXO9cXFi53c6JFonssEPxkNfZJqUsQIbMWbvmx
 bLYTnFyyvwsNAK+fmOHc51SAO33HWJyfskBh+UZimXOCyG3DK6xJ0Okiv/ZZPFA2uTYghsRV8JJ
 AgP5EMqI5cf8RCdVygzAtuLXGK9RLPYQ9bQ6ZbgOynXxjcJcGWPlRprbDQS/CShze9RuyybfXpW
 FoO4/OGRmcE7enld0f6UEPRhLx9DC79W4B9OI3puuAfalwBPli4oKjGYW1Z4tMlWJ2EVgGD6xP8
 eR4epv8fHvQ8Wb3KfKKdbbpA==
X-Google-Smtp-Source: AGHT+IEvbafavPUhgLdXbmF3gP2et1yYkX/XgDnGBThDhol3Cgi0iPpfJig3NhF4r6BCcMGBKIefKA==
X-Received: by 2002:a17:906:794e:b0:b3a:b949:3059 with SMTP id
 a640c23a62f3a-b6473143f12mr3069083566b.18.1761221402278; 
 Thu, 23 Oct 2025 05:10:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d511f87a9sm208019366b.26.2025.10.23.05.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 05:09:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7613C610D1;
 Thu, 23 Oct 2025 13:09:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 7/7] gitlab: add initial ppc64le custom-runner test
Date: Thu, 23 Oct 2025 13:09:53 +0100
Message-ID: <20251023120953.2905297-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023120953.2905297-1-alex.bennee@linaro.org>
References: <20251023120953.2905297-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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


