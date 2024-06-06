Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497FDC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBdy-0007gy-Oh; Thu, 06 Jun 2024 07:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdw-0007fA-ML
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:56 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdu-0000sU-EZ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:56 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57a4ea8058bso869963a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674653; x=1718279453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXbv9Kvrz4n4PgZWKu5PXlplVnMVp3AhsbCe/G+6Wew=;
 b=feL/W/TeM5PLvTe3MsR8kk0tZir+KUiAPfhgdv+D6L4TUGuzAarIzh+OuTUAn3rxCR
 gEYZ2Nw72+SARWowQdevdAFwFhp8uIhh00ff5nMgOPpWwIrqKVCudMLNHjtG/lq+YOdz
 rytswRwKUvNSTdjLn6aXStwCUKgnOlOjB9MpTqZJk7JqQCNMRTjIYsd2l5L2uoOQqgn6
 VQ2YaZa1TvCDlKPtEi2O0vgyHeQeSfochk6IjkhnXKYSuc0Jz1ziFSrJgEdEpRKG6tBS
 ETA8MBmZ6yFxEmnWvWfvrqWGdQvqTMgm1IgVVHr0zahBtJM0TmuN4k8btxk1Cler29Bj
 PfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674653; x=1718279453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXbv9Kvrz4n4PgZWKu5PXlplVnMVp3AhsbCe/G+6Wew=;
 b=Ngt351/KoeQ10WUqdXSIEpc5r3aiyv5O4YFYd+jiVV0XUzUNc2FWDzARAMchjvQWBZ
 16Va+FIZ+71z/DyRCmQtqsrycbr5n4Ww4BNQmrzFIXZREruM3WavhdlrVM8c4KmHiiWa
 3I24QTwNLQ3QyhremRa0hexUv1Q4EZSCvDFp75Sj+oZFNGv52lm8rYXeXnqD0qt21yUq
 qspmFL1kvOddcFVOoJArtQsyt5AqdRrHiLR5qFBrBUFf3Xa2zc/TTGzx9wb1WC8YTOhm
 vOVUSakKcouTtojFV2fVMmO5cn8K8RYHOB/B6vjdpsiLV2aAn3/oLamtoXYdwMYLdbMq
 axoA==
X-Gm-Message-State: AOJu0Yw/Iilr8sVB86SPURczTv4pNmoTA3hMOIBkxp/FGqL7rbw/m9lP
 f3DodC98NwQ8jneQXq9/BkdvA5U10GLowKyUvtVWoR3WFFKiJew4Qk/NZtGrPRc=
X-Google-Smtp-Source: AGHT+IEapv0lmt4VBfIrPuv/WFz9IwZFrw0puLX8Dh8ojDDEV38NkNE5DFzbJJP/U1N8LbmcFhgMcQ==
X-Received: by 2002:a50:99c9:0:b0:57a:225c:6acf with SMTP id
 4fb4d7f45d1cf-57a8b67c142mr3648404a12.4.1717674652864; 
 Thu, 06 Jun 2024 04:50:52 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae201d14sm949802a12.63.2024.06.06.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7613B5FA29;
 Thu,  6 Jun 2024 12:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 06/12] docs/ci: clean-up references for consistency
Date: Thu,  6 Jun 2024 12:50:41 +0100
Message-Id: <20240606115047.421045-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240603175328.3823123-7-alex.bennee@linaro.org>

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


