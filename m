Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ECBCCA472
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 12:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Im-0002kr-Kw; Tue, 07 Oct 2025 07:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IG-0002Wb-Pr
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:49 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66I4-0001JE-Vl
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso3654875f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838132; x=1760442932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Echx4uRqwkJqs/Dj8ikICL6jA4XnDYHYFfWG4FU7iJ0=;
 b=Uq5m+5G41Wyfs7t7cNxZ46Zl9l9onSR2TPnX2+kT820IfQEkdKN+a4FCemLzUHcCYU
 hlLL0V5QSi7DIuG3hfvMZYVtz4/Zv3lz4f6WcwE2x/Oyk/8DmuROIsnYqhczowgveGu2
 7N2X6pb0LyUgee3NIgPyzpxuk/t0VPYblMJNBYV8ybYvN/52VqhlPHV67jo0v1YVDzPT
 RKpmIqjHDcs4IdfRupQ9UapS7sG2ia20C2bdSPG2CG7yW3zddFxrlgmbHuspbWgwtfwh
 mmLV+w5t/gXKLcj/Y70X7rTY3n08fKNK6xy1LGWBs+zoXmhYbPjsiYgCHNPHJ560pqmM
 VJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838132; x=1760442932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Echx4uRqwkJqs/Dj8ikICL6jA4XnDYHYFfWG4FU7iJ0=;
 b=RiT7xupi/1rhUI5hPi7NEJxo+NfVBfExLM278ApSZCRz7S2H9DBCt1bt4dPOdKhWYb
 crBdRDlNWrvJ+wBJ0wBnxdREpJVmkXMQdXIiacP0zIg7G7P2+uJ10BogqGDbyL3HVzLc
 8Kq7ljvQG36u9ljZ7PuGt1cCbxKo9zIj7dsfky3B8e2gXfvpx42rUdtIYmKWgoIiO8Yo
 VP0JME+Uvtq3sjMvuBv51wLGVkqiQ+S9VzYKd+NawDmMqvc3k5GhauRBo6Frg9mF7SsJ
 48GAmHZjSpijVy395BYCFU31phwbq3GP7w+GcuFb+PSYOICPbriwpGQrckozUEpqGv24
 v6/g==
X-Gm-Message-State: AOJu0YzrqZjuY1kxm7H5oaHhJVIRiM+OBYuSUcQHTRN1iW2sNO+RBJNF
 mdJstxCOaNq5aesq6/NGY9mr9WJOXb/cB9JEgZZgeCFqNi/Q46sgJ+/pj6VK1jze2VtNedZmUYR
 KYlUH
X-Gm-Gg: ASbGncvLQfAZwgcZ+s8VXPYiIm7B4b58jWzQ8go2YdNK2IgaeGJwEFA7z7nsIShwlKx
 c7wVdFE8Jzh4CgfMTFtzTdZukXKacSmFZnPMZN0E5p46od3JF0bcxjQleXRm1282Xh5dvR1j4MI
 33TAeQjFVUad5x042a+13aeDaGxs9OmAkLaIFs6GSKTCGw4LBTBWJdMz8+TKPlPw04qY/VlOpLC
 54k3ylV1PSkCuiwyMJqNTe+lSTXCBFNSxKQzZn9kB8dzZ3b2VANUnzEH3zozSqn5magHyZ1MZyO
 RTv1iecJtW5jjSMqyZC0bRMLFhQQzmizbyjQWiTluelxEZdMXj9pfUQ/KRl8BRcynUMtTyXwsFY
 rc5zCy6FemEgpP7vLJCMBb63rp6s9RlLlcve1uDDhKkgbjXqheFo=
X-Google-Smtp-Source: AGHT+IFDaa57kCZt8PFGY7eiKzO2uSJZh9SwLhgql11nCKTo9OYjrFpvrxQGwImzumwMpWx61PKNdQ==
X-Received: by 2002:a05:6000:18a9:b0:411:3c14:3aa1 with SMTP id
 ffacd0b85a97d-42567139debmr9962416f8f.3.1759838132223; 
 Tue, 07 Oct 2025 04:55:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abe9bsm25445095f8f.22.2025.10.07.04.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 82F5B5FBEE;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 06/17] gitlab: move custom runners to Ubuntu 24.04
