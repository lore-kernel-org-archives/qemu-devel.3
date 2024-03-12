Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A488C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5WZ-000258-Hh; Tue, 12 Mar 2024 13:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk5UG-0005xr-Re
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:00:35 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk5UC-0008Jn-H2
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:00:23 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d208be133bso65234561fa.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710262818; x=1710867618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D/uNmK++/ud7f+ngB6fiXfdhnqeNrD4IIe9hghiHPPk=;
 b=WmYFHUY6jzw4kZoE+Q0r9hg4HYTv90gx+w5tTq3c5FqkfzuYCR18MeDAwQdrsVTI+P
 8qeNUMklu4uylb7u1mFRWYashBFTivZ+3yxzPIcoNSEVoCvvFJkQgkPV1K7y5mmHxg1E
 d6khbT3a1QkJ/LBgUM+DpLjOgisUUV5tz+FHiOdskHFYuY/t+XwkyIz9uq/1gCajObna
 k5+4cz36x00NZbAbF0A01MF7LWRQrCeSWxsxj7sOgeeLoAdJ6f+8BY5HDE5kcc3Gxec8
 7VdVgjJaAn0FUOldwr8BV17M24dz7dUDCf0f1a9hOUpMDr3LIGqKUhcPtOPPWFTMehgO
 JiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262818; x=1710867618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D/uNmK++/ud7f+ngB6fiXfdhnqeNrD4IIe9hghiHPPk=;
 b=s/fmtvQmN3ww+XMzmXSIqZDx1vBN8KFGAFz1o/Vo+E7Toj1aUXIsxZ7z3gK2zi64Kw
 Tu9y+9T4wYosxItKnj05hl3t44PrEglX+WZw1ykFajyRPVlgfXPuALm3AmoCpSnPjyyW
 UiQ5Y0La9X3AxliARvpY0VowgiNnxQ08+7ZRGMNUrjk+Bci9etantWLXo9ZPNKASZSma
 BZneU4pcu9qr4GZH77DjiKijwf2XB6og4zVn5n3VVmf21iIytxklbH/QwVYACfY4lxLS
 oWBj8s8k9eveG0Uijz/j9irQXU9mTJwBjUxDWBeWyblLkri8Bkl5Q605cs71Lozom/Sq
 SHqQ==
X-Gm-Message-State: AOJu0YwfvohA7M9kU/SmNvJGYE7P572mQLqwu3rLZeSdAdnbPOP5oBMe
 LpASSl5exZynNB/O6T3RBls2hBkQncDPNqBuEF/RF+1zacKZh5Pf6MgrFCJCxeA=
X-Google-Smtp-Source: AGHT+IFDvjuetJIW2htdTjG1Mw0v+5yWjl056nZ8maZa3fQe8R5LysxvlZ0O65wF0tCF7kQ0E1gduQ==
X-Received: by 2002:a2e:9550:0:b0:2d4:2faa:d93 with SMTP id
 t16-20020a2e9550000000b002d42faa0d93mr5159573ljh.45.1710262818085; 
 Tue, 12 Mar 2024 10:00:18 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x21-20020aa7d395000000b00567fa27e75fsm4079742edq.32.2024.03.12.10.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 164FC5F7D6;
 Tue, 12 Mar 2024 17:00:17 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2] gitlab: aggressively avoid extra GIT data
Date: Tue, 12 Mar 2024 17:00:11 +0000
Message-Id: <20240312170011.1688444-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
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

This avoids fetching blobs and tree references for branches we are not
going to worry about. Also skip tag references which are similarly not
useful and keep the default --prune. This keeps the .git data to
around 100M rather than the ~400M even a shallow clone takes.

So we can check the savings we also run a quick du while setting up
the build.

We also have to have special settings of GIT_FETCH_EXTRA_FLAGS for the
Windows build, the migration legacy test and the custom runners. In
the case of the custom runners we also move the free floating variable
to the runner template.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - make custom runners follow the legacy options
---
 .gitlab-ci.d/base.yml               | 4 ++++
 .gitlab-ci.d/buildtest-template.yml | 1 +
 .gitlab-ci.d/buildtest.yml          | 2 ++
 .gitlab-ci.d/custom-runners.yml     | 5 +++--
 .gitlab-ci.d/windows.yml            | 2 ++
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 2dd8a9b57c..bf3d8efab6 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -24,6 +24,10 @@ variables:
     # Each script line from will be in a collapsible section in the job output
     # and show the duration of each line.
     FF_SCRIPT_SECTIONS: 1
+    # The project has a fairly fat GIT repo so we try and avoid bringing in things
+    # we don't need. The --filter options avoid blobs and tree references we aren't going to use
+    # and we also avoid fetching tags.
+    GIT_FETCH_EXTRA_FLAGS: --filter=blob:none --filter=tree:0 --no-tags --prune --quiet
 
   interruptible: true
 
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 4fbfeb6667..22045add80 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -14,6 +14,7 @@
     - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
     - export CCACHE_MAXSIZE="500M"
     - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
+    - du -sh .git
     - mkdir build
     - cd build
     - ccache --zero-stats
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index c7d92fc301..cfdff175c3 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -187,6 +187,8 @@ build-previous-qemu:
   variables:
     IMAGE: opensuse-leap
     TARGETS: x86_64-softmmu aarch64-softmmu
+    # Override the default flags as we need more to grab the old version
+    GIT_FETCH_EXTRA_FLAGS: --prune --quiet
   before_script:
     - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
     - git remote add upstream https://gitlab.com/qemu-project/qemu
diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 8e5b9500f4..a0e79acd39 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -10,13 +10,14 @@
 # gitlab-runner.  To avoid problems that gitlab-runner can cause while
 # reusing the GIT repository, let's enable the clone strategy, which
 # guarantees a fresh repository on each job run.
-variables:
-  GIT_STRATEGY: clone
 
 # All custom runners can extend this template to upload the testlog
 # data as an artifact and also feed the junit report
 .custom_runner_template:
   extends: .base_job_template
+  variables:
+    GIT_STRATEGY: clone
+    GIT_FETCH_EXTRA_FLAGS: --no-tags --prune --quiet
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
     expire_in: 7 days
diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index f116b8012d..94834269ec 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -28,6 +28,8 @@ msys2-64bit:
     # qTests don't run successfully with "--without-default-devices",
     # so let's exclude the qtests from CI for now.
     TEST_ARGS: --no-suite qtest
+    # The Windows git is a bit older so override the default
+    GIT_FETCH_EXTRA_FLAGS: --no-tags --prune --quiet
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
     expire_in: 7 days
-- 
2.39.2


