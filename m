Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE273CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1VF-0003zq-2T; Mon, 17 Nov 2025 10:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1US-0003eM-7l
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:13 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UO-0007zM-00
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:02 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so47444575e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394598; x=1763999398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09U62eKe5Yxy/KGkkCFbVC8OGZHmX2FwjAQEb33kAG0=;
 b=aq/AqAFJg60VMVm/cB9oBdZWMtqtIlkC4KmWxd/jahrZ+q7mIpgYHzGIaSKqIKCbWM
 qohCUk5xTkPPYKL8pE1ubk5Gh5CZyf5wVfohSLGE7SBr0M5FitpWbTSxa2NPTF9irFzp
 BXKNrjs6DmFtsCeWsKfTCNhYDC3+jP6pXthAxeZ0iRcA0gIXKK4wWHBrkvSkyfiaA032
 V9Jz7G9qyK3vQhroRiKCjdA+K/KwQI6xNjafGyMy5n7ROzn7l0+1kZ6FgpDyjm0LeYSj
 Jo6RPS8Sih/0/m1Cusj+KJW28187k/pbhkfoyJWu+wUHYSbyjCgF7L+0gxtKdAIwGlzF
 cN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394598; x=1763999398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=09U62eKe5Yxy/KGkkCFbVC8OGZHmX2FwjAQEb33kAG0=;
 b=vnNih08cc5VbMgtONQaSNXmuGIlzjn2z+QTzBaB1nPVfpERtGnTf79VtyW3CjpOktN
 vI0Wk6WPT69DxAFr0j4QAylJhldo0nYJID6eqGygDcBujRBhpuTpeyLwtovZkz6CHjca
 wn1E2Lm9ovcj3W1sqIM6K1bHr6MjFS3wOKIVFz+S9mggUiTp5k3IzLIhbjo0ogNUmZM2
 0Ep6vK1QUhaBFpHNNOUYtskTJelLcsnsLc2Ry+ptNQYxcfWysdPZzSchfDtfNgueqGQ7
 EY4uIYIpb1cjlrTyXC1X64zpn4KNOzZN10gQ3FyH4f3yofadv3l/BGN5SmthJFgxDGhg
 pXnA==
X-Gm-Message-State: AOJu0YwSqIlKUM12mMhPprW/RD7wvlpd/tYfreY4U/uZEGsKrjdsi3Mo
 7Brlzw+qEnQIXcMTvKVT73YCBKGY2ZK9oh6ze4H3fAgl0TueY08LQES314nIU83sqBY=
X-Gm-Gg: ASbGncto9yLQqbHF9zFabEM7SobZkogST2HV3BYTfIXCESYeMg2fN5bdIlqTMRelVxw
 if6nFIcckxYl0AK2T6DoHwui1Wod6gavyxiR+XKtu0Ccwtzfy2w46UEnqsmhnvwZwf6IXob45o7
 QoEUudFJTXWrFUihRBg2ChEhhaUnwk9mRAHxyhTA5uIOZkeNFToue8QxymacbLq4zwFaEWhWGF2
 Z5b23GFtipdMnsJY2Ar7Hi55e75RlbGpj9d0quf8kABdxnyB9LMHa3Of3KQ0qUNKPJRWsULHrFb
 T/WKDrQhVyythmmGbyHDsUk5/rkyimvZf+nS95Av6cqvDLtIh5ZL7KuPzO57DpTPsGlln6fjDjk
 g5gGB9EPodbugErwUclQcFAQzgeWOfkdCniMlM6aiP8yrot33C+WFaTx2VL3DDlPWoaMnbPg6T3
 pv
X-Google-Smtp-Source: AGHT+IHeGWjzoNgTovmhBOvOqtwWc99UYmCsr94JZKPWwcQt06QNIjd/UnlhvUrbLHPuybrjSbXxCA==
X-Received: by 2002:a05:600c:354b:b0:475:da13:257c with SMTP id
 5b1f17b1804b1-4778fea1239mr140134445e9.27.1763394597970; 
 Mon, 17 Nov 2025 07:49:57 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bd0f761sm117120115e9.4.2025.11.17.07.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 895445FA6C;
 Mon, 17 Nov 2025 15:49:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 12/18] gitlab: add initial ppc64le custom-runner test
Date: Mon, 17 Nov 2025 15:49:41 +0000
Message-ID: <20251117154948.4122164-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

This is a plain configure build but I only run a subset of the tests
until the kinks have been worked out.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251117115523.3993105-13-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
index 00000000000..e088c3b67b7
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
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^staging/'
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


