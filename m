Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF03C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 14:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttSNn-0003ky-6t; Sat, 15 Mar 2025 10:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1ttSNl-0003kb-GO; Sat, 15 Mar 2025 10:20:57 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1ttSNj-0003G4-KN; Sat, 15 Mar 2025 10:20:57 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224171d6826so1813405ad.3; 
 Sat, 15 Mar 2025 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742048453; x=1742653253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=xn/+9kBxvehWJDBB6ljJ3rR9p+GCHUYGWHwwq30XmP4=;
 b=YoLd9lqhXOFGwNl21fE+Z+gL16QsnB9I/DtZUoGWcuy3sdgfBFu9SETd7yoi0yNkKl
 r/hp4eada0oBtDrNh3OjUe7TljcQTuHQ8vcfwfZmjA0lH0eJfoHbdsV/IhlsOmPMm1Yc
 mpj5IRF288T9ZmxDMLtgrrSjomITqRM5exIZozDtmdPdJbq2MHxlH5ocF4vB0rs0Gp8Q
 +YrZp1a+6ivPLBw4Sg65JtVaXu47JXLjhAqybCuLBjk59ldP6AgGePX0AC1z2JJdcBG9
 m+E41xNYxawo8J0Myug+CFrdlQuAG7AtvhoggFpDRDh83hjhavaI/NV70jPQWCx/E+It
 Xj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048453; x=1742653253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xn/+9kBxvehWJDBB6ljJ3rR9p+GCHUYGWHwwq30XmP4=;
 b=PgxS5C2izCCwsy9WCzcblzgpWCO6H6l7M7o8IF+8cigzD2qEV4/g9aAQF+hO0+gw9y
 gjQfbiwEu8I7pcgccZGhlJKzFOWnDmHVaKBXiaQKK+H0VF5O0SrV/VrgfNm4D5l+dsKM
 Ax+Ia8SEEY5NyLoJn9iG9DNn68pc8IG0Zt9wzNf7JIs4BABT8/hJFlEMcrmQKOYI5KiZ
 1iTxBSrGme2wzN17rQhZz/qDV+DMQ1oBPFoNxKhzooJo0ReMF4EUPLJX3AFBnBoKDjmJ
 ggc9CraM4esICk7eQgYM9BAJjEFExBfkpY+8Lsk1F9c4fHchmMbwxpsG+Tciw9UlwfXh
 2Mgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIEpBPPqQB2uSekJ69vQ/dfVcsvN+pS3mEts2Fds1giIH5bHJKpmVdy1Ec3PeWH+gGBqZaOiF2oECitw==@nongnu.org,
 AJvYcCVAxc92+SXJb1Z7UR1YqRvHXvQVG5nTqVSmRYzJ4yRE2pnTzurlTQadaqYookOHwCR9Uw7AecoMwA==@nongnu.org
X-Gm-Message-State: AOJu0YzvjFsDFDh+Fs/876858ZM1CekdVFmu/3pH1AfqenHNn8BqZzn9
 pBxhyPl7Nqmx4ydF/w52oAJ7DxsoTajMyrxeoN91jNPBlzyHKc0JVF8DfA==
X-Gm-Gg: ASbGncu4tKytoqGp9hL3DzIO0ducgAcjjOAdX+n7dmpDIwTnsAXeQn80mfXMetFjaq9
 oskZEUTV3dZW4lDwdi0TqQh8QNb8D61iOJUIvyz5R6+MRMK+cTWcRaysLs3McsuMzb/30Sr6oc1
 xCePeZNkeAFWGGZkEnKtKt9vAxxmHZAaQT/knzEL98X8ivPDT0p51fl3TCB6SGGBysSY1gI59mm
 YR/IxlNLeTObfvcXt/OEATM88A6klDjxbMEPo5fj0OluUXH7Wk2gilj0KxjTPOdfMKXN6oUIQ8U
 SJF3eZ3dUvHsXRu7bCpBqqayfa55o5YBul2TQA/mtLpNc8HvZNC3wASFAQ==
X-Google-Smtp-Source: AGHT+IES5quEf60/lh+3i3O3zNfcu04vPVfh7DIK6E9m/au80ZQQAC3PO7ICpxCJMJAikzeLd727+Q==
X-Received: by 2002:a05:6a00:1301:b0:736:5c8e:baaa with SMTP id
 d2e1a72fcca58-7372236c8a2mr6960235b3a.2.1742048453139; 
 Sat, 15 Mar 2025 07:20:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116b114asm4493164b3a.164.2025.03.15.07.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:20:52 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Tyrone Ting <kfting@nuvoton.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 Hao Wu <wuhaotsh@google.com>
Subject: [PATCH] hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info
Date: Sat, 15 Mar 2025 07:20:50 -0700
Message-ID: <20250315142050.3642741-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Without psci_conduit, the Linux kernel crashes almost immediately.

    psci: probing for conduit method from DT.
    Internal error: Oops - Undefined instruction: 0000000002000000 [#1] PREEMPT SMP

Fixes: ae0c4d1a1290 ("hw/arm: Add NPCM8XX SoC")
Cc: Hao Wu <wuhaotsh@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/npcm8xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index f182accc47..e5a1929ed7 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -346,6 +346,7 @@ static struct arm_boot_info npcm8xx_binfo = {
     .secure_boot            = false,
     .board_id               = -1,
     .board_setup_addr       = NPCM8XX_BOARD_SETUP_ADDR,
+    .psci_conduit           = QEMU_PSCI_CONDUIT_SMC,
 };
 
 void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc)
-- 
2.45.2


