Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8E7CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcwm-0002uC-0W; Tue, 28 Oct 2025 02:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcwj-0002sm-VV
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:12:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcwi-0006jA-3c
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:12:41 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso3203057f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631958; x=1762236758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rS/0cEG8zGv/ErrZdKLPdjhw1ubEPoYKy6MJUJ+uZjY=;
 b=cdXIQ1wYV2Cvm1njocpgEX9QSbN+8vmV+m/V5nZA/sVnrrIV8975JATlQd6o9gfjpa
 zmZ8x43SBW7+sOGhtWHF/UQVCXNeznsOyUNUo9GOJ/+3RUfdf0nc/n69U5/QrEkc+/1P
 NAEtrqmbBLJS3ifGRgw1izEykWKzgk+deH09DNqE6+rPTSAHzslw8LXihgjnyEAFnH6H
 Qyz516Evgih4ONJnNQtUMPOS+Fw8FfBXbr/kOP3Zs94a1Vl2pk+L4XZW4L0vew8Y2AXm
 E81McVYM3sDJrZh8nXsB4BKOX4bttaJt8KpLlqgtwsxaRjifnqcOtihzvUFPdYvTfjK9
 q4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631958; x=1762236758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rS/0cEG8zGv/ErrZdKLPdjhw1ubEPoYKy6MJUJ+uZjY=;
 b=WRjRhqnZJnhM78eOqEG6zOoJOe1faIkVD9hrzhp6LNgdbfauzNCoRY09Rt56YHXU1H
 M3gUA6Lv2TWJXUV5qb+ypho2KaJOliQpmTfmG4G48JKKdbmelhdZSdb3XOr9vJ6HpS01
 /mFdaWREbTU7bGTQOOlDm4EvGrp/4LjVh5a8d0ONRjl74u0a0lqdHyR859cGVnSymQ0o
 JBFtdQPp9GGmTFH2j+dvZmU3ZHZC4FdUDmGWsaGyV8LzUcx7xVMfe3gufwp2FfYCVdby
 0rWpvFpvpPylo6Cb4dePLh8h5e/2Qyy3ufVSIoVNop4YqYzGQfOenk6a3nyNPj+yYMDu
 uABQ==
X-Gm-Message-State: AOJu0Yw1/ON2bkaGAMpS7Hu5zhpgNceCsW8stiM/zwjBCoARrZtH3gol
 i62D82Qf1weGJvI6q2LkuXWERQOKdGvamaTvAqje4wPnReJewtdQxlts3+27pl/QP00czwwGZ/u
 D+ZTfyf8=
X-Gm-Gg: ASbGncttg24DIHINoVyRRtJ5c9zUI3jdFB6ek7hLE8TMNIYJTJoPkgqB7aYlVYR1mrP
 Kkqw+MYUeIfQsyCtWTWD8XOpgLOKWaI6oLEmUj2vA7piscEs0rOvvWTY6l1l9h5uFOmDxGDd/K7
 hOEPYrXjoog4MPiHdU3ltk6nK5NR0AVAtZqhffujjxdzVh5oIdCx88EFpqtDrJWU09jY98ivNS7
 d4envRqsyvwyiRWzy66GoY+U8WR934pDT9LdG/SYOQOMkelOPNIy6E2tdJ+Rlmo4iYLIGQzn3nJ
 5Uk5ZQcrio53Y6VH73dnU/2f2LvJNBSjqz4z68ZPqXiG3BgrGvA5XH5mzpBjCSDSuMBH6ZJAsKv
 S4qPsYLOgC1yuKssZ7753WM5pgBtlLjVceJ7rdXNXLQ7l0hRePgssH9rsJrfhcRFYF/y1bEuKT5
 0UDK3GhT7PInRwSpoH13/J75vEV6yRFYpbuTAVLXyudUy5KXqBTeoA2hI=
X-Google-Smtp-Source: AGHT+IGt+o0q20+/Ua5ohB99OZ+yA4Shz9NLkIv10R2A0bast3mbUlcuctXhX31HLYOnJwVrl9+abg==
X-Received: by 2002:a5d:5f87:0:b0:427:665:e373 with SMTP id
 ffacd0b85a97d-429a7e9df7bmr1810027f8f.63.1761631957746; 
 Mon, 27 Oct 2025 23:12:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df62dsm19852899f8f.45.2025.10.27.23.12.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:12:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 42/59] accel/hvf: Skip WFI if CPU has work to do
Date: Tue, 28 Oct 2025 06:42:18 +0100
Message-ID: <20251028054238.14949-43-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Avoid sleeping vCPU thread for any pending work, not just IRQs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index da2f4cf2e9c..1abb4a7d7a9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1737,8 +1737,11 @@ static void hvf_wfi(CPUState *cpu)
     uint64_t nanos;
     uint32_t cntfrq;
 
-    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ)) {
-        /* Interrupt pending, no need to wait */
+    if (cpu_has_work(cpu)) {
+        /*
+         * Don't bother to go into our "low power state" if
+         * we would just wake up immediately.
+         */
         return;
     }
 
-- 
2.51.0


