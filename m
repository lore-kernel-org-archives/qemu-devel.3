Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80157C87FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 03:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujquS-0007xX-UC; Wed, 06 Aug 2025 23:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujquN-0007qw-LQ
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:03:12 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujqu5-0002P1-W6
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:02:57 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso578767b3a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 20:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754535772; x=1755140572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqZKDhwtkLC/tHYUZBs2eggDgvqJxQq19A0deinJjBI=;
 b=PvLDHskurSKK7t0jVK+wv5pYDwNPnU2a9c3TzKjeI10bzaBjPm9of/MwuKE9JsYTVG
 O1uRq0hfzY6mrV+d2XgB4c/Yz7Wz/hqaaqZHUhrWapeZM9KpumjQv06d9NnAD5mCRWvv
 KBTw/CSqjWl0HRRhtP06MvrgSdoGCFwH8z/kLRfJZJ5q8VnLtXhZ2hqZEl6DO/CP+uPj
 GB4zlt7B1ALMb1OuSl/LR7B5CN8yw4OFSPsNxzAzocstXAT6O5SPiiz3L93aQe7cttXT
 5xVuMziPkoV64BjmBNa8SYJrbdz4zocTt9pOCqQfKjvm7GXtPq0w29q0tbvqH6mLC7ie
 oiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754535772; x=1755140572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqZKDhwtkLC/tHYUZBs2eggDgvqJxQq19A0deinJjBI=;
 b=sCYFkz0fMLzLrR9XIPhD2wYU1HpgWtCesCDI9nZPJXOX3U+Mku0gPuXLGAdTiSBhht
 emcFknZZOyBuSE0BH0+epI5YZWsg8lkfjAl2HK+OU0+4oiC6PhHFe5rjEUn6rErmQa1p
 THkDt/gizRLnmU/6NnKsfUi7zYwCOJWEPaPnkgLJntUwivcaCWa22KbL+H8o9fqcS7Ny
 Wb/qQ6Q50o2gXWlOGnqT/q78UMU3p9O03SyiC64t2/p32MFEuSqg4c3AepK6voVDLPbQ
 P6OzOSnka1WI7oOjepwOiA3VIAlR7L+Rklz+ELPeU91GbP4bWVIfS2vCbrlcfRpkFRV+
 8zOg==
X-Gm-Message-State: AOJu0YzagVPQI2AyEZxXIOJzsI9tPEHSFN0fRuA5J38mnBoprgA/Bc7z
 3IDStyiVuFNLuzEQpRz3tO5+nwM6q8efUfoM0ulpXF4xwQg0/9ygU5aD9Zet4A==
X-Gm-Gg: ASbGncskLMHh9xOHmiMCu9GuIiiXWd9CMM0yzuiLKFmFIX3CgvPJn3Y6TzSbdnpwWQN
 kr6NDwoeJWJvDrzVrKM1UKzSSKjYdannfYvFWiDmtYOUxiLM9li8jN6sttNOhAUB2IDNqM31wIu
 RvRJeIMXOdsg+pkGWwUrlubar/EzQw2l5SCBVzCxLUAWeiWv4UiUY4buuaua9YbRkswQ6emtFHK
 gtkYPMa+NwQfb5Gu8EkfSSPe1UsQK06/IbHFMC6uQoQ5Z9MxirUOQIkw/xo2wyGfqSAzArE1umI
 5/0G7LCla4I1In16mh1bqF2OJXIPEIPDxC2ipL68rfXf2EM/F9b5jSDmWd/ugJg+4L8XQIMU5IM
 BXlWcVCWkFmVwBM9R8v4qzA==
X-Google-Smtp-Source: AGHT+IFf88P460IRUHcmvQ8QNE1dy7ChKC/k+eKZ6PsDEavr1VndIMAZRY4uAGB54Y1c1AN7l+LIwQ==
X-Received: by 2002:a17:902:c94d:b0:240:1f19:d35c with SMTP id
 d9443c01a7336-242a0bb5554mr73466095ad.39.1754535772342; 
 Wed, 06 Aug 2025 20:02:52 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:81e2:9f1d:777a:7b46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6ac6sm173154585ad.1.2025.08.06.20.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 20:02:51 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 4/4] .gitlab-ci.d: Add build tests for wasm64
