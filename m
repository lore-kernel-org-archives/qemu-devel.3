Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0329CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2zp-0007zs-CL; Mon, 01 Sep 2025 07:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2z2-0006ol-6g; Mon, 01 Sep 2025 07:46:01 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2yw-0001JP-Dm; Mon, 01 Sep 2025 07:45:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-24a1270e0deso12881415ad.1; 
 Mon, 01 Sep 2025 04:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727145; x=1757331945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WES0X6tSGNzNPhgOsz9aAkJISTE6g/V5BmTgRuV7mUk=;
 b=DqcoPFdj+AWXPDnW23HymEIhKcDg3Wfwh3JrAO9BEgh/uwair4d48xhWxifm54okC9
 9n50YPa7KXM5cqcTqgjF1DaMNEtvp22DVqjbABdVndGSBBlRBP0nTuBDL1JeCgANN4VS
 CFjTXlibZ4A5tiWBJSl2d6cmZB3vJ78N5JoAu1bGUhdU07ffkbPqWM37MjNXSpc1s6MV
 H39skfg1qn0uKhCToOyKmq6VybTh/9zBsVnd30q/tFIGnJyRLZaXv0u9VtfQra8qmZ9f
 JoLgdTprrMacGWSkl0TG3itfzwc/RxHHwHtuq2t6kXolALT1YMpUEH4nTSga1cn3KtZl
 tIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727145; x=1757331945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WES0X6tSGNzNPhgOsz9aAkJISTE6g/V5BmTgRuV7mUk=;
 b=I4LNDap/LbK1EHA99mwOufdHymqoh4wlqLabH6sth+se/yXo2hPlYvpcc32FvIQ5up
 TuOKrFOVriWxWK3waBy+e+H6Og3D7r4mN6y4kXwVWhioU//QUlDVfmNrlWfIbVZH1sqM
 0KtrwV1c75cPqjE2EtxUoQqGueglD53O0h7QTtwSlIaD+rGwfwVVdRdkKV9UJ4rDHfi0
 SVmSktuLBQRJaKdmtALRWnXHfG/Iw8ON85K2fqIG9cupISnNzQnVDNlDaQ8KSDSJBs9q
 wrSJP850618AmWz7Pr+es/fL5GzVcUzou1Rq+jSEayoWKLTMGryte7QQi81uxpVvniLE
 Xs3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlbf19HjF+4NHUBCT5tFS4yOLyE98CRhjCU+i3Ygg+x60WARisnKGCnPUZN8ykFp6+3TznbAKjbA==@nongnu.org,
 AJvYcCUywqYR6VzOqSSM+DH0RXkrnuhKF9hIg0Dc/4pce+0Subt6lr8pqgsbWADFrd98ojXwOeoPieP4HlL7Jw==@nongnu.org
X-Gm-Message-State: AOJu0YxuvZXFFUJrR/08mEdULNnq4XyBPh5wNH4OmhjP63Qw2ROP9TVv
 Ax5KnuF6nvZwH0H9FxrjuitpxTlQVxeqc4UyyvYnk6wwvoyP27qAm0Sxnchjdw==
X-Gm-Gg: ASbGncvxMd8mzHyStboFnT1zo3gDmNXSU5+OOxPkWYb6VRNo09uWL4br4EAOiIMql7Z
 Ywq+69SaWzZ9sUY1AVE8v7vQ68WPKT7+9myGS6Vjgjy656sko6Mn9qJTl35cqP5441m+s4wXMox
 Dn1Berh3sIEIA46UeXgEwpLdiAkZiI+YaTvTWvFYRpOSRkOarAAjKo36/OP5dRCQ1nxuDiYhr2P
 D6A086YW0EC6JMflmRddRyIZmUMMCxIsc2hfT8Eei6dVi8aPwKC2LNlHGM0nKlgWQO+6ZRZMAF9
 9tO4wDtIVSkMkFa6YfkUDPDb9Po2VVjCEtP1TtY7bypFhefLhmPXL4H1gGld9nE9sUPB4vyjBQt
 u860y6dEM+vC7DN0cuFG2v/FT1QYntQ/ol4o4wo03ggE=
X-Google-Smtp-Source: AGHT+IHDhFRJQBYt2ZX4BzXIeOLbiQkOdlyOuir3bILDtDa/NmCbPUbnJ/plEPsSK9snQ1kxnmscMQ==
X-Received: by 2002:a17:902:e5ce:b0:248:ffb6:5bc1 with SMTP id
 d9443c01a7336-24944a9d689mr109011385ad.35.1756727145453; 
 Mon, 01 Sep 2025 04:45:45 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:45:44 -0700 (PDT)
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
Subject: [PATCH v3 04/35] .gitlab-ci.d: Add build tests for wasm64
Date: Mon,  1 Sep 2025 20:44:06 +0900
Message-ID: <74f75ef5de887b7e27ba9d17e21fc083ba99fa67.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62d.google.com
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

V3:
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


