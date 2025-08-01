Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E20FC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtX3-0007XJ-FQ; Fri, 01 Aug 2025 13:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3M-0003AN-Rd
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3K-0000zW-Da
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b78d337dd9so677790f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754063533; x=1754668333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QTe4QCluDBY66ITB8Ceh5te2MGHPGvOu4G1EJ1VCMyQ=;
 b=zu+WCGsw9dJyr1BUcfundb8h69jGTDoRrJ0Bh2x9LOmX6w68ww9FNpMw9GtJaVmeWA
 PMzq0B7h1mdTNa2AJGWCh7JISJ6ELVqyJBJj65A/lTiZ5Zylqf5iREjjIyyZm+vkjWw6
 9cELgXYi6Fu9CX+02ZSevQoxZXxUN8rxXJhnTWZ05QtxeSilYzJnruZduUxk7Vl47BBA
 vnUXJaSf1qMaYntlhsHf3tqOPwuYAdSKDoRX2M7a6hm0My1kA2+cb3ZKEKGcqU7LBrAX
 zvByA9OhDlUgvH4Np6zoqsNdPAwIKZhY3JG25g32AxQxzMDU3SDemL5ZGC5odTHtq6n6
 hAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754063533; x=1754668333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTe4QCluDBY66ITB8Ceh5te2MGHPGvOu4G1EJ1VCMyQ=;
 b=HkaUSkpjz+L8NqWefzzLRKLUBjDsffyJ5Ls640fVitrYKUvSFqrYRU4+GlOqns4Lvn
 M7+0Lb/WGdEu3FCTj4gpWBOs79JP4Ay1OM7dTx++MxSrzmUcaHu/M3tJn1pxg23peqUk
 QA6ughLbEDpQ1IhYydz9CzWtXK0BoPcO0+BLXv9sWmgx2a8WGKriXhY3MWJ4E9JqRzf5
 xurt6S4N9hMSkZfGBASWebpIReB6v3Y87/W2eQ89PEaPfovwgv/bKZWrjzpjo1J4Z1p1
 BcVPXlnwJMvizWksxDuQ/uANRV+EbAXidQoOlAFb9o8Lacspb0m1lHao/93be7xTQmBM
 mJ6Q==
X-Gm-Message-State: AOJu0YxGY1t61K8cKG8Mg+Dthssm+p8PZR01WM2/bFGJPSYScHm1tsq4
 hNh/w/86M1tYzJorrl4NuPQe6YRDABrK/600mnf/R/EKyHVoKJ1D+Tjmd/FQQglswliOZNLQRjS
 4Qaxp
X-Gm-Gg: ASbGncsF3Wp1auNqy7cJiue3mkXY0hV+byFJENSotmbQ/Xzudcp+jynObKtQJ5pD/IW
 rjXgrfeUA1dwc5jKQpgNSiFpqj1SlA6CAyddLnbntUmYJ8+8vJ17rVK3JvjHS2PhUiTA9liVRtU
 HGigbnri7t3O1+XCpeVyPvoPutWHIjghfM68tDg6yAxm82JaQWAttfHn8mO7+KEP7y7FngAUnGQ
 SEEuDEo2d9WnBMBYajCwM3Zdvx2znQ9k3UD9U3CUmFn6HbD2gSl+g5frqvO8lWtTvX1u9lBoGmc
 sQ2TMyuhx6GYkAN1HPmQCNEpzGbIPSNJmFXk/sujVask+uRI0vLQogbgTP9gxEQQISiVwR+dysX
 ST3WmQm1jvVBlUvW5DJWg7j9BVbxA
X-Google-Smtp-Source: AGHT+IE78s51t+IF69k2YwEn2RBc3Giz5wEvJ2Fnn55VR8fEaas5wSbkiCTjRm9YAlK36HF9c7iYFA==
X-Received: by 2002:a05:6000:1a86:b0:3b7:c703:ce4 with SMTP id
 ffacd0b85a97d-3b8d94c4d87mr235462f8f.59.1754063532686; 
 Fri, 01 Aug 2025 08:52:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2f03sm6176670f8f.72.2025.08.01.08.52.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 08:52:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] tests/tcg: Fix run for tests with specific plugin
Date: Fri,  1 Aug 2025 16:51:59 +0100
Message-ID: <20250801155159.400947-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801155159.400947-1-peter.maydell@linaro.org>
References: <20250801155159.400947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Commit 25aaf0cb7f (“tests/tcg: reduce the number of plugin test
combinations”) added support for running tests with specific plugins
passed via the EXTRA_RUNS variable.

However, due to the optimization, the rules generated as a shuffled
combination of tests and plugins might not cover the rules required to
run the tests with a specific plugin passed via EXTRA_RUNS.

This commit fixes it by correctly generating the rules for the tests
that require a specific plugin to run, which are now passed via the
EXTRA_RUNS_WITH_PLUGIN instead of via the EXTRA_RUNS variable.

The fix essentially excludes the tests passed via EXTRA_RUNS_WITH_PLUGIN
from the rules created by the shuffled combination of tests and plugins,
to avoid running the tests twice, and generates the rules for the
test/plugin combinations listed in the EXTRA_RUNS_WITH_PLUGIN variable.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250801001305.2352554-1-gustavo.romero@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/Makefile.target                     | 20 ++++++++++++++++---
 tests/tcg/multiarch/Makefile.target           |  2 +-
 .../multiarch/system/Makefile.softmmu-target  |  2 +-
 tests/tcg/x86_64/Makefile.softmmu-target      |  2 +-
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 18afd5be194..af72903f898 100644
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
+# which can run with any plugin combination, so we don't run it twice.
+MULTIARCH_TESTS:=$(filter-out $(EXTRA_TESTS_WITH_PLUGIN), $(MULTIARCH_TESTS))
+
 NUM_PLUGINS := $(words $(PLUGINS))
 NUM_TESTS := $(words $(MULTIARCH_TESTS))
 
@@ -186,19 +197,22 @@ define mod_plus_one
   $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
 endef
 
+# Rules for running tests with any plugin combination, i.e., no specific plugin.
 $(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
 	$(eval _test := $(word $(_idx), $(MULTIARCH_TESTS))) \
 	$(eval _plugin := $(word $(call mod_plus_one, $(_idx), $(NUM_PLUGINS)), $(PLUGINS))) \
 	$(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin)) \
 	$(eval RUN_TESTS+=run-plugin-$(_test)-with-$(_plugin)))
 
+# Rules for running extra tests with specific plugins.
+$(foreach f,$(EXTRA_RUNS_WITH_PLUGIN), \
+    $(eval $(f): $(call extract-test,$(f)) $(call extract-plugin,$(f))))
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
index 38345ff8805..8dc65d7a064 100644
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
index 4171b4e6aa0..98c4eda5e00 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -77,5 +77,5 @@ run-plugin-memory-with-libmem.so: memory libmem.so
 run-plugin-memory-with-libmem.so: PLUGIN_ARGS=$(COMMA)region-summary=true
 run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
 
-EXTRA_RUNS += run-plugin-memory-with-libmem.so
+EXTRA_RUNS_WITH_PLUGIN += run-plugin-memory-with-libmem.so
 endif
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index 3e30ca93074..4e65f58b570 100644
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
2.43.0


