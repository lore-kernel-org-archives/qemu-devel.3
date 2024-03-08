Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4904C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribpI-0000wu-1l; Fri, 08 Mar 2024 10:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ribpF-0000qu-Lq
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:07:57 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ribpC-0000sR-QX
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:07:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412e6ba32easo6924045e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709910473; x=1710515273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DXkqpQ2d+nXcY4e+AOIltUbvXiT1OvsvmOZuFvpyCvA=;
 b=NVkNYpdQcRWh++rJDaqXkRVvTptyPFVnZKrqgmsPCedfc88zaWYB9TyayBL0l6g93W
 TY8fdtksTk/tC1HIJv75UWOMbVxENidwx8Ava6gyL2TkxUzLnhyxh0UnjynmIaeM7XVt
 MxF6cRlNNakXESq8ojThM1uy+Te+aUsHAV/+cCQef+5qa5WhRy+XoOBl/5hhb4zLchAi
 Dqa9VQUm1nDrf7RRvXuKLe5n78LL/13CJGsHcvxoX7PqqCMmHq7T+Y6UEWgsVXo1sEfz
 7aqi8KkcoaHDuBMPUpMELQvkxPHw18sMuaekW3/9TtJkHXSKjXF/zLAIopd5eY5Vx+do
 Ky1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709910473; x=1710515273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DXkqpQ2d+nXcY4e+AOIltUbvXiT1OvsvmOZuFvpyCvA=;
 b=ZMh2RaC/UARQ2UGlyp3qt6DGmm6J7i9ETn/69p2DhCjTS+9GijcE67aqC8ESt6MLUb
 kQpezyfglrYODJ8NlhsAE6KDqJodc3ciq7ZPfwL4AyIz+q6raOV2U8cf/fQwdPlplQle
 tR1bTu42jvYLkt0HXbLx0P0Tdn8UQk9FnmCjUSWeFwyAa5WaUcAIYcblWlKptU02J4Y6
 ATxzUTumWxppAGSDvrJrzxriqhGjTY+8TWtOcZlUkbTdgYBcVMGG7EATkvULwQqzwPj9
 yLxgGx8cLlI1A1BHzsDbFl0SGeocdu70GfoULt0/oB9gcvQF+/A4vnzK1pdM9fF843tj
 58hw==
X-Gm-Message-State: AOJu0YwD3AZ+sRyfheGz8prwc9UVpLd0PrCQxUKzSiWpQp/SHj5eYyRP
 hlyoP9Fe/493ewVAnXZoG7xAUYz6l3hZsN7vZvnez3Kpc2QdFBu4eETt3CfxqZ4=
X-Google-Smtp-Source: AGHT+IF5cbysXBuu65fq32gdCih+C/ghQUW3kuOOAdJ3TM0rwyuj3dIy+wELybNOyPK9fvXUDHc2CA==
X-Received: by 2002:adf:a34a:0:b0:33e:7b09:8a66 with SMTP id
 d10-20020adfa34a000000b0033e7b098a66mr305155wrb.28.1709910473069; 
 Fri, 08 Mar 2024 07:07:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bw1-20020a0560001f8100b0033d6bc17d0esm23686459wrb.74.2024.03.08.07.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:07:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 36BD15F753;
 Fri,  8 Mar 2024 15:07:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [RFC PATCH] gitlab: aggressively avoid extra GIT data
Date: Fri,  8 Mar 2024 15:07:48 +0000
Message-Id: <20240308150748.894699-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
Windows build (git too old?) and the migration legacy test where we
build an older QEMU alongside the main one.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/base.yml               | 4 ++++
 .gitlab-ci.d/buildtest-template.yml | 1 +
 .gitlab-ci.d/buildtest.yml          | 2 ++
 .gitlab-ci.d/windows.yml            | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index ef173a34e6..7cb800fc3b 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -24,6 +24,10 @@ variables:
     # Each script line from will be in a collapsible section in the job output
     # and show the duration of each line.
     FF_SCRIPT_SECTIONS: 1
+    # The project has a fairly fat GIT repo so we try and avoid bringing in things
+    # we don't need. The --filter options avoid blobs and tree references we aren't going to use
+    # and we also avoid fetching tags.
+    GIT_FETCH_EXTRA_FLAGS: --filter=blob:none --filter=tree:0 --no-tags --prune
 
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
index a1c030337b..def469a9dc 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -187,6 +187,8 @@ build-previous-qemu:
   variables:
     IMAGE: opensuse-leap
     TARGETS: x86_64-softmmu aarch64-softmmu
+    # Override the default flags as we need more to grab the old version
+    GIT_FETCH_EXTRA_FLAGS: --prune
   before_script:
     - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
     - git remote add upstream https://gitlab.com/qemu-project/qemu
diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index f116b8012d..f9da745042 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -28,6 +28,8 @@ msys2-64bit:
     # qTests don't run successfully with "--without-default-devices",
     # so let's exclude the qtests from CI for now.
     TEST_ARGS: --no-suite qtest
+    # The Windows git is a bit older so override the default
+    GIT_FETCH_EXTRA_FLAGS: --no-tags --prune
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
     expire_in: 7 days
-- 
2.39.2


