Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22FCCCD1A3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squCx-0003Ye-CB; Wed, 18 Sep 2024 08:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1squCu-0003UX-5A
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:54:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1squCs-0002pJ-2F
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:54:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42e5e758093so30598235e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726664091; x=1727268891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3xuY/dn/VE1/VAQJG02uSRnCOARSaZWLd5XFaTF7XQ=;
 b=r1iI/UB4xmJac71a0WPt7pWuX2HqDb/MzMBnkH3zDy4Cj/QXzvMHQTAROp/UZpQVOw
 StqPbra589wrJTl87OkKpmmzC8AnNxtvbwmPwKIkYFiGOA07BZ6nxPpJlDm/UkRjsW1C
 V2jD0/RmybTqtmRsdvpEYesVhIe8IMKM3Lic21xyCqhEc6sPOXnfiLuKC1G3YGXp4CQS
 j9PDfb2ltvL+Bx2XNILKmD38i647f9XFh0byECm/RxH0oVXhvpIjisbzcgeGcLlVt6zi
 9HIFvKOBUtODEUXoFOhH4TSTB5YNbl40GjGRSsM+NKM0shxtq8GEnWWeY034nj22WDks
 XxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726664091; x=1727268891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3xuY/dn/VE1/VAQJG02uSRnCOARSaZWLd5XFaTF7XQ=;
 b=Yhn8SA5NGce94eKou6tnSG3CV4eSfFvduE0YrOb7qUCWzEr2xGWRn+N77C/2V5kLvr
 0RvMnjmCANeViirZ106NqgsZRiexnjRfIDq8pSBaZzg2OAfje0rxbRsVFyN98Z4jX9AY
 CKho/tascxIgjSj0YSWF5KPo2qV+k9c6sQJEMxPBlSEtY4fslaJGqXibTrke2IFIRcfN
 kDEu0X3YCWGrgwz2WqJublYlGagWoGj/bRBa6BYk6nE9fntX5tw94pu8DHCM32yzRGn2
 gmmoaWCSEELRAdyfX71WCvPGKAk+ZTNV3EiH2MslIBfqlxuMuJcG8FXyxzv5UWwDuOlS
 tdww==
X-Gm-Message-State: AOJu0YyGCZah9xj4ttlAm661jozI9I82qhb2bT0+fB7id+1W7+uy6gQO
 PXpRFAkU0gDdQfvdEELOmAVITc2iTGfTsBiNYM/sFBuPTfcyr33XN+Hl+S1ZV+C1R+0IamIHT+V
 X
X-Google-Smtp-Source: AGHT+IFyXfKoNfev7J4icMDCycs9JIFSAGp1MiwNUoIdmNJdGhZWOIQY5QVcotfUnP1+ULQ3eNeWdg==
X-Received: by 2002:a05:600c:3b1d:b0:42c:c401:6d8b with SMTP id
 5b1f17b1804b1-42d9070af3emr139345795e9.7.1726664091456; 
 Wed, 18 Sep 2024 05:54:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7051335fsm16410645e9.30.2024.09.18.05.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 05:54:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 1/2] .gitlab-ci.d: Split build and test in cross build job
 templates
Date: Wed, 18 Sep 2024 13:54:48 +0100
Message-Id: <20240918125449.3125571-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918125449.3125571-1-peter.maydell@linaro.org>
References: <20240918125449.3125571-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
Gitlab seems to be inconsistent about whether you get the
separate time-taken bubbles for each line of the script section
or not; but certainly if we don't split into separate 'make'
invocations we definitely can't get the timing info...
---
 .gitlab-ci.d/crossbuild-template.yml | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 2ce0432eb77..d1cb7a35dbf 100644
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
2.34.1


