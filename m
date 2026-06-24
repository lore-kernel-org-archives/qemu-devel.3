Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20482CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcN1L-0005mu-9q; Wed, 24 Jun 2026 08:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcN0h-0004o1-E3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcN0e-0006YE-8N
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782305235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2A4QuDgemvw1Sf+etVFj4hgRALEHALqTXi3Iy1ErUg=;
 b=AKRrXG8UrlyyL+cfOw3a1fK6heS/2UnGcW32yxOv/i+uCPNFezf5hxtdutu33K+m5oWVJc
 mCOV2Verxomjs2JadIQWoWFXXii17VOy4ABT5Ob+oC8dYtCRF+QIaK0yhio66VH+FstEEh
 RFWwOr//UbMCWXw1Dbdwb6FTSRqmnxg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-K3xmHSqMNyeshdYPz4O4CQ-1; Wed,
 24 Jun 2026 08:47:12 -0400
X-MC-Unique: K3xmHSqMNyeshdYPz4O4CQ-1
X-Mimecast-MFC-AGG-ID: K3xmHSqMNyeshdYPz4O4CQ_1782305231
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40B761956080; Wed, 24 Jun 2026 12:47:11 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.57])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C94791956049; Wed, 24 Jun 2026 12:47:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 5/6] gitlab: pull before_script logic into
 .base_meson_job_template
Date: Wed, 24 Jun 2026 13:46:56 +0100
Message-ID: <20260624124657.2725376-6-berrange@redhat.com>
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

This ensures that all jobs have the $JOBS env set and capture the
packages.txt content (where available) in their logs, and all use
the job section headers.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/base.yml                |  9 +++++++++
 .gitlab-ci.d/buildtest-template.yml  | 24 ++----------------------
 .gitlab-ci.d/crossbuild-template.yml | 12 ------------
 3 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 6289c7e5c3..a75fb37d61 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -143,6 +143,15 @@ variables:
       - build/meson-logs
     reports:
       junit: build/meson-logs/*.junit.xml
+  before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
+    - JOBS=$(expr $(nproc) + 1)
+    # Prevent logs (if any) from prior build job artifacts
+    # from being duplicated in the new job artifacts
+    - rm -f build/meson-logs/*
+    - test -f /packages.txt && cat /packages.txt
+    - section_end setup
 
 .base_meson_ccache_job_template:
   extends: .base_meson_job_template
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 8dfd17a0b5..11d7a75667 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -3,12 +3,6 @@
   extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  before_script:
-    - source scripts/ci/gitlab-ci-section
-    - section_start setup "Pre-script setup"
-    - JOBS=$(expr $(nproc) + 1)
-    - cat /packages.txt
-    - section_end setup
   script:
     - !reference [.base_meson_ccache_job_template, script]
     - du -sh .git
@@ -74,11 +68,6 @@
 
 .native_test_job_template:
   extends: .common_test_job_template
-  before_script:
-    # Prevent logs from the build job that run earlier
-    # from being duplicated in the test job artifacts
-    - rm -f build/meson-logs/*
-
 
 .functional_test_job_template:
   extends: .common_test_job_template
@@ -96,27 +85,18 @@
       - build/tests/functional/*/*/*.log
     reports:
       junit: build/meson-logs/*.junit.xml
-  before_script:
-    - export QEMU_TEST_ALLOW_UNTRUSTED_CODE=1
-    - export QEMU_TEST_CACHE_DIR=${CI_PROJECT_DIR}/functional-cache
-    # Prevent logs from the build job that run earlier
-    # from being duplicated in the test job artifacts
-    - rm -f build/meson-logs/*
   after_script:
     - cd build
     - du -chs ${CI_PROJECT_DIR}/*-cache
   variables:
     QEMU_JOB_FUNCTIONAL: 1
+    QEMU_TEST_ALLOW_UNTRUSTED_CODE: 1
+    QEMU_TEST_CACHE_DIR: ${CI_PROJECT_DIR}/functional-cache
 
 .wasm_build_job_template:
   extends: .base_meson_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  before_script:
-    - source scripts/ci/gitlab-ci-section
-    - section_start setup "Pre-script setup"
-    - JOBS=$(expr $(nproc) + 1)
-    - section_end setup
   script:
     - du -sh .git
     - mkdir build
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index aadae26844..94423814a7 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -3,12 +3,6 @@
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   timeout: 80m
-  before_script:
-    - source scripts/ci/gitlab-ci-section
-    - section_start setup "Pre-script setup"
-    - JOBS=$(expr $(nproc) + 1)
-    - cat /packages.txt
-    - section_end setup
   script:
     - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
@@ -48,9 +42,6 @@
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   timeout: 60m
-  before_script:
-    - source scripts/ci/gitlab-ci-section
-    - JOBS=$(expr $(nproc) + 1)
   script:
     - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
@@ -73,9 +64,6 @@
   extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  before_script:
-    - source scripts/ci/gitlab-ci-section
-    - JOBS=$(expr $(nproc) + 1)
   script:
     - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
-- 
2.54.0


