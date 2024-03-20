Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B754CC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyZY-0002ze-So; Wed, 20 Mar 2024 12:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZX-0002yk-A5
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:47 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZU-00035J-Cl
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:47 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5688eaf1165so10101900a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710951222; x=1711556022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfjqk3C9XKUuY3mZ0blhMLx9KnHWjtdF/kXD7veoPg0=;
 b=NOII1P754miSGkxqhcGaMg3a7KgpYSjkmzibDG9tmgdxLVqZVlCuhBRYhh2o/FhPvE
 MXX9EoTRgt/zr5x6WHKtRq+kI1VL20nNthtlP8HmwZt+0w2QXb8L//ueu4qpN3o7pHi7
 TxKWJY7AqahWgwOz3cDH/Et8gmF9PsD2K8ElMfTXZDF63tJsUDpxucE7V4pzCCuvT/f7
 dAaD+oxaL5lGMjxoMtm9odkfkJnAwY6ADCpwscLMy3TQfLczvB3vVl5B9JmguQ4YiyZT
 A8RNgDBNgMu4YBErlT1/YHz+FePhsEbkmra0GcE1WkKe1ET7hTb/NezNj5FSxoDv8Enx
 BTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710951222; x=1711556022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfjqk3C9XKUuY3mZ0blhMLx9KnHWjtdF/kXD7veoPg0=;
 b=qlu9KtkdLVLUxgMIEmXJBJk1PvlBwKbsSLT7KBA30bBl70wq8q340jZGfCC+gN5anc
 +SurYr6ZtoVSwOQ3DSKSlx3K6JlTi/hFV+TkYyDYzF3WT5Ev8ODqjMF9x8sc7HXUt7vf
 qnxnS/nBasHlr+zX388S2j2BK0UNyAwEQqqk9Vyooosbxjgf0tUqDGFPzxpIuJ6qBDoV
 sE9LjlbJa2VpDSN6/yiZT34Yy+m6ODrs3MhFhWwmUFNc2WY05xHGfUQITvAw3xPZyIun
 ryaAovqbhXORMmRB3fd4UPMDWL+ZFjGyT39OUGxlPwPBj3RTO2hfvbTi+BOjhaj820Uh
 uslA==
X-Gm-Message-State: AOJu0YxdxAZcvVxJIdHCoquvYXhGRYBmCEjk8/md7gPQCp5+DovCz3mj
 1GEhP9NYx16bGwnFJ9BL9cwdDBTMJDqu8dJwBf49atBgcGcOtKeum9/APdpVF5c=
X-Google-Smtp-Source: AGHT+IERvIWnIsCuvD8X1JXkFwQ8YgbQzBIrkGHDfl+Wc47HJGz8o/VZWEc/1TACkcE9g46hB6rvcg==
X-Received: by 2002:a05:6402:528a:b0:56b:863c:2c92 with SMTP id
 en10-20020a056402528a00b0056b863c2c92mr4166907edb.34.1710951221848; 
 Wed, 20 Mar 2024 09:13:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 co24-20020a0564020c1800b00568c613570dsm4682613edb.79.2024.03.20.09.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 09:13:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 177FD5F8B0;
 Wed, 20 Mar 2024 16:13:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PULL 1/5] gitlab: aggressively avoid extra GIT data
Date: Wed, 20 Mar 2024 16:13:36 +0000
Message-Id: <20240320161340.391798-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320161340.391798-1-alex.bennee@linaro.org>
References: <20240320161340.391798-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240312170011.1688444-1-alex.bennee@linaro.org>

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


