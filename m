Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ED4C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcE4-0007jv-74; Wed, 26 Jun 2024 19:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDL-0007Rv-OP
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:13 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDJ-0007G8-OD
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:11 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fa0f143b85so38111585ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719445088; x=1720049888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfJtbR1DHFH39g5O1RoXMV40m1cvFRDojz81uxTKSUM=;
 b=R/C0O/xxplwLGfnC/mgUJVv+waOwEighnZfl4S5pPz5qB/mjGYP6RCblt8s1eTej/o
 gX0UN9gnSc/tpu6r3vV7vtwIpkQ/OQEZxQS7U9G0ZqvuoT87f9lMANnNAareNQ4Kcyij
 Po/7hCOwCy7cARTMumG8Q3M8y3TTES+6h+CdQwcmPaWaGVeKgWuHvLCoSlXdsaSJbbtc
 St1EFA5+66kt8Se5gV4IInYyjnZIUgFYhiKSDBNTK100HAdHDI/B4UD4cfFUUdibei+o
 WiUiIyTGeX6hkF0WlDpWXOVkw27KEfVJvCHT5AR4fNDgWKxL8MCs8nO6BE+hty+yHdwl
 j+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719445088; x=1720049888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KfJtbR1DHFH39g5O1RoXMV40m1cvFRDojz81uxTKSUM=;
 b=VP7X0NO/WWn6GU1dtQiPeuPc5DpPT+HdDDum0j8+R2837oytc0voh762icBp8sT0Ha
 3u1FjxLixNlAGyR3tY8g6tcccs7KgZkpF1S3AVYl7Bc+0YJBULLfz6iucZKZTv3qB6aB
 xc4sAFVIZSsMrZ3Ld8wsVaSPK+/I61emmSsZ1D2lBxRp/yFtrRGKgFWI4dqQI/+JQkcZ
 b8k7OtPzMFsj3XiecinvqdVIZGwX7YTuXM5De98HZwhN3gZ6Eqo7V38udgliOlKxfeLh
 BjkLzT2W0zr/vIIyE6fN8PAwI5pz2smAYDKMuNls0wXC+nG2jAec/5CPBeLIsjwwoC0U
 iAgw==
X-Gm-Message-State: AOJu0YwIR151dFPQTxooTVW2QdrcBZkcGNtu+MNgINdq3Htb5Q/EpOaD
 yy0b/Z7TsWK47fjPNIP6B1PGJqcCi3dUp5mp/mANo/5NXkMY9pGhi0gxTwW8j7HYYv4mNssWta0
 UxkQ=
X-Google-Smtp-Source: AGHT+IGy3accr33oAdGDLdUXwqqVdOnuoVVeHFWG3GMNM0enhtaadN+kTeu6NBfTF3tLZECfb/7pIw==
X-Received: by 2002:a17:903:2446:b0:1fa:2760:c3f3 with SMTP id
 d9443c01a7336-1fa2760d403mr124158315ad.13.1719445087703; 
 Wed, 26 Jun 2024 16:38:07 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac8df624sm563055ad.29.2024.06.26.16.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:38:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 4/7] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Wed, 26 Jun 2024 16:37:54 -0700
Message-Id: <20240626233757.375083-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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


