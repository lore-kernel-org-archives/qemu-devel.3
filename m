Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FE1CAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OFA-0000rI-4F; Wed, 24 Sep 2025 08:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OF8-0000qH-Sl
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OEz-0005lS-FQ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758715495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P5Q8lCd19u8w9C29Wg7kipakMeKWcFiotzcPqtpJo08=;
 b=CWEoPsGyZS+kuj6/WYSOMqEVICh5s6Jrtf+aq7ikJpq8xCpDoCaWnNUvzvDx6CKtb2+eJo
 YxunBbTZgEhPNav5wu7ChMx7XCfIqRUVvsb5A1gOlkchXxiD41mQi3H9XTeyTZ8blqFzMM
 kw0WeL9JndyOukiSt8eWJPD6g+e4Fhc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-CMmDNGxOPAWt8SpaejxBAA-1; Wed,
 24 Sep 2025 08:04:51 -0400
X-MC-Unique: CMmDNGxOPAWt8SpaejxBAA-1
X-Mimecast-MFC-AGG-ID: CMmDNGxOPAWt8SpaejxBAA_1758715489
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6A0219560BA; Wed, 24 Sep 2025 12:04:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C907E1800446; Wed, 24 Sep 2025 12:04:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PATCH v2 02/27] gitlab-ci: fix 'needs' property type must be array
Date: Wed, 24 Sep 2025 16:03:59 +0400
Message-ID: <20250924120426.2158655-3-marcandre.lureau@redhat.com>
In-Reply-To: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The gitlab "Pipeline editor" has some warnings, and gitlab-ci-local
fails.

Read also from the docs

   https://docs.gitlab.com/ci/yaml/#needs

"Supported values:

    An array of jobs (maximum of 50 jobs).
    An empty array ([]), to set the job to start as soon as the pipeline
    is created."

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/buildtest.yml     | 56 +++++++++++++++++-----------------
 .gitlab-ci.d/crossbuilds.yml   | 46 ++++++++++++++--------------
 .gitlab-ci.d/static_checks.yml |  6 ++--
 3 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index f01978fb40..f8d7b6c3ac 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -36,7 +36,7 @@ build-system-ubuntu:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    job: amd64-ubuntu2204-container
+    - job: amd64-ubuntu2204-container
   variables:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-docs
@@ -66,7 +66,7 @@ build-system-debian:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    job: amd64-debian-container
+    - job: amd64-debian-container
   variables:
     IMAGE: debian
     CONFIGURE_ARGS: --with-coroutine=sigaltstack --enable-rust
@@ -109,7 +109,7 @@ build-system-fedora:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    job: amd64-fedora-container
+    - job: amd64-fedora-container
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs --enable-crypto-afalg --enable-rust
@@ -122,7 +122,7 @@ build-system-fedora-rust-nightly:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    job: amd64-fedora-rust-nightly-container
+    - job: amd64-fedora-rust-nightly-container
   variables:
     IMAGE: fedora-rust-nightly
     CONFIGURE_ARGS: --disable-docs --enable-rust --enable-strict-rust-lints
@@ -167,7 +167,7 @@ build-system-centos:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    job: amd64-centos9-container
+    - job: amd64-centos9-container
   variables:
     IMAGE: centos9
     CONFIGURE_ARGS: --disable-nettle --enable-gcrypt --enable-vfio-user-server
@@ -189,7 +189,7 @@ build-previous-qemu:
       - build-previous/tests/qtest/migration-test
       - build-previous/scripts
   needs:
-    job: amd64-opensuse-leap-container
+    - job: amd64-opensuse-leap-container
   variables:
     IMAGE: opensuse-leap
     TARGETS: x86_64-softmmu aarch64-softmmu
@@ -274,7 +274,7 @@ build-system-opensuse:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    job: amd64-opensuse-leap-container
+    - job: amd64-opensuse-leap-container
   variables:
     IMAGE: opensuse-leap
     TARGETS: s390x-softmmu x86_64-softmmu aarch64-softmmu
@@ -308,7 +308,7 @@ build-system-flaky:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    job: amd64-debian-container
+    - job: amd64-debian-container
   variables:
     IMAGE: debian
     QEMU_JOB_OPTIONAL: 1
