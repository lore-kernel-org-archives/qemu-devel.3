Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDC5C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhZT-0002aT-G8; Wed, 06 Aug 2025 13:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujgPa-0007PG-De
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:50:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujgPY-00038U-Nc
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:50:42 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76bde897110so99894b3a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754495439; x=1755100239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqfVs8LrCw6VFYQzRNYHUlfWzAl7tvJj6FpfwaoQEeA=;
 b=HjI8IQZpFZ3WwdcdflLo/I4qRyX8MSjlYx29A3+EGp2Q+GjWfIMArHQXczT+mKPTEo
 /ZfuD7vRvaCNr7fznZP+ZSP3wlBzd0vWvkvWT5aNEGo4XhRoqD1d3Mcno54NhJWFuia6
 YAHQWOcSrtDUDK9N2G6GvVfi8hDJzi+vlw3gq9Yqyhd01xFwi+li1SSqIr+/HifKeRIz
 /8hePLzI9veLf6cNHGsJYb2Lc1+zhJ+puojn7kbkFIHdxI4VTkfR4qm19UM0WQxLvXoH
 dvZRPvpAS+XO8cjUh3ZsqeXhLf0jRcONSsy6ppQsNfg4MnYWJ48lnEONtmU++Q367OcP
 IIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754495439; x=1755100239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqfVs8LrCw6VFYQzRNYHUlfWzAl7tvJj6FpfwaoQEeA=;
 b=lgQsDiWeLY6VSXrAoImrWxS72KBDxUeiTr9aeATXFn0j6h6qJkWoH2gTovOW1f0dnK
 Byw9lvs4Qc85zwXb74mUxR0NDDPUA2+zTrUk45A2lKk3QJNP8Yet3L2CIg8p3Xe9JbPJ
 2j5/5Upswc29hNVaCbG8vPtt1WKMxGal/P5y0YUejyjVBvliet/qAxxBFvkNa0/L0FCb
 bfR+uo0zzv20zSt17BzYXEzkCx01rieoyzZOHZx8m3ThDcvovs/mG3bVZPUePfyyvmtW
 dWbeh/3zIefSxf9S1wjAP/4cvtNgh1AD6VSwaMPkNfrZm9ysmO9mrLwT2VRGXB9Z5kq+
 6Dpg==
X-Gm-Message-State: AOJu0YyaRrlf/O/cuuLKKuKV1xonU6bxvPrqzrQ5xUNgDkQAGhC+F5+p
 xIr2tPz2S23zOsr9tLDHMgx1P1U9R4w0qvPAKKfVg+pnOOXbCQQXq0pJjdphpQ==
X-Gm-Gg: ASbGncsm68HLyGntQJZcmBS1Qa3RaJkhu5KAQc7CEXg7d+wvwqQTr/UMjaLtMEqr7VR
 A+GL4QRAXbRSZ8Wn/Wn2CgSCiv3yPUysEEU3oRi80brzhE1979L/0sbAfisyeiGinDOTQazZeD8
 eJFY881EgX1eE3e87KpdS7xmTFUBZFzSRXa8DNM4A0pfet/c1m9GbtqmsLRqSixWTIsPvq9pUtX
 jEI3seGeUVx7qg2orrgRUhTtB/CMUhuVP/1O+o/Zlj/AAktBRIybE1603FFvFFB6kMlQ/13huYV
 8wUdIr5TuoKxdgkI6pdMgC9+iRI+HKKqaVIkSOcWi/L5FtTeeVY+ZJsxVM+++w7nMbfrtVzEcba
 1umQAYPI2VXbQ/zLvCzgEqg==
X-Google-Smtp-Source: AGHT+IGBtSenovuocauq8HTqJyl+RQD6Ky1dHozafLxbi+glLX8VB9Py22N0XezBHfbxzJDta5tZuw==
X-Received: by 2002:a17:902:e944:b0:23f:d47a:c9d3 with SMTP id
 d9443c01a7336-242a0b00209mr36028365ad.15.1754495439281; 
 Wed, 06 Aug 2025 08:50:39 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:4cca:cbdb:3f01:1165])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976a3asm163374575ad.87.2025.08.06.08.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:50:38 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 4/4] .gitlab-ci.d: Add build tests for wasm64
Date: Thu,  7 Aug 2025 00:49:51 +0900
Message-ID: <c10d9f2b85a2791d9f734678fba186e6eacc1b37.1754494089.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754494089.git.ktokunaga.mail@gmail.com>
References: <cover.1754494089.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42b.google.com
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
 .gitlab-ci.d/buildtest.yml          | 24 +++++++++++++++++++++---
 .gitlab-ci.d/container-cross.yml    | 18 +++++++++++++++++-
 .gitlab-ci.d/container-template.yml |  4 +++-
 3 files changed, 41 insertions(+), 5 deletions(-)

V2:
- Fixed to use --wasm64-32bit-address-limit instead of the removed
  --wasm64-memory64. This can be considered as a significant change from the
  previous version of this patch so the Reviewed-by tag has been removed.

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index d888a60063..0dded04188 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -787,11 +787,29 @@ coverity:
     # Always manual on forks even if $QEMU_CI == "2"
     - when: manual
 
-build-wasm:
+build-wasm32:
   extends: .wasm_build_job_template
   timeout: 2h
   needs:
-    job: wasm-emsdk-cross-container
+    job: wasm32-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm32-cross
-    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --cpu=wasm32 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm-wasm64:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    job: wasm64-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm-wasm64l:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    job: wasm64l-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64l-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --wasm64-32bit-address-limit --disable-tools --enable-debug --enable-tcg-interpreter
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 8d3be53b75..1bacaff818 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -92,7 +92,23 @@ win64-fedora-cross-container:
   variables:
     NAME: fedora-win64-cross
 
-wasm-emsdk-cross-container:
+wasm32-emsdk-cross-container:
   extends: .container_job_template
   variables:
     NAME: emsdk-wasm32-cross
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm32
+    DOCKERFILE: emsdk-wasm-cross
+
+wasm64-emsdk-cross-container:
+  extends: .container_job_template
+  variables:
+    NAME: emsdk-wasm64-cross
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg WASM64_MEMORY64=1
+    DOCKERFILE: emsdk-wasm-cross
+
+wasm64l-emsdk-cross-container:
+  extends: .container_job_template
+  variables:
+    NAME: emsdk-wasm64l-cross
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


