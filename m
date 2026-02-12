Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40711EB48E8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSP4-00029B-MN; Thu, 12 Feb 2026 03:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOy-000203-Hg
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOw-0001bE-K2
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770886218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=id70y4pm34MdQLex05aMQJihyAnpSVIJL6a8OWLggQ8=;
 b=U7QgdrYT7DaGgVyjjL1jVp3Hab9LjT1liqRwiqe3ha4SLh4K7mNLg2zIl7p6nvOYQhHsNo
 2tqV16DCJ/cXVRfSNcOtdzOsP4Wd9Aw0rdeg8KL2XvUbphJbeUHubPrb14B/vp+vRYpGaw
 g7xSieDsiVxhfB95YpqvwhMsXDfbhXE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-Y3Rc4RKfOMONnGAHJBYznQ-1; Thu,
 12 Feb 2026 03:50:14 -0500
X-MC-Unique: Y3Rc4RKfOMONnGAHJBYznQ-1
X-Mimecast-MFC-AGG-ID: Y3Rc4RKfOMONnGAHJBYznQ_1770886213
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EC43195605B; Thu, 12 Feb 2026 08:50:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3FD130001BB; Thu, 12 Feb 2026 08:50:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 ck <ckeong.teo17@gmail.com>
Subject: [PULL 13/14] tests/Makefile.include: add run-tcg-tests-TARGET to
 check-help
Date: Thu, 12 Feb 2026 09:49:26 +0100
Message-ID: <20260212084927.258642-14-thuth@redhat.com>
In-Reply-To: <20260212084927.258642-1-thuth@redhat.com>
References: <20260212084927.258642-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Choon Keong <ckeong.teo17@gmail.com>

User can execute TCG tests for a specific TARGET using the command:
$ make run-tcg-tests-TARGET-softmmu

However, this command is not showing in 'make check-help'
documentation, making it hard for new contributors to
discover.

This commit help to resolve this by adding the description
for the command, to the "check-tcg" section, as suggested
by Thomas, in tests/Makefile.include.

Additionally, reformat the alignment to accommodate
the length of the new command, ensuring the
consistency of the output.

Suggested-by: Thomas Huth <thuth@redhat.com>
Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/228
Signed-off-by: ck <ckeong.teo17@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260206170059.4913-1-ckeong.teo17@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7728098981d..be3b78fdfb7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -3,29 +3,30 @@
 .PHONY: check-help
 check-help:
 	@echo "Regression testing targets:"
-	@echo " $(MAKE) check                    Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
-	@echo " $(MAKE) bench                    Run speed tests"
+	@echo " $(MAKE) check                         Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
+	@echo " $(MAKE) bench                         Run speed tests"
 	@echo
 	@echo "Individual test suites:"
-	@echo " $(MAKE) check-qtest-TARGET       Run qtest tests for given target"
-	@echo " $(MAKE) check-qtest              Run qtest tests"
-	@echo " $(MAKE) check-functional         Run python-based functional tests"
-	@echo " $(MAKE) check-functional-TARGET  Run functional tests for a given target"
-	@echo " $(MAKE) check-unit               Run qobject tests"
-	@echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
-	@echo " $(MAKE) check-tracetool          Run tracetool generator tests"
-	@echo " $(MAKE) check-block              Run block tests"
+	@echo " $(MAKE) check-qtest-TARGET            Run qtest tests for given target"
+	@echo " $(MAKE) check-qtest                   Run qtest tests"
+	@echo " $(MAKE) check-functional              Run python-based functional tests"
+	@echo " $(MAKE) check-functional-TARGET       Run functional tests for a given target"
+	@echo " $(MAKE) check-unit                    Run qobject tests"
+	@echo " $(MAKE) check-qapi-schema             Run QAPI schema tests"
+	@echo " $(MAKE) check-tracetool               Run tracetool generator tests"
+	@echo " $(MAKE) check-block                   Run block tests"
 ifneq ($(filter $(all-check-targets), check-softfloat),)
-	@echo " $(MAKE) check-tcg                Run TCG tests"
-	@echo " $(MAKE) check-softfloat          Run FPU emulation tests"
+	@echo " $(MAKE) check-tcg                     Run TCG tests"
+	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
+	@echo " $(MAKE) run-tcg-tests-TARGET-softmmu  Run TCG tests for a given target"
 endif
 	@echo
-	@echo " $(MAKE) check-report.junit.xml   Generates an aggregated XML test report"
-	@echo " $(MAKE) check-venv               Creates a Python venv for tests"
-	@echo " $(MAKE) check-clean              Clean the tests and related data"
+	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated XML test report"
+	@echo " $(MAKE) check-venv                    Creates a Python venv for tests"
+	@echo " $(MAKE) check-clean                   Clean the tests and related data"
 	@echo
 	@echo "The following are useful for CI builds"
-	@echo " $(MAKE) check-build              Build most test binaries"
+	@echo " $(MAKE) check-build                   Build most test binaries"
 	@echo
 	@echo
 	@echo "The variable SPEED can be set to control the gtester speed setting."
-- 
2.53.0


