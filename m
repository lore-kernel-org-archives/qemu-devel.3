Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD2F606B0D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dwq6K474
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuw4-0007JB-4E; Mon, 02 Nov 2026 11:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuvx-0006r7-9O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuvv-0002PH-4e
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tcFk+yotROrLDq/Y2HrnBk4fsx0YuGmNzlggcu+kE+U=;
 b=dwq6K474EW8vR3vUn9FZ3pGCV3KyMBd23fxBeJYVQM742ZkYCm3oK7cuynVEwg5+WuhO7O
 W+XKwiGcwbcun9SdmHD/F1tz+6wqcwvuz7tG4SxhqpjWsDOqu7uvTjCn5yQj5fNGAy3hBB
 rDhk9nuzBY8r6s4BY/vlcFQ2tA8FGJU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-7gMAhNwCP0aJIiXH-pYWoQ-1; Mon,
 02 Nov 2026 11:30:50 -0500
X-MC-Unique: 7gMAhNwCP0aJIiXH-pYWoQ-1
X-Mimecast-MFC-AGG-ID: 7gMAhNwCP0aJIiXH-pYWoQ_1793637049
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4300C1955D7B; Mon,  2 Nov 2026 16:30:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.50])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC21F180057F; Mon,  2 Nov 2026 16:30:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@linux.dev>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/5] tests: Add a target to run all tests in thorough mode
Date: Mon,  2 Nov 2026 17:30:40 +0100
Message-ID: <20261102163044.644663-2-thuth@redhat.com>
In-Reply-To: <20261102163044.644663-1-thuth@redhat.com>
References: <20261102163044.644663-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"make check SPEED=thorough" is a little bit clunky to type and many
people are not aware of this nice possibility to run almost all test
in parallel this way. So add a "check-thorough" target that makes this
way of running the tests a little bit more accessible.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20261026093034.516604-1-thuth@redhat.com>
---
 tests/Makefile.include | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9f82552ab54..a1f60802b9b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -4,6 +4,7 @@
 check-help:
 	@echo "Regression testing targets:"
 	@echo " $(MAKE) check                         Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
+	@echo " $(MAKE) check-thorough                Download assets and run almost all non-flaky tests"
 	@echo " $(MAKE) bench                         Run speed tests"
 	@echo
 	@echo "Individual test suites:"
@@ -46,10 +47,13 @@ FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$
 $(FUNCTIONAL_TARGETS):
 	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
 
-.PHONY: check-functional
-check-functional:
+.PHONY: check-functional-precache
+check-functional-precache:
 	@$(NINJA) precache-functional
 	@$(PYTHON) $(SRC_PATH)/scripts/clean_functional_cache.py
+
+.PHONY: check-functional
+check-functional: check-functional-precache
 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
 
 .PHONY: check-func check-func-quick
@@ -57,9 +61,12 @@ check-func check-func-quick:
 
 # Consolidated targets
 
-.PHONY: check check-clean
+.PHONY: check check-thorough check-clean
 check:
 
+check-thorough: check-functional-precache
+	$(MAKE) check SPEED=thorough QEMU_TEST_NO_DOWNLOAD=1
+
 check-build: run-ninja
 
 check-clean:
-- 
2.56.0


