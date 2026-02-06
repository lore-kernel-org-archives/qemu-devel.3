Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B00AEE20B8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPEE-0002tT-Al; Fri, 06 Feb 2026 12:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1voPDk-0002fF-RC
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:02:21 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1voPDh-0003Lo-HD
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:02:16 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c075ec1a58aso850327a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770397332; x=1771002132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o5PGBM113VNBl9Zg18me20J5Yyoe4Tn8ie4ZakB18ZU=;
 b=E2PL4MfVXK3o5Rm7VnmyeRHAilJxhsVMBseOyV38pAtE0hn7Ze+X0zTFB+APOmf1a9
 lYue4BTPeoUr6+ORJn4BeXAzPWPiCCfAh3jYEnwj68I6qAvUIlXXdmW2tZbjGwCuDO/g
 8aA6ncie04Jx+M71sUW8NVo6Bowu7RGTxkI2mt3Kbth0VN4HzwlWdK/4/wiutdveooHV
 OUNZx88ET3/fxWDKYU6AvCcvjIurEuEBEWDGXPrQdx3lGw3BopSPs3jWHwiosE+o0iXm
 l9jklvxUhDhn87pZqZfoMRu4hfSNaHSLDamPFC89nicCfOnSmIKd8NjWGPau55+fYSm8
 TFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770397332; x=1771002132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5PGBM113VNBl9Zg18me20J5Yyoe4Tn8ie4ZakB18ZU=;
 b=bWzrhRYC8cSwCq5ipBqQGDqhT6xVzpjWitZWe5Lj5PoaSkEsxVncVmhVYa/pIUXoUN
 2mJ/nC9u3paR+S/Du5/Zosxysmt1WnTVWr7dqRyWYBqnfWTiJSVZQLZdlHVEZx603qRP
 otPQZlGOzE909dFF5ZHvyOFbDzJAFsS7cOhnm/CqJXZkjQ3IwqZ00J3NWx/rXKWT3MOH
 10YIR0mGqUL6VLduyBRXZHSbNzV4ONbHIoKJTq5WS1M3r9Rsc0F1hxSWGXh1iFkd8AUO
 dsDhSClaok890q4peNLWy6QO+myGpVk1r42kRW4EPHEGbI05lEXbyMFWIut2xq4DAD2B
 hvhw==
X-Gm-Message-State: AOJu0YzPKwVQcZ1/oTj8xk1srLXRXBYElkiQLOtD57imOh5HIRWs0Hdk
 EObFshrIyByU5N7NjvvIamunePjw9V2165gllkAwcUp59nPXJn1wwob8TUQFB31M
X-Gm-Gg: AZuq6aLzOFSNloET9vFFmwsro8UyAEhsbgsnc2nVdgnSpF7n/5bT2aEUUhtV/Gl+XwD
 fng8YvLkw7D4g5GAxr6T/lHNBcY0w+58BbREeaRQHr/TU0h/69loVNlZvLWwPUIrDbIJ7MFvTFf
 SDzZwhYlUCEBCkmbo7L3RYQ6TdlIyLvfdGT2QTNCsUQlqyDU9Es0RbU8als/O4wzNZdctT1CMq1
 iIPHqxsKBgEeYwXJwPNUGs6gxRahA5P0eG+VPsvKVFU6tphyrc0BH33ytOMn2Qw1ioGxayGhFMy
 Pv6eRS+I0w9M1c3OYj5phneCaPa2osK8hwBjlnMc5YqWbG1KU6BHkvU1Wr4BjatN5p9nhZlcWWv
 J8Y7tBbp7+5iAA/xGx2FYIg25Si8GDSiZc9CIIS+CjdBq0Ud7h3Un96dwtQT69MKNnQWREWElMe
 iztbIT/nO34epBIXLBTpHXhWb9DhAKi+UseOnoT1UwFARp
X-Received: by 2002:a17:903:2343:b0:2a1:243:94a8 with SMTP id
 d9443c01a7336-2a9518188bcmr32760015ad.49.1770397331435; 
 Fri, 06 Feb 2026 09:02:11 -0800 (PST)
Received: from localhost.localdomain ([119.234.105.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951c7a047sm28547455ad.27.2026.02.06.09.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 09:02:10 -0800 (PST)
From: ck <ckeong.teo17@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com,
 ck <ckeong.teo17@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] tests/Makefile.include: add run-tcg-tests-TARGET to
 check-help
Date: Fri,  6 Feb 2026 17:00:59 +0000
Message-ID: <20260206170059.4913-1-ckeong.teo17@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 tests/Makefile.include | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7728098981..be3b78fdfb 100644
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
2.43.0


