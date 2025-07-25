Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872AAC87FD1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKci-0003qC-Ge; Fri, 25 Jul 2025 11:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKcL-0003aY-2K
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:53 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKcI-0002at-5E
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:52 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5550dca1241so2036040e87.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458347; x=1754063147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16xfUtbC6UzI1u4ODCUmMfcCCqi0akC8LfMOrHCPnys=;
 b=jBOcKR6PsOLuO2WACTkjRCBEUXa6O8JuvXAtWeNeL6/g6WjH59fD5YrvHhA3YfJoq0
 9oarqdzW3F/fSEYKgE+LuHDHsy7bCHiZQoR3clBr9sc3OmcGBvSrIebJd6F3QBHxkUn4
 rQ9neK/Ya6E/APtQKlgx84RDaZkv14bdmzyIUiklTmI9nmzGbk15QJH5EgzVGUc6Ox/L
 xxoJZSEsoqaDYEJU7eVOkGqUmP0cYEhYTC5rb05zugxdMtPVlEAU8Vw5lAdcEyDWlcjC
 pCcNvEKV57ozUU+kPXxwCFl0t47ww9SuVx0prR8vYWXd5U1RLdJl79N7VV417xJHt/Kt
 fICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458347; x=1754063147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=16xfUtbC6UzI1u4ODCUmMfcCCqi0akC8LfMOrHCPnys=;
 b=hbxnKhJVZNCd/PYTfYU3NgdExxGvGilreKrkPOp9wHCBHOF941KCoLP6dOcUdWUYAH
 iVF/MKPC+2pcz9FtoxlimkF6jdrGKqliaFLEUmfOQbABTv1NyPbX4lSi7JXBWsGOCJQL
 +RHtASMBII7FU1whfpn2iVsQ0vcA7XPMXdeuGOxZ43SFHsNMI+rjoaeYmwt6pHQ4T1d4
 9illcll/HUdlmSsibPP9QZWuYDNdX7hkrx+MbA55p9xY/4XIFKOq4Df1jjDT1/u6Lgdb
 0XGyV9csHnoYkv4fdklH8rBLE4ih7Pn85gXDH+UYiudqy2GARPfs+UjV3eFB8pSOxDCI
 zR6A==
X-Gm-Message-State: AOJu0YwOkbUs8/5aXxfJ2T/dfChCGNHXOCW8lgzYolEfUQEf5XSGTivr
 HmNh3/Ysk7I5sq39TPJdlpPV1NhorWN9oJewKZp31ZA2SsleNSjm373A1tW2z43kX+jgkZapz9n
 8zfUx
X-Gm-Gg: ASbGncuGIOOc/bEGjFvMhUVkaawgY5l+zs+3xZI6JFsKVSY0uV9Ldw6TkT3wfBxIljj
 IqhHKVO9viNZqed7g3ZXrvLqmPX1fD9pw0xBQpJ90qpCcKE4hNEH3+43NRw7Hq6doupejyN5bAT
 h8eOsSd9A0sxzxQv9jfsx/YyAmfTn+maTY4WaSenLUcBB8FU/vfenVdO1UBXbLkTQGIaylnEHjU
 Ho/zb5it2rHrZX9wC4IQ254cultBGB+6UzC8M0EevbXLTpcoA4QyQfqD4BLwRHGCycxDuoemuCU
 sz/QkCP7t669x2jHaSvven/g0IHFhiQZlSxFRbJCLAgioPsMs8CBIBKVS6J01c1zJI489uQ5iFm
 Am1X3I8nZKAwFXlngz3hds/o=
X-Google-Smtp-Source: AGHT+IG9HAC5+3xvsSdgH7ALQJn52Q2ZEznMpmcmtBfv4SAzRmtVNp0mY12l8JpU6BhvbjFIVNHytA==
X-Received: by 2002:a05:6402:13d3:b0:5ff:ef06:1c52 with SMTP id
 4fb4d7f45d1cf-614f1bd8c22mr2536819a12.3.1753458333402; 
 Fri, 25 Jul 2025 08:45:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61500add92dsm6710a12.52.2025.07.25.08.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D5ACD5F8F1;
 Fri, 25 Jul 2025 16:45:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH for 10.1 v2 11/14] tests/tcg: reduce the number of plugin
 tests combinations
