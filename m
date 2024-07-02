Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A95CC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 01:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOS2e-0005Sv-Rx; Mon, 01 Jul 2024 21:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2d-0005Sd-PG
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:43 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2X-0002Ac-03
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:43 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c8e422c40cso2056651a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 18:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719882627; x=1720487427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfJtbR1DHFH39g5O1RoXMV40m1cvFRDojz81uxTKSUM=;
 b=CpTK7hSo9lCZQR1nv0XPdeMfn3hleLofUS3y/mz7v4bjHjsDogxL4JrsD2Nge/2oyb
 unHGTXg/DNrpmSKGE38bmQrYifjcpqBPBWLOx0kUtAcvODdPiLNxFY6zFcjEi+W8dbtX
 SEgzr6nx3eVwZ0MTt3kHB9fuV47huKyUyJLKM39dwHWN+U9/5SZ6z7b5bwuBkDs62XQS
 nne7lNiHHcGpEUps+1BOSkYgZdvttH0U9s+pZB3Q+xs2VcQxGtNTxDe/yoPOQz4xZ2nn
 hvMtqYwVxPx+Ckk2LDqAfLPcw/8B8etBLsS2HeQTYlxU21DDCRIHKFJnt3h2KNJRkldB
 ZjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719882627; x=1720487427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KfJtbR1DHFH39g5O1RoXMV40m1cvFRDojz81uxTKSUM=;
 b=gY8A7veYogdTE1rHogyV0ro0bSN98q0yshlC4zhpQBwWSG88bi6mEPymM4H0NF/N/T
 YxMOe1HzdHv+D7H7dxCMmIwZl4VbSsOL82VGmrfvKVZ5XZtvNHNrXeJMzaMKmyh/JQtg
 uHtBYHCNB1uTRwKlMeEq9h9okD397GP4MMBaNxYekO7P/mn1Km2WsxYcnp3HYtWeoq8S
 Cl1kxCM7HI3zuD//pJyefRvR3wsFPY+jOxj3Gw6bqBHOxXdSYo69SzwUlnZBw2XDnHwC
 vP2A3VuthpXt5zQL5t3wTpMGjqoQbAgv67Smt2G3lxD554yTdEpsPrLmJ0y+itUHCxSm
 GONA==
X-Gm-Message-State: AOJu0Yxz0gWuSS3Dfd+rFU3QwojYFNIsb9isa5AJM579pcuQ7+xAF4Gq
 Kx9OwV1eveRc1sTBLL4cXvhSete/LMBHKGPti6VIKkbU526vzvoYPYiHcQOSTEGUd0nlvoAhYxO
 a
X-Google-Smtp-Source: AGHT+IGk7Ew07BpcISKKOA7R83FAiAoti5BULif+4zM3Xy3zDCxiLVkqrMabHFqjNjYDUqbWVwzt9Q==
X-Received: by 2002:a17:90b:3d8:b0:2c2:dd1d:ce6a with SMTP id
 98e67ed59e1d1-2c93d77a623mr3766383a91.45.1719882627597; 
 Mon, 01 Jul 2024 18:10:27 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce1f198sm7480317a91.2.2024.07.01.18.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 18:10:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 4/7] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Mon,  1 Jul 2024 18:10:12 -0700
Message-Id: <20240702011015.325609-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
References: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

Only multiarch tests are run with plugins, and we want to be able to run
per-arch test with plugins too.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/Makefile.target | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index f21be50d3b2..dc5c8b7a3b4 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -152,10 +152,11 @@ PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
 # add some special helpers the run-plugin- rules can use below.
+# In more, extra tests can be added using PLUGINS_TESTS variable.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
-	$(foreach t,$(MULTIARCH_TESTS),\
+	$(foreach t,$(MULTIARCH_TESTS) $(PLUGINS_TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif # MULTIARCH_TESTS
-- 
2.39.2


