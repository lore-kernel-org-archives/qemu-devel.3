Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C3EEF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxn7V-0000mk-U0; Wed, 04 Mar 2026 09:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxn7U-0000eY-5o
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:22:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxn7S-0006Ko-6k
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772634153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2pUvMQewJUV9LL6jjoOnTx3CSBNxygEpDicbyvLHxs=;
 b=EE4CKkIQSs3HbObbx01WbRPuatSUUf2OEnObTypbnQotNWyFuCySrD1fl7CxWz1N4n508C
 z6TVH0GphvDdwhRop/Z3ZhFkgmrEDbYaS2I/dSV/cDnDCAXBXGGsZSPgv5KEzN0xmk8FP8
 MzJCMejb+gQAXJqGD06D3cAlSgQczlc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-horikHwyNoObpUFkiDft2Q-1; Wed,
 04 Mar 2026 09:22:30 -0500
X-MC-Unique: horikHwyNoObpUFkiDft2Q-1
X-Mimecast-MFC-AGG-ID: horikHwyNoObpUFkiDft2Q_1772634147
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBCDA19560B5; Wed,  4 Mar 2026 14:22:27 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.75])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EE361958DC5; Wed,  4 Mar 2026 14:22:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v5 14/15] gitlab: add jobs for thorough block tests
Date: Wed,  4 Mar 2026 14:21:19 +0000
Message-ID: <20260304142120.2635617-15-berrange@redhat.com>
In-Reply-To: <20260304142120.2635617-1-berrange@redhat.com>
References: <20260304142120.2635617-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

The jobs 147 with NBD and 045 with raw are also marked skipped as the
qemu.qmp python code triggers deprecation warnings for sendmsg. This
can be removed when the next release of python-qemu-qmp is made per:

  https://gitlab.com/qemu-project/python-qemu-qmp/-/issues/36

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 102 +++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 4b20429c7f..2e143737a3 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -174,6 +174,108 @@ build-system-centos:
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
+    # https://gitlab.com/qemu-project/python-qemu-qmp/-/issues/36
+    QEMU_TEST_IO_SKIP: nbd:147
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
+    # https://gitlab.com/qemu-project/python-qemu-qmp/-/issues/36
+    QEMU_TEST_IO_SKIP: raw:045
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


