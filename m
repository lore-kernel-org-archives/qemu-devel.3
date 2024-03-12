Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9F3C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0GT-0002wW-6J; Tue, 12 Mar 2024 07:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GP-0002uF-AJ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:45 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GK-0000jH-8J
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:43 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33e672e10cfso2660343f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710242736; x=1710847536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=likgvKugk4b8t9l89CQl3BfsUjLIPBB3WZoVAljees8=;
 b=DW08WxMF+B9rMlbuk/1FXC8SRiNlybQcsMlufn10lYW1lD9iQUeCgSAKTLErF6+gWr
 VwZmpM3TOqE6EfOfEEUAU+JuMCsLmvjeTMJxrhPWKJEhpIeBi6+oH3L86jYI9A8+xGdL
 dXGlX6mMTNqJ9S0Ip5EBR2fLrBes68eaRZQO0i2yT1scSWS1O+NtgBfF4Lnuj4JbUWE+
 Oh9IjIJeXy+7TE1R74yamIk+pKLtSFzy1XuWw5V1xOTM223O1tD7us7FRvkBRzuzfpmx
 Q9OuOmcOO+iRXPx2zQveLRtWvl9XKjcQmwLAjGlxEbMZwTRGl46PGlo+ZUNFOE5laerB
 5MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710242736; x=1710847536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=likgvKugk4b8t9l89CQl3BfsUjLIPBB3WZoVAljees8=;
 b=OzxXLdZ27PU6f9w8kSPQlsAGE7fklbOdH8jJQ221bfH1Lndj8na+r9KEeVi2U4LIpp
 UICdOHvCbyW9EVT0SRidT3IFrjeK0XjLt9gqjsgjmuVGtbdFx3sw//j6AAnleIIW2t0w
 CeBOkqyP6UAlmPVTJPK8hCRHTLatQx6++SmevXhlGHSFtVAm2MZP3zJ1cu0Y00sDw9Zr
 MZ21cSENU0A56ZSQ4wU4kiZvYPe4hWgFpYwIbZcz0nb833N0kML+y1gox2ugZwSLIIqx
 KO6r2WEcatwkJLnfy+6xsh1XL+duSK4n6SuTFqGajYVxtgYmA1KGztrtV81pndqQSqXd
 DZ2g==
X-Gm-Message-State: AOJu0YyM8Fs7wCbmatjcKeA/YCgm14fb4rxGg5lW9qBx17UFYry1Y9OE
 gE23uMY/WLMDFJ/b9XJCTygz/S9j/hp5vU/rzRsaJWx98yf/WHolakWViesioW4=
X-Google-Smtp-Source: AGHT+IHPit1NXoSm5SCOXYpz5veD40FZDYcwT3cLMIan4pT5sEjVA4tmuOIU+pnxMj43WBmsYaYSTw==
X-Received: by 2002:adf:da4f:0:b0:33e:9113:a21d with SMTP id
 r15-20020adfda4f000000b0033e9113a21dmr4769899wrl.28.1710242736339; 
 Tue, 12 Mar 2024 04:25:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a22-20020a5d4576000000b0033e68338fbasm8766559wrc.81.2024.03.12.04.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:25:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C108F5F8D5;
 Tue, 12 Mar 2024 11:25:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 2/8] tests/vm: ensure we build everything by default
Date: Tue, 12 Mar 2024 11:25:26 +0000
Message-Id: <20240312112532.1558319-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312112532.1558319-1-alex.bennee@linaro.org>
References: <20240312112532.1558319-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The "check" target by itself is not enough to ensure we build the user
mode binaries. While we can't test them with check-tcg we can at least
include them in the build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index f8fd751eb1..4a1af04b9a 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -606,7 +606,7 @@ def get_default_jobs():
     parser.add_argument("--build-qemu",
                         help="build QEMU from source in guest")
     parser.add_argument("--build-target",
-                        help="QEMU build target", default="check")
+                        help="QEMU build target", default="all check")
     parser.add_argument("--build-path", default=None,
                         help="Path of build directory, "\
                         "for using build tree QEMU binary. ")
-- 
2.39.2