@@ -338,7 +338,7 @@ functional-system-flaky:
 build-tcg-disabled:
   extends: .native_build_job_template
   needs:
-    job: amd64-centos9-container
+    - job: amd64-centos9-container
   variables:
     IMAGE: centos9
   script:
@@ -364,7 +364,7 @@ build-tcg-disabled:
 build-user:
   extends: .native_build_job_template
   needs:
-    job: amd64-debian-user-cross-container
+    - job: amd64-debian-user-cross-container
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system
@@ -374,7 +374,7 @@ build-user:
 build-user-static:
   extends: .native_build_job_template
   needs:
-    job: amd64-debian-user-cross-container
+    - job: amd64-debian-user-cross-container
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system --static
@@ -385,7 +385,7 @@ build-user-static:
 build-legacy:
   extends: .native_build_job_template
   needs:
-    job: amd64-debian-legacy-cross-container
+    - job: amd64-debian-legacy-cross-container
   variables:
     IMAGE: debian-legacy-test-cross
     TARGETS: alpha-linux-user alpha-softmmu sh4-linux-user
@@ -395,7 +395,7 @@ build-legacy:
 build-user-hexagon:
   extends: .native_build_job_template
   needs:
-    job: hexagon-cross-container
+    - job: hexagon-cross-container
   variables:
     IMAGE: debian-hexagon-cross
     TARGETS: hexagon-linux-user
@@ -408,7 +408,7 @@ build-user-hexagon:
 build-some-softmmu:
   extends: .native_build_job_template
   needs:
-    job: amd64-debian-user-cross-container
+    - job: amd64-debian-user-cross-container
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --enable-debug
@@ -419,7 +419,7 @@ build-some-softmmu:
 build-loongarch64:
   extends: .native_build_job_template
   needs:
-    job: loongarch-debian-cross-container
+    - job: loongarch-debian-cross-container
   variables:
     IMAGE: debian-loongarch-cross
     CONFIGURE_ARGS: --disable-tools --enable-debug
@@ -430,7 +430,7 @@ build-loongarch64:
 build-tricore-softmmu:
   extends: .native_build_job_template
   needs:
-    job: tricore-debian-cross-container
+    - job: tricore-debian-cross-container
   variables:
     IMAGE: debian-tricore-cross
     CONFIGURE_ARGS: --disable-tools --disable-fdt --enable-debug
@@ -440,7 +440,7 @@ build-tricore-softmmu:
 clang-system:
   extends: .native_build_job_template
   needs:
-    job: amd64-fedora-container
+    - job: amd64-fedora-container
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan
@@ -451,7 +451,7 @@ clang-system:
 clang-user:
   extends: .native_build_job_template
   needs:
-    job: amd64-debian-user-cross-container
+    - job: amd64-debian-user-cross-container
   timeout: 70m
   variables:
     IMAGE: debian-all-test-cross
@@ -582,7 +582,7 @@ functional-cfi-x86_64:
 tsan-build:
   extends: .native_build_job_template
   needs:
-    job: amd64-ubuntu2204-container
+    - job: amd64-ubuntu2204-container
   variables:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-tsan --cc=clang --cxx=clang++
@@ -596,7 +596,7 @@ tsan-build:
 gcov:
   extends: .native_build_job_template
   needs:
-    job: amd64-ubuntu2204-container
+    - job: amd64-ubuntu2204-container
   timeout: 80m
   variables:
     IMAGE: ubuntu2204
@@ -623,7 +623,7 @@ gcov:
 build-oss-fuzz:
   extends: .native_build_job_template
   needs:
-    job: amd64-fedora-container
+    - job: amd64-fedora-container
   variables:
     IMAGE: fedora
   script:
@@ -645,7 +645,7 @@ build-oss-fuzz:
 build-tci:
   extends: .native_build_job_template
   needs:
-    job: amd64-debian-user-cross-container
+    - job: amd64-debian-user-cross-container
   variables:
     IMAGE: debian-all-test-cross
   script:
@@ -670,7 +670,7 @@ build-tci:
 build-without-defaults:
   extends: .native_build_job_template
   needs:
