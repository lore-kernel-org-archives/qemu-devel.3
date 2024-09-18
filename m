Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4FFCDD556
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1tU-00054R-32; Wed, 18 Sep 2024 17:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tR-0004rn-4d
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:21 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tP-0001bk-JA
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:20 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f75aa08a96so1052201fa.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726693638; x=1727298438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hPYnws2CPsfhEtfVIm4JM3/IzZjfJCyZOBoN4xWTqc=;
 b=ayydsn91G+nUmPpv9xPPyYOkJbeMUKZcCrUnBqqaUslrAadyddxa8AG6uU1iOjBD7R
 dFh3CDb3O3NDQiTiW97Yp1Ekb1BlbHQwu3d7paUHULxd4deiCM5PsQ4R5EC+Y9zsNzHd
 B7Ilnnr9rQF807AX/0/7g22UwxNKs0ewq9Qra37zwJU1xqEGuTr9sQBrQP8b6E40ieoz
 UTowwmwfhGQ1a7R2xrSe/OsWxPxcpzuCiwE1e90G3YEC/e+Kym3/oYCp6J6D8eaHHO4Y
 KqGqm2GDldX3Aa+64ppaHcOdukrfvVdpol/O7KDySYr0G5nw9Op3Nh/cy2DM2jwaxTtO
 WNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726693638; x=1727298438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hPYnws2CPsfhEtfVIm4JM3/IzZjfJCyZOBoN4xWTqc=;
 b=ZJS/yMxRMT2QH6eSKSFlEBDmVvX0hLKcgiHgtwtbxBe8ox1LQM009LrdSe2BW+irBS
 KkUewnPD4TU/JbUMENHZPG/uOquU/9pZ7ddKNO3iotn5eaMGcJc8eH10YpMbAFRGn/8P
 22o2owdiv2jzvNrGclcuiqIu+8QCfxTpbyAFMNAORaH8ze4qA+A9jQ3jeMyicIkQPfvT
 vqsxfx0DcaxCfhFH4MdAI73pImDouHfznDH3rtON04SYvHk7QMxPDDYrwOouz7UX0Wi3
 I/DTG9iXQhroYAhdpaP6XkvKoIm2Llnz4yLtCeQxbPv/BwL0kIlVNCTY5EYggG5HTNQw
 wFZA==
X-Gm-Message-State: AOJu0Yy7mzGC/yu7NKabC2Lxmtyfn3zBQRQg5NJg9Hr5FS9/N2t0iOkf
 07Ueh4N4uvz1RPBaao4fEI+GkSDjA4tujaB3PwmgMmXjIaoldd+PCRZRcgYOkcE=
X-Google-Smtp-Source: AGHT+IEnvjLMHLinVv+EhQk56jEdhD4T8ezGvIWrqMtsdpWXfl9Wmjh2jAhE2/7jpCkrzi5itR2RoA==
X-Received: by 2002:a05:651c:1548:b0:2f7:5bcd:ab52 with SMTP id
 38308e7fff4ca-2f787edca58mr121477401fa.25.1726693637736; 
 Wed, 18 Sep 2024 14:07:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb8a428sm5339909a12.71.2024.09.18.14.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:07:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D1A4B5F90D;
 Wed, 18 Sep 2024 22:07:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/18] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Wed, 18 Sep 2024 22:07:00 +0100
Message-Id: <20240918210712.2336854-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x229.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Only multiarch tests are run with plugins, and we want to be able to run
per-arch test with plugins too.

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240724194708.1843704-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240916085400.1046925-7-alex.bennee@linaro.org>

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 452a2cde65..c5b1c7a786 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -152,10 +152,11 @@ PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
 # add some special helpers the run-plugin- rules can use below.
+# In more, extra tests can be added using ADDITIONAL_PLUGINS_TESTS variable.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
-	$(foreach t,$(MULTIARCH_TESTS),\
+	$(foreach t,$(MULTIARCH_TESTS) $(ADDITIONAL_PLUGINS_TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif # MULTIARCH_TESTS
-- 
2.39.5


