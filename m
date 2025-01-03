Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7E8E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlNq-0005wn-0j; Fri, 03 Jan 2025 12:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlNn-0005v3-00
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:22:47 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlNl-0001Mw-3d
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:22:46 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso89729305e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924961; x=1736529761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dNWNLD3TOQ90+HAs9bzy2nivedS6mvux2NVJyj5jEvk=;
 b=Lal+8eKPLC5pvUG3w6EWh5YmvI0B40TE1cAv7IWHIlnP20/AIW44AgBY9z6Zg9nSLV
 IgzFOm6cuOTlV8bms6zbNQYboT8/O2lSmlJqdfqlSTR7+581nbsdVUg5QqdVRXDbkw0S
 digCwE6QjkCdvx4zFMpFjNbD9BFFSJdq5kkXpYqJRBprM9SC3qLp/0Zi2+XizKPhWTvC
 mWU1d4RHSzGpohxztHw1q5MHt0L5d+FhGgS8TPvsS51Dl/beAc3gM6ixPCf87dnlbkzd
 MM3OcoSMVuOIRwjdqD4YVX714lFLreYT1wbpx/9GH6vma2wIod+dITfIyoA8THWEejIp
 7e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924961; x=1736529761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dNWNLD3TOQ90+HAs9bzy2nivedS6mvux2NVJyj5jEvk=;
 b=MJgHFsZc29tMra0WeIkI2c1r6j6PN9xS/1W2QZyo1Vx6hSk/65zOuiQ0DrGhOp6vyp
 8WZM2PQgctArBrToDQjEzVXkjZZQJ3o7UFpZmfcox+oLkHhx2rLSmLymXGeLbVbT5AjO
 xtM/+ryzW/ny31QActBezOMmdXjPlZCukQIfLfzbaA/KTny+s6DMM9DiFV+EQW3j01j0
 D/PiqwbT93J8b90gCSZUN470aYDHsa+AwPjWMU82YmcTW/nBTV6IeBgMARyqTNOBKy1F
 QlGLjNoOYu/QJreuCO1J2uz12BgT6s+9EiqZWx+OIlkAQlna0HfH9/+d0XIyTa6WZY10
 ri+g==
X-Gm-Message-State: AOJu0YzzrCD89XSHwMdWRdgJQEs/7hCuuXxpx0/uCrtbf0esveQMoAgq
 SXAT9YNLvLKtUO7CyymW51m43MGpEz+hy9pQk1hyD8S7bItXvwd9LS2GrDZ9s/hWMFNANtUD18b
 26Uw=
X-Gm-Gg: ASbGncsACUgQXebi+4rV+FtLQaQIz5y+aYF05iRfwllhJ1KDj3iQRl9MhI9BUOiuRLS
 pENfxZAOnVrtL4oZdfbEd9myxtKCZEhL8ZjJx8bhxt6lMdxPCjZxrmGlG/qYujrsQRz6HELqsGB
 bllHaKdyPbI8hcosHPEZP5qDBsQbT7b2G7ml/EIQeXbQl3j7RNRScFRNCG/7mm4HEZcuvZibrUS
 IjzRoaniP0qIOIn0TTdjXHcA5EsduRAP50jXRHVwa56Yarx7gbktZwG5kTVgYHNc2gryG/IgXvU
 Ez0nSV3Ga893pYanpKqIAnfeSsSmifY=
X-Google-Smtp-Source: AGHT+IE0Z3BqSonF42KMbdKuboPrqf6YDSMmLjVUEI1ruCWv7zgfIMX8W/6w5URpwO7RduJufUUyJQ==
X-Received: by 2002:a05:600c:350b:b0:434:f8e5:1bb with SMTP id
 5b1f17b1804b1-436686430a2mr451498585e9.12.1735924961214; 
 Fri, 03 Jan 2025 09:22:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008b1sm484965375e9.15.2025.01.03.09.22.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 09:22:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 0/4] tests/qtest: Update tests using PL011 UART
Date: Fri,  3 Jan 2025 18:22:35 +0100
Message-ID: <20250103172239.18562-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

(Series fully reviewed)

Since v6:
- Corrected ASM comment (Fabiano)

This series split a patch [*] which was previously posted
too compact in multiple trivial steps. The last patch
initializes the PL011 Control register, enabling the
UART and its transmit channel, before using it to send
the 'T' character in the boot-serial-test.

[*] https://lore.kernel.org/qemu-devel/20240719181041.49545-10-philmd@linaro.org/

Philippe Mathieu-Daudé (4):
  tests/qtest/boot-serial-test: Improve ASM comments of PL011 tests
  tests/qtest/boot-serial-test: Reduce for() loop in PL011 tests
  tests/qtest/boot-serial-test: Reorder pair of instructions in PL011
    test
  tests/qtest/boot-serial-test: Initialize PL011 Control register

 tests/qtest/boot-serial-test.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.47.1