-    job: amd64-centos9-container
+    - job: amd64-centos9-container
   variables:
     IMAGE: centos9
     CONFIGURE_ARGS:
@@ -688,7 +688,7 @@ build-libvhost-user:
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/fedora:$QEMU_CI_CONTAINER_TAG
   needs:
-    job: amd64-fedora-container
+    - job: amd64-fedora-container
   script:
     - mkdir subprojects/libvhost-user/build
     - cd subprojects/libvhost-user/build
@@ -702,9 +702,9 @@ build-tools-and-docs-debian:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    job: amd64-debian-container
-    # when running on 'master' we use pre-existing container
-    optional: true
+    - job: amd64-debian-container
+      # when running on 'master' we use pre-existing container
+      optional: true
   variables:
     IMAGE: debian
     MAKE_CHECK_ARGS: check-unit ctags TAGS cscope
@@ -791,7 +791,7 @@ build-wasm:
   extends: .wasm_build_job_template
   timeout: 2h
   needs:
-    job: wasm-emsdk-cross-container
+    - job: wasm-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm32-cross
     CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 3f76c901ba..8ff0c27f74 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -4,28 +4,28 @@ include:
 cross-armhf-user:
   extends: .cross_user_build_job
   needs:
-    job: armhf-debian-cross-container
+    - job: armhf-debian-cross-container
   variables:
     IMAGE: debian-armhf-cross
 
 cross-arm64-system:
   extends: .cross_system_build_job
   needs:
-    job: arm64-debian-cross-container
+    - job: arm64-debian-cross-container
   variables:
     IMAGE: debian-arm64-cross
 
 cross-arm64-user:
   extends: .cross_user_build_job
   needs:
-    job: arm64-debian-cross-container
+    - job: arm64-debian-cross-container
   variables:
     IMAGE: debian-arm64-cross
 
 cross-arm64-kvm-only:
   extends: .cross_accel_build_job
   needs:
-    job: arm64-debian-cross-container
+    - job: arm64-debian-cross-container
   variables:
     IMAGE: debian-arm64-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
@@ -35,7 +35,7 @@ cross-i686-system:
     - .cross_system_build_job
     - .cross_test_artifacts
   needs:
-    job: i686-debian-cross-container
+    - job: i686-debian-cross-container
   variables:
     IMAGE: debian-i686-cross
     EXTRA_CONFIGURE_OPTS: --disable-kvm
@@ -46,7 +46,7 @@ cross-i686-user:
     - .cross_user_build_job
     - .cross_test_artifacts
   needs:
-    job: i686-debian-cross-container
+    - job: i686-debian-cross-container
   variables:
     IMAGE: debian-i686-cross
     MAKE_CHECK_ARGS: check
@@ -57,7 +57,7 @@ cross-i686-tci:
     - .cross_test_artifacts
   timeout: 60m
   needs:
-    job: i686-debian-cross-container
+    - job: i686-debian-cross-container
   variables:
     IMAGE: debian-i686-cross
     ACCEL: tcg-interpreter
@@ -71,49 +71,49 @@ cross-i686-tci:
 cross-mipsel-system:
   extends: .cross_system_build_job
   needs:
-    job: mipsel-debian-cross-container
+    - job: mipsel-debian-cross-container
   variables:
     IMAGE: debian-mipsel-cross
 
 cross-mipsel-user:
   extends: .cross_user_build_job
   needs:
-    job: mipsel-debian-cross-container
+    - job: mipsel-debian-cross-container
   variables:
     IMAGE: debian-mipsel-cross
 
 cross-mips64el-system:
   extends: .cross_system_build_job
   needs:
-    job: mips64el-debian-cross-container
+    - job: mips64el-debian-cross-container
   variables:
     IMAGE: debian-mips64el-cross
 
 cross-mips64el-user:
   extends: .cross_user_build_job
   needs:
-    job: mips64el-debian-cross-container
+    - job: mips64el-debian-cross-container
   variables:
     IMAGE: debian-mips64el-cross
 
 cross-ppc64el-system:
   extends: .cross_system_build_job
   needs:
-    job: ppc64el-debian-cross-container
+    - job: ppc64el-debian-cross-container
   variables:
     IMAGE: debian-ppc64el-cross
 
 cross-ppc64el-user:
   extends: .cross_user_build_job
   needs:
