Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5F1D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaaq-00059h-Oe; Thu, 15 Jan 2026 22:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaap-000597-1T
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:47 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaan-0005Jt-CI
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:46 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f3fba4a11so1499662b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534424; x=1769139224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzDXHHrlzlOvFG8u9bvgWF8ocDA0BIRZVJaj0j3UHCk=;
 b=m5OwzCJkLxa9eneWZ5koaL0oXhuHHOWGpsMQ8qOkneILXD91NHidUh/Ot3u/lQKva7
 6hBh4NuxoBSXxdVnq0ydoxcUnBWz7gBvuO0xOA5gSnSXuRVoZd8/VG/D6UOBay+3Ukz2
 iJq0bv9w2sYJXsLL7sM+y8HfaDWXE4P2N5C875g3vgDdHzrjxEpYm3a1jTo5GTBxlly8
 Qvu7cvrwbSEgHy5+y2izuFl5Q3HS/1fO/7iVtOtAM9IAOlhydRdk2fMjpnD2oD+gl0yF
 om4v4WOCPeWX/TW/nR9IDlc3nvxK4dxjANFJQh0VdtpGgny0oPkbz+FMDHHeOHASWi6A
 /prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534424; x=1769139224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zzDXHHrlzlOvFG8u9bvgWF8ocDA0BIRZVJaj0j3UHCk=;
 b=AYMlVkwVK8Bsn+OOgpLk3MbBOV8SQkQdUpowgFIAJVttVxCuW/IR2H79urdpfptmZ0
 0Gcu2agmg1F1vfEDaagougbrqS9M3rnESoGbEL/bGFQQmH1ymxV7K0fpzuk2odQLExq0
 fsgQOJ7kP6rzx8dyk2Pc+bPSvQpec2EPUUoZ2hUCRog0lkhxubAeaz5bXOrEhnJC8sis
 CcHTHjiEBdq4v7l/E4tUkbyyKXcl1SRT9z9nHSWRzfI9Bc1+qDfLyrn7w4Y+HFrZ3WuU
 eX5fag4gmEen1FShhibT72uywlFRE+2A3NPP42Dk/QZu0fD8N888WsmmXnVVbKeHVvRg
 xs3w==
X-Gm-Message-State: AOJu0YySVtBGo5MQoO6OjmDy89nD0C6sQRIH87xL7hNsTeMfB+WELSWw
 XjLwXhnZejE7/zIAJf+EiFPmXgf4vkY1CrbPlH+B/B9Y98e3hduBTSrM9q/ssVsjaaHDij+/Sy0
 QNxSoUdIJqg==
X-Gm-Gg: AY/fxX427CdF3abJ4cbJoak1uzhY4CpBIpJTUITH+fklPKjXEB6fWRM4T5TJOQu/y/l
 PxcTDHeFXjxtU2aRe7ey7xwiVpiGLZctvR8kAumuIcDLyHcbr2oL5mIlL3Ro3QZumryidtTVnfV
 /QmJoSSgm6s36egfVDrGrij3S1kFHqOU3Z4ZqzAHbvI6PK+o+MK2ZNvDWx8DphjPxz5bYRjoEBR
 cqsLJAvJBr0QeyYk0CIxIiwzxa+NqLDcoFwsvM9Q+obZmvePl7tY2NDH9fTJi6s3RuPXdfeZQcM
 iu6BG6zb3gD4QFvJUWiICe+9IdIohdzAHPpAV4Ez02Og6B2G7kOFmiUzuXQuktszQiI9SNbhYVj
 eu9P1rmZ/VvETJeLyUDxyRy9DYvoOBS9qEAJyZVaT4uPB53/yYwT6S01HmxF1q8MxBCRhX5Q2CM
 XMLfOx4+Es4bvosefPJjUyHgbwOzrx
X-Received: by 2002:a05:6a00:1891:b0:7f7:5783:fc6d with SMTP id
 d2e1a72fcca58-81fa01d9d58mr1350898b3a.41.1768534423881; 
 Thu, 15 Jan 2026 19:33:43 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:33:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 07/58] gitlab: Remove 32-bit host testing
Date: Fri, 16 Jan 2026 14:32:13 +1100
Message-ID: <20260116033305.51162-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

These deprecated builds will be disabled.
Remove testing of armhf and i686.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/container-cross.yml | 12 ---------
 .gitlab-ci.d/containers.yml      |  2 --
 .gitlab-ci.d/crossbuilds.yml     | 45 --------------------------------
 3 files changed, 59 deletions(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index b376c837dc..d7ae57fb1f 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -22,12 +22,6 @@ arm64-debian-cross-container:
   variables:
     NAME: debian-arm64-cross
 
-armhf-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-armhf-cross
-
 hexagon-cross-container:
   extends: .container_job_template
   stage: containers
@@ -40,12 +34,6 @@ loongarch-debian-cross-container:
   variables:
     NAME: debian-loongarch-cross
 
-i686-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-i686-cross
-
 mips64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 9b6d33ac13..6aeccf8be0 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -47,10 +47,8 @@ weekly-container-builds:
     - amd64-debian-user-cross-container
     - amd64-debian-legacy-cross-container
     - arm64-debian-cross-container
-    - armhf-debian-cross-container
     - hexagon-cross-container
     - loongarch-debian-cross-container
-    - i686-debian-cross-container
     - mips64el-debian-cross-container
     - ppc64el-debian-cross-container
     - riscv64-debian-cross-container
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 99dfa7eea6..59ff8b1d87 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -1,13 +1,6 @@
 include:
   - local: '/.gitlab-ci.d/crossbuild-template.yml'
 
-cross-armhf-user:
-  extends: .cross_user_build_job
-  needs:
-    - job: armhf-debian-cross-container
-  variables:
-    IMAGE: debian-armhf-cross
-
 cross-arm64-system:
   extends: .cross_system_build_job
   needs:
@@ -30,44 +23,6 @@ cross-arm64-kvm-only:
     IMAGE: debian-arm64-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
 
-cross-i686-system:
-  extends:
-    - .cross_system_build_job
-    - .cross_test_artifacts
-  needs:
-    - job: i686-debian-cross-container
-  variables:
-    IMAGE: debian-i686-cross
-    EXTRA_CONFIGURE_OPTS: --disable-kvm
-    MAKE_CHECK_ARGS: check-qtest
-
-cross-i686-user:
-  extends:
-    - .cross_user_build_job
-    - .cross_test_artifacts
-  needs:
-    - job: i686-debian-cross-container
-  variables:
-    IMAGE: debian-i686-cross
-    MAKE_CHECK_ARGS: check
-
-cross-i686-tci:
-  extends:
-    - .cross_accel_build_job
-    - .cross_test_artifacts
-  timeout: 60m
-  needs:
-    - job: i686-debian-cross-container
-  variables:
-    IMAGE: debian-i686-cross
-    ACCEL: tcg-interpreter
-    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,arm-softmmu,arm-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
-    # Force tests to run with reduced parallelism, to see whether this
-    # reduces the flakiness of this CI job. The CI
-    # environment by default shows us 8 CPUs and so we
-    # would otherwise be using a parallelism of 9.
-    MAKE_CHECK_ARGS: check check-tcg -j2
-
 cross-mips64el-system:
   extends: .cross_system_build_job
   needs:
-- 
2.43.0


