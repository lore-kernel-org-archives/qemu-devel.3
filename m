Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4252AC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 20:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhZsE-0007X1-BC; Thu, 31 Jul 2025 16:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uhYOk-00030N-Fx
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:53:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uhYOi-0007j0-5s
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:53:01 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-24014cd385bso1353085ad.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753987978; x=1754592778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QyrYdLkR5Cz2ox+ZPvgu+hFep4K/vYOt7VSdpfk/NM8=;
 b=GicbimCq4VT2bNmZPlW8OppBAMuTge71MIC6u7Wgm6BRjqU00B5By3GK2ICjRN/r9u
 B4bHjoZfR1cPP4nIPBi0XOMUtHBpju91A3T4edcvArUSP9qC2UnPBNFbllN75Hq1FWz/
 7PNAYCw7hmIsfVvEZ3n+aF1lCV3f6eM0PCPe2vDaA7I8Rr4urBYk+h9FFrvIIHxc0zlX
 yfEsoDyI9h1MC28mWSQZmzcGC8OWCI8/JWO4iOxI8PGQPnDRA+s/pRbFqK3CxHqMFDZw
 +7lwAjBQGuYtjp5N3s2zIlDMvuOCVysb/wZnhdjHUDz7vVfs1Y2LRzb1SqOJFqh3UJjo
 SRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753987978; x=1754592778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QyrYdLkR5Cz2ox+ZPvgu+hFep4K/vYOt7VSdpfk/NM8=;
 b=VrvaBTd71/dmVmRsyDL2PCy62f4es1sCzwebaS0HZ9JIjfbNBrKYQDZH2GMGXz64Cb
 XkIO9sq0JSooFp69QjDt1SroP+QxvGIv4B+ZjYWO94n11dolQzqcd6H0GUG/ZZfwIA00
 eLKy2At+mcRrvNjlx9G7bo7TKQ695gNLqrRoPfRE0IgJecoKyQo597qBhTI4UcQQqOIh
 /ZeCAZkQO9IWCbcHiwJcILn6sRk68QcSSPSJZnkXdc1VyIjl0o+6LjjHfH0X862hsFou
 ve2KUD37wdanCWaoIc5ZJiLuASL7iJOnXPafP7GlMo9pWI5EUD9JZpDb3X4qRDEwjpY+
 U6vQ==
X-Gm-Message-State: AOJu0Yzd7/pJRkR1g2G+8nLVfzNFzx1lmRGUYsfDoscUStuJcAVzKjTU
 pEufFDq5urMfNfPrHrdohdMLi9nCc4xBcioBarZN08x553N5iP2vZj8GNdeaw55V3gulY5vDD6b
 EskRHuKo=
X-Gm-Gg: ASbGncsva7aYqKpiI3XGnrd6uOqLOJZ/vyh4vLDNPwyaqPga3BKgfsep39qS0AB5mQ2
 ecWUy5ZuydVRB2B0GPTDSAIywQoRlvsUoYXw2Kvba+F6BFQjOtZICQExI4ZFyBTlCv2NQXXdW3D
 deOU4rdlNY2bAi6n8GY/k+mOK7EEFDxGp/D/v/ftQB7EpMjlphq70dK+EjvWimqsi74184JmbAd
 pWx6bULij4mPz1HVQT4kPTSFQDmRIkBaBKi2NJ2fm9YhkJF79VUcq+83QIAvmuFk66YyWtxBZz9
 KuXS+0wymC03K2kup5leV2u14enYYep67eCgEoQ8BfQFyNesyjmmdIlv9N2W0y0HGUpMJNRbX+J
 /VfDTuMiKfk0lAPUWGrftlELbb0sosNInd0otDA==
X-Google-Smtp-Source: AGHT+IEPGnxui1szgyTJY9LcrQYDojdJQNv1GjHgctQTDG37w0iyOi3Wz9JQ1MCWORE1TRmkc9tgyg==
X-Received: by 2002:a17:902:f08d:b0:240:10dc:b795 with SMTP id
 d9443c01a7336-24096a73014mr96763115ad.1.1753987977508; 
 Thu, 31 Jul 2025 11:52:57 -0700 (PDT)
