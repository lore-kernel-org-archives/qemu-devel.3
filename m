Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB28EC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPktv-0005dH-KO; Fri, 05 Jul 2024 11:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkts-0005bs-71
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:04 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktp-0000Nb-RJ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:03 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57cd26347d3so2426452a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193459; x=1720798259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xv12aEHcacHy909xjN8SHkQelk6UZTRk75aOEyUvjoM=;
 b=w+dG1OpSGb+cNSmjPl20J3Nj95hNAbuTUE9QlFAmmHh2mgHm0Gwd5j/MTXEsGsKkYT
 /OdOFaOQfDufFYTXX7/DK1QM7OBVGcj8M/TazCTPJgyZS33+2a2gv3hWlzIlLQRtt79Z
 sXvUbdrLsPKKQCzofexVoHHyYakNThhcH7BVPG1HbDQn+/ItAe4DYy/5f1o5cM/eoBKB
 Q8qhuBqHJCYm2JArLKNdw5Hwdir1rzIUFY+l/Ft4HXEcZK/mJMJ0XiJugSBQRLGSkkOw
 cLEY0yjITDQOjCHPEkoTwxXPNR1BGHxCU6UDnBiFD5Wo6Jf2Z4veUtzgJtIl10tTGaNA
 nLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193459; x=1720798259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xv12aEHcacHy909xjN8SHkQelk6UZTRk75aOEyUvjoM=;
 b=pFhz0yynPjjid1/LPrmb/C+7ucXWzT5Y/My1R4gh/KoqeQaLimtwYXca4Ue/Kcmldl
 /L2OzOtYooFZJmfPOPu1SbzvsmS7l7Fyz1gEADCyf/ftgpd+J0E48hikmLgynY0yJU8F
 gLR8Ik0vHJ/M6wzFVs9v2wLoPbUa41rq0vrHRdK1lI8sIWtH5lqN0z7y5frw7+hHs2j1
 VVSkWquTTFaTgoPMR8MB3Cg5pKF/RN5POTA+eqeS/DVGOVsnsAEbS9QHm0RTMPJ5oIzX
 HvG1Nu90AdjGCjWImVHySC6+XQN5JzGNqzJNJGo3xPkBWHR4eCHVUP1f3PS4opVz3B1j
 XvSQ==
X-Gm-Message-State: AOJu0Yy8TAG+t+BEyfT2Q2eNhnCQuet3Q1RCpx7PrrfKoZ/FLLfr9O/6
 GedDt21uVrwZtYJWmj2nZtOkHutHdoT+V3dy4D0D/G6Q7/F6NcSdRSOclVCVKy1XGPye6+HHoko
 w
X-Google-Smtp-Source: AGHT+IFftEiOeAs1X03sFlaC9xR6z0gKqXmYs/z12ouezfcitktjOje10O0Gwb4jBt2dvLrwqP+cdQ==
X-Received: by 2002:a05:6402:1cc1:b0:58b:4621:e866 with SMTP id
 4fb4d7f45d1cf-58e5cd12b99mr2738756a12.41.1720193458578; 
 Fri, 05 Jul 2024 08:30:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58ad8730dcfsm5495220a12.7.2024.07.05.08.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 909875F93A;
 Fri,  5 Jul 2024 16:30:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/40] tests/tcg/minilib: Constify digits in print_num
Date: Fri,  5 Jul 2024 16:30:18 +0100
Message-Id: <20240705153052.1219696-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This avoids a memcpy to the stack when compiled with clang.
Since we don't enable optimization, nor provide memcpy,
this results in an undefined symbol error at link time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-2-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-7-alex.bennee@linaro.org>

diff --git a/tests/tcg/minilib/printf.c b/tests/tcg/minilib/printf.c
index 10472b4f58..fb0189c2bb 100644
--- a/tests/tcg/minilib/printf.c
+++ b/tests/tcg/minilib/printf.c
@@ -27,7 +27,7 @@ static void print_str(char *s)
 
 static void print_num(unsigned long long value, int base)
 {
-    char digits[] = "0123456789abcdef";
+    static const char digits[] = "0123456789abcdef";
     char buf[32];
     int i = sizeof(buf) - 2, j;
 
-- 
2.39.2


