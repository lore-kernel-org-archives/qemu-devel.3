Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6572ED4A5F1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaaf-00055M-9l; Thu, 15 Jan 2026 22:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaae-00055D-1C
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:36 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaac-0005Ez-CJ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:35 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso941492b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534413; x=1769139213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiKhVe9h1C0nVxITBJA39wKqU/L0CHS8GFQCoHFP+dc=;
 b=lwK0UPnDpm9Y4A6UgUBrI0o1T1pSID4fKlC8p3oZYTgYQfpK6UHCS+/WmVb3ssnn8/
 U00PmOSC1LhNT6JxazSoCz8kIc0qFOAQlvA4MJ6cqJ+UX21PjC0sw42F5FwXn9FkJBo/
 OcCYXw1n9gKjG/DMZXCKw1gqMy6LKA4wunhN958kCzEvBVqub6QbXUhwKDykpAYn7h7i
 /xK+GFXT8yGLembqWD9n4A0inp5WUmqxEELeYUiEXM8N0Emgqihdhz4RSqvkWLhFkqJG
 VpPS6K5F9s/vsCJIvbPAA7RdZsBPSzuGDCa0+TUBLW1QWBjOSoQDl5JP4VQ1a7/MSqIx
 RFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534413; x=1769139213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WiKhVe9h1C0nVxITBJA39wKqU/L0CHS8GFQCoHFP+dc=;
 b=SfGwYfE4Qlp38IjLAcC1t64Z9OnDJvgvqRDf1fUcI+j+HxnkhKEvJFcLmKuu8C6Vac
 SUrI8qC1z2TGPy8YGU6MF1kyf60ZYWbTl/sBiMyaX+FuERQMI0R+2h3AUCN181sTYqT+
 rFdKHJ/MxB3ygMGgwGvucI0cmm7lcIahzO3sj35GTiJxqVM831WhhmNu+gi1tmxxx8MZ
 SkaMkCUa2Ee0bHtXYIhaApIps/D2ZB13nzHRfcViH+7oB2HV+e2OdSIptnqLOVeblDMW
 e9BorrpX/RNRGO1+EXGJGmXOmisDx6hsxteOwFXNBP//ak7LDK2X7nGsA+70wmulCD80
 ecrw==
X-Gm-Message-State: AOJu0YwTHTeO4f+jCdjQKchwqQoP/LXjLr+rxaR7iXsYkByNh2UMbIfX
 i/NNCOlPvrgRJ+HCXkPqGL2+AEgYe4CIbG8KGTCqGhYVILpVNLRUO9Z/V8oZJPhpM4P4t7mrRSG
 dlfYBXMZ0JA==
X-Gm-Gg: AY/fxX4+h6foeg/+qgwwthmZ7qVUwKrJddoG7JQ/Hbt8Y9YdmnaaOHNIRglI1Nr02G8
 NcoHVnFHFkt30wXUGQBdXDdoB8qngdFYphys2AXCgwJLtzP/sf7wA4ODCQ3tgqQuqz3oJH1a/Bz
 V3Pc/JacHO4dfzMSWGXpq1ojn6AHTvaIaBGpYsvfpRFd0SdH8RDb1gjXeZvwztmZkZD1OF2xOGi
 ZZLEWr0SH2oBuBNRHhJ4qCH7fRdtqkfq9JMSt1jbKZZmY5Bcr3CWCc7irQgGCbPGKZwUs1eMxkD
 SrSntGw4HegHuY1ng3hR/jRl06F32Kk45e1JD9+T+WEpnML8gJjDGeCI2wKBXo+hOJ2xp+sTTTx
 yGC4vY5FEYdELpw1MYV1a3123pGgnGKXm6r5XlzZiQIFdhSaHbtThXgbo61PlAQx6vVObb0+vrS
 p5cRfk6pLYCE7S0r2Pdg==
X-Received: by 2002:a05:6a00:c86:b0:81f:4566:ccde with SMTP id
 d2e1a72fcca58-81f9f6ab85dmr1628745b3a.20.1768534413039; 
 Thu, 15 Jan 2026 19:33:33 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:33:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 04/58] gitlab-ci: Add build tests for wasm64
Date: Fri, 16 Jan 2026 14:32:10 +1100
Message-ID: <20260116033305.51162-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

The wasm builds are tested for 3 targets: wasm32, wasm64(-sMEMORY64=1) and
wasm64(-sMEMORY64=2). The CI builds the containers using the same Dockerfile
(emsdk-wasm-cross.docker) with different build args.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee30d4956a485fd46b4735028486d3fb7b22fe60.1768308374.git.ktokunaga.mail@gmail.com>
---
 .gitlab-ci.d/buildtest.yml          | 24 +++++++++++++++++++++---
 .gitlab-ci.d/container-cross.yml    | 11 ++++++++++-
 .gitlab-ci.d/container-template.yml |  4 +++-
 .gitlab-ci.d/containers.yml         |  3 ++-
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index dfe954fe3c..ea0f5bb057 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -785,11 +785,29 @@ coverity:
     # Always manual on forks even if $QEMU_CI == "2"
     - when: manual
 
-build-wasm:
+build-wasm32-32bit:
   extends: .wasm_build_job_template
   timeout: 2h
   needs:
-    - job: wasm-emsdk-cross-container
+    - job: wasm32-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm32-cross
-    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --cpu=wasm32 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm64-64bit:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    - job: wasm64-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug --enable-tcg-interpreter
+
+build-wasm64-32bit:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    - job: wasm64-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm64-cross
+    CONFIGURE_ARGS: --static --cpu=wasm64 --wasm64-32bit-address-limit --disable-tools --enable-debug --enable-tcg-interpreter
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 0fd7341afa..7022015e95 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -86,7 +86,16 @@ win64-fedora-cross-container:
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
+    BUILD_ARGS: --build-arg TARGET_CPU=wasm64
+    DOCKERFILE: emsdk-wasm-cross
diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 82c1b69e8d..b92e96b0fc 100644
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
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index f7d3e7205d..dde9a3f840 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -58,7 +58,8 @@ weekly-container-builds:
     - tricore-debian-cross-container
     - xtensa-debian-cross-container
     - win64-fedora-cross-container
-    - wasm-emsdk-cross-container
+    - wasm32-emsdk-cross-container
+    - wasm64-emsdk-cross-container
     # containers
     - amd64-alpine-container
     - amd64-debian-container
-- 
2.43.0


