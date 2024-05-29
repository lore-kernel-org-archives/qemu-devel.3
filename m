Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C20C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLsG-0000eY-8o; Wed, 29 May 2024 12:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLsD-0000d8-Eg
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:58 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLrw-0003Hq-Gu
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:57 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6267643794so113218366b.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998979; x=1717603779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nson0+T9tnXc6Zvr/sqOnJ7uDt+Cm6/3D1pj5zZVt40=;
 b=W1k0r3GuxwOg+4BIZjeX2KUl+rCy+rVhZoytPVhvuNHv6cD++psBdm+8hABzE40A1Y
 MWpEGz+ckLD3FudWFstV+NXmILSd+H3ziEdo29Kb2Zs+0+O3Fkz4miOPtOyfaeCmlmE/
 PQAPJU0Uktn2ZKCRniyRujhpCQKsXHg64fWw8kE3AusRs65guLoE+mCS6R3oAQtQJ4dU
 Zsw0JHLLePX3WPZBPGTnh5VR02oWwcw2BGQhlwAqOlCpZVh69JwVwy1aYvZqtCVFBhLz
 R6kQgjq2QgCsXBeZ3ZeH66GYwBTs7IbYCuXgqbbKtx+1NU4PXI7+5C9ibi3GbTraaTiL
 fcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998979; x=1717603779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nson0+T9tnXc6Zvr/sqOnJ7uDt+Cm6/3D1pj5zZVt40=;
 b=WS1P4OUflXsmpgN8FMC44xkzdRxAaCWQqj1nf10TfEYQNSkZ4thNaimvgsiDgRUivg
 zBkEEUspH0Hhw6ZX9gKgGv6Dnh0DJZRSnlk5xz/mgFv2X6Vv1NWfzLfUZPzVwgvcWfSp
 43DRoHur46aQJg30bk0aMEB2eCMDIJi5NIo1z1Lh5vj6RgCTd4eyPjy1jt1fjurwZTo/
 WVUI6zGfnuzu3VWYX4A6+crCq2evjjAikNFB61PIB/ukTZTizs6tZUhDPJUJx5aAkJx6
 hvE+96gewfcOEsG6YKi9luWIL8Ntna9ZsMpgD7GV40KovPrI5bB0YkFa8h1AYyIs6pbh
 eApg==
X-Gm-Message-State: AOJu0Yx0Wq42EBx/OM/a4RbToytX7O0yh+CpXjkv0J7laDzINn8BCP7G
 SrlLe8pya7ULPeivLU+Zw/kWA0+LZKEkeNiNGbSwxNv1dyw4w61TgHxzAWRnekY=
X-Google-Smtp-Source: AGHT+IH71bqcYho8rYw1aqOFux87AcGqWFm3MWmT4Hy18+ZHM7Kvt7xV+HJzofLFJ+7aW38bzpk+vw==
X-Received: by 2002:a50:cd97:0:b0:578:55f5:197c with SMTP id
 4fb4d7f45d1cf-57855f519b7mr13049931a12.1.1716998979162; 
 Wed, 29 May 2024 09:09:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579d41ef2f2sm4218078a12.41.2024.05.29.09.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A69C5F9F9;
 Wed, 29 May 2024 17:09:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 06/10] docs/ci: clean-up references for consistency
Date: Wed, 29 May 2024 17:09:30 +0100
Message-Id: <20240529160934.982373-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529160934.982373-1-alex.bennee@linaro.org>
References: <20240529160934.982373-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


