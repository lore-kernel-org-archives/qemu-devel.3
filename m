Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97299D10F5F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 15:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOHS1-0001ap-Sq; Wed, 26 Nov 2025 10:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vOHRw-0001Uk-TQ
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:28:57 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vOHRu-0001II-Ui
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:28:56 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b3c965cc4so526240f8f.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 07:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764170933; x=1764775733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1DGGN972COszVw0XgwjUe95FT8j0aUdcqd6miQIJWy4=;
 b=JuRQr8NvLgNHiOFYZzv22v0g/mZHMzr/Dq1KfPPs1iD9OB1STT7WKiioUzCP61SHPo
 KuKjqmDXmhGSVGg+fvaL+orq3jme/OK6SNrCnGKeEtLkTMx4PUPeeEHiJo4p7EZTXJsI
 9Enowk7cf/ZlI3GR895T6RjVDRZkwznmPjuFJmWxDPiadSsmQ82ccBE4tYkw+6UyLci/
 Y8FydBk82wRc9cTSwGx+2ToclsxTbbD4ooba+utZFBOTOFJ3OMVF/tONJ7HFdVcE6qqA
 2ZZWRWR3AO12PMMqo7MiPnG1fKfigPouVnhLUA6Oeccp56RhP7FK8Ch5VgG6rV94jncZ
 2TVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764170933; x=1764775733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DGGN972COszVw0XgwjUe95FT8j0aUdcqd6miQIJWy4=;
 b=nj73/dFbkNCnRRZGZMajZTBnu0ounLKUnUE8TJfOQn+UD+tUjmD3BrcmzjnDHzGKcc
 rK7oEZkSXkdqzlQafpcXsz9UFkcrz+1hrpGigj3XVZx0sY0wCP7jmnK0po/mo+jsT0g5
 nxJ48me6dyMfxh8yGwOkKlSQ/dlvk3/iDegMOJNNzyRBLqcV1BkrMsf2Bx3mJwmfDkBO
 qlgn0MhjXAaMghlHrDvR1fwPNPQLoiRubr7k/pORND+t9+Ysq5a4+qQYn22fvy/7b05w
 LUQ8InfJoUPcSMT+9HK53qSxKIzNzW892dmbqWkSyk0uqa6QPNswb3S+Bgy9WJ0YIIpA
 llVg==
X-Gm-Message-State: AOJu0YyoIxxPfUyUtrjSvJS2WyHyv63s/ScHQDczIeRYKeshyeQtgppt
 wbBZm0i84n4Yg/NJMJ7vSIc1MS4zVgxQgD2T0POY/X4eErl40JuQJUdKAiCSTrJ7e+M=
X-Gm-Gg: ASbGncvw9eaOlWzXjsSIAEAsG3oFs74o31aZiOy47vE7Ksdq2p6QinpBIjsqYTjBj0a
 BrjMDMYtdNhWM7hcDnYgC+sykh+sid/TGZAgKYXRLoxBuUycv2FWCp4myHzA/K+VKyTF+Zrqz7W
 xl9DLnk3F6ut+tndd0Kc5ObOJ8GWfnVuCbpMd4UInkoZ71xdXMTtvzqOg+4a6ZLtNP+ZhSp2t/G
 mdxkAipouAxxdTw7di13Sp2NP4XyBpRu9TNK1lkgaxwXh39OkyZljJPY8O0ejrCmmFSPnXZglNy
 WqRW7RlPeJUTNadludTJDZ3LnKXNWCOGvxXwsdw7Kc0V5kFyQAknwOK3Hgnh5Zg4+CKDPMx/q87
 dzlmAGtJlTx0HlnzNaMn5KDltAM17Cuuiz/767WZLSdXQ6wbXY8bZbs/I22TDg/6d9p5KufX6Z3
 p3Wu0VROuEp2Y=
X-Google-Smtp-Source: AGHT+IFNiqO9OCy6UtHOIggtdS1UTDiBtYaH7EhSDKeLcbh42u3gI3CgKQqqmJMIhJlUz/FeX4T2qA==
X-Received: by 2002:a5d:5f88:0:b0:42b:3383:bcf4 with SMTP id
 ffacd0b85a97d-42cba63b5bfmr28990151f8f.1.1764170932656; 
 Wed, 26 Nov 2025 07:28:52 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e432sm40376611f8f.9.2025.11.26.07.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 07:28:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C691B6020E;
 Wed, 26 Nov 2025 15:28:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH] tests/tcg: honour the available QEMU binaries when
 running check-tcg
Date: Wed, 26 Nov 2025 15:28:48 +0000
Message-ID: <20251126152848.2200629-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Currently configure can identify all the targets that have
cross-compilers available from the supplied target-list. By default
this is the default_target_list which is all possible targets we can
build.

At the same time the target list passed to meson is filtered down
depending on various factors including not building 64 bit targets on
32 bit hosts. As a result make check-tcg will erroneously attempt to
run tests for which we haven't built a QEMU.

Solve this by filtering the final list of TCG_TEST_TARGETS based on
what actually was configured by meson. Rename the variable that
configure spits out to TCG_TESTS_WITH_COMPILERS for clarity and to
avoid larger churn in the Makefile.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure              | 6 +++---
 tests/Makefile.include | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index a2f66f7ff9c..82cace1bc95 100755
--- a/configure
+++ b/configure
@@ -1801,7 +1801,7 @@ if test "$plugins" = "yes" ; then
 fi
 echo "PYTHON=$python" >> tests/tcg/$config_host_mak
 
-tcg_tests_targets=
+tcg_tests_with_compilers=
 for target in $target_list; do
   arch=${target%%-*}
 
@@ -1852,12 +1852,12 @@ for target in $target_list; do
       fi
 
       echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
-      tcg_tests_targets="$tcg_tests_targets $target"
+      tcg_tests_with_compilers="$tcg_tests_with_compilers $target"
   fi
 done
 
 if test "$tcg" = "enabled"; then
-    echo "TCG_TESTS_TARGETS=$tcg_tests_targets" >> $config_host_mak
+    echo "TCG_TESTS_WITH_COMPILERS=$tcg_tests_with_compilers" >> $config_host_mak
 fi
 
 if test "$skip_meson" = no; then
diff --git a/tests/Makefile.include b/tests/Makefile.include
index d4dfbf3716d..7728098981d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -37,6 +37,15 @@ export SRC_PATH
 
 SPEED = quick
 
+
+# TCG_TESTS_WITH_COMPILERS represents the test targets we have cross compiler
+# support for, CONFIGURED_TEST_TARGETS it what meson has finally
+# configured having rejected stuff we can't build.
+CONFIGURED_TCG_TARGETS=$(patsubst %-config-target.h, %, $(wildcard *-config-target.h))
+
+# This is the intersection of what tests we can build and is configured
+TCG_TESTS_TARGETS=$(filter $(CONFIGURED_TCG_TARGETS), $(TCG_TESTS_WITH_COMPILERS))
+
 # Per guest TCG tests
 BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TCG_TESTS_TARGETS))
 CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(TCG_TESTS_TARGETS))
-- 
2.47.3


