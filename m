Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F58C87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwpF-0002Ef-4f; Sun, 27 Jul 2025 04:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwob-0001RK-H2
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:05 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoY-0000B9-Oj
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:05 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60c5b8ee2d9so7110343a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605180; x=1754209980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNJ2MvKRs9uDkdQcc6X7MIK2k+T8sian3QFrXVTACAY=;
 b=j2ALle9JD68F+V78QllnazFXM9Y5ARh2H2/I/wLE2GSYxatX0trB1MokPCi9O18u4X
 Pza0WZBreLy2s1at09i+bymW9SMVdKWAtIY4slfbft+vNTyQ7IdSWzMAVhbMI6TmG5++
 KiR0Cz+R2B1F0kj/vI6SHFStq9/5BPGrX0Uun7BNZE8EIZRV5bv15EgwCFJIQ9mMeSBW
 wCsZV4K0TcIGtb260kz68MyUvN5urfLMQOfvtI4H0dYJx0bCmOavJSWkIMtFmGq3jkZq
 PCb3mehEvFeDEcKRmOHqupLHsj2vm8BeZ0uztdNZSvyEJVb+A2UG0sbm8Kv09sFBcjm4
 SBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605180; x=1754209980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNJ2MvKRs9uDkdQcc6X7MIK2k+T8sian3QFrXVTACAY=;
 b=NDx2U5/8pZ+JedL/zMfVf8t/g2ab7NUtx3kcEdEpaECb+vws8bcbKQU6+TQazf4xfa
 DGQjVDLehNWbhF2ny7JDvFt6qulJOnBrwxAxFlp9xxc/Fz3feNagpLct6jKmiKgNCcgJ
 cRxNq2lbXDvmO35I6mKbZf+SVouJ9CiYEAIekk3kjU0AWn81ES3EILUkzCmHp4bB1SEk
 yQcF6tP8v6bmVQcu+R2Yv3ahglJU9m7bS/yEocG0AKaoLGi7HeW6DhbjxpNCjpbo3r2m
 DcyX9V2oHipm3Enz1f5oMJGqU3xc1nsB8a7tw2EhsyxwEHxV+Ha1pY7jukpQj6m5ee9D
 lb5g==
X-Gm-Message-State: AOJu0YwIwA2D8J6COgt1Mm+0LSYDwSiK1PWjY7gk9CIs/wMZEC5Rd2ll
 yzxpuASCsHb6g5X0I5PJ7Mz7IjiqkVHhIw+YQFtC1tXRAfeEJce99WZYn/C3OrdJpWRrkcDso5m
 LNBHo
X-Gm-Gg: ASbGncuRMVia8Ym1w1/vCLM47gh2bMImHOcjfY9O+1E1q7myXzXU+KqlryWb7QeBGBw
 itFI+iI4/ZCyRH5dInFpzSe0x7JOcz8EWtxJfIe96Uelaqhnw+ZLmC0B4p6MvPTKgoK/MsuQtma
 P5X3gbjUZjElA3M6OGviHrTQd6HB3/106CaskwfwO+FcAG96TuGMsGWJBbbVKlwfI6iHL3o3K8f
 8D58yuFrC14QkF4igR2oNnFIUF1r4b3VWabHzRElVSZqXY8AtTuaS6R14urSF3TxZRLZwqID07T
 kxsGedeu9JsT+JsakAFngHdN6yVgriRmwcU0QJwNo8o7AMOCtxpScctC4HvEcMvDuejJYI7XyfB
 +pvGPVWpx+NXDOpFS0iD6hYY=
X-Google-Smtp-Source: AGHT+IGLww1PThDFy3FXvnfotiX+XjiYB7VOllY5cVZid/9umnUtupl58ew48u88kyb1T0fhKva9Bw==
X-Received: by 2002:a17:907:7283:b0:ae0:a483:7b29 with SMTP id
 a640c23a62f3a-af619c0d81emr946716066b.49.1753605180328; 
 Sun, 27 Jul 2025 01:33:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635b42704sm256345966b.144.2025.07.27.01.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:32:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B48065F8D5;
 Sun, 27 Jul 2025 09:32:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/14] tests/tcg: skip libsyscall.so on softmmu tests
Date: Sun, 27 Jul 2025 09:32:46 +0100
Message-ID: <20250727083254.3826585-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

It isn't testing anything and just expanding the runtime of testing.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-8-alex.bennee@linaro.org>

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index af68f11664f..3d96182a7b9 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -155,6 +155,12 @@ VPATH+=$(PLUGIN_LIB)
 # For example, libpatch.so only needs to run against the arch-specific patch
 # target test, so we explicitly run it in the arch-specific Makefile.
 DISABLE_PLUGINS=libpatch.so
+
+# Likewise don't bother with the syscall plugin for softmmu
+ifneq ($(filter %-softmmu, $(TARGET)),)
+DISABLE_PLUGINS += libsyscall.so
+endif
+
 PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
 	$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
 
-- 
2.47.2


