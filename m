Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926CFC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetgO-0007q4-45; Thu, 24 Jul 2025 07:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetg1-0007Ss-T8
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:54 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetg0-0007zX-28
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:53 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ae3ec622d2fso132980866b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354790; x=1753959590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6EYeOydwHeWT+0KjgI8rE6kC6uYaOoJ0ACHOIOUReQ=;
 b=xfYutSfh5LQ9HPJ3Yk2H0cthMUhSGMa1QadrXxCsGU6/eJlTBch8hCkn87r67bw2/4
 OOypcnHm5Whn/Ksk2B9RiaksedsuCD5GEHane+3DsatCXHKmtoKTjKWLpzyE41t1nPP3
 i7IfzYiHiMy7JIaEYNza0iy0hCWisz9/H/pg+AA1T8s18qeyczN7Xes4CTKX2gAosH64
 JvCKFaEXqfdFylyft3O2NMqfoGdqeW48Y+/EeBmGsFxfa+6KY/yU3Dgm/RUcU1EA714V
 aMHJMfXN0telrBR35+PiqxQfMtCRakxgNJBm5cUeXSeN3cFw2sC381BkLratnO93boFx
 92nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354790; x=1753959590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6EYeOydwHeWT+0KjgI8rE6kC6uYaOoJ0ACHOIOUReQ=;
 b=LRYiZeCWqn8IX6fPdo3JsaaFMssbqoogS/9evoFE16eF6PsCDnE7L0vOMP4S1ekw/T
 XsXJ7oyqsOSnLC36ZKUTFDhKpQ9++F3qzr8gb5LBu9/LWPb5hDusOJMOlpQDEVa3RBY0
 Iwiq3rTOHBhL6cM9r7OVEIJjI/7lLKQuYUva2z5hGSOtsEG5E2/bQYJHC6FhzLu8VkUO
 K83NqjZVAWSujyIEWMMD+YVbBIpWD/bpDHWJZmxXVgL8o5Wz6ZxJQ0/+lU1tS1Ot/b76
 XohQ1B1UiP6xW5dHeVfRvgczcFj336hEuzkk3wvsK40h+JrxN/c0i7GI8WG1ZpwRS33L
 2dcQ==
X-Gm-Message-State: AOJu0Yy7oftruBqeEPRcI72Gp1K2HWuq6p6Wyfnn9SUDHOVR+tVxoyVc
 IiquWUh7GE9pxBBlJMaXscNVtVFa+rE0yQPajLbm0y5LQ5m9uQsp73BnaR91I6Z6Jgc=
X-Gm-Gg: ASbGncvBnnXquR+4jwjsuV6hvTrQP1TWxOrLoM3JzigxFsSLe9887G5ri2OobUxsPKR
 1fLrZNwDRYPfwGB7eMngCc+k/m97hLhBeU+VLnKiR01cdTuTiHgUye4NupGcmoT+W2KlZUES31r
 NkNaNjJ1qroPaF7Sb6mP6rFDlEc/WUdUq36tvBYqoGvssLMzCOG7+yp8uw4Y21lABtpw6iK/tEO
 dZ7yZWHKmHM8iOlYo3vsJnuSasJMXNb+sKuYFHaZNmvw5rdsY3avXLuMuRETDzm6HAD2wP/Fjol
 nuRO4S8fa0F3BZGkW11VBr+v5rXqjeG7uNDQPlnYVE0P3pS7RDxciWnRHq565BKU38b7FOv/Ojj
 pH1+j9cSYvphwKlBbOICAFHw=
X-Google-Smtp-Source: AGHT+IElkCmawROGosVEaY32z/FVCCKsjMcwMbxGZthmyJmTkhWRruBW6yCcbdpNZetD4wJv010WQw==
X-Received: by 2002:a17:907:9612:b0:ae6:a8c1:c633 with SMTP id
 a640c23a62f3a-af2f895a512mr602231766b.34.1753354790317; 
 Thu, 24 Jul 2025 03:59:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47cd64da8sm96387966b.60.2025.07.24.03.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E22755F8F1;
 Thu, 24 Jul 2025 11:59:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 11/13] tests/tcg: reduce the number of plugin tests
 combinations
Date: Thu, 24 Jul 2025 11:59:37 +0100
Message-ID: <20250724105939.2393230-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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


