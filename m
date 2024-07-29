Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93797C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSI3-0002Z7-6J; Mon, 29 Jul 2024 11:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHw-0001tx-1v
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHt-0008Gq-OQ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso15318085e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266868; x=1722871668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7BE/CfrHJNluE1SRipI94yPsTEJHS+QxQjczrrTgwI=;
 b=zyci+QYPSle5ic7GPu8U72byt2Hor+wbISl+4twqMkI7G9SGn0CHEqTiM2PsBRX1eA
 yiCBZyvBo58DTYlhV0Vg8Uh6m9QPbBAmi5naNtKMg9yxFrCCgzH2JpIHe02AIXJP7f6a
 s9YocWn8Nu8Ck4XomShys6ahkL1YzPEZcVA5L5SY+jnmo2M5xLFS+EFh50bJ2KHP/QxT
 xMSUgjv/vGPFfKMFzh7hJY1H1skApRMEMpoF1hP+ZfmBFPqxXhthRlWZZ3E9JJvFh33P
 qux0Jm/CxdH4bmQTFYObKLGjSf/bXwvfnIK33UUGwooZ3EvkssMz6lJQbym33VOtrSZG
 AaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266868; x=1722871668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7BE/CfrHJNluE1SRipI94yPsTEJHS+QxQjczrrTgwI=;
 b=Z52fUOvpIACeRka27sHRVpJgv4VwSG80qK5iLIwt1+hTE7ClsTBWDQOnTyiPFZaSGV
 OEqAqdaNoo8U+lhiF4EJzqV1Y4RF3rqD/CICT82iCxy4dxMTuLqi/1WfeaTlJ7bVTSMo
 qUTKdMtUb+q3vFfM8+r18M9I020youd0Kqy6fRm5X3k0ea7SO6a5osGF2I5Sz6xmLFek
 nOwDBmiU6yfaCrny4MwyDIGT/aXjVd3cuXHd2FBLtvTfGQBOtehDaO9Ljva4Jg1tod8h
 OWvBfczii1eZ67UZCcF/0UVuj6b63L9/7aW1/fpS5Zpw6JlDlCyFogxsnOGknlNPHaGu
 VW2Q==
X-Gm-Message-State: AOJu0Yw74ezbZbB79sNbq3bFyqsvjsaI9F6sGIbJFflk/YdrMHv82dhg
 PeXcqmnAgfx7oJ3ssH7Ee0t7Js0Zp0XpGB6n2FC/syofn8NiwrU2p3H8I0QuNgxIn3T8leOH102
 P
X-Google-Smtp-Source: AGHT+IGWgFX/GcwrWT6ftRRtuZoMav5EJlqb0WXMMw3iVsZ7YIq1Bz613jdjiqwcJyutc/Yhkf/tbA==
X-Received: by 2002:adf:e844:0:b0:367:9828:f42d with SMTP id
 ffacd0b85a97d-36b5d0a60b1mr5731955f8f.53.1722266867426; 
 Mon, 29 Jul 2024 08:27:47 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fc873sm12514354f8f.60.2024.07.29.08.27.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:27:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/14] tests/Makefile.include: Increase the level of
 indentation in the help text
Date: Mon, 29 Jul 2024 17:27:05 +0200
Message-ID: <20240729152714.10225-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Thomas Huth <thuth@redhat.com>

The next patch is going to add some entries that need more space between
the command and the help text, so let's increase the indentation here
first.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240724175248.1389201-4-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/Makefile.include | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6618bfed70..167d8f29a4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -3,28 +3,28 @@
 .PHONY: check-help
 check-help:
 	@echo "Regression testing targets:"
-	@echo " $(MAKE) check                  Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
-	@echo " $(MAKE) bench                  Run speed tests"
+	@echo " $(MAKE) check                    Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
+	@echo " $(MAKE) bench                    Run speed tests"
 	@echo
 	@echo "Individual test suites:"
-	@echo " $(MAKE) check-qtest-TARGET     Run qtest tests for given target"
-	@echo " $(MAKE) check-qtest            Run qtest tests"
-	@echo " $(MAKE) check-unit             Run qobject tests"
-	@echo " $(MAKE) check-qapi-schema      Run QAPI schema tests"
-	@echo " $(MAKE) check-block            Run block tests"
+	@echo " $(MAKE) check-qtest-TARGET       Run qtest tests for given target"
+	@echo " $(MAKE) check-qtest              Run qtest tests"
+	@echo " $(MAKE) check-unit               Run qobject tests"
+	@echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
+	@echo " $(MAKE) check-block              Run block tests"
 ifneq ($(filter $(all-check-targets), check-softfloat),)
-	@echo " $(MAKE) check-tcg              Run TCG tests"
-	@echo " $(MAKE) check-softfloat        Run FPU emulation tests"
+	@echo " $(MAKE) check-tcg                Run TCG tests"
+	@echo " $(MAKE) check-softfloat          Run FPU emulation tests"
 endif
-	@echo " $(MAKE) check-avocado          Run avocado (integration) tests for currently configured targets"
+	@echo " $(MAKE) check-avocado            Run avocado (integration) tests for currently configured targets"
 	@echo
-	@echo " $(MAKE) check-report.junit.xml Generates an aggregated XML test report"
-	@echo " $(MAKE) check-venv             Creates a Python venv for tests"
-	@echo " $(MAKE) check-clean            Clean the tests and related data"
+	@echo " $(MAKE) check-report.junit.xml   Generates an aggregated XML test report"
+	@echo " $(MAKE) check-venv               Creates a Python venv for tests"
+	@echo " $(MAKE) check-clean              Clean the tests and related data"
 	@echo
 	@echo "The following are useful for CI builds"
-	@echo " $(MAKE) check-build            Build most test binaries"
-	@echo " $(MAKE) get-vm-images          Downloads all images used by avocado tests, according to configured targets (~350 MB each, 1.5 GB max)"
+	@echo " $(MAKE) check-build              Build most test binaries"
+	@echo " $(MAKE) get-vm-images            Downloads all images used by avocado tests, according to configured targets (~350 MB each, 1.5 GB max)"
 	@echo
 	@echo
 	@echo "The variable SPEED can be set to control the gtester speed setting."
-- 
2.45.2


