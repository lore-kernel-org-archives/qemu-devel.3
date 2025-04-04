Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C63C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0pdo-0000iV-H6; Fri, 04 Apr 2025 18:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdW-0000gN-Op
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdT-0007xw-Es
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso14039165e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743806135; x=1744410935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rq6ukSPz6i3qBiz15byBnMynpVR9qpwTm75W75QCRYE=;
 b=EW10laci9slrRsXuCmaiaE2apnM5TjP/bRpx6oknJp3mqRS3EVeChLYWSJl4bCpNyv
 5Z+y5JfWeFci77yylU8gqcXhHzaU86lIKDiB9GEEiukT/QElp+nwKzHxC6lZKB6DmeOo
 mwiqkmf6vYLN9XiQzp3I0H16Ok9/XiUI2l5HchdQlnjuIe73N8/ex6ZKFniWzkUqCLds
 wDe5VUBGhVHzL738E5ng9jy35cOL0tb3CnNDNmuYaxga0DUPCGI3Va67mbiWf/hAmJnD
 XG4QzTBcOV7TgmuE4HUfJ/nnD3S3wbpifpZypOJKfZDIflx94gH8ZuZcHtMm5ScP3WoF
 e+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743806135; x=1744410935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rq6ukSPz6i3qBiz15byBnMynpVR9qpwTm75W75QCRYE=;
 b=Z5mDgtV6Dc1l97NmuhXVH8p3L1ll32eJ5w0SPHZHc/g++EjQHWk2hlCC83no+oNESk
 8yP0sDpYqnturh/PfFZna9D8kd9PB2K0rpB/fKkfSTxRdXPgVABsOt6cyMy9V0hHenT8
 fWVh3F39RlHNC/gm2n+rLUh3/7nUIHzI1EgC5q3SjKVYYh8+nZXQ8spZwKESgAmCCXNG
 W3/RVdIaF4DVKRB6zPMs3LlON2/XbsTkYV2Gl5uvyEXehXeFuVJtog/jEnRcAgLqBa8J
 Zl8XFLM6kR1InYHbhZ0WmOEaVofAvc1yfJo10g5JFXYwMVWhoUCGxCU72gUN/A7MRKtw
 fngA==
X-Gm-Message-State: AOJu0Ywe7kKsBO5X7O3yNikRF+/Dyqig51HSS4BnKfljyYE0Au8em7+A
 6v/u5yBhVK189IJcmkMwPyev1TUm5qZdYdH1ky7B4a61VzY9KrF7wDKASWlthFkcpQjLK+yERP+
 M
X-Gm-Gg: ASbGncsSa8zDNQt5qF5gwYC8CvkAUIV6mCCCi8woOlwjQZuetI2ptSPZP6Te8G1HKQx
 jYiuug2ZuPclHiRrci5XCJ52wTPDpLG0EePSO5PsNDBpTlkXuSHiPd8XcL39XGJPGJ0DKMlh3sM
 u8r4MIHTMC68eVDmMp8bq8vdkVvq+CENGJR6GzOyGPAphcRReQqjgz9IinbWqBNNNJ3qaO/Wmhp
 4ulF7wIOGBrbcc32hzcnxwtC+b/7JRoRxllWuB5d5O2x+MHYFlYzEAxI6nBTJ6NGBCL10Gbsm85
 j/INabNx9P+AAt2UIxf9Mae1HIiNMLpI8qLe6JoCqVAifoUYpYT+Cm0uIg9gFFVryYiPWa6tY1E
 4xn1FP/nnZq2YOeSdPIdS6sAf
X-Google-Smtp-Source: AGHT+IEMSL61JPkT0XeVJ40GVionwl/pYjYgi7F0pD9PxlljrW0JC+Cjy++q3jco8uIlJSEnpFn+Qg==
X-Received: by 2002:a05:600c:a013:b0:43c:f8fc:f686 with SMTP id
 5b1f17b1804b1-43ee0616fedmr13051525e9.3.1743806134772; 
 Fri, 04 Apr 2025 15:35:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16ba978sm60231765e9.23.2025.04.04.15.35.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 15:35:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 2/9] target/arm: Remove use of TARGET_AARCH64 in
 dump.c
Date: Sat,  5 Apr 2025 00:35:14 +0200
Message-ID: <20250404223521.38781-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404223521.38781-1-philmd@linaro.org>
References: <20250404223521.38781-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

It is safe to remove TARGET_AARCH64 #ifdef'ry for code
guarded by runtime check on aa64_sve ISA feature, which
is only available for Aarch64 CPUs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 377791c84dd..95afa9b72f1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1213,8 +1213,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-#ifdef TARGET_AARCH64
-
 static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1372,15 +1370,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-#else
-
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    g_assert_not_reached();
-}
-
-#endif
-
 static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.47.1


