Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128FAF4613C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4heP-0005La-51; Mon, 23 Mar 2026 11:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he2-0005Ed-QU
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:49 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he0-0007t4-7N
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:46 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9841aecf72so335798366b.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774281399; x=1774886199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDq7L8VxJbWEl+g0lwQ7GIiMPhaC6/ZfTXLocURTGgs=;
 b=RB82YbNuKrh4kibTdwGu7nBo3R2Czm8a519qwAVdhhxgIqglJSYEXNiqFFurRFNrXv
 Ff9wEivhoMHxOOLKQN4ZekBxACAi57gtMvsmiGS8/sp9f7Us0gSqBJ5Qn/0ph+dSEitZ
 RA6h1SkBX+x5LinjpyC9iJZw5UeRlhDZHLxsiVFwFszJ9/fq2o6kSM++V2r0GmMpxE5v
 b0kvE280kNnAbVGrgCz5NT+CFIwQQsoqVgImCuockH/XCekcjeYPoerUiR5Z6P41yDG2
 vEmWmNvgyMPw81kBfScMYPzJXUH9lTvG9xvaXQdQ7CmJb6OHUsLZwkPlvHYQ2xyEPnss
 Et1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281399; x=1774886199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WDq7L8VxJbWEl+g0lwQ7GIiMPhaC6/ZfTXLocURTGgs=;
 b=JnJsGJ8gQKr8yjD0RWuyJ6iBkSz9JtaCDxNn92iaA4HRxwQ8w3/y2Dh6+CN0Dt6V2n
 bPyQXP4i7YNvXr7K1VLV5waT7eT0IrjNCS0P6HLTXdxm7gYMKXElAW8PpGJefeNnHGKG
 CRgu332gokshqHvI94K5N9S/yW6k9DeKdFW7K0Ns5ff2egVj27cwMDl1Z1HVJDzEOUxt
 +lyUWkGBjaws44nBWMYMiKw3X/DDsbogzXikW7iOAf32FYWuNGX7AvQ3VnNlPDVcK/0p
 kg/0FhHYonj29X2/km6MBTf+jg1TIgKLU1A7ALJbixr5NqNG2Oc5oUy0xwcNEgVEQoAk
 qn/w==
X-Gm-Message-State: AOJu0YyrIx8mAkO0DrWJ2qsMDxC4JH61SpFTmxKrFYXhN/1BacqGw81s
 weXXOaJU7/jnK5tW8cHV4FKzpu7/ee8X2WVvX+GsQaYk56yOkiwD44F4cGOCJpC902o=
X-Gm-Gg: ATEYQzwWbiZoAHv7K1dy5irbo6DiwTLPYaf8NJXFVDQY7GqCS5sDmv4gYG8iz7PIYPT
 OBsFYVT8HbX/ygXLaoxIbb1J/58AW6oEqWRUL3w0zWRKW/iz2/hwMwEMUOJ1TeWPtUFWhmlrTHx
 IttWgPQCw6sr3qH5EwmZaiM8EgXJP6ohI3suUEtlOtnm1Ys8AwMluy+cC8vtT1hFuWrt50Wr+dT
 ICDRcyfkjIV6GSYqTZ1wdFhPYmlxi3U4sc+uiblfbayq/ZvttbSiekKr1TxI3/LtidTwlpumage
 aIQiFN/aHq+C7oiG/8ZTANVc1gCe+VJTmi3uizDitoO73KWwV8WNf+tI6uk9G14NsYrh8ZaYdCm
 o3TuInfYhIteyTt3laSO1nMPUGPF62rJOjjvhOX+mKNcgtA9xACODVaMgiZpf44OKGTWDz9tK16
 7udslOqAKE73Fsu6GKAFi7aDo=
X-Received: by 2002:a17:906:6a22:b0:b98:4b50:ac3c with SMTP id
 a640c23a62f3a-b984b50ad49mr644273166b.27.1774281399386; 
 Mon, 23 Mar 2026 08:56:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983365a159sm502508766b.44.2026.03.23.08.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:56:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 00C875F7F5;
 Mon, 23 Mar 2026 15:56:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/8] tests/tcg: allow filtering of TCG tests
Date: Mon, 23 Mar 2026 15:56:30 +0000
Message-ID: <20260323155637.145015-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323155637.145015-1-alex.bennee@linaro.org>
References: <20260323155637.145015-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

We have a lot of TCG tests now which can be fiddly if we just want to
check one particular test type across the targets. Introduce
TCG_TEST_FILTER to allow this:

  make check-tcg TCG_TEST_FILTER=gdb

to run all the gdb tests across the suites.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260320155107.2143191-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 59b9a4b9220..f257288194d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -16,9 +16,11 @@ check-help:
 	@echo " $(MAKE) check-tracetool               Run tracetool generator tests"
 	@echo " $(MAKE) check-block                   Run block tests"
 ifneq ($(filter $(all-check-targets), check-softfloat),)
-	@echo " $(MAKE) check-tcg                     Run TCG tests"
 	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
-	@echo " $(MAKE) run-tcg-tests-TARGET-softmmu  Run TCG tests for a given target"
+	@echo " $(MAKE) check-tcg                     Run TCG tests"
+	@echo " $(MAKE) run-tcg-tests-TARGET          Run TCG tests for a given target"
+	@echo
+	@echo "The variable TCG_TEST_FILTER will select the subset of matching tests."
 endif
 	@echo
 	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated XML test report"
@@ -64,7 +66,7 @@ $(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/
 .PHONY: $(TCG_TESTS_TARGETS:%=run-tcg-tests-%)
 $(TCG_TESTS_TARGETS:%=run-tcg-tests-%): run-tcg-tests-%: build-tcg-tests-%
 	$(call quiet-command, \
-           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) SPEED=$(SPEED) run, \
+           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) SPEED=$(SPEED) TCG_TEST_FILTER=$(TCG_TEST_FILTER) run, \
         "RUN", "$* guest-tests")
 
 .PHONY: $(TCG_TESTS_TARGETS:%=clean-tcg-tests-%)
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index af72903f898..1b83824ff4e 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -254,8 +254,15 @@ endif
 gdb-%: %
 	gdb --args $(QEMU) $(QEMU_OPTS) $<
 
+# Filter tests based on TCG_TEST_FILTER if set
+ifdef TCG_TEST_FILTER
+FILTERED_RUN_TESTS=$(foreach test,$(RUN_TESTS),$(if $(findstring $(TCG_TEST_FILTER),$(test)),$(test)))
+else
+FILTERED_RUN_TESTS=$(RUN_TESTS)
+endif
+
 .PHONY: run
-run: $(RUN_TESTS)
+run: $(FILTERED_RUN_TESTS)
 
 clean:
 	rm -f $(TESTS) *.o $(CLEANFILES)
@@ -269,3 +276,6 @@ help:
 	@echo "Built with $(CC)"
 	@echo "Available tests:"
 	@$(foreach t,$(RUN_TESTS),echo "  $t";)
+	@echo ""
+	@echo "Environment variables:"
+	@echo "  TCG_TEST_FILTER=<pattern>  Filter tests matching pattern"
-- 
2.47.3


