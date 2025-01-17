Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2EFC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdH-0001Bq-5D; Fri, 17 Jan 2025 08:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcv-0000y3-Bn
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:09 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcq-0002DF-9R
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:09 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ab2aea81cd8so358244866b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121382; x=1737726182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXvDUDHkugKiilyR3D1H0/yadk87FxFT1Mw8vy1ltsA=;
 b=TNPyJykwJ6oxeyVdOc0KhqH7b75d7bWLjwdn1fIv/zZ2SyMcXIaWNIgxD9DzGv3eVF
 cUYUQ2qKj5qpjEl5rkrZIsIk8/LKCJwB+Y1uqtdUW3FSXRgOyJuZRIkqgfOyzSTeDQtB
 aNDbf5jBVEzAULRoQgHrraO/iEDqvPI/FRWGr/raBuhMF654Jb6D9EF8LC21F0+K5n60
 757eO6LCyLHbxCb3HfrrLwtiAs3qUMIagnTYaHWNTENob0md2QtLPcJEy2PNig9TLF+Y
 keBEzrMurKx5jCsjtbBaSukEfZFXJJaqQCJ4i8MyFFufiCe5VsSBGTyUuPgxYodzyyhu
 tYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121382; x=1737726182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GXvDUDHkugKiilyR3D1H0/yadk87FxFT1Mw8vy1ltsA=;
 b=kw++KZmIDPZkWpwqF2gsnn9xu8x3QP8An7PhDd4CR+wv5I+uC8WvEgzyYLTKOmxOZZ
 cRIoPJ6UcTB8Bv5wIidbkBlyKqU/zruF9qOKRt/+J9A9pxmtM1bwB6i3MlmjfaQQamjA
 TsWerP7ahcoE8IZLsD8r88eD4uwr9f/xuiUojzZQmX/c0PQKC1R/kOnwKlWDeuiXJ1Lq
 lr/aSfoXDQdMFe+tDt1xHBu9ZvSiutsbEmTG4kMe+J8SdHb320m02MNsKJuZq4d/1ukL
 QwhHHJEOUxeXtZwEY6IeOqyX/CjJGF6UG3Kxlu3oALF8NuI/zc7xflJ/CJCt0UQw9PIu
 LpzQ==
X-Gm-Message-State: AOJu0Yy17fOm7v3h7oRsGjTgfX/2ChcG8HH0Cb2yOm3KSIXaR36OjGTF
 TJ6v3/sXB2Fboz0616k2ZsmE1zxI9ZEuJIMtdmTcb2EpxMm93Sg0aQggJh3qk0M=
X-Gm-Gg: ASbGncscSbc87BGNI3f86vjjaitPPcYeVDDyBGBqvH5pbvMdwV55SgGN8Izr4O9ZP3d
 TIIPDVfMlbXzio1iIke2URc9IatyRrY/V5mwoyp3G8DOMwP0s0Zuf/5pHD/HQfGN1M/JvcbuOOk
 /aiE1aIub9t+XVvV4lnWkZ36PjYMb6SPoM5yKl1Q/bItGhAMs7LJpU+HwiFFmOzyX79+mqQka/l
 IrQFAg0tgHtX/e2XhYZ8y4nZqXr20w6T7bFiN8us2MI3uudrwRwoCo=
X-Google-Smtp-Source: AGHT+IE1zpEXn7HnexZkHIBenMuyo1Y5ptBd8phMZsxQSczT1drUGDh6ua8yULBrQ0oggC2f8/lJPw==
X-Received: by 2002:a17:907:980b:b0:ab3:61e1:9b06 with SMTP id
 a640c23a62f3a-ab38b0a2221mr308042566b.5.1737121381863; 
 Fri, 17 Jan 2025 05:43:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab39aa6a7besm38093266b.68.2025.01.17.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8797F6086B;
 Fri, 17 Jan 2025 13:42:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 07/37] semihosting/meson: Build config.o and console.o once
Date: Fri, 17 Jan 2025 13:42:26 +0000
Message-Id: <20250117134256.2079356-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

config.c and console.c don't use any target specific
headers anymore, move them from specific_ss[] to
system_ss[] so they are built once, but will also be
linked once, removing global symbol clash in a single
QEMU binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-6-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-8-alex.bennee@linaro.org>

diff --git a/semihosting/meson.build b/semihosting/meson.build
index 34933e5a19..86f5004bed 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -4,13 +4,16 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
 ))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
-  'config.c',
-  'console.c',
   'uaccess.c',
 ))
 
 common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_false: files('stubs-all.c'))
-system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_false: files('stubs-system.c'))
+system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_true: files(
+  'config.c',
+  'console.c',
+), if_false: files(
+  'stubs-system.c',
+))
 
 specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.39.5


