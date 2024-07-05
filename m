Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF58C38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPku5-0005lC-83; Fri, 05 Jul 2024 11:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPku3-0005j7-9f
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:15 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkty-0000Rh-57
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:15 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a77b550128dso227619966b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193467; x=1720798267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylCfX57vu2XtKdQ2UE07h/WESYaBK96i7YkZDwjHda4=;
 b=jMkTZFL+H/x6Kc7yVz5WrvgqBDQV/BzkdYeVZw0oa+71zsjFOJnoI3HnPwl46MQzSF
 0chlSeQX1yy2x4i3EU4ubbDXMwVinMCOHA3UC/XOyDkgzbTCVNb6jGGIcNa8vadmBkkD
 bucmYiRFLq/t4ToeckFB3IznwMaFXia7fK/qWO4Wh5ggZg4hozXfWXLsWnysqIrmxe1W
 uswP3WIypq8Xvt/c25r6ZtRHAVAQNsH8GAQK3Se4Aeky/WdPMJHXoFaClCkf4BrZdj5o
 ijjvSOuOAL+Cgmbz9nKJnlAC1MS8LTa128c3LTUj9nC5c3KmZ0ME99Rfa0Y3WfuExm3q
 5+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193467; x=1720798267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylCfX57vu2XtKdQ2UE07h/WESYaBK96i7YkZDwjHda4=;
 b=lPY20YaG/EJzRS6wIGWCZmTJ5k+U7mofnuGcEtx8I6OyKz4Wy6jDr9PKQhcCNQlNuJ
 mG1Ajziah6Qy4twqEK/SVTlFSqoKDt7d6pbKPAe1iLuFTn0IJwErF0iNK97Hik4piu8d
 vLIKqwB8AYqz3uY+lXgR9P6ikAe8imuaQlYehnWgjIGkX+irv3bjgQxtZ1upSjbrwpBp
 /gVH0zf1yNWh2hGn4L/GXx9alBnOLR/QMJQrlxuCD9LIpfRDor5F1QjXxmJ/7JC4+LdZ
 EJpO/BNyzj+YVjQiN1g29bPziYU55JaUVu6lMQSchkaaN1XPGoTNz0MGrXsH38w7tJ15
 ZagA==
X-Gm-Message-State: AOJu0YzTRBs2CexVdrPHnf+gZ5iXkiuHKMvQaP17dIQkTpNLH91+h2pz
 L9y/7kiu5w9o9KKeLfflIxxMVz07Hva7aHZ0s90QkoynJ5znFv7nj14z62Hzrfo=
X-Google-Smtp-Source: AGHT+IELrAN0WvOf6IiV4zXOkT7YLd0AvenxfVzf0knR6hixn0iY24Ig8j1kL7B9Eus2YWRPN1Fmzw==
X-Received: by 2002:a17:906:17c1:b0:a6f:59dc:4ed0 with SMTP id
 a640c23a62f3a-a77ba48e64emr387205866b.46.1720193466525; 
 Fri, 05 Jul 2024 08:31:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77ab405d36sm185924166b.186.2024.07.05.08.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:31:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 760D95F8AF;
 Fri,  5 Jul 2024 16:30:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 15/40] tests/tcg/arm: Use -fno-integrated-as for test-arm-iwmmxt
Date: Fri,  5 Jul 2024 16:30:27 +0100
Message-Id: <20240705153052.1219696-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Clang does not support IWMXT instructions.
Fall back to the external assembler.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-11-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-16-alex.bennee@linaro.org>

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 0a1965fce7..95f891bf8c 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -8,6 +8,11 @@ ARM_SRC=$(SRC_PATH)/tests/tcg/arm
 # Set search path for all sources
 VPATH 		+= $(ARM_SRC)
 
+config-cc.mak: Makefile
+	$(quiet-@)( \
+	    $(call cc-option,-fno-integrated-as, CROSS_CC_HAS_FNIA)) 3> config-cc.mak
+-include config-cc.mak
+
 float_madds: CFLAGS+=-mfpu=neon-vfpv4
 
 # Basic Hello World
@@ -17,7 +22,8 @@ hello-arm: LDFLAGS+=-nostdlib
 
 # IWMXT floating point extensions
 ARM_TESTS += test-arm-iwmmxt
-test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16
+# Clang assembler does not support IWMXT, so use the external assembler.
+test-arm-iwmmxt: CFLAGS += -marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16 $(CROSS_CC_HAS_FNIA)
 test-arm-iwmmxt: test-arm-iwmmxt.S
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
 
-- 
2.39.2


