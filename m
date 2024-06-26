Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F611C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMbpG-0003DG-9O; Wed, 26 Jun 2024 19:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMbp7-000392-6B
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:09 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMbp5-0000Ou-Iy
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fa2782a8ccso30404445ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719443586; x=1720048386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doL4IgQgCF3HWgmN7iQLNBk72z9WitWnst2YOIXTsDc=;
 b=PpTviXvN/4c7MjKUnYEaPn9TSOlwwp3b8ztjNbi5eWpKtSM/vVLKnGO1kI6zWbIKHK
 fi1buTqdVzBKxoAiGW3eisatcGS91fIF+rXTNRq/8rFDFSc4dGc2eXTVmyEpbNNgk5Fv
 xow6JiPJXyOvRpp28km+Reh5IGg7pZ60MQYkZgcCvujDo9/mIhXCUpP/O/evri03z6Is
 YP9/apHLSwRCUEDGrAhFbGCgePNY7GMoVKCoIYWvkdiahNUK6Di2NfC5Hepv4gK/glTa
 gD6UgMt+aC14lR4iCvSftx0oY9SHnDZhkzlrX68ybq3Xz1+8qRtoQoIKuWEVAzmX6Ebj
 JN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719443586; x=1720048386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doL4IgQgCF3HWgmN7iQLNBk72z9WitWnst2YOIXTsDc=;
 b=gihc/l5JSFlq+k10PRpa9W9j9SnJCjuBsU0mC+mZsyCSOg+aSuIj9V3wONVgK4ksGV
 oYrf4GxZlmdaldSw6bzNXf3KY6Nq6G4N6FaiwQvIfxM/A3/ViVjtYBKP5wEZlWxqgtbN
 ATMjb6lieSYIDnpGmMXtB0yMDqMzozlLfhKV7mGIdkmO8i4f37+Yfa5o7AcFBs2c9aGZ
 5qvm4B02BKAYK52q441B1twsCGaBBdYJB8b4VLglodojrLhMVblaiVOFcMzU2rpAoUOc
 hic1eMsucorVvSrRexD/x/CJd39tQPsens4V6fsoOQ0ox4C7txCCmMmcsStwBY6Usc/8
 sQWQ==
X-Gm-Message-State: AOJu0Yyw90piGg/ULWa3l92+ndp7reIGHjs58hH+5b7Dv4udHUbLk7on
 1GG40HAs/uqzk0XcmjFinXp1InBJ6UHoOtOqsyR0ixlYjrsdKdY3tPFF7SSb3KasvSV+Vs6DEoi
 EpiI=
X-Google-Smtp-Source: AGHT+IFAV/V+HBonKzPmujeU8znPTO3DXycdD5c7hC4jl3KMq1IoZny1TsyRBzC2m8d/vtrmnHukNg==
X-Received: by 2002:a17:902:680e:b0:1f9:fb0f:b9ec with SMTP id
 d9443c01a7336-1fa23f35fffmr91719095ad.62.1719443585803; 
 Wed, 26 Jun 2024 16:13:05 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac82cd3bsm478215ad.0.2024.06.26.16.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:13:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 5/7] tests/tcg: allow to check output of plugins
Date: Wed, 26 Jun 2024 16:12:53 -0700
Message-Id: <20240626231255.339353-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
References: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

A specific plugin test can now read and check a plugin output, to ensure
it contains expected values.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/Makefile.target | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index dc5c8b7a3b4..55993611cae 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -90,6 +90,7 @@ CFLAGS=
 LDFLAGS=
 
 QEMU_OPTS=
+CHECK_PLUGIN_OUTPUT_COMMAND=true
 
 
 # If TCG debugging, or TCI is enabled things are a lot slower
@@ -180,6 +181,8 @@ run-plugin-%:
 		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<))
+	@$(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout || echo \
+	$(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout failed
 else
 run-%: %
 	$(call run-test, $<, \
@@ -194,6 +197,8 @@ run-plugin-%:
 	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 	    	  -d plugin -D $*.pout \
 		  $(QEMU_OPTS) $(call strip-plugin,$<))
+	@$(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout || echo \
+	$(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout failed
 endif
 
 gdb-%: %
-- 
2.39.2


