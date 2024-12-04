Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5688E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvMK-0004jY-Mr; Wed, 04 Dec 2024 14:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIvMF-0004j2-V1
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:48:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIvME-0000jW-H2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733341700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iB40+CdfGiCZrwqYDuttl0n++gcanzaNfeSPhLoNLeg=;
 b=QLA3ewzOVFLPUtpymCvVkd7Txx5+1NK2rcXaBGekpe/rWaI6nj3w7b2lnf4rC25dz42pxB
 TyHfljsRpO7C9CpMAp5EIT+M16qX30E6bjVniBeNZUAJQ03xbMUykc1CPgKWK1gZuzU3TE
 w6FsBDWr46mQqGmDQUo9u/qLaQM5F/g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-0YahhZRkMaiQgIAPZ5qL-Q-1; Wed,
 04 Dec 2024 14:48:17 -0500
X-MC-Unique: 0YahhZRkMaiQgIAPZ5qL-Q-1
X-Mimecast-MFC-AGG-ID: 0YahhZRkMaiQgIAPZ5qL-Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EFBD1955E8C; Wed,  4 Dec 2024 19:48:16 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB27419560A2; Wed,  4 Dec 2024 19:48:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/7] gitlab: use new(ish) cirrus-vars command for creating
 config
Date: Wed,  4 Dec 2024 19:48:02 +0000
Message-ID: <20241204194807.1472261-3-berrange@redhat.com>
In-Reply-To: <20241204194807.1472261-1-berrange@redhat.com>
References: <20241204194807.1472261-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rather than a giant sed command with a hardcoded list of env var name,
we can now use the new(ish) cirrus-vars command that libvirt has added
to the 'cirrus-run' container.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/cirrus.yml       | 23 +++--------------------
 .gitlab-ci.d/cirrus/build.yml |  2 +-
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index adc0007e5d..16411f3d2b 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -22,27 +22,10 @@
   # actually starts the task
   timeout: 80m
   script:
+    - set -o allexport
     - source .gitlab-ci.d/cirrus/$NAME.vars
-    - sed -e "s|[@]CI_REPOSITORY_URL@|$CI_REPOSITORY_URL|g"
-          -e "s|[@]CI_COMMIT_REF_NAME@|$CI_COMMIT_REF_NAME|g"
-          -e "s|[@]CI_COMMIT_SHA@|$CI_COMMIT_SHA|g"
-          -e "s|[@]CIRRUS_VM_INSTANCE_TYPE@|$CIRRUS_VM_INSTANCE_TYPE|g"
-          -e "s|[@]CIRRUS_VM_IMAGE_SELECTOR@|$CIRRUS_VM_IMAGE_SELECTOR|g"
-          -e "s|[@]CIRRUS_VM_IMAGE_NAME@|$CIRRUS_VM_IMAGE_NAME|g"
-          -e "s|[@]CIRRUS_VM_CPUS@|$CIRRUS_VM_CPUS|g"
-          -e "s|[@]CIRRUS_VM_RAM@|$CIRRUS_VM_RAM|g"
-          -e "s|[@]UPDATE_COMMAND@|$UPDATE_COMMAND|g"
-          -e "s|[@]INSTALL_COMMAND@|$INSTALL_COMMAND|g"
-          -e "s|[@]PATH@|$PATH_EXTRA${PATH_EXTRA:+:}\$PATH|g"
-          -e "s|[@]PKG_CONFIG_PATH@|$PKG_CONFIG_PATH|g"
-          -e "s|[@]PKGS@|$PKGS|g"
-          -e "s|[@]MAKE@|$MAKE|g"
-          -e "s|[@]PYTHON@|$PYTHON|g"
-          -e "s|[@]PIP3@|$PIP3|g"
-          -e "s|[@]PYPI_PKGS@|$PYPI_PKGS|g"
-          -e "s|[@]CONFIGURE_ARGS@|$CONFIGURE_ARGS|g"
-          -e "s|[@]TEST_TARGETS@|$TEST_TARGETS|g"
-      <.gitlab-ci.d/cirrus/build.yml >.gitlab-ci.d/cirrus/$NAME.yml
+    - set +o allexport
+    - cirrus-vars <.gitlab-ci.d/cirrus/build.yml >.gitlab-ci.d/cirrus/$NAME.yml
     - cat .gitlab-ci.d/cirrus/$NAME.yml
     - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml
   variables:
diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
index 102cdbd8b1..41abd0b31a 100644
--- a/.gitlab-ci.d/cirrus/build.yml
+++ b/.gitlab-ci.d/cirrus/build.yml
@@ -8,7 +8,7 @@ env:
   CI_REPOSITORY_URL: "@CI_REPOSITORY_URL@"
   CI_COMMIT_REF_NAME: "@CI_COMMIT_REF_NAME@"
   CI_COMMIT_SHA: "@CI_COMMIT_SHA@"
-  PATH: "@PATH@"
+  PATH: "@PATH_EXTRA@:$PATH"
   PKG_CONFIG_PATH: "@PKG_CONFIG_PATH@"
   PYTHON: "@PYTHON@"
   MAKE: "@MAKE@"
-- 
2.46.0


