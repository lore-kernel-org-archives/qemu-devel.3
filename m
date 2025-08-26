Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2639DCA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwGy-0003pR-C5; Tue, 26 Aug 2025 12:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGt-0003k8-Nk; Tue, 26 Aug 2025 12:11:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGo-0007my-62; Tue, 26 Aug 2025 12:11:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-246151aefaaso263545ad.1; 
 Tue, 26 Aug 2025 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224694; x=1756829494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/4/Sw600R7SwLSv6LDIYlP62n0VZBFIs7QEajYZBZg=;
 b=Ctlt8qKnQjr03mFCkmRdigB5yBEO7IE/Ikj6+U6MrxDT1TYFDd0Fs7bv65Q6bT4+S6
 HZlSnFvI+NNacSe9BjKu/Wq22d1hPA+uTfd9XoKyXz4zectVSiDhhq9PhHmrGPTv4Y4r
 s/VEzXC/Bou6WHT0EhAcgkQZP8JaXi2xhd5UBO/kPca35Q2cFkuQKGTp/gI5aPkfa403
 DEnqpo4mkM9+4AXf74amyWE9Yyh7OyWA/NJNizGWbCcZU6KrWL4m8dM6x2cXQKa3tySp
 tSwNdwB6X1a64vEtvCJfQAf5h7BGufqd6emDGSzkD2Zv7MnURtJd/ESSifOvOMKAHlaK
 2oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224694; x=1756829494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/4/Sw600R7SwLSv6LDIYlP62n0VZBFIs7QEajYZBZg=;
 b=BLsKm3PTn/DyG/7UqPcZRUJdI3RyWALKc0lxcpNC52nRPb7wVCM8U6v0O+h3D/R8m+
 VPZwUo3GiASogqHD+j72Eg4kml9Ojxc4b+q5FMzzUuZdA8oboqj6VQVRSGAHlUM32bQA
 FltGYfBitteeHQ0GKcszQZstRlz9+KN6DMBLxDbREU/biCpTI1za0zTHL2mVDCSiPnb0
 Fw4muKRyZxZsXtzsZKhHyJBpg93kMCl6oNR3P5hL7Jh3NnDerIy7spHwmaCme3BvxRkN
 ffbUZMbLfqn1k/0G3gGz4Z4uMT3qce/R2eN+bzMCxrO1vYrXw40AAmb4yocLZk3USfXd
 9VTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDE0crqL2XNkqNkONaIK9CFLi+1qXz2EI3LlbKUeFr9OvSafX2RfNeuurDEziDiVDSSvuubP/3cA==@nongnu.org,
 AJvYcCWUQArGj9irSBNj+uw0XO19DCf1PmoyIGN+Vu/imAW/+dcDcepOqMPZSDv8WVGbMP9y2KDHsUbwqB2nQg==@nongnu.org
X-Gm-Message-State: AOJu0YxH2A216JzBD+Y01Bi1Gtib4C44kdu9JhBQNnli269e1Jvxk8se
 Ns9wldKHzV6KrM7ywZ9Xog9ZBDzmuLnl+KnkQIEhHep5hFRPQUilP0GDcdbI9A==
X-Gm-Gg: ASbGncsedzKykXUDHRjADNg2LjCJ9jGX+L1M+P/wbiqg3jTWts6FDqlB9XOXzpoHpje
 mG21g9K5mncSwrDvV0n/qZbCNt5lJB3eGb/ym+be2AJAlVnBAHpcpYj347TNBFu5GYMmFf/f35P
 7IqjNlItHGvlkHT2iApbzfDtjiUybJCLUKoHMj4yCVWMqVPyoxiITbc4BjL4qYQb8OCXR8L2An6
 +MlDnlUVHmJRAs8d847cUiaqOeVx0j7xeo9dGmku+FCyMGSyLYeEU9KHcyNLcOS3Duu5Uz8lsY3
 bUQmOZkd/hp+WR+oss3MpXTHv/L7XGrNeos7SbVdiKEiF0vrV3AZ4XQHK1tTs9GCAGlvOEmJAKn
 jgLs9J8laqk5aSC2oIB7c7gPBmzs7V0qF
X-Google-Smtp-Source: AGHT+IH1CJvPDrY0ctLrlUPhWHiH0zK+sdiDSIZBX6e+ZIn0i2tpfgM43kwcAqL8nnniGIIgkAYb5g==
X-Received: by 2002:a17:902:dac3:b0:246:bba8:9b8e with SMTP id
 d9443c01a7336-24875397544mr23234765ad.21.1756224693658; 
 Tue, 26 Aug 2025 09:11:33 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:11:32 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 04/35] .gitlab-ci.d: Add build tests for wasm64
Date: Wed, 27 Aug 2025 01:10:09 +0900
Message-ID: <74f75ef5de887b7e27ba9d17e21fc083ba99fa67.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

V2:
- This commit is under review in another patch series so please ignore it
  here.

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


