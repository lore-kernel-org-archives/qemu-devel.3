Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8947C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBsb-0007A1-Ra; Mon, 03 Jun 2024 13:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsI-0006zc-Ui
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:40 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsF-00008c-2j
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35dc9cef36dso3806445f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717437212; x=1718042012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwO5Xk/JBsiCE4LMX0EusCkO9JTloZRZc0GlJ2FQNxg=;
 b=S6JV52Q4deEVTgCgnFc0zBWfQA32ss4/k6GSiy5q4dkeBN4nSq07UOqhEMZZoZBgd2
 QgxCWPDGS23/izh0EakrOUf2/I52ZAYn5vyEhDxQMYUIwR51FxUM2t2IeohvlfZmWWbx
 XU6VQGMFhg+4QuKma7faYE50nZ+u7afJjXIuvIlk641mxQkyaKTSsSd19stLmuquGsUY
 n/fHC1lQbExp0lpeYIuto8wjluyzgZdRHN+2IkQGRYbK4Vnfgy0jr7MomSoIziAvKcHx
 iF+4oFnHJfSxMxqFvHO38YbUqjc9M8LO7NMoV+qeRR5HZonfcDJzz1Q0vyvm1281TP9S
 BmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437212; x=1718042012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwO5Xk/JBsiCE4LMX0EusCkO9JTloZRZc0GlJ2FQNxg=;
 b=CALDIrlO/fJpgDQrow3eoeP5M4BkC/PiuHMGIw84wYB680uv+4E1hfyZEQ4rcCfm+A
 fElyg9dTcUvN5g9392fmo6CiCM+xB+x2PzogpTtH72PQ+dsIVfiqoq1wXZi4XtaMhIV2
 SltIufNQalIvNWwt0lbe+r9vTRmjm/zM1FRWr29NWm/9WPfkBZj+ppO2ybnx5u2MDeEn
 NO9IGAIEx6MtbUROupIIk6sqfF1WHkXf+ScR416PCxYfSgAJwBT/AxeTVEzzA+yoCXO8
 +wHDWzxHo1WP3bvaJ4ViSkX0kApQnV9zpy0PqJGBisz/2m/BIvJEKYqX824oiSxa4Vtk
 m5xA==
X-Gm-Message-State: AOJu0YywnQ/7M5sFguzLPeoSi0g0Q/AL+KX+7Lgpp/0epblWpCfIA04P
 ER71LDvIBHJl9oAmYXxMwBy6ouUuHdQRlATeVSdIMvWhGeNpWpXEAgCJkCTUQlI=
X-Google-Smtp-Source: AGHT+IF1PCBb2CO9/Ha0W0kFzU945k4om4tTwmp9tb4scoZqYEgQk/JoA5gdXNQKPLn7IBQz8Mqlwg==
X-Received: by 2002:a05:6000:1282:b0:354:f944:11de with SMTP id
 ffacd0b85a97d-35e0f2869f4mr6834901f8f.28.1717437212642; 
 Mon, 03 Jun 2024 10:53:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064bbb1sm9295671f8f.101.2024.06.03.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C8CB5F9FB;
 Mon,  3 Jun 2024 18:53:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH v3 06/12] docs/ci: clean-up references for consistency
Date: Mon,  3 Jun 2024 18:53:22 +0100
Message-Id: <20240603175328.3823123-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603175328.3823123-1-alex.bennee@linaro.org>
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Document we have split up build-environment by distro and update the
references that exist in the code base to be correct.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240529160934.982373-7-alex.bennee@linaro.org>
---
 docs/devel/ci-runners.rst.inc                       | 13 ++++++-------
 .../custom-runners/ubuntu-22.04-aarch32.yml         |  2 +-
 .../custom-runners/ubuntu-22.04-aarch64.yml         |  2 +-
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml  |  2 +-
 scripts/ci/setup/{ => ubuntu}/build-environment.yml |  0
 5 files changed, 9 insertions(+), 10 deletions(-)
 rename scripts/ci/setup/{ => ubuntu}/build-environment.yml (100%)

diff --git a/docs/devel/ci-runners.rst.inc b/docs/devel/ci-runners.rst.inc
index 7817001fb2..67b23d3719 100644
--- a/docs/devel/ci-runners.rst.inc
+++ b/docs/devel/ci-runners.rst.inc
@@ -41,19 +41,18 @@ those hosts.  This would look like::
 Build environment
 ~~~~~~~~~~~~~~~~~
 
-The ``scripts/ci/setup/build-environment.yml`` Ansible playbook will
-set up machines with the environment needed to perform builds and run
-QEMU tests.  This playbook consists on the installation of various
-required packages (and a general package update while at it).  It
-currently covers a number of different Linux distributions, but it can
-be expanded to cover other systems.
+The ``scripts/ci/setup/$DISTRO/build-environment.yml`` Ansible
+playbook will set up machines with the environment needed to perform
+builds and run QEMU tests. This playbook consists on the installation
+of various required packages (and a general package update while at
+it).
 
 The minimum required version of Ansible successfully tested in this
 playbook is 2.8.0 (a version check is embedded within the playbook
 itself).  To run the playbook, execute::
 
   cd scripts/ci/setup
-  ansible-playbook -i inventory build-environment.yml
+  ansible-playbook -i inventory $DISTRO/build-environment.yml
 
 Please note that most of the tasks in the playbook require superuser
 privileges, such as those from the ``root`` account or those obtained
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml
index b8a0d75162..8727687e2b 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml
@@ -1,5 +1,5 @@
 # All ubuntu-22.04 jobs should run successfully in an environment
-# setup by the scripts/ci/setup/qemu/build-environment.yml task
+# setup by the scripts/ci/setup/ubuntu/build-environment.yml task
 # "Install basic packages to build QEMU on Ubuntu 22.04"
 
 ubuntu-22.04-aarch32-all:
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
index 374b0956c3..263a3c2140 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
@@ -1,5 +1,5 @@
 # All ubuntu-22.04 jobs should run successfully in an environment
-# setup by the scripts/ci/setup/qemu/build-environment.yml task
+# setup by the scripts/ci/setup/ubuntu/build-environment.yml task
 # "Install basic packages to build QEMU on Ubuntu 22.04"
 
 ubuntu-22.04-aarch64-all-linux-static:
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index 25935048e2..69ddd3e7d5 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -1,5 +1,5 @@
 # All ubuntu-22.04 jobs should run successfully in an environment
-# setup by the scripts/ci/setup/build-environment.yml task
+# setup by the scripts/ci/setup/ubuntu/build-environment.yml task
 # "Install basic packages to build QEMU on Ubuntu 22.04"
 
 ubuntu-22.04-s390x-all-linux:
diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/ubuntu/build-environment.yml
similarity index 100%
rename from scripts/ci/setup/build-environment.yml
rename to scripts/ci/setup/ubuntu/build-environment.yml
-- 
2.39.2


