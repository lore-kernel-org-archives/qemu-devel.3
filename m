Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECD0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 15:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Nfy-0001qm-KR; Fri, 26 Apr 2024 11:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s0Nft-0001mm-8w
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 11:39:45 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s0Nfq-0003nB-KH
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 11:39:44 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a559b919303so298168966b.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714145980; x=1714750780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQVnWso8WX9bz1gOeDbAO6szOCXlSFLVqMyjg5rVeaw=;
 b=Ze8/OlkpJC5pNgAXu4Iwb2n87Z3t2Ap5EmFmTwaJoZjzIAZ6LoEFXPHDb9Lr278KYB
 Y0L134ieafv8IWbKv/dosRFe4g4MtrGoOvZDngDM0MXRJgmdN6TfDsCcFoQha6p9DI0t
 lDAFPwhj8bwPmFLq55yZEZa/0IHdsmY1cZZsUl7qqGY303pPTWD3pn+wtitI68j6wQbe
 RrTrgYxZbGW+UOvCB4yrPr9I0HElgLJJOZg8E9kMxQWgSkgr5fW/CjfNXTyo/MeXgbGl
 x8nLexUeIDC8Ofr8Y9+HXe9XJyJ0qE/zX403RkDXQWk1nHEsNID23dfnrwGvrNgxchgz
 pR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714145980; x=1714750780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQVnWso8WX9bz1gOeDbAO6szOCXlSFLVqMyjg5rVeaw=;
 b=U3Xg+eKJBMgJdIKATCFTDni5y3qdijKG1M+SMYHnLljudmjNwzPYngxi9nMDqdEKCB
 p9cscJf6Lft4+C5OTlQKNbofyUbs9LROHuNk5RaOWvmeANTtrnfGu4WhdqpSWbnBQIYw
 CvbkP7Rv5OXBNg7+HpvnOReInQIZKxIJJJOX9ZVz/OjahSUzcNxlPV3DVBLMwXRidzfv
 dBAIWWvgIfBTocCT/bZQcNdJi89AVRVqJpk2up+1/peWNoYq8N9Cj8y++F820dsuFwNk
 8DbqMJf0Ep5wG5JN/1HYisBtraV70MhvTLVTNRbVX4uaFgRz7rmrgMZCcKmGov10lYY2
 dBIw==
X-Gm-Message-State: AOJu0Ywj7V0Z3ZXVlHo0Y9K5LoiwqFTPg4yd399QZ4f7aaBR2beNVIFQ
 iJK+eojFts1AUTX1I7HRwJMMqcQ5RMG6H1BJy2Lr/GPD7Fbo6xjEKiCLTgMGJCc=
X-Google-Smtp-Source: AGHT+IEMyD2P1lpAJ3X+JkD3KFAIJt1AH9wyJZYLRbGjxiCpenmkej3vs4PybaxLaf/MG92cKXkzKA==
X-Received: by 2002:a17:906:3bd5:b0:a55:3488:f730 with SMTP id
 v21-20020a1709063bd500b00a553488f730mr2243165ejf.31.1714145980106; 
 Fri, 26 Apr 2024 08:39:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u14-20020a1709063b8e00b00a58de9434ecsm33716ejf.108.2024.04.26.08.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 08:39:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C85E5F94B;
 Fri, 26 Apr 2024 16:39:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Joel Stanley <joel@jms.id.au>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/3] gitlab: migrate the s390x custom machine to 22.04
Date: Fri, 26 Apr 2024 16:39:37 +0100
Message-Id: <20240426153938.1707723-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426153938.1707723-1-alex.bennee@linaro.org>
References: <20240426153938.1707723-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

20.04 is dead (from QEMU's point of view), long live 22.04!

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/custom-runners.yml               |  2 +-
 ...20.04-s390x.yml => ubuntu-22.04-s390x.yml} | 28 +++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)
 rename .gitlab-ci.d/custom-runners/{ubuntu-20.04-s390x.yml => ubuntu-22.04-s390x.yml} (88%)

diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index a0e79acd39..29e52df283 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -29,7 +29,7 @@
       junit: build/meson-logs/testlog.junit.xml
 
 include:
-  - local: '/.gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml'
+  - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
   - local: '/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml'
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
similarity index 88%
rename from .gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml
rename to .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index cdae6c5212..85e2809573 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -1,13 +1,13 @@
-# All ubuntu-20.04 jobs should run successfully in an environment
+# All ubuntu-22.04 jobs should run successfully in an environment
 # setup by the scripts/ci/setup/build-environment.yml task
-# "Install basic packages to build QEMU on Ubuntu 20.04/20.04"
+# "Install basic packages to build QEMU on Ubuntu 22.04"
 
-ubuntu-20.04-s390x-all-linux-static:
+ubuntu-22.04-s390x-all-linux-static:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -23,12 +23,12 @@ ubuntu-20.04-s390x-all-linux-static:
  - make --output-sync check-tcg
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-all:
+ubuntu-22.04-s390x-all:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  timeout: 75m
  rules:
@@ -42,12 +42,12 @@ ubuntu-20.04-s390x-all:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-alldbg:
+ubuntu-22.04-s390x-alldbg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -65,12 +65,12 @@ ubuntu-20.04-s390x-alldbg:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-clang:
+ubuntu-22.04-s390x-clang:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -87,11 +87,11 @@ ubuntu-20.04-s390x-clang:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-tci:
+ubuntu-22.04-s390x-tci:
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -107,12 +107,12 @@ ubuntu-20.04-s390x-tci:
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
 
-ubuntu-20.04-s390x-notcg:
+ubuntu-22.04-s390x-notcg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-- 
2.39.2