Date: Tue,  7 Oct 2025 12:55:14 +0100
Message-ID: <20251007115525.1998643-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20251001170947.2769296-7-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 2d493f70f7a..3eb8216d571 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -29,6 +29,6 @@
       junit: build/meson-logs/*.junit.xml
 
 include:
-  - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml'
-  - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
-  - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
+  - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml'
+  - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml'
+  - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml'
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
similarity index 78%
rename from .gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml
rename to .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
index 8727687e2b4..75029c9187e 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
@@ -1,13 +1,13 @@
-# All ubuntu-22.04 jobs should run successfully in an environment
+# All ubuntu-24.04 jobs should run successfully in an environment
 # setup by the scripts/ci/setup/ubuntu/build-environment.yml task
-# "Install basic packages to build QEMU on Ubuntu 22.04"
+# "Install basic packages to build QEMU on Ubuntu 24.04"
 
-ubuntu-22.04-aarch32-all:
+ubuntu-24.04-aarch32-all:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch32
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
similarity index 89%
rename from .gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
rename to .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index ca2f1404710..d26c7827f45 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -1,13 +1,13 @@
-# All ubuntu-22.04 jobs should run successfully in an environment
+# All ubuntu-24.04 jobs should run successfully in an environment
 # setup by the scripts/ci/setup/ubuntu/build-environment.yml task
-# "Install basic packages to build QEMU on Ubuntu 22.04"
+# "Install basic packages to build QEMU on Ubuntu 24.04"
 
-ubuntu-22.04-aarch64-all-linux-static:
+ubuntu-24.04-aarch64-all-linux-static:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -23,12 +23,12 @@ ubuntu-22.04-aarch64-all-linux-static:
  - make check-tcg
  - make --output-sync -j`nproc --ignore=40` check
 
-ubuntu-22.04-aarch64-all:
+ubuntu-24.04-aarch64-all:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -45,12 +45,12 @@ ubuntu-22.04-aarch64-all:
  - make --output-sync -j`nproc --ignore=40`
  - make --output-sync -j`nproc --ignore=40` check
 
-ubuntu-22.04-aarch64-without-defaults:
+ubuntu-24.04-aarch64-without-defaults:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -67,12 +67,12 @@ ubuntu-22.04-aarch64-without-defaults:
  - make --output-sync -j`nproc --ignore=40`
  - make --output-sync -j`nproc --ignore=40` check
 
-ubuntu-22.04-aarch64-alldbg:
+ubuntu-24.04-aarch64-alldbg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -86,12 +86,12 @@ ubuntu-22.04-aarch64-alldbg:
  - make --output-sync -j`nproc --ignore=40`
  - make --output-sync -j`nproc --ignore=40` check
 
-ubuntu-22.04-aarch64-clang:
+ubuntu-24.04-aarch64-clang:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -108,11 +108,11 @@ ubuntu-22.04-aarch64-clang:
  - make --output-sync -j`nproc --ignore=40`
  - make --output-sync -j`nproc --ignore=40` check
 
-ubuntu-22.04-aarch64-tci:
+ubuntu-24.04-aarch64-tci:
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -128,12 +128,12 @@ ubuntu-22.04-aarch64-tci:
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc --ignore=40`
 
-ubuntu-22.04-aarch64-notcg:
+ubuntu-24.04-aarch64-notcg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - aarch64
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
similarity index 88%
rename from .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
rename to .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
index e62ff1763fa..45dbee17880 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
@@ -1,13 +1,13 @@
-# All ubuntu-22.04 jobs should run successfully in an environment
+# All ubuntu-24.04 jobs should run successfully in an environment
 # setup by the scripts/ci/setup/ubuntu/build-environment.yml task
-# "Install basic packages to build QEMU on Ubuntu 22.04"
+# "Install basic packages to build QEMU on Ubuntu 24.04"
 
-ubuntu-22.04-s390x-all-linux:
+ubuntu-24.04-s390x-all-linux:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -21,12 +21,12 @@ ubuntu-22.04-s390x-all-linux:
  - make --output-sync check-tcg
  - make --output-sync -j`nproc` check
 
-ubuntu-22.04-s390x-all-system:
+ubuntu-24.04-s390x-all-system:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  timeout: 75m
  rules:
@@ -42,12 +42,12 @@ ubuntu-22.04-s390x-all-system:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-22.04-s390x-alldbg:
+ubuntu-24.04-s390x-alldbg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -65,12 +65,12 @@ ubuntu-22.04-s390x-alldbg:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-22.04-s390x-clang:
+ubuntu-24.04-s390x-clang:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -87,11 +87,11 @@ ubuntu-22.04-s390x-clang:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-22.04-s390x-tci:
+ubuntu-24.04-s390x-tci:
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -107,12 +107,12 @@ ubuntu-22.04-s390x-tci:
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
 
-ubuntu-22.04-s390x-notcg:
+ubuntu-24.04-s390x-notcg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_22.04
+ - ubuntu_24.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-- 
2.47.3