Date: Fri, 25 Jul 2025 16:45:14 +0100
Message-ID: <20250725154517.3523095-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

As our set of multiarch tests has grown the practice of running every
plugin with every test is becoming unsustainable. If we switch to
ensuring every test gets run with at least one plugin we can speed
things up.

Some plugins do need to be run with specific tests (for example the
memory instrumentation test). We can handle this by manually adding
them to EXTRA_RUNS. We also need to wrap rules in a CONFIG_PLUGIN test
so we don't enable the runs when plugins are not enabled.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target                     | 23 ++++++++++++++-----
 tests/tcg/multiarch/Makefile.target           |  8 +++++--
 .../multiarch/system/Makefile.softmmu-target  | 11 +++++----
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index a12b15637ea..18afd5be194 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -173,14 +173,25 @@ PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
 # We need to ensure expand the run-plugin-TEST-with-PLUGIN
 # pre-requistes manually here as we can't use stems to handle it. We
 # only expand MULTIARCH_TESTS which are common on most of our targets
-# to avoid an exponential explosion as new tests are added. We also
-# add some special helpers the run-plugin- rules can use below.
+# and rotate the plugins so we don't grow too out of control as new
+# tests are added. Plugins that need to run with a specific test
+# should ensure they add their combination to EXTRA_RUNS.
 
 ifneq ($(MULTIARCH_TESTS),)
-$(foreach p,$(PLUGINS), \
-	$(foreach t,$(MULTIARCH_TESTS),\
-		$(eval run-plugin-$(t)-with-$(p): $t $p) \
-		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
+
+NUM_PLUGINS := $(words $(PLUGINS))
+NUM_TESTS := $(words $(MULTIARCH_TESTS))
+
+define mod_plus_one
+  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
+endef
+
+$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
+	$(eval _test := $(word $(_idx), $(MULTIARCH_TESTS))) \
+	$(eval _plugin := $(word $(call mod_plus_one, $(_idx), $(NUM_PLUGINS)), $(PLUGINS))) \
+	$(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin)) \
+	$(eval RUN_TESTS+=run-plugin-$(_test)-with-$(_plugin)))
+
 endif # MULTIARCH_TESTS
 endif # CONFIG_PLUGIN
 
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index bfdf7197a7b..38345ff8805 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -189,6 +189,10 @@ run-plugin-semiconsole-with-%:
 TESTS += semihosting semiconsole
 endif
 
+test-plugin-mem-access: CFLAGS+=-pthread -O0
+test-plugin-mem-access: LDFLAGS+=-pthread -O0
+
+ifeq ($(CONFIG_PLUGIN),y)
 # Test plugin memory access instrumentation
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
@@ -197,8 +201,8 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
 	$(QEMU) $<
 
-test-plugin-mem-access: CFLAGS+=-pthread -O0
-test-plugin-mem-access: LDFLAGS+=-pthread -O0
+EXTRA_RUNS += run-plugin-test-plugin-mem-access-with-libmem.so
+endif
 
 # Update TESTS
 TESTS += $(MULTIARCH_TESTS)
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index 5acf2700812..4171b4e6aa0 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -71,8 +71,11 @@ endif
 MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt \
 	run-gdbstub-untimely-packet run-gdbstub-registers
 
+ifeq ($(CONFIG_PLUGIN),y)
 # Test plugin memory access instrumentation
-run-plugin-memory-with-libmem.so: 		\
-	PLUGIN_ARGS=$(COMMA)region-summary=true
-run-plugin-memory-with-libmem.so: 		\
-	CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
+run-plugin-memory-with-libmem.so: memory libmem.so
+run-plugin-memory-with-libmem.so: PLUGIN_ARGS=$(COMMA)region-summary=true
+run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
+
+EXTRA_RUNS += run-plugin-memory-with-libmem.so
+endif
-- 
2.47.2


