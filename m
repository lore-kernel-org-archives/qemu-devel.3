Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E228CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 12:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN8Gx-0007mF-HC; Wed, 13 May 2026 08:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8Gr-0007eE-ED
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8Gp-00055K-B4
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778673658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Xw/nFw0Q17d8MoulWnbnWRtQ704uoEn/FsMh209j74=;
 b=cg4wctmVn+L1i3TgzFTzOfRtFhwqvbzM9yEQPlFMAvp9bGDoa7ztspl1C5A9L62u0NXn9/
 34ZTy7LOqTSTHNHM3mWLZ3HUNXATTMHGgfGz1jkhoPVgsMJ18VffiQMyxoBqoiVZjiS1RP
 /VaB7kZk7mMdJega8BTxy66pGCz/PMQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-lypLTs-oMgiC8Gbkp2FZJA-1; Wed,
 13 May 2026 08:00:52 -0400
X-MC-Unique: lypLTs-oMgiC8Gbkp2FZJA-1
X-Mimecast-MFC-AGG-ID: lypLTs-oMgiC8Gbkp2FZJA_1778673650
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A462319560AF; Wed, 13 May 2026 12:00:50 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D0771800349; Wed, 13 May 2026 12:00:45 +0000 (UTC)
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
Subject: [PATCH v6 08/16] tests: add a meson suite / make target per block I/O
 tests format
Date: Wed, 13 May 2026 12:59:55 +0100
Message-ID: <20260513120003.226790-9-berrange@redhat.com>
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

Currently each block format is classified as either 'quick', 'slow' or
'thorough' and this controls whether its I/O tests are added to the meson
suites 'block-quick', 'block-slow' or 'block-thorough'.

This suites are exposed the 'check-block' make target, accepting the
optional SPEED variable.

As we add more formats to the 'thorough' group, however, it becomes
increasingly large and time consuming to run. What is needed is a make
target that can exercise all tests for an individual format, regardless
of speed classification.

This makes use of the previous enhancement to mtest2make.py to introduce
new meson suites 'block-$FORMAT-optional', which translate to new top
level make targets 'check-block-$FORMAT'. These new targets always run
all tests and as such do not need the SPEED variable to be set, but are
not triggered by 'make check' or 'make check-block'.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/Makefile.include         | 3 ++-
 tests/qemu-iotests/meson.build | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f257288194..a820980bbe 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -14,7 +14,8 @@ check-help:
 	@echo " $(MAKE) check-unit                    Run qobject tests"
 	@echo " $(MAKE) check-qapi-schema             Run QAPI schema tests"
 	@echo " $(MAKE) check-tracetool               Run tracetool generator tests"
-	@echo " $(MAKE) check-block                   Run block tests"
+	@echo " $(MAKE) check-block                   Run block tests (all formats)"
+	@echo " $(MAKE) check-block-FORMAT            Run block tests (only for FORMAT)"
 ifneq ($(filter $(all-check-targets), check-softfloat),)
 	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
 	@echo " $(MAKE) check-tcg                     Run TCG tests"
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 1a24d801a3..16a5e39476 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -62,7 +62,8 @@ foreach format, speed: qemu_iotests_formats
     endforeach
   endif
 
-  suites = []
+  # Every format gets put in the format specific suite
+  suites = ['block-' + format + '-optional']
   # Any format tagged quick or slow also gets added to slow
   # otherwise its tagged thorough
   if speed != 'thorough'
-- 
2.54.0


