Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70EACEBF8D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 12:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxys-0003C0-L8; Mon, 17 Nov 2025 07:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxyc-00039J-86
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 07:04:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxyX-00087q-HU
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 07:04:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so28874505e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 04:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763381092; x=1763985892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTfl9/oVQRYgJ1LsJlKUs+ebC3gKf7DB/3Pp6sigeDg=;
 b=Gf44STcehv7ezeuShzYA5kdvVhBVhLRt6pSjin/SkeHNrfvyGlMscsQlIGo+yF9rZ5
 A0mC01qXC8csVUa70PqXT0C8MfHHaPsy/1ChoNbu2yoXVVEAoGBbjjfJbQbgN8Vojq5W
 mHpiZbjHHJgqcwE3drLGNfHw84eOZDbNx6j6Yjt5rsZlyiklWy2q/nawLpby+4P9X+Zg
 /aqyOAn3mTu/eax9SPMiZ4wOdkdV7ho7QJBcWwUbXNsoQBM2m/+pfOxrPoSxKtEk5KgR
 nORl3/E2fh/KtVDlsJgnPUhoqpeJUQ6auyl2SwkNLPWmPKTexKxrz0WKJOsTCqVYiyMu
 5KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763381092; x=1763985892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dTfl9/oVQRYgJ1LsJlKUs+ebC3gKf7DB/3Pp6sigeDg=;
 b=T4IMHT7yE0Kx63gI7o87qqyZfBG8gDvmY7qlrW76TTtRpDXS0dhPZ3omypab9sL0Yu
 Bm4Y4BGKpGAdYEGdZTGgFPUCuzB6EOrGv+kNINcnG2z04L8hWLaYrd6FtVRwKNstc96z
 8nOwfW2EvD3V6gIKg3HdsHRkcQ01GW03+XGU1vq8wyJ7IY6SMopBz0OezSumKilbYXMr
 1UQ2U7PYEs1CsEMsHHfwIYJdvwYK6EevApRysy+sTXG+D7gSRNUAzwEB0sBYzGSbeH64
 5BlsW7vN0uZNHGhnnLu2te40Lb1YZDQeTvdwa3TyImd4wm3w/BSZhU83J5KaTHRnK3iN
 vjpw==
X-Gm-Message-State: AOJu0Yzw5Jkm9OBclrLETn98nYQn7ojI9RXkUzyBPKXtdGXqkcT4hbrU
 hJ1rL0ejKyyGXpe+nO6TyC44STwfpW8PK/vQXxhoOstwLYo1fowKjRFX8/JmFum3G7I=
X-Gm-Gg: ASbGncvl203i+SVJi3RlBM/SX2xwOqMB6X9Yslqny6gmRi156zS81s4/F62QG6G2HBb
 NT9Ua0c0NyqPjsz9BuS+gHwovsu/OGnybg7z2KA72jty5/P1Cimr2ImUdPINCPViatXPgIUIoUD
 k10dZHpXiyFFVr7E1uhHAd0BT1fNr4Jl5G+X/QemR8zePFkNFqTI8rXO4rvNQBEHDZ7PhH0XKhf
 bGbTbuwhF4HkXWGhKh4NvFcgUSOyJ35VCzRfg+MxgN8zla8Rs/JolMFkujw2CNY7RBfcBjTHlGP
 xHHaDxyMFokbmAv1x0xwtKJtYI4rGVzah7+c4V6th79GUBGF7kGrQjZxFM2YTP9n4vDi8NUWNZi
 cVpJIZi3jY/U1FDWLmjuVs+0gIzPIeJZ8XO9+xx5dsOQqy6B8CYAseAjYrX0Fvm6jstoJss42rv
 jKKylU+YH2eE4=
X-Google-Smtp-Source: AGHT+IHCteNyHqjJRsx4JN/KIkHMgclHDG/vTOR6YpnhvzLSx6v0UnS/v8T+f+6JE4D07gah+gKPcQ==
X-Received: by 2002:a05:600c:c4a2:b0:475:da13:2568 with SMTP id
 5b1f17b1804b1-4778fe9a5f6mr99374045e9.25.1763381091673; 
 Mon, 17 Nov 2025 04:04:51 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e97a87sm26577415f8f.20.2025.11.17.04.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 04:04:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1ED125F860;
 Mon, 17 Nov 2025 11:55:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 18/18] gitlab: add a weekly container building job
