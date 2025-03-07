Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7EDC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIS-00010X-JC; Fri, 07 Mar 2025 10:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIQ-0000z5-2h
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:30 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIN-0008I4-IC
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:29 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso1088696f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360046; x=1741964846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l5tIzE5Flt/Mk2PuwQMT4yx2y90XXlNLNl3RYwyZsjU=;
 b=NyynZ3z4WCM1BU2nlh4qOFFCUmQSPS34HDprI1rTyJdwdqedqM5ZqnJ35CKeCpT6Pq
 oSafWweRJM65d/i28XK6M5/B2Ere1fCSyWyLiBET5CahxK6W1OOFAkKD0xZyNKS54AXn
 ePd7QExFRPp4cbXvcZdP4wN9T5bS6MZOlhskYHR/g2Dr0gAba6BktEWoJaqCbfOIBk4m
 P7nD89fmwtXNeSJUX3NXhZZqvc1UgK5i2sF3qHvR2zMfRHKbGxTdijH+dSWx1Lti7NNf
 ZFQbO1MX5uuyYIk1EOErEqf9Eo1wrCiH0OaMy7zYLJ1kLu8np5b8iyukmAp5pfp7RRq0
 OwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360046; x=1741964846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5tIzE5Flt/Mk2PuwQMT4yx2y90XXlNLNl3RYwyZsjU=;
 b=M/0FeZsVCJD3qGRbmvkz3WB8qpWLXlWPznoqWytyRXc8E7wAElqNA2KMXRCOdyJcNh
 RpXfvF9QucfbwBi14z7loOngodNnedLxZoqO86xW1oyKPVqletxpfE7ZqagBmfzcLCvS
 tNrJtYLVQUNSApu4JucteCSVp9Yr5Hf1OtoWOsZfFtRmCYv4f2uUUEen+rlAfdT8KznP
 HW+8RFusCmpOkdm7at0sKmHBkr/pufERinTx93ntqyr6LtcJKcKxHHwcrf858JwmAubZ
 x9udgaPPk8aAfJb0271MkS2gtSFi946t5cTpVNpgWV7ojzmxv1P08G1dJ0FKOwrSvjGo
 yDFg==
X-Gm-Message-State: AOJu0YwVhE1oe6ImlbTSEkQ3t7IOcSutqDfi4jKXCpMQt1wbsbNysaTZ
 xDBVWOvwsVOrMMWiNpmjRlv5ubvwWb0OP9BfTdybXfODEooZyt+u1v7mASP/RnlOGtpIviQRCLT
 9
X-Gm-Gg: ASbGnctoGpBL543teZNddp4h6YITFesVamKZ5nPV7ahZkWXIJk0q27Ggq66RV88f/Mb
 DcnKwcmuWIWf8TzMY70Ovie3KhPSWspMfn4/5n+jQD2UuFIbRz9XicF1w6ED+QuRzqTmSBug7mP
 7qh1Anv6MLLsXoSrDQsPgu8KrPqydBpaQjNgJX76oJ8eCLMGGAaNa7RCYuEg8robES3E3OF3wtr
 gTxOTBdhklb3msEEq4g65QjgxFgTI5O0K0y6e85zeBUxGQzjSXjra8STs+UQzfZ2S7gqqL8iuxd
 Q4m4PoBWzfh6nvDwKfozsRtk13t8f6dkAukZ82y9g9u48zJBid8=
X-Google-Smtp-Source: AGHT+IEoCN1E5wB3mFTgdNKvBRStr8cVfW0gQuLJ9vJuyKPlTMlDpW59B2AFZ7V9TbBFe2rJcrXwfQ==
X-Received: by 2002:a5d:64c3:0:b0:391:ccf:2d1b with SMTP id
 ffacd0b85a97d-39132db1454mr2479087f8f.49.1741360045811; 
 Fri, 07 Mar 2025 07:07:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/21] hw/arm: enable secure EL2 timers for sbsa machine
Date: Fri,  7 Mar 2025 15:06:59 +0000
Message-ID: <20250307150708.3222813-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250204125009.2281315-10-peter.maydell@linaro.org
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e720de30641..aa09d7a0917 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -484,6 +484,8 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
             [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+            [GTIMER_S_EL2_PHYS] = ARCH_TIMER_S_EL2_IRQ,
+            [GTIMER_S_EL2_VIRT] = ARCH_TIMER_S_EL2_VIRT_IRQ,
         };
 
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
-- 
2.43.0