Date: Thu,  7 Aug 2025 12:02:03 +0900
Message-ID: <85c09a7c387d8fb9bbcd5b887c3d219c59a0807b.1754534225.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754534225.git.ktokunaga.mail@gmail.com>
References: <cover.1754534225.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The wasm builds are tested for 3 targets: wasm32, wasm64(-sMEMORY64=1) and
wasm64(-sMEMORY64=2). The CI builds the containers using the same Dockerfile
(emsdk-wasm-cross.docker) with different build args.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 .gitlab-ci.d/buildtest.yml          | 26 ++++++++++++++++++++++----
 .gitlab-ci.d/container-cross.yml    | 20 ++++++++++++++++++--
 .gitlab-ci.d/container-template.yml |  4 +++-
 3 files changed, 43 insertions(+), 7 deletions(-)

V3:
- Renamed the build tests on GitLab CI("build-wasm32" ->
  "build-wasm32-32bit", "build-wasm-wasm64" -> "build-wasm64-64bit",
  "build-wasm-wasm64l" -> "build-wasm64-32bit"). The same change has also
  been applied to container-cross.yml.

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index d888a60063..77ae8f8281 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -787,11 +787,29 @@ coverity:
     # Always manual on forks even if $QEMU_CI == "2"
     - when: manual
 
-build-wasm:
+build-wasm32-32bit:
   extends: .wasm_build_job_template
   timeout: 2h
   needs:
-    job: wasm-emsdk-cross-container
+    job: wasm32-32bit-emsdk-cross-container
   variables:
-    IMAGE: emsdk-wasm32-cross
-    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
+    IMAGE: emsdk-wasm32-32bit-cross
+    CONFIGURE_ARGS: --static --cpu=wasm32 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm64-64bit:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    job: wasm64-64bit-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64-64bit-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm64-32bit:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    job: wasm64-32bit-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64-32bit-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --wasm64-32bit-address-limit --disable-tools --enable-debug --enable-tcg-interpreter
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 8d3be53b75..84c4be49f4 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -92,7 +92,23 @@ win64-fedora-cross-container:
   variables:
     NAME: fedora-win64-cross
 
-wasm-emsdk-cross-container:
+wasm32-32bit-emsdk-cross-container:
   extends: .container_job_template
   variables:
-    NAME: emsdk-wasm32-cross
+    NAME: emsdk-wasm32-32bit-cross
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm32
+    DOCKERFILE: emsdk-wasm-cross
+
+wasm64-64bit-emsdk-cross-container:
+  extends: .container_job_template
+  variables:
+    NAME: emsdk-wasm64-64bit-cross
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg WASM64_MEMORY64=1
+    DOCKERFILE: emsdk-wasm-cross
+
+wasm64-32bit-emsdk-cross-container:
+  extends: .container_job_template
+  variables:
+    NAME: emsdk-wasm64-32bit-cross
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg WASM64_MEMORY64=2
+    DOCKERFILE: emsdk-wasm-cross
diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 4eec72f383..01ca840413 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -10,12 +10,14 @@
     - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
     - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
     - until docker info; do sleep 1; done
+    - export DOCKERFILE_NAME=${DOCKERFILE:-$NAME}
   script:
     - echo "TAG:$TAG"
     - echo "COMMON_TAG:$COMMON_TAG"
     - docker build --tag "$TAG" --cache-from "$TAG" --cache-from "$COMMON_TAG"
       --build-arg BUILDKIT_INLINE_CACHE=1
-      -f "tests/docker/dockerfiles/$NAME.docker" "."
+      $BUILD_ARGS
+      -f "tests/docker/dockerfiles/$DOCKERFILE_NAME.docker" "."
     - docker push "$TAG"
   after_script:
     - docker logout
-- 
2.43.0


