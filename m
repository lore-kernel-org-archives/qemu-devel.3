Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2746C369D0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPxp-0003fx-D1; Wed, 25 Sep 2024 07:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPwf-0006gE-Kz
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPwd-00040q-UY
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnhOt4A+tUtlf00Ic65PLK009/y0PlsO2AKKzYEyQmE=;
 b=FW4ZubkyVexbbjSd6pRROpWiYJDbcdzSKgX/LWM0e+GzTuzOYmLCwVz03lqDSGxKhftfkS
 I2alLeLUD5hoSjOQxL5ltfM/ykexoCsKTl0/hma8i7k1znZHopbAAaomHzhFr4elKjl7vn
 Wd8qUpgQkopUHHHvkJ7zn2BVTO/mTFc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-s5A0gX_2OryNHjlTTnehCw-1; Wed,
 25 Sep 2024 07:12:28 -0400
X-MC-Unique: s5A0gX_2OryNHjlTTnehCw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 113991955E75; Wed, 25 Sep 2024 11:12:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 395101956094; Wed, 25 Sep 2024 11:12:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 43/44] .gitlab-ci.d: Split build and test in cross build job
 templates
Date: Wed, 25 Sep 2024 13:10:24 +0200
Message-ID: <20240925111029.24082-44-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In the native_build_job_template we have separate steps in the script
for the build and the test steps.  This is helpful because then
gitlab will give separate timestamps in the log view for each, and
you can see how long it took to compile vs how long to test.  In the
templates in crossbuild-template.yml, however, we do both the build
and test in a single 'make' invocation, and so we don't get the
separate timing information.

Split the build and test, in the same way we do in the native build
template.

This will also give us a place to separate out how parallel we want
to do the build by default from how parallel we want to do the tests
by default, which might be helpful in future.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240918125449.3125571-2-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/crossbuild-template.yml | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 2ce0432eb7..d1cb7a35db 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -9,6 +9,7 @@
     when: always
   timeout: 80m
   before_script:
+    - JOBS=$(expr $(nproc) + 1)
     - cat /packages.txt
   script:
     - export CCACHE_BASEDIR="$(pwd)"
@@ -24,7 +25,11 @@
           i386-softmmu microblaze-softmmu mips-softmmu mipsel-softmmu
           mips64-softmmu ppc-softmmu riscv32-softmmu sh4-softmmu
           sparc-softmmu xtensa-softmmu $CROSS_SKIP_TARGETS"
-    - make -j$(expr $(nproc) + 1) all check-build $MAKE_CHECK_ARGS
+    - make -j"$JOBS" all check-build
+    - if test -n "$MAKE_CHECK_ARGS";
+      then
+        $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
+      fi
     - if grep -q "EXESUF=.exe" config-host.mak;
       then make installer;
       version="$(git describe --match v[0-9]* 2>/dev/null || git rev-parse --short HEAD)";
@@ -46,6 +51,8 @@
     paths:
       - ccache/
     key: "$CI_JOB_NAME"
+  before_script:
+    - JOBS=$(expr $(nproc) + 1)
   script:
     - export CCACHE_BASEDIR="$(pwd)"
     - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
@@ -55,7 +62,11 @@
     - cd build
     - ../configure --enable-werror --disable-docs $QEMU_CONFIGURE_OPTS
         --disable-tools --enable-${ACCEL:-kvm} $EXTRA_CONFIGURE_OPTS
-    - make -j$(expr $(nproc) + 1) all check-build $MAKE_CHECK_ARGS
+    - make -j"$JOBS" all check-build
+    - if test -n "$MAKE_CHECK_ARGS";
+      then
+        $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
+      fi
 
 .cross_user_build_job:
   extends: .base_job_template
@@ -65,6 +76,8 @@
     paths:
       - ccache/
     key: "$CI_JOB_NAME"
+  before_script:
+    - JOBS=$(expr $(nproc) + 1)
   script:
     - export CCACHE_BASEDIR="$(pwd)"
     - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
@@ -76,7 +89,11 @@
           alpha-linux-user m68k-linux-user microblazeel-linux-user
           or1k-linux-user ppc-linux-user sparc-linux-user
           xtensa-linux-user $CROSS_SKIP_TARGETS"
-    - make -j$(expr $(nproc) + 1) all check-build $MAKE_CHECK_ARGS
+    - make -j"$JOBS" all check-build
+    - if test -n "$MAKE_CHECK_ARGS";
+      then
+        $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
+      fi
 
 # We can still run some tests on some of our cross build jobs. They can add this
 # template to their extends to save the build logs and test results
-- 
2.46.0


