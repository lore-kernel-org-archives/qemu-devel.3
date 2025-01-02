Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57F6E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIuf-0005GJ-Su; Thu, 02 Jan 2025 05:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTIuc-0005FP-Sp
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:58:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTIub-0000Nl-Eq
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:58:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso80599445e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735815523; x=1736420323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcekA88L/Z07G4gBsT6y7wvrNxItM6wYEmpLelolWes=;
 b=qusRj6B6J974BDnTFDBajgENunRe0dBkOf+Gx3iVaSX1IDFPlEPpGNr7zf8AVyssJx
 BQPKa1rb7tTi/M5BMO2vXSyZD7PLDCcv+DVi2ViW9MTjp58NPXZwl/iIPZA5J9br9uNW
 niAhBA9L339CPLrIW0lVjz16bZXCNhGXSWNaUsJ/L7y84sYKkgnwXlFtfkcDpb1Z8oww
 4KKiI7EloWCOyrhdQWj5S6dEt3chgbwAmkGvI9B43Z92uVrYFB6M1McKcxZHS/taCn2e
 J03vIaqtXhyg1DOk4FpsxQ5ZTta8LixO0kmaBlNpTprYWGbd4P2kcjOVlsnzLuZqJf8X
 KRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735815523; x=1736420323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcekA88L/Z07G4gBsT6y7wvrNxItM6wYEmpLelolWes=;
 b=otsnGxxpnu6IwUB8+GMap0UA6+MR8RZhYQ0qSsJ7a2bNJlOh2/B1UJpmiJYLGyY3t3
 1Ne0xPefIeOcJA4zFjG99OGWbGBtIFyiarM1xykcsGGT/mSJB7yvOLin4MKn4y1386vP
 PksAm2tEMmh64MQ6yok/3kzwfE+6lzJ2miJRyz6LQNKGgt1iowrb0O8Gcns0HgRms7Zr
 B/FhrdWQdMzVIT7M3nXitFMcesFIe71xVwSepTBfZQDET61UJeQ1CPpQFYrV7mksHmHw
 +bcz9tB5pweLHyOs91xqseMgMmgTOHG8LDg3SWfu43W9W27Ke3PoEX9aCeynZKAoU+SC
 uFsg==
X-Gm-Message-State: AOJu0YwJ8xrzLmzWfLqf12icFIESmTB6RW73E54QEg3kenEc8nBiuNsP
 ZIjG9Fi+fE3IWWDEGLQEx6scrllcyZalV+ue+81LTw+Lp0j40lXhk/vv8/ndVnjddhiBEwcH2xY
 EzqT3xQ==
X-Gm-Gg: ASbGncvyiAahBmPLNKNpteu4lkGsQafnax9p9OGa+fGVYNgTEwRYzOu8aqg2lYjE9a5
 Vyu88ZAeJtM/8OSEEqVRjHk3NwfSd6n7i+PKMPrOsKgX+eqLoQ47jIdWSLTSopu8u3abNC8/pGi
 wWbbNzAnRcH68wMWExqTrhnRk4I8FEuwIeV4G9Yr6oRmlmE+RcZI1s0u0qFrtNUFG5K1NxZC86N
 PYd0V+VdGj5HT9xOVG8Ez3K3ynIfqP0FPNEmpV67K9CpBXPkfbxixVPCbPqIbEWVHmpOxe5ADbJ
 8fb73ntlzmsEMqnT1Ygh6JKShjEmP46+yRbuUBmg2YzTtg==
X-Google-Smtp-Source: AGHT+IHuKZiTDqfvdgRrkNIzVHKJDvTLXwGdy3KrAjQmf1boaZkc7xDtRhRd53OuYnJUXXBsdIhdSA==
X-Received: by 2002:a05:600c:350b:b0:434:f8e5:1bb with SMTP id
 5b1f17b1804b1-436686430a2mr404478675e9.12.1735815523632; 
 Thu, 02 Jan 2025 02:58:43 -0800 (PST)
Received: from localhost.localdomain
 (161.red-88-29-191.dynamicip.rima-tde.net. [88.29.191.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea487sm446530485e9.8.2025.01.02.02.58.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 02:58:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 3/4] tests/qtest/boot-serial-test: Reorder pair of
 instructions in PL011 test
Date: Thu,  2 Jan 2025 11:58:21 +0100
Message-ID: <20250102105822.43532-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102105822.43532-1-philmd@linaro.org>
References: <20250102105822.43532-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

In the next commit we are going to use a different value
for the $w1 register, maintaining the same $x2 value. In
order to keep the next commit trivial to review, set $x2
before $w1.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/boot-serial-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 553575ca75c..bcfa504826c 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -78,8 +78,8 @@ static const uint8_t bios_raspi2[] = {
 };
 
 static const uint8_t kernel_aarch64[] = {
-    0x81, 0x0a, 0x80, 0x52,                 /*        mov    w1, #'T' */
     0x02, 0x20, 0xa1, 0xd2,                 /*        mov    x2, #0x9000000  Load UART0 */
+    0x81, 0x0a, 0x80, 0x52,                 /*        mov    w1, #'T' */
     0x41, 0x00, 0x00, 0x39,                 /* loop:  strb   w1, [x2]        *TXDAT = 'T' */
     0xff, 0xff, 0xff, 0x17,                 /*        b      -4              (loop) */
 };
-- 
2.47.1


