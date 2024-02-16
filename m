Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E52CC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw0t-0006p3-Bt; Fri, 16 Feb 2024 06:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0o-0006hA-57
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:10 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0i-0000z3-14
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:06 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-411d231ea71so14663285e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081441; x=1708686241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4cWnhsBShzzzFHqb9EuQ4ogMglB6l+e/nMze0glgi0=;
 b=loa2CLhH2eVGucz+5u/ZHrF/tVm3Kb1XtkZaChSqNZYVLfUMD0wrsLSiUCIX1v+ZZ2
 jnXz5aRtVP6cTU3+P5FB0lxpBp84TcD4B/ZpIHLL0UwDR370wc10Ayzy/MMmX50KDTzZ
 z/Xk/1TgaS3HGA1tZzbOYyJ5yMj5iqUmsvFOtz/mMibvVNmyGoDg6pE7J3ywZfZoyJM+
 rP5QIqhDB64AJm+QA0C/hkCE5WkVITAfkMzFpGjp46DbKKpYv+z9A4zHOKszin2d1q8w
 vxNA667jv1R8UcE5ccNyourlTN6BHYxI41xFsKfuTAlNPqFyqEWYIVrJQHdFX1xTtkID
 EDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081441; x=1708686241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4cWnhsBShzzzFHqb9EuQ4ogMglB6l+e/nMze0glgi0=;
 b=n6Ra7KPfjdWCSeLc8zqX07pITiqtJjuBClbelXjOXHtatzyy9cpS99/Tu0B0cphHSR
 1EuX8u4rm9I6whvRPG0QDs9aqMFX77sVMcjGyvmpqaFRT7qABWDaN4oPLDIE9/dAKlu4
 Q1ebiNDhmOZ7JszZCp556hoOg5kQUHMAsnvulOhV8Ui7uyPCC+RtbfZSzVs3D30OFSjw
 KNnRxmJ30w0HLS0/NLzDDaFVluPZZpMPY6IpIT6ceoKkWhBzYaTOfYuQsDcQdhDQkQRU
 6CmxiGErBA5iBh8jtH6+D6Fj4cKFbGMpFvXBMa9VaeZi5miHjucGoFiH+6P0wqA75kDg
 +2wA==
X-Gm-Message-State: AOJu0YxDDg/XgyxyF4antVqefTlGQ+Lv0P+6ZRTEGp++iwUJjr2UhAHJ
 XqgaBHbmFp5IBOcfQst/ARoKOmb/l9yRrkZlQITIV548fZRnpbNo6cjcTOhsqD1eS9T0hkwK7jU
 q
X-Google-Smtp-Source: AGHT+IFJ0tgORZjuv+Xo1BE69NDOJYJ5Z6N8Ug5++1Pn0E/2AFdYFRNsQvRUPzDxGqWA0u8rp4Hd/Q==
X-Received: by 2002:a5d:6143:0:b0:33d:2437:e739 with SMTP id
 y3-20020a5d6143000000b0033d2437e739mr252251wrt.54.1708081441727; 
 Fri, 16 Feb 2024 03:04:01 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 x11-20020adff64b000000b0033d157bb26esm1880818wrp.32.2024.02.16.03.03.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:04:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 07/21] target: Replace DEVICE(object_new) -> qdev_new()
Date: Fri, 16 Feb 2024 12:02:58 +0100
Message-ID: <20240216110313.17039-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Prefer QDev API for QDev objects, avoid the underlying QOM layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.c   | 2 +-
 target/xtensa/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d644adbc77..6b3909ee08 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -649,7 +649,7 @@ MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
 {
     DeviceState *cpu;
 
-    cpu = DEVICE(object_new(cpu_type));
+    cpu = qdev_new(cpu_type);
     qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
     qdev_realize(cpu, NULL, &error_abort);
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 79f91819df..4f9408e1a0 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -205,7 +205,7 @@ XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
 {
     DeviceState *cpu;
 
-    cpu = DEVICE(object_new(cpu_type));
+    cpu = qdev_new(cpu_type);
     qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
     qdev_realize(cpu, NULL, &error_abort);
 
-- 
2.41.0


