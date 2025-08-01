Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56F0C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 00:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhdTJ-000334-MK; Thu, 31 Jul 2025 20:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uhdOu-0007xw-HV
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 20:13:32 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uhdOq-0001kD-PS
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 20:13:32 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-240763b322fso10438335ad.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 17:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754007199; x=1754611999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=puyOmxGd5nbAUKxa4bS/YO3K65xgCmHZUgpZjwuLvOY=;
 b=YhGxl2qN3KE4VJ02gClvVaKXei4CnfGlaVNm1hQo7yVkAUVdaGqel0PtqlpsZQLqwY
 bSABEYcIqYfQPDlsMqmY/dnE2HYA5XJ5B3PRA5/MVbaoVwkMmHiEsuq+HuqVokwUT7jp
 zFfHQAtWqR3P0Pxmz/LsgO66k/sNQF1SeB17FjFSfkx0eftRYiRgX0PN9a2ZvTpzXTW+
 NbRxDsGKsEb8qT+ZH+4I0OO6YPa/lIhR1w2ttvfvw8UpNGmOlwBf7nfE8/qNk1XSgmcs
 u+M2txjs24fpgYn8sypG07VXG9bQahpNX24qih/YlCm/gawZpQbkU5/47nozHeE99eQj
 3V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754007199; x=1754611999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=puyOmxGd5nbAUKxa4bS/YO3K65xgCmHZUgpZjwuLvOY=;
 b=xDfbEGewJyrZ8HMtrGdOCMIvafxf7CSas0/KXCvDw1AGXnhJyUHLYGxY05aWePARqY
 CvzT6o87OhZQeauqH9Koi9+tDLsjKpxUD5oza0OWcuYHaMl2khP6C+yLAWG7u+5zSYSK
 0lAaKC9JFN63akKF0Cb08zfxossoq+x/PVaiAHt25VVBStmKGFQlilVLW3gc+D4AU5Da
 IisM1nNwjpbwdE5W+QWBSVjs2pkHZW90fXb+NzN3P4ojXZTMi+xds59rTyW4D05HzkQw
 5sTEiVOLCe7ZpuV4CkVglnu8HF3JKbaMqFyai4xR+C7CnRhxIYHo15k0hczxGSVu2bDe
 uA8A==
X-Gm-Message-State: AOJu0YyQJBkkEN9EUEf9fuSAVSO3CxHYJoWm5rp/CRXdkCX7iD36k+ZW
 7BZeya+Q4DcYufu2AbVKaWe4xOJlV4eZZwsvEBrfOjc4HpaSmx25nZKjCewIr3MADGlOMRPPc4V
 MUdfCRG4=
X-Gm-Gg: ASbGncuCRld/1NnozSfQwVPCVzKc49aj6xwiQcG08julvwpV5LZYnsb94+vWMwQtpbA
 dHI+pEUcrdODPt46o/qpwyE57+ZhOleyyZip0tOl2D53qeJvn20UXT/akXBTOJp0lLrEZ0iTTFY
 mnn/3n0n49L413/3ApqM9uslCZ9ICN/lb9Y14Vy3yTi/3DMkIft5Vx2A/IG0KtPOsKg/zSFhvKf
 IWaVvaRklrr+x97u543LbgqaW9LdEGWVz9u2dLUZrWJZVMEEYwY7KYklVmr+2lQCjyiaBgF4t8t
 4x6qqeC47zg77xg1sAf0QjQ1UDk2YrKUE9aLr752uEm0lrTVFOtfOeqpMPqiOu3UT7zP0BViTdh
 yYrl378mhIxXWZzKTS+TT7oIzDhY=
X-Google-Smtp-Source: AGHT+IGHF62TxgPqvJmlTwcX9rGAZqDUXXtOfDQVWBm5/qeGiVStZKpeuhzZVncIUgF6kXTqVk7hqQ==
X-Received: by 2002:a17:903:1b6d:b0:240:8fee:e500 with SMTP id
 d9443c01a7336-24096b76dffmr122340575ad.50.1754007199035; 
 Thu, 31 Jul 2025 17:13:19 -0700 (PDT)
Received: from gromero0.. ([152.243.37.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f1ebc1sm27993855ad.67.2025.07.31.17.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 17:13:18 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 manos.pitsidianakis@linaro.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2] tests/tcg: Fix run for tests with specific plugin
Date: Fri,  1 Aug 2025 00:13:05 +0000
Message-Id: <20250801001305.2352554-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62c.google.com
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
---
 tests/tcg/Makefile.target                     | 20 ++++++++++++++++---
 tests/tcg/multiarch/Makefile.target           |  2 +-
 .../multiarch/system/Makefile.softmmu-target  |  2 +-
 tests/tcg/x86_64/Makefile.softmmu-target      |  2 +-
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 18afd5be19..af72903f89 100644
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


