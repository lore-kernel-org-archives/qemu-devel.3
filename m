Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A66ECCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIsBB-0001s0-0P; Tue, 11 Nov 2025 12:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIs65-0005mm-Ft
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:24:01 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIs64-0005Dr-0N
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:24:01 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso412266b.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 09:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762881838; x=1763486638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0ACTmVCm6Itx0zI8K5haUPy7qTi+867lgA6yGc7lBA=;
 b=MH0FfBpfV+jYQpmqAgrkefNq/tvWCKiRutM8F/6Lk3EP/yYyKBDOc9CsczLjrbO7T9
 GPsPFT2jT+ZRKpfPhEhbdfKSKmRtb11YA/Tbvx5MGdkZrE5mveDuvEdYBkOSX9uDKbap
 AAInYFGfIFYuCbcK4TeFLv1sHj6KGHRgJ6+Hy1qOJS3DN+N+0PFtTIHKJfAfuRgQ6MtJ
 21ouiU1f7bYHBEaxVUUQDkf1aqwudHNAmdnPTnphe5n/X4MBBqBbiXWM/DE1w2s4bVGo
 Pt31kXqoTHE5qkfQ1lAB1p4p8XcP3t8JT6m52gKSpsoYpTv9fXu6txGXyzDmaCXx7rsn
 69vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762881838; x=1763486638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K0ACTmVCm6Itx0zI8K5haUPy7qTi+867lgA6yGc7lBA=;
 b=GP/JGwK6uRL+30hBL0CyGOwrmFGMlPNWdB7gTESjFhmSOxDLDgwLS1ayH+2in0lGhd
 slFqkiMQq2kbCzUnxNYQjxtyZmH0L1whn3op9huAO1Fgw7vzCOpZSNxsEoJODyYzZFJA
 geaWtOyTscfZk86/s1gicE9Cz33+pYi6ICNradiXjDJlWsWPGuAIS58zDmlpAWekxpDY
 /Nd/4ubSZM5GaqLxrNKrDROjk/JlzIi+My6L0cn/oEuO3elBFjoIDYuJ4B3A361qJsrD
 HayupkZUVpxyfoQB+ZRYN8ZTrG1/bZe44YYf1KVXlONkD0nH75/X4ojOjEmlE+FT9GRy
 VT7w==
X-Gm-Message-State: AOJu0Yxerd7+1Pafgp5+eS/1wIjaBgjXN1/C3hi+u2aSZJOX8NnvOFHr
 GoRKbYMLM4D2EWauOByWjb3Wy10KtKSgucwFuSv0VY5SIZZLmUDLCZXrFeiEdYQ9O3Q=
X-Gm-Gg: ASbGncuuH/X9SXi04wJSwdt2dCy/QB8Rw2574oK0eQd+lK8R4xgXaJsRU4C4OH8o31f
 d5zocUPYQLWIlBgaBUmoRJb/r2iRU0LW0U1QSBgYKXy3xy7C49YvDcsn9dGw8B1IH6AQ1/IYk/8
 mwI38FKnobtXAdnCZjwCVxw6b4ANvX8xBtaTk07ATZP5qh19Tsq3ItprMi68Rcy+3KfyGbRvVLo
 Yz7DZ/joGvb0usSkQ3JVsFBUaX+gF2sRwgz4kJFmMpc1W4c3IBZbEg2azp0i4uylJ5nAOEEb0SN
 0+QRCAQ9LgG3UFGqRHuYQw5K/RjGzEtdLG5Sy2rizVKVkkb87C0chy2xjm1pEeYFXw9Hw6x3YEF
 29Q3XPjDNaCYwz/wREjjJCIpXlDUsIw/Jp6xJ5i+wbv/Q+CZZbUxePnoNHzt+5/4zknEjfBXD4T
 wU
X-Google-Smtp-Source: AGHT+IHOgTKvV05M8SeaSy+OisZ/2MMINvTFVzOX/apXVwVgnzFRJuQ+iIbLbW+MgAOPOtkk/8FUFg==
X-Received: by 2002:a17:907:3fa9:b0:b6d:5262:a615 with SMTP id
 a640c23a62f3a-b72e045bbe3mr1021878866b.41.1762881838431; 
 Tue, 11 Nov 2025 09:23:58 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf9bc83asm1368958266b.51.2025.11.11.09.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 09:23:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1D62A60DE6;
 Tue, 11 Nov 2025 17:17:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 16/16] gitlab: add a weekly container building job
Date: Tue, 11 Nov 2025 17:17:23 +0000
Message-ID: <20251111171724.78201-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111171724.78201-1-alex.bennee@linaro.org>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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
container template to allow scheduled runs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/container-template.yml |  4 ++++
 .gitlab-ci.d/containers.yml         | 36 +++++++++++++++++++++++++++++
 tests/docker/Makefile.include       | 11 +++++++++
 3 files changed, 51 insertions(+)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 4eec72f383d..5385d1b5685 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -19,3 +19,7 @@
     - docker push "$TAG"
   after_script:
     - docker logout
+  rules:
+    # Allow for inclusion in schedules
+    - if: '$CI_PIPELINE_SOURCE == "schedule"'
+      when: on_success
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index db9b4d5e57f..9bf6d39b264 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -33,3 +33,39 @@ amd64-fedora-rust-nightly-container:
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


