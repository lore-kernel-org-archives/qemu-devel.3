Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A85CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcN1K-0005Xh-1r; Wed, 24 Jun 2026 08:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcN0i-0004pK-M2
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcN0h-0006Yj-6w
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782305237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGiI/E4m2CtgDflQah6Ez6vUFomHQjUX5W+C0IwbTsA=;
 b=csWcMm7mG3Plb6rZJGL0iAzfLZbzeEv+9hzyAdzNlj+HvF0+YRgqgZpA3bUCctI6O3ZLTl
 mnIAH4gJAo7wEsrNGy1oTqGVyAqPp8jr8I8TCuDAMyy3JdM93jjSCAgzUBcLo1tRor4Fr5
 Rd5nxNSSeRcNh/IkZTm9EIlgGY40OJw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-Ho0m6UwYPxmLZRGHBI5tAA-1; Wed,
 24 Jun 2026 08:47:14 -0400
X-MC-Unique: Ho0m6UwYPxmLZRGHBI5tAA-1
X-Mimecast-MFC-AGG-ID: Ho0m6UwYPxmLZRGHBI5tAA_1782305233
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41B351801BDC; Wed, 24 Jun 2026 12:47:13 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.57])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB9D01956049; Wed, 24 Jun 2026 12:47:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 6/6] gitlab: greatly expand captured info about CI runner
 environment
Date: Wed, 24 Jun 2026 13:46:57 +0100
Message-ID: <20260624124657.2725376-7-berrange@redhat.com>
In-Reply-To: <20260624124657.2725376-1-berrange@redhat.com>
References: <20260624124657.2725376-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

To aid in debugging wierd CI failures we need greater information
about the CI runner environment. It is usually container based
and can have some unexpected characteristics that significantly
differ from a developer's local environment.

This captures the mount list, CPU model, memory information,
device node lists, kernel info, user identity and all environment
variables.

Since this information can get quite large it is not emitted
directly in the logs, rather it is exposed in job artifacts
under the "ci-runner-env" directory.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/base.yml               | 11 ++++++++++-
 .gitlab-ci.d/buildtest-template.yml |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index a75fb37d61..bec04138fa 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -141,6 +141,7 @@ variables:
     expire_in: 7 days
     paths:
       - build/meson-logs
+      - ci-runner-env
     reports:
       junit: build/meson-logs/*.junit.xml
   before_script:
@@ -150,7 +151,15 @@ variables:
     # Prevent logs (if any) from prior build job artifacts
     # from being duplicated in the new job artifacts
     - rm -f build/meson-logs/*
-    - test -f /packages.txt && cat /packages.txt
+    - mkdir -p ci-runner-env
+    - test -f /packages.txt && cp /packages.txt ci-runner-env/packages.txt
+    - cp /proc/mounts ci-runner-env/mounts.txt
+    - cp /proc/cpuinfo ci-runner-env/cpuinfo.txt
+    - cp /proc/meminfo ci-runner-env/meminfo.txt
+    - ls -l /dev > ci-runner-env/devices.txt
+    - uname -a > ci-runner-env/kernel.txt
+    - id -a > ci-runner-env/user.txt
+    - printenv | sort > ci-runner-env/environ.txt
     - section_end setup
 
 .base_meson_ccache_job_template:
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 11d7a75667..e62b3f2123 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -38,6 +38,7 @@
     paths:
       - build
       - .git-submodule-status
+      - ci-runner-env
     exclude:
       - build/**/*.p
       - build/**/*.a.p
@@ -83,6 +84,7 @@
     paths:
       - build/meson-logs
       - build/tests/functional/*/*/*.log
+      - ci-runner-env
     reports:
       junit: build/meson-logs/*.junit.xml
   after_script:
-- 
2.54.0


