Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D00C54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 22:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhGSb-000453-79; Mon, 04 Mar 2024 17:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhGSL-0003zq-Ki
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:06:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhGSC-00018y-DW
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709589995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UrxDlBZKjvs1iaHuf23Et+5gP3N+F3zrixOI9sLweo=;
 b=Lhe50EjAvssDOBZ6qeVv93kvsnzQQKsDf2kkAcCf4YEjfmqdZaCJ7GDJODninGcvF0CaHi
 cAnHXFuh0T19t5CtXIWaoNnk2IBwgdZA7XXgX0CHFHxGpgy42nwcoS+z6ntFnlkBZs3aqJ
 EuY0VWeRuBTmYruzYIZgTToJMg6pfPg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-fybZ0ElTNeCt9ByunOgMtA-1; Mon,
 04 Mar 2024 17:06:33 -0500
X-MC-Unique: fybZ0ElTNeCt9ByunOgMtA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C98E738062A7;
 Mon,  4 Mar 2024 22:06:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC43A492BC8;
 Mon,  4 Mar 2024 22:06:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	berrange@redhat.com
Subject: [RFC PATCH 2/2] gitlab-ci: add manual job to run Coverity
Date: Mon,  4 Mar 2024 17:06:31 -0500
Message-Id: <20240304220631.943130-3-pbonzini@redhat.com>
In-Reply-To: <20240304220631.943130-1-pbonzini@redhat.com>
References: <20240304220631.943130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Add a job that can be run, either manually or on a schedule, to upload
a build to Coverity Scan.  The job uses the run-coverity-scan script
in multiple phases of check, download tools and upload, in order to
avoid both wasting time (skip everything if you are above the upload
quota) and avoid filling the log with the progress of downloading
the tools.

The job is intended to run on a scheduled pipeline run, and scheduled
runs will not get any other job.  It requires two variables to be in
GitLab CI, COVERITY_TOKEN and COVERITY_EMAIL.  Those are already set up
in qemu-project's configuration as protected and masked variables.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/base.yml      |  4 ++++
 .gitlab-ci.d/buildtest.yml | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index ef173a34e6..2dd8a9b57c 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -41,6 +41,10 @@ variables:
     - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_TAG'
       when: never
 
+    # Scheduled runs on mainline don't get pipelines except for the special Coverity job
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_PIPELINE_SOURCE == "schedule"'
+      when: never
+
     # Cirrus jobs can't run unless the creds / target repo are set
     - if: '$QEMU_JOB_CIRRUS && ($CIRRUS_GITHUB_REPO == null || $CIRRUS_API_TOKEN == null)'
       when: never
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index a1c030337b..378dee055b 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -729,3 +729,38 @@ pages:
       - public
   variables:
     QEMU_JOB_PUBLISH: 1
+
+coverity:
+  image: $CI_REGISTRY_IMAGE/qemu/fedora:$QEMU_CI_CONTAINER_TAG
+  stage: build
+  allow_failure: true
+  timeout: 3h
+  needs:
+    - job: amd64-fedora-container
+      optional: true
+  before_script:
+    - dnf install -y curl wget
+  script:
+    # would be nice to cancel the job if over quota (https://gitlab.com/gitlab-org/gitlab/-/issues/256089)
+    - 'scripts/coverity-scan/run-coverity-scan --check-upload-only || (exitcode=$?; if test $exitcode = 1; then
+        exit 0;
+      else
+        exit $exitcode;
+      fi)'
+    - 'scripts/coverity-scan/run-coverity-scan --update-tools-only > update-tools.log 2>&1 || cat update-tools.log'
+    - 'scripts/coverity-scan/run-coverity-scan --no-update-tools'
+  rules:
+    - if: '$COVERITY_TOKEN == null'
+      when: never
+    - if: '$COVERITY_EMAIL == null'
+      when: never
+    # Never included on upstream pipelines, except for schedules
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_PIPELINE_SOURCE == "schedule" && $CI_COMMIT_REF_NAME == $CI_DEFAULT_BRANCH'
+      when: on_success
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM'
+      when: never
+    # Forks don't get any pipeline unless QEMU_CI=1 or QEMU_CI=2 is set
+    - if: '$QEMU_CI != "1" && $QEMU_CI != "2"'
+      when: never
+    # Always manual on forks even if $QEMU_CI == "2"
+    - when: manual
-- 
2.39.1


