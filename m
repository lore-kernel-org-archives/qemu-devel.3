Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4026C021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI1e-0001Xp-UM; Wed, 26 Feb 2025 09:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI12-00016v-PD
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:01 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI10-0005jv-68
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:00 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso69757115e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578637; x=1741183437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThH5BQgbHAmOS+UQy2wCG4a6AKm/DC+QNI57Vzuv2mA=;
 b=vcn7x9R7CFOC1/nGW0tBaRzt5Ic16agommM6MpU4orZ38uJkXhfWGFm1u7yl7vL+d8
 M6nh7mddfG+s+UGEMTqO9qBQhlRmH7VPodkPOoY9mejBX0hAe5e0f8okor9TaeU10/8f
 i5ElWUPxZcvj02zKbLq6J2PlUNtUodyIoosfyfmy9HQnfEiu4IubkAyQm3kaGNklzdlb
 zC0+stQCcCey8QXn8RwzbxdJH4+Qf/ntqyiDZLKBI/Kn5zmk3t3JhzuG+OouB1pgqyqQ
 yGHDdh4nQ2wR0I5qrpsFv5YEXwvzT1ZPEapzxLfB/W6YOTA5DeWkwACCrUlMnw8FEYCb
 z78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578637; x=1741183437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThH5BQgbHAmOS+UQy2wCG4a6AKm/DC+QNI57Vzuv2mA=;
 b=bOlZW8VM2iqh1obBlbG3obQ9OSzp2R30UQKgmIt1vZPfMY/Dgpk+sR2HopJtgBUFDk
 HhCIjMx23ldJAIrhl2feuPTlkJHocoGMIC3W4DJ6WlPf8AUsyI0fS6QY458Y5ltPFn4N
 GNC1WDJsUqsmetBHHjsLpzP73ZpvQc4aNv0Q2xtzP032wACrnxpL35EA0vAwm7I3DTCY
 3X/OKzSIMzEdV/cmpcM0esGrSXsmu2K2LnyKGmwm+5BHjb09o1gbO6F7KNCVfAuKIMbH
 nI+0W66Lxusy08gn24qlx5snWzHR/UvXDpEI4fF3VOvu1zaKtSguAwDgmmdsHKrvhC3W
 n11A==
X-Gm-Message-State: AOJu0Yy3iPdKvIgDgFGTMkBoKfdxzAQE+bzoz2hxbs973qG4WjK6UiT+
 PV4YLfjAtxicnrPTTO9sqbxmNbUnq1wD9HrQUNtE/h7M2zOkTr7567XodRzF+r0=
X-Gm-Gg: ASbGnctT9YFrns4mfl12CfDESXI8bchv3yea9g/V4jrS4qRQv93jRuFscdsoxfL62GW
 ShSrhHqr7I8CJW2JjRmGj0q7xfe2L7l1duK/m2xYDKfNtbcEbmX1WaJXhNkLa2hC+94ZZ+EETh3
 m2xVWcQSGuAQHn2GiQJhrHgCT4XL25I/VuHSPSm6KQRVZMyxj2olMNncSzYflhAnng1KBmoFlX6
 Ptoug8rzl5rNd5g4c8pi571pBdTsk2b6B6uvp2/eEcsArH6u7BNT9B8wzec+wAz80KAAtAZLw01
 pjdPwXaZ2zNmeKmGB/dD6GM8Ox4g
X-Google-Smtp-Source: AGHT+IFFNlhkw3kzVazdTaS3EZM4YWxJWGMoAB/2aOLRU0VRtSXmkLsvO3HWriiFXTOsZ1qMWEqvOQ==
X-Received: by 2002:a05:600c:3d19:b0:43a:b186:8abc with SMTP id
 5b1f17b1804b1-43ab1868ac3mr73031805e9.2.1740578636516; 
 Wed, 26 Feb 2025 06:03:56 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba57145esm22493425e9.30.2025.02.26.06.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 38416603F4;
 Wed, 26 Feb 2025 14:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 13/25] tests/tcg: fix constraints in test-i386-adcox
Date: Wed, 26 Feb 2025 14:03:31 +0000
Message-Id: <20250226140343.3907080-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Clang complains:

  clang -O2 -m64 -mcx16 /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c -o test-i386-adcox -static
  /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:32:26: error: invalid input constraint '0' in asm
          : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
                           ^
  /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:57:26: error: invalid input constraint '0' in asm
          : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
                           ^
  2 errors generated.

Pointing out a numbered input constraint can't point to a read/write
output [1]. Convert to a read-only input constraint to allow this.

[1] https://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20101101/036036.html

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/tcg/i386/test-i386-adcox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/i386/test-i386-adcox.c b/tests/tcg/i386/test-i386-adcox.c
index 16169efff8..b56dbc00f2 100644
--- a/tests/tcg/i386/test-i386-adcox.c
+++ b/tests/tcg/i386/test-i386-adcox.c
@@ -28,7 +28,7 @@ void test_adox_adcx(uint32_t in_c, uint32_t in_o, REG adcx_operand, REG adox_ope
         "adox %3, %2;"
         "adcx %3, %1;"
         "pushf; pop %0"
-        : "+r" (flags), "+r" (out_adcx), "+r" (out_adox)
+        : "=r"(flags), "=r"(out_adcx), "=r"(out_adox)
         : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
 
     assert(out_adcx == in_c + adcx_operand - 1);
@@ -53,7 +53,7 @@ void test_adcx_adox(uint32_t in_c, uint32_t in_o, REG adcx_operand, REG adox_ope
         "adcx %3, %1;"
         "adox %3, %2;"
         "pushf; pop %0"
-        : "+r" (flags), "+r" (out_adcx), "+r" (out_adox)
+        : "=r"(flags), "=r"(out_adcx), "=r"(out_adox)
         : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
 
     assert(out_adcx == in_c + adcx_operand - 1);
-- 
2.39.5


