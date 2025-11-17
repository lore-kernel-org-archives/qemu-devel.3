Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D6BCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1VE-0003yq-5P; Mon, 17 Nov 2025 10:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UT-0003eo-P8
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UO-0007zV-8P
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:02 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477770019e4so49603235e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394599; x=1763999399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOTWnKm4DTCGpZ1/a5sMZIlg2R2K5QNc87Tidro0ZBI=;
 b=pgAbBM1pRhSbK4/Ka+qMo4V92WsQtQk9TyAOPL7QDYb/iOJCYZZ/xuoAkLEyCmry7G
 KeWbH1LhLbKT2VsUWi+0vr4ibSI4wCFRzEDxtSdjtbrxo3JuQB2FTUrVtC+Wg0mqnvCI
 ykWk+Dpp0uT4lRutMeJfyS2Um7hnfXV+KYpYXRenf1aGsDmfftE9i2E9/ulFsQY6aD9h
 oaZC7G+lYqLH8QG3J3kSvVE1EL881Soqqm8lcKWq7MwSPdnlQeLOciY5pc5IommPzEE2
 ZOBul6tvbNCvBu0gTHxVdWrBm5JjDEs/xtE9Anq10/FNBnc92eORMhjNoCaWmmYbgcbY
 /Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394599; x=1763999399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JOTWnKm4DTCGpZ1/a5sMZIlg2R2K5QNc87Tidro0ZBI=;
 b=K4HV2m6NoIgiVezpkFY32DgFOSWflUj/oabNDq1+MMMVt8Cz16ihdo/EGyrTGEMgsI
 i82jj1FgFf5LIfutqmh1tSfsIY9kWGtFTzg1LResDMYpCwMG5uUL+xa/J8DtQWpTJ6QL
 l9yH/2L2z2xdV3+wzR8DEjKELI1Brsr5MSeQhjlCIBhk9sWJF4Ra/xjAeyk5evtuhDJA
 y4PdC4etn45lB7SKU775HWDGQEtvKNd3D6OFZbjjQCmJXHizEiltpA7d+Hu7Z8DSmdQc
 bLowyk3zbV2lsl2QhmPajSj7Xmer6SjGRJXBzJ3+pEPtpDfiw/AstkAEzanLyvP0+2yC
 flEQ==
X-Gm-Message-State: AOJu0YyOMAp/6zUt5J+KOWC8z/M07nVG+QjELqqDJ2eqUCd36nSt+lU8
 ZGD3l9OeGMyZBHH+fuY3Qj5OVXqNR/12t5s167Y3igI4cHgrKdQgn7NqR35LfFdPg9g=
X-Gm-Gg: ASbGnctU5lpxvyrW8WuXUdG6+lIxyzpGtWBHxXO8qf/h5iOJClMMtBLAtTOePz8p/tZ
 ZYMVbbnnZ7zJwtaDmTmggLHJ9xhjUguh+7wkU7a+wFqZP98qYw3TT12VWZ3b1AzdqKKHy00QZyo
 60wBefuiAwE6hluUXWFoj6JR2NNCO9dmpIuIizEPLkOf5ziww7y2n5jvP7rbOPFjNlVWjY+07Sg
 UJooTQcdA9G4j8LP1F6bWoV4tTSxSLdoppx2t69Rhn6trAZVxVvJ4X/3zbqKKOISg6+z9h22MwA
 HECdtmDr9unHEURxc5BVD+T+gMjLKQZjRnQBORCe2A26d+ICWfDy40SkMtNV9Od6+qYR0RTSQv9
 UHs93rk7JAg+sEt3jUjMp2ZMxSiwWauV9k7CtOzY/ObHsgxyzXPfaNH3mO0pN6ZWs+wPENLagLk
 9hblSbxH0p5Iw=
X-Google-Smtp-Source: AGHT+IFPfEQ4ubAj92QzXzLxhQLrDnGI41swdstS8gMVmIXnORI9UOPszWp/ozInWZbWCzEvfcTmrg==
X-Received: by 2002:a05:600c:4707:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-4779eb89abfmr57844505e9.8.1763394598573; 
 Mon, 17 Nov 2025 07:49:58 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47799768409sm144630225e9.3.2025.11.17.07.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 225E95F860;
 Mon, 17 Nov 2025 15:49:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 18/18] gitlab: add a weekly container building job
Date: Mon, 17 Nov 2025 15:49:47 +0000
Message-ID: <20251117154948.4122164-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
Message-ID: <20251117115523.3993105-19-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