Received: from gromero0.. ([152.243.37.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8975a66sm24075335ad.95.2025.07.31.11.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 11:52:56 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 manos.pitsidianakis@linaro.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH] tests/tcg: Fix run for tests with specific plugin
Date: Thu, 31 Jul 2025 18:52:32 +0000
Message-Id: <20250731185232.2351818-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 25aaf0cb7f (“tests/tcg: reduce the number of plugin test
combinations”) added support for running tests with specific plugins
passed via the EXTRA_RUNS variable.

However, due to the optimization, the rules generated as a shuffled
combination of tests and plugins might not correctly generate the rules
for the tests passed via EXTRA_RUNS.

This commit fixes it by correctly generating the rules for the tests
that require a specific plugin to run.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/tcg/Makefile.target                     | 21 ++++++++++++++++---
 tests/tcg/multiarch/Makefile.target           |  2 +-
 .../multiarch/system/Makefile.softmmu-target  |  2 +-
 tests/tcg/x86_64/Makefile.softmmu-target      |  2 +-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 18afd5be19..e7bc66b5a0 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -170,6 +170,10 @@ endif
 PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
 	$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
 
+strip-plugin = $(wordlist 1, 1, $(subst -with-, ,$1))
+extract-plugin = $(wordlist 2, 2, $(subst -with-, ,$1))
+extract-test = $(subst run-plugin-,,$(wordlist 1, 1, $(subst -with-, ,$1)))
+
 # We need to ensure expand the run-plugin-TEST-with-PLUGIN
 # pre-requistes manually here as we can't use stems to handle it. We
 # only expand MULTIARCH_TESTS which are common on most of our targets
@@ -179,6 +183,13 @@ PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
 
 ifneq ($(MULTIARCH_TESTS),)
 
+# Extract extra tests from the extra test+plugin combination.
+EXTRA_TESTS_WITH_PLUGIN=$(foreach test, \
+                        $(EXTRA_RUNS_WITH_PLUGIN),$(call extract-test,$(test)))
+# Exclude tests that were specified to run with specific plugins from the tests
+# which can run with any plugin combination.
+MULTIARCH_TESTS:=$(filter-out $(EXTRA_TESTS_WITH_PLUGIN), $(MULTIARCH_TESTS))
+
 NUM_PLUGINS := $(words $(PLUGINS))
 NUM_TESTS := $(words $(MULTIARCH_TESTS))
 
@@ -186,19 +197,23 @@ define mod_plus_one
   $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
 endef
 
+# Rules for running tests with any plugin combination, i.e., no specific plugin.
 $(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
 	$(eval _test := $(word $(_idx), $(MULTIARCH_TESTS))) \
 	$(eval _plugin := $(word $(call mod_plus_one, $(_idx), $(NUM_PLUGINS)), $(PLUGINS))) \
 	$(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin)) \
 	$(eval RUN_TESTS+=run-plugin-$(_test)-with-$(_plugin)))
 
+# Rules for running extra tests with specific plugins.
+RULE_TEXT := $(foreach f,$(EXTRA_RUNS_WITH_PLUGIN), \
+  $(f): $(call extract-test,$(f)) $(call extract-plugin,$(f)))
+$(eval $(RULE_TEXT))
+
 endif # MULTIARCH_TESTS
 endif # CONFIG_PLUGIN
 
-strip-plugin = $(wordlist 1, 1, $(subst -with-, ,$1))
-extract-plugin = $(wordlist 2, 2, $(subst -with-, ,$1))
-
 RUN_TESTS+=$(EXTRA_RUNS)
+RUN_TESTS+=$(EXTRA_RUNS_WITH_PLUGIN)
 
 # Some plugins need additional arguments above the default to fully
 # exercise things. We can define them on a per-test basis here.
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 38345ff880..8dc65d7a06 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -201,7 +201,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
 	$(QEMU) $<
 
-EXTRA_RUNS += run-plugin-test-plugin-mem-access-with-libmem.so
+EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so
 endif
 
 # Update TESTS
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index 4171b4e6aa..98c4eda5e0 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -77,5 +77,5 @@ run-plugin-memory-with-libmem.so: memory libmem.so
 run-plugin-memory-with-libmem.so: PLUGIN_ARGS=$(COMMA)region-summary=true
 run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
 
-EXTRA_RUNS += run-plugin-memory-with-libmem.so
+EXTRA_RUNS_WITH_PLUGIN += run-plugin-memory-with-libmem.so
 endif
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index 3e30ca9307..4e65f58b57 100644
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -40,5 +40,5 @@ run-plugin-patch-target-with-libpatch.so:		\
 run-plugin-patch-target-with-libpatch.so:		\
 	CHECK_PLUGIN_OUTPUT_COMMAND=$(X64_SYSTEM_SRC)/validate-patch.py $@.out
 run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
-EXTRA_RUNS+=run-plugin-patch-target-with-libpatch.so
+EXTRA_RUNS_WITH_PLUGIN+=run-plugin-patch-target-with-libpatch.so
 endif
-- 
2.34.1


