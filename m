Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67716CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 19:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvhFQ-0005Zn-9k; Mon, 08 Sep 2025 15:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvhFE-0005BV-VK
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvhEy-0000Ue-Dd
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757358558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Py4y9yOMQACrXx8cwGLeKInInitOjleGlwKwgpjs8PI=;
 b=hCKXA2lAY6OkWD/9otn4DclMrJkftKoUlyvHBXwherRKZeVnGDGxnI2cHLoTkKxjqWCLYk
 MsLuI1gbSvraw4pDip42c+/Tq4HMkwY7oBEbNilFB6lz0/ddp1GakpIKL7320UKn9nadgy
 3N5yWQl+c8skTp8AduJKQMiPW9c7EwE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-lF9Q828lOoGQwdOsvf3gBA-1; Mon,
 08 Sep 2025 15:09:15 -0400
X-MC-Unique: lF9Q828lOoGQwdOsvf3gBA-1
X-Mimecast-MFC-AGG-ID: lF9Q828lOoGQwdOsvf3gBA_1757358553
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 389511800289; Mon,  8 Sep 2025 19:09:13 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26E5619560A2; Mon,  8 Sep 2025 19:09:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/4] gitlab: include all junit XML files from meson
Date: Mon,  8 Sep 2025 20:09:00 +0100
Message-ID: <20250908190901.3571859-4-berrange@redhat.com>
In-Reply-To: <20250908190901.3571859-1-berrange@redhat.com>
References: <20250908190901.3571859-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
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

The junit XML file produced by meson does not always have the
name 'testlog.junit.xml' - in the case of 'make check-functional'
there is a 'testlog-thorough.junit.xml' file too.

Improve CI debugging robustness by capturing all junit files that
meson produces.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml  | 4 ++--
 .gitlab-ci.d/buildtest.yml           | 2 +-
 .gitlab-ci.d/crossbuild-template.yml | 2 +-
 .gitlab-ci.d/custom-runners.yml      | 2 +-
 .gitlab-ci.d/windows.yml             | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 4cc5b20790..308490a35a 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -90,7 +90,7 @@
     paths:
       - build/meson-logs
     reports:
-      junit: build/meson-logs/testlog.junit.xml
+      junit: build/meson-logs/*.junit.xml
 
 .functional_test_job_template:
   extends: .common_test_job_template
@@ -107,7 +107,7 @@
       - build/meson-logs
       - build/tests/functional/*/*/*.log
     reports:
-      junit: build/meson-logs/testlog.junit.xml
+      junit: build/meson-logs/*.junit.xml
   before_script:
     - export QEMU_TEST_ALLOW_UNTRUSTED_CODE=1
     - export QEMU_TEST_CACHE_DIR=${CI_PROJECT_DIR}/functional-cache
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 778289267f..83c2867295 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -615,7 +615,7 @@ gcov:
     paths:
       - build/meson-logs
     reports:
-      junit: build/meson-logs/testlog.junit.xml
+      junit: build/meson-logs/*.junit.xml
       coverage_report:
         coverage_format: cobertura
         path: build/coverage.xml
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 7e70376cfc..58136d06e4 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -130,4 +130,4 @@
     paths:
       - build/meson-logs
     reports:
-      junit: build/meson-logs/testlog.junit.xml
+      junit: build/meson-logs/*.junit.xml
diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 1aa3c60efe..2d493f70f7 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -26,7 +26,7 @@
       - build/build.ninja
       - build/meson-logs
     reports:
-      junit: build/meson-logs/testlog.junit.xml
+      junit: build/meson-logs/*.junit.xml
 
 include:
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml'
diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index f14e9ca134..1e6a01bd9a 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -26,7 +26,7 @@ msys2-64bit:
     paths:
       - build/meson-logs
     reports:
-      junit: "build/meson-logs/testlog.junit.xml"
+      junit: build/meson-logs/*.junit.xml
   before_script:
   - Write-Output "Acquiring msys2.exe installer at $(Get-Date -Format u)"
   - If ( !(Test-Path -Path msys64\var\cache ) ) {
-- 
2.50.1


