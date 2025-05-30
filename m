Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B8EC5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBd-00021t-Fu; Fri, 30 May 2025 08:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBX-00020V-9K
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBS-0001cv-Nq
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so21592355e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609401; x=1749214201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=76US8ZNo4guZn7iQ4NXyIXoYHD/B5ALXS2oPgYy7SVQ=;
 b=mj0WDmu7E2bbi7lXTkn/tGHyC/7j2uUw7McXgvgCcVjv8iawvadgPIcDt7rJA7DL1y
 ohYceNVmFRl44pjgeUOhpNIhXDniBbCfdbQoRxOWgKWGJM8YjHvwzSN4vByhF7feuU4Q
 3TCc0jGR3fDdDb9wOPmT6bj3RVu+ND7aAoGhBUHYfATIpolhgwKS2E0mnuolm0u6Q60q
 Mt3bMWJrub+CgjoV56AzK/It6U5YzdyO8uZmz5gerG8j6y/OdoEYS7uCSMkzctzbW9ST
 SkcEhfd6kqiELRtdXm30UWKp5wXqnXV76sPGzVFVn3GM0yL/8BjoNcmp8MwVjAPWy+oU
 9zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609401; x=1749214201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76US8ZNo4guZn7iQ4NXyIXoYHD/B5ALXS2oPgYy7SVQ=;
 b=i0R1Tr7a8Ik2q7+Gs8vAhwVnBZobi8x/MzVZ+tFJrctmXlunqsggi3mHfPE+JXwvQL
 B5nQBcieKFG3jMItGRfE7SzOvIBVY6tIb8d54bau7wztHSj2iHR8OBjHirIr8Xz0Cjvv
 lmjqUZHWZHxSnfUSlr6yXIEBiyHDf/Ycl3NsUnZxT8jLDh3K1fT19t4yPwbfvYg6piD6
 YdgEwH2h0xDH91HXw+YcAeSLgLcxNQqz0xJeGTg9/P639VgdDycHCa7eQZVzy7UgE+TR
 6FPZS7Y4okGTs8z8BlOUGQH+eCHt1mjWXyY12hjnEul60WR97aOnuUB2mcbylJCiSpey
 TwnA==
X-Gm-Message-State: AOJu0YyTBO2SodYSAY+FZv4LdE3aclRupWHuL8pfQZ5PQC9CyTYV7rjW
 X2DQI8KsRaADeUsf5xq6QeUT+2g45kT4Zh4bd6THLzkWnnBA7XDwlW5rKDGWNezyEJqdaShvssj
 X161f
X-Gm-Gg: ASbGncvy30Hp1zSAmzHJMGtunLf7A37pyOSfYS4T6OkxtWuWaAN9uYbUKst9iiXPDVq
 hzxOWBnnePx2JbbBYAlBN+eoEC2nCoFTRNdbjwA5vSbYEg1lfZbDk8qydzN9wnpS7zxAptnQDoF
 Uk0GnJgOiOKllGBAtBBGL0yq8FuDDRc7iPlYyVmA5+H6i8GAbuDnaxMouZezMwR+AoHPJW02l8E
 VhXPRT8RJfmO/1oobR2uiozjYrzJ5X4AwVuRGxLcoHPud+8/AauW6adWNOOuL5B47iD4EwKFtLq
 Ci1gLGyjZ7ROOOdBrKb8jqtL1U/G52A7Ux9EO4EHMsKdvTpLG3gJwn1muw==
X-Google-Smtp-Source: AGHT+IF6xkCKO/das6Uvo9JC/rPj0Vk3e7ShKez74/LkOMGiPSq+KB7n0/j7Yf2WNeeIz7+kvB56LQ==
X-Received: by 2002:a05:600c:348c:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-450d654b5bemr29079615e9.19.1748609401100; 
 Fri, 30 May 2025 05:50:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.49.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:49:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/15] hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info
Date: Fri, 30 May 2025 13:49:40 +0100
Message-ID: <20250530124953.383687-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

Without psci_conduit, the Linux kernel crashes almost immediately.

    psci: probing for conduit method from DT.
    Internal error: Oops - Undefined instruction: 0000000002000000 [#1] PREEMPT SMP

Fixes: ae0c4d1a1290 ("hw/arm: Add NPCM8XX SoC")
Cc: qemu-stable@nongnu.org
Cc: Hao Wu <wuhaotsh@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20250315142050.3642741-1-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm8xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index d14bf55cd71..a276fea6985 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -365,6 +365,7 @@ static struct arm_boot_info npcm8xx_binfo = {
     .secure_boot            = false,
     .board_id               = -1,
     .board_setup_addr       = NPCM8XX_BOARD_SETUP_ADDR,
+    .psci_conduit           = QEMU_PSCI_CONDUIT_SMC,
 };
 
 void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc)
-- 
2.43.0


