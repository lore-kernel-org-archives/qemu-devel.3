Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E810EC3814E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 19:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQArH-0002Fg-FC; Sat, 06 Jul 2024 15:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQArF-0002F2-Fm
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:14:05 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAr0-000455-Py
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:14:05 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f9fb3ca81bso15809695ad.3
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720293227; x=1720898027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOVQG8CjYwbYZDeC+WrM19zb25ZnXpMuyBziO7HazqU=;
 b=wJY6/rIqDV0scUNDMzOu7Gra417DP008PHaTn9xTmlyPB773p+z0WG1lpe5hkjCkdX
 B204JiAxxinyc9XFezfH/PNPVRqjkv0F6oVBkJjpZr+GKYwo/GuneaqsCzpZhaTslQCn
 Z30b5uvYQY1BxKOBKLF+DNhXvQx1Yg2YEJ3iyhp+IWHUjUUsT3lncLbPRPfS8bmS7PA5
 R6C1pvUfNLcpIFXszroZE6OCLjFTQyTFKy3HEJjwiOsaNMA2/4OmyEwEuYM9tXgetYRo
 tXAoGeo2P+s9JMnvpYaZczWFTUtRgiijGik6fhSDZDtrH6juydoEG6cEToK2mcGL+Ocv
 5/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720293227; x=1720898027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOVQG8CjYwbYZDeC+WrM19zb25ZnXpMuyBziO7HazqU=;
 b=uhSMUl7+eGTel4r2ztXHIiENYze3Avefvz1vtk4iFKo99jq0Wo8itHvlswzM5mU+YF
 GfX7GaFBfGdDn8XqXgakyB/qfg2HBbg1BH5gBjR7Cx3VVYmVrxeHCC0YCCEghVNYZoik
 O/htYoM2SirMkgKwWX2R/29QfEtrunHpELFmhLk0iMQqBjOGoVUeu2vqx1Sns3zLZgha
 iz7ZEyMoHGM6Az4hYz54i+TKgfj38VtrQYqjKt7Pb70kC5xSDpOzrh1oXVXtIBAkK6yS
 ZKyhRBPLnf45OX3NSMbr576cHVbbLcH0vQR8w/4tM25GFMWP4Nrbdde/Asmv9UH/pCmW
 H87w==
X-Gm-Message-State: AOJu0YwLADH9lBP4kRf0HzimrjowpsseLoFblFzKshT9eRrs8o3LuxEJ
 gifqu+CzbKFcW03d5mpONr4FLC9mW4Pvhgufa+judFsvMKqjTc85ATS54N+h51XP4iwCOmTRP5f
 pPOU=
X-Google-Smtp-Source: AGHT+IEFe7T1JSLTV153DdUh1RSDePZ8ViLcdAwVyS+wCxMOjahf26VLsr0B8I/4zwm5ZY0h0ounog==
X-Received: by 2002:a17:903:41c7:b0:1fb:6616:9cd4 with SMTP id
 d9443c01a7336-1fb66169f60mr14796955ad.38.1720293227456; 
 Sat, 06 Jul 2024 12:13:47 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb6153cb3bsm17304305ad.129.2024.07.06.12.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 12:13:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v6 4/7] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Sat,  6 Jul 2024 12:13:32 -0700
Message-Id: <20240706191335.878142-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/Makefile.target | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index cb8cfeb6dac..52616544d52 100644
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


