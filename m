Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FCDC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0GP-0002u4-4V; Tue, 12 Mar 2024 07:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GO-0002tU-17
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:44 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GF-0000gj-NC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:42 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-513a81b717cso2465756e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710242733; x=1710847533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFd08eLrd4gGZuM0kNWdC4d2ia0nfqfy86pon6xWh1k=;
 b=bcwW9czWa5T5iUu2nDdG7Zm3o0UfMGB0hTCdWvzl1R6UrHr4htjsgifOLKwTMHctIa
 ho83jp0k/qKP6CzrU3k5rLWaITJGu8iepNEJQzYgUWPV+jhNvR2plOOL7pmyPd4PB+PJ
 6X84KFd0SdXDtFpsM9qmerh7Agw91RYhahH2tTLzECGmjaofnLBpPNn5np2+9fPWC2V9
 NMA3Q7UgL2o3isJ8wgDISd6ZW3w0Y5oU6qAIzD3dc2hCJZs2bxnWMzh4AbBhwjjJubcm
 /CvQ1P0lt/rD1wGsD5xvrA1nO0uTrCMLGoN3szhiPPQH3hf3qX3A/njChYLBeYmIdwE8
 rLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710242733; x=1710847533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFd08eLrd4gGZuM0kNWdC4d2ia0nfqfy86pon6xWh1k=;
 b=tk6cpcTjtlhk0funQXJKvRxf+KI2hpI/+6w1Mlyj73gCmHEcQVaIsLDVEj9DJPAgzx
 /eJB3wZoMVnDfPwzBxk3H6PgulE33oMRYxmGv/Xla6ufbCqM0IVFu5IPWm6T6ICmPCzs
 ORUhkDAo2rhEAcPiaj4T3aClXCi/ZPP/B/seD/PYB0eYOQPUdcwI2j/j/JT/19C8tWIs
 VomF8SAEIvVNaRNPN86Lc6OMXu7hEtah/4tvcJewZ0Vl71csbZZR4EIpORSVKFufjd0P
 7XYqJ4lAYhHqXYPQNYy0YbitnxWXvfFwAFZiLro2ED+mPyHBiKonpDJxExRzYEN2jgSK
 +UHQ==
X-Gm-Message-State: AOJu0YyT/AoBixVUOdrnYmQfAh5pKdg6QzwV3QHNShCLJjwf283spi+1
 hOPfa31N+S4PWCV2pgij9kl9a4rUD5xqb0lYwWDD6zJo8bSRvqim2Nr/Ln2U0u8=
X-Google-Smtp-Source: AGHT+IFC6Fh3LNkcZ9kqV5GEWUtPFb95TYfhzKiyewiw/UssDJV+5/k+C6Fe4iuCammu+eoJs5T60Q==
X-Received: by 2002:a05:6512:b94:b0:513:a833:cdaa with SMTP id
 b20-20020a0565120b9400b00513a833cdaamr4849827lfv.69.1710242733529; 
 Tue, 12 Mar 2024 04:25:33 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j1-20020a05600c1c0100b00412ee7d65a6sm12202228wms.6.2024.03.12.04.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:25:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF3D45F8D4;
 Tue, 12 Mar 2024 11:25:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PULL 1/8] gitlab: aggressively avoid extra GIT data
Date: Tue, 12 Mar 2024 11:25:25 +0000
Message-Id: <20240312112532.1558319-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312112532.1558319-1-alex.bennee@linaro.org>
References: <20240312112532.1558319-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Windows build (git too old?) and the migration legacy test where we
build an older QEMU alongside the main one.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