-    job: ppc64el-debian-cross-container
+    - job: ppc64el-debian-cross-container
   variables:
     IMAGE: debian-ppc64el-cross
 
 cross-ppc64el-kvm-only:
   extends: .cross_accel_build_job
   needs:
-    job: ppc64el-debian-cross-container
+    - job: ppc64el-debian-cross-container
   variables:
     IMAGE: debian-ppc64el-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-devices
@@ -121,35 +121,35 @@ cross-ppc64el-kvm-only:
 cross-riscv64-system:
   extends: .cross_system_build_job
   needs:
-    job: riscv64-debian-cross-container
+    - job: riscv64-debian-cross-container
   variables:
     IMAGE: debian-riscv64-cross
 
 cross-riscv64-user:
   extends: .cross_user_build_job
   needs:
-    job: riscv64-debian-cross-container
+    - job: riscv64-debian-cross-container
   variables:
     IMAGE: debian-riscv64-cross
 
 cross-s390x-system:
   extends: .cross_system_build_job
   needs:
-    job: s390x-debian-cross-container
+    - job: s390x-debian-cross-container
   variables:
     IMAGE: debian-s390x-cross
 
 cross-s390x-user:
   extends: .cross_user_build_job
   needs:
-    job: s390x-debian-cross-container
+    - job: s390x-debian-cross-container
   variables:
     IMAGE: debian-s390x-cross
 
 cross-s390x-kvm-only:
   extends: .cross_accel_build_job
   needs:
-    job: s390x-debian-cross-container
+    - job: s390x-debian-cross-container
   variables:
     IMAGE: debian-s390x-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --enable-trace-backends=ftrace
@@ -157,7 +157,7 @@ cross-s390x-kvm-only:
 cross-mips64el-kvm-only:
   extends: .cross_accel_build_job
   needs:
-    job: mips64el-debian-cross-container
+    - job: mips64el-debian-cross-container
   variables:
     IMAGE: debian-mips64el-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --target-list=mips64el-softmmu
@@ -165,7 +165,7 @@ cross-mips64el-kvm-only:
 cross-win64-system:
   extends: .cross_system_build_job
   needs:
-    job: win64-fedora-cross-container
+    - job: win64-fedora-cross-container
   variables:
     IMAGE: fedora-win64-cross
     EXTRA_CONFIGURE_OPTS: --enable-fdt=internal --disable-plugins
@@ -181,7 +181,7 @@ cross-win64-system:
 cross-amd64-xen-only:
   extends: .cross_accel_build_job
   needs:
-    job: amd64-debian-cross-container
+    - job: amd64-debian-cross-container
   variables:
     IMAGE: debian-amd64-cross
     ACCEL: xen
@@ -190,7 +190,7 @@ cross-amd64-xen-only:
 cross-arm64-xen-only:
   extends: .cross_accel_build_job
   needs:
-    job: arm64-debian-cross-container
+    - job: arm64-debian-cross-container
   variables:
     IMAGE: debian-arm64-cross
     ACCEL: xen
diff --git a/.gitlab-ci.d/static_checks.yml b/.gitlab-ci.d/static_checks.yml
index c3ed6de453..61fe2fa39a 100644
--- a/.gitlab-ci.d/static_checks.yml
+++ b/.gitlab-ci.d/static_checks.yml
@@ -32,7 +32,7 @@ check-python-minreqs:
   variables:
     GIT_DEPTH: 1
   needs:
-    job: python-container
+    - job: python-container
 
 check-python-tox:
   extends: .base_job_template
@@ -45,7 +45,7 @@ check-python-tox:
     QEMU_TOX_EXTRA_ARGS: --skip-missing-interpreters=false
     QEMU_JOB_OPTIONAL: 1
   needs:
-    job: python-container
+    - job: python-container
 
 check-rust-tools-nightly:
   extends: .base_job_template
@@ -76,7 +76,7 @@ check-build-units:
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/debian:$QEMU_CI_CONTAINER_TAG
   needs:
-    job: amd64-debian-container
+    - job: amd64-debian-container
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Install Tools"
-- 
2.51.0


