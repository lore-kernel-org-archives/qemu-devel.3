Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7DFCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcN1N-0006BC-Pk; Wed, 24 Jun 2026 08:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcN0e-0004mo-J9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcN0c-0006Y0-RZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782305233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nC5BWqSoFDGol8qL1Iqk8USAmrA3A8NrfIL1Ufwfc+8=;
 b=UxQuu158e9BS1z1yXWzYCVeKebb4aOgDd1HPlJ70drYMGahV8lsI7kPq/ljFMauKQYo672
 6uvrWh84Xcy4Xzu4VJqOH2ro2zMMI6vWGfcIF1L3mYltQpu78im1ZKkwsqKUq4yz6gmASw
 94T1rvWSHYX6uGNJp6ntAt6hoNWnSYA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-NnJ7aZmxNW66kU_QZv9osw-1; Wed,
 24 Jun 2026 08:47:10 -0400
X-MC-Unique: NnJ7aZmxNW66kU_QZv9osw-1
X-Mimecast-MFC-AGG-ID: NnJ7aZmxNW66kU_QZv9osw_1782305229
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C0F11955F72; Wed, 24 Jun 2026 12:47:09 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.57])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E216A1956049; Wed, 24 Jun 2026 12:47:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 4/6] gitlab: pull ccache setup into
 .base_meson_ccache_job_template
Date: Wed, 24 Jun 2026 13:46:55 +0100
Message-ID: <20260624124657.2725376-5-berrange@redhat.com>
In-Reply-To: <20260624124657.2725376-1-berrange@redhat.com>
References: <20260624124657.2725376-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This provides a consistent ccache setup across all build jobs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/base.yml                | 16 +++++++++++++
 .gitlab-ci.d/buildtest-template.yml  | 14 ++---------
 .gitlab-ci.d/crossbuild-template.yml | 35 +++++-----------------------
 3 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index dc36a1ca11..6289c7e5c3 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -143,3 +143,19 @@ variables:
       - build/meson-logs
     reports:
       junit: build/meson-logs/*.junit.xml
+
+.base_meson_ccache_job_template:
+  extends: .base_meson_job_template
+  cache:
+    paths:
+      - ccache
+    key: "$CI_JOB_NAME"
+    when: always
+  script:
+    - export CCACHE_BASEDIR="$(pwd)"
+    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
+    - export CCACHE_MAXSIZE="500M"
+    - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
+    - ccache --zero-stats
+  after_script:
+    - ccache --show-stats
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 0fa2351d87..8dfd17a0b5 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -1,13 +1,8 @@
 
 .native_build_job_template:
-  extends: .base_meson_job_template
+  extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  cache:
-    paths:
-      - ccache
-    key: "$CI_JOB_NAME"
-    when: always
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Pre-script setup"
@@ -15,14 +10,10 @@
     - cat /packages.txt
     - section_end setup
   script:
-    - export CCACHE_BASEDIR="$(pwd)"
-    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
-    - export CCACHE_MAXSIZE="500M"
-    - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
+    - !reference [.base_meson_ccache_job_template, script]
     - du -sh .git
     - mkdir build
     - cd build
-    - ccache --zero-stats
     - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
           --disable-debug-info
@@ -43,7 +34,6 @@
         $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
     - section_end test
-    - ccache --show-stats
 
 # We jump some hoops in common_test_job_template to avoid
 # rebuilding all the object files we skip in the artifacts
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 36bb9a405c..aadae26844 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -1,12 +1,7 @@
 .cross_system_build_job:
-  extends: .base_meson_job_template
+  extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  cache:
-    paths:
-      - ccache
-    key: "$CI_JOB_NAME"
-    when: always
   timeout: 80m
   before_script:
     - source scripts/ci/gitlab-ci-section
@@ -15,13 +10,9 @@
     - cat /packages.txt
     - section_end setup
   script:
-    - export CCACHE_BASEDIR="$(pwd)"
-    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
-    - export CCACHE_MAXSIZE="500M"
-    - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
+    - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
     - cd build
-    - ccache --zero-stats
     - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
         --disable-user $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS
@@ -46,7 +37,6 @@
       mv -v qemu-setup*.exe qemu-setup-${version}.exe;
       fi
     - section_end installer
-    - ccache --show-stats
 
 # Job to cross-build specific accelerators.
 #
@@ -54,22 +44,15 @@
 # KVM), and set extra options (such disabling other accelerators) via the
 # $EXTRA_CONFIGURE_OPTS variable.
 .cross_accel_build_job:
-  extends: .base_meson_job_template
+  extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   timeout: 60m
-  cache:
-    paths:
-      - ccache/
-    key: "$CI_JOB_NAME"
   before_script:
     - source scripts/ci/gitlab-ci-section
     - JOBS=$(expr $(nproc) + 1)
   script:
-    - export CCACHE_BASEDIR="$(pwd)"
-    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
-    - export CCACHE_MAXSIZE="500M"
-    - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
+    - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
     - cd build
     - section_start configure "Running configure"
@@ -87,20 +70,14 @@
     - section_end test
 
 .cross_user_build_job:
-  extends: .base_meson_job_template
+  extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  cache:
-    paths:
-      - ccache/
-    key: "$CI_JOB_NAME"
   before_script:
     - source scripts/ci/gitlab-ci-section
     - JOBS=$(expr $(nproc) + 1)
   script:
-    - export CCACHE_BASEDIR="$(pwd)"
-    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
-    - export CCACHE_MAXSIZE="500M"
+    - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
     - cd build
     - section_start configure "Running configure"
-- 
2.54.0


