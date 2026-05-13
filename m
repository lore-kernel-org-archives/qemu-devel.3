Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90601CD4F3E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 12:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN8Gu-0007kA-Le; Wed, 13 May 2026 08:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8GP-0007Rd-Np
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8GM-0004vZ-8I
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778673629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fY9OcW11dxOOLoYf4IzWR6za9PdJLoQv5J+dsb92vSY=;
 b=YKfWc2Xq96g9QvY2W4gAjrUx1jZPLAvFdekl2eQMcvuBEFYvJZHXb6QkSdgsBl9dH9ZOzD
 WXd+ShJ+4nhzpQtewMyjwyrpa/1sfNREfh9JjgVg56E/64vTWGG2nQZQ4wB5gzehWj4XlM
 h2Xj5OGUG/DW+gwXo8Mxfu6YR7rSwq4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-SY0e0IJ2OHiOtPXogarHig-1; Wed,
 13 May 2026 08:00:22 -0400
X-MC-Unique: SY0e0IJ2OHiOtPXogarHig-1
X-Mimecast-MFC-AGG-ID: SY0e0IJ2OHiOtPXogarHig_1778673620
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5B65195608E; Wed, 13 May 2026 12:00:20 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35992180056E; Wed, 13 May 2026 12:00:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v6 02/16] gitlab: ensure all meson jobs capture
 build/meson-logs by default
Date: Wed, 13 May 2026 12:59:49 +0100
Message-ID: <20260513120003.226790-3-berrange@redhat.com>
In-Reply-To: <20260513120003.226790-1-berrange@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The build-without-defaults and build-tci jobs do not capture any
artifacts, despite running 'make check'. This has proved a repeated
bug with CI jobs, so introduce a new '.meson_job_template' rule
which always captures 'build/meson-logs'. Jobs can still provide
their own 'artifacts:' config which will override this default
behaviour.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml | 30 ++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index d866cb12bb..005058625e 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -1,5 +1,20 @@
-.native_build_job_template:
+
+# Any job running meson should capture meson logs
+# by default. Some jobs might override the artifacts
+# to capture further files
+.meson_job_template:
   extends: .base_job_template
+  artifacts:
+    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
+    when: always
+    expire_in: 7 days
+    paths:
+      - build/meson-logs
+    reports:
+      junit: build/meson-logs/*.junit.xml
+
+.native_build_job_template:
+  extends: .meson_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   cache:
@@ -60,7 +75,7 @@
       - build/**/*.c.o.d
 
 .common_test_job_template:
-  extends: .base_job_template
+  extends: .meson_job_template
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   script:
@@ -87,14 +102,7 @@
     # Prevent logs from the build job that run earlier
     # from being duplicated in the test job artifacts
     - rm -f build/meson-logs/*
-  artifacts:
-    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
-    when: always
-    expire_in: 7 days
-    paths:
-      - build/meson-logs
-    reports:
-      junit: build/meson-logs/*.junit.xml
+
 
 .functional_test_job_template:
   extends: .common_test_job_template
@@ -125,7 +133,7 @@
     QEMU_JOB_FUNCTIONAL: 1
 
 .wasm_build_job_template:
-  extends: .base_job_template
+  extends: .meson_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   before_script:
-- 
2.54.0


