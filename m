Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3F1CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQz7-0004w1-V2; Tue, 19 Aug 2025 14:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQz7-0004vT-Cc; Tue, 19 Aug 2025 14:23:01 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQz5-0003mh-Hy; Tue, 19 Aug 2025 14:23:01 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24458263458so45862225ad.3; 
 Tue, 19 Aug 2025 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627777; x=1756232577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mnwM1NKHDi9Rdp/eRcwiDwz6kKklNhllSveakiPYS/g=;
 b=SuZiL/le0pNdXBCetxuteCOVM6vTSzqw2E8XMe0czcxaONhP1eftGMZE7cnufhH/fj
 okP2Ltl34SIqrG1jELFtf1aeKLhk3aCX4cRiyM8GSyeSkyF+wmtdC5tp44u/0zePaovT
 HsY4mnJZwMuFcwuigEseYZ1xuT08vBwojNUGck1Ldtm95wz844uq78PQFnK/m5cv7a8x
 LXyAOCl6IzLSpc36gfTw0w4L4retHR14EeJ9gWujK8pKaLJx167JAdawvxx9qtKjrMVW
 HpnI2Ps7F8WQUYgbNLqrhroZJ+WR84/yzAPUyrJXi7E7PvdnywMh14Hn/STIwYIqS7LR
 09lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627777; x=1756232577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mnwM1NKHDi9Rdp/eRcwiDwz6kKklNhllSveakiPYS/g=;
 b=BCXlVG2FL0dVSMKDNlLHgfg/NRKQmQDqohN2n0qxlSM7XXDgb67FhYaxs4g0woBGpB
 MtDPQCszFdMZN5rMlG4FWKgsVnsNNMcF7tRMbW5lpZJzKGATVFmslBNZruqBEHXGRE8A
 VOxp5z2IqUzWYCNk9tSHNYuLZ6u9PyB5sbNSdrn8thIvIrsnncpkPBfNK0FupRmVqbDz
 9bp0NLz2NduzfalTL/f0DQdsme4MGr/nd2unPyXY11nZaS9GJxXZyS8kwLR2d/GY/74z
 WbEsYDOuEryYrvdYdKNtGB3bmvuxHwBhf2LU/mBD9kyJ7hxfbC3NarDadDVt2UwANCfk
 pIhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/jvv7JRIgTihAh6PnPCRJc2nNMe7sL212WfqFMO4BF8dcU5/y+4HMdCveQt+hQFYqZMiZdB2rc7pY2g==@nongnu.org,
 AJvYcCWPrxLi490RVTBnw0T1dzinetmNkWo4aA9+H0wkUkBnm0bbOeWQSHOyPgodmS92qyPq3k4UcYoK0A==@nongnu.org
X-Gm-Message-State: AOJu0Yx2mziGM+TMAPbdOd8vxvYCZs54d/qUtfMnUuTYuw9MJWw91ykh
 UPgYmTMOCe1Tim6N12CokMQIxsx22CZXQGBPI5dbUkBa0ISSNKyDVxiWc0QLD6tL
X-Gm-Gg: ASbGncvMo7nM//NhFMQRe/nfwh/22oco7pv9vCA2/uZBaKFgyqwPgtm5v1AsxhxC4mG
 UfDKgsQor+bNN6snDCClULITMFA/Z3OVLe+yJBud80xvH0WNpu6GZbev6GRhrLNNGz1s3Map/9n
 k1z24mlePLsS8LCcBjrlUkjDB1eBEqmFBDJEoQrvbTtB40WlMf9hYzacgkODzQ/t2w/vu4kzLq0
 lWe13abepJMvFDkeYZEq0Ke8T4MQTKefh+M7Ot3wI1UEMgagqTuusTRUOhwK5OjSpa199tiwCzq
 3I3lG7SrAmvM15swlB2lhHTaZmjOw0KmjzTlSsj80iKvHLi2r/ZewuXddgTDgYknPbHe2y/sq9n
 Ktgf9kxCaTJESNtYyIlaXfqsvmgY9UvIp
X-Google-Smtp-Source: AGHT+IFBsiEtnYUR+SskuxqrM1PYZdjvBSImy/uoMDx63y0gSjeoy+527k5Zq5vjFVAwnR57bFS7YA==
X-Received: by 2002:a17:903:2ac5:b0:234:9656:7db9 with SMTP id
 d9443c01a7336-245e04866a6mr49403075ad.32.1755627777331; 
 Tue, 19 Aug 2025 11:22:57 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:22:56 -0700 (PDT)
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
Subject: [PATCH 04/35] .gitlab-ci.d: Add build tests for wasm64
Date: Wed, 20 Aug 2025 03:21:33 +0900
Message-ID: <85c09a7c387d8fb9bbcd5b887c3d219c59a0807b.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
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

V1:
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


