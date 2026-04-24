Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09191FED3E6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIgt-0003vP-UW; Fri, 24 Apr 2026 11:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGIgW-00034C-M4
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGIgS-0007bn-3E
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777045391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhqREfsPxP/AghFXJaof5fi5sZbIpj/sIID0BGhHCok=;
 b=TsnwBeXvlsLl+vKAW5IUrYzf38UXofPrUeHa14gBajRukzJ2CTS07v7Q4LkSVLWCvWvC/W
 77iwmj/qISeV/xcLKOYf5YO/ZSUoOzrraZfTKXDkMSSFVzbIZXCtJdaj8IKhDk4WXWkQH0
 v/jNX08fNqs0vHBqbxgFxwkqYGP/Zp8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-0r8kPdKLOMKE7pHNVf-4sw-1; Fri,
 24 Apr 2026 11:43:08 -0400
X-MC-Unique: 0r8kPdKLOMKE7pHNVf-4sw-1
X-Mimecast-MFC-AGG-ID: 0r8kPdKLOMKE7pHNVf-4sw_1777045387
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82A0519560B0; Fri, 24 Apr 2026 15:43:07 +0000 (UTC)
Received: from thinkbook.redhat.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DD5D180047F; Fri, 24 Apr 2026 15:43:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 15/16] gitlab: add jobs for thorough block tests
Date: Fri, 24 Apr 2026 16:42:03 +0100
Message-ID: <20260424154205.364268-16-berrange@redhat.com>
In-Reply-To: <20260424154205.364268-1-berrange@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CI is only exercising the qcow2 'auto' tests currently. As a result we
get no exposure of changes which cause regressions in other block format
drivers.

This adds new CI jobs for each block format, that will run the target
'make check-block-$FORMAT'. The jobs are separate so that we have the
ability to make each format gating or not, depending on their level
of reliability.

The 'centos' image is used to run the I/O tests since several tests
have an implicit dependency on x86_64-softmmu, and thus break with
other architecture targets. The 'centos' build job is the only one
that creates the x86_64-softmmu target in CI. Ideally this target
portability in I/O tests would be fixed to avoid this limitation.

There is currently an undiagnosed failure of job 185 with the qcow2
when run in CI that is marked to be skipped, reported at:

  https://gitlab.com/qemu-project/qemu/-/issues/3270

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 98 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 4b1949a3a5..d4591d30e9 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -174,6 +174,104 @@ build-system-centos:
       x86_64-softmmu rx-softmmu sh4-softmmu
     MAKE_CHECK_ARGS: check-build
 
+
+# NB: block-XXX jobs use 'centos' since that is the build
+# job that provides the x86_64-softmmu.  Some I/O tests
+# are currently buggy and blindly assume characteristics
+# of x86 (such as PCIe) causing failures with other arches
+
+block-luks:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos9
+    MAKE_CHECK_ARGS: check-block-luks
+
+block-nbd:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos9
+    MAKE_CHECK_ARGS: check-block-nbd
+
+block-parallels:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos9
+    MAKE_CHECK_ARGS: check-block-parallels
+
+block-qcow2:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos9
+    MAKE_CHECK_ARGS: check-block-qcow2
+    # https://gitlab.com/qemu-project/qemu/-/issues/3270
+    QEMU_TEST_IO_SKIP: qcow2:185
+
+block-qed:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos9
+    MAKE_CHECK_ARGS: check-block-qed
+
+block-raw:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos9
+    MAKE_CHECK_ARGS: check-block-raw
+
+block-vdi:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos9
+    MAKE_CHECK_ARGS: check-block-vdi
+
+block-vhdx:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos9
+    MAKE_CHECK_ARGS: check-block-vhdx
+
+block-vmdk:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos9
+    MAKE_CHECK_ARGS: check-block-vmdk
+
+block-vpc:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos9
+    MAKE_CHECK_ARGS: check-block-vpc
+
 # Previous QEMU release. Used for cross-version migration tests.
 build-previous-qemu:
   extends: .native_build_job_template
-- 
2.53.0


