Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4D5CF45C8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 20:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfOij-0007GM-4k; Mon, 12 Jan 2026 15:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfOii-0007FX-8T
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 15:41:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfOig-0000nG-JI
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 15:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768250458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmd+lG//fjnEIzulqaegvbh8KAWoHQ7DLO8b4iiFIhE=;
 b=gQeByC/NSNpiqeR7Mc5hxV+x6NL3EvnIoruQAVh2IWcw2a9YF1H7Pqy+pmkctWvYL/YsBI
 GAI319Ifiq/88s9mGipCIlIbqHBSZFUYztWsBdOuD4Eoetuwsj3AT9HNTvn9GfU4bGbniM
 dy70i/oZqj+G6OQMpJaSxbBHl+PletI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-xzsq59GFNnmtB4OVdvEWUw-1; Mon,
 12 Jan 2026 15:40:54 -0500
X-MC-Unique: xzsq59GFNnmtB4OVdvEWUw-1
X-Mimecast-MFC-AGG-ID: xzsq59GFNnmtB4OVdvEWUw_1768250453
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95C27195609E; Mon, 12 Jan 2026 20:40:53 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.178])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C65F730001A2; Mon, 12 Jan 2026 20:40:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 07/13] tests: add a meson suite / make target per block I/O
 tests format
Date: Mon, 12 Jan 2026 20:40:20 +0000
Message-ID: <20260112204026.710659-8-berrange@redhat.com>
In-Reply-To: <20260112204026.710659-1-berrange@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/Makefile.include         | 3 ++-
 tests/qemu-iotests/meson.build | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7728098981..fc6fdcbbf9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -14,7 +14,8 @@ check-help:
 	@echo " $(MAKE) check-unit               Run qobject tests"
 	@echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
 	@echo " $(MAKE) check-tracetool          Run tracetool generator tests"
-	@echo " $(MAKE) check-block              Run block tests"
+	@echo " $(MAKE) check-block              Run block tests (all formats)"
+	@echo " $(MAKE) check-block-FORMAT       Run block tests (only for FORMAT)"
 ifneq ($(filter $(all-check-targets), check-softfloat),)
 	@echo " $(MAKE) check-tcg                Run TCG tests"
 	@echo " $(MAKE) check-softfloat          Run FPU emulation tests"
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
2.52.0


