Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C498C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgr-00018m-Kz; Tue, 30 Apr 2024 03:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgp-00014n-Uv
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgo-0008SX-5N
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNfqWdCJaaAOktsdNMfyPhML7pGWVRz5Up9dTUGIj7A=;
 b=AqW7IJt/6T5DRnya4Fzq3xiXTkqSm5Z1ezVh4uOhzWNR+BDQKicMmKzGKKunhe7G0gDNeN
 0XYanHtsJSnn9dMHrvZJKbTKYAPyr0t4nuIYbperi7ujhlqyjgpxfAfAUB0Kdk/pkdTa99
 xWAMsDWUJm/brO5NcL2suRjwYKAQV7k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-UMq5lItDOHew-Kh4cK7bgw-1; Tue,
 30 Apr 2024 03:14:07 -0400
X-MC-Unique: UMq5lItDOHew-Kh4cK7bgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 299041C031A4;
 Tue, 30 Apr 2024 07:14:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D35BB40C6CC1;
 Tue, 30 Apr 2024 07:14:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 14/19] gitlab: migrate the s390x custom machine to 22.04
Date: Tue, 30 Apr 2024 09:13:35 +0200
Message-ID: <20240430071340.413305-15-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

20.04 is dead (from QEMU's point of view), long live 22.04!

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240426153938.1707723-3-alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/custom-runners.yml               |  2 +-
 ...20.04-s390x.yml => ubuntu-22.04-s390x.yml} | 28 +++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)
 rename .gitlab-ci.d/custom-runners/{ubuntu-20.04-s390x.yml => ubuntu-22.04-s390x.yml} (88%)

diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index a0e79acd39..29e52df283 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -29,7 +29,7 @@
       junit: build/meson-logs/testlog.junit.xml
 
 include:
-  - local: '/.gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml'
+  - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
   - local: '/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml'
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
similarity index 88%
rename from .gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml
rename to .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index cdae6c5212..85e2809573 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-20.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -1,13 +1,13 @@
-# All ubuntu-20.04 jobs should run successfully in an environment
+# All ubuntu-22.04 jobs should run successfully in an environment
 # setup by the scripts/ci/setup/build-environment.yml task
-# "Install basic packages to build QEMU on Ubuntu 20.04/20.04"
+# "Install basic packages to build QEMU on Ubuntu 22.04"
 
-ubuntu-20.04-s390x-all-linux-static:
+ubuntu-22.04-s390x-all-linux-static:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -23,12 +23,12 @@ ubuntu-20.04-s390x-all-linux-static:
  - make --output-sync check-tcg
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-all:
+ubuntu-22.04-s390x-all:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  timeout: 75m
  rules:
@@ -42,12 +42,12 @@ ubuntu-20.04-s390x-all:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-alldbg:
+ubuntu-22.04-s390x-alldbg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -65,12 +65,12 @@ ubuntu-20.04-s390x-alldbg:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-clang:
+ubuntu-22.04-s390x-clang:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -87,11 +87,11 @@ ubuntu-20.04-s390x-clang:
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
 
-ubuntu-20.04-s390x-tci:
+ubuntu-22.04-s390x-tci:
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
@@ -107,12 +107,12 @@ ubuntu-20.04-s390x-tci:
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
 
-ubuntu-20.04-s390x-notcg:
+ubuntu-22.04-s390x-notcg:
  extends: .custom_runner_template
  needs: []
  stage: build
  tags:
- - ubuntu_20.04
+ - ubuntu_22.04
  - s390x
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-- 
2.44.0