Date: Mon, 17 Nov 2025 11:55:23 +0000
Message-ID: <20251117115523.3993105-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This will hopefully catch containers that break because of upstream
changes as well as keep the container cache fresh.

As we have all the container jobs as dependants we tweaks the
container template to allow scheduled runs. Because we added a new
rules stanza we also need to make sure we catch the normal runs as
well.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251113102525.1255370-19-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - use QEMU_CI_UPSTREAM
---
 .gitlab-ci.d/container-template.yml |  5 ++++
 .gitlab-ci.d/containers.yml         | 39 +++++++++++++++++++++++++++++
 tests/docker/Makefile.include       | 11 ++++++++
 3 files changed, 55 insertions(+)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 4eec72f383d..82c1b69e8dd 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -19,3 +19,8 @@
     - docker push "$TAG"
   after_script:
     - docker logout
+  rules:
+    # because we want to enable this for scheduled runs we also have to replicate the normal rules
+    - if: '$CI_PIPELINE_SOURCE == "schedule"'
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^staging/'
+    - if: '$QEMU_CI && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index db9b4d5e57f..f7d3e7205dc 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -33,3 +33,42 @@ amd64-fedora-rust-nightly-container:
   variables:
     NAME: fedora-rust-nightly
   allow_failure: true
+
+# this scheduled job will trigger all the containers to build
+weekly-container-builds:
+  extends: .container_job_template
+  allow_failure: true
+  needs:
+    # core
+    - amd64-centos9-container
+    - amd64-fedora-container
+    # cross
+    - amd64-debian-cross-container
+    - amd64-debian-user-cross-container
+    - amd64-debian-legacy-cross-container
+    - arm64-debian-cross-container
+    - armhf-debian-cross-container
+    - hexagon-cross-container
+    - loongarch-debian-cross-container
+    - i686-debian-cross-container
+    - mips64el-debian-cross-container
+    - ppc64el-debian-cross-container
+    - riscv64-debian-cross-container
+    - s390x-debian-cross-container
+    - tricore-debian-cross-container
+    - xtensa-debian-cross-container
+    - win64-fedora-cross-container
+    - wasm-emsdk-cross-container
+    # containers
+    - amd64-alpine-container
+    - amd64-debian-container
+    - amd64-ubuntu2204-container
+    - amd64-opensuse-leap-container
+    - python-container
+    - amd64-fedora-rust-nightly-container
+  script:
+    - apk -U add make bash skopeo
+    - make docker-verify V=1 DOCKER_DEFAULT_REGISTRY=$CI_REGISTRY_IMAGE
+  rules:
+    # this only ever runes as a scheduled build
+    - if: '$CI_PIPELINE_SOURCE == "schedule"'
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3959d8a028a..38467cca610 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -49,6 +49,15 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		-t qemu/$* - < $< $(if $V,,> /dev/null),\
 		"BUILD", $*)
 
+# General rule for inspecting registry images.
+docker-verify-%: $(DOCKER_FILES_DIR)/%.docker
+	  $(call quiet-command,			\
+		skopeo inspect 			\
+			--format '{{.Created}}' \
+			docker://$(DOCKER_REGISTRY)/qemu/$*	\
+		$(if $V,,> /dev/null),\
+		"VERIFY", $*)
+
 # Special rule for debootstraped binfmt linux-user images
 docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 	$(if $(EXECUTABLE),,\
@@ -236,6 +245,8 @@ docker-run: docker-qemu-src
 
 docker-image: ${DOCKER_IMAGES:%=docker-image-%}
 
+docker-verify: ${DOCKER_IMAGES:%=docker-verify-%}
+
 docker-clean:
 	$(call quiet-command, $(DOCKER_SCRIPT) clean)
 
-- 
2.47.3


