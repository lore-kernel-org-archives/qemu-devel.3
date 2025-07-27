Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA222C87FD3
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwpP-0002iz-3G; Sun, 27 Jul 2025 04:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwon-0001lp-9v
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:17 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoe-0000D4-Ly
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:10 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-612a8e6f675so5698051a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605186; x=1754209986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUwWgu3Z3v2IIptfvV06aRS7E7HsMNnjaVsN/QeYzzg=;
 b=uijxztIcGPaTn0f0KYpwYvJn7MDmAcxSbOMnuVwET65kRpaxeqDlNXOMnsBdq8V44k
 EIOHgZuCznuovJa6kxaKIpfRRivKzLO/FE6dBJ1zbWNEk+vVdeWNavWUIFcfx8WNKdXK
 iOuIrKzgsF2OC2i4GXAg1vIlNyzIwexw7xvltTiXFqTKQyKTBhy2YfAOcOV3cmswhjpC
 wZvnNiB+JS/yngxIM+YLz5ZY5oLTIFvC+FUas3SbdU6zQrotQXpeKKcF5+RDENQ0I5d2
 FXvztFe5b7gp7TD5WvsUwvBmLt43gQuMYRB4tk2IXWMuMOx1VUM47iyZtjcpDgP6j/jt
 7qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605186; x=1754209986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUwWgu3Z3v2IIptfvV06aRS7E7HsMNnjaVsN/QeYzzg=;
 b=Ol08GokalZ0A9qJLt+BEzItVnfGZydk6SpaiX+Riv2gMJnX5B6xU9fM6WaXtsg1lCI
 IaRLCbbgoKFzfDoB7pbHJqx4skmPLCGxPFbewootBDm6MVDQFEDChQCgUfe6bIR0VwUG
 7UzAFuhrkGSR+AogH7V//NRX7m/7RwvSRQ+fpmlClLzAnWmExC/eh+FJRX/sFCyH3jdC
 JYBD5VBU339pa4d/49M5Veh4U9GwMdXJ5OJTM3t9xso1x5IiA71HGETnjWPkjsXguhfY
 Bu1Rm+tS+JQvq2ubIOIifFXFADoLYY5sGGQd7bqNaFln3MxzdLpItulnPu7LmtlFUewQ
 zj9g==
X-Gm-Message-State: AOJu0Yy5poO6Jd0Q/tyx0lfpD+RiEjAG/Pj7zUxPvBawp35Yl2/Y4tSZ
 JExqJjs8fEtdBqt5YKMMHbqztg7Du8WuxAVAkOw8Fz/Fa24Fl2+EIo9RxkzjjbjVJrwOsRRBrFm
 wYLM1
X-Gm-Gg: ASbGnctj+j13ptJXjd6aGfzN8kcOVQ2OR+KbZaYeJSOiYvUUKhQHC0Qegfzz5yajh68
 aDdzZNU/SOJSyWZWGoRmcWu0iOPw4BWdvdNEJSO3HsmWi8Nv5tGkJl2XgVgRBBAwQg7dUW/ZeL+
 n4+5uruwIefnQoPY5NrGGCAPIjS6M/9PcUT3xB6smGR5Qfg29Gpd6sLiBC6bY4zW+3jcq7Dewft
 IYFWVxpKUm4BBk6jLpWj1s8kq5ZCmLtJU9XY9gyFKeoFFQrWvnkPOxISDLOD1083fjia9Vv9jF4
 7/95gIexkIpmaDI8AnPeB8cn2XhrgH246HuWL2VM9rvkQjfP/p2cp/wKE4n3llNHggLUzTxkhtz
 bc4HCJiW2WLt8Ug1c99nz7llmz89M/sd7bQ==
X-Google-Smtp-Source: AGHT+IGuebsd74OBqVR3WhCMuTHMG60QYHCmO4M9KRMadzaXKYJjfM1qQVBkocfSlC+iYHDhQ6+I4w==
X-Received: by 2002:a05:6402:1d4b:b0:604:e602:779a with SMTP id
 4fb4d7f45d1cf-614f1f0257fmr7989764a12.28.1753605186442; 
 Sun, 27 Jul 2025 01:33:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6151dfcf1a9sm1055407a12.7.2025.07.27.01.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:33:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 19B535F8F1;
 Sun, 27 Jul 2025 09:32:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/14] tests/tcg: reduce the number of plugin tests combinations
Date: Sun, 27 Jul 2025 09:32:50 +0100
Message-ID: <20250727083254.3826585-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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
Message-ID: <20250725154517.3523095-12-alex.bennee@linaro.org>

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


