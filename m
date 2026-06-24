Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49BACDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcN1N-000683-DY; Wed, 24 Jun 2026 08:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcN0c-0004Z5-19
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcN0Z-0006Xc-9L
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782305229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7pMOxsT8ySu/3aDedy1T18ifFSESdGAWeg2Erc61moY=;
 b=hy1VLHDwxLTXJiU4zA/s3o7HxSuecjqjeVdlJCgvyzkA5XXiGyFmkCfwazIzjyZBdySsbb
 SpUOSlr+INHjiWXAYDsaMvRjaEx6+FJv5o9mqoSxw0XAyqA5mvjifWrhl3Ss8i0r223ut4
 nH4u0tn6DV23ll/GX4Kz/+qWTdk/m+Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-04c5SbdHNry_sTzP3cXvRw-1; Wed,
 24 Jun 2026 08:47:06 -0400
X-MC-Unique: 04c5SbdHNry_sTzP3cXvRw-1
X-Mimecast-MFC-AGG-ID: 04c5SbdHNry_sTzP3cXvRw_1782305225
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 238AA1956080; Wed, 24 Jun 2026 12:47:05 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.57])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB9B61956049; Wed, 24 Jun 2026 12:47:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/6] gitlab: move .meson_job_template into base.yaml
Date: Wed, 24 Jun 2026 13:46:53 +0100
Message-ID: <20260624124657.2725376-3-berrange@redhat.com>
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

Rename .meson_job_template to .base_meson_job_template and move
it into base.yml, in prep for wider reuse.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/base.yml               | 14 ++++++++++++++
 .gitlab-ci.d/buildtest-template.yml | 20 +++-----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 72eadc8073..dc36a1ca11 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -129,3 +129,17 @@ variables:
         QEMU_CI_CONTAINER_TAG: $CI_COMMIT_REF_SLUG
 
     - when: on_success
+
+# Any job running meson should capture meson logs
+# by default. Some jobs might override the artifacts
+# to capture further files
+.base_meson_job_template:
+  extends: .base_job_template
+  artifacts:
+    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
+    when: always
+    expire_in: 7 days
+    paths:
+      - build/meson-logs
+    reports:
+      junit: build/meson-logs/*.junit.xml
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 005058625e..0fa2351d87 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -1,20 +1,6 @@
 
-# Any job running meson should capture meson logs
-# by default. Some jobs might override the artifacts
-# to capture further files
-.meson_job_template:
-  extends: .base_job_template
-  artifacts:
-    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
-    when: always
-    expire_in: 7 days
-    paths:
-      - build/meson-logs
-    reports:
-      junit: build/meson-logs/*.junit.xml
-
 .native_build_job_template:
-  extends: .meson_job_template
+  extends: .base_meson_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   cache:
@@ -75,7 +61,7 @@
       - build/**/*.c.o.d
 
 .common_test_job_template:
-  extends: .meson_job_template
+  extends: .base_meson_job_template
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   script:
@@ -133,7 +119,7 @@
     QEMU_JOB_FUNCTIONAL: 1
 
 .wasm_build_job_template:
-  extends: .meson_job_template
+  extends: .base_meson_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   before_script:
-- 
2.54.0


